#!/bin/bash
#question 1
# the shell variable $# counts the number of arguments given
am1="236216"
am2="236240"

if [ $#  -eq 0 ] ; # if no arguments are given then output am1,am2 variables

   then
   echo "$am1-$am2"

     elif [ $# -eq 2  ]; then #if 3 arguments given then remove all comments from the log file 

         if [ $1="-f" ]; #if first argument equals -f then with grep -o we print only any character except # repeated zero or more times.The first ^ refers to the beginning of each line
         then 
         
           grep -o '^[^#]*' $2
       fi


    fi

#question 2

if [ $# -eq 4 ]; #if 5 arguments are given

   then
        awk -v one_id="${4}" 'BEGIN { FS="|"; OFS=" ";}{ if ($1 == one_id) {print $3,$2,$5} }' "$2" #if the argument of id is equal to the id of the log file then we print the 3rd,2nd and 5fth field of the log file

fi
#question 3
if [ $# -eq 3 ] ; #if 4 arguments are given
 then

  if [ $1 ==  "--firstnames" ] ;
    then
   awk -F"|" '!/firstName/{print $3 }' $3 | sort -u #we print the 3rd field except the comment firstName and with pipe we input it to the sort command so as to sort it and with -u we remove duplicate values

  elif [ $1 == "--lastnames"  ]; then

   awk -F"|" '!/lastName/{print $2}' $3 | sort -u #we print the 2nd field except the comment lastName and with pipe we input it to the sort command so as to sort it and with -u we remove duplicate values



  fi

fi


#question 4

if [ $# -eq 6 ]; #if 7 arguments are given
 then

     if [ $1 = --born-since -a $3 = --born-until ];

      then
        awk -v dateA="${2}" -v dateB="${4}"  'BEGIN { FS="|"; OFS=" ";}{ if (dateA <= $5 && dateB >= $5) {print $0} }' "$6" #with awk we print the lines of the log file that match to  be borned  between dateA and dateB

      fi
       elif [ $# -eq 4 ]; #if 5 arguments are given
        then
            if [ $1 = --born-since -a $3 = -f ];
             then
             awk -v dateA="${2}" 'BEGIN { FS="|"; OFS=" ";}{ if (dateA <= $5) {print $0} }' "$4" #here we print the lines that match be borned from dateA and after
            fi

            if [ $1 = --born-until -a $3 = -f ];
             then
             awk -v dateB="${2}" 'BEGIN { FS="|"; OFS=" ";}{ if (dateB >= $5) {print $0} }' "$4" #there we print the lines that match be borned from dateB and before

            fi


fi

#question 5


if [ $# -eq 3 -a "$1" = --socialmedia ]; # if 4 arguments given
then
awk -F "|" ' { socialmedia[$9]++ } END { for ( i in socialmedia ) if ( i !="socialmedia" ){ print i,socialmedia[i]}} ' $3 | sort #with socialmedia[$9] we use a counter which counts the number of socialmedia in the log file  and with a for loop at the END of awk we print the name of socialmedia followed by times its appeared in the file and then we input it with pipe to sort.  



    elif [ $# -eq 6 -a "$3" = --edit ];#if 7 arguments are given and 3rd arguments is --edit then execute the following block code
    then

    awk -v one_id="$4" -v one_column="$5" -v one_value="$6" -F"|" ' { if (one_id==$1 && one_column!=$1) { gsub(one_column,one_value); print $1"|"$2"|"$3"|"$4"|"$5"|"$6"|"$7"|"$8"|"$9 } } ' $2

fi
#while [ $1 -n ];

#do

#case $1 in

#       -f) file = $2
#       ;;
#       --id) id = $2
#       ;;
#       --born-since) born_since = $2
#       ;;
#       --born-until) born_until = $2
#       ;;
#       --edit) id = $2; column = $3; value = $4
#       ;; 
#       esac


#       shift#shift all parameters down by one

#done

#with the help of the above code we shift parameters down by one and with help of case we can run the script with whatever order of arguments due to lack of time we couldnt make it ,but we provide the code above with comments! 
