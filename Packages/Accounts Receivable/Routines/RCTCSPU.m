RCTCSPU ;ALBANY/BDB-CROSS-SERVICING UTILITIES ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301,315,350**;Mar 20, 1995;Build 66
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;total amount of bills for a debtor
TOTALB(DEBTOR) ;
 N TOTAL,BILL,B7
 S TOTAL=0,BILL=0
 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 .Q:'$D(^PRCA(430,"TCSP",BILL))
 .S B7=$G(^PRCA(430,BILL,7))
 .S TOTAL=TOTAL+$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 Q TOTAL
 ;
 ;stop TCSP referral on a bill
STOP ;stop Cross-Servicing referral
 N DIC,DIE,DA,DR,DIR,Y,BILL,REASON,COMMENT,EFFDT
 I $G(GOTBILL) S BILL=RCBILLDA  ;PRCA*4.5*315
 I '$G(GOTBILL) S DIC=430,DIC(0)="AEQM" D ^DIC Q:Y<0  ;PRCA*4.5*315
 I '$G(GOTBILL) S BILL=+Y  ;PRCA*4.5*315
 I $P($G(^PRCA(430,BILL,15)),U,7) G DELSTOP
 W !,"Stop flag for Cross-Servicing Referral set? : NO"
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to stop the Cross-Servicing Referral for this bill" D ^DIR
 I $G(GOTBILL),$D(DIRUT) S RCDPGQ=1      ; account profile listman quit flag  *315
 I 'Y W !,*7,"No action taken" Q
 ;
REASON ;ask referral reason
 K DIR S DIR("A")="Enter Stop Cross-Servicing Reason ",DA=BILL,DIR(0)="430,159" D ^DIR
 Q:(Y="")!(Y=U)
 S REASON=Y I REASON="O" D  Q:COMMENT=U  G REASON:COMMENT=""
 .S COMMENT="",DIR("A")="Enter Stop Reason Comment ",DA=BILL,DIR(0)="430,159.1" D ^DIR S COMMENT=Y
 .I COMMENT="" W !,"A Reason of Other requires a comment to be entered"
 .Q
 I REASON'="O",$P($G(^PRCA(430,BILL,15)),U,10)'="" S $P(^(15),U,10)=""
 ;
 ;ask effective date
 ;
 S DIR(0)="430,158",DA=BILL,DIR("A")="Enter Effective Date " D ^DIR G:Y=U STOPQ S EFFDT=Y
 ;
STOPFILE ;set stop referral data in file 430
 S $P(^PRCA(430,BILL,15),U,7,10)="1^"_EFFDT_U_REASON_U_$G(COMMENT)
 ;
 W !,"Stop Cross-Servicing Referral complete"
 D STOP^RCTCSPD4 ; *315 Create CS Stop Placed comment tx in 433
 G STOPQ
 ;
DELSTOP ;Allows Cross-Servicing Referral to be re-instituted for bill
 N I
 W !!,*7,"Referral to Cross-Servicing has already been stopped for this bill."
 W !,"Stop Cross-Servicing referral effective date: ",$$GET1^DIQ(430,BILL,158,"E")
 W !,"Stop Cross-Servicing referral reason        : ",$$GET1^DIQ(430,BILL,159,"E")
 I $$GET1^DIQ(430,BILL,159,"E")="OTHER" W !,"Stop Cross-Servicing referral comment       : ",$$GET1^DIQ(430,BILL,159.1,"E")
 S DIR(0)="Y",DIR("A")="Do you wish to re-institute Cross-Servicing Referral for this bill",DIR("B")="NO"
 D ^DIR
 I $G(GOTBILL),$D(DIRUT) S RCDPGQ=1 G STOPQ        ; account profile listman quit flag  *315
 G EDSTOP:'Y
 ;
 ;reset file to allow cross-servicing referral to be re-started
 F I=7:1:10 S $P(^PRCA(430,BILL,15),U,I)=""
 W !!,"Bill is now eligible to be Referred to Cross-Servicing" D DELSTOP^RCTCSPD4 G STOPQ ; *315 create CS Stop Deleted transaction
 ;
EDSTOP S DIR(0)="Y",DIR("A")="Do you wish to edit the Stop Referral Data for this bill",DIR("B")="NO" D ^DIR G REASON:Y
STOPQ Q
 ;
 ;Set Cross-Servicing recall for a bill
