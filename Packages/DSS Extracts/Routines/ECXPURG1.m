ECXPURG1 ;BIR/CML-Purge of DSS Extract Files (CONTINUED) ; 10/2/08 10:48am
 ;;3.0;DSS EXTRACTS;**2,9,8,24,49,102,112**;Dec 22, 1997;Build 26
GET ;compile list of purgable extracts
 K HI,LO,ECBDT,ECEDT,ECLOC,^TMP("ECXPURG",$J)
 S QFLG=1 W !!,"...one moment please"
 S ECEX=0 F  S ECEX=$O(^ECX(727,ECEX)) Q:'ECEX  I '$G(^ECX(727,ECEX,"PURG")),$D(^ECX(727,ECEX,0)) S EC=^(0) D
 .S ^TMP("ECXPURG",$J,$P(EC,U,3),ECEX)="",ECLOC(ECEX)=$P(EC,U,3)_U_$P(EC,U,4,5)
 I '$D(^TMP("ECXPURG",$J)) W !!,"There are no extracts that can be purged at this time." G DONE
ASK1 ;ask for print
 W !
 K DIR S DIR(0)="Y",DIR("A")="Do you want to print a list of extracts that can be purged",DIR("B")="NO"
 D ^DIR K DIR I $D(DIRUT) K ECLOC G DONE
 G:'Y ASK2
 W !!,"The right margin for this report is 80.",!!
 K ZTSAVE S ZTSAVE("^TMP(""ECXPURG"",$J,")=""
 D EN^XUTMDEVQ("PRT^ECXPURG1","DSS - Print Purgable Extracts",.ZTSAVE) I 'POP G ASK2
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
ASK2 ;ask for extract range
 ;
 ;** Check divisions for purging
 N ECCHK,ECTMP
 S ECCHK=$$DIV4^XUSER(.ECTMP,DUZ)
 I 'ECCHK DO
 .W !,"You do not have any divisions defined in your user set up and can not purge."
 .S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 .K ECLOC
 ;
 I 'ECCHK G DONE  ;** (essentially) QUIT out of middle
 ;
 W !,"You will not be able to select an extract that is not from your division.",!
 S LO=$O(ECLOC(0)),HI=$O(ECLOC(" "),-1)
 S DIR(0)="L^"_LO_":"_HI_"",DIR("A")="Select extracts to be purged"
 S DIR("?",1)="Choose the number(s) of the extract(s) you wish to purge,",DIR("?")="(e.g. 1-3,17,20 to choose 1 thru 3, 17, and 20)."
 W ! D ^DIR K DIR I $D(DIRUT) K ECLOC G DONE
 S JJ=0,Y=","_Y F  S JJ=$O(ECLOC(JJ)) Q:'JJ  S JZ=","_JJ_"," I Y'[JZ K ECLOC(JJ)
 D CBOCCHK(.ECLOC) I '$D(ECLOC) G GET
 D DIVCHK(.ECLOC,.ECTMP)
 I '$D(ECLOC) W !!,"You have not chosen a valid extract number.  Try again." G GET
ASK3 W !!,"I will purge the following extract(s):"
 S JJ=0 F  S JJ=$O(ECLOC(JJ)) Q:'JJ  D
 .W !?5,"#",JJ," - ",$P(ECLOC(JJ),U)
 .W ?47,$TR($$FMTE^XLFDT($P(ECLOC(JJ),U,2),"5DF")," ","0")," to ",$TR($$FMTE^XLFDT($P(ECLOC(JJ),U,3),"5DF")," ","0")
 W !! K DIR S DIR(0)="Y",DIR("A")="Is this OK",DIR("B")="NO"
 S DIR("?",1)="    Enter:"
 S DIR("?",2)="      ""YES"" if you agree with this list and would like to proceed,"
 S DIR("?",3)="       ""NO"" if you would like to make a different selection, or"
 S DIR("?")="        ""^"" to exit option."
 D ^DIR K DIR I $D(DIRUT) K ECLOC G DONE
 I 'Y G GET
 ; at this point, the local array ECLOC( is passed back to ^ECXPURG
 G DONE
QUIT ;
 I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
DONE K ^TMP("ECXPURG",$J),ZTSK Q
PRT ;print list of extracts
 S (PG,QFLG)=0,$P(LN,"-",81)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D HDR
 S ECTYP="" F  S ECTYP=$O(^TMP("ECXPURG",$J,ECTYP)) Q:ECTYP=""  Q:QFLG  D:$Y+4>IOSL HDR Q:QFLG  W !!,ECTYP D
 .S ECEX=0 F  S ECEX=$O(^TMP("ECXPURG",$J,ECTYP,ECEX)) Q:'ECEX  Q:QFLG  I $D(^ECX(727,ECEX,0)) S EC=^(0) D
 ..S ECDT=$$FMTE^XLFDT($P(EC,U,2),"D")
 ..S ECFR=$TR($$FMTE^XLFDT($P(EC,U,4),"5DF")," ","0")
 ..S ECTO=$TR($$FMTE^XLFDT($P(EC,U,5),"5DF")," ","0")
 ..S ECRC=$P(EC,U,6) S:ECRC="" ECRC="Incomplete"
 ..S ECTRN=$$FMTE^XLFDT($G(^ECX(727,ECEX,"TR")),"D")
 ..S ECXDIV=$P($G(^ECX(727,ECEX,"DIV")),U,1) I ECXDIV D
 ...K ECXDIC S DA=ECXDIV,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 ...D EN^DIQ1 S ECXDIV=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 ..D:$Y+3>IOSL HDR Q:QFLG
 ..W !?1,ECEX,?11,ECDT,?25,ECFR,"-",ECTO,?48,$J(ECRC,9),?60,ECTRN,?75,ECXDIV
 G QUIT
HDR ;HEADER
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !,"PURGABLE EXTRACTS",?72,"Page: ",PG,!,"Printed on ",HDT,!
 W !,"FEEDER SYS",?12,"EXTRACT,",!,"EXTRACT #",?12,"DATE",?33,"FROM-TO",?48,"RECORD CNT",?60,"TRANSMIT DATE",?75,"DIV",!,LN
 Q
DATES ;ask for date range for purge of holding files
 K HI,LO,ECBDT,ECEDT
 I ECY="I" D
 .I '$O(^ECX(728.113,0)) W !!,"You have no data in the IVP holding file (file #728.113) to purge." Q
 .S LO=$O(^ECX(728.113,"A",0)),HI=$O(^ECX(728.113,"A"," "),-1)
 I ECY="U" D
 .I '$O(^ECX(728.904,0)) W !!,"You have no data in the UDP holding file (file #728.904) to purge." Q
 .S LO=$O(^ECX(728.904,"A",0)),HI=$O(^ECX(728.904,"A"," "),-1)
 I ECY="V" D
 .I '$O(^VBEC(6002.03,0)) W !!,"You have no data in the VBECS holding file (file #6002.03) to purge." Q
 .S LO=$O(^VBEC(6002.03,"C",0)),HI=$O(^VBEC(6002.03,"C"," "),-1)
 Q:$G(LO)=""
 W @IOF,!!,"This file currently holds ",$S(ECY="I":"IVP",ECY="U":"UDP",1:"VBECS")," data from <",$$FMTE^XLFDT(LO,"D"),"> to <",$$FMTE^XLFDT(HI,"D"),">."
 W ! K DIR S DIR(0)="DA^"_LO_":"_HI_":EPX",DIR("A")="Beginning date for purge: " D ^DIR K DIR I $D(DIRUT) K HI,LO Q
 S ECBDT=+Y
 K DIR S DIR(0)="DA^"_ECBDT_":"_HI_":EPX",DIR("A")="Ending date for purge: " D ^DIR K DIR I $D(DIRUT) K HI,LO,ECBDT Q
 S ECEDT=+Y
ASK4 ; ask to confirm date range
 W !!,"I will purge the ",$S(ECY="I":"IVP",ECY="U":"UDP",1:"VBECS")," holding file from <",$$FMTE^XLFDT(ECBDT,"D"),"> to <",$$FMTE^XLFDT(ECEDT,"D"),">."
 W !! K DIR S DIR(0)="Y",DIR("A")="Is this OK",DIR("B")="NO"
 S DIR("?",1)="    Enter:"
 S DIR("?",2)="      ""YES"" if you agree with this date range and wish to proceed,"
 S DIR("?",3)="       ""NO"" if you would like to make a different selection, or"
 S DIR("?")="        ""^"" to exit option."
 D ^DIR K DIR I $D(DIRUT) K ECBDT,ECEDT Q 
 I 'Y G DATES
 ; at this point, ECBDT and ECEDT are passed back to ^ECXPURG
 Q
 ;
DIVCHK(ECLOC,ECTMP) ;**Remove extracts from ECLOC that are for user's div.
 N ECLPDA
 S ECLPDA=0
 F  S ECLPDA=$O(ECLOC(ECLPDA)) Q:(+ECLPDA=0)  DO
 .I '$D(ECTMP($P(^ECX(727,ECLPDA,"DIV"),U,1))) KILL ECLOC(ECLPDA)
 Q
CBOCCHK(ECLOC) ;**Check that CBOC report has been viewed prior to purging
 N LOOPDA,YYYMMDD
 S LOOPDA=0
 F  S LOOPDA=$O(ECLOC(LOOPDA)) Q:(+LOOPDA=0)  D
 .I ^ECX(727,LOOPDA,"HEAD")="CLI" D
 ..S DA(1)=1
 ..S YYYMMDD=$P(^ECX(727,LOOPDA,0),U,4)
 ..I YYYMMDD>3030930 I '$D(^ECX(728,DA(1),"CBOC","B",LOOPDA)) D
 ...K DIR S DIR(0)="Y",DIR("A")="The CBOC Activity Report has not been viewed.  Purge anyway",DIR("B")="NO"
 ...D ^DIR K DIR I 'Y K ECLOC(LOOPDA)
 Q
