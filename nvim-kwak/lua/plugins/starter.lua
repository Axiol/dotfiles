vim.pack.add({
  "https://github.com/nvim-mini/mini.starter",
})

local starter = require("mini.starter")

starter.setup({
  header = table.concat({
    " ███                                           █████         ",
    "░███                                          ░░███          ",
    "░███ █████ █████  █████   ██████   ██████   ███████   ██████ ",
    "░███░░███ ░░███  ███░░   ███░░███ ███░░███ ███░░███  ███░░███",
    "░███ ░███  ░███ ░░█████ ░███ ░░░ ░███ ░███░███ ░███ ░███████ ",
    "░░░  ░░███ ███   ░░░░███░███  ███░███ ░███░███ ░███ ░███░░░  ",
    " ███  ░░█████    ██████ ░░██████ ░░██████ ░░████████░░██████ ",
    "░░░   ░░░░░    ░░░░░░   ░░░░░░   ░░░░░░   ░░░░░░░░  ░░░░░░   ",
  }, "\n"),

  items = {
    { name = "Find files",   action = [[lua require("fzf-lua").files()]],     section = "" },
    { name = "Live grep",    action = [[lua require("fzf-lua").live_grep()]], section = "" },
    { name = "Recent files", action = [[lua require("fzf-lua").oldfiles()]],  section = "" },
    { name = "New file",     action = "enew | startinsert",                   section = "" },
    { name = "Quit",         action = "qall",                                 section = "" },
  },

  footer = "",

  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning("center", "center"),
  },
})
