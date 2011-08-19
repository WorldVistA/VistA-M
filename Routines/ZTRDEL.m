%ZTRDEL ;SF/RWF - ROUTINE DELETE ;9/17/93  07:38 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
 W !,$C(7),!,"ROUTINE DELETE",! K ^UTILITY($J)
 X ^%ZOSF("RSEL") S X="$" F I=0:1 S X=$O(^UTILITY($J,X)) Q:X=""
 I 'I W !,"No routines selected" G EXIT
A W !,I," routines to DELETE, OK: NO// " R X:60 I X["?" D LIST G A
 W ! G EXIT:"Yy"'[$E(X_" ")
 S X="$",DEL=^%ZOSF("DEL") F I=1:1 S X=$O(^UTILITY($J,X)) Q:X=""  X DEL W $E(X_"          ",1,10) H:'(I#25) 1
EXIT W !,"Done." K I,X,DEL,^UTILITY($J)
 Q
LIST ;List the routines
 W !,"List of routines to DELETE",!
 S X="$" F J=0:0 S X=$O(^UTILITY($J,X)) Q:X=""  W $E(X_"          ",1,10)
 K J W !,"END",! Q
