setopt PROMPT_SUBST

if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi

function _git_symbols() {
  local ahead='↑'
	local behind='↓'
	local diverged='↕'
	local up_to_date='|'
	local no_remote=''
	local staged='+'
	local untracked='?'
	local modified='!'
	local moved='>'
	local deleted='x'
	local stashed='$'

  local output_symbols=''

	local git_status_v
	git_status_v="$(git status --porcelain=v2 --branch --show-stash 2>/dev/null)"

	# Parse branch information
	local ahead_count behind_count

	# AHEAD, BEHIND, DIVERGED
	if echo $git_status_v | grep -q "^# branch.ab " ; then
		# One line of the git status output looks like this:
		# # branch.ab +1 -2
		# In the line below:
		# - we grep for the line starting with # branch.ab
		# - we grep for the numbers and output them on separate lines
		# - we remove the + and - signs
		# - we put the two numbers into variables, while telling read to use a newline as the delimiter for reading
		read -d "\n" -r ahead_count behind_count <<< $(echo "$git_status_v" | grep "^# branch.ab" | grep -o -E '[+-][0-9]+' | sed 's/[-+]//')
		# Show the ahead and behind symbols when relevant
		[[ $ahead_count != 0 ]] && output_symbols+="$ahead"
		[[ $behind_count != 0 ]] && output_symbols+="$behind"
		# Replace the ahead symbol with the diverged symbol when both ahead and behind
		output_symbols="${output_symbols//$ahead$behind/$diverged}"

		# If the branch is up to date, show the up to date symbol
		[[ $ahead_count == 0 && $behind_count == 0 ]] && output_symbols+="$up_to_date"
	fi

	# STASHED
	echo $git_status_v | grep -q "^# stash " && output_symbols+="$stashed"

	# STAGED
	[[ $(git diff --name-only --cached) ]] && output_symbols+="$staged"

	# For the rest of the symbols, we use the v1 format of git status because it's easier to parse.
	local git_status

	symbols="$(git status --porcelain=v1 | cut -c1-2 | sed 's/ //g')"

	while IFS= read -r symbol; do
		case $symbol in
			??) output_symbols+="$untracked";;
			M) output_symbols+="$modified";;
			R) output_symbols+="$moved";;
			D) output_symbols+="$deleted";;
		esac
	done <<< "$symbols"

	# Remove duplicate symbols
	output_symbols="$(echo -n "$output_symbols" | tr -s "$untracked$modified$moved$deleted")"

	[[ -n $output_symbols ]] && echo -n " $output_symbols"
}

function _git_info() {
  local git_info=''
	local git_branch_name=''

	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		# Get the Git branch name
		git_branch_name="$(git symbolic-ref --short HEAD 2>/dev/null)"
		if [[ -n "$git_branch_name" ]]; then
			git_info+="$git_branch_name"
		fi
		# Get the Git status
		git_info+="$(_git_symbols)"
		echo "$git_info"
	fi
}

NEWLINE=$'\n'

PROMPT='${NEWLINE}%F{yellow}%f%K{yellow}%F{black} %f%k%K{yellow}%F{black}%n%f%k%K{yellow} %k%K{cyan}%F{black}  %f%k%K{cyan}%F{black}%1d%f%k%K{cyan} %k%K{red}%F{black}  %f%k%K{red}%F{black}$(_git_info)%f%k%F{red}%f${NEWLINE} 󱞩 '

alias gs="git status --short"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gp="git pull"
alias gu="git push"
alias gl="git log"
alias gb="git branch"
alias gi="git init"
alias gcl="git clone"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
