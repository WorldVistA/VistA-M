SRSWL5 ;B'HAM ISC/MAM - PRINT PROCEDURE FOR WAITING LIST ; 20 SEPT 1990  9:00 AM
 ;;3.0; Surgery ;;24 Jun 93
 S SROLD=0 D OLD^SRSWLST Q:'SROLD  S SROPER=$P(^SRF(SROLD,"OP"),"^")
 K SROPS,MM,MMM S:$L(SROPER)<70 SROPS(1)=SROPER I $L(SROPER)>69 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,"* Procedure performed since this entry was made on the Waiting List",!,"  Operation Date: "_SROLD("DATE"),!,?2,SROPS(1) I $D(SROPS(2)) W !,?2,SROPS(2)
 Q
LOOP ; break operation if greater than 69 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<70  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
