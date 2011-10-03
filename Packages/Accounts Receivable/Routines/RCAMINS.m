RCAMINS ;WASH-ISC@ALTOONA,PA/LDB-CHECK FOR INSURANCE COMPANY AS DEBTOR,SECONDARY OR TERTIARY CO ;8/17/95  1:27 PM
V ;;4.5;Accounts Receivable;**6,20,144**;Mar 20, 1995
 ;
DEL(INS) ;Delete insurance company check
 N DEB,INS1,INSN1,INSN2
 I '$G(INS) S INS1="0^NO INSURANCE ENTRY"  G DELQ
 S INS1=0,DEB=$O(^RCD(340,"B",INS_";DIC(36,",0))
 I 'DEB S INS1=0 G DELQ
 I $O(^PRCA(430,"C",DEB,0)) S INS1=2
 I '$O(^PRCA(430,"C",DEB,0)) S INS1=1
DELQ Q INS1
 ;
 ;
EN(INS,INS1,INS2,ERROR) ;Repoint any bills with an obsolete insurance co.
 Q:'$G(INS)
 N ADD,BN,DEB,DIE,DIK,DR,ETYP,MSG,XMSUB
 S ERROR=""
 K ^TMP("RCAMINS",$J)
 S DEB(1)=$O(^RCD(340,"B",INS_";DIC(36,",0))
 I 'DEB(1),'$G(INS2) S ERROR="-1^NO AR DEBTOR ENTRY FOR 1ST INSURANCE CO. "_DEB(1) Q
 S:'$G(INS1) DEB(2)=""
 I $G(INS1),'$G(INS2) S DEB(2)=$O(^RCD(340,"B",INS1_";DIC(36,",0)) I 'DEB(2) D
 .K DD,DO S DIC="^RCD(340,",DIC(0)="QL",X=INS1_";DIC(36,",DLAYG0=340 D FILE^DICN K DIC,DD,DLAYGO,DO,X
 .S DEB(2)=+Y
 I '$G(INS2),DEB(2)=-1 S ERROR="-1^NO AR DEBTOR ENTRY FOR "_INS1 Q
 S:$G(INS) INSN1=$P($G(^DIC(36,+INS,0)),"^")
 S INSN2=$S($G(INS1):$P($G(^DIC(36,+INS1,0)),"^"),1:"")
 S ADD(1)=$$DADD^RCAMADD(INS_";DIC(36,")
 S ADD(2)=$S($G(INS1):$$DADD^RCAMADD(INS1_";DIC(36,"),1:"")
 I $G(INS1),'$G(INS2) D MRG
 I $G(DEB(1)) D EVNT
 I $G(DEB(1)),'$O(^PRCA(430,"C",DEB(1),0)) S DA=DEB(1),DIK="^RCD(340," D ^DIK
 Q
 ;
 ;
INS2(ROOT,COUNT) ; Check secondary or tertiary insurance fields
 ;  Input:   ROOT  --  Global root for table of carriers to be repointed
 ;          COUNT  --  Passed by reference; # of fields updated
 N BN,BN0,P
 S (BN,COUNT)=0
 F  S BN=$O(^PRCA(430,BN)) Q:'BN  S BN0=$G(^PRCA(430,+BN,0)) I $G(BN0) D
 .F P=19,20 I $P(BN0,"^",P),$D(@ROOT@($P(BN0,"^",P))) D
 ..S $P(^PRCA(430,+BN,0),"^",P)=@ROOT@($P(BN0,"^",P))
 ..S COUNT=COUNT+1
 Q
 ;
ATDX ;Fix "ATD" cross-reference
 S X=0 F  S X=$O(^RCD(340,X)) Q:'X  I $D(^RCD(340,+X,0)),(^(0)'["DPT"),$D(^PRCA(433,"ATD",X)) K ^PRCA(433,"ATD",X)
 Q
 ;
MRG ;Change debtor on bills
 S BN=0 F  S BN=$O(^PRCA(430,"C",DEB(1),BN)) Q:'BN  I $D(^PRCA(430,+BN,0)) D
 .S DA=BN,DIE="^PRCA(430,",DR="9////"_DEB(2) D ^DIE
 .I $P($G(^PRCA(430,+BN,0)),"^")]"" S ^TMP("RCAMINS",$J,$P($G(^PRCA(430,+BN,0)),"^"))=""
 .D BILL^IBCNSCD1($P($P($G(^PRCA(430,+DA,0)),"^"),"-",2),INS,INS1)
 S XMSUB="ACCOUNTS RECEIVABLE INSURANCE CO. MERGE/DELETION"
 S ^TMP($J,"MSG",17)="The following bills were affected:"
 Q
 ;
EVNT ;Change AR EVENTS
 F ETYP=1,9 S EDAT=0 F  S EDAT=$O(^RC(341,"AD",DEB(1),ETYP,EDAT)) Q:'EDAT  D
 .S EVNT=0 F  S EVNT=$O(^RC(341,"AD",DEB(1),ETYP,EDAT,EVNT)) Q:'EVNT  D
 ..I DEB(2) S DA=EVNT,DIE="^RC(341,",DR=".05////"_DEB(2) D ^DIE K DA
 ..I 'DEB(2) S DA=EVNT,DIK="^RC(341," D ^DIK K DA
 K DA,DIE,DR
 D MAIL^RCAMINS1
 Q
