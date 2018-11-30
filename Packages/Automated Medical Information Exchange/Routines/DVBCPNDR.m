DVBCPNDR ;ALB/GTS-557/THM-2507 PENDING REQUESTS, PART 1 ; 2/12/03 5:21pm
 ;;2.7;AMIE;**51**;Apr 10, 1995
 ;
 S DVBCCNT=0 D HOME^%ZIS W @IOF,"Pending 2507 Request Report",!!! K NOASK S ADIVNUM="",ADIV="",FF=IOF
 ;
ASK W !!,"Do you want to sort by:",!!?5,"(A)ge of request",!?5,"(S)tatus",!?5,"(V)eteran name",!?5,"(R)outing location",!!?5,"Selection:   V// " R DVBCSORT:DTIME G:'$T!(DVBCSORT=U) KILL^DVBCUTIL
 S:DVBCSORT="r" DVBCSORT="R"
 S:DVBCSORT="a" DVBCSORT="A"
 S:DVBCSORT="s" DVBCSORT="S"
 S:DVBCSORT="v" DVBCSORT="V"
 I DVBCSORT'=""&("A^S^V^R"'[DVBCSORT) W !!,*7,"Answer must be A, S, V, or R.",!! H 3 W @IOF G ASK
 W $S(DVBCSORT="V":"eteran name",DVBCSORT="":"Veteran name",DVBCSORT="A":"ge of request",DVBCSORT="S":"tatus",DVBCSORT="R":"outing location",1:"") I DVBCSORT="" S DVBCSORT="V"
 S DVBCHDR=$S(DVBCSORT="V":"Veteran name",DVBCSORT="R":"Routing location",DVBCSORT="S":"Status",DVBCSORT="A":"Age of request",1:"Unknown"),DVBCHDR="Sorted by "_DVBCHDR
 ;
SSORT H 1 I DVBCSORT="S" W @IOF,"Status selection:",!!!!,"Select STATUS (enter A for all): P// " R RSTAT:DTIME G:'$T!(RSTAT=U) KILL^DVBCUTIL I RSTAT="" S RSTAT="P" W RSTAT
 I DVBCSORT="S" S:RSTAT="n" RSTAT="N" S:RSTAT="t" RSTAT="T" S:RSTAT="p" RSTAT="P" S:RSTAT="a" RSTAT="A"
 I DVBCSORT="S",RSTAT'?1"N",RSTAT'?1"P",RSTAT'?1"T",RSTAT'?1"A" W *7,!!,"Status must be N (new), P (pending), T (transcribed) or A (all)" H 3 G SSORT
 I DVBCSORT="S" W $S(RSTAT="P":"ending",RSTAT="T":"ranscribed",RSTAT="N":"ew",RSTAT="A":"ll",1:"")
 ;
ESORT I DVBCSORT="A" W @IOF,!,"Age selection:",!!!?5,"Enter EARLIEST age: " R ERDAYS:DTIME G:'$T!(ERDAYS=U) KILL^DVBCUTIL
 I DVBCSORT="A",(ERDAYS<1) W *7,!!,"Enter the shortest time span (in days) which 2507 processing has elapsed.",!,"Cannot be less than one day !",!,"If you want NEW requests (zero days), sort by status.",!! D CONTMES^DVBCUTL4 G ESORT
 ;
OSORT I DVBCSORT="A" W !?8," and OLDEST age: " R OLDAYS:DTIME G:'$T!(OLDAYS=U) KILL^DVBCUTIL
 I DVBCSORT="A",(OLDAYS<1) W *7,!!,"Enter the longest time span (in days) which 2507 processing has elapsed.",!,"Cannot be less than 1 day",!! H 4 G OSORT
 I DVBCSORT="A",ERDAYS>OLDAYS W *7,!!,"Earliest age must be less than oldest age",!! H 2 G ESORT
 G CALWRK:DVBCSORT'="R" H 1 W @IOF,!,"Routing Location Selection:",!!! S DIC="^DG(40.8,",DIC(0)="AEQM",DIC("A")="Enter MEDICAL CENTER DIVISION: " D ^DIC G:X=""!(X=U) KILL^DVBCUTIL S ADIVNUM=+Y I ADIVNUM<0 G KILL^DVBCUTIL
 ;
CALWRK W !!,"Do you want elapsed time reported",!," in (C)alender days or (W)ork days?  C// " R ELTYP:DTIME I '$T!(ELTYP=U) G KILL^DVBCUTIL
 S:ELTYP="c" ELTYP="C"
 S:ELTYP="w" ELTYP="W"
 I ELTYP'?1"W"&(ELTYP'?1"C")&(ELTYP'="") W !!,*7,"Must be C for Calendar, W for Workdays",!,"or simply press RETURN to accept the default.",!! H 2 G CALWRK
 W $S(ELTYP="":"Calendar",ELTYP="C":"alendar",ELTYP="W":"ork",1:"Unknown")_" days" I ELTYP="" S ELTYP="C"
 S HEAD3="(Elapsed time in "_$S(ELTYP="C":"Calendar",ELTYP="W":"Work",1:"Unknown")_" days)"
 ;
DEV W !! S %ZIS="AEQ",%ZIS("A")="Printing device: " D ^%ZIS K %ZIS G:POP KILL^DVBCUTIL
 I $D(IO("Q")) S ZTRTN="SETUP^DVBCPND1",ZTIO=ION,ZTDESC="2507 PENDING REPORT",NOASK=1 F I="STAT","RSTAT","DVBC*","HEAD*","ELTYP","CMPDIV","ERDAYS","OLDAYS","ADIVNUM","ADIV","NOASK","DUZ" S ZTSAVE(I)=""
 I  D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! H 1 G KILL^DVBCUTIL
 G SETUP^DVBCPND1
