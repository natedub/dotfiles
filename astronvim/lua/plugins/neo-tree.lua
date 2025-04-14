return {
  "nvim-neo-tree/neo-tree.nvim",
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree").setup {
          filesystem = {
            hijack_netrw_behavior = "open_current",
          },
        }
      end
    end
  end,
  opts = {
    -- filesystem = {
    --  hijack_netrw_behavior = "disabled",
    --},
  },
}
