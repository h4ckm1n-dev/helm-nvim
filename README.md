# 🚀 Neovim Kubernetes Plugin 🚀

This Neovim plugin provides seamless integration with Kubernetes and Helm, allowing you to deploy and manage Kubernetes resources directly from your editor.

## Build Status
[![Go](https://github.com/h4ckm1n-dev/helm-utils-nvim/actions/workflows/lualint.yml/badge.svg)](https://github.com/h4ckm1n-dev/helm-utils-nvim/actions/workflows/lualint.yml)

## Features
- **Helm Deployment:** Deploy Helm charts directly from your Neovim buffer.
- **Helm Dry Run:** Simulate Helm chart installations without actually deploying.
- **Kubectl Apply:** Apply Kubernetes manifests from your buffer.
- **Kubernetes Context Switching:** Quickly switch between Kubernetes contexts.
- **Open K9s:** Open the K9s Kubernetes CLI in a new terminal buffer.
- **Open K9s Split:** Open the K9s Kubernetes CLI in a new split terminal buffer.

## Installation
Install the plugin using your preferred package manager (below is an example using lazy.nvim):
```lua
return {
    {
        "h4ckm1n-dev/helm-utils-nvim",
        event = "BufReadPost",
        config = function()
            require("helm_utils").setup()
        end,
    },
}
```
Additionaly you can create a witch-key mapping to use the commands:
```lua
-- Helm keybindings
local helm_mappings = {
	h = {
		name = "Helm", -- This sets a label for all helm-related keybindings
		c = { "<cmd>HelmDeployFromBuffer<CR>", "Deploy Buffer to Context" },
		d = { "<cmd>HelmDryRun<CR>", "DryRun Buffer" },
        	a = { "<cmd>KubectlApplyFromBuffer<CR>", "kubectl apply from buffer" },
		k = { "<cmd>KubeSwitchContext<CR>", "Switch Kubernetes Context" },
	},
}

-- Require the which-key plugin
local wk = require("which-key")

-- Register the Helm keybindings with a specific prefix
wk.register(helm_mappings, { prefix = "<leader>" })
```

## Usage
- **Helm Deployment:** Use `:HelmDeployFromBuffer` to deploy the Helm chart from the current buffer. You'll be prompted for the release name and namespace.
- **Helm Dry Run:** Use `:HelmDryRun` to simulate the Helm chart installation from the current buffer. You'll be prompted for the release name and namespace, and a new tab will open showing the simulated output.
- **Kubectl Apply:** Use `:KubectlApplyFromBuffer` to apply Kubernetes manifests from the current buffer.
- **Kubernetes Context Switching:** Use `:KubeSwitchContext` to switch between Kubernetes contexts.
- **Open K9s:** Use `:OpenK9s` to open the K9s Kubernetes CLI in a new terminal buffer.
- **Open K9s Split:** Use `:OpenK9sSplit` to open the K9s Kubernetes CLI in a new split terminal buffer.

## Requirements
Neovim 0.9.0 or higher
Helm
kubectl

## Configuration
No additional configuration is required. Simply install the plugin and start using the commands.

## License
This plugin is licensed under the MIT License. See the LICENSE file for details.

# 🎉 Happy Kubernetes deployment with Neovim! 🎉
