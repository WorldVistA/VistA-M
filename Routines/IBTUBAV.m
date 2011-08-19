IBTUBAV ;ALB/AAS - UNBILLED AMOUNTS - AVERAGE BILL AMOUNT LOGIC ; 29-SEP-94
 ;;2.0;INTEGRATED BILLING;**19,123**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; - Entry point for manual option.
 I '$D(DT) D DT^DICRW
 W !
 ;
DATE ; - Select date.
 W ! D DT2^IBTUBOU("Average Bill Amounts") G:IBTIMON="^" END
 ;
DEV ; - Select device.
 W !!,"This will automatically be tasked to run and needs no device."
 W !!,"A mail Message will be sent when the process completes."
 W !,"Use the option View Unbilled Amounts to see cumulative totals.",!!
 S ZTRTN="DQ^IBTUBAV",ZTSAVE("IB*")="",ZTIO=""
 S ZTDESC="IB - Generate Avg. Bill Amounts for a Month"
 D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 ;
AUTO ; - Entry point for scheduled option (update monthly number of bills
 ;   and prior 12 months fields).
 ;
 S IBCOMP=1  ; This will cause the mail msg to be sent to all the users
 ;             on the Unbilled Amounts mail group (see SEND^IBTUBUL).
 ;
DQ ; - Entry point for user options when queued.
 K ^TMP($J,"IBTUBAV"),^TMP($J,"IBTUBAV1")
 ;
 ; - If no IBTIMON or in the future, sets it with current Month
 I '$G(IBTIMON)!($G(IBTIMON)>(DT\100*100)) S IBTIMON=DT\100*100
 ;
 ; - Sets IBGMON with the 1st month 1 year prior to IBTIMON
 S IBGMON=IBTIMON-10000
 ;
 ; AUG/1993 should be the first month in the Unbilled Amounts File
 I IBGMON>2930800,'$D(^IBE(356.19,2930800,0)) D
 . S IBGMON=2930800
 ;
 ; - Calculate/Store the Unbilled Amounts Data for the past 12 months
 ;   (Prior to IBTIMON, does NOT include IBTIMON)
 F  Q:IBGMON'<IBTIMON  D
 . ; - If there is no entry for the month, try to create an entry
 . I '$D(^IBE(356.19,IBGMON,0)),'$$ADD(IBGMON) D  Q
 . . S IBGMON=$$FMADD^XLFDT(IBGMON,32)\100*100
 . ;
 . D MONTH(IBGMON)  ; - Calculate MONTHLY totals and store if necessary
 . D YEAR(IBGMON)   ; - Calculate YEARLY  totals and store if necessary
 . ;
 . S IBGMON=$$FMADD^XLFDT(IBGMON,32)\100*100
 ;
 ; - Calculate/Store MONTHLY & YEARLY totals for IBTIMON, if not the
 ;   current month
 I $$ADD(IBTIMON),IBTIMON<(DT\100*100) D MONTH(IBTIMON,1)
 D YEAR(IBTIMON,1)
 ;
 I $D(^TMP($J,"IBTUBAV"))!($D(^TMP($J,"IBTUBAV1"))) D SEND
 ;
END K ^TMP($J,"IBTUBAV"),^TMP($J,"IBTUBAV1")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K IBTIMON,IBCOMP,D,DIRUT,D0,%DT
 Q
 ;
