# Prompt character
set fish_prompt_prefix "λ "

# Prompt
function fish_prompt
	# Error notice

	set -l last_status $status
	set -l fish_prompt_dim 946638
	
	printf "\n\033[K"
	if test $last_status -ne 0
		set_color $fish_color_error
		printf "[E$last_status] "
	end

	# host:cwd

	set_color normal
	if [ $COMPUTERNAME ]
		echo -n $COMPUTERNAME
	else
		echo -n (hostname)
	end
	set_color $fish_prompt_dim
	echo -n ':'
	set_color $fish_color_cwd
	echo -n (prompt_pwd)

	# Git status

	set -l git_branch (git rev-parse --abbrev-ref HEAD ^ /dev/null)
	if [ $status -eq 0 ]
		set -l git_dirty_count (git status --porcelain  | wc -l | sed "s/ //g")
		if [ $git_dirty_count -gt 0 ]
			set_color $fish_color_error
			echo -n ' ['$git_branch']'
		else
			set_color green
			echo -n ' ['$git_branch']'
		end
	end

	# Input line

	printf "\n"

	if test "$fish_key_bindings" = "fish_vi_key_bindings"

	# VI mode

		switch $fish_bind_mode
		case default
			set_color black --background green
		case insert
			set_color $fish_prompt_dim
		case visual
			set_color black --background blue
		case replace-one
			set_color black --background red
		end
	else

		# Non-VI mode

		set_color $fish_prompt_dim

	end

	printf $fish_prompt_prefix
	set_color normal
end
