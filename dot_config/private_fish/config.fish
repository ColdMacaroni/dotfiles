if status is-interactive
  # Vars
  set -Ux EDITOR nvim
  set -Ux VISUAL nvim
  set -Ux XDG_CONFIG_HOME $HOME/.config
  set -Ux BUNDLE_PATH $HOME/.gems

  fish_add_path $HOME/bin $HOME/.local/bin $HOME/.local/share/gem/ruby/3.0.0/bin
end
