DVBCCHKR ;ALB/GTS-557/THM-CHECK C&P REQUEST FOR CRITICAL DATA ; 4/23/91  7:53 AM
 ;;2.7;AMIE;**17**;Apr 10, 1995
 ;
 ;** Version Changes
 ; 2.7 - GTS/C&P appt links report (Enhc 13)
 ;
 S DVBCMAN="" G EN
 ;
CHECK N OLDX
 S OLDX=X,DTA=^DVB(396.3,DA,0),DTB=$S($D(^DVB(396.3,DA,1)):^(1),1:"")
 Q:$P(DTA,U,18)["X"  F XI=2,3,4,10,18 I $P(^DVB(396.3,DA,0),U,XI)="" S X=X_XI_U
 I $P(DTB,U,4)="" S X=X_99_U
 I $O(^DVB(396.4,"C",DA,0))="" S X=X_98_U ;no exams selected
 S REQDA=DA,NAME=$P(^DPT(DFN,0),U,1) D:STYLEIND'="4" LINKCK
 I OLDX'=X DO
 .S:$E(X,$L(X))="^" X=$E(X,1,($L(X)-1))
 .S X=X_";"_DA_"~"
 I X]"" S ^TMP($J,NAME,DFN)=X
 Q
 ;
PRINT D HDR S NAME=""
 F XI=0:0 S NAME=$O(^TMP($J,NAME)) Q:NAME=""!($D(DVBCQUIT))  DO
 .S (DVBAPC,DVBADTA)=""
 .F DFN=0:0 S DFN=$O(^TMP($J,NAME,DFN)) Q:DFN=""!($D(DVBCQUIT))  DO
 ..I (IOST?1"C-".E),($Y>(IOSL-9)) D TERM^DVBCUTL3 S:$D(GETOUT) DVBCQUIT=""
 ..I '$D(DVBCQUIT) DO
 ...D:($Y>(IOSL-9)) HDR
 ...D NAMELN ;**Output name
 ...F DVBAPC=1:1 S DVBADTA=$P(^TMP($J,NAME,DFN),"~",DVBAPC) Q:DVBADTA=""  DO
 ....W !
 ....S DTA=$P(DVBADTA,";",1),REQDA=$P(DVBADTA,";",2) ;**DVBADTA=Prob pce
 ....F DVBCX=1:1 S DVBAY=$P(DTA,U,DVBCX) Q:DVBAY=""!($D(DVBCQUIT))  I DVBAY]"" D PRINT1
 .K DVBAPC,DVBADTA
 I '$D(DVBCQUIT)&(IOST?1"C-".E) D TERM^DVBCUTL3 S:$D(GETOUT) DVBCQUIT=""
 Q
 ;
PRINT1 I (IOST?1"C-".E),($Y>(IOSL-2)) D TERM^DVBCUTL3 S:$D(GETOUT) DVBCQUIT=""
 I '$D(DVBCQUIT) DO
 .I ($Y>(IOSL-2)) D HDR,NAMELN
 .W ?50,$S(DVBAY=2:"Request date",DVBAY=3:"Regional office number",DVBAY=4:"Requester",DVBAY=10:"Priority of exam",DVBAY=18:"Request status",DVBAY=99:"Routing location",1:"")
 .W:DVBAY=98 ?50,"** No exams selected **"
 .W:DVBAY=199 ?50,"** No C&P Appt's linked **"
 .W !
 Q
 ;
EN D HOME^%ZIS S FF=IOF
 W @FF,!!,"This report will check the 2507 REQUEST file for missing crucial data.",!!,"All requests will be checked and those found missing any of the following",!,"will be reported:",!!
 W "1)  Request date",!,"2)  Regional office number",!,"3)  Requester",!,"4)  Priority of exam",!
 W "5)  Request status",!,"6)  Routing location",!,"7)  No exams selected"
 D SETSTYLE
 W:STYLEIND=4 !
 W:STYLEIND'="4" !,"8)  Requests older than 3 days without C&P Appt links ",!
 W ! K PARAMDA
 ;
