return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
      {"<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files"},
      {"<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep"},
  },
}
