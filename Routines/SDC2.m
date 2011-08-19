SDC2 ;ALB/GRR - CHECK PARTIAL CANCELLATIONS ; 19 FEB 85
 ;;5.3;Scheduling;**182,452**;Aug 13, 1993
 K SDZ I $D(^SC(SC,"SDCAN")),$O(^SC(SC,"SDCAN",SD))\1=SD G OVR
 D WAIT^DICD F SDZL=SD:0 S SDZL=$O(^SC(SC,"S",SDZL)) Q:SDZL=""  I $D(^SC(SC,"S",SDZL,"MES")) S SDCTO=$E(^("MES"),17,20) S:'$D(^SC(SC,"SDCAN",0)) ^SC(SC,"SDCAN",0)="^44.05D^"_SDZL_"^0" D MORE
 G:'$D(^SC(SC,"SDCAN")) W^SDC G:$O(^SC(SC,"SDCAN",SD))\1-SD W^SDC
OVR F SDJ=SD:0 S SDJ=$O(^SC(SC,"SDCAN",SDJ)) Q:SDJ=""!(SDJ\1-SD)  S SDZ(SDJ)=SD_($P(^(SDJ,0),"^",2)/10000)_$S($D(^SC(SC,"S",SDJ,"MES")):"   ("_$P(^("MES"),"(",2),1:"")
SHOW W !,"Clinic already has the following cancellation(s) for that date: ",!
 F Z=0:0 S Z=$O(SDZ(Z)) Q:Z=""  S X=Z D TM W !,?15,"From: ",X,"   To: " S X=+SDZ(Z) D TM W X,$S($P(SDZ(Z),"(",2)]"":"  ("_$P(SDZ(Z),"(",2),1:"")
CP S %=1 W !!,"Do you want to Cancel another portion of the day" D YN^DICN I '% W !,"REPLY YES (Y) OR NO (N)" G CP
 W:%<0 " NO" S SDANS=$S('(%-1):"Y",1:"N") Q:SDANS'["Y"
RDFR R !,"STARTING TIME: ",X:DTIME Q:"^"[X  D TC G RDFR:Y<0 S FR=Y,ST=%
RDTO R !,"ENDING TIME: ",X:DTIME Q:"^"[X  D TC G RDTO:Y<0 S SDHTO=X,TO=Y I TO'>FR W !,*7,"Ending time must be later than starting time!" G RDTO
 D TZ G:'$D(X) SHOW
 G ROPT^SDC
TC S X=$$FMTE^XLFDT(SD)_"@"_X,%DT="TE" D ^%DT I Y<0!(X["?") W !,"Enter a time after starting time",!,"for clinic and which is a valid time for clinic.",*7 Q
 S X=$E($P(Y_"0000",".",2),1,4),%=$E(X,3,4),%=X\100-STARTDAY*SI+(%*SI\60)*2 I %<0 W !,*7,"DAY STARTS AT ",STARTDAY S Y=-1
 I %>72 W *7,"?" S Y=-1
 Q
TZ K SDERR F Z=0:0 S Z=$O(SDZ(Z)) Q:Z=""  S SDERR=$S(FR'<Z&(FR<SDZ(Z)):1,TO>Z&(TO<SDZ(Z)):1,1:0) Q:SDERR  I Z'<FR&(Z<TO) S SDERR=1 Q
 G:SDERR ERR
 Q
MORE Q:$D(^SC(SC,"SDCAN",SDZL,0))  S A=^SC(SC,"SDCAN",0),SDCNT=$P(A,"^",4),^SC(SC,"SDCAN",0)=$P(A,"^",1,2)_"^"_SDZL_"^"_(SDCNT+1),^SC(SC,"SDCAN",SDZL,0)=SDZL_"^"_SDCTO
 Q
ERR W !!,*7,"Time frame selected overlaps previously cancelled time frame!",! K X Q
TM S X=$E($P(X,".",2)_"0000",1,4),%=X>1159 S:X>1259 X=X-1200 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M" Q
