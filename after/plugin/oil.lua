-- after/plugin/oil.lua
-- after/plugin/oil.lua
local ok, oil = pcall(require, "oil")
if not ok then return end

-- store the root directory you started Neovim in
local root_dir = vim.fn.getcwd()

-- <Leader>pv: open parent directory but don’t go above root_dir
vim.keymap.set("n", "<leader>pv", function()
    local current
    if vim.fn.expand("%:p") == "" then
        -- no file open, fallback to cwd
        current = vim.fn.getcwd()
    else
        -- parent of current file
        current = vim.fn.expand("%:p:h")
    end

    local parent = vim.fn.fnamemodify(current, ":h")

    -- don’t go above root_dir
    if vim.fn.stridx(parent, root_dir) == 0 then
        oil.open(parent)
    else
        -- already at or above root_dir, stay there
        oil.open(root_dir)
    end
end, { desc = "Open parent directory (capped at root)" })
