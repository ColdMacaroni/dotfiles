function fconf
  if test $EDITOR = nvim
    set arg -c 'lua if vim.fn.exists("NvimTreeToggle") then require("nvim-tree.api").tree.toggle {focus=false} end'
  end

  $EDITOR $arg -c 'cd ~/.config/fish' ~/.config/fish/config.fish
  chezmoi re-add
end
