RCCPC1 ;WASH-ISC@ALTOONA,PA/LDB-Setups for CCPC;11/19/96  10:21 AM
V ;;4.5;Accounts Receivable;**34,70**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;called by RCCPC0
 ;
XMBGRP ;Setup RCCPC STATEMENTS MAIL GROUP
 N DES,X
 S DES(1)="CCPC PATIENT STATEMENTS MESSAGES"
 S X=$$MG^XMBGRP("RCCPC STATEMENTS",0,.5,1,"",.DES,1)
 ;
SDAY ;set patient statement day to site statement day
 S DEB=0 F  S DEB=$O(^RCD(340,"AB","DPT(",DEB)) Q:'DEB  I $D(^RCD(340,+DEB,0)) D
 .S STDT=$P($G(^RCD(340,+DEB,0)),"^",3) Q:'STDT
 .S SSTDT=$P($G(^RC(342,1,0)),"^",11)
 .Q:(SSTDT=STDT)
 .K ^RCD(340,"AC",STDT,+DEB)
 .S $P(^RCD(340,+DEB,0),"^",3)=SSTDT
 .S ^RCD(340,"AC",SSTDT,DEB)=""
 ;
RESET ;Reset statement days for non-patients
 S X(1)=$$STDY^RCCPCFN,X=0 F  S X=$O(^RCD(340,"AC",X(1),X)) Q:'X  D
 .K ^RCD(340,"AC",X(1),X)
 .S $P(^RCD(340,+X,0),"^",3)=+X(1)
 .S ^RCD(340,"AC",+X(1),X)=""
 ;
DOMAIN ;sets up 349.1 entry pointer to DOMAIN
 S DIC="^DIC(4.2,",X="Q-CCP.MED.VA.GOV",DIC(0)="M" D ^DIC Q:Y<0
 S SEG=$O(^RCT(349.1,"B","PS",0)) Q:'SEG
 S $P(^RCT(349.1,+SEG,3),"^",2,3)=+Y_"^"_$P(Y,"^",2)
 ;
DMC ;Find delinquent bill olders than 4/28/94 with no waiver rights
 N COM,DA,DFN,DIE,DR,DAT,PRCABN,PRCAEN,RCD,TODAY,TYP,VAEL,XMSUB,XMTEXT,XMY
 Q:$P(^RC(342,1,0),"^",13)
 S RCD=0 F  S RCD=$O(^RCD(340,"AB","DPT(",RCD)) Q:'RCD  D
 .Q:'$G(^RCD(340,+RCD,0))
 .S DAT=$O(^RC(341,"AD",RCD,2,0))
 .S DAT=9999999.999999-DAT
 .I DAT>2940428 Q
 .S DFN=+$G(^RCD(340,+RCD,0)) D ELIG^VADPT
 .I 'VAEL(1) Q
 .D DEM^VADPT I +$G(VADM(6))!VAERR Q
 .I $$ACT^PRCAGT(+RCD,DAT) Q
 .D NOW^%DTC S TODAY=$P(%,".")
 .S COM="Waiver rights on statement."
 .S PRCABN=$O(^PRCA(430,"AS",+RCD,16,0))
 .Q:'PRCABN
 .I "^18^22^23^"'[("^"_$P(^PRCA(430,+PRCABN,0),"^",2)_"^") S PRCABN=$O(^PRCA(430,"AS",+RCD,16,PRCABN))
 .Q:'PRCABN
 .D SETTR^PRCAUTL,PATTR^PRCAUTL
 .S TYP=$O(^PRCA(430.3,"AC",17,0))
 .S DR=".03////^S X="_PRCABN_";3////^S X=0;4////^S X=2;12////^S X=TYP;15////^S X=0;42////^S X=$G(DUZ)"
 .S DR=DR_";11////^S X=TODAY;5.02////^S X=COM;5.03////^S X="_$$STD^RCCPCFN
 .S DA=PRCAEN,DIE="^PRCA(433,"
 .D ^DIE
 .D MAIL
 S:'$O(^RCT(349,0)) $P(^RC(342,1,0),"^",13)=$$STD^RCCPCFN
 I $O(^RCT(349,0)) S X=$P(^RCT(349,$O(^RCT(349,0)),0),"^",9),X=$E(X,1,2)_"/"_$E(X,3,4)_"/"_$E(X,5,8) D ^%DT S $P(^RC(342,1,0),"^",13)=Y
 Q
 ;
MAIL ;Send message
 S XMSUB="Patient with no previous waiver rights notice"
 S XMDUZ="AR PACKAGE"
 S XMY("G.RCCPC STATEMENTS")=""
 S XMSG(1)="This patient: "_$$NAM^RCFN01(+RCD)_" "_$$SSN^RCFN01(+RCD)
 S XMSG(2)="will receive a statement next statement date with"
 S XMSG(3)="WAIVER RIGHTS and a comment on bill "_$P($G(^PRCA(430,+PRCABN,0)),"^")
 S XMTEXT="XMSG("
 D ^XMD
 Q
