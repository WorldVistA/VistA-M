IBEFUNC ;ALB/RLW - EXTRINSIC FUNCTIONS ;12-JUN-92
 ;;2.0;INTEGRATED BILLING;**55,91,106,139,51,153,232,155,249,327,420**;21-MAR-94;Build 6
 ;
ETXT(X) ; -- output error text from 350.8
 ; -- input error code
 N Y S Y=X
 I X="" G ETXTQ
 S Y=$P($G(^IBE(350.8,+$O(^IBE(350.8,"AC",X,0)),0)),U,2)
ETXTQ Q Y
 ;
IGN(X,Y) ; ignore means test? for appt type on dates
 ; -- input x = mas appt type
 ;          y = appt date
 ;    output  = true if this appt type should not be billed for
 ;              Means Test billing (352.1,.04) for given date
 ;
 I '$G(X)!('$G(Y)) Q 1
 Q +$P($G(^IBE(352.1,+$O(^(+$O(^IBE(352.1,"AIVDT",+X,-(Y+.1))),0)),0)),U,4)
 ;
DSP(X,Y) ; display on input screen?
 ; --    input X = mas appt type (P409.1)
 ;             Y = date
 ;       output  = true if appt type X (352.1,.02) should be displayed as
 ;          a potential billable visit (352.1,.06) on given date Y (352.1,.03)
 ;
 I '$G(X)!('$G(Y)) Q 0
 Q +$P($G(^IBE(352.1,+$O(^(+$O(^IBE(352.1,"AIVDT",+X,-(Y+.1))),0)),0)),U,6)
 ;
RPT(X,Y) ; print on report?
 ; -- input X = mas appt type (P409.1)
 ;          Y = date
 ;    output  = true if appt type X (352.1,.02) should be printed on 'Vets w/ Ins and Opt
 ;               Visits' report (352.1,.05) on given date Y (352.1,.06)
 ;
 I '$G(X)!('$G(Y)) Q 0
 Q +$P($G(^IBE(352.1,+$O(^(+$O(^IBE(352.1,"AIVDT",+X,-(Y+.1))),0)),0)),U,5)
 ;
NBDIS(X,Y) ; Is disposition non-billable?
 ; -- input X = disposition (P37)
 ;          Y = date of appt
 ;    output  = true (1) if disposition should be ignored for
 ;              Means test billing (352.2,.03) for given date
 ;
 I '$G(X)!('$G(Y)) Q 0
 Q +$P($G(^IBE(352.2,+$O(^(+$O(^IBE(352.2,"AIVDT",+X,-(Y+.1))),0)),0)),U,3)
 ;
NBCSC(X,Y) ; Is clinic stop code non-billable?
 ; -- input X = clinic stop code (P40.7)
 ;          Y = date of appt
 ;    output  = true (1) if clinic stop code should be ignored for
 ;              Means test billing (352.3,.03) for given date
 ;
 I '$G(X)!('$G(Y)) Q 0
 Q +$P($G(^IBE(352.3,+$O(^(+$O(^IBE(352.3,"AIVDT",+X,-(Y+.1))),0)),0)),U,3)
 ;
NBCL(X,Y) ; Is clinic non-billable?
 ; -- input X = clinic (P44)
 ;          Y = date of appt
 ;    output  = true (1) if clinic should be ignored for
 ;              Means test billing (352.4,.03) for given date
 ;
 I '$G(X)!('$G(Y)) Q 0
 Q +$P($G(^IBE(352.4,+$O(^(+$O(^IBE(352.4,"AIVDT",+X,-(Y+.1))),0)),0)),U,3)
 ;
NBST(X,Y) ; Is clinic stop code non-billable for Third Party?
 ; -- input X = clinic stop code (P40.7), Y = appt date
 ;    output  = true (1) if stop non-billable for Third Party (352.3,.05) for given dt
 ;
 I '$G(X)!('$G(Y)) Q 0
 Q +$P($G(^IBE(352.3,+$O(^(+$O(^IBE(352.3,"AIVDTT2",+X,-(Y+.1))),0)),0)),U,5)
 ;