RCLLSETB ;Set Cross-Servicing recall
 N DIC,DIE,DA,DR,DIR,Y,BILL,REASON
 I '$G(GOTBILL) S DIC=430,DIC(0)="AEQM" D ^DIC Q:Y<0
 I '$G(GOTBILL) S BILL=+Y
 I $G(GOTBILL) S BILL=RCBILLDA
 I $P($G(^PRCA(430,BILL,15)),U,2) G DELSETB
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to set this bill to be recalled from Cross-Servicing" D ^DIR
 I $G(GOTBILL),$D(DIRUT) S RCDPGQ=1        ; account profile listman quit flag  *315
 I 'Y W !,*7,"No action taken" Q
 I '$D(^PRCA(430,"TCSP",BILL)) W !,*7,"No action taken.  Bill has not been referred to Cross-Servicing." Q
 ; 
RCRSB ;ask recall reason
 K DIR S DIR(0)="S^01:DEBT REFERRED IN ERROR;07:AGENCY IS FORGIVING DEBT;08:AGENCY CAN COLLECT THROUGH INTERNAL OFFSET" D ^DIR
 Q:(Y="")!(Y=U)
 ;set recall data in file 430
 S REASON=Y
 S $P(^PRCA(430,BILL,15),U,2,4)="1^^"_REASON
 D CSRCLPL^RCTCSPD5 ; *315 CS Recall Placed comment tx in 433
 W !,"Setting this bill for Recall from Cross-Servicing is complete"
 G SETBQ
 ;
RRSET ; Set rerefer for bills PRCA*4.5*350
 N BILL,STOP
 S STOP=0
 F  D RRSETB Q:BILL=""  Q:STOP
 Q
 ; Set rerefer for bill PRCA*4.5*350
