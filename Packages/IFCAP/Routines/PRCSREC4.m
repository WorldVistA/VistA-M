PRCSREC4 ;WISC/KMB-REPOST FILE 417.1 ENTRIES ;4/5/95  12:00
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;loop thru file 417.1 entries. try to reset 417.
START ;
 W !!,"This option attempts to repost FMS Exception file entries.",!,"Duplicate entries are not posted on the FMS Transactions file."
 N COUNT S COUNT=$P($G(^PRCS(417.1,0)),"^",4) W !!,"There are ",+COUNT," transactions in your FMS Exceptions File.",!!
 S %=1 W !!!,"Are you ready to begin" D YN^DICN Q:(%=2)!(%=-1)  G:%=0 START
 K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="LOOP^PRCSREC4",ZTDESC="FMS REPOSTING REPORT" D ^%ZTLOAD,^%ZISC W !,"End of processing" Q
 D LOOP,^%ZISC W !,"End of processing" QUIT
LOOP ;
 N A,B,AMT,ARRAY,II,FILE,FCP,FY,I,PODA,PONUM,PONUM1,QUARTER,RDA,STATION,STR,STRING,TDATE,TRANCODE,TRANSNUM,COUNTER,USER,X,Y,FLAG,TY,Z1,P
 D NOW^%DTC S Y=% D DD^%DT S TY=Y
 ;
 S (FLAG,P,Z1)=0,STR=",,,FY,,FUND,AO,SITE,PGM,FCPRJ,,,,JOB,,OC"
 S RDA=0 F  S RDA=$O(^PRCS(417.1,RDA)) Q:(+RDA=0)!(Z1="^")  D RESET
 I FLAG=0 U IO W !,"No transactions were reposted."
 QUIT
RESET ;
 S STRING=^PRCS(417.1,RDA,0)
 F I=4,6,7,8,9,10,14,16 S ARRAY($P(STR,",",I))=$P(STRING,"^",I)
 S STATION=ARRAY("SITE"),AMT=$P(STRING,"^",20),QUARTER=$P(STRING,"^",5),FY=$P(STRING,"^",4),TDATE=$P(STRING,"^",22),(PONUM,PONUM1)=$P(STRING,"^",18)
 S ARRAY("BFY")=+$$YEAR^PRC0C($P(STRING,"^",2))
 S TRANSNUM=$P(STRING,"^",17)_"-"_PONUM_"-"_$E(TDATE,2,7)_"-"_+$P(STRING,"^",19)_"-"_QUARTER
 ;
CHEC442 ;
 S PODA=0,FCP="" S PONUM=$E(PONUM,4,9),PONUM=STATION_"-"_PONUM S:$D(^PRC(442,"B",PONUM)) PODA=$O(^PRC(442,"B",PONUM,0))
 I +PODA'=0 S FCP=$P($G(^PRC(442,PODA,0)),"^",3),FCP=+$P(FCP," ") I $D(^PRC(420,STATION,1,FCP,4,FY)) G POST
 ;
 S A="" D FINDCP^PRCSREC Q:A=""
 S B=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_A_""",",0) Q:'B
 S FCP=+$P(^PRCD(420.141,B,0),"^",2) Q:+FCP=0
 I '$D(^PRC(420,STATION,1,+FCP,4,FY)) Q
 ;
 ;
POST ;
 S TRANSNUM=TRANSNUM_"-"_FCP
 Q:$D(^PRCS(417,"B",TRANSNUM))
 S A=STATION_"^"_+FCP_"^"_FY_"^"_QUARTER_"^"_AMT D EBAL^PRCSEZ(A,"O")
 S TRANCODE=$P(STRING,"^",17) I TRANCODE'="CC",$E(PONUM1,4,7)'?4A D EBAL^PRCSEZ(A,"C")
 S X=TRANSNUM,DIC="^PRCS(417,",DIC(0)="LZ",DLAYGO=417 D ^DIC Q:Y=-1  S FMSDA=+Y K DIC
 L +^PRCS(417,FMSDA):5 Q:'$T  F I=2:1:20 S $P(^PRCS(417,FMSDA,0),"^",I)=$P(STRING,"^",I)
 S $P(^PRCS(417,FMSDA,0),"^",22)=TDATE
 S COUNTER=STATION_"-"_FY_"-"_QUARTER_"-"_FCP,$P(^PRCS(417,FMSDA,0),"^",21)=COUNTER,^PRCS(417,"C",COUNTER,FMSDA)=""
 S $P(^PRCS(417,FMSDA,1),"^")=1
 L -^PRCS(417,FMSDA) S FLAG=1 D:P=0 HDR
 D:IOSL-$Y<3 HOLD Q:Z1="^"
 U IO W !,TRANSNUM," posted to control point ",FCP,!,"for fiscal year ",FY,", quarter ",QUARTER," for $",AMT
 S DA=RDA,DIK="^PRCS(417.1," D ^DIK K DA,DIK
 QUIT
 ;
HOLD G HDR:$D(ZTQUEUED),HDR:IO'=IO(0) W !,"Press return to continue, uparrow (^) to exit: " R Z1:DTIME S:'$T Z1="^" D:Z1'="^" HDR Q
 ;
HDR S P=P+1,II="" U IO W !,"FMS REPOSTING REPORT",?30,TY,?60,"PAGE ",P S $P(II,"-",80)="-" W !,II
 QUIT
