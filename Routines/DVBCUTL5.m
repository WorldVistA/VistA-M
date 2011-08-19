DVBCUTL5 ;ALB/GTS-AMIE C&P APPT LINK USER SEL RTNS ; 10/20/94  1:00 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
REQARY ;** Create Array of 2507's for veteran
 ;
 ;** If 2507 status=DVBASTAT, set node in ^TMP("DVBC",$J)
 ;**  ^TMP("DVBC",$J) ordered from newest to oldest 2507
 ;**  The following variables must be KILLed by the calling routine:
 ;**   DVBAMORE, DVBALP, DVBAOUT, DVBADTOT, DVBAPNAM,DVBADA,DVBADFN
 ;**   DVBADT,DVBAORD
 ;**  NOTE: DVBASTAT must be defined before REQARY entry
 S DVBACNT=0
 ;
 ;**  If entered from INSUF^DVBCLOG or DVBCMKLK and open
 ;**   exam on current 2507, Set ^TMP
 F  S DVBADA=$O(^DVB(396.3,"B",DVBADFN,DVBADA)) Q:DVBADA=""  DO
 .I $P(^DVB(396.3,DVBADA,0),U,18)=DVBASTAT DO
 ..S DVBAOPEN=$$OPENCHK(DVBADA) I +DVBAOPEN'>0 K DVBAOPEN
 ..I '$D(DVBASDPR)!($D(DVBASDPR)&($D(DVBAOPEN))) DO
 ...K DVBAOPEN
 ...S DVBADT=$P(^DVB(396.3,DVBADA,0),"^",2),DVBACNT=DVBACNT+1
 ...S ^TMP("DVBC",$J,9999999.999999-DVBADT,DVBADT,DVBADA)=""
 Q
 ;
REQSEL ;** Select 2507
 ;
 ;**  Loop ^TMP array, display 2507's in groups of 5
 ;**  ^TMP subscripts:
 ;**    ^TMP("DVBC",$J,9999999.999999-2507 Request date int,
 ;**         Request date int, Request DA)
 W !!,"Select a 2507 request",!
 S DVBAORD=""
 S DVBAPNAM=$P(^DPT(DVBADFN,0),"^",1)
 F DVBALP=1:1 S DVBAORD=$O(^TMP("DVBC",$J,DVBAORD)) Q:DVBAORD=""  DO
 .S (DVBADT,DVBADA)=""
 .S DVBADT=$O(^TMP("DVBC",$J,DVBAORD,DVBADT))
 .S DVBADA=$O(^TMP("DVBC",$J,DVBAORD,DVBADT,DVBADA))
 .K Y S Y=DVBADT X ^DD("DD")
 .W !,?5,DVBALP,?8," ",DVBAPNAM,?40,"  Request date: ",Y
 .S DVBAMORE=$O(^TMP("DVBC",$J,DVBAORD))
 .I +DVBAMORE'>0 D SELREQ ;**No more entries
 .I (+DVBAMORE>0)&(DVBALP#5=0) DO  ;**More entries exist, 5 displayed
 ..W !,"ENTER '^' TO STOP, OR"
 ..D SELREQ
 Q
 ;
FINDDA ;** Loop ^TMP, get 396.3 DA
 F DVBALP=1:1:DVBASEL S DVBAORD=$O(^TMP("DVBC",$J,DVBAORD)) DO
 .S (DVBADT,DVBADA)=""
 .S DVBADT=$O(^TMP("DVBC",$J,DVBAORD,DVBADT))
 .S DVBADA=$O(^TMP("DVBC",$J,DVBAORD,DVBADT,DVBADA))
 Q
 ;
SELREQ ;** Select 2507 from ^TMP
 K DVBAOUT
 S DIR(0)="NOA^1:"_DVBALP_"^K:X[""."" X"
 S DIR("?")="Select a 2507 request by entering it's associated number"
 S DIR("A")="CHOOSE 1-"_DVBALP_": " D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S DVBAORD="9999999.999999",DVBAOUT=""
 I '$D(DTOUT)&('$D(DUOUT)) S:+Y>0 DVBAORD="9999999.999999"
 S:$D(DTOUT) DVBADTOT=""
 W !
 K DTOUT,DUOUT,DIR
 Q
 ;
OPENCHK(REQDA) ;** Check for open exam on 2507
 N LPDA,QVAR
 S LPDA=""
 F  S LPDA=$O(^DVB(396.4,"C",REQDA,LPDA)) Q:'LPDA!($D(QVAR))  DO
 .I $P(^DVB(396.4,LPDA,0),U,4)="O" DO
 ..S:'$D(QVAR) QVAR=LPDA
 S:'$D(QVAR) QVAR=""
 Q +QVAR
 ;
REQPAT() ;** Select patient who has 2507's
 S DIC(0)="AEMQ",DIC("A")="Select C&P Veteran Name: ",DIC="^DPT("
 S DIC("S")="I $D(^DVB(396.3,""B"",+Y))" D ^DIC K DIC
 Q +Y
 ;
CPPATARY(DVBADFN) ;** Set ^TMP of 2507's for vet
 ;
 ;**  ^TMP array ordered newest to oldest
 ;**  DVBACNT to be killed by calling routine
 N REQDA,REQDT
 S DVBACNT=0
 S REQDA=""
 F  S REQDA=$O(^DVB(396.3,"B",DVBADFN,REQDA)) Q:REQDA=""  DO
 .I +$P(^DVB(396.3,REQDA,0),U,2)>0,($P(^DVB(396.3,REQDA,0),U,18)'="N") DO
 ..I $P(^DVB(396.3,REQDA,0),U,18)'="" DO
 ...S REQDT=$P(^DVB(396.3,REQDA,0),"^",2),DVBACNT=DVBACNT+1
 ...S ^TMP("DVBC",$J,9999999.999999-REQDT,REQDT,REQDA)=""
 Q
 ;
NO2507 ;** 2507 not selected, error
 S DIR("A",1)="You have not selected a 2507 request to link a C&P appointment to."
 S DIR("A",2)="This is required to continue processing with the AMIE link management option."
 S DIR("A",3)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 Q
 ;
SDEVTSPC(DVBAPCE) ;**Return piece of 'S' node in Sched event
 N DVBASPCV
 S DVBASPCV=""
 S:($D(^TMP("SDEVT",$J,SDHDL,1,"DPT",0,"AFTER"))) DVBASPCV=$P(^TMP("SDEVT",$J,SDHDL,1,"DPT",0,"AFTER"),U,DVBAPCE)
 Q DVBASPCV
 ;
SDEVTXST() ;** Check ^TMP("SDEVT",$J) existence
 Q $D(^TMP("SDEVT",$J,SDHDL,1,"DPT",0,"AFTER"))
 ;
SDORGST() ;** Return value of SD Event originating process
 N DVBAVAR
 S DVBAVAR=""
 Q $O(^TMP("SDEVT",$J,SDHDL,DVBAVAR))
 ;
