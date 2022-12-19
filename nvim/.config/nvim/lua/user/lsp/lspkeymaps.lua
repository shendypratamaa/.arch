local M = {}

local function lspkeymaps()
    local opts = { noremap = true, silent = true }
    local keymap = vim.keymap.set

    keymap("n", "gh", ":Lspsaga lsp_finder<CR>", opts)
    keymap("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
    keymap("n", "K", ":Lspsaga hover_doc<CR>", opts)
    keymap("n", "gk", ":lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "gr", ":Lspsaga rename<CR>", opts)
    keymap("n", "\\df", ":Lspsaga peek_definition<CR>", opts)
    keymap("n", "[d", ":Lspsaga diagnostic_jump_next<CR>", opts)
    keymap("n", "]d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
    keymap("n", "gl", ":Lspsaga show_line_diagnostics<CR>", opts)
    keymap("v", "pa", ":Lspsaga code_action<CR>", opts)

    keymap("n", "gS", ":TSLspOrganize<CR>", opts)
    keymap("n", "gR", ":TSLspRenameFile<CR>", opts)
    keymap("n", "gn", ":TSLspImportAll<CR>", opts)

    keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
    keymap("n", "<leader>fo", ":Format<CR>", opts)

    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end

function M.setup()
    lspkeymaps()
end

return M
