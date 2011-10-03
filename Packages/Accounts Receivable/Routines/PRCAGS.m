PRCAGS ;WASH-ISC@ALTOONA,PA/CMS-Patient Statement ;6/19/96  5:12 PM
V ;;4.5;Accounts Receivable;**34,78**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ENTRY FROM NIGHTLY PROCESS
 NEW HDAT,DEB
EN ;entry from patient statement option
 NEW %,%H,%I,DAT,END,LDT1,LDT3,SDT,SITE,PRNT,X,X1,X2,Y
 D DT^DICRW,SITE^PRCAGU
 I '$D(SITE) D  Q
 .   D NOW^%DTC S Y=% D DD^%DT
 .   W !!,"AR SITE PARAMETER ENTRIES NOT DEFINED!",?46,Y,!!,"COULD NOT PROCESS AR PATIENT STATEMENTS"
 ;
 S:$G(HDAT)="" HDAT=DT S SDT=+$E(HDAT,6,7)
 D NOW^%DTC S END=%
 S LDT1=$$FPS^RCAMFN01(HDAT,-1)
 S LDT3=$$FPS^RCAMFN01(HDAT,-3)
 ;I $G(DEB) S DAT=HDAT D STS G ENQ ;if comming in thru option.
 ;F DEB=0:0 S DEB=$O(^RCD(340,"AC",SDT,DEB)) Q:'DEB  I $P(^RCD(340,DEB,0),U,1)["DPT" S DAT=HDAT D STS
 F DEB=0:0 S DEB=$O(^RCD(340,"AC",SDT,DEB)) Q:'DEB  I $P(^RCD(340,DEB,0),U,1)'["DPT" D
 .S DAT=$$LST^RCFN01(DEB,10) I $P(DAT,".")'<$P(HDAT,".") Q
 .S PRNT="FL",SB="" D EN^PRCAGF(DEB,SB,.PRNT) I PRNT D UPDAT^PRCAGU(DEB,HDAT),BEVN^PRCAGU(DEB,HDAT)
ENQ K DAT,DEB,^TMP("PRCAGT",$J)
 Q
STS ;start statement process
 ;NEW BBAL,BEG,PBAL,PDAT,PEND,SBAL,SDT,TBAL,X,Y
 ;K ^TMP("PRCAGT",$J)
 ;D NOW^%DTC S END=%
 ;S BEG=+$$LST^RCFN01(DEB,2) I $P(BEG,".")'<$P(DAT,".") G STSQ ;statement printed on or after this date
 ;I BEG<1 S PDAT="",BEG=0,PBAL=0 ;get last date/time event occurred
 ;I BEG S PDAT=BEG,BEG=9999999.999999-BEG,PBAL=0 D PBAL^PRCAGU(DEB,.BEG,.PBAL) ;Get previous bal and prev date of last transaction
 ;D EN^PRCAGT(DEB,BEG,.END) ;get transactions reset END to last tran
 ;S TBAL=0 D TBAL^PRCAGT(DEB,.TBAL) ;get trans bal
 ;S BBAL=0 D BBAL^PRCAGU(DEB,.BBAL) ;get bill bal
 ;S X=$$PRE^PRCAGU(DEB) S PEND=$P(X,U,2),X=+X I X,BBAL D REF^PRCAGD(DEB,X,$G(REP)) G STSQ ;unprocessed refund and outstand bills send disc
 ;I BBAL=0,PEND,-PEND=PBAL+TBAL G STSQ ;all of the amount due is prepayment pending or refund review status
 ;I BBAL'=(PBAL+TBAL) D EN^PRCAGD(DEB,BBAL,TBAL,PBAL,BEG,$G(REP)) G STSQ ;send disc
 ;I BBAL=0,$G(SITE("ZERO")) G STSQ ;zero balance
 ;I BBAL'>0,'$D(^TMP("PRCAGT",$J,DEB)) G STSQ ;no amt due no activity
 ;I BBAL<0,BBAL>-.99 G STSQ ;refund less than 1.00
 ;I BBAL'<0,'$$ACT^PRCAGT(DEB,LDT3) G STSQ ;no activty past 3 stat
 ;S TBAL=TBAL+PBAL
 ;D EN^PRCAGST(DEB,.TBAL,PDAT,PBAL) S SITE("SCAN")="" ;print statement
 ;D EN^PRCAGF(DEB,TBAL) S ERR="" ;get forms and print
 ;D OPEN^RCEVDRV1(2,$P(^RCD(340,DEB,0),U),END,DUZ,$$SITE^RCMSITE,.ERR,.EVN,BBAL("PB")_U_BBAL("INT")_U_BBAL("ADM")_U_BBAL("CT")_U_BBAL("MF"))
 ;I EVN D CLOSE^RCEVDRV1(EVN)
 ;D UPDAT^PRCAGU(DEB,DT) ;set bill letter field
 ;S SITE("SCAN")=$G(^RC(342,1,5))
STSQ ;Q
REP ;entry from reprint statement queued option
 NEW DA,DEB,ETY,LST,SDT,SITE,X,Y
 D SITE^PRCAGU
 S ETY=+$O(^RC(341.1,"AC",2,0))
 I 'BEG S BEG=1
 F DA=BEG-1:0 S DA=$O(^RC(341,DA))  Q:'DA  I ETY=$P($G(^RC(341,DA,0)),U,2) Q:$S(END="*"&($P($P(^RC(341,DA,0),U,7),".")>HDAT):1,END'="*"&(DA>END):1,1:0)  S DEB=$P(^RC(341,DA,0),U,5) I DEB D REPS
