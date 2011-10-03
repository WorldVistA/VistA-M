PRCAGF ;WASH-ISC@ALTOONA,PA/CMS-Print Form Letters ;5/1/95  3:04 PM
V ;;4.5;Accounts Receivable;**1,48,141,190,225,259**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN(DEB,SB,PRNT) ;entry send Debtor number and statemet bal
 NEW PRCABN,CR,NOT,STAT
 S (CR,NOT)=0 I '$D(SITE) D SITE^PRCAGU
 F STAT=16,42 F PRCABN=0:0 S PRCABN=$O(^PRCA(430,"AS",DEB,STAT,PRCABN)) Q:'PRCABN  D
 .I $P(^RCD(340,DEB,0),U,1)'["DPT",$G(^PRCA(430,PRCABN,1))>0 Q
 .I $P(^RCD(340,DEB,0),U)'["DPT",($P($G(^PRCA(430,PRCABN,6)),U,4)>0) Q
 .D LT(PRCABN,$G(SB))
 Q
LT(PRCABN,SB,REPNOT) ;find which letter to print needs Site variable
 NEW BY,CAT,CE,CN,EH,EXE,FR,I,INE,IOP,LET,LT,PG,TO,VEN,X,TOPLTR
 I '$D(^PRCA(430,PRCABN,0)) Q
 S:'$D(CR) (NOT,CR)="" S:'$G(DEB) DEB=+$P(^PRCA(430,PRCABN,0),U,9)
 S CAT=$P($G(^PRCA(430,PRCABN,0)),U,2),LET=$G(^PRCA(430,PRCABN,6)) Q:CAT=""
 I $G(SB)="",CAT=26,^PRCA(430,PRCABN,7) S SB=-(+^(7))
 I $G(SB)="" S X=$G(^PRCA(430,PRCABN,7)) F I=1:1:5 S SB=+$G(SB)+$P(X,U,I)
 I SB<0 Q:CR  S LT=$O(^RC(343,"B","CREDIT",0)) D PRT(LT,PRCABN) S CR=1 Q
 I $P($G(^PRCA(430,PRCABN,1)),U,1),$P($G(^RCD(340,$P(^PRCA(430,PRCABN,0),U,9),0)),U,1)[";DPT" Q
 I $G(REPNOT)>0 S:REPNOT=4 REPNOT=3 S $P(LET,U,REPNOT)=""
 I NOT=0 F CN=24,29,30 I CAT=$O(^PRCA(430.2,"AC",CN,0)),$P(LET,U,3)="" D
 .I SITE("SUP") S NOT=1 Q
 .S LT=$S('$G(BBAL("INT")):"FL 4-513",1:"FL 4-513w")
 .S LT=$O(^RC(343,"B",LT,0)) D PRT(LT,PRCABN) S NOT=1
 S INE=$O(^PRCA(430.2,"AC",20,0)),EH=$O(^PRCA(430.2,"AC",25,0)),CV=$O(^PRCA(430.2,"AC",34,0))
 S CU=$O(^PRCA(430.2,"AC",38,0))
 I CAT=INE!(CAT=CV)!(CAT=CU),$P(LET,U,1)="" S LT=$O(^RC(343,"B","FL 4-480",0)) D PRT(LT,PRCABN) Q
 I CAT=EH,$P(LET,U,1)="" S LT=$O(^RC(343,"B","FL 4-481",0)) D PRT(LT,PRCABN) Q
 I CAT=EH!(CAT=INE)!(CAT=CV)!(CAT=CU),$P(LET,U,2)="" S LT=$O(^RC(343,"B","FL 4-482",0)) D PRT(LT,PRCABN) Q
 ;THIRD PARAMETER (1) FOR CALLING PRINT SUBROUTINE INSTRUCTS
 ;SOFTWARE TO PRINT "TOP ATTACHMENT LETTER"
 I CAT=EH!(CAT=INE)!(CAT=CV)!(CAT=CU),SB>599.99,SB<1200,$P(LET,U,3)="" S LT=$O(^RC(343,"B","FL 4-484",0)) D PRT(LT,PRCABN,1) Q
 I CAT=EH!(CAT=INE)!(CAT=CV)!(CAT=CU),SB>1199.99,$P(LET,U,3)="" S LT=$O(^RC(343,"B","FL 4-485",0)) D PRT(LT,PRCABN,1) Q
 S VEN=","_$O(^PRCA(430.2,"AC",6,0))_","_$O(^PRCA(430.2,"AC",7,0))_","_$O(^PRCA(430.2,"AC",11,0))_",",EXE=$O(^PRCA(430.2,"AC",13,0)),CE=$O(^PRCA(430.2,"AC",14,0))
 I CAT=EXE,$P(LET,U,1)="" S LT=$O(^RC(343,"B","FL 4-520b",0)) D PRT(LT,PRCABN) Q
 I CAT=CE,$P(LET,U,1)="" S LT=$O(^RC(343,"B","FL 4-520a",0)) D PRT(LT,PRCABN) Q
 I VEN[(","_CAT_","),$P(LET,U,1)="" S LT=$O(^RC(343,"B","FL 4-521",0)) D PRT(LT,PRCABN) Q
 I CAT=CE!(CAT=EXE)!(VEN[(","_CAT_",")),$P(LET,U,2)="" S LT=$O(^RC(343,"B","FL 4-483a",0)) D PRT(LT,PRCABN) Q
 ;I CAT=CE!(CAT=EH)!(CAT=INE)!(CAT=EXE)!(VEN[(","_CAT_","))!(CAT=CV)!(CAT=CU),$P(LET,U,3)="",SB>25,SB<600 S LT=$O(^RC(343,"B","FL 4-483",0)) D PRT(LT,PRCABN,1) Q
 ;CHANGE GREATER THAN $25 TO GREATER THAN $0 - PRCA*4.5*259
 I CAT=CE!(CAT=EH)!(CAT=INE)!(CAT=EXE)!(VEN[(","_CAT_","))!(CAT=CV)!(CAT=CU),$P(LET,U,3)="",SB>0,SB<600 S LT=$O(^RC(343,"B","FL 4-483",0)) D PRT(LT,PRCABN,1) Q
 I CAT=CE!(CAT=EXE)!(VEN[(","_CAT_",")),SB>599.99,$P(LET,U,3)="" S LT=$O(^RC(343,"B","FL 4-485",0)) D PRT(LT,PRCABN,1) Q
 Q
PRT(LT,PRCABN,TOP) ;print letter
 NEW DA,DIWF,DIWL,DIWR,LINE,LTP,X,D0
 S TOP=$G(TOP),LTP=0 I '$D(^RC(343,LT,0)) G PRTQ
 I LT'=+$O(^RC(343,"B","CREDIT",0)),LT'=+$O(^RC(343,"B","FL 4-513",0)),LT'=+$O(^RC(343,"B","FL 4-513w",0)) S LTP=1 ;s ltp if letter (not statement)
 S DEB=+$P(^PRCA(430,PRCABN,0),U,9)
 S NAM=$$NAM^RCFN01(DEB),SSN=$$SSN^RCFN01(DEB),SSN=$S(SSN=-1:"",1:SSN)
 I LTP D LTH ;print header on letter
 K ^UTILITY($J) ;print main body text from 343
 S ^UTILITY($J,1)="W "_IOF
 F LINE=0:0 S LINE=$O(^RC(343,LT,1,LINE)) Q:'LINE  S X=$G(^(LINE,0)) I X]"" W:($Y+2)>IOSL @IOF S DIWL=1,DIWR=80,DIWF="W" D ^DIWP
 D ^DIWW S:$G(PRNT)="FL" PRNT=1 K ^UTILITY($J)
 I LTP,",15,16,17,41,42,"[(","_$P($G(^PRCA(430,PRCABN,0)),U,2)_",") D DESC(PRCABN) ;print bill desc from 430 for cat. Ex-Emp, Curr Emp., Vendor, Cwt & Parking Fees
 ;CALL TO PRINT "TOP ATTACHMENT LETTER" FOR FL 4-483,FL 4-484,FL 4-485
 I TOP D TOP
 I LTP D PAY^PRCAGF1 W !,$P(^RC(343,LT,0),U,1) ;print letter payment remittance and Form number
PRTQ Q
LTH ;print letter header
 NEW ADD,X,Y
 W @IOF D:'$D(SITE) SITE^PRCAGU
 S ADD=$$SADD^RCFN01(8) I ADD="" S ADD=$$SADD^RCFN01(1)
 W !!,?30,"Department of Veterans Affairs"
 F Y=1:1:3 I $P(ADD,U,Y)]"" W !,?32,$P(ADD,U,Y)
 W !,?32,$P(ADD,U,4)_", "_$P(ADD,U,5)_"  "_$P(ADD,U,6)
 W !!!!,?50,"In Reply Refer To:"
 W !,?50,"File No./SSAN: ",$S($D(RCIRSTOT):SSN,1:$P(^PRCA(430,PRCABN,0),U,1))
 W !,?14,NAM
 S ADD=$$DADD^RCAMADD(DEB,1) ; Get debtor address (confidential if applicable)
 F Y=1:1:3 I $P(ADD,U,Y)]"" W !,?14,$P(ADD,U,Y) I Y=1 W ?50 X SITE("SCAN")
 W !,?14,$P(ADD,U,4)_", "_$P(ADD,U,5)_"  "_$P(ADD,U,6)
 S Y=DT X ^DD("DD") W !!!!!!,Y,!!
 Q
DESC(PRCABN) ;print description multiple from file 430
 NEW PRCABT,X,Y
 I '$G(PRCABN),$G(^PRCA(430,PRCABN,100))'=3 Q
 W !!,"Detailed Description:"
 D DES^PRCABD(PRCABN,3) W !
 Q
TOP ;PRINT TOP ATTACHMENT LETTER FOR FL 4-483,FL 4-484, FL 4-485
 S TOPLTR=$O(^RC(343,"B","TOP ATTACHMENT LETTER",0))
 Q:'TOPLTR  K ^UTILITY($J)
 S ^UTILITY($J,1)="W "_IOF
 F LINE=0:0 S LINE=$O(^RC(343,TOPLTR,1,LINE)) Q:'LINE  S X=$G(^(LINE,0)) I X]"" W:($Y+2)>IOSL @IOF S DIWL=1,DIWR=80,DIWF="W" D ^DIWP
 D ^DIWW K ^UTILITY($J)
 Q
