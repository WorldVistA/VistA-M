RCRCRR ;ALB/CMS - RC RECONCILIATION DRIVER ; 16-JUN-00
V ;;4.5;Accounts Receivable;**61,63,147,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
RRR ;Request Reconciliation Rollup from RC option entry point
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,RCBDT,RCCAT,RCDIV,RCDOM,RCEDT,RCI,RCJOB,RCSITE,RCSUB,RCWHO,X,X1,XMDUZ,XMSUB,XMTEXT,XMZ,X,Y
 W !!!,"  This option will send a Reconciliation Roll-up mail message request to your"
 W !,"  supporting Regional Counsel office.  Using this option is not CPU intensive."
 W !,"  Four mail messages each containing a different report will be sent"
 W !,"  to the RC RC REFERRALS mail group at this site and the RC office"
 W !,"  containing the outcome of the referral comparison. The messages may"
 W !,"  take up to a day to be delivered since it relies on Mailman delivery"
 W !,"  system response time at your Medical Center and your supporting RC office."
 W !!
 S DIR("A")="Continue with Request",DIR(0)="Y",DIR("B")="NO" D ^DIR
 I ($D(DIRUT))!($D(DIROUT)) G RRRQ
 I Y'=1 G RRRQ
 ;
CAT W !! S RCCAT="RR1"
 ;W !!,"AR Category to include in Roll-up Request"
 ;W !,"1.  Reimbursable Health",!,"2.  Worker's Comp, Tort Feasor and No-Fault Auto."
 ;R !!,"Select 1 or 2 : 1//",X:DTIME I ('$T)!(X["^") G RRRQ
 ;I X=2 S RCCAT="RR2" G DT
 ;I (X="")!(X=1) S RCCAT="RR1" G DT
 ;W !!,"You must select a Category or enter '^' to exit." G CAT
 ;
DT ;  Get date range for Report 4 of 4
 W !!,"Report (4 of 4) Bills in AR and RC with same Dollar amount HOWEVER,"
 W !," a Contract/Decrease adjustment was made before the Referral Date."
 W !!,"This report is for you to review and determine the validity of the adjustment."
 W !,"Select the Referral Date range for referred bills that have a decrease"
 W !,"adjustment made prior to the bill referral date."
 W !!,"  Adjusted bills or bills with valid decreases will continue to"
 W !,"  display in the same selected Referral Date time frame."
BDT W ! S %DT="AEPX",%DT(0)=-DT,%DT("A")="Start with Referral Date: " D ^%DT K %DT
 G RRRQ:Y<0 S RCBDT=Y
 W ! S %DT="AEPX",%DT(0)=RCBDT,%DT("A")="End with Referral Date: " D ^%DT K %DT
 G RRRQ:Y<0 S RCEDT=Y
 ;
 S RCSITE=$$SITE^RCMSITE
 D RCDIV^RCRCDIV(.RCDIV)
 I $O(RCDIV(0)) S RCI=0 F  S RCI=$O(RCDIV(RCI)) Q:'RCI  D
 .S RCDOM=$P(RCDIV(RCI),U,6)
 .D SEND
 E  S RCDOM=$$RCDOM^RCRCUTL D SEND
RRRQ Q
 ;
SEND ;Called with user supplied date range
 S (RCSUB,XMSUB)="AR/RC -"_RCSITE_" Reconciliation Roll-up Request ("_$S(RCCAT="RR1":"RI)",1:"WC,TF,NA)")
 S X1(1)="$$RC$"_RCCAT_"$$"_RCSITE_"$S.RC RC SERV"
 S X1(2)="$END$1$"_RCBDT_"$"_RCEDT
 S XMTEXT="X1("
 S RCWHO=RCDOM
 S XMY(RCWHO)="",XMY(DUZ)=""
 D ^XMD I XMZ<1 W !!,"** Mail message not created. Please Try Again. **" G RRRQ
 W !!,"Request sent to "_RCDOM_" in Mail Message #("_XMZ_").",!
 D ENT^RCRCXMS(XMZ,RCSUB,RCWHO)
SENDQ Q
 ;
TASK ;Task the RC background job from the RC Server
 ;Called from RCRCSVR
 N I,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK,ZTSAVE,%,%I,%H,X,Y
 I $P($G(RCVAR),U,6)="" G TASKQ
 D NOW^%DTC S ZTDTH=%
 S ZTRTN=$P(RCVAR,U,6),ZTDESC=$P(RCVAR,U,4),ZTIO=""
 F I="RCSITE","RCBDT","RCEDT","RCJOB","RCXTYP","RCVAR","RCXMY","RCXMZ" S ZTSAVE(I)=""
 D ^%ZTLOAD
TASKQ Q
 ;
BKTSK(RCCAT) ;This entry point is called from the scheduled options
 ;to send a Reconciliation request to RC
 ;Input: RR1=Reimburs.Health  RR2=NON-Reimburs.Health
 N RCSITE,RCSUB,RCDOM,RCDIV,RCWHO,RCI,X1,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,X,Y
 I ($G(RCCAT)'="RR1")&($G(RCCAT)'="RR2") G BKTSKQ
 ;Line below should be removed when RC is ready to Reconcile Worker's Comp., Torts and No Fault AUTO
 I $G(RCCAT)="RR2" G BKTSKQ
 S RCSITE=$$SITE^RCMSITE
 D RCDIV^RCRCDIV(.RCDIV)
 I $O(RCDIV(0)) S RCI=0 F  S RCI=$O(RCDIV(RCI)) Q:'RCI  D
 .S RCDOM=$P(RCDIV(RCI),U,6)
 .D BSND
 E  S RCDOM=$$RCDOM^RCRCUTL D BSND
 D PRG
BKTSKQ Q
 ;
BSND ;Send with date values set to T-30
 S XMCHAN=1
BKTA S (RCSUB,XMSUB)="AR/RC -"_RCSITE_" Reconciliation Roll-up Request ("_$S(RCCAT="RR1":"RI)",1:"TF,WC,NA)")
 S X1(1)="$$RC$"_RCCAT_"$$"_RCSITE_"$S.RC RC SERV"
 S X1(2)="$END$1$"_$$FMADD^XLFDT(DT,-30)_"$"_DT
 S XMTEXT="X1("
 S RCWHO=RCDOM,XMY(RCWHO)="",XMY(DUZ)=""
 D ^XMD I XMZ<1 G BKTA
 D ENT^RCRCXMS(XMZ,RCSUB,RCWHO)
BSNDQ Q
 ;
PRG ;Purge old entries in the File 349.3
 N DA,DIK,RCI,X,Y
 S DIK="^RCT(349.3,"
 S RCI=0 F  S RCI=$O(^RCT(349.3,"AD",RCI)) Q:'RCI  D
 .I RCI>DT Q
 .S DA=0 F  S DA=$O(^RCT(349.3,"AD",RCI,DA)) Q:'DA  D ^DIK
PRGQ Q
 ;RCRCRR
