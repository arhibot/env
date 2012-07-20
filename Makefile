DEVTOOLS_DIR=$(HOME)/devtools


all: install_depends create_configs createenv


install_depends:
	sudo add-apt-repository ppa:cassou/emacs # emacs-snapshot
	sudo apt-get update
	sudo apt-get install $(cat debpackages.list)


create_configs:
	find . -iname 'tpl_*' -exec ./bin/apply_template $(PWD)/config {} \;


createenv: git_prompt dotsconfs


devtools:
	mkdir $(DEVTOOLS_DIR); true


git_prompt: devtools
	rm -rf $(DEVTOOLS_DIR)/git-prompt && git clone git://github.com/lvv/git-prompt.git $(DEVTOOLS_DIR)/git-prompt
	echo "[[ $- == *i* ]] && . $(DEVTOOLS_DIR)/git-prompt/git-prompt.sh" >> bash.conf/.common_config


# Simple dots configs
dotsconfs: $(addsuffix -dots, git.conf tmux.conf bash.conf)
%-dots:
	/bin/bash -c "cp $*/.[^.]* $(HOME)/"