NBCT(X,Y) ; Is clinic non-billable for Third Party?
 ; -- input X = clinic (P44), Y = appt dt
 ;    output  = true (1) if clinic non-billable for Third Party (352.4,.05) for given date
 ;
 I '$G(X)!('$G(Y)) Q 0
 Q +$P($G(^IBE(352.4,+$O(^(+$O(^IBE(352.4,"AIVDTT2",+X,-(Y+.1))),0)),0)),U,5)
 ;
NABST(X,Y) ; Returns true (1) if stop code flagged to be ignored by Third Party auto biller (use DT)
 S:'$G(Y) Y=DT I '$G(X) Q 0
 Q +$P($G(^IBE(352.3,+$O(^(+$O(^IBE(352.3,"AIVDTT2",+X,-(Y+.1))),0)),0)),U,6)
 ;
NABCT(X,Y) ; Returns true (1) if clinic is flagged to be ignored by Third Party auto biller (use DT)
 S:'$G(Y) Y=DT I '$G(X) Q 0
 Q +$P($G(^IBE(352.4,+$O(^(+$O(^IBE(352.4,"AIVDTT2",+X,-(Y+.1))),0)),0)),U,6)
 ;
PT(DFN) ;returns (patient name^long pat id^short pat id) or null if not found
 N X,IBX S X="" I $D(DFN) S X=$G(^DPT(+DFN,0)) I X'="" S X=$P(X,U,1)_U_$P($G(^DPT(DFN,.36)),U,3,4) D
 . S IBX=$P(^DPT(+DFN,0),U,9)
 . I $P(X,U,2)="" S $P(X,U,2)=$E(IBX,1,3)_"-"_$E(IBX,4,5)_"-"_$E(IBX,6,10)
 . I $P(X,U,3)="" S $P(X,U,3)=$E(IBX,6,10)
 Q X
 ;
EXSET(X,D0,D1) ;returns external value of a set in file D0, field D1
 Q $$EXPAND^IBTRE($G(D0),$G(D1),$G(X))
 ;
BABCSC(DFN,IBDT) ; -- any billable Third Party visits in encounter file for patient
 ;  -- Input  dfn = patient,  ibdt = date
 ;     output     = 1 if any billable stop on date OR 0 if none
 ;
 N IBX,IBVAL,IBCBK,IBFILTER
 S IBX=0
 I '$G(DFN)!('$G(IBDT)) G BABQ
 ;
 S IBVAL("DFN")=DFN,IBVAL("BDT")=IBDT\1,IBVAL("EDT")=IBDT\1+.24
 ;Ignore if not chkd out, no stop, non-billable stop, non-billable clinic
 S IBFILTER=""
 S IBCBK="I $P(Y0,U,12)=2,$P(Y0,U,3),'$$NBST^IBEFUNC($P(Y0,U,3),+Y0),'$$NBCT^IBEFUNC(+$P(Y0,U,4),+Y0) S (IBX,SDSTOP)=1"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,"",IBCBK,1) K ^TMP("DIERR",$J)
 ;
BABQ Q IBX
 ;
APPTCT(IBOE0) ; Determine if appt encounter/appt has valid status for billing
 ; Returns 1 if valid, 0 if not
 ; IBOE0 = the encounter's 0-node (input)
 N STAT
 S STAT=$P(IBOE0,U,12) ;Encounter stat
 I STAT=14 S STAT=2
 ; Assume 1,2 (and 14 sometimes) are valid, 8 = INPATIENT
 Q STAT<3
 ;
NCTCL(IBOE0) ; Determine if a clinic for an outpt encounter is non-count
 ; IBOE0 = the 0-node of the encounter
 Q ($P($G(^SC(+$P(IBOE0,U,4),0)),U,17)="Y")
 ;
DISCT(IBOE,IBOE0) ; Determine if disposition has valid status for billing
 ; Returns 1 if valid, 0 if not valid
 ; IBOE = encounter ien
 ; IBOE0 = 0-node of encounter (optional)
 N IBX
 S IBX=$$DISND^IBSDU(IBOE,$G(IBOE0),2)
 Q (IBX<2)
 ;
NEEDMRA(IBIFN) ; Returns MRA NEEDED STATUS for bill
 Q $P($G(^DGCR(399,+IBIFN,"TX")),U,5)
 ;