RRSETB ;
 N DIC,DIE,DA,DR,DIR,Y,DIROUT,DTOUT,DUOUT,DIRUT
 N WR,EXE,DEBTOR,CHECK,REASON,COMMENT,LIEN,QUIT,FIXABLE
 S BILL="",LIEN="",QUIT=""
 ; Still experimenting if to use DIC or DIR
 S DIC=430,DIC(0)="AEQMS",DIC("A")="Enter Bill Number for re-referral: "
 ; we will allow selection of bills here and show error message if we don't like bill.
 ;S DIC("S")="I $D(^PRCA(430,Y,15))" 
 D ^DIC
 S BILL=+Y S:Y=-1 STOP=1
 I STOP Q
 S DEBTOR=$P($G(^PRCA(430,BILL,0)),U,9)
 I $$RR^RCTCSPU(BILL)=0 D  Q:STOP  Q:QUIT
 . N NZ,REASON,COMMENT
 . W !!,"Re-Referral has already been requested",!
 . S LIEN=$O(^PRCA(430,BILL,15.5,99999),-1)
 . S NZ=^PRCA(430,BILL,15.5,LIEN,0),REASON=$P(NZ,U,4),COMMENT=$P(NZ,U,5)
 . W !,"By ",$P(^VA(200,$P(NZ,U,3),0),U)," on ",$$FMTE^XLFDT($P(NZ,U,2),"5Z"),"   Reason: "
 . W $S(REASON="R":"Recall in error",REASON="T":"Treasury reversal",REASON="D":"Defaulted RPP",REASON="O":"Other: "_COMMENT,1:""),!
 . K DIR S DIR("A")="Do you want to Cancel this Re-Referral",DIR("B")="NO",DIR(0)="Y" D ^DIR
 . I X="" S STOP=1 Q
 . I $G(DTOUT) S STOP=1 Q
 . I $G(DIROUT) S STOP=1 Q 
 . I $G(DUOUT) S STOP=1 Q
 . I Y D  S QUIT=1 Q
 . . ; remove LIEN from 15.5.   Use DIK?
 . . I LIEN=1 K ^PRCA(430,BILL,15.5,0)
 . . E  S $P(^PRCA(430,BILL,15.5,0),U,2)=430.03,$P(^PRCA(430,BILL,15.5,0),U,3)=LIEN-1,$P(^PRCA(430,BILL,15.5,0),U,4)=$P(^PRCA(430,BILL,15.5,0),U,4)-1
 . . K ^PRCA(430,BILL,15.5,LIEN)
 . . K ^PRCA(430,BILL,15.5,"B",0,LIEN)
 . . D RRCAN^RCTCSPD4
 . . W !!,"*** Re-Referral has been cancelled for this bill ***"
 . . Q
 . K DIR S DIR("A")="Do you want to Update this Re-Referral",DIR("B")="NO",DIR(0)="Y" D ^DIR
 . I X="" S QUIT=1 Q
 . I $G(DTOUT) S STOP=1 Q
 . I $G(DIROUT) S STOP=1 Q 
 . I $G(DUOUT) S STOP=1 Q
 . I X?1"N".E!(X?1"n".E) W !!,"*** No changes applied to this re-referral ***",! S QUIT=1 Q
 D
 . S CHECK=1
 . I 'DEBTOR S CHECK="0^0^Bill has no debtor" Q
 . I '$P($G(^PRCA(430,BILL,30)),U),'$P($G(^PRCA(430,BILL,15)),U,3) S CHECK="0^0^Bill is not Returned or Recalled, so can't re-refer" Q
 . ; Disabling Stop flag is OK for now, but we will need to clear it at some point.   Batch Job?
 . S CHECK=$$RSBILCHK^RCTCSPD0(BILL,"3,20")
 I 'CHECK D  Q
 . S FIXABLE=$F(",0,3,5,6,12,15,16,19,20,21,24,26,27,",","_$P(CHECK,U,2)_",")
 . I 'FIXABLE W !!,"Unable to complete the re-referral process",!,$P(CHECK,U,3) Q
 . W !!,"This bill has issues and will not make it through re-referral process because:",!,$P(CHECK,U,3)
 . W !!,"PLEASE CORRECT THIS ISSUE AND THEN RE-REFER THE BILL AGAIN",!
 . K DIR S DIR(0)="FO",DIR("A")="Press <ENTER> to continue " D ^DIR
 . I (Y=U)!$G(DTOUT)!$G(DUOUT) S STOP=1
 ; Ask Rerefer Reason and description if O=Other
 K DIR S DIR(0)="S^R:Recall in error;T:Treasury reversal;D:Defaulted RPP;O:Other"
 S DIR("A")="Select Reason for this re-referral"
 D ^DIR
 I (Y="")!(Y=U)!$G(DTOUT)!$G(DUOUT) S STOP=1 Q
 W !
 S REASON=Y
 I REASON="O" K DIR S DIR(0)="F^1:30",DIR("A")="Enter ""Other"" description " D ^DIR Q:Y=""  Q:Y=U  S COMMENT=Y
 ; Are you sure (do we want to ask this for update to rereferral?)
 K DIR S DIR("A")="Are you sure you want to Re-refer this bill for Cross-Servicing",DIR(0)="Y",DIR("B")="YES"
 D ^DIR
 I (Y=U)!$G(DTOUT)!$G(DUOUT) S STOP=1 Q
 I 'Y W !!,"*** No updates applied ***" Q
 ; user, date, status of rerefer
 I LIEN'="" D
 . ; That should be all we need for update of last IEN
 . S ^PRCA(430,BILL,15.5,LIEN,0)=0_U_DT_U_DUZ_U_REASON_U_$G(COMMENT)
 I LIEN="" D
 . S LIEN=$O(^PRCA(430,BILL,15.5,99999),-1)+1
 . S $P(^PRCA(430,BILL,15.5,0),U,2)=430.03
 . S $P(^PRCA(430,BILL,15.5,0),U,3)=LIEN
 . S $P(^PRCA(430,BILL,15.5,0),U,4)=$P(^PRCA(430,BILL,15.5,0),U,4)+1
 . S ^PRCA(430,BILL,15.5,LIEN,0)=0_U_DT_U_DUZ_U_REASON_U_$G(COMMENT)
 . S ^PRCA(430,BILL,15.5,"B",0,LIEN)=""
 W !!,"Bill is set to be re-referred to Cross-Servicing in the next weekly transmission"
 W !
 ; file Rerefer Request transaction
 D RRREQ^RCTCSPD4
 K DIR S DIR(0)="FO",DIR("A")="Press <ENTER> to continue " D ^DIR
 W !
 I (Y=U)!$G(DTOUT)!$G(DUOUT) S STOP=1 Q
 Q
RR(BILL) ; PRCA*4.5*350
 ; Return: Null = no RR, 0 = RR Requested, 1 = RR Performed
 N LIEN
 Q:BILL="" ""
 S LIEN=$O(^PRCA(430,BILL,15.5,99999),-1)
 I LIEN<1 Q ""
 Q $P(^PRCA(430,BILL,15.5,LIEN,0),U)
 ;
