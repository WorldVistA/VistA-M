DGPTBE1 ;ALB/BOK - ENTER BREAKEVEN VALUES FOR DRG ;  27 APR 88 @ 0900
 ;;5.3;Registration;**158,252**;Aug 13, 1993
 ;
FY W !!,"Enter Values for (F)ISCAL YEAR or (Q)UARTER: QUARTER// " S Z="^QUARTER^FISCAL YEAR" S X="" R X:DTIME G Q:X["^"!('$T) I X="" S X="Q" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM: ",!?12,"Q - values are entered on a quarterly basis",!?12,"F - values are entered once a year and are ",!?16,"therefore the same for each quarter." S %="" G FY
 S DGY=$S(X="Q":1,1:0)
 ;Display help text
 D HELP
QRTR W !!,"Select Fiscal Year",$S(DGY:" and Quarter: ",1:": ") R DGFY:DTIME G Q:DGFY["^"!('$T)!(DGFY="") I DGY,($L(DGFY)'=5)!("1234"'[($E(DGFY,5)))!(DGFY<19801) D HELP G QRTR
 I 'DGY I $L(DGFY)'=4!(DGFY<1980) D HELP G QRTR
 ;Validate year entered
 N DGFY2B
 S DGFY2B=$$DGY2K^DGPTOD0($E(DGFY,1,4))
 I DGFY2B<0 D HELP G QRTR
 S DGFY2B=$$FMTE^XLFDT(DGFY2B),DGFY=DGFY2B_$E(DGFY,5)
SV W !!,"Enter values by (I)NDIVIDUAL SERVICE or ",!?3,"(S)AME VALUE FOR ALL SERVICES: INDIVIDUAL// " S Z="^INDIVIDUAL SERVICE^SAME VALUE FOR ALL SERVICES" S X="" R X:DTIME G Q:X["^"!('$T) I X="" S X="I" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM: ",!?12,"I - values are entered for each service",!?12,"S - one value is entered and used for all services" G SV
 S DGS=$S(X="I":1,1:0),DGHD="FY          MED      NEUR      PSYCH     REHAB     SURG     MED CTR"
BE S DGVALUES="" I 'DGS W !!,"MEDICAL CENTER BREAKEVEN DAYS: " D DGBE Q:'DGGO  F %=1:1:6 S DGVALUES=DGVALUES_DGBE_"^"
 I DGS W ! F DGSV=1:1:6 D W,DGBE Q:'DGGO  S DGVALUES=DGVALUES_DGBE_"^"
 G Q:'DGGO D TABLE,DRG
CONTINU F DGGO=0:0 S %=1 W !!,"Do you wish to select another DRG" D YN^DICN G:%=0 HELP1 Q:%'=1  D DRG
Q K DIC,DGBE,DGCURENT,DGFY,DGFY1,DGGO,DGHD,DGQRTR,DGS,DGSV,DGVALUES,DGY,DRG,%,I,X,Y,Z Q
W W !,$S(DGSV=1:"MEDICINE",DGSV=2:"NEUROLOGY",DGSV=3:"PSYCHIATRY",DGSV=4:"REHAB MEDICINE",DGSV=5:"SURGERY",1:"MEDICAL CENTER"),$S(DGSV'=6:" SERVICE",1:"")," BREAKEVEN DAYS: " Q
TABLE W !!,$J("TABLE OF BREAKEVEN VALUES YOU HAVE SELECTED:",55),!,DGHD,! F %=1:1:7 W "-------   "
 W !,DGFY,?7 F %=1:1:6 W ?3,$J($P(DGVALUES,"^",%),10)
 W ! Q
DRG K DGCURENT S DGCURENT="",DIC("A")="MOVE BREAKEVEN VALUES FROM TABLE INTO WHICH DRG? ",DIC(0)="AEQM",DIC="^ICD(" D ^DIC Q:Y'>0  S DRG=+Y K DIC
 S:'$D(^ICD(DRG,"BE",0)) ^(0)="^80.23" F %=1:1:4 S DGFY1=$S(DGY:DGFY,1:DGFY_%) S:'$D(^ICD(DRG,"BE",DGFY1,"S",0)) ^(0)="^80.24SA" Q:DGY
 I DGY S:$D(^ICD(DRG,"BE",DGFY,0))#2 $P(DGCURENT(1),"^",6)=$P(^ICD(DRG,"BE",DGFY,0),"^",2) F %=1:1:5 S:$D(^ICD(DRG,"BE",DGFY,"S",%,0)) $P(DGCURENT(1),"^",%)=$P(^ICD(DRG,"BE",DGFY,"S",%,0),"^",2)
 I 'DGY F %=1:1:4 S:$D(^ICD(DRG,"BE",DGFY_%,0))#2 $P(DGCURENT(%),"^",6)=$P(^ICD(DRG,"BE",DGFY_%,0),"^",2) F I=1:1:5 S:$D(^ICD(DRG,"BE",DGFY_%,"S",I,0)) $P(DGCURENT(%),"^",I)=$P(^ICD(DRG,"BE",DGFY_%,"S",I,0),"^",2)
 F %=0:0 S %=$O(DGCURENT(%)) Q:%'>0  I DGCURENT(%)]"" S DGCURENT=1 Q
 W !!,$S(DGCURENT:"  ",1:"NO")," BREAKEVEN VALUES CURRENTLY IN FILE FOR DRG: ",DRG,$S(DGCURENT:"",'DGY:" for selected FY",1:" for selected FY/Q") I DGCURENT W !,DGHD,! F %=1:1:7 W "-------   "
 I DGCURENT F I=0:0 S I=$O(DGCURENT(I)) Q:I'>0  W !,DGFY,$S(DGY:"",1:I),?7 F %=1:1:6 W ?3,$J($P(DGCURENT(I),"^",%),10)
C W !!,"COPY VALUES FROM TABLE INTO DRG FILE" S %=1 D YN^DICN Q:%=2  I %=0 W !!?12,"Y - to have your selected breakeven values",!?16,"copied into the DRG File",!?12,"N - to make no changes to the DRG File" G C
 Q:%'=1  S DGBE=$P(DGVALUES,"^",6) D WAIT^DICD,^DGPTBE2 Q
DGBE S DGGO="" R DGBE:DTIME Q:DGBE["^"!('$T)  I +DGBE'=DGBE!(DGBE>366)!(DGBE<0)!($L($P(DGBE,".",2))>1) W !,"enter a number between 0 and 366, up to 1 decimal digit" W !,"BREAKEVEN DAYS: " G DGBE
 S DGGO=1 Q
HELP W !!?5,"Please enter a 4-digit fiscal year",$S(DGY:" and quarter",1:"")," as 1999",$S(DGY:"1",1:"")," for fiscal",!?5,"year 1999",$S(DGY:" first quarter",1:""),".  Fiscal years earlier than 1980 not allowed." Q
HELP1 W !!?12,"CHOOSE FROM: ",!?12,"Y - yes to copy the same breakeven values from the table",!?16,"into a different DRG",!?12,"N - no to exit" G CONTINU
