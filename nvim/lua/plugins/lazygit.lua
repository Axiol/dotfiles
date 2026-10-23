vim.pack.add({
  "https://github.com/kdheepak/lazygit.nvim",
})

vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>", { desc = "Open lazygit" })

-- Called over RPC by lazygit when pressing "e" (see os.edit in ~/.config/lazygit/config.yml).
-- Deferred so lazygit's child process exits before we kill its terminal buffer.
function _G.LazygitEdit(file, line)
  local term = vim.api.nvim_get_current_buf()
  vim.defer_fn(function()
    if vim.bo[term].buftype == "terminal" then
      vim.api.nvim_buf_delete(term, { force = true })
    end
    vim.cmd.edit(vim.fn.fnameescape(file))
    if line and line > 0 then
      vim.api.nvim_win_set_cursor(0, { line, 0 })
    end
  end, 50)
  return ""
end
