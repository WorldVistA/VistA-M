RCCPCSTM ;WASH-ISC@ALTOONA,PA/LDB-Patient Statement ;2/14/97  5:12 PM
V ;;4.5;Accounts Receivable;**70,219**;Mar 20, 1995;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;ENTRY FROM NIGHTLY PROCESS
 NEW HDAT,DEB
STM ;called by RCCPCPS to print >32K at site
 NEW DAT,END,LDT1,LDT3,SDT,SITE,PRNT,X1,X2 S COMM=0
 D DT^DICRW,SITE^PRCAGU
 S:$G(HDAT)="" HDAT=DT S SDT=+$E(HDAT,6,7),DAT=HDAT
 D NOW^%DTC S END=%
 S LDT1=$$FPS^RCAMFN01(HDAT,-1)
 S LDT3=$$FPS^RCAMFN01(HDAT,-3)
 S DEB=0 F  S DEB=$O(^XTMP("RCCPC",DEB)) Q:'DEB  D STS
 K ^XTMP("RCCPC")
 Q
STS ;start statement process
 NEW BBAL,BEG,PBAL,PDAT,PEND,SBAL,SDT,TBAL,X,Y
 K ^TMP("PRCAGT",$J)
 D NOW^%DTC S END=%
 S BEG=+$$LST^RCFN01(DEB,2) I $P(BEG,".")'<$P(DAT,".") G STSQ ;statement printed on or after this date
 I BEG<1 S PDAT="",BEG=0,PBAL=0 ;get last date/time event occurred
 I BEG S PDAT=BEG,BEG=9999999.999999-BEG,PBAL=0 D PBAL^PRCAGU(DEB,.BEG,.PBAL) ;Get previous bal and prev date of last transaction
 D EN^PRCAGT(DEB,BEG,.END) ;get transactions reset END to last tran
 S TBAL=0 D TBAL^PRCAGT(DEB,.TBAL) ;get trans bal
 S BBAL=0 D BBAL^PRCAGU(DEB,.BBAL) ;get bill bal
 S X=$$PRE^PRCAGU(DEB) S PEND=$P(X,U,2),X=+X I X,BBAL D REF^PRCAGD(DEB,X,$G(REP)) G STSQ ;unprocessed refund and outstand bills send disc
 I BBAL=0,PEND,-PEND=PBAL+TBAL G STSQ ;all of the amount due is prepayment pending or refund review status
 I BBAL'=(PBAL+TBAL) D EN^PRCAGD(DEB,BBAL,TBAL,PBAL,BEG,$G(REP)) G STSQ ;send disc
 I BBAL=0,$G(SITE("ZERO")) G STSQ ;zero balance
 I BBAL'>0,'$D(^TMP("PRCAGT",$J,DEB)) G STSQ ;no amt due no activity
 I BBAL<0,BBAL>-.99 G STSQ ;refund less than 1.00
 I BBAL'<0,'$D(^XTMP("PRCAGU",$J,DEB)),'COMM G STSQ ;third letter printed,not comment
 S TBAL=TBAL+PBAL
 D EN^PRCAGST(DEB,.TBAL,PDAT,PBAL) S SITE("SCAN")="" ;print statement
 D EN^PRCAGF(DEB,TBAL) S ERR="" ;get forms and print
 D OPEN^RCEVDRV1(2,$P(^RCD(340,DEB,0),U),END,DUZ,$$SITE^RCMSITE,.ERR,.EVN,BBAL("PB")_U_BBAL("INT")_U_BBAL("ADM")_U_BBAL("CT")_U_BBAL("MF"))
 I EVN D CLOSE^RCEVDRV1(EVN)
 D UPDAT^PRCAGU(DEB,DT) ;set bill letter field
 S SITE("SCAN")=$G(^RC(342,1,5))
STSQ ;
 K ^XTMP("PRCAGU",$J),COMM
 Q
