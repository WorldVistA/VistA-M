PSXRTRAN ;BIR/WPB/PDW-Batch Retransmission Routine ;13 Mar 2002  3:09 PM
 ;;2.0;CMOP;**18,27,31,41,51**;11 Apr 97
 ;Reference to ^PS(59,  supported by DBIA #1976
 ;Reference to ^PS(59.7 supported by DBIA #694
 ;Reference to ^PSRX(   supported by DBIA #1977
 ;
START I '$D(^XUSEC("PSXCMOPMGR",DUZ)) D NO Q
 I '$D(^XUSEC("PSXRTRAN",DUZ)) D NO Q
 I '$D(^XUSEC("PSX XMIT",DUZ)) D NO Q
 D SET^PSXSYS
 I '$D(PSXSYS) W !,"CMOP processing is inactivated, re-transmission of data not allowed." Q
 S PSXJOB=2
 I $D(^PSX(550,"TR","T")) W !,"There is another job in progress, try again later." G EXIT
 L +PSX(550.1):3 I '$T W !,"There is another job in progress, try again later." G EXIT
 I '$D(^PSX(550.2,"AX")) W !!,"No data to re-transmit." G EXIT
 S DIC="^PSX(550.2,",DIC(0)="AMZEQ",DIC("S")="I ($D(^PSX(550.2,""AX"",+Y))),($P($G(^PSX(550.2,+Y,1)),U,3)=""""),($P($G(^PSX(550.2,+Y,1)),U,1)="""")"
 D ^DIC K DIC,DIC("S"),DIC(0)
 G:$D(DTOUT)!($D(DUOUT))!($G(Y)'>0) EXIT
 S OLDBAT=+Y K Y,TRAN,TRANI
 D GETS^DIQ(550.2,OLDBAT,".01;2;3;5;14;17","","TRAN"),TOP^PSXUTL("TRAN") ;external of fields
 D GETS^DIQ(550.2,OLDBAT,".01;2;3;5;14;17","I","TRANI"),TOP^PSXUTL("TRANI") ;internal of fields
 S OLDBATNM=TRAN(.01)
 W !,"Transmission:       "_TRAN(.01)
 W !,"Date:               "_TRAN(5)
 W !,"Division:           "_TRAN(2)
 W !,"Type:               "_TRAN(17)
 W !,"CMOP Host:          "_TRAN(3)
 W !,"Total RXs:          "_TRAN(14)
 S TYP=$S(TRANI(17)="C":"CS",1:"STD")
 S PSXCS=$S(TYP="CS":1,1:0) D SET^PSXSYS
 I TRANI(3)'=+PSXSYS W !!,$$GET1^DIQ(550,+PSXSYS,.01)_" is the active host for transmitting "_TRAN(17) G EXIT
CLOSED S CLOSED=$P($G(^PSX(550.2,OLDBAT,1)),U,1)
 I CLOSED'="" W !,"The transmission selected has been acknowledged and cannot be re-transmitted." D RESET G EXIT
 I $P($G(^PSX(550.2,OLDBAT,1)),U,2)'="" W !!,"This transmission has been re-transmitted once and cannot",!,"be retransmitted again." D RESET G ERRMSG^PSXERR1
 W !!
 S BMSG=$P($G(^PSX(550.2,OLDBAT,1)),U,5)-1,EMSG=$P($G(^PSX(550.2,OLDBAT,1)),U,6),PSOSITE=$P($G(^PSX(550.2,OLDBAT,0)),"^",3)
 S PSXSTART=BMSG+1,PSXDUZ=DUZ,PSXSITE=$P($G(PSXSYS),U,3)
 S SNDR=$$GET1^DIQ(200,$P($G(^PSX(550.2,OLDBAT,0)),U,5),.01)
 S DIV=$P($G(^PS(59,$P($G(^PSX(550.2,OLDBAT,0)),U,3),0)),U,1),Y=$P($G(^PSX(550.2,OLDBAT,0)),U,6) X ^DD("DD") S TRNDT=Y
 W !,"   *** Coordinate re-transmissions with ",$$GET1^DIQ(550,+PSXSYS,.01)," CMOP ***",!
 S DIR(0)="Y^O",DIR("B")="NO",DIR("A")="Are you sure you want to Re-transmit this batch" D ^DIR K DIR
 I Y=0!($D(DIRUT)) D RESET G EXIT
QUE ;
 F YY="PSXMFLAG","BMSG","EMSG","PSXSYS","OLDBAT*","PSXDUZ","PSXJOB","PSXSITE","PSOSITE","PSXSTART","PSXJOB","PSXSITE","TRAN*","PSXCS" S ZTSAVE(YY)=""
 S ZTDTH=$H,ZTSAVE("ZZDATA")="",ZTIO="",ZTRTN="ENTRAN^PSXRTRAN",ZTDESC="CMOP Retransmission"
 D ^%ZTLOAD ;****TESTING
 ;D ENTRAN S PSXSTAT="H" D PSXSTAT^PSXRSYU G EXIT ;****TESTING ;to run in the foreground uncomment this line and comment out the previous line
 I $D(ZTSK)[0 W !!,"Job Cancelled" G EXIT
 E  W !!,"Re-transmission Queued "_ZTSK
 S PSXSTAT="T" D PSXSTAT^PSXRSYU
 G EXIT
TXT I $G(ORD)]"" S LCNT=LCNT+1,^XMB(3.9,XMZ,2,LCNT,0)=ORD
 Q
ENTRAN ;Entry for data transmission
LOCK ; >>>**** LOCK OF FILE 550.1 ****<<<
 F I=1:1:3 L +^PSX(550.1):6 I $T S I=100
 I I'=100 D CANMSG G EXIT ; could not get a lock in 18 minutes of waiting
 K ^TMP($J,"PSX"),^TMP($J,"PSXDFN"),ZCNT,PSXBAT
 S PSOPAR=^PS(59,PSOSITE,1)
 S PSXTDIV=PSOSITE,PSXTYP=$S(+$G(PSXCS):"C",1:"N")
 S PSOLAP=ION,PSOSYS=$G(^PS(59.7,1,40.1)),PSXTRANS=1,PSXFLAG=1
 S PSOINST=+$P(PSXSYS,"^",2)
 S PSXVENDR="AUTOMATED SYSTEM"
 S PSXRTRAN=1,PSXRTRN=1,ZTREQ="@"
RESETRX ; pull, reset RXs from 550.2 RX multiple, if released do not send, make report
 K ^TMP($J,"PSXRTRAN"),LCNT
 S PSXERFLG=0 S PSXFLAG=1,PSXRTRAN=1
 F NI=1:1 Q:'$D(^PSX(550.2,OLDBAT,15,NI,0))  S XX=^(0) D
 . N NI
 . S RXDA=$P(XX,U,1),FILL=$P(XX,U,2),DFN=$P(XX,U,3),REC=$P(XX,U,5)
 . S TEST=$$TESTREL(RXDA,FILL) ; test & catalog RXs for report, 'SENT' if OK, "FILL '=" if more recent fill, 'released date' if released 
 . Q:TEST'="SENT"
 . Q:'$D(^PS(52.5,"B",RXDA))  ;RX pulled early from suspense
 . D RESET^PSXNEW(RXDA,FILL,"Re-Trans of "_OLDBAT)
 . D SDT ;test/set RX into 550.2
 ;
 I '$G(PSXBAT) D NOTRAN G EXIT ;no RXs passed retesting
 I PSXERFLG=1 S PSXJOB=7 D ^PSXERR
 D EN^PSXBLD ; build 550.1 entries related to PSXBAT
 I PSXERFLG=1 S PFLAG=1 D EN^PSXERR
 S OLDSDT=$P($G(^PSX(550.2,OLDBAT,0)),"^",6)
 S PSXSENDR=$$GET1^DIQ(200,PSXDUZ,.01),(SITEN,SITENUM)=$P($G(PSXSYS),U,2),PSXEND=EMSG,PSXDIV=$P($G(^PS(59,+PSOSITE,0)),U,1),XSITE=$P($G(^PS(59,+PSOSITE,0)),U,6)
 S PSXSTART=$O(^PSX(550.1,"C",PSXBAT,0)),(PSXEND,EMSG)=$O(^PSX(550.1,"C",PSXBAT,"A"),-1)
 S PSXBATNM=$$GET1^DIQ(550.2,PSXBAT,.01)
 S PSXHDR=PSXSITE_U_+PSXSYS_U_SITENUM_U_PSXTDT_U_PSXSENDR_U_PSXSTART_U_EMSG_U_PSXDIV_U_XSITE,PSXREF=SITENUM_"-"_PSXBATNM
 N DOMAIN,LCNT,XMDUZ,XMSUB,XMZ,ORD
 S (LCNT,PSXMSGCT,PSXRXCT)=0
 S X=$$KSP^XUPARAM("INST"),DIC="4",DIC(0)="MOXZ" D ^DIC S SITEX=$P(Y,"^",2),XMDUZ=.5 K X,Y,DIC
XMZ S XMSUB="CMOP Retransmission Update from "_SITEX
 D XMZ^XMA2
 I XMZ'>0 H 2 G XMZ
HDR ;Get header data
 S ORD="$$RMIT"_U_PSXBATNM_U_PSXHDR_U_OLDBATNM D TXT
 S PSXTYP=TRANI(17),PSXTDIV=TRANI(2)
 S ORD=$G(PSXORD("A")) D TXT
 S:$G(PSXORD("B",1))="" PSXORD("B",1)="NTE|2||"
 S:$G(PSXORD("C",1))="" PSXORD("C",1)="NTE|3||"
 S:$G(PSXORD("D",1))="" PSXORD("D",1)="NTE|4||"
 F ZZ="B","C","D" S Z=0 F  S Z=$O(PSXORD(ZZ,Z)) Q:Z'>0  S ORD=$G(PSXORD(ZZ,Z)) D TXT
MSG ;Get patient order data
 S (LMSG,MSG)=0
 F  S MSG=$O(^PSX(550.1,"C",PSXBAT,MSG)) Q:MSG'>0  S:$G(MCT)'>0 MCT=MSG S LMSG=MSG,PSXMSGCT=PSXMSGCT+1,LNTX=+$P(^PSX(550.1,MSG,"T",0),U,4) D
 .S ORD="$MSG^"_+$G(^PSX(550.1,MSG,0))_U_LNTX D TXT
 .F PSX=1:1:LNTX I $G(^PSX(550.1,MSG,"T",PSX,0))]"" S ORD=$G(^(0)) S:$E(ORD,1,7)="ORC|NW|" PSXRXCT=PSXRXCT+1 D TXT
 .S DA=MSG,DIE="^PSX(550.1,",DR="1///2;5////"_$H_";3////"_PSXBAT D ^DIE K DIE,DA,DR
 .S REC=MSG,PSXRTRN=1 ;D SUSPS^PSXRXU
 S ORD="$$ENDRMIT^"_U_U_PSXBATNM_U_PSXMSGCT_U_PSXRXCT D TXT K ORD
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_U_LCNT_U_DT,XMDUN="CMOP Manager"
 S XMDUZ=.5
 S RECV=$P($G(^PSX(550,+PSXSYS,0)),U,4),DOMAIN="@"_$$GET1^DIQ(4.2,RECV,.01)
 ;code to divert patient transmissions for testing
 I '$D(^XTMP("PSXDIVERTCMOP")) S XMY("S.PSXX CMOP SERVER"_DOMAIN)="" I 1 ;****TESTING
 E  S XX=^XTMP("PSXDIVERTCMOP",1) S XMY(XX)="" H 1 ;****TESTING S.PSXX
 D ENT1^XMD
 K DIE,DA,DR,BAT,PSX,PSXORD
FILE L +^PSX(550.2,PSXBAT):30 G:'$T FILE
 D NOW^%DTC S PSXTRDTM=%
 S PSXLAST=LMSG,PSXFRST=MCT,DA=PSXBAT,DIE="^PSX(550.2,"
 S DR="1////2;9////"_OLDBAT_";11////"_PSXFRST_";12////"_PSXLAST_";13////"_PSXMSGCT_";14////"_PSXRXCT_";5////"_PSXTRDTM D ^DIE
 L -^PSX(550.2,PSXBAT) K DA,DIE
F1 L +^PSX(550.2,OLDBAT):30 G:'$T F1
 S DA=OLDBAT,DIE="^PSX(550.2,",DR="1////5;8////"_PSXBAT D ^DIE
 L -^PSX(550.2,OLDBAT) K DA,DIE
 S PSXOLD=OLDBAT
 D AFTER1^PSXRSYU ;set PSXBAT into 550
 S PSXFLAG=1,PSXRTRN=1
 D EN^PSXNOTE
 S OLDBAT=PSXOLD
 D START^PSXRXU ;update RXs in 52.5 & 52
 D OERRCLR^PSXRSUS
 S OLDBAT=PSXOLD
 D SETSTAT^PSXRTRA1
 D REPORT^PSXRTRA1
RESET S PSXSTAT="H" D PSXSTAT^PSXRSYU
 G EXIT
 Q
NO W !,"You are not authorized to use this option!" Q
EXIT S ZTREQ="@"
 L -^PSX(550.1)
 K PSXSTART,PSXEND,PSXRXCT,PSXMSGCT,PSXLAST,PSXSITE,PSXTDT,LASTBAT,LCNT,CNTX,MSG,REC,SITENUM,XQAMSG,XX,XMY,XMSUB,XMFROM,XMZ,XMDUZ,XMDUN,LNCT,OLDBAT,PSXMFLAG,FLAG,PSXSENDR,BMSG,EMSG,RECV,DOMAIN,CLOSED,PSXDIV,XSITE
 K %,DIV,LNTX,SNDR,STATUS,TRNDT,Z,ZZ,PSXHDR,PSXJOB,PSXRTRN,PSXSTAT,PSXFRST,PSXBAT,PSXDUZ,PSXFLAG,DIR,Y,X,OLDSDT,S1,Y,DIRUT,DIROUT,DTOUT,DUOUT,BAD,MCT,LMSG,PSXOLD,PSXRXD
 K ^PSX("CMOP TRANS"),PSXBATNM,OLDBATNM,TRAN,TRANI,PSXTRDTM,I
 K ^TMP($J)
 Q
CANMSG ; lock on 550.1 not achieved send transmission cancelled message
 D CANMSG^PSXRTRA1
 Q
TESTREL(RXDA,FILL) ; test release date, gather RX data, store for report
 ;returns SENT, "FILL '=", or Released Date
 N DFN,VADM,SSN,RELDT,RELDTE,PATNM,REPLY,FILLX
 S DFN=$$GET1^DIQ(52,RXDA,2,"I"),PATNM=$$GET1^DIQ(52,RXDA,2)
 D DEM^VADPT S SSN=$P(VADM(2),U,2)
 S RXNM=$P(^PSRX(RXDA,0),U)_"-"_FILL
 I FILL=0 S RELDT=$P(^PSRX(RXDA,2),U,13)\1 I 1
 E  S RELDT=$P(^PSRX(RXDA,1,FILL,0),U,18)\1
 S REPLY="SENT"
 S:RELDT REPLY=$$FMTE^XLFDT(RELDT)
 S FILLX=+$O(^PSRX(RXDA,1,"A"),-1) I FILL'=FILLX S REPLY="Fill '= "_FILLX
 Q REPLY
NOTRAN ;no RXs passed testing to go into a new transmission
 S XMSUB="Retransmission of "_OLDBATNM_" failed"
 K TXT,XMY
 S TXT(1,0)="No prescriptions passed testing to go into a new transmission"
 S XMTEXT="TXT("
 D GRP^PSXNOTE
 D ^XMD
 Q
SDT ;functional code as to SDT^PSXRPPL test and set individual RXs into 550.2
 N SDT
 S REC=$O(^PS(52.5,"B",RXDA,0)) Q:'REC
 S XX=^PS(52.5,REC,0),SDT=$P(XX,U,2)
 S XDFN=DFN
 N RXN,RXDA,FILL
 D GETDATA^PSXRPPL ;if RX is OK makes entry into new batch PSXBAT
 D:$G(RXN) PSOUL^PSSLOCK(RXN),OERRLOCK^PSXRPPL(RXN)
 Q
