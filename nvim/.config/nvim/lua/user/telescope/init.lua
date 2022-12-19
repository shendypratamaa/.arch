local telescope_ok, telescope = pcall(require, "telescope")
local actions                 = require("telescope.actions")
local actions_state           = require("telescope.actions.state")
local actions_layout          = require("telescope.actions.layout")
local sorters                 = require("telescope.sorters")
local previewers              = require("telescope.previewers")

if not telescope_ok then
    return 
end

local find = { "fd", "--type", "f", "--strip-cwd-prefix" }

local ripgrep = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--trim",
}

local mappings = {
    i = {
        ["\\q"]     = actions.close,
        ["<CR>"]    = actions.select_default,

        ["<C-n>"]   = actions.cycle_history_next,
        ["<C-p>"]   = actions.cycle_history_prev,

        ["<C-v>"]   = actions.select_vertical,
        ["<C-h>"]   = actions.select_horizontal,

        ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

        ["<C-j>"]   = actions.move_selection_next,
        ["<C-k>"]   = actions.move_selection_previous,

        ["<C-q>"]   = actions_layout.toggle_preview,

        ["<C-t>"]   = actions.smart_send_to_qflist + actions.open_qflist,

        ["<Down>"]  = false,
        ["<Up>"]    = false,
    },
    n = {
        ["\\q"]     = actions.close,
        ["<CR>"]    = actions.select_default,

        ["<C-n>"]   = actions.cycle_history_next,
        ["<C-p>"]   = actions.cycle_history_prev,

        ["ss"]      = actions.select_horizontal,
        ["sv"]      = actions.select_vertical,

        ["H"]       = actions.move_to_top,
        ["M"]       = actions.move_to_middle,
        ["L"]       = actions.move_to_bottom,

        ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

        ["j"]       = actions.move_selection_next,
        ["k"]       = actions.move_selection_previous,

        ["<C-q>"]   = actions_layout.toggle_preview,

        ["<C-t>"]   = actions.smart_send_to_qflist + actions.open_qflist,

        ["<Down>"]  = false,
        ["<Up>"]    = false,
    },
}

local pickers = {
    find_files = {
        find_command = find,
    },
    buffers = {
        show_all_buffers = true,
        sort_lastused    = true,
        mappings = {
            i = {
                ["\\q"]     = "delete_buffer",

                ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
            n = {
                ["\\q"]     = "delete_buffer",

                ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
        },
    },
    quickfix = {
        trim_text = true,
    },
    quickfixhistory = {
        find_command = find,
        mappings = {
            i = {
                ["<C-o>"] = function(prompt_buf)
                    local entry = actions_state.get_selected_entry()
                    actions.close(prompt_buf)
                    vim.cmd(string.format("%schistory | copen", entry.nr))
                end,
            },
            n = {
                ["<C-o>"] = function(prompt_buf)
                    local entry = actions_state.get_selected_entry()
                    actions.close(prompt_buf)
                    vim.cmd(string.format("%schistory | copen", entry.nr))
                end,
            },
        },
    },
}

local layout_config = {
    horizontal = {
        prompt_position = "bottom",
        preview_width   = 0.6,
        results_width   = 0.8,
    },
    vertical = {
        mirror = false,
    },
    width          = 0.82,
    height         = 0.75,
    preview_cutoff = 120,
}

local cfg = {
    defaults = {
        file_ignore_patterns   = { "node%_modules/.*" },
        prompt_prefix          = " ",
        selection_caret        = "▷ ",
        sorting_strategy       = "descending",
        path_display           = { "truncate" },
        vimgrep_arguments      = ripgrep,
        file_previewer         = previewers.vim_buffer_cat.new,
        grep_previewer         = previewers.vim_buffer_vimgrep.new,
        qflist_previewer       = previewers.vim_buffer_qflist.new,
        file_sorter            = sorters.get_fuzzy_file,
        generic_sorter         = sorters.get_generic_fuzzy_sorter,
        layout_config          = layout_config,
        mappings               = mappings,
    },
    pickers = pickers,
}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "]f", ":lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "]g", ":lua require('telescope.builtin').builtin()<CR>", opts)
keymap("n", "]b", ":lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "]r", ":lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "]h", ":lua require('telescope.builtin').help_tags()<CR>", opts)
keymap( "n", "]fh", ":lua require('telescope.builtin').quickfixhistory()<CR>", opts)
keymap("n", "]fc", ":lua require('telescope.builtin').commands()<CR>", opts)

telescope.setup(cfg)
