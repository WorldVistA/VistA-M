DVBCROPN ;ALB/GTS-557/THM-REOPEN REQUEST/SELECTED EXAMS ; 9/22/91  4:54 PM
 ;;2.7;AMIE;**42**;Apr 10, 1995
 I $D(DUZ)#2=0 W *7,!!,"Your user number (DUZ) is invalid !",!! H 3 G EXIT
 S SUPER=$S($D(^XUSEC("DVBA C SUPERVISOR",DUZ)):1,1:0)
 G EN
 ;
LOOK1 S EXAM=$P(^DVB(396.4,DA,0),U,3)
 S EXAM=$S($D(^DVB(396.6,+EXAM,0)):$P(^(0),U,1),1:"Unknown")
 S STAT=$P(^DVB(396.4,DA,0),U,4),^TMP($J,EXAM)=STAT_U_DA
 Q
 ;
EN D HOME^%ZIS S FF=IOF,HD="2507 Exam Veteran Selection",HD2="Re-open Exams/Requests"
 ;
LOOK D KILL W @FF,!?(IOM-$L(HD)\2),HD,!?(IOM-$L(HD2)\2),HD2,!!
 S DIC("W")="D DICW^DVBCUTIL" S DIC="^DVB(396.3,",DIC(0)="AEQM",DIC("A")="Select VETERAN: " D ^DIC G:X=""!(X=U) EXIT I +Y<0 W *7,"  ???" G LOOK
 S (REQDA,DA(1))=+Y,STAT=$P(^DVB(396.3,DA(1),0),U,18),DFN=$P(Y,U,2)
 I STAT="C"!(STAT["X")!(STAT="R")&(SUPER=0) W !!,*7,"Status prohibits activity except by supervisors.",!! H 3 G EN
 S REQDT=$P(^DVB(396.3,DA(1),0),U,2),DATA=$S($D(^DPT(DFN,0)):^(0),1:"")
 S PNAM=$S($P(DATA,U,1)]"":$P(DATA,U,1),1:"Unknown"),SSN=$P(DATA,U,9),CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown") K DICW
 S RELDAT=$P(^DVB(396.3,DA(1),0),U,13)
 F DA=0:0 S DA=$O(^DVB(396.4,"C",DA(1),DA)) Q:DA=""  D LOOK1
 I $P(^DVB(396.3,DA(1),0),U,5)="" DO
 .S TVAR(1,0)="1,0,0,2,0^This 2507 was never reported to MAS, it can NOT be reopened."
 .D WR^DVBAUTL4("TVAR")
 .D CONTMES^DVBCUTL4
 .S NOTRPT=""
 .K TVAR
 G:$D(NOTRPT) LOOK
 S STAT=$P(^DVB(396.3,DA(1),0),U,18) D STATCHK G:$D(NCN) LOOK
 ;