RRD(DEBTOR) ; PRCA*4.5*350
 ; Return: 0 = Debtor has no RR bills, 1 = Debtor has RR bills
 Q:DEBTOR="" 0
 N BILL,OUT
 S BILL="",OUT=0
 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL=""  I $$RR(BILL) S OUT=1 Q
 Q OUT
 ;
DELSETB ;Allows Cross-Servicing Recall to be deleted for bill
 W !!,*7,"This bill has already been set for recall from Cross-Servicing."
 I +$P($G(^PRCA(430,BILL,15)),U,3) W !!,"Not available for reactivation.  The Recall request has already been processed." G SETBQ
 S DIR(0)="Y",DIR("A")="Do you wish to delete the Cross-Servicing Recall for this bill",DIR("B")="NO"
 D ^DIR
 I $G(GOTBILL),$D(DIRUT) S RCDPGQ=1 G SETBQ         ; account profile listman quit flag  *315
 G EDSETB:'Y
 ;
 ;delete the recall
 F I=2:1:5 S $P(^PRCA(430,BILL,15),U,I)=""
 D DELRCLL^RCTCSPD4 ; *315 Create CS Delete Recall comment tx in 433
 W !!,"Recall from Cross-Servicing has been deleted for this bill."
 G SETBQ
 ;
EDSETB S DIR(0)="Y",DIR("A")="Do you wish to edit the Recall data for this bill",DIR("B")="NO" D ^DIR G RCRSB:Y
SETBQ Q
 ;
 ;Set Cross-Servicing recall for a debtor
RCLLSETD ;Set Cross-Servicing debtor recall
 N DIC,DIE,DA,DR,DIR,Y,DEBTOR,REASON,BILL
 ; GOTDEBT, RCDEBTDA  - are defined if called from List Manager
 I '$G(GOTDEBT) S DIC=340,DIC(0)="AEQM" D ^DIC Q:Y<0      ; *315
 I '$G(GOTDEBT) S DEBTOR=+Y                               ; *315
 I $G(GOTDEBT) S DEBTOR=RCDEBTDA                          ; *315  
 I $P($G(^RCD(340,DEBTOR,7)),U,2),'$P($G(^RCD(340,DEBTOR,7)),U,3) G DELSETD
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to recall this debtor and bills from Cross-Servicing" D ^DIR
 I 'Y W !,*7,"No action taken" Q
 I '$D(^RCD(340,"TCSP",DEBTOR)) W !,*7,"No action taken.  Debtor has not been referred to Cross-Servicing." Q
 ;
RCRSD ;ask debtor recall reason
 K DIR S DIR(0)="340,7.04" D ^DIR
 Q:(Y="")!(Y=U)
 ;set debtor recall data in file 340
 S REASON=Y
 S $P(^RCD(340,DEBTOR,7),U,2,4)="1^^"_REASON
 ;go through debtor bills and set reason in the bill recall reason
 S BILL=0
 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 .I $D(^PRCA(430,"TCSP",BILL)) D  Q  ;bill previously sent to TCSP
 ..S $P(^PRCA(430,BILL,15),U,2,4)="1^^"_REASON ;set the recall flag and reason (TV9)
 ..D CSRCLPL^RCTCSPD5 ; *315 Create CS RECALL PLACED tx in 433
 W !,"Setting this debtor for Recall from Cross-Servicing is complete"
 G SETDQ
 ;
DELSETD ;Allows Cross-Servicing Recall to be deleted for debtor
 W !!,*7,"This debtor has already been set for recall from Cross-Servicing."
 S DIR(0)="Y",DIR("A")="Do you wish to delete the Cross-Servicing Recall for this debtor",DIR("B")="NO" D ^DIR G EDSETD:'Y
 ;
 ;delete the recall in file 340
 F I=2:1:4 S $P(^RCD(340,DEBTOR,7),U,I)=""
 ;go through debtor bills and delete the recall flag & reason
 S BILL=0
 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 .I $D(^PRCA(430,"TCSP",BILL)) D  Q  ;bill previously sent to TCSP 
 ..S $P(^PRCA(430,BILL,15),U,2)="" ; delete the recall flag PRCA*4.5*315 
 ..S $P(^PRCA(430,BILL,15),U,4)="" ; delete the recall reason
 ..D DELRCLL^RCTCSPD4 ; *315 CS DEL BILL RECALL in 433
 ;
 W !!,"Recall from Cross-Servicing has been deleted for this debtor."
 G SETDQ
 ;
EDSETD S DIR(0)="Y",DIR("A")="Do you wish to edit the Recall data for this debtor",DIR("B")="NO" D ^DIR G RCRSD:Y
SETDQ Q
 ;
