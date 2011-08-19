PRCAFBDU ;WASH-ISC@ALTOONA,PA/CLH-FMS Billing Document Utilities ;6/27/96  11:48 AM
V ;;4.5;Accounts Receivable;**2,16,29,42,168,169,204,198**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
BDGEN ;regenerate billing document
 N Y,ID,REFMS
EN N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^PRCA(430,",DIC(0)="AEMNQZ",DIC("A")="Select BILL NUMBER: "
 D ^DIC K DIC Q:+Y<0
 I $$GSTAT^RCFMFN02("B"_+Y)'=3 W !!,*7,"You CANNOT resend a document that has NOT REJECTED in FMS.",!! G EN
 S PRCABN=+Y
 S DIR(0)="Y",DIR("A")="Are you sure",DIR("A",1)="This will RESEND the selected Billing Document to FMS.",DIR("B")="NO" D ^DIR K DIR
 W ! G:+Y'=1 EN
 ;Setting variable REFMS flags for retransmission of document and will
 ;have a date of DT for transmission to FMS.
 S REFMS=1 D RSEND
 G EN
RSEND S FMSNUM="B"_PRCABN
 D DEL^RCFMFN02(FMSNUM)
 K FMSNUM
 D EN^PRCAFBD(PRCABN)
 K PRCABN
 Q
 ;
BDMGEN ;regenerate modified billing document
 N Y,DIC,BN,AMT,ADJTYO,TDT,TN,ERR,REFMS
EN2 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^PRCA(433,",DIC(0)="AEMNQZ",DIC("A")="Select A/R TRANSACTION NUMBER: " D ^DIC
 Q:+Y<0
 I $$GSTAT^RCFMFN02("T"_+Y)'=3 W !!,*7,"You CANNOT resend a document that has NOT REJECTED in FMS.",!! G EN2
 S TN=+Y,BN=$P(^PRCA(433,TN,0),U,2),TDT=$P(^(1),U),ADJTYP=$P(^(1),U,2),AMT=$P(^(1),U,5)
 S DIR(0)="Y",DIR("A")="Are you sure",DIR("A",1)="This will RESEND the selected Billing Document to FMS.",DIR("B")="NO" D ^DIR K DIR
 W ! G:+Y'=1 EN2
 S FMSNUM="T"_TN,REFMS=1
 D DEL^RCFMFN02(FMSNUM)
 K FMSNUM
 D EN^PRCAFBDM(BN,AMT,ADJTYP,TDT,TN,.ERR)
 G EN2
 ;
 ;
CC ;cost center
 N DIC,Y
 S CCC=$$COST^PRCSREC2($S($D(PRCA("SITE")):PRCA("SITE"),1:$$SITE^RCMSITE),CP)
 S DIC="^PRCD(420.1,",DIC(0)="EMNQ",DIC("A")="COST CENTER: "
 D ^DIC Q:+Y<0
 I $D(DUOUT)!($D(DTOUT)) S PRCA("EXIT")=1 Q
 I CCC'[$P(Y,U) W !!,*7,"Invalid Cost Center for the Control Point" D CCDISP Q
 S CCC=+Y,CC=$E(+Y,1,4)_"00",SCC=$E(+Y,5,6)
 Q
 ;
BOC ;budget object code
 N DIC,Y
 I '$D(CCC) S CCC=$P($G(^PRCA(430,$S($D(PRCABN):PRCABN,$D(DA):DA,1:-1),11)),U,2)
 S DIC="^PRCD(420.2,",DIC(0)="EMNQ"
 D ^DIC Q:+Y<0
 I $D(DUOUT)!($D(DTOUT)) S PRCA("EXIT")=1 Q
 I +CCC>0,'$D(^PRCD(420.1,CCC,1,+Y,0)) S Y=-1 Q
 S BOC=+Y
 Q
 ;
CCDISP ;display valid cost centers
 N DIC,X,Y
 S:'$D(CCC) CCC=$$COST^PRCSREC2($S($D(PRCA("SITE")):PRCA("SITE"),1:$$SITE^RCMSITE),CP)
 S X="?"
 S DIC="^PRC(420,"_$S($D(PRCA("SITE")):PRCA("SITE"),1:$$SITE^RCMSITE)_",1,"_+CP_",2,"
 S DIC(0)="EMNQ"
 D ^DIC
 Q
 W !!,"Valid Cost Centers for this Control Point are:",!
 F I=1:1:$L(CCC,U) W ?10,$E($P($G(^PRCD(420.1,$P(CCC,U,I),0)),U),1,40),!
 Q
 ;
BOCDISP ;display valid BOCs
 N ZZDA,DIC,X,Y
 S:'$D(CCC) CCC=$P($G(^PRCA(430,$S($D(PRCABN):PRCABN,1:$G(DA)),11)),U,2)
 S DIC="^PRCD(420.1,"_+CCC_",1,",DIC(0)="EMNQ",X="?"
 W ?10,!!,"Valid BOCs for this Cost Center are:",!
 D ^DIC
 Q
 ;
RHLP ;help for refund/reimbursement prompt
 W !!,"If this BILL will create a receivable for a budget element, i.e. Control Point,",!,"Answer REFUND.  Otherwise answer REIMBURSEMENT.",!!,"A REFUND will ALWAYS reference a Control Point, i.e. SALARY OVERPAYMENT."
 W !,"A REIMBURSEMENT is usually for services, i.e. Emergency/Humanitarian Care.",!!
 Q
 ;
ACCT ;edit accounting line information on rejected documents
 NEW BILL,DIE,DA,PRCABN,DIC,X,Y,L,FR,TO,FLDS,DIR,REFMS
ACCT1 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 SET (DIC,DIE)="^PRCA(430,",DIC(0)="AEMNQ",DIC("A")="Select BILL NUMBER: " DO ^DIC
 QUIT:+Y<0
 I '$P($G(^PRCA(430,+Y,6)),"^",21) W !,"YOU CAN ONLY SELECT BILLS THAT ARE ACTIVE.",! G ACCT1
 I $D(RCONVERT) S PRCABN=+Y G EDT
 SET BILL="B"_+Y
 SET PRCABN=+Y
EDT SET IOP=IO(0),DIC="^PRCA(430,",FLDS="[PRCA DISP AUDIT2]",(FR,TO)=PRCABN,L=0,BY="@NUMBER" DO EN1^DIP
 SET (DIC,DIE)="^PRCA(430,"
 DO CPLK^PRCAFUT(PRCABN)
 QUIT:$D(PRCA("EXIT"))
 ;DO:'$DATA(RCONVERT) RSEND
 I '$D(RCONVERT) S REFMS=1 D RSEND
 G ACCT
 ;
FUND ;valid fund seletion
 NEW DIC,X,Y
 S DIC(0)="EMNQ",DIC="^PRCD(420.14,",X="?"
 D ^DIC
 Q
SBOC ;remove SUB BOC from rejected bills
 N DIE,DA,DIC,DR
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S (DIC,DIE)="^PRCA(430,",DIC(0)="AEMNQ" D ^DIC
 Q:+Y<0
 S DA=+Y
 S DR="254///^S X=""@""" D ^DIE
 W !,"SUB BOC removed.",!
 Q
 ;
BDTRANS ;Select trans type for billing documents
 N DIC,DA,X,Y
 S DIC="^PRCA(347.4,",DIC(0)="AEMNQ",DIC("A")="Select TRANS. TYPE: ",DIC("S")="I $P(^(0),U,2)=1" D ^DIC
 I +Y<0 S PRCA("EXIT")=1 Q
 S TYPE=$P(Y,U,2)
 Q
 ;