MONTH(IBYRMO,IBOVRW) ; - Calculate/update Inpatient Unbilled Amounts
 ; Input: IBYRMO - YEAR/MONTH (YYYMM00) being calculated/updated
 ;        IBOVRW - Overwrite the data currently on file? (1-YES/0-NO) 
 ;
 N BGDT,ENDT,IBAVG,IBAMT,IBDA,IBDFN,IBDT,IBNOD,X
 ;
 I '$G(IBYRMO) Q
 K ^TMP($J,"IBTUBAV2")
 ;
 ; - If MONTHLY Average has already been calculated & NOT Overwrite->QUIT
 I '$G(IBOVRW),$P($G(^IBE(356.19,IBYRMO,1)),"^",13)'="" Q
 ;
 S BGDT=IBYRMO+1,ENDT=IBYRMO+32
 ;
 ; - Initialize the IBAVG array (set at line tag INPT)
 F X="I","P" S (IBAVG("$AMNT-"_X),IBAVG("BILLS-"_X),IBAVG("EPISD-"_X))=0
 ;
 ; - Loop through date entered x-ref starting a year prior to the period
 S IBDT=BGDT-10000
 F  S IBDT=$O(^DGCR(399,"APD",IBDT)) Q:'IBDT!(IBDT>ENDT)  D
 . S IBDA=0 F  S IBDA=$O(^DGCR(399,"APD",IBDT,IBDA)) Q:'IBDA  D
 . . S IBNOD=$G(^DGCR(399,+IBDA,0))
 . . I $P(IBNOD,U,11)'="i" Q         ; Not reimbursable insurance bill
 . . S X=$P(IBNOD,U,13) Q:X<3!(X>6)  ; Status not authorized or printed
 . . S X=$P($G(^DGCR(399,+IBDA,"S")),U,10)
 . . I X=""!(X<BGDT)!(X>ENDT) Q      ; Date authorized must be in period
 . . I $P(IBNOD,U,5)<3 D INPT
 ;
 ; - Updates file #356.19 with MONTHLY totals (Inpatient)
 S IBAVG("$AMNT-I")=$J(IBAVG("$AMNT-I"),0,2)
 S IBAVG("$AMNT-P")=$J(IBAVG("$AMNT-P"),0,2)
 D LD^IBTUBOU(1,IBYRMO) S ^TMP($J,"IBTUBAV",IBYRMO)=""
 ;
 K ^TMP($J,"IBTUBAV2") Q
 ;
INPT ; - For inpatient bills (add count of bills/total dollars).
 S IBDFN=$P(IBNOD,U,2,3),IBAMT=+$G(^DGCR(399,IBDA,"U1"))
 I $P(IBNOD,U,27)=1!($P(IBNOD,U,19)=3) D  G INP1
 . S IBAVG("BILLS-I")=IBAVG("BILLS-I")+1
 . S IBAVG("$AMNT-I")=IBAVG("$AMNT-I")+IBAMT
 . S IBDFN=IBDFN_"^I"
 ;
 I $P(IBNOD,U,27)=2!($P(IBNOD,U,19)=2) D  G INP1
 . S IBAVG("BILLS-P")=IBAVG("BILLS-P")+1
 . S IBAVG("$AMNT-P")=IBAVG("$AMNT-P")+IBAMT
 . S IBDFN=IBDFN_"^P"
 ;
 G INPQ
 ;
INP1 ; - Add number of inpatient episodes.
 I '$D(^TMP($J,"IBTUBAV2",IBDFN)) D
 . S Y=$P(IBDFN,U,3),IBAVG("EPISD-"_Y)=IBAVG("EPISD-"_Y)+1
 . S ^TMP($J,"IBTUBAV2",IBDFN)=""
 ;
INPQ Q
 ;
