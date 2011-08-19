PRCFDE3 ;(WASH ISC)/LKG -RECHARGE AN INVOICE ;12/2/10  16:12
V ;;5.1;IFCAP;**154**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
RECHARGE ;Send Invoice to Service for Certification
 S PRCF("X")="AS" D ^PRCFSITE G:'% RCHX
 S DIC=421.5,DIC(0)="AEMNZ"
 S DIC("S")="I $S("";5;10;""[("";""_$P(^(2),U)_"";""):1,1:0)"
 D ^DIC K DIC I Y<0 G RCHX
 S PRCF("CIDA")=+Y,PRCF("LOC")=$P(^PRCF(421.5,PRCF("CIDA"),2),U,4)
 L +^PRCF(421.5,PRCF("CIDA")):5 E  W *7,!,"Invoice is being edited by another user - Please try again later!" G RC2
 S DIR("A",1)="Invoice is currently in "_$S(PRCF("LOC")]"":PRCF("LOC"),1:"AN UNKNOWN LOCATION")_"."
 S DIR("A")="Do you want to recharge it to someone else"
 S DIR("B")="YES",DIR(0)="Y" D ^DIR K DIR
 I Y'=1 S X=" <No Action Taken>*" D MSG^PRCFQ G RCHX:$D(DIRUT),RC1
 S DIC=49,DIC(0)="AEMNZ",PRCF("LOC")=$P($G(^(+$P($G(^PRCF(421.5,PRCF("CIDA"),3,0)),U,3),0)),U),DIC("S")="I +Y'=PRCF(""LOC"")" D ^DIC K DIC
 I Y<0 S X=" <No Action Taken>*" D MSG^PRCFQ G RCHX:$D(DTOUT)!$D(DUOUT),RC1
 I $E($P(Y(0),"^",8),1,2)="04" S X="You may not RECHARGE a record to Fiscal.  You may only CHECK-IN invoices to Fiscal. <No Action Taken>*" D MSG^PRCFQ G RC1
 I '$$CHARGE(+Y,"",$P(Y(0),U,8)) S X=" <Recharge to Service Failed.>*" D MSG^PRCFQ G RC1
 S X="  Recharge Completed.*" D MSG^PRCFQ
 S X=5 D STATUS^PRCFDE1
RC1 L -^PRCF(421.5,PRCF("CIDA"))
RC2 K PRCF("CIDA"),PRCF("LOC")
 G:$D(DTOUT) RCHX
 S %A="Do you want to recharge another invoice",%B="",%=2 D ^PRCFYN
 G RECHARGE:%=1
RCHX L:$D(PRCF("CIDA")) -^PRCF(421.5,PRCF("CIDA")) K PRCF,DTOUT,DUOUT,DIRUT
 Q
LOGIN ;Check Certified Invoice into Fiscal
 W !!,"This option allows you to check in documents from the services.",!,"It sets the current location as Fiscal and shows the status as",!,"'Awaiting Voucher Audit Review'.",!!
 S %=1,%A="Do you wish to process each document as it is checked in",%B="If you answer 'YES', you will be prompted for the items necessary to"
 S %B(1)="complete the Voucher Audit information.",%B(2)="A 'NO' will merely check-in the document.",%B(3)="Use an '^' to Quit." D ^PRCFYN G:%<0 LOGINX
 S:%=1 PRCFD("ALL")=""
 S PRCF("X")="AS" D ^PRCFSITE G:'% LOGINX
 S DIC=49,DIC(0)="AEMNQZ",DIC("A")="Select Fiscal Section Accepting Receipt of Document: ",DIC("S")="I $E($P(^(0),""^"",8),1,2)=""04""" D ^DIC K DIC G:Y<0 LOGINX
 S PRCF("FISCAL")=+Y,PRCF("MC")=$P(Y(0),U,8)
 S DIC("A")="Select/Barcode INVOICE TRACKING NUMBER: "
NXT S DIC=421.5,DIC(0)="AEMNZ",DIC("S")="I $D(^(2)),+^(2)=5"
 D ^DIC K DIC G:Y<0 LOGINX S PRCF("CIDA")=+Y
 I $$VIOLATE^PRCFDSOD(PRCF("CIDA"),DUZ) G NXTX
 L +^PRCF(421.5,PRCF("CIDA")):5 E  W *7,!,"Invoice is being edited by another user. - Please again try later!" G NXTX
 W:$$CLSD1358^PRCFDE2($P(Y(0),U,7),1) !
 I '$$CHARGE(PRCF("FISCAL"),10,PRCF("MC")) S X=" <Login Failed.>*" D MSG^PRCFQ G NXT1
 I '$D(DTOUT),$D(PRCFD("ALL")) D DIE^PRCFDCI G NXT1
 S X="Login completed.*" D MSG^PRCFQ
NXT1 L -^PRCF(421.5,PRCF("CIDA")) G:$D(DTOUT) LOGINX
NXTX S DIC("A")="Select/Barcode Next INVOICE TRACKING NUMBER: "
 G NXT
LOGINX K DTOUT,DUOUT D OUT^PRCFDE
 Q
CHARGE(PRCA,PRCB,PRCC) ;Assign to Certifying Service or Fiscal
 ; PRCA Service's Internal Entry #, PRCB Invoice Status, PRCC Service's Mail Code
 K DD,DO S DIC("P")=$P(^DD(421.5,70,0),U,2),DIC(0)="XL",DLAYGO=421.51
 S DA(1)=PRCF("CIDA"),DIC="^PRCF(421.5,"_DA(1)_",3,"
 S X=PRCA D FILE^DICN K DLAYGO I +Y<1 K DIC,DA Q 0
 S DA=+Y,DA(1)=PRCF("CIDA"),DIE=DIC K DIC D NOW^PRCFQ K X,Y,%X
 S DR="1////^S X=%;2////^S X=DUZ" D ^DIE K DIE,DR,DA
 S DIE="^PRCF(421.5,",DA=PRCF("CIDA"),PRCC=$E(PRCC,1,2)
 S DR=$S(PRCB'="":"50////^S X=PRCB;",1:"")_$S(PRCC="04":"58////^S X=$P(DT,""."");57///@",1:"58///@;57///T+7;57R")
 D ^DIE K DIE,DR,DA I $E($G(IOST),1,2)="C-",PRCC'="04" W !
 Q 1
