DVBCPND1 ;ALB/GTS-557/THM,SBW-2507 PENDING REQUESTS, PART 2 ; 3/MAY/2011
 ;;2.7;AMIE;**17,168**;Apr 10, 1995;Build 3
 ;
NXT F DA(1)=0:0 S DA(1)=$O(^TMP($J,JX,PNAM,DFN,DA(1))) Q:DA(1)=""  D PRINT I $D(OUT) S DA(1)="",PNAM="ZZZZ",JX=$S($A(JX)>57:PNAM,1:999999)
 Q
 ;
SORT S STAT=$P(^DVB(396.3,REQDA,0),U,18) Q:"^R^X^RX^C^CT^"[(U_STAT_U)  I DVBCSORT="S" Q:STAT'=RSTAT&(RSTAT'="A")
 S PNAM=$S($D(^DPT(DFN,0)):$P(^(0),U,1),1:"Unknown"),ROUT=$S($D(^DVB(396.3,REQDA,1)):$P(^(1),U,4),1:0),RDATE=$P(^(0),U,5)
 I DVBCSORT="V" S ^TMP($J,PNAM,DFN,REQDA)="" Q
 I DVBCSORT="S" S ^TMP($J,STAT,PNAM,DFN,REQDA)="" Q
 I DVBCSORT="R",$D(ADIVNUM),ROUT=ADIVNUM S ^TMP($J,ROUT,PNAM,DFN,REQDA)="" Q
 I DVBCSORT="A" D ELAPSED I EDAYS'<ERDAYS,EDAYS'>OLDAYS S ^TMP($J,EDAYS,PNAM,DFN,REQDA)=""
 Q
 ;
SETUP K ^TMP($J) S DVBCDT(0)=$$FMTE^XLFDT(DT,"5DZ"),PG=0
 S HEAD="Pending 2507 Requests for "_$S($D(^DVB(396.1,1,0)):$P(^(0),U,1),1:"Unknown site"),HEAD2="",PROCDT="Processed on: "_DVBCDT(0),NODATA=0 U IO D HEADER
 ;
DATA S DFN="" F J=0:0 S DFN=$O(^DVB(396.3,"B",DFN)) Q:DFN=""  F REQDA=0:0 S REQDA=$O(^DVB(396.3,"B",DFN,REQDA)) Q:REQDA=""  D SORT
 I DVBCSORT="V" S PNAM="" F I=0:0 S PNAM=$O(^TMP($J,PNAM)) Q:PNAM=""  F DFN=0:0 S DFN=$O(^TMP($J,PNAM,DFN)) Q:DFN=""  F DA(1)=0:0 S DA(1)=$O(^TMP($J,PNAM,DFN,DA(1))) Q:DA(1)=""  D PRINT I $D(OUT) S DA(1)="",PNAM="ZZZ" Q
 I DVBCSORT="R"!(DVBCSORT="A") S PNAM="" F JX=-1:0 S JX=$O(^TMP($J,JX)) Q:JX=""  F I=0:0 S PNAM=$O(^TMP($J,JX,PNAM)) Q:PNAM=""  F DFN=0:0 S DFN=$O(^TMP($J,JX,PNAM,DFN)) Q:DFN=""  D NXT
 I DVBCSORT="S" S (PNAM,JX)="" F ZX=0:0 S JX=$O(^TMP($J,JX)) Q:JX=""  F I=0:0 S PNAM=$O(^TMP($J,JX,PNAM)) Q:PNAM=""  F DFN=0:0 S DFN=$O(^TMP($J,JX,PNAM,DFN)) Q:DFN=""  D NXT
 D:$Y>60 HEADER I DVBCCNT>0 W !!,"Total pending: ",DVBCCNT,!
 I IOST?1"C-".E W !!,"Press RETURN  " R ANS:DTIME
 ;
EXIT I NODATA=0 U IO W *7,!!!!!,"No pending requests found for selected parameters.",!! H 2
 ;
KILL D:$D(ZTQUEUED) KILL^%ZTLOAD K ANS,JX,DVBCHDR,^TMP($J) G KILL^DVBCUTIL
 ;
PRINT S ADIV=$S($D(^DVB(396.3,DA(1),1)):$P(^(1),U,4),1:"") Q:ADIV'=ADIVNUM&(DVBCSORT="R")  I ADIV]"" S ADIV=$S($D(^DG(40.8,+ADIV,0)):$P(^(0),U,1),1:"Unknown Division")
 S RDATE1=$P(^DVB(396.3,DA(1),0),U,2),RDATE=$P(^(0),U,5),SSN=$P(^DPT(DFN,0),U,9),CNUM=$S($D(^(.31)):$P(^(.31),U,3),1:"Unknown") D ELAPSED
 S STATUS="Unknown" W !?10,"Division: "_ADIV,!?12,"Status: " S XX=$P(^DVB(396.3,DA(1),0),U,18),STATUS=$S(XX="N":"New",XX="P":"Pending, reported",XX="S":"Pending, scheduled",XX="R":"Released to RO, not printed",1:"")
 I STATUS="",$D(XX) S STATUS=$S(XX="C":"Completed, printed by RO",XX="X":"Cancelled by MAS",XX="RX":"Cancelled by RO",XX="T":"Transcribed",XX="NT":"New,Transferred in",XX="CT":"Completed, Transferred out",1:"Unknown")
 W STATUS,!!,PNAM,?49,"SSN: ",SSN,!?44,"Claim no: ",CNUM,!?40,"Request date: ",$$FMTE^XLFDT(RDATE1,"5DZ"),!?40,"Elapsed days: ",EDAYS,!!
 S X=$S($D(^DVB(396.3,DA(1),4)):^(4),1:"")
 S OWNDOM=$P(^DVB(396.3,DA(1),0),U,22) I OWNDOM]"" W "Transferred in from ",$S($D(^DIC(4.2,+OWNDOM,0)):$P(^(0),U,1),1:"Unknown site"),!
 W !?5,"Exams requested:",!!
 ;
ITEMS ;
 N DVBPALL
 S DVBPALL=1
 D TST^DVBCUTL2 S NODATA=1,REQSTR=+$P(^DVB(396.3,DA(1),0),U,4)
 W !!,"Requested by: ",$S($D(^VA(200,+REQSTR,0)):$P(^(0),U,1),1:" (Not specified) ")," at "
 S RONAME=$P(^DVB(396.3,DA(1),0),U,3),RONAME=$S(RONAME]"":$P(^DIC(4,+RONAME,0),U,1),1:"") W $S(RONAME]"":RONAME,1:" (Not specified) "),! F L=1:1:79 W "-"
 S DVBCCNT=DVBCCNT+1 I IOST?1"C-".E K OUT W !!!,"Press RETURN to continue or ""^"" exit  " R ANS:DTIME S:'$T!(ANS=U) OUT=1 Q:$D(OUT)  D HEADER Q
 W ! I $Y>45 D HEADER
 Q
 ;
HEADER S PG=PG+1 W @IOF,!!
 W ?(80-$L(HEAD)\2),HEAD,?71,"Page: ",PG,!?(80-$L(DVBCHDR)\2),DVBCHDR,!! I HEAD2]"" W ?(80-$L(HEAD2)\2),HEAD2,!
 W ?(80-$L(PROCDT)\2),PROCDT,!?(80-$L(HEAD3)\2),HEAD3,! F LN=1:1:80 W "="
 W !!
 Q
 ;
ELAPSED K EDAYS,X1,X2,X S X1=DT,(X2,X)=RDATE D:ELTYP="C" ^%DTC D:ELTYP="W" ^XUWORKDY S EDAYS=X
