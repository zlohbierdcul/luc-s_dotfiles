# Enable Prompt Substitution
setopt prompt_subst


# enable color support of ls and also add handy aliases

alias ls='ls --color'
alias dir='dir --color'
alias vdir='vdir --color'
alias grep='grep --color'
alias fgrep='fgrep --color'
alias egrep='egrep --color'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Colors
newline=$'\n';
bold='%B';
unbold='%b';
reset="%f%b";
black="%F{0}";
blue="%F{75}";
cyan="%F{43}";
green="%F{35}";
purple="%F{135}";
red="%F{red}";
white="%F{15}";

# Get branch name and change status
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
  	s='';
	repoUrl="$(git config --get remote.origin.url)";
	if grep -q 'chromium/src.git' <<< "${repoUrl}"; then
		s+='*';
	else
		# Check for uncommitted changes in the index.
		if ! $(git diff --quiet --ignore-submodules --cached); then
			s+='+';
		fi;
		# Check for unstaged changes.
		if ! $(git diff-files --quiet --ignore-submodules --); then
			s+='!';
		fi;
		# Check for untracked files.
		if [ -n "$(git ls-files --others --exclude-standard)" ]; then
			s+='?';
		fi;
		# Check for stashed files.
		if $(git rev-parse --verify refs/stash &>/dev/null); then
			s+='$';
		fi;
	fi;
		if [ -z "$s" ];
		  then changes="";
		  else changes="${reset}${bold}[${red}$s${reset}${bold}]${unbold}";
		fi
    echo " ${purple}$branch $changes"
  fi
}

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${green}";
else
	userStyle="${green}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${cyan}";
else
	hostStyle="${cyan}";
fi;

# Set the terminal title and prompt.
PS1="
╭─⠇⠥⠉ "; # User icon and arrow start
PS1+="${userStyle} %n"; # username
PS1+="${white}  "; # host Icon
PS1+="${hostStyle} %m"; # host
PS1+="${white} "; # Dir icon
PS1+="${blue} %~"; # working directory full path
PS1+='${reset} $(git_branch_name)'; # Git repository details
PS1+="${white}
╰─ᐳ   ${reset}"; # arrow end

export PS1;
