RCTCS1 ;HAF/ASF-CROSS-SERVICING S/R ;03/17/19 3:34 PM
 ;;4.5;Accounts Receivable;**350**;Mar 26, 2019;Build 66
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ;entry
 N %,BILLN,CBAL,CNT,CSTAT,DA,DIC,DIK,DNAME,G1,GOTBILL,HDR1,LASTDT,LASTIEN,LSUB,RCBILLDA,RCG,RCTCB,RCTCNO
 N RCTCNO,RCTCNR,RET,SEPLINE,SSN,X,Y
 K DIR
 S DIR(0)="S^B:Stop/Reactivate TCSP Referral for a Bill;D:Stop/Reactivate TCSP Referral for a Debtor"
 S DIR("B")="B" D ^DIR Q:$D(DIRUT)
 I Y="B" D STOP^RCTCSPU Q  ;--> out
 D DSEL ;select debtor
 I DEBTOR="" W !,"Debtor must be selected",! Q  ;--> out
 D SHOWB ;disply bills for debtor
 D DEBSTAT(DEBTOR) ;get debtor status
 Q:'$D(RCDSTAT)  ;required info
 D REUPS:$G(RCDSTAT("STOP FLAG"))="S"
 D REUPR:$G(RCDSTAT("STOP FLAG"))="R"
 D SETS:$G(RCDSTAT("STOP FLAG"))="R"!($G(RCDSTAT("STOP FLAG"))="")
 D SETR:$G(RCDSTAT("STOP FLAG"))="S"
 Q
DSEL ;Pick patient only
 S DEBTOR=""
 S DIC="^RCD(340,",DIC(0)="AEQZ"
 S DIC("V")="I +Y(0)=2"
 S DIC("S")="I $P(^(0),U,1)["";DPT("""
 D ^DIC Q:Y<0
 S DEBTOR=+Y
 S SSN=$P(^DPT(+Y(0),0),U,9)
 Q
SHOWB ;
 S RET=0,HDR1=1
 S RCTCB=0 F  S RCTCB=$O(^PRCA(430,"C",DEBTOR,RCTCB)) Q:RCTCB'>0!RET  D
 . S RCBILLDA=RCTCB,GOTBILL=$P(^PRCA(430,RCTCB,0),U) ;bill
 . S CSTAT=$$GET1^DIQ(430,RCTCB_",",8)
 . I (CSTAT'="ACTIVE")&(CSTAT'="OPEN") Q  ; only active and open
 . I HDR1 D BILLHEAD S HDR1=0
 . D DISPLAY ;W !,INFOLN,!?6,INFOLN1
 . ;D STOP^RCTCSPU
 . ;I $D(DUOUT)  S RET=1
 . Q
 Q
 ;
DISPLAY ;Display Info for each BILL
 S DNAME=$$GET1^DIQ(430,RCTCB_",",9) W !,DNAME
 W ?32,SSN
 S BILLN=$$GET1^DIQ(430,RCTCB_",",.01) W ?43,BILLN
 W ?58,CSTAT
 S CBAL=$$GET1^DIQ(430,RCTCB_",",11) W ?74,CBAL
 ;
 Q
TMP ;
 S SEPLINE="-",$P(SEPLINE,"-",80)=""
 W !,"Bill",?13,"Debtor",?40,"Current Bal",!?8,"CURRENT STATUS",?30,"CATEGORY",!,SEPLINE
 Q
BILLHEAD ;bill header
 S SEPLINE="-",$P(SEPLINE,"-",80)="" W !,SEPLINE
 W !,"Debtor Name",?32,"SSN",?43,"Bill #",?58,"AR Status",?74,"Amount"
 W !,SEPLINE
 Q
DEBSTAT(DEBTOR) ;Debtor TSP Status
 K RCDSTAT
 S LASTDT=$O(^RCD(340,DEBTOR,8,"C",99999999),-1)
 I LASTDT>0 D  ;has new style TCP
 . S LASTIEN=$O(^RCD(340,DEBTOR,8,"C",LASTDT,0))
 . S G1=^RCD(340,DEBTOR,8,LASTIEN,0)
 . S RCDSTAT("STOP FLAG")=$P(G1,U,1)
 . S RCDSTAT("DATE")=$P(G1,U,2)
 . S RCDSTAT("USER")=$P(G1,U,3)
 . S RCDSTAT("REASON")=$P(G1,U,4)
 .S RCDSTAT("COMMENT")=$P(G1,U,5)
 I LASTDT'>0 D  ;check for old stop
 . S RCDSTAT("STOP FLAG")=$$GET1^DIQ(340,DEBTOR_",",6.02)
 . S RCDSTAT("DATE")=$$GET1^DIQ(340,DEBTOR_",",6.03)
 . ; S RCDSTAT("USER")=$P(G1,U,3)
 . S RCDSTAT("REASON")=$$GET1^DIQ(340,DEBTOR_",",6.04)
 .S RCDSTAT("COMMENT")=$$GET1^DIQ(340,DEBTOR_",",6.05)
 Q  ;RCDSTAT
