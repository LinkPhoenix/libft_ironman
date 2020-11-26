# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: emlecerf <emlecerf@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/26 07:09:57 by emlecerf          #+#    #+#              #
#    Updated: 2020/11/26 07:09:59 by emlecerf         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

setup_color() {
    # Only use colors if connected to a terminal
    # Thank your Oh My ZSH
    if [ -t 1 ]; then
        # https://gist.github.com/vratiu/9780109
        # https://misc.flogisoft.com/bash/tip_colors_and_formatting
        #RESET
        RESET=$(printf '\033[m')

        # Regular Colors
        BLACK=$(printf '\033[30m')
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        MAGENTA=$(printf '\033[35m')
        CYAN=$(printf '\033[36m')
        WHITE=$(printf '\033[37m')

        #BACKGROUND
        BG_BLACK=$(printf '\033[40m')
        BG_RED=$(printf '\033[41m')
        BG_GREEN=$(printf '\033[42m')
        BG_YELLOW=$(printf '\033[43m')
        BG_BLUE=$(printf '\033[44m')
        BG_MAGENTA=$(printf '\033[45m')
        BG_CYAN=$(printf '\033[46m')
        BG_WHITE=$(printf '\033[47m')

        # Formatting
        BOLD=$(printf '\033[1m')
        DIM=$(printf '\033[2m')
        ITALIC=$(printf '\033[3m')
        UNDERLINE=$(printf '\033[4m')
        BLINK=$(printf '\033[5m')
        REVERSE=$(printf '\033[7m')

    else
        RESET=""

        # Regular Colors
        BLACK=""
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        MAGENTA=""
        CYAN=""
        WHITE=""

        #BACKGROUND
        BG_BLACK=""
        BG_RED=""
        BG_GREEN=""
        BG_YELLOW=""
        BG_BLUE=""
        BG_MAGENTA=""
        BG_CYAN=""
        BG_WHITE=""

        # Formatting
        BOLD=""
        DIM=""
        ITALIC=""
        UNDERLINE=""
        BLINK=""
        REVERSE=""
    fi
}

message_exit() {
    echo "${YELLOW}#######################################################${RESET}"
    echo ""
    echo "${RED}${BOLD}Thank you for using this script to the end${RESET}"
    echo "${RED}${BOLD}If you love my work you can buy me coffee${RESET}"
    echo "${YELLOW}${BOLD}URL : https://www.buymeacoffee.com/LinkPhoenix${RESET}"
    echo ""
    echo "${YELLOW}#######################################################${RESET}"
}

header() {
    echo ""
    echo "${YELLOW}#######################################################${RESET}"
    echo ""
    echo "${GREEN}$1${RESET}"
    echo ""
    echo "${YELLOW}#######################################################${RESET}"
    echo ""
    echo ""
}

launching_command() {
    echo "${YELLOW}Command : ${RESET}${BG_BLACK}${ITALIC}$ $1 ${RESET}"
}

warning_text() {
    echo ""
    echo "${RED}#######################################################${RESET}"
    echo "${RED}${BOLD}$1${RESET}"
    echo "${RED}#######################################################${RESET}"
    echo ""
}

detect_text() {
    echo "${GREEN}${BOLD}$1${RESET}"
}

information() {
    echo "${RED}${BOLD}$1${RESET}"
    press_any_key_to_continue
}

press_any_key_to_continue() {
    read -n 1 -s -r -p "${GREEN}${BOLD}Press any key to continue${RESET}"
    printf "\n"
}

ask() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
    [yY][eE][sS] | [yY])
        $1
        ;;
    *)
        continue
        ;;
    esac
}