REPQ Q
REPS ;Start reprint statement process
 NEW BBAL,BDT,CR,DAT,EDT,LDT,LST,NOT,PBAL,PDAT,TBAL,X,Y
 S DAT=9999999-HDAT
 D DT^DICRW S EDT=$P(^RC(341,DA,0),U,6),LDT=$P(^(0),U,7) ;ending date of transactions to reprint
 F I=2,3 S II=$P($G(^RC(341,DA,1)),U,I) I II S BBAL("INT")=II Q
 K I,II
 S BDT=0 D LST^PRCAGU(DEB,DA,.BDT) I 'BDT S PDAT="",PBAL=0 ;get last date/time of previous event before reprint event
 I BDT S PDAT=9999999-$P(BDT,"."),PBAL=0 D PBAL^PRCAGU(DEB,.BDT,.PBAL) ;Get previous bal and prev date of last transaction
 D EN^PRCAGT(DEB,BDT,EDT) ;get transactions for date range
 S TBAL=0 D TBAL^PRCAGT(DEB,.TBAL) ;get trans bal
 S TBAL=PBAL+TBAL
 I TBAL=0,SITE("ZERO") G REPSQ ;zero balance
 I TBAL'>0,'$D(^TMP("PRCAGT",$J,DEB)) G REPSQ ;less than 0 no activity
 I TBAL<0,TBAL>-.99 G REPSQ ;refund less than 1.00
 D EN^PRCAGST(DEB,.TBAL,PDAT,PBAL,LDT) ;print statement
 S (CR,NOT)=0,SITE("SCAN")=""
 F STAT=16,42 F BN=0:0 S BN=$O(^PRCA(430,"AS",DEB,STAT,BN)) Q:'BN  D
 .S LET=$G(^PRCA(430,BN,6)) F X=1:1:3 I $P(LET,U,X)=HDAT Q
 .S LET=X S SB="" D LT^PRCAGF(BN,SB,LET) ;get forms and print
 S SITE("SCAN")=$G(^RC(342,1,5))
REPSQ Q
BILL ;start reprint bill from queued option
 NEW BN,PRCADA,DEB,X,Y
 S DAT=9999999-DAT I 'BEG S BEG=1
 F PRCADA=BEG-1:0 S PRCADA=$O(^RC(341,PRCADA)) Q:'PRCADA  I $P(^RC(341,PRCADA,0),U,2)=$S(ETY="UB":9,1:10) Q:$S('PRCADA:1,END="*"&($P($P(^RC(341,PRCADA,0),"^",7),".")>DAT):1,PRCADA>END&(END'="*"):1,1:0)  D BILLS
BILLQ Q
BILLS ;start reprint bills process
 NEW BAL,NOTICE,PRCASV,X,Y
 S BN=$G(^RC(341,PRCADA,5)) Q:'BN
 S NOTICE=+$P(BN,U,2),BN=+BN
 S BAL=$G(^RC(341,PRCADA,1)) S BAL=+BAL+$P(BAL,U,2)+$P(BAL,U,3)+$P(BAL,U,4)+$P(BAL,U,5)
 I ETY'="UB" D LT^PRCAGF(BN,BAL,NOTICE) Q
 I NOTICE>1 S PRCASV("NOTICE")=NOTICE,PRCASV("ARREC")=BN D REPRNT^IBCF13 Q
 Q
