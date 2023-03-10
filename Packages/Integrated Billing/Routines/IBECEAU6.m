IBECEAU6 ;EDE/YMG - Cancel Charge ; 03/09/2021
 ;;2.0;INTEGRATED BILLING;**703**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CANCEL(IBN,IBCRES,IBCLK,IBCAP) ; cancel a single charge
 ;
 ; IBN    - ien of the charge to cancel (file 350)
 ; IBCRES - cancellation reason (from file 350.3)
 ; IBCLK  - 1 = update billing clock, 0 = leave billing clock alone
 ; IBCAP  - 1 = update caps, 0 = leave caps alone
 ;
 ; returns 1 if successful, "-1^[optional error code]^[optional error message]" otherwise
 ;
 N DFN,IBACT,IBAMC,IBATYP,IBCANTR,IBCHG,IBCOPAY,IBFAC,IBFR,IBIL,IBH,IBND,IBPRNT,IBSEQNO,IBSITE,IBSTAT,IBUC,IBUNIT,IBXA,IBY,SVZTQ
 N IBCLDA,IBCLST  ; set by CLSTR^IBECEAU1
 N IBNOS,IBSERV,Y  ; used in ^IBR
 ;
 S IBY=1
 ; perform up-front edits and set variables
 D CED I IBY<0 Q IBY
 ; check cancellation reason
 I +IBCRES'>0 S IBY="-1^^Missing cancellation reason" Q IBY
 I $P(^IBE(350.3,IBCRES,0),U,6) S IBY="-1^^Cancellation reason is inactive"
 S IBUC=$$GET1^DIQ(350.1,$P(IBND,U,3)_",",.01,"E")["URGENT CARE"  ; 1 if urgent care charge
 I IBUC,'$P(^IBE(350.3,IBCRES,0),U,4) S IBY="-1^^Please use an Urgent Care cancellation reason." Q IBY
 I IBUC,IBSTAT'=8,IBIL="" Q IBY
 D SITE^IBAUTL ; set IBSITE and IBFAC vars
 S DFN=$P(IBND,U,2)  ; patient's DFN
 I IBUC D UCVSTDB I IBY<0 Q IBY
 ; handle CHAMPVA/TRICARE charges
 I IBXA=6!(IBXA=7) D CANC(IBN,IBCRES,1) Q IBY
 ; handle cancellation transactions
 I IBCANTR D  Q IBY
 .I IBN=IBPRNT D UPSTAT(IBN,1) Q
 .I 'IBIL S IBIL=$P($G(^IB(IBPRNT,0)),U,11) I 'IBIL S IBY="-1^^There is no bill number associated with this charge" Q
 .D UPCANC(IBN,IBRES,IBIL)
 .; pass the action to Accounts Receivable.
 .D ^IBR S IBY=Y
 .Q
 ; update 354.71 and 354.7 (cap info)
 I IBCAP D  I IBY<0 Q
 .S IBCOPAY=$P(IBND,U,19)  ; copay transaction #
 .; FOUND^IBARXMA needs ZTQUEUED to be defined in order to suppress the output
 .S SVZTQ=0 S:'$D(ZTQUEUED) (SVZTQ,ZTQUEUED)=1
 .I IBCOPAY S IBAMC=$$CANCEL^IBARXMN(DFN,IBCOPAY,.IBY) I IBY>0  D:IBAMC FOUND^IBARXMA(.IBY,IBAMC)
 .I SVZTQ K ZTQUEUED
 .Q
 ; handle incomplete and regular transactions
 D CANC(IBN,IBCRES,1) I IBY<1 Q IBY
 ; handle billing clock
 I IBCLK D
 .I "^1^2^3^"[(U_IBXA_U),IBCHG D
 ..D CLSTR^IBECEAU1(DFN,IBFR) I 'IBCLDA S IBY="-1^^No billing clock found for this charge" Q
 ..D CLOCK(-IBCHG,+$P(IBCLST,U,9),-IBUNIT)
 ..Q
 .Q
 ;
 Q IBY
 ;
CED ; Edits required to cancel a charge.
 ;
 ; IBN - ien of the charge to cancel (file 350)
 ;
 S IBND=$G(^IB(IBN,0)) I 'IBND S IBY="-1^IB021" G CEDQ  ; node 0 in file 350
 S IBPRNT=+$P(IBND,U,9) I '$D(^IB(IBPRNT,0)) S IBY="-1^IB027" G CEDQ  ; ptr to parent charge in file 350
 ; make sure that we're cancelling the last transaction 
 I $$LAST^IBECEAU(IBPRNT)'=IBN S IBY="-1^^You can only cancel the last transaction for an original charge" G CEDQ
 S IBACT=$G(^IBE(350.1,+$P(IBND,U,3),0))  ; node 0 in file 350.1 for the action type of this charge
 S IBSTAT=+$P(IBND,U,5)  ; status (350/.05)
 S IBH='$P($G(^IBE(350.21,IBSTAT,0)),U,4)  ; 1 if charge was not passed to AR
 S IBCANTR=$P(IBACT,U,5)=2  ; action type of this action is "cancel"
 S IBXA=$P(IBACT,U,11)  ; billing group
 ;if charge has already been cancelled, and either passed to AR or belongs to billing groups 6,7
 I IBCANTR!(IBSTAT=10),'IBH!(IBXA=6!(IBXA=7)) S IBY="-1^^This transaction has already been cancelled." G CEDQ
 S IBATYP=$P(IBACT,U,6)  ; ptr to cancellation action
 I '$D(^IBE(350.1,+IBATYP,0)) S IBY="-1^IB022" G CEDQ
 ; make sure that cancellation action has action type defined
 S IBSEQNO=$P(^IBE(350.1,+IBATYP,0),U,5) I 'IBSEQNO S IBY="-1^IB023" G CEDQ
 S IBIL=$P(IBND,U,11)  ; AR bill #
 S IBUNIT=+$P(IBND,U,6)  ; units
 S IBCHG=+$P(IBND,U,7)  ; total charge
 S IBFR=$P(IBND,U,14)  ; billed from
 I IBUNIT<1 S IBY="-1^IB025" G CEDQ
 I 'IBH,'IBCHG S IBY="-1^^There is no charge amount associated with this action." G CEDQ
 I 'IBH,IBIL="" S IBY="-1^IB024"
CEDQ ; exit point
 Q
 ;
UPDVST(IBCAN) ; update the Visit Tracking file
 ;
 ; IBCAN - Type of Update to perform
 ;   1 - Remove with Entered in Error Message
 ;   2 - Visit Only Update
 ;   3 - Free (if free not used) or Visit Only
 ;   4 - Remove with Duplicate Error message
 ;
 N IBBLNO,IBVSTIEN,IBREAS,IBRTN,IBERROR,IENS,UCSTAT
 ;
 S IENS=IBN_","
 ;Locate the IEN in the file using the Bill Number
 S IBBLNO=$S(IBSTAT=8:"ON HOLD",1:IBIL) S:$E(IBBLNO,1)="K" IBBLNO=IBSITE_"-"_IBBLNO
 S IBVSTIEN=$$FNDVST^IBECEA4(IBBLNO,IBFR,DFN)
 I +IBVSTIEN=0 Q
 ;Set Status and Reason based on update type.
 S:IBCAN=1 IBREAS=3,UCSTAT=3   ;Visits Removed
 S:IBCAN=2 IBREAS=5,UCSTAT=4   ;Visit set to Visit Only
 S:IBCAN=3 IBREAS=1,UCSTAT=1   ;Free visit
 S:IBCAN=4 IBREAS=4,UCSTAT=3   ;Duplicate Visit
 ;
 S IBRTN=$$UPDATE^IBECEA38(IBVSTIEN,UCSTAT,"",IBREAS,1,.IBERROR)
 I IBRTN=0 S IBY="-1^^Unable to update UC visit tracking file"
 Q
 ;
UCVSTDB ; Update the UC Visit Tracking
 ;
 N IBELIG,IBNOFRVS,IBUCBH
 ;
 S IBUCBH=$P(^IBE(350.3,IBCRES,0),U,5)  ; UC visit processing (350.3/.05)
 ;cancellation reasons deemed to be data entry errors
 I IBUCBH=1 D UPDVST(1) Q
 ;For those cancellation reasons deemed to be duplicate visits
 I IBUCBH=4 D UPDVST(4) Q
 ;For those cancellation reasons that need to keep the visit as visit only....
 I IBUCBH=2 D UPDVST(2) Q
 ;
 ;For other valid UC cancellation reasons, assuming that they are 3's (need free visit check)
 S IBELIG=$$GETELGP^IBECEA36(DFN,IBFR)
 I IBELIG'<6 D UPDVST(2) Q  ; priority group 6,7, or 8
 ;Retrieve # visits
 S IBNOFRVS=$P($$GETVST^IBECEA36(DFN,IBFR),U,2)
 ;If free visit remain, convert visit to Free Visit
 I IBNOFRVS<3 D UPDVST(3) Q
 ;Otherwise, visit only.
 D UPDVST(2)
 Q
 ;
CANC(IBCN,IBCRES,IBINC) ; Cancel a charge, after passing all edits
 ;
 ;  IBCN  --  Internal entry # of IB Action to cancel
 ;  IBCRES --  Cancellation reason
 ;  IBINC --  Try to cancel an incomplete charge? [optional]
 ;
 N FDA,IBDUZ,IENS,Z
 ; handle incomplete transactions
 I $G(IBINC),IBH D UPSTAT(IBCN,IBCRES) Q
 ; handle regular transactions
 L +^IB(0):10 I '$T S IBY="-1^B014" Q
 ; create new entry in file 350
 S Z=$$ADD350(DFN,IBSITE,IBATYP) I +Z<0 S IBY=Z L -^IB(0) Q
 S IENS=Z_",",IBNOS=Z
 ;
 S IBDUZ=$S($G(DUZ)>0:DUZ,1:.5)
 ; populate the new file 350 entry
 S FDA(350,IENS,.04)=$P(IBND,U,4)
 S FDA(350,IENS,.06)=IBUNIT
 S FDA(350,IENS,.07)=IBCHG
 S FDA(350,IENS,.08)=$P(IBND,U,8)
 S FDA(350,IENS,.09)=IBPRNT
 S FDA(350,IENS,.1)=IBCRES
 S FDA(350,IENS,.11)=IBIL
 S FDA(350,IENS,.13)=$P(IBND,U,13)
 S FDA(350,IENS,.14)=IBFR
 S FDA(350,IENS,.15)=$P(IBND,U,15)
 S FDA(350,IENS,.16)=$P(IBND,U,16)
 I IBXA=5 S FDA(350,IENS,.17)=$P(IBND,U,17)
 S FDA(350,IENS,.2)=$P(IBND,U,20)
 S FDA(350,IENS,.21)=$P(IBND,U,21)
 S FDA(350,IENS,.22)=$P(IBND,U,22)
 S FDA(350,IENS,11)=IBDUZ
 D FILE^DIE("","FDA")
 L -^IB(0)
 ; pass the action to Accounts Receivable.
 D ^IBR S IBY=Y I IBY<0 Q
 ; cancel original charge (if it was an updated transaction)
 I $D(^IB(IBCN,0)),IBSTAT'=10 D UPSTAT(IBCN,IBCRES)
 Q
 ;
UPSTAT(IBCN,IBCRES) ; Update the status, cancellation reason of incomplete charges.
 ;
 ;  IBCN  --  Internal entry # of IB Action to cancel
 ;  IBCRES --  Cancellation reason
 ;
 N DIE,DA,DR,X,Y
 S DIE="^IB(",DA=IBCN,DR=".05////10;.1////"_IBCRES
 D ^DIE
 Q
 ;
UPCANC(IBCN,IBRES,IBIL) ; Update cancellation transaction
 ;
 ;  IBCN  --  Internal entry # of IB Action to cancel
 ;  IBCRES --  Cancellation reason
 ;  IBIL -- AR bill #
 ;
 N DIE,DA,DR,X,Y
 S DIE="^IB(",DA=IBCN,DR=".1////"_IBCRES_";.11////"_IBIL D ^DIE
 Q
 ;
CLOCK(IBDOL,IBDAYPR,IBDAY) ; Update clock data.
 ;
 ; IBDOL  --  Dollar amount to add or subtract
 ; IBDAYPR  --  Existing number of inpatient days
 ; IBDAY  --  Inpatient days to add or subtract
 ; Also assumes that IBCLST, IBCLDA, and IBXA are defined.
 ;
 I IBXA=1!(IBXA=2) D CLAMT(IBCLST,IBDOL,IBCLDA)
 I IBXA=3 D CLINP(IBDAYPR,IBDAY,IBCLDA)
 Q
 ;
CLAMT(STR,AMT,IBCLDA) ; Update Billing Clock Medicare Deductible co-payments
 ;
 ;  STR  --  Zeroth node of clock in file #351
 ;  AMT  --  Dollar Amt to add to clock (could be negative)
 ;  IBCLDA  --  Pointer to clock in file #351
 ;
 N DA,DAYS,DIE,DR,IBCLDT,NEWAMT,PTR
 I $G(STR)=""!'$G(AMT)!'$G(IBCLDA) Q
 S DAYS=+$P(STR,U,9),PTR=$S(DAYS<91:5,DAYS<181:6,DAYS<271:7,1:8)
 S IBCLDT=+$P(STR,U,3),NEWAMT=+$P(STR,U,PTR)+AMT
 I NEWAMT<0 S IBY="-1^^Unable to update the clock to reflect negative copayment" Q
 S DIE="^IBE(351,",DA=IBCLDA,DR=".0"_PTR_"////"_NEWAMT_";13////"_DUZ_";14///NOW" D ^DIE
 Q
 ;
CLINP(BEG,DIF,IBCLDA) ; Update Billing Clock Inpatient Days
 ;
 ;  BEG  --  Existing number of inpatient days
 ;  DIF  --  Days to add to clock (could be negative)
 ;  IBCLDA  --  Pointer to clock in file #351
 ;
 N DAYS
 I $G(BEG)=""!'$G(DIF)!'$G(IBCLDA) Q
 S DAYS=BEG+DIF
 I DAYS<0!(DAYS>365) S IBY="-1^^Unable to update the clock - invalid number of inpatient days" Q
 S DIE="^IBE(351,",DA=IBCLDA,DR=".09////"_DAYS_";13////"_DUZ_";14///NOW" D ^DIE
 Q
 ;
ADD350(DFN,IBSITE,IBATYP) ; add new entry to file 350 (wrapper for ADD^IBAUTL)
 ;
 ; DFN    - patient DFN
 ; IBSITE - station number
 ; IBATYP - action type
 ;
 ; returns IEN of the new entry on success or "-1^[error code]" on failure
 ;
 N DA,DD,DIC,DIE,DINUM,DLAYGO,DO,DR,IBN,IBN1,X,Y
 D ADD^IBAUTL
 ; IBN and Y are set in ADD^IBAUTL
 Q $S(+Y<0:Y,1:IBN)