REQMRA(IBIFN) ; Determine from site parameter, ins assigned to bill and txmn
 ;   rules if request for MRA is needed (MCRWNR must be current ins co)
 ; "R" = not needed due to next carrier not requiring it (txmn rules),
 ; "R1" = not needed due to MRA turned off at site
 ;  0 = not needed,  1 = needed
 N IB0,COBINS,COBSEQ,IBOK,Z1,Z0,IBDA,IB00,IB0
 ;
 I $$COB^IBCEF(IBIFN)="A" S IBOK=0 G REQMRAQ    ; payer sequence = patient not allowed for MRA
 S COBSEQ=$$COBN^IBCEF(IBIFN)
 S COBINS=$P($G(^DGCR(399,IBIFN,"M")),U,COBSEQ)
 ;Curr ins must = MEDICARE WNR
 S IBOK=+$$MCRWNR(COBINS)
 I 'IBOK G REQMRAQ
 ;
 I '$$EDIACTV^IBCEF4(2) S IBOK="R1" G REQMRAQ ; Site param=NO
 ;
 ; Check next ins for MRA needed
 I COBSEQ'<3 S IBOK=0 G REQMRAQ
 ;
 S IB0=$G(^DGCR(399,IBIFN,0))
 S COBINS=+$P($G(^DGCR(399,IBIFN,"M")),U,COBSEQ+1)
 I 'COBINS S IBOK=0 G REQMRAQ ;No next ins
 I $$COB^IBCEF(IBIFN)="S" D  I IBOK="R2" G REQMRAQ
 . S COBINS=$P($G(^DGCR(399,IBIFN,"M")),U,COBSEQ)
 . I +$$MCRWNR(COBINS)=1 S IBOK="R2"
 ;
 ; Check only rules with rule type = 2 (MRA REQUEST RESTRICTIONS)
 S IBDA=0 F  S IBDA=$O(^IBE(364.4,"AC",2,IBDA)) Q:'IBDA  S IB00=$G(^IBE(364.4,IBDA,0)) D  Q:'IBOK
 . I $P(IB00,U,2)>DT Q  ; Inactive
 . I $P(IB00,U,6),$P(IB00,U,6)'>DT Q  ; Expired
 . S Z0=$$INPAT^IBCEF(IBIFN,1),Z0=$S(Z0=1:2,1:1)
 . S Z1=$$FT^IBCEF(IBIFN),Z1=$S(Z1=3:1,1:2)
 . I $S($P(IB00,U,4)=3:1,1:$P(IB00,U,4)=Z0),$S($P(IB00,U,5)=3:1,1:$P(IB00,U,5)=Z1) S Z0=$D(^IBE(364.4,IBDA,3,"B",COBINS)) I Z0>0 S IBOK="R"
 ;
REQMRAQ Q IBOK
 ;
MCRWNR(IBINS) ;Returns whether the ins co IBINS is MEDICARE WNR (Will
 ;           NOT Reimburse) 0=NO, 1=YES
 N Z,Z0
 S Z=0,Z0=$G(^DIC(36,+IBINS,0))
 I $P(Z0,U,2)="N",$P($G(^IBE(355.2,+$P(Z0,U,13),0)),U)="MEDICARE" S Z=1
 Q Z
 ;
WNRBILL(IBIFN,IBCOB) ; Returns whether the ins for COB seq IBCOB
 ;  is MEDICARE will not reimburse
 ;
 I $G(IBCOB)="" S IBCOB=$$COBN^IBCEF(IBIFN)
 S IBCOB=$TR(IBCOB,"PST","123")
 Q $$MCRWNR(+$G(^DGCR(399,IBIFN,"I"_IBCOB)))
 ;
MCR(IBINS) ;Returns whether the ins co IBINS is MCR Will Reimburse
 ;          0=NO , 1=YES
 N Z,Z0
 S Z=0,Z0=$G(^DIC(36,+IBINS,0))
 I $P(Z0,U,2)'="N",$P($G(^IBE(355.2,+$P(Z0,U,13),0)),U)="MEDICARE" S Z=1
 Q Z
 ;
