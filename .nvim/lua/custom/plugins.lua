local plugins = {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.configs.lspconfig")
            require("custom.configs.lspconfig")
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "js-debug-adapter",
                "typescript-language-server",
                "tailwindcss-language-server",
            }
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            opts = require "plugins.configs.treesitter"
            opts.ensure_installed = {
                "lua",
                "javascript",
                "typescript",
                "tsx",
            }
            return opts
        end
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-jest",
        },

        requires = {
            "nvim-neotest/neotest-jest",
        },

        config = function()
            require("neotest").setup({
                adapters = {
                    require('neotest-jest')({
                        jestCommand = require('neotest-jest.jest-util').getJestCommand(vim.fn.expand '%:p:h') ..
                        ' --coverage --testLocationInResults --verbose --',
                        jest_test_discovery = true,
                        discovery = {
                            enabled = false,
                        }
                    }),
                }
            })
        end
    },
    {
        "andythigpen/nvim-coverage",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("coverage").setup(
                {
                    auto_reload = true,
                    highlights = {
                        -- customize highlight groups created by the plugin
                        covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
                        uncovered = { fg = "#F07178" },
                        partial = { fg = "#ffc31f" }
                    },
                    signs = {
                        -- use your own highlight groups or text markers
                        covered = { hl = "CoverageCovered", text = "▎" },
                        uncovered = { hl = "CoverageUncovered", text = "▎" },
                        partial = { hl = "CoveragePartial", text = "▎" },
                    },
                    summary = {
                        -- customize the summary pop-up
                        min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
                    },
                    lang = {
                        -- customize language specific settings
                    },
                }
            )
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            require("dapui").setup()
            dap.listeners.after.event_initalized["dapui_config"] = function()
                print("dapui open")
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require "custom.configs.dap"
            require("core.utils").load_mappings("dap")
        end
    },
    {
        "mxsdev/nvim-dap-vscode-js",
        requires = { "mfussenegger/nvim-dap" }
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
}
return plugins
