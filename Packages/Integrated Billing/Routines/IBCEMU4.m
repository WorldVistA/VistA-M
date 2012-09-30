IBCEMU4 ;ALB/ESG - MRA UTILITIES ;25-OCT-2004
 ;;2.0;INTEGRATED BILLING;**288,432,447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
DENDUP(IBEOB,IBMRANOT) ; Denied for Duplicate Function ;WCJ IB*2.0*432
 ; Function returns true if MRA is Denied AND Reason code 18 is present (Duplicate claim/service)
 NEW IBX,IBM,LINE,DUP,ADJ
 S IBX=0,IBM=$G(^IBM(361.1,+$G(IBEOB),0))
 I '$G(IBMRANOT),$P(IBM,U,4)'=1 G DENDUPX    ; not an MRA  ;WCJ IB*2.0*432
 I $G(IBMRANOT),$P(IBM,U,4)'=0 G DENDUPX    ; not an EOB ;WCJ IB*2.0*432
 I $P(IBM,U,13)'=2 G DENDUPX   ; not Denied
 ;
 ; check line item adjustments for reason code 18
 S LINE=0,DUP=0
 F  S LINE=$O(^IBM(361.1,IBEOB,15,LINE)) Q:'LINE  D  Q:DUP
 . S ADJ=0
 . F  S ADJ=$O(^IBM(361.1,IBEOB,15,LINE,1,ADJ)) Q:'ADJ  D  Q:DUP
 .. I $D(^IBM(361.1,IBEOB,15,LINE,1,ADJ,1,"B",18)) S DUP=1 Q
 .. Q
 . Q
 ;
 I DUP S IBX=1
