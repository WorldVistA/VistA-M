ABSVTIME ;VAMC ALTOONA/CTB - VERIFY TIME ;12/17/93  8:31 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;;JULY 6, 1994
 Q:$D(X)[0
 N X1,X2
 I X?3N S X="0"_X S ABSVXA="Do you mean '"_X_"'",ABSVXB="",%=1 D ^ABSVYN I %'=1 K X Q
 I X'?4N K X Q
 S X1=$E(X,1,2),X2=$E(X,3,4)
 I +X1<10!(+X1>13) S ABSVXA="Are you sure you want the meal cutoff time to be this "_$S(+X1<10:"early",1:"late"),ABSVXB="",%=2 D ^ABSVYN I %'=1 K X Q
 I +X2>59 W !,"Minutes may not exceed 59" K X Q
 Q
NAME ;ELIMINATE SPACES FROM NAME FIELD FROM FILE 503330
 I X'["," K X Q
 N I,X1,X2 S X1=$P(X,","),X2=$P(X,",",2) F I=1:1 Q:$E(X2)'=" "  S X2=$E(X2,2,$L(X2))
 S X=X1_","_X2 Q
