local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({
  source = "saghen/blink.cmp",
  checkout = "v1.7.0",
  hooks = {
    post_checkout = function()
      vim.fn.system("curl -L https://github.com/Saghen/blink.cmp/releases/latest/download/blink.cmp-$(uname -s)-$(uname -m).tar.gz | tar -xz -C " .. vim.fn.stdpath("data") .. "/mini.deps/blink.cmp")
    end
  }
})

-- Configure blink APRÈS que LSP soit setup
vim.api.nvim_create_autocmd("LspAttach", {
  once = true, -- Une seule fois
  callback = function()
    vim.schedule(function()
      local ok, blink = pcall(require, "blink.cmp")
      if not ok then
        vim.notify("Blink.cmp not loaded", vim.log.levels.WARN)
        return
      end

      blink.setup({
        keymap = { preset = "super-tab" },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          menu = {
            border = "rounded",
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
              border = "rounded",
            },
          },
          ghost_text = {
            enabled = true,
          },
        },
      })
    end)
  end,
})
