PSGWADE1 ;BHAM ISC/PTD,CML-Enter AMIS Data for All Drugs in All AOUs - CONTINUED ; 23 Mar 93 / 10:29 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
DONE I (PSGWFLG=1)&(PSGWRET=0) W !!!,"All drugs in all AOUs contain AMIS data.",!,"If you need to edit data for a selected drug,",!,"use the AMIS Data Enter/Edit (Single Drug) option.",!!!
 I  W "If you wish to view the data stored in the drug file for",!,"AR/WS AMIS statistics, use the Data for AMIS Stats - Print option.",!!!
END K ^TMP("PSGW",$J),^TMP("PSGWDN",$J),K,PSGWFLG,PSGWRET,PSGWAOU,PSGWITM,PSGWDR,PSGWTY,PSGWNM,PSGWCT,PSGWCN,PSGW2,PSGWDT,PSGWPC,%,%I,%H,DA Q
 ;
 ;LOOP THROUGH UTILITY GLOBAL BY TYPE, DRUG NAME & DRUG #. CHECK FOR AMIS INFO IN DRUG FILE.
LOOP S PSGWTY=""
L1 S PSGWTY=$O(^TMP("PSGW",$J,PSGWTY)),PSGWNM="" G:'PSGWTY DONE W:(PSGWTY'=9999)&($D(^PSI(58.16,PSGWTY,0))) !!?5,"TYPE: ",$P(^PSI(58.16,PSGWTY,0),"^") W:PSGWTY=9999 !!?5,"** UNCLASSIFIED BY TYPE:"
L2 S PSGWNM=$O(^TMP("PSGW",$J,PSGWTY,PSGWNM)),PSGWDR="" G:PSGWNM="" L1 I (PSGWTY=9999)&($D(^TMP("PSGWDN",$J,PSGWNM))) G L2
L3 S PSGWDR=$O(^TMP("PSGW",$J,PSGWTY,PSGWNM,PSGWDR)) G:'PSGWDR L2
CHK S PSGW2=1 I $D(^PSDRUG(PSGWDR,"PSG")) G:($P(^PSDRUG(PSGWDR,"PSG"),"^",2)'="")&($P(^PSDRUG(PSGWDR,"PSG"),"^",3)'="") L3
 I $P(^PSDRUG(PSGWDR,0),"^")'="" W !!,"==> "_$P(^(0),"^")
 E  W !!,"The name for drug number ",PSGWDR," is missing from your drug file.",!,"Please notify your package coordinator!"
 I '$D(^PSDRUG(PSGWDR,"PSG")) D ASKCAT G:PSGWCT="^" END G:('$T)&(PSGWCT="") END S:PSGWCT="" PSGWRET=1 G:PSGWCT="" L3 D ASKCON G:PSGWCN="^" END G:('$T)&(PSGWCN="") END S:PSGWCN="" PSGWRET=1 G:PSGWCN="" L3 D SETNOD S PSGWFLG=0 G L3
 I $D(^PSDRUG(PSGWDR,"PSG"))&($P(^PSDRUG(PSGWDR,"PSG"),"^",2)="") D ASKCAT G:PSGWCT="^" END G:('$T)&(PSGWCT="") END S:PSGWCT="" PSGWRET=1 G:PSGWCT="" L3 S PSGWFLG=0,PSGWPC=2,PSGW2=0 D SETPC
 I $D(^PSDRUG(PSGWDR,"PSG"))&($P(^PSDRUG(PSGWDR,"PSG"),"^",3)="") W:PSGW2=1 !,"AMIS Category: ",$P(^PSDRUG(PSGWDR,"PSG"),"^",2) D ASKCON G:PSGWCN="^" END G:('$T)&(PSGWCN="") END S:PSGWCN="" PSGWRET=1 G:PSGWCN="" L3 S PSGWFLG=0,PSGWPC=3 D SETPC
 G L3
 ;
ASKCAT R !,"Enter AMIS Category: ",PSGWCT:DTIME S:'$T PSGWCT="^" Q:"^"[PSGWCT
 I "?"[$E(PSGWCT)!(PSGWCT<0)!(PSGWCT>3)!(PSGWCT'?1N) D HELP G ASKCAT
 Q
 ;
ASKCON R !,"Enter AMIS Conversion Number: ",PSGWCN:DTIME S:'$T PSGWCN="^" Q:"^"[PSGWCN
 I "?"[$E(PSGWCN)!(PSGWCN'?1.4N)!(PSGWCN<1)!(PSGWCN>9999) W *7,!!,"Enter a whole number between 1 and 9999.",!,"This number reflects the number of doses/units",!,"contained in a single quantity dispensed.",!! G ASKCON
 Q
 ;
SETNOD S ^PSDRUG(PSGWDR,"PSG")="^"_PSGWCT_"^"_PSGWCN Q
 ;
SETPC I PSGWPC=2 S $P(^PSDRUG(PSGWDR,"PSG"),"^",2)=PSGWCT
 I PSGWPC=3 S $P(^PSDRUG(PSGWDR,"PSG"),"^",3)=PSGWCN
 Q
HELP W *7,!!,"Enter the category that this drug is to be classified as for AMIS:",!?5,"==> ""0"" for field 03 or 04",!?5,"==> ""1"" for field 06 or 07",!?5,"==> ""2"" for field 17",!?5,"==> ""3"" for field 22",!! Q
