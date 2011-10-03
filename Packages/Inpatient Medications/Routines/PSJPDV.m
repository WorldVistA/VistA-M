PSJPDV ;BIR/KKA-LIST PATIENTS ON SPECIFIC DRUGS ; 3/4/10 9:38am
 ;;5.0; INPATIENT MEDICATIONS ;**9,22,30,50,67,214,239**;16 DEC 97;Build 1
 ;
 ; Reference to ^PS(50.7 is supported by DBIA# 2180.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PS(59.7 is supported by DBIA# 2181.
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ; Reference to ^PS(50.606 is supported by DBIA# 2174.
 ; Reference to ^PS(50.605 is supported by DBIA# 696.
 ; Reference to ^%DT is supported by DBIA# 10003.
 ; Reference to ^%ZISC is supported by DBIA# 10089.
 ; Reference to ^DIC is supported by DBIA# 10006.
 ; Reference to ^DIR is supported by DBIA# 10026.
 ; Reference to ^VAUTOMA is supported by DBIA# 664.
 ;
DATES ;prompt user for the range of dates
 N QFLG,OUT
 W ! S %DT="ETX",D="start" D DT G:Y'>0 DONE S (%DT(0),PSJREPS)=+Y,D="stop" D DT K %DT G:Y'>0 DONE S:'$P(PSJREPS,".",2) PSJREPS=PSJREPS+.0001 S PSJREPF=Y+$S($P(Y,".",2):0,1:.24)
 ;
ORDERS D LIST^PSJEXP0 G:$D(OUT) DONE W !
 ;
SORT S DIR(0)="SAOM^P:Patient;S:Start Date",DIR("A")="Do you wish to sort by (P)atient or (S)tart Date: ",DIR("B")="Patient"
 S DIR("?",1)="Enter a ""P"" if you wish to sort by patient name or enter ""S"" if you",DIR("?")="wish to sort by order start date." D ^DIR K DIR S PSJSRT=Y G:$D(DTOUT)!($D(DUOUT)) DONE
 ;
SELECT W ! S DIR(0)="SAM^O:Orderable Item;D:Dispense Drug;V:VA Class of Drugs",DIR("A")="List by (O)rderable Item, (D)ispense Drug, or (V)A Class of Drugs: "
 S DIR("?",1)="Enter a ""O"" if you wish to list all patients on a specific orderable item",DIR("?",2)="Enter a ""D"" if you wish to list all patients on a specific dispense drug,"
 S DIR("?")="or enter a ""V"" if you wish to list all patients on a VA class of drugs." D ^DIR K DIR S PSJSL=Y G:$D(DTOUT)!($D(DUOUT)) DONE
 ;
DRGS S COUNT=1,BCNT=0 W !
 ;/IV Identifier is no longer used after POE
 ;/S PSJIDD=$P($G(^PS(59.7,1,31)),"^",2)
 F  K DIC S DIC=$S(PSJSL="O":50.7,PSJSL="D":50,PSJSL="V":50.605),DIC(0)="QEAMZ" Q:$D(OUT)  D
 .I PSJSL="O" D
 ..;/S DIC("W")="W ""  ""_$P(^PS(50.606,$P(^PS(50.7,+Y,0),""^"",2),0),""^"")_$S($P(^PS(50.7,+Y,0),""^"",3):"" ""_$G(PSJIDD),1:"""")_"
 ..S DIC("W")="W ""  ""_$P(^PS(50.606,$P(^PS(50.7,+Y,0),""^"",2),0),""^"")_"
 ..S DIC("W")=DIC("W")_""" ""_$S($P(^PS(50.7,+Y,0),""^"",4):$E($P(^(0),""^"",4),4,5)_""-""_$E($P(^(0),""^"",4),6,7)_""-""_$E($P(^(0),""^"",4),2,3),1:"""")"
 .D ^DIC K DIC S:$D(DTOUT)!($D(DUOUT)) QFLG=1 S:(+Y'>0) OUT=1 Q:+Y'>0  S IEN=+Y,NAME=$P(Y,U,2) D @PSJSL
 ;***PSJCNT is set to the number of drugs or classes the user chooses
 S PSJCNT=COUNT-1
 ;G:$D(QFLG)!(PSJCNT=0) DONE
 G:$D(QFLG)!(BCNT=0) DONE
 ;
MATCH ;**prompt user for the number of matches, default to 1 RMS/PBM PSJ*5*214
 W ! S DIR(0)="NAO^1:"_PSJCNT_":0",DIR("A")="Select number of matches: ",DIR("B")=1
 S DIR("?",1)="Enter the number of drugs that a user must be receiving to appear",DIR("?",2)="on the report.",DIR("?",3)="",DIR("?")="The number must be between 1 and "_PSJCNT
 D ^DIR K DIR S PSJMAT=Y G:$D(DTOUT)!($D(DUOUT)) DONE
 ;
DIVWARD ;PSJ*5*214 ADDS MULTIDIVISIONAL SUPPORT
 W !
 I $$CNTDIV^PSJQUTIL=1 S VAUTD=1 G UNIDIV
 D DIVISION^VAUTOMA
 G:$D(DTOUT)!($D(DUOUT))!(Y=-1) DONE
UNIDIV I '$G(VAUTNI) S VAUTNI=2
 D WARD^VAUTOMA
 G:$D(DTOUT)!(Y=-1) DONE
 I VAUTD I VAUTW D  ;WARD GROUPS
 . N PSJSTOP,PSJWARD,PSJSEL
 . W !!,"You may optionally select a ward group..." D G^PSJPDIR
 . Q:+PSJSTOP
 . S PSJWARD=0 F  S PSJWARD=$O(^PS(57.5,+PSJSEL("WG"),1,PSJWARD)) Q:'+PSJWARD  D
 .. S VAUTW=0,VAUTW($G(^PS(57.5,+PSJSEL("WG"),1,PSJWARD,0)))=""
 ;
DEV ; ask print device and queue if asked to
 K ZTSAVE S PSGTIR="ENQ^PSJPDV0",ZTDESC="List Patients on Specific Drugs" F X="CHOICE","PSJISP(","PSJSNM(","PSJREPS","PSJREPF","PSJSL","PSJSRT","PSJCNT","PSJMAT","VAUTD","VAUTW","VAUTD(","VAUTW(" S ZTSAVE(X)=""
 D ENDEV^PSGTI I POP!$D(ZTSK) W:POP !!?3,"No device selected for report run." W:$D(ZTSK) !?3,"Report Queued!" K ZTSK G DONE
 U IO
 W:$E(IOST)="C" !,"...this may take a few minutes...",!?25,"...you really should QUEUE this report, if possible..."
 D ^PSJPDV0
 I '$D(QFLG)&($E(IOST)="C") W !!,"Press RETURN to continue: " R CONT:DTIME
 ;
DONE W:$E(IOST)="P" @IOF D ^%ZISC K %DT,CHOICE,CNT,CONT,COUNT,D,DIC,DTOUT,DUOUT,IEN,NAME,OUT,POP,PRIM,PSGP,PSGTIR,PSJCNT,PSJISP,PSJMAT,PSJREPF,PSJREPS,PSJSL,PSJSNM,PSJSRT,QFLG,SPDRG,X,Y
 ;/K GG,GGG,MATCHES,ON,OUT,PSIVUP,PSJACNWP,PSJIDD,PSJORIFN,PSJPAD,PSJPAGE,PSJPBID,PSJPCAF,PSJPDD,PSJDOB,PSJPDX,PSJPHT,PSJPHTD,PSJPPID,PSJPRB,PSJPSEX,PSJPSSN,PSJPTD,PSJPTS,PSJPTSD,PSJPWD,PSJPWDN,PSJPWT,PSJPWTD,PSJPDOB,PSJPTSP
 K GG,GGG,MATCHES,ON,OUT,PSIVUP,PSJACNWP,PSJORIFN,PSJPAD,PSJPAGE,PSJPBID,PSJPCAF,PSJPDD,PSJDOB,PSJPDX,PSJPHT,PSJPHTD,PSJPPID,PSJPRB,PSJPSEX,PSJPSSN,PSJPTD,PSJPTS,PSJPTSD,PSJPWD,PSJPWDN,PSJPWT,PSJPWTD,PSJPDOB,PSJPTSP
 K PSJQ,VAUTD,VAUTW,VAUTNI
 Q
 ;
P ;get primary drug from user
 W !!,"Dispense Drugs for ",NAME," are:"
 S SPDRG=0 F  S SPDRG=$O(^PSDRUG("AP",IEN,SPDRG)) Q:'SPDRG  W !,$P(^PSDRUG(SPDRG,0),"^") S PSJISP(SPDRG_"D")=COUNT_NAME,PSJSNM(NAME)=""
 I $D(PSJSNM(NAME)) S (COUNT,BCNT)=COUNT+1
 E  W !,"   NONE FOUND"
 W ! Q
 ;
O ;get orderable item from user
 ;/I $P($G(^PS(50.7,IEN,0)),"^",3) S PSJIDD=$P($G(^PS(59.7,1,31)),"^",2) D O1 Q
 NEW FIL F FIL=52.6,52.7 I $O(^PS(FIL,"AOI",IEN,0)) D O1 Q
 W !!,"Dispense Drugs for ",NAME," are:"
 S SPDRG=0 F  S SPDRG=$O(^PSDRUG("ASP",IEN,SPDRG)) Q:'SPDRG  W !,$P(^PSDRUG(SPDRG,0),"^") S PSJISP(SPDRG_"D")=COUNT_NAME,PSJSNM(NAME)=""
 I $D(PSJSNM(NAME)) S (COUNT,BCNT)=COUNT+1
 E  W !,"   NONE FOUND"
 W ! Q
O1 ; here if the orderable item is marked for IV use
 W !!,"Additives for ",NAME," are:"
 ;/S SPDRG=0 F  S SPDRG=$O(^PS(52.6,"AOI",IEN,SPDRG)) Q:'SPDRG  W !,$P(^PS(52.6,SPDRG,0),"^") S PSJISP(IEN_"O")=COUNT_NAME,PSJSNM(NAME_"  "_PSJIDD)=""
 S SPDRG=0 F  S SPDRG=$O(^PS(52.6,"AOI",IEN,SPDRG)) Q:'SPDRG  W !,$P(^PS(52.6,SPDRG,0),"^") S PSJISP(IEN_"O")=COUNT_NAME,PSJSNM(NAME)=""
 ;/I $D(PSJSNM(NAME_"  "_PSJIDD)) S (COUNT,BCNT)=COUNT+1
 I $D(PSJSNM(NAME)) S (COUNT,BCNT)=COUNT+1
 E  W !,"   NONE FOUND" D
 .W !!,"Solutions for ",NAME," are:"
 .;/S SPDRG=0 F  S SPDRG=$O(^PS(52.7,"AOI",IEN,SPDRG)) Q:'SPDRG  W !,$P(^PS(52.7,SPDRG,0),"^") S PSJISP(IEN_"O")=COUNT_NAME,PSJSNM(NAME_"  "_PSJIDD)=""
 .S SPDRG=0 F  S SPDRG=$O(^PS(52.7,"AOI",IEN,SPDRG)) Q:'SPDRG  W !,$P(^PS(52.7,SPDRG,0),"^") S PSJISP(IEN_"O")=COUNT_NAME,PSJSNM(NAME)=""
 .;/I $D(PSJSNM(NAME_"  "_PSJIDD)) S (COUNT,BCNT)=COUNT+1
 .I $D(PSJSNM(NAME)) S (COUNT,BCNT)=COUNT+1
 .E  W !,"   NONE FOUND"
 W ! Q
 ;
D ;get dispense drug from user
 S PSJISP(IEN_"D")=COUNT,(BCNT,COUNT)=COUNT+1,PSJSNM(NAME)=""
 Q
 ;
V ;get VA Class of Drug from user
 D V2,VSPLIT Q:$G(PSJQ("STOP"))
V2 W !!,"Dispense Drugs for VA Class ",NAME," are: "
 S PRIM=0 F  S PRIM=$O(^PSDRUG("AOC",PRIM)) Q:'PRIM  S SPDRG=0 F  S SPDRG=$O(^PSDRUG("AOC",PRIM,NAME,SPDRG)) Q:'SPDRG  W !,$P(^PSDRUG(SPDRG,0),"^") S PSJISP(SPDRG_"D")=COUNT_NAME,PSJSNM(NAME)=""
 I $D(PSJSNM(NAME)) S (BCNT,COUNT)=COUNT+1
 W ! Q
 ;
VSPLIT I $D(^PS(50.605,"AC",IEN)) D
 . S PSJQ("CLASS")=0 F  S PSJQ("CLASS")=$O(^PS(50.605,"AC",IEN,PSJQ("CLASS"))) D:$D(^PS(50.605,"AC",+PSJQ("CLASS"))) VSPLIT2 Q:PSJQ("CLASS")'=+PSJQ("CLASS")  D
 .. S NAME=$P(^PS(50.605,PSJQ("CLASS"),0),"^") D V2 S PSJQ("STOP")=1
 Q
VSPLIT2 S PSJQ("CLASS2")=0 F  S PSJQ("CLASS2")=$O(^PS(50.605,"AC",PSJQ("CLASS"),PSJQ("CLASS2"))) Q:'+PSJQ("CLASS2")  S NAME=$P(^PS(50.605,PSJQ("CLASS2"),0),"^") D V2
 Q
DT S Y=-1 F  W !!,"Enter ",D," date: " R X:DTIME W:'$T $C(7) S:'$T X="^" D DTM:X?1."?",^%DT:"^"'[X I Y>0!("^"[X) W:Y<0 !,"No ",D," date chosen for notices run." Q
 Q
DTM W !!,"Enter the ",D," date of the range of dates where you wish to see patients ",!,"on specific drugs. The start date and stop date may be the same." W:D="stop" " The stop",!,"date may not come before the start date." W ! Q
