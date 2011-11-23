DVBCRLST ;ALB/GTS-557/THM-LIST C&P REQUESTS ; 1/3/91  6:20 AM
 ;;2.7;AMIE;;Apr 10, 1995
 S LN="C&P REQUESTS BY DATE RANGE" D HOME^%ZIS
 ;
 W @IOF
 W !?(IOM-$L(LN)\2),LN,!!! ;S %DT="AE",%DT("A")="Enter DATE OF REQUEST FROM: " D ^%DT S BDATE=Y-.0001
EN1 S PHYS="N" W !!,"Do you want to report by physician" S %=2 D YN^DICN G:$D(DTOUT)!(%<0) END I %=1 S PHYS="Y"
 I %=0 W !!,"Enter <Y> to report by Physician or <N> to report only by date range." G EN1
 W !!,*7,"This report uses ",$S(PHYS="Y":132,1:80)," columns.",!! D PRINT
 ;;;I $D(IOST),IOST?1"C-".E W !!,"Press [RETURN] to continue or ""^"" to exit    " R ANS:DTIME I ANS=U!('$T) G END
 ;
END K %DT,B,BDATE,EDATE,FR,TO,L,DIC,ANS,DIJ,DP,P,X,Y,LN,IOY,DA,DO,C,D,DE,DHD,DIK,DIS,I,J,K,IOP,%ZIS,BY,FLDS,PHYS
 ;;;W @IOF,!
 Q
 ;
PRINT S HDR="2507 Requests "_$S(PHYS="Y":"by Physician",1:"by Date Range")
 D NOW^%DTC S Y=% D DD^%DT
 S TME=$E(Y,1,12)_"  "_$E(Y,14,18),PGE=0,SCNWTH=$S(PHYS="Y":132,1:80)
 I PHYS="N" S DHD="W HDR S PGE=PGE+1 W ?47,TME,?69,""PAGE "",PGE,!,""    for ""_$$SITE^DVBCUTL4,?45,""REQUEST"",!,""NAME"",?32,""SSN"",?45,""DATE"",?56,""REQUESTER"",! F CNT=1:1:SCNWTH W ""-"""
 I PHYS="Y" D SETDHD
 S L=0
 I PHYS="N" S BY="[DVBA C REQUESTS BY DATE RANGE]",FLDS=BY
 I PHYS="N" S DIC="^DVB(396.3,"
 I PHYS="Y" S BY="[DVBA C REQUESTS BY PHYSICIAN]",FLDS=BY
 I PHYS="Y" S DIC="^DVB(396.4,"
 D EN1^DIP K HDR,SCNWTH,TME,PGE,CNT,%,Y,X,%H Q
 ;
SETDHD ;
 S DHD="W HDR S PGE=PGE+1 W ?99,TME,?121,""PAGE "",PGE,!,""  for ""_$$SITE^DVBCUTL4,?42,""REGIONAL OFFICE"",?91,""EXAM"",!,""NAME"",?27,""SSN"",?42,""NAME"",?59,""EXAM"",?91,""DATE"",?101,""EXAMINING PHYSICIAN"",! F CNT=1:1:SCNWTH W ""-"""
 Q
