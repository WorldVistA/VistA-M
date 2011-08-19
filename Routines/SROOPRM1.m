SROOPRM1 ;B'HAM ISC/KKA ; UPDATE NORMAL O.R. HOURS ; 28 SEPT 1992 11:48 am
 ;;3.0; Surgery ;;24 Jun 93
HELP ; help message for incorrect responses
 W @IOF,!,?8,"Enter the number or range of numbers you want to edit.",!,?8,"Examples of proper responses are listed below:",!!,?12,"1. Enter ""A"" to update all information.",!!,?12,"2. Enter a number (1-3) to update information"
 W !,?12,"   in that field.  (For example, enter ""2"" to",!,?12,"   update the Normal End Time.)",!!,?12,"3. Enter a range of numbers (1-3) separated",!,?12,"   by a "":"" to enter a range of information."
 W !,?12,"   (For example, enter ""1:2"" to update Normal",!,?12,"   Start Time and Normal End Time.)"
 W !!,?12,"4. Press RETURN to edit the next consecutive",!,?12,"   day of the week."
 W !!,?12,"5. Enter an ""^"" followed by a day of the week",!,?12,"   to edit that particular day.  (For example,",!,?12,"   enter ""^Friday"" to edit Friday's schedule)"
 W !!,?8,"Press RETURN to continue or ""^"" to quit: " R SRCON:DTIME I '$T!(SRCON["^") S SRSOUT=1
 Q
T ; select TUESDAY or THURSDAY
 W !!,"Update information for Tuesday or Thursday ?  TUESDAY//   " R X:DTIME Q:'$T!("^")
 S:X="" X="TU" S X=$E(X,1,2) I X'="TU",X'="TH" W !!,"Enter 'TU' to update information for Tuesday, or 'TH' to update information",!,"for Thursday." G T
 Q
S ; select SATURDAY or SUNDAY
 W !!,"Update information for Saturday or Sunday ?  SATURDAY//   " R X:DTIME Q:'$T!("^")
 S:X="" X="SA" S X=$E(X,1,2) I X'="SA",X'="SU" W !!,"Enter 'SA' to update information for Saturday, or 'SU' to update information",!,"for Sunday." G S
 Q