YEAR(IBYRMO,IBOVRW) ; - Calculate YEARLY totals, and store if necessary
 ; - Input: IBYRMO - YEAR/MONTH (YYYMM00) being calculated/updated
 ;          IBOVRW - Overwrite the data currently on file? (1-YES/0-NO) 
 ;
 N IBAVG,IBTMON,IBGMON,IBTNMON,DA,DIC,DIE,DR,SUBCNT,I,X
 I IBYRMO>(DT\100*100) G YEARQ ; Don't compile for future months.
 ;
 ; - If YEARLY Average has already been calculated -> QUIT
 I '$G(IBOVRW),$P($G(^IBE(356.19,IBYRMO,1)),"^",14)'="" Q
 ;
 ; - Initialize the array IBAVG for Institutional and Professional
 F X="I","P" D
 . S (IBAVG("$AMNT-"_X),IBAVG("BILLS-"_X),IBAVG("EPISD-"_X))=0
 ;
 ; Sets IBGMON with the 1st day of month 1 year prior to IBYRMO
 S IBGMON=IBYRMO-9999,SUBCNT=0
 F I=1:1:12 S IBTMON=IBGMON\100*100 Q:IBTMON'<IBYRMO  D
 . S X=$G(^IBE(356.19,IBTMON,1))
 . S IBAVG("BILLS-I")=IBAVG("BILLS-I")+$P(X,U)
 . S IBAVG("$AMNT-I")=IBAVG("$AMNT-I")+$P(X,U,2)
 . S IBAVG("EPISD-I")=IBAVG("EPISD-I")+$P(X,U,3)
 . S IBAVG("BILLS-P")=IBAVG("BILLS-P")+$P(X,U,4)
 . S IBAVG("$AMNT-P")=IBAVG("$AMNT-P")+$P(X,U,5)
 . S IBAVG("EPISD-P")=IBAVG("EPISD-P")+$P(X,U,6)
 . S IBGMON=$$FMADD^XLFDT(IBGMON,31),SUBCNT=SUBCNT+1
 ;
 I SUBCNT<6 G YEARQ ;   If less than 6 months of data don't store.
 S IBAVG("$AMNT-I")=$J(IBAVG("$AMNT-I"),0,2)
 S IBAVG("$AMNT-P")=$J(IBAVG("$AMNT-P"),0,2)
 D LD^IBTUBOU(2,IBYRMO) ; Add to file #356.19 entry.
 S ^TMP($J,"IBTUBAV1",IBYRMO)=""
 ;
YEARQ Q
 ;
SEND ; - Send a mail message to the Unbilled Amounts mail group informing
 ;   which months had their data (MONTHLY & YEARLY) updated.
 N IBCNT,IBGRP,IBDT,IBT,XCNP,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,I,X
 S XMSUB="UNBILLED AMOUNTS JOB FOR "_$$DAT2^IBOUTL(IBTIMON)
 S IBT(1)="The background job responsible for calculating and updating MONTHLY and"
 S IBT(2)="YEARLY Average Bill Amounts and Bill numbers for inpatient episodes has"
 S IBT(3)="successfully completed.",IBT(4)=""
 S IBCNT=5,IBDT=0
 F  S IBDT=$O(^TMP($J,"IBTUBAV",IBDT)) Q:'IBDT  D
 . S IBT(IBCNT)="Monthly totals calculated for "_$$DAT2^IBOUTL(IBDT)
 . S IBCNT=IBCNT+1
 S IBT(IBCNT)="",IBCNT=IBCNT+1,IBDT=0
 F  S IBDT=$O(^TMP($J,"IBTUBAV1",IBDT)) Q:'IBDT  D
 . S IBT(IBCNT)="Yearly totals calculated for "_$$DAT2^IBOUTL(IBDT)
 . S IBCNT=IBCNT+1
 S IBT(IBCNT)="" D SEND^IBTUBUL
 ;
 Q
 ;
ADD(IBYRMO) ; - Add entry to file 356.19 (unbilled amounts file).
 ;    Input: IBYRMO=date/time in month year format no days allowed
 ;   Output: IBADD=1-entry or entry added, 0-not added or error
 N IBADD,DA,DD,DIC,DIE,DO,DR,Y S IBADD=0
 I IBYRMO'?7N!($E(IBYRMO,6,7)'="00") G ADDQ
 I $D(^IBE(356.19,IBYRMO,0)) S IBADD=1 G ADDQ
 S DIC="^IBE(356.19,",DIC(0)="L",DLAYGO=356.19
 L +^IBE(356.19,IBYRMO):0
 I $T S (DINUM,X)=IBYRMO D FILE^DICN I +Y>0 S IBADD=1
 L -^IBE(356.19,IBYRMO)
 ;
ADDQ Q IBADD
