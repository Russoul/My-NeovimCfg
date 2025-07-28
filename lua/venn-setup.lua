-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "I", "<C-v>i:VBox<CR>", {noremap = false})
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = false})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = false})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = false})
        vim.api.nvim_buf_set_keymap(0, "n", "<C-i>", "r<SPACE>i", {noremap = false})
        vim.api.nvim_buf_set_keymap(0, "n", "<C-j>", "r<SPACE>j", {noremap = false})
        vim.api.nvim_buf_set_keymap(0, "n", "<C-k>", "r<SPACE>k", {noremap = false})
        vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "r<SPACE>l", {noremap = false})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, "n", "I")
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})