ask_libft_path() {
	PATH_LIBFT=
while true ; do
	# for read with autocomplete
	# https://stackoverflow.com/questions/4819819/get-autocompletion-when-invoking-a-read-inside-a-bash-script
	# for ask path
	# https://superuser.com/questions/1201079/how-to-make-a-bash-script-ask-the-user-for-a-directory-and-if-its-not-found-as
		read -e -p "Where is you Libft " PATH_LIBFT
	#Use ~ in if
	#https://askubuntu.com/questions/1093906/why-isnt-tilde-expansion-performed-on-the-input-to-read
		if [ -d ${PATH_LIBFT/#~//$HOME/} ]; then
		    	break
		fi
		if [ -d "$PATH_LIBFT" ] ; then
			break
		fi
	echo "$PATH_LIBFT is not a directory..."
done
export PATH_LIBFT
}

main() {

	setup_color

	header="
 _    _________________ _____   _____               ___  ___            
| |  |_   _| ___ |  ___|_   _| |_   _|              |  \/  |            
| |    | | | |_/ | |_    | |     | | _ __ ___  _ __ | .  . | __ _ _ __  
| |    | | | ___ |  _|   | |     | || '__/ _ \| '_ \| |\/| |/ _  |  _ \ 
| |____| |_| |_/ | |     | |    _| || | | (_) | | | | |  | | (_| | | | |
\_____\___/\____/\_|     \_/    \___|_|  \___/|_| |_\_|  |_/\__,_|_| |_|
                                                                        
                                                                        
"

    i=0
    while [ $i -lt ${#header} ]; do
        echo -ne "${GREEN}${BOLD}${header:$i:1}${RESET}" | tr -d '%'
        ((i++))
    done

	header "Ask where is your libft folder"

	ask_libft_path

	    info_script="
	Installation Tester 1

	Author              jtoty
	Github              https://github.com/jtoty/
	URL Repository      https://github.com/jtoty/Libftest

"

    i=0
    while [ $i -lt ${#info_script} ]; do
        sleep 0.001
        echo -ne "${YELLOW}${BOLD}${info_script:$i:1}${RESET}" | tr -d "%"
        ((i++))
    done

	FILE=~/.testers42/Libftest
	DEFAULT_PATH=~/libft
	if [[ -s "$FILE" ]]; then
		detect_text "$FILE exists."
		if [[ -s "$FILE/my_config.sh" ]]; then
			detect_text "$FILE/my_config.sh already exist"
			information "Your tester is already initialize"
			# https://stackoverflow.com/questions/11145270/how-to-replace-an-entire-line-in-a-text-file-by-line-number
			launching_command "vim -c ':%s/PATH_LIBFT=~/libft/PATH_LIBFT=$PATH_LIBFT/g'"
			information "I use VIM for add the good Path, use :wq if all is good"
			if [ -d ${PATH_LIBFT/#~//$HOME/} ]; then
				vim -c ":%s#PATH_LIBFT=\~/libft#PATH_LIBFT=${PATH_LIBFT/#~/$HOME}#g" $FILE/my_config.sh
			else
				vim -c ":%s#PATH_LIBFT=\~/libft#PATH_LIBFT=$PATH_LIBFT}#g" $FILE/my_config.sh
			fi
		else
			launching_command "bash $FILE/grademe.sh"
			information "I will launch grademe.sh for initialize the tester"
			bash $FILE/grademe.sh
			launching_command "vim -c ':%s/PATH_LIBFT=~/libft/PATH_LIBFT=$PATH_LIBFT/g'"
			information "I use VIM for add the good Path, use :wq if all is good"
			if [ -d ${PATH_LIBFT/#~//$HOME/} ]; then
				vim -c ":%s#PATH_LIBFT=\~/libft#PATH_LIBFT=${PATH_LIBFT/#~/$HOME}#g" $FILE/my_config.sh
			else
				vim -c ":%s#PATH_LIBFT=\~/libft#PATH_LIBFT=$PATH_LIBFT}#g" $FILE/my_config.sh
			fi
		fi
	else 
		launching_command "git clone https://github.com/jtoty/Libftest ~/.testers42/Libftest/" "test"
		information "I will download the Gihub Repo"
		git clone https://github.com/jtoty/Libftest ~/.testers42/Libftest/
		launching_command "bash $FILE/grademe.sh"
		information "I will launch grademe.sh for initialize the tester"
		bash $FILE/grademe.sh
		launching_command "vim -c ':%s/PATH_LIBFT=~/libft/PATH_LIBFT=$PATH_LIBFT/g'"
		information "I use VIM for add the good Path, use :wq if all is good"
		if [ -d ${PATH_LIBFT/#~//$HOME/} ]; then
		    	vim -c ":%s#PATH_LIBFT=\~/libft#PATH_LIBFT=${PATH_LIBFT/#~/$HOME}#g" $FILE/my_config.sh
		else
			vim -c ":%s#PATH_LIBFT=\~/libft#PATH_LIBFT=$PATH_LIBFT}#g" $FILE/my_config.sh
		fi
	fi

	message_exit

}

main