ASK W "Do you want to continue" S %=2 D YN^DICN G:$D(DTOUT) EXIT
 I $D(%Y),%Y["?" W !!,"Enter Y to print the report or N to quit.",!! H 2 G ASK
 I $D(%),%'=1 G EXIT
 ;
DEV W !! S %ZIS="AEQ" D ^%ZIS K %ZIS G:POP EXIT I $D(IO("Q")) S ZTIO=ION,ZTDESC="2507 exam integrity report",ZTRTN="GO^DVBCCHKR" F I="FF" S ZTSAVE(I)=""
 I  D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued",!! G EXIT
 ;
GO D:'$D(STYLEIND) SETSTYLE
 K ^TMP($J),LN,DVBCQUIT,GETOUT S (ITEMS,PG)=0,$P(LN,"-",80)="-",HD="C & P Exam Integrity Report",DVBCDT=$$FMTE^XLFDT(DT,"5DZ")
 U IO F DFN=0:0 S X="",DFN=$O(^DVB(396.3,"B",DFN)) Q:DFN=""  F DA=0:0 S DA=$O(^DVB(396.3,"B",DFN,DA)) Q:DA=""  D CHECK
 I '$D(^TMP($J)) D HDR W !!!!!?25,"Nothing found to report",!!
 I $D(^TMP($J)) D PRINT
 I ('$D(^TMP("DVBA",$J))&((+STYLEIND'="4")&(+$$RPTCHK=1))) DO
 .D NOW^%DTC S Y=X X ^DD("DD")
 .S TODAYDT=Y K Y,X
 .S SITE=$$SITE^DVBCUTL4
 .D RPTHD^DVBCULAP W !!!!!?25,"Nothing found to report",!!
 .I (IOST?1"C-".E) D PAUSE^DVBCUTL4
 .K TODAYDT,SITE
 I $D(^TMP("DVBA",$J)) D:(+$$RPTCHK=1) ^DVBCULAP
 ;
EXIT D ^%ZISC
 W:'$D(ZTQUEUED) @FF,!!!
 I $D(ZTQUEUED)&($D(DVBCMAN)) D KILL^%ZTLOAD
 K %,%Y,DTA,DTB,DTOUT,DVBCDT,FF,HD,NAME,PG,I,ZTSAVE,POP,X,XI,Y,ZTDESC,ZTIO,ZTRTN,ZTSK,ITEMS,PRINT,DFN,DA,LN,DVBCMAN,DVBCQUIT,GETOUT,DVBCX,HDRPRT
 K ^TMP("DVBA",$J),^TMP($J),REQDA,STYLEIND,DVBAY,DIQ,DIR,DIRUT,DUOUT
 K DR,DIC
 Q
 ;
HDR S PG=PG+1,HDRPRT="" W @IOF
 W !,DVBCDT,?(80-$L(HD)\2),HD,?69,"Page: ",PG,!,?(80-$L($$SITE^DVBCUTL4)\2),$$SITE^DVBCUTL4,!!,"Veteran name",?28,"Social Sec #",?50,"Missing items",!
 Q
 ;
LINKCK ;** Patient DFN's w/ 2507's >3 days w/out links
 ;** Called - 2507 C&P INTEG RPT'=OFF
 ;** $D(DVBAFND) - 2507 >3 days old w/out links
 N DVBAX,DVBADAYS
 S:'$D(X) X=""
 S DVBAX=X ;**Save X (prob report var)
 I +$$STYLE^DVBCUTL8(REQDA)=1 DO
 .K X,X1,X2
 .D NOW^%DTC
 .S X2=($P(^DVB(396.3,REQDA,0),U,5)\1),X1=X\1
 .K X D ^%DTC
 .S DVBADAYS=X K X
 .S X=DVBAX ;**Reset X (prob var)
 .I +DVBADAYS>3 DO  ;**2507 >3 days old, check links
 ..N APPTDA S APPTDA=""
 ..K DVBAFND
 ..I +$O(^DVB(396.95,"AR",REQDA,APPTDA))'>0 DO
 ...S:$$TRANCHK^DVBCUTA4(REQDA)=0 DVBAFND="" ;**2507 w/out links
 ..I $D(DVBAFND) DO  ;**Unlinked 2507 >3 days old
 ...S:(+$$RPTCHK=1) ^TMP("DVBA",$J,NAME,DFN)="" ;**TMP("DVBA") - unlinked 2507's
 ...S X=X_"199^"
 K DVBAFND
 Q
 ;
RPTCHK() ;**Check C&P Report Param field - 396.1
 N PARAMDA,PARAMVAL S PARAMDA=0
 S PARAMDA=$O(^DVB(396.1,PARAMDA))
 S PARAMVAL=$P(^DVB(396.1,PARAMDA,0),U,19)
 Q PARAMVAL
 ;
NAMELN W LN,!!,NAME,?28,$P(^DPT(DFN,0),U,9)
 Q
 ;
SETSTYLE ;
 S PARAMDA=0
 S PARAMDA=$O(^DVB(396.1,PARAMDA))
 S STYLEIND=$P(^DVB(396.1,PARAMDA,0),U,15)
 Q
