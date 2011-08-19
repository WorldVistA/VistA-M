PSGOER1 ;BIR/CML3-RENEWAL UTILITIES ;04 APR 94 / 11:04 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENVPPC ; view previous provider comments
 N %,%Y,PSJ1,PSJ2,X,Y S PSJ1=$S(PSGORD["V":"IV",1:5),PSJ2=$S(PSGORD["V":5,1:12)
 I '$O(^PS(55,PSGP,PSJ1,+PSGORD,PSJ2,0)) W !,"(There are no previous provider comments to show.)" Q
 F  W !!,"Would you like to view the previous provider comments for this order" S %=1 D YN^DICN Q:%  D  ;
 .W !!?2,"Answer 'YES' to view the provider comments for this order prior to its",!,"renewal.  Answer 'NO' (or '^') if you do not need to see the provider comments."
 I %=1 W !!,"Provider Comments:",! S %=0 F  S %=$O(^PS(55,PSGP,PSJ1,+PSGORD,PSJ2,%)) Q:'%  N Y,Y2 S Y=" "_$G(^(%,0)) F KKA=2:1 S Y2=$P(Y," ",KKA) Q:Y2=""  W:$L(Y2)+$X>79 !?2 W " ",Y2
 K KKA
 Q