DECADJ(RCBILLDA,RCTRANDA) ;decrease adjustment transaction history for 5b cross-servicing record
 ;rcbillda - file 430 bill ien
 ;rctranda - file 433 transaction ien
 N BILL,DIC,DA,DIE,DR,Y,X
 I '$D(RCBILLDA)!('$D(RCTRANDA)) Q
 S X=RCTRANDA
 S DIC="^PRCA(430,"_RCBILLDA_",17,",DIC(0)="L"
 I '$D(^PRCA(430,RCBILLDA,17,0)) S ^PRCA(430,RCBILLDA,17,0)="^430.0171PA^0^0"
 S DIC("P")=$P(^PRCA(430,RCBILLDA,17,0),"^",2)
 S DA(1)=RCBILLDA
 S BILL=RCBILLDA
 D ^DIC I Y=-1 K DIC,DA Q
 S DIE=DIC K DIC
 S DA=+Y
 S DR="1////1" D ^DIE ; Reinstated the 4 slashes
 Q
 ;
INCADJ(RCBILLDA,RCTRANDA) ;increase adjustment transaction history for 5b cross-servicing record 315/DRF
 ;rcbillda - file 430 bill ien
 ;rctranda - file 433 transaction ien
 N DIC,DA,DIE,DR,Y,X
 I '$D(RCBILLDA)!('$D(RCTRANDA)) Q
 S X=RCTRANDA
 S DIC="^PRCA(430,"_RCBILLDA_",17,",DIC(0)="L"
 I '$D(^PRCA(430,RCBILLDA,17,0)) S ^PRCA(430,RCBILLDA,17,0)="^430.0171PA^0^0"
 S DIC("P")=$P(^PRCA(430,RCBILLDA,17,0),"^",2)
 S DA(1)=RCBILLDA
 D ^DIC I Y=-1 K DIC,DA Q
 S DIE=DIC K DIC
 S DA=+Y
 S DR="1////1" D ^DIE
 Q
 ;
RCLLSETC ;Set Cross-Servicing recall for a case
 N DIC,DIE,DA,DR,DIR,Y,BILL,REASON
 S DIC=430,DIC(0)="AEQM" D ^DIC Q:Y<0
 S BILL=+Y
 I $P($G(^PRCA(430,BILL,15)),U,11) G DELSETC
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to set this case to be recalled from Cross-Servicing" D ^DIR
 I 'Y W !,*7,"No action taken" Q
 I '$D(^PRCA(430,"TCSP",BILL)) W !,*7,"No action taken.  Case has not been referred to Cross-Servicing." Q
 ; 
RCRSC ;set case recall reason
 ;set recall data in file 430 for the bill and the case
 S REASON=15
 S $P(^PRCA(430,BILL,15),U,11,13)="1^^"_REASON
 S $P(^PRCA(430,BILL,15),U,2,4)="1^^"_REASON
 ;
 D RCRSC^RCTCSPD4 ; *315 CS CASE RECALL tx
 W !,"Setting this case for Recall from Cross-Servicing is complete"
 G SETCQ
 ;
DELSETC ;Allows Cross-Servicing Recall to be deleted for case
 W !!,*7,"This case has already been set for recall from Cross-Servicing."
 S DIR(0)="Y",DIR("A")="Do you wish to delete the Cross-Servicing Recall for this case",DIR("B")="NO" D ^DIR G SETCQ:'Y
 ;
 ;delete the case recall
 F I=11:1:13 S $P(^PRCA(430,BILL,15),U,I)=""
 F I=2:1:5 S $P(^PRCA(430,BILL,15),U,I)=""
 D DELSETC^RCTCSPD4 ; *315 Create CS Delete Case Recall comment tx in 433 
 W !!,"Recall from Cross-Servicing has been deleted for this case."
 G SETCQ
 ;
SETCQ Q
 ;
SSN(DEBT) ;Get SSN for debtor
 ;Input Debtor (340)
 ;Output: SSN # or null
 NEW Y
 S Y=-1 G:'$G(DEBT) Q1
 S:DEBT?1N.N DEBT=$P($G(^RCD(340,DEBT,0)),"^")
 I DEBT[";DPT(" S Y=$P($G(^DPT(+DEBT,0)),"^",9)
 I DEBT[";VA(200," S Y=$P($G(^VA(200,+DEBT,1)),"^",9)
Q1 Q Y
 ;
 Q
