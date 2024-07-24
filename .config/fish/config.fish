set fish_greeting ""

# nvim setup
if command -qv nvim 
    alias vim nvim
    alias vi nvim 
    set -gx EDITOR nvim
end

# git setup
if command -qv git
    alias g="git"
    alias ga="git add"
    alias gc="git commit"
end

# kubernetes setup
if command -qv kubectl
    alias k="kubectl"
    alias kns="kubens"
    alias kctx="kubectx"
end


# initialize starship prompt
starship init fish | source