REUPS ;already set to stop
 W !!,"Referral to Cross-Servicing has already been stopped for this debtor"
 W !,"Stop Cross-Servicing referral effective date: " S Y=RCDSTAT("DATE") X ^DD("DD") W Y
 W !,"Stop Cross-Servicing referral reason: "
 S X=RCDSTAT("REASON") W $S(X="D":"DMC Eligible",X="H":"High risk veteran",X="B":"Bankruptcy",X="T":"Treasury Error",X="O":"Other",1:1)
 I RCDSTAT("REASON")="O" W !,"Stop Cross-Servicing referral reason Other: ",RCDSTAT("COMMENT")
 W !,"Cross-Servicing referral stopped by : ",$P(^VA(200,RCDSTAT("USER"),0),U)
 Q
REUPR ;already re-active
 W !!,"Referral to Cross-Servicing has already been reactivated for this debtor"
 W !,"Reactivated Cross-Servicing referral effective date: " S Y=RCDSTAT("DATE") X ^DD("DD") W Y
 W !,"Cross-Servicing referral reactivated by : ",$P(^VA(200,RCDSTAT("USER"),0),U)
 Q
SETS ;set the stop
 W !!,"Are You Sure You Want To Stop Cross-Servicing Referral for this Debtor?"
 K DIR S DIR(0)="Y",DIR("B")="NO" D ^DIR
 Q:'Y  ;out if not Y or dirut
 K DIR S DIR("A")="Enter Required Stop Reason"
 S DIR(0)="S^D:DMC Eligible;H:High risk veteran;B:Bankruptcy;T:Treasury Error;O:Other"
 D ^DIR Q:$D(DIRUT)
 S RCTCNR=Y,RCTCNO=""
 K DIR
 I RCTCNR="O" S DIR(0)="F^3:100",DIR("A")="Enter 'Other' Reason" D ^DIR Q:$D(DIRUT)
 S RCTCNO=Y
 S LSUB=0,CNT=1 F  S LSUB=$O(^RCD(340,DEBTOR,8,LSUB)) Q:LSUB'>0  S CNT=LSUB+1
 D NOW^%DTC
 S ^RCD(340,DEBTOR,8,CNT,0)="S"_U_%_U_DUZ_U_RCTCNR_U_RCTCNO
 S ^RCD(340,DEBTOR,8,0)="^340.08SA"
 S ^RCD(340,DEBTOR,8,"C",%,CNT)=""
 W !!,"Stop Cross-Servicing Referral Complete"
 W !!,"*** End of Stop Cross-Servicing Referral ***"
 I $E(IOST,1,2)="C-",'$D(DIRUT) R !!,"Type <Enter> to continue or '^' to exit:",X:DTIME
 Q
SETR ;reactivate
 W !!,"Are You Sure You Want To Reactivate Cross-Servicing Referral for this Debtor?"
 K DIR S DIR(0)="Y",DIR("B")="NO" D ^DIR
 Q:'Y  ;out if not Y or dirut
 S LSUB=0,CNT=1 F  S LSUB=$O(^RCD(340,DEBTOR,8,LSUB)) Q:LSUB'>0  S CNT=LSUB+1
 D NOW^%DTC
 S ^RCD(340,DEBTOR,8,CNT,0)="R"_U_%_U_DUZ_U
 S ^RCD(340,DEBTOR,8,"C",%,CNT)=""
 W !!,"Reactivate Cross-Servicing Referral complete"
 W !,"All eligible bills for this Debtor are now to be Referred to Cross-Servicing"
 W !!,"*** End of Reactivate Cross-Servicing Referral ***"
 I $E(IOST,1,2)="C-",'$D(DIRUT) R !!,"Type <Enter> to continue or '^' to exit:",X:DTIME
 Q
SITE(SITE) ;Status from file 342
 N G,EFFEC,RCDT,N,N1,RCSTAT
 S RCSTAT=0,RCDT=0
 S N1=$O(^RC(342,0)) S N=0,RCDT=0 F  S N=$O(^RC(342,N1,40,N)) Q:N'>0  D
 . S G=^RC(342,N1,40,N,0),EFFEC=$P(G,U,2)
 . I EFFEC>RCDT S RCDT=EFFEC,RCSTAT=$P(G,U)
 Q RCSTAT
 ;
