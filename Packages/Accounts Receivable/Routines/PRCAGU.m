PRCAGU ;WASH-ISC@ALTOONA,PA/CMS-Patient Statement Utility ;8/23/94  8:06 AM
V ;;4.5;Accounts Receivable;**181,219**;Mar 20, 1995;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q  ;This routine should not be called from the top
SITE ;Set statement variables from Site Parameter File
 NEW SP0,SP2
 S SP0=$G(^RC(342,1,0)) I SP0="" G SITEQ
 S SP2=$G(^RC(342,1,2))
 S SITE("SUP")=+$P(SP0,U,2) ;suppres right&oblig
 S SITE("DETL")=+$P(SP0,U,5) ;Copay info 1-brief or 2-expanded
 S SITE("COM1")=$P($G(SP2),U,1) ;statement comment 1
 S SITE("COM2")="" ; statement comment 2 disabled with GMT patch ;($P($G(SP2),U,2))
 S SITE("SCAN")=$G(^RC(342,1,5)) ;mark for auto stuffer
 S SITE("ZERO")=$P($G(SP0),U,9) ;suppress zero balance
SITEQ Q
PBAL(DEB,DAT,PBAL) ;get previous balance and date of last transaction
 N EVN,I,Y G:'DEB PBALQ
 S EVN=$O(^RC(341,"AD",DEB,+$O(^RC(341.1,"AC",2,0)),DAT,0))
 I '$G(EVN) G PBALQ
 S Y=$G(^RC(341,EVN,1)) F I=1:1:5 S PBAL=PBAL+$P(Y,U,I)
 S DAT=$P($G(^RC(341,EVN,0)),U,6)
PBALQ Q
BBAL(DEB,BBAL) ;get bills balances return array
 NEW ADM,AC,BAL,CT,I,INT,MF,OP,PB,PRE,STAT
 S (BBAL,PB,INT,ADM,MF,CT)=0,LET3=""
 G:'DEB BBALQ
 S AC=+$O(^PRCA(430.3,"AC",102,0)),OP=+$O(^PRCA(430.3,"AC",112,0)),PRE=+$O(^PRCA(430.2,"AC",33,0))
 F STAT=AC,OP F BN=0:0 S BN=$O(^PRCA(430,"AS",DEB,STAT,BN)) Q:'BN  D
 .S BAL=$G(^PRCA(430,BN,7))
 .I $D(^PRCA(430,BN,6)) S LET3=$P(^(6),U,3) I LET3="" S ^XTMP("PRCAGU",$J,DEB,BN)=""
 .I $P(^PRCA(430,BN,0),U,2)=PRE S PB=PB-BAL Q
 .S PB=PB+$P(BAL,U,1),INT=INT+$P(BAL,U,2),ADM=ADM+$P(BAL,U,3),MF=MF+$P(BAL,U,4),CT=CT+$P(BAL,U,5)
 S BBAL=PB+INT+ADM+MF+CT
 F X="PB","INT","ADM","MF","CT" S BBAL(X)=@X
BBALQ Q
UPDAT(DEB,DAT) ;update bill file 430 letter fields
 NEW BN,DA,DIE,DR,II,LET,NOT,X,Y
 G:'DEB UPDATQ
 S:$G(DAT)="" DAT=DT S DIE="^PRCA(430,",NOT=0,BN=0
 F  S BN=$O(^PRCA(430,"AS",DEB,16,BN)) Q:'BN  S DA=BN D
 .S LET=$G(^PRCA(430,BN,6))
 .F II=1:1:4 Q:$P(LET,U,II)=DAT  I $P(LET,U,II)="" S NOT=II,DR=$S(II=1:61,II=2:62,II=3:63,1:68)_"////^S X="_DAT_";68.1////^S X="_DAT D ^DIE Q
UPDATQ Q
BEVN(DEB,DAT) ;set event for non patient letters
 NEW BAL,BN,DA,DIE,DR,EVN,I,NOT,X,Y
 G:'DEB BEVNQ
 S:$G(DAT)="" DAT=DT S DIE="^RC(341,",NOT=0,BN=0
 F  S BN=$O(^PRCA(430,"AS",DEB,16,BN)) Q:'BN  D
 .F I=1:1:3 I $P($G(^PRCA(430,BN,6)),U,I)=DAT S NOT=I Q
 .S:'NOT NOT=4 S BAL=$G(^PRCA(430,BN,7)),ERR="",EVN=""
 .D OPEN^RCEVDRV1(10,$P(^RCD(340,DEB,0),U),DAT,DUZ,$$SITE^RCMSITE,.ERR,.EVN,+BAL_U_$P(BAL,U,2)_U_$P(BAL,U,3)_U_$P(BAL,U,4)_U_$P(BAL,U,5))
 .I EVN S DA=EVN,DR="5.01////^S X="_BN_";5.02////^S X="_NOT D ^DIE D CLOSE^RCEVDRV1(EVN)
BEVNQ Q
PRE(DEB) ;check for prepay bills in Refund review or Pending Calm
 NEW BAL,BN,PEN,PRE,RR,STAT,Y
 S (BAL,Y)=0 G:'DEB PREQ
 S RR=+$O(^PRCA(430.3,"AC",113,0)),PEN=+$O(^PRCA(430.3,"AC",107,0)),PRE=+$O(^PRCA(430.2,"AC",33,0))
 F STAT=RR,PEN F BN=0:0 S BN=$O(^PRCA(430,"AS",DEB,STAT,BN)) Q:'BN  D
 .I $P($G(^PRCA(430,BN,0)),U,2)=PRE S Y=BN,BAL=BAL+$G(^PRCA(430,BN,7))
PREQ Q Y_U_BAL
LST(DEB,EVN,BDT) ;get last statement date before the statement date sent
 NEW BEG,DAT,Y
 S BDT=0 I 'DEB G LSTQ
 S Y=+$O(^RC(341.1,"AC",2,0)),BEG=$P($G(^RC(341,EVN,0)),U,7) I 'BEG G LSTQ
 S BEG=9999999.999999-BEG
 F DAT=BEG:0 S DAT=$O(^RC(341,"AD",DEB,Y,DAT)) Q:'DAT  S BDT=DAT Q
 ;return BDT in inverse date
LSTQ Q
