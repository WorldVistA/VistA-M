PSGWPAW1 ;BHAM ISC/PTD,CML-Print AMIS Data Worksheet for All Drugs in All AOUs - CONTINUED ; 05/22/90 10:10
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
PRINT S PSGWPG=1,$P(PSGWLN,"_",33)="" D PG1,HDR
 F PSGWTY=0:0 S PSGWTY=$O(^TMP("PSGWPAW",$J,PSGWTY)),PSGWNM=0 G:PSGWTY=9999 ONDM G:'PSGWTY DONE D:$Y+5>IOSL HDR D WRTYPE F J=0:0 S PSGWNM=$O(^TMP("PSGWPAW",$J,PSGWTY,PSGWNM)) Q:PSGWNM=""  D:$Y+5>IOSL HDR W !!?5,PSGWNM,?45,PSGWLN
 ;
ONDM S PSGWNM=0 D:$Y+5>IOSL HDR D WRTYPE F J=0:0 S PSGWNM=$O(^TMP("PSGWPAW",$J,9999,PSGWNM)) Q:PSGWNM=""  I '$D(^TMP("PSGWPAW",$J,"DN",PSGWNM)) D:$Y+5>IOSL HDR W !!?5,PSGWNM,?45,PSGWLN
 ;
DONE I $E(IOST)'="C" W @IOF
END K ^TMP("PSGWPAW",$J),I,J,K,PSGWAOU,PSGWDR,PSGWITM,PSGWNM,PSGWTY,PSGWPG,PSGWIO,ZTSK,PSGWDT,PSGWLN,%,%H,%I,%DT,ZTIO,IO("Q"),X,Y
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
PG1 F I=1:1:10 W !
 W !?30,"AMIS DATA WORKSHEET",!!!?5,"For each drug listed on the following page(s), determine the AMIS category",!,"and AMIS conversion number to be entered for AR/WS AMIS statistics.",!!!
 W "AMIS CATEGORY will classify the drug for AR/WS AMIS.",!,"You will enter ""0"", ""1"", ""2"", or ""3"".",!!?5,"==> ""0"" Means the drug is classified as field 03 or 04.",!?10,"Include tablets, capsules, multi-dose vials, etc."
 W !?10,"Exclude multiple-dose externals, liquids, or antacids.",!!?5,"==> ""1"" Means the drug is classified as field 06 or 07.",!?10,"Include multiple-dose externals, liquids, antacids, otics,",!?10,"opthalmics, and inhalations.",!!
 W ?5,"==> ""2"" Means the drug is classified as field 17.",!?10,"Include solutions and administration sets.",!!
 W ?5,"==> ""3"" Means the drug is classified as field 22.",!?10,"Include blood and blood products.",!!!
 W "AMIS CONVERSION NUMBER:",!?5,"This number reflects the number of doses/units contained in a single",!?5,"quantity dispensed.  For example:",!?10,"For a 20cc vial, quantity dispensed is 1, and conversion number is 20."
 W !?10,"For 5oz. antacid, quantity dispensed is 1, and conversion number is 1.",!?10,"For a bottle of 100 aspirin, quantity dispensed is 1, and",!?10,"conversion number is 100.",!!!
 Q
 ;
HDR ;PRINT REPORT MAIN HEADER
 S %DT="",X="T" D ^%DT X ^DD("DD") W:$Y @IOF W !!,"PAGE: ",PSGWPG,?60,"DATE: ",Y,!?30,"AMIS DATA WORKSHEET",!!,"TYPE",?45,"AMIS CATEGORY",?65,"AMIS CONVERSION",!?5,"DRUG NAME",?45,"(0,1,2, or 3)",?70,"NUMBER",!
 F J=1:1:80 W "="
 S PSGWPG=PSGWPG+1
 Q
 ;
WRTYPE W !!,$S((PSGWTY'=9999)&($D(^PSI(58.16,PSGWTY,0))):$P(^PSI(58.16,PSGWTY,0),"^"),1:"** UNCLASSIFIED BY TYPE: ") Q
