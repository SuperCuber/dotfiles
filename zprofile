{{#if (and default_pwd cd_location)~}}
if [ `pwd` = {{default_pwd}} ]; then
    builtin cd {{cd_location}}
fi
{{/if~}}
{{#if load_rc~}}
{{#if zsh~}}
test -f ~/.zshrc && . ~/.zshrc
{{~else~}}
test -f ~/.bashrc && . ~/.bashrc
{{~/if}}

{{/if~}}
export PATH=$HOME/bin:$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH=$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
export TZ='UTC-3'