MRATYPE(IBIEN,IBVAR) ; Returns: A = MEDICARE A   B = MEDICARE B
 ;  C = MEDICARE OTHER    null = NOT MEDICARE
 ; for the plan associated with bill ien IBIEN OR grp plan IBIEN
 ; If IBVAR = "" or 'C', the data is from bill ien in IBIEN
 ;          = 'P', the data is from grp policy ien in IBIEN
 ; 
 N IBPLAN
 S IBPLAN=$S($G(IBVAR)'="P":+$$POLICY^IBCEF(IBIEN,18),1:IBIEN)
 Q $P($G(^IBA(355.3,+IBPLAN,0)),U,14)
 ;
MCRONBIL(IBIFN,IBFLG,IBTRBIL) ; Returns 0 if MCR WNR not on bill IBIFN
 ;  1 if on bill, is on or before current ins
 ;  2 if on bill, but after current ins
 ; IBFLG = a COB number if second "^" piece of return data should be
 ;         1 if MCRWNR is the insurance at that COB sequence (optional)
 ; IBTRBIL = tricare for CL1A-5 
 ;
 N Z,IBON,Q
 S IBON=0,Q=$$COBN^IBCEF(IBIFN)
 F Z=1:1:3 I $$WNRBILL(IBIFN,Z)!$$TRI(IBIFN,Z) S IBON=$S(Q'<Z:1,1:2)_$S('$G(IBFLG):"",Z'=IBFLG:"",1:"^1") Q
 Q IBON
 ;
TRI(IBIFN,Z) ;return 1 if rate type & coverage type-Tricare
 N Z0,Z1,IBINS,IBRTY
 S Z1=0
 I '$G(IBTRBIL) Q Z1
 S IBINS=+$G(^DGCR(399,IBIFN,"I"_Z))
 S IBRTY=$P($G(^DGCR(399.3,+$P($G(^DGCR(399,IBIFN,0)),U,7),0)),U)
 S Z0=$G(^DIC(36,+IBINS,0))
 I IBRTY["TRICARE",$P($G(^IBE(355.2,+$P(Z0,U,13),0)),U)="TRICARE" S Z1=1
 Q Z1
 ;
PROFEE(IBIFN) ; Returns whether any rev codes for prof fees
 ;  included on bill IBIFN  0 = not included,  1 = included,
 ;  2 = both inst and prof are included
 ;
 N IBPRO,Z
 S IBPRO=0,Z=$O(^DGCR(399,IBIFN,"RC","B",959)) ; Rev cds 960-989 are prof
 I Z,Z<990 D
 . S IBPRO=1
 . S Z=$O(^DGCR(399,IBIFN,"RC","B",0))
 . I $S(Z:Z<960,1:0)!($O(^DGCR(399,IBIFN,"RC","B",1000),-1)'<990) S IBPRO=2
 Q IBPRO
 ;
GETMOD(IBIFN,IBCPT,EXT) ; Returns 'list' of modifiers for file 399
 ;   procedure for bill IBIFN and proc ien IBCPT
 ;   in modifier seq order, separated by ','
 ;  If EXT = 1, return the actual modifier, not the ptr
 N IBMOD,IBZ,IBZ0,IB0,Z
 S IBZ=0,IBMOD=""
 F  S IBZ=$O(^DGCR(399,IBIFN,"CP",IBCPT,"MOD","B",IBZ)) Q:'IBZ  S IBZ0=0 F  S IBZ0=$O(^DGCR(399,IBIFN,"CP",IBCPT,"MOD","B",IBZ,IBZ0)) Q:'IBZ0  I $D(^DGCR(399,IBIFN,"CP",IBCPT,"MOD",IBZ0,0)) S IB0=$G(^(0)) D
 . I '$G(EXT) S Z=$P(IB0,U,2)
 . I $G(EXT) S Z=$$MOD^ICPTMOD($P(IB0,U,2),"I"),Z=$S($P(Z,U)=-1:"",1:$P(Z,U,2))
 . Q:Z=""
 . S IBMOD=IBMOD_$S(IBMOD="":"",1:",")_Z
 Q IBMOD
 ;
MODLST(MODS,DESC,IBMOD) ; Returns string of actual mods
 ; MOVED
 Q $$MODLST^IBEFUNC2(MODS,$G(DESC),.IBMOD)
 ;
GETSPEC(FILE,FIELD) ; Get fld specifier for FIELD # in FILE
 ; Use to set DIC("P") for FILE^DICN
 N IBZ
 D FIELD^DID(FILE,FIELD,"","SPECIFIER","IBZ")
 Q $G(IBZ("SPECIFIER"))
 ;