ROPN W !!,"Do you want to reopen the ENTIRE request" S %=2 D YN^DICN G:$D(DTOUT)!(%<0) EXIT G:%=1 ALL
 I $D(%Y),%Y["?" W !,"Enter Y to reopen the ENTIRE request or N to reopen only selected exams.",!! H 1 G ROPN
DATA D HDR^DVBCUTIL K NOFND
 W !!
 S Y=$$EXSRH^DVBCUTL4("Select EXAM TO REOPEN: ","I $D(^DVB(396.4,""ARQ""_REQDA,+Y))") ;*Exam lookup function call
 G:$D(DTOUT) EXIT G:X=""!(X=U) UPDATE I +Y<0 W *7,"  ???" G DATA
 S EXY=+Y,EXMNM=$S($D(^DVB(396.6,+$P(^DVB(396.4,EXY,0),U,3),0)):$P(^(0),U,1),1:"")
 I EXMNM="" W *7,!!,"Exam name not found in file 396.6 !",!! H 2 G EXIT
 S STAT=$P(^TMP($J,EXMNM),U,1) I STAT="O" W *7,!!,"Already open!",!! H 2 G DATA
 D STATCHK G:$D(NCN) DATA
 S DA=EXY,DIE="^DVB(396.4,"
 S DR=".04////O;52///@;51///@;50///@"
 D ^DIE I '$D(Y) W " .. reopened" H 1
 I $D(Y) W *7,"   reopen error !" H 2 G EXIT
 S STAT=$P(^DVB(396.4,EXY,0),U,4),$P(^TMP($J,EXMNM),U,1)=STAT S EDIT=1
 G DATA
UPDATE I $D(EDIT) W @FF D STATUS1^DVBCROP1,BULL
 G LOOK
 ;
EXIT G KILL^DVBCUTIL
 ;
KILL K DIC,DA,ALLROPN,EXAM,REQDA,D0,D1,DFN,X,Y,EXY,OLDEXAM,DR,REQDT,DR,EXMNM,NCN,STAT,%,NOFND,^TMP($J),EDIT,NOTRPT,RELDAT,DATA
 Q
HDR D HDR^DVBCUTIL
 Q
STATCHK S I="",NCN=1 F J=0:0 S I=$O(^TMP($J,I)) Q:I=""  I $P(^TMP($J,I),U,1)["X"!($P(^(I),U,1)="C") K NCN Q
 I $D(NCN) W !!,*7,"There are no cancelled or completed exams remaining on this request.",!! H 3
 Q
ALL W !! D STATCHK G:$D(NCN) LOOK W ! S ALLROPN=1,EXMNM="" F JJY=0:0 S EXMNM=$O(^TMP($J,EXMNM)) Q:EXMNM=""  S STAT=$P(^TMP($J,EXMNM),U,1) I STAT["X"!(STAT="C") S X=EXMNM D ALL1
 H 2 W @FF D STATUS1^DVBCROP1,NOTIFY G EN
ALL1 K DR S DIC(0)="QM",DR=".04////O;52///@;51///@;50///@"
 S (DIC,DIE)="^DVB(396.4,",DA=$P(^TMP($J,EXMNM),U,2)
 D ^DIE I '$D(Y) W:$X>50 ! W:$L(EXMNM)>25&($X>45) ! W EXMNM," reopened, "
 I $D(Y) W *7,!,"Reopen error on ",EXMNM," exam !",! H 2
 Q
NOTIFY S X=$P(^DVB(396.3,DA(1),0),U,18) I X'["X"&(X'="")&(X'="C") W !!,"Entire exam is now REOPENED.",!! H 1
 I X["X"!(X="")!(X="C") W *7,!!,"Reopen error !",!! H 3 S OUT=1 K X Q
 D BULL K X Q
BULL W !!,"Sending a bulletin to the 2507 REOPENED mail group ...",!!
 H 1 S Y=REQDT X ^DD("DD") S XREQDT=Y,XMDUZ=DUZ
 I RELDAT'="" S Y=RELDAT X ^DD("DD") S XRELDAT=Y
 S XMB="DVBA C 2507 EXAM REOPENED",XMB(1)=PNAM,XMB(2)="XXXXX"_$E(SSN,6,9),XMB(3)=XREQDT,XMB(4)=$P(^VA(200,DUZ,0),U,1),XMB(5)=$S(RELDAT'="":XRELDAT,1:"This request has not been released.")
 S XMB(6)=$S(RELDAT="":"     This reopen will not affect the AMIE AMIS 290.",1:"     **THIS REOPEN WILL AFFECT THE AMIE AMIS 290**")
 S XMB(7)=$S(RELDAT'="":"/Affects AMIE AMIS 290",1:"")
 I $D(ALLROPN) S OWNDOM=$P(^DVB(396.3,DA(1),0),U,22) I OWNDOM]"" S XDOM=$S($D(^DIC(4.2,OWNDOM,0)):^(0),1:"") S DOMAIN=$P(XDOM,U,1),DOMNUM=+$P(XDOM,U,3)
 I $D(ALLROPN),OWNDOM]"" I +DOMNUM>0 S XMY("G.DVBA C 2507 EXAM REOPENED@"_DOMAIN)=DOMNUM W !!,*7,"I am sending updated information to "_DOMAIN,!,"since this was transferred in.",!! H 2
 I '$D(^VA(200,DUZ,.15)) S XMY(XMDUZ)="" G XMB
 I $D(^VA(200,DUZ,.15))&($P(^VA(200,DUZ,.15),"^",1)="") S XMY(XMDUZ)="" G XMB
 I $D(^VA(200,DUZ,.15)) S XMY($P(^VA(200,DUZ,.15),"^",1))=""
XMB D ^XMB K XMDUZ
 I $D(ALLROPN),OWNDOM]"",+DOMNUM>0 S REQDA=DA(1) D EN1^DVBCXFRE
 K ALLROPN,CANC,SEND,OWNDOM,DOMNUM,XMB,XREQDT,XDOM,DOMAIN,RELDAT,XRELDAT
 Q
