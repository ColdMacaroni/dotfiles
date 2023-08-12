function nconf
  if test $EDITOR = nvim
    set arg -c 'lua if vim.fn.exists("NvimTreeToggle") then require("nvim-tree.api").tree.toggle {focus=false} end'
  end

  $EDITOR $arg -c 'cd ~/.config/nvim' ~/.config/nvim/init.lua
  chezmoi re-add
end
