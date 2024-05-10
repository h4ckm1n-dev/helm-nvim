local M = {}

local function run_shell_command(cmd)
	-- Attempt to open a pipe to run the command
	local handle, err = io.popen(cmd, "r")
	if not handle then
		-- If the handle is nil, print the error and return a default message
		print("Failed to run command: " .. cmd .. "\nError: " .. tostring(err))
		return nil, "Error running command: " .. tostring(err)
	end

	-- Read the output of the command
	local output = handle:read("*a")
	-- Always ensure the handle is closed to avoid resource leaks
	handle:close()

	-- Check if the output is nil or empty
	if not output or output == "" then
		return nil, "Command returned no output"
	end

	-- Return the output normally
	return output
end

function M.helm_deploy_from_buffer()
	-- Fetch the current file path from the buffer
	local file_path = vim.api.nvim_buf_get_name(0)
	if file_path == "" then
		print("No file selected")
		return
	end

	-- Prompt user for input regarding other deployment details
	local chart_name = vim.fn.input("Enter Chart Name (e.g., argo-cd): ")
	local chart_directory = vim.fn.input("Enter Chart Directory (e.g., argo-cd/): ")
	local namespace = vim.fn.input("Enter Namespace (e.g., argo-cd): ")

	-- Construct the Helm command using the buffer's file as the values file
	local helm_cmd = string.format(
		"helm upgrade --install %s %s --values %s -n %s --create-namespace",
		chart_name,
		chart_directory,
		file_path,
		namespace
	)

	-- Execute the Helm command
	local result = run_shell_command(helm_cmd)
	if result and result ~= "" then
		print("Deployment successful: \n" .. result)
	else
		print("Deployment failed or no output returned.")
	end
end

-- Function to switch Kubernetes contexts
function M.switch_kubernetes_context()
	local contexts, error_message = run_shell_command("kubectl config get-contexts -o name")
	if not contexts then
		print(error_message or "Failed to fetch Kubernetes contexts.")
		return
	end

	local context_list = vim.split(contexts, "\n", true)
	if #context_list == 0 then
		print("No Kubernetes contexts available.")
		return
	end

	vim.ui.select(context_list, { prompt = "Select Kubernetes context:" }, function(choice)
		if choice then
			local result, error_message = run_shell_command("kubectl config use-context " .. choice)
			if result then
				print("Switched to context: " .. choice)
			else
				print(error_message or "Failed to switch context.")
			end
		else
			print("No context selected.")
		end
	end)
end

-- Register Neovim commands
function M.setup()
	vim.api.nvim_create_user_command("HelmDeployFromBuffer", M.helm_deploy_from_buffer, {})
	vim.api.nvim_create_user_command("KubeSwitchContext", M.switch_kubernetes_context, {})
end

return M
