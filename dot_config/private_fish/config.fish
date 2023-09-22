if status is-interactive
  # Vars
  set -Ux EDITOR nvim
  set -Ux VISUAL nvim
  set -Ux XDG_CONFIG_HOME $HOME/.config
  set -Ux XDG_DATA_HOME $HOME/.local/share
  set -Ux BUNDLE_PATH $HOME/.gems
  set -g GOPATH $XDG_DATA_HOME/go

  set -U tide_character_icon 
  set -U tide_left_prompt_items pwd git jobs character

  fish_add_path $HOME/bin $HOME/.local/bin $HOME/.local/share/gem/ruby/3.0.0/bin
end