DENDUPX ;
 Q IBX
 ;
 ; the remaining functions are all new w/ IB*2.0*447 and have to do with calculating
 ; different amounts based on percentages stored in the effective date multiple of
 ; the TYPE OF PLAN file (#355.1) for Medicare Supplemental plans
 ;
MSPRE(IBIFN,IBEXF,IBTYPLAN) ; Medicare supplemental PR and Excess calculations
 ; determine PR amount in order to calculate balance due after medicare for secondary/tertiary
 ; if type of plan is a Medicare supplemental or EGHP plan secondary to Medicare, PR 
 ; calculations are determined based on the effective date multiple in the TYPE OF PLAN file
 ; and may or may not included Excess charges (CO-45), based on Plan Type.
 ; need to pass in:
 ;  IBIFN (REQUIRED) = claim ien
 ;  IBEXF = Excess Flag, set to 1 if NOT to include excess charges in calculation but to
 ;          return "e" (IBE) for excess indicator if plan allows excess and there are 
 ;          excess charges.  Used by PR column of MRW screen to show PR without excess
 ;          amounts included in calculation.
 ;  IBTYPLAN = ien in TYPE OF PLAN file (355.1)
 ;  returns "" if no effective date for type of plan to calculate on
 ;
 N IBFRMTYP,IBPNCAT,IBINPAT,IBMGBD,IBEOB,LNLVL,EOBADJ,IBPCE,IBEDT,IBE,IBTOT
 Q:$G(IBIFN)="" ""
 S:$G(IBTYPLAN)="" IBTYPLAN=$$TYPLN(IBIFN)
 S IBEDT=$$MSEDT(IBIFN,IBTYPLAN) Q:IBEDT="" ""
 S IBINPAT=$$INPAT^IBCEF(IBIFN)     ;Inpat/Outpat Flag
 S IBFRMTYP=$P($G(^DGCR(399,IBIFN,0)),U,19)  ; Form Type 2=1500, 3=UB
 ; plan category - PART A is Inpatient Institutional, B is all Outpatient and Inpatient Professional
 S IBPNCAT="B"
 I IBINPAT=1,IBFRMTYP=3 S IBPNCAT="A" Q:IBPNCAT="" ""
 ; Medicare supplemental plan  Offset amount = total charges - what medicare secondary plan will pay
 ; so balance due = whatever medicare secondary will pay
 ;
 ; plan category - PART A =1st piece of AEDT Index, B =2nd
 S IBPCE=$S(IBPNCAT="B":2,1:1)
 S IBMGBD=0,IBEOB=0
 F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D
 .N I
 .F I=0,1,2 S IBEOB(I)=$G(^IBM(361.1,IBEOB,I))
 .I $P(IBEOB(0),U,4)'=1 Q  ;make sure it's an MRA
 .;
 .; Handle CMS-1500 Form Type and UB Outpatient:
 .I IBFRMTYP=2!('IBINPAT) D  Q
 ..; calculate Medicare unpaid amount from line-level (outpatient)
 ..S LNLVL=0 F  S LNLVL=$O(^IBM(361.1,IBEOB,15,LNLVL)) Q:'LNLVL  D  ;
 ...K EOBADJ
 ...M EOBADJ=^IBM(361.1,IBEOB,15,LNLVL,1)
 ...; Total up the Medicare Contract Adjustment across ALL Service Lines to find
 ...; Medicare supplemental Balance Due
 ...S IBTOT=$$CALC(.EOBADJ,IBTYPLAN,IBPCE,IBEDT,$G(IBEXF)),IBE=$P(IBTOT,U,2)
 ...S IBMGBD=$G(IBMGBD)+$P(IBTOT,U)
 .;
 .; Handle Inpatient UB Form Type Next:  Calculate from Claim level data
 .K EOBADJ
 .M EOBADJ=^IBM(361.1,IBEOB,10)
 .S IBTOT=$$CALC(.EOBADJ,IBTYPLAN,IBPCE,IBEDT,$G(IBEXF)),IBE=$P(IBTOT,U,2)
 .S IBMGBD=$G(IBMGBD)+$P(IBTOT,U)
 Q IBMGBD_$G(IBE)
 ;
CALC(EOBADJ,IBTYPLAN,IBPCE,IBEDT,IBEXF) ; FUNCTION - Calculate Medicare Supplemental Balance due
 ; Sums up Amounts on ALL Reason Codes under ALL Group Codes = 'PR' and CO/Reason code=45.
 ; If those reason codes have an entry in the effective date mutliple, multiples that
 ; reason amount by the % the Type of plan will pay.  If no entry, assume 100% payment for PR.
 ; any other Group and reason codes would be 0%. 
 ; Adds up all those sums and returns that value as the total PR&CO the Medicare 
 ; Supplemental plan will pay.
 ;
 ; Input  EOBADJ = Array of Group Codes & Reason Codes from either the Claim 
 ;                 Level (10) or Service Line Level (15) of EOB file (#361.1)
 ; IBTYPLAN = ien in TYPE OF PLAN file 
 ; IBPCE = 2 for PART A, 3 for PART B - REQUIRED
 ; IBEDT = effective date of plan rates 
 ; IBEXF = Excess Flag, set to 1 if NOT to include excess charges in calculation but to
 ;          return "e" for excess indicator if plan allows excess and there are excess 
 ;          charges.   Used by PR column of MRW screen to show PR without excess
 ;          amounts included in calculation.
 ; Output  amount that Medicare supplemental plan will pay
 ;
 N GRPLVL,RSNLVL,RSNAMT,MCA,GRPCD,RSNCD,RSN0,CALC,IBIND
 Q:$G(IBPCE)="" ""
 S:$G(IBTYPLAN)="" IBTYPLAN=$$TYPLN(IBIFN)
 I $G(IBEDT)="" S IBEDT=$$MSEDT(IBIFN,IBTYPLAN) Q:IBEDT="" ""
 S (GRPLVL,MCA)=0
 F  S GRPLVL=$O(EOBADJ(GRPLVL)) Q:'GRPLVL  D 
 .S GRPCD=$P($G(EOBADJ(GRPLVL,0)),U)
 .; For now they want to calculate all PR but only apply %age calcs to PR-1,2 & 3 
 .I GRPCD'="PR" Q:'$D(^IBE(355.1,IBTYPLAN,14,"AEDT",IBEDT,GRPCD))
 .S RSNLVL=0
 .F  S RSNLVL=$O(EOBADJ(GRPLVL,1,RSNLVL)) Q:'RSNLVL  D  ;
 ..S RSN0=$G(EOBADJ(GRPLVL,1,RSNLVL,0)),RSNAMT=$P(RSN0,U,2),RSNCD=$P(RSN0,U)
 ..I GRPCD="PR",RSNCD="AAA" Q  ; ignore PR-AAA
 ..; For now they want to calculate all PR but only apply %age calcs to PR-1,2 & 3
 ..I GRPCD="PR","1^2^3"'[RSNCD,'$D(^IBE(355.1,IBTYPLAN,14,"AEDT",IBEDT,GRPCD,RSNCD)) S MCA=MCA+RSNAMT Q
 ..Q:'$D(^IBE(355.1,IBTYPLAN,14,"AEDT",IBEDT,GRPCD,RSNCD))
 ..; if there is an entry in the effective date multiple for this grp/rsn code use it to calculate amount for PART A and B.
 ..; for MRW, don't add up excess charges if IBEXF=1, just send back an "e" indicator to alert user of excess  
 ..I $G(IBEXF)=1,GRPCD="CO",RSNCD=45,$P($G(^IBE(355.1,IBTYPLAN,14,"AEDT",IBEDT,GRPCD,RSNCD)),U,IBPCE)>0 S IBIND="e" Q
 ..S CALC=$P($G(^IBE(355.1,IBTYPLAN,14,"AEDT",IBEDT,GRPCD,RSNCD)),U,IBPCE)/100
 ..S MCA=MCA+(RSNAMT*CALC)
 Q MCA_U_$G(IBIND)
 ;
MSEDT(IBIFN,IBTYPLAN) ; does this claim's TYPE OF PLAN have an effective date multiple on or before the
 ; claim 'statement covers from' date
 ; IBIFN = claim ien - REQUIRED
 ; IBTYPLAN = Type of Plan ien
 ; returns eff.date calculation multiple to use or null
 ; called from SKIP^IBCCCB, BLD^IBCECOB1, TOT^IBCECOB2, CRIT^IBCEMQC, & SECOND^IBCEMSR
 ;
 ; IB*2.0*447:  the below quit statement has been added because CBO has decided not to implement
 ; these changes with patch 447 after all.  Once a long-term maintenance plan for the plan type
 ; calculations can be worked out and CBO is ready to implement the special calculations, the
 ; below quit statement and these comments should be removed and the type of plan special calculations 
 ; will immediately take effect.  For now, returning a null will allow existing code to bypass 
 ; the special calculation table in file 355.1 and calculate everything as 100% of Patient Responsibility (PR).
 Q ""
 ;
 N IBSVDT
 Q:$G(IBIFN)="" ""
 S:$G(IBTYPLAN)="" IBTYPLAN=+$$TYPLN(IBIFN)
 S IBSVDT=+$P($G(^DGCR(399,IBIFN,"U")),U)
 Q:$D(^IBE(355.1,IBTYPLAN,14,"B",IBSVDT)) IBSVDT
 Q $O(^IBE(355.1,IBTYPLAN,14,"B",IBSVDT),-1)
 ;
TYPLN(IBIFN) ; find type of plan for claim
 ; IBIFN = claim ien - REQUIRED
 ; returns ien from file 355.1 or null if none found
 ;
 Q:$G(IBIFN)="" ""
 N IBCOBN,IBGRPNO
 S IBCOBN=$$COBN^IBCEF(IBIFN)+1 ;find next payer
 S IBGRPNO=+$P($G(^DGCR(399,IBIFN,"I"_IBCOBN)),U,18) ; group plan number
 Q $P($G(^IBA(355.3,IBGRPNO,0)),U,9) ; type of plan - IEN
 ;
