IBAECU ;ALB/BGA-LTC UTILITIES DETERMINE LTC ELIG ; 25-SEPT-01
 ;;2.0;INTEGRATED BILLING;**164,171,176,198,188**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine contains the following utilities in support of the
 ; LTC initiative:
 ; 1. Determine if a patient is ELIGIBLE for the LTC COPAY
 ; 2. Determine if a inpatient episode is related to LTC
 ;
 ;LTCST(DFN,IBDT); - Returns '2' if LTC Eligible or else '1' Not Eligible
 ;       ; -- Returns '-1' and a second piece if there is an ERROR
 ;       ; -- If 2 LTC VET's Income Exceeds Pension Level <LTC ELIG>
 ;       ; -- If 1 Not LTC Eligible = Exempt
 ;
LTCST(DFN,IBDT,LOS) ; returns LTC status from API
 ;  input:  Patient's DFN, Date of Care, Length of stay
 ;
 ; format:  exemption flag ^ exemption reason (714.1 pointer)
 ;          ^ <181 $ amount ^ >180 $ amount ^ opt $ amount
 Q $$COPAY^EASECCAL(DFN,$$LASTDT(IBDT),LOS)
 ;
 ;
MAXRATE(IBDT) ; returns the max rates for the effective date
 ; the rates retuned are the max daily rates for any and all LTC
 ; copayments.  The return is:  outpatient^inpatient
 ;
 N IBATYP,IBR,IBL,IBT,IBCHG
 ;
 S IBR=""
 ;
 ; if IBDT less than the starting date of LTC set to the starting date
 I IBDT<3020726 S IBDT=3020726
 ;
 F IBL=1:1 S IBT=$P($T(STOP+IBL^IBAECU1),";",3) Q:IBT=""  S IBATYP=$O(^IBE(350.1,"B",IBT,0)) I IBATYP D COST^IBAUTL2 I IBCHG>IBR S IBR=IBCHG
 F IBL=1:1 S IBT=$P($T(SPEC+IBL^IBAECU1),";",3) Q:IBT=""  S IBATYP=$O(^IBE(350.1,"B",IBT,0)) I IBATYP D COST^IBAUTL2 I IBCHG>$P(IBR,"^",2) S $P(IBR,"^",2)=IBCHG
 Q IBR
 ;
FACSPEC(IBSPEC) ; returns the treating specialty for 42.4 from a facility sp
 ;
 Q $P($G(^DIC(45.7,+$G(IBSPEC),0)),"^",2)
 ;
 ;
LTCSPEC(IBSPEC)   ; Determine if INPT Specialty is related to LTC.
 ;       -- Input the ien of #42.4 Specialty
 ;
 ;       -- Output: Piece 1:  If a LTC Specialty Bedsection Pointer 399.1
 ;                            If not LTC Spec Return 0
 ;                  Piece 2:  If LTC, type of LTC
 ;
 N IBTS
 ;
 ;  get the LTC Treating Specialty type
 S IBTS=$T(@("T"_IBSPEC)^IBAECU1)
 ;
 Q $S($L(IBTS):+$E(IBTS,2,99)_"^"_$P(IBTS,";",3),1:0)
 ;
 ;
LTCSTOP(IB407)   ; Determine if the 'STOP CODE' is related to LTC.
 ;
 ;       -- Input the ien of #40.7 Clinic Stop Code
 ;
 ;       -- Output: 1st piece 1 -  LTC STOP CODE
 ;                            0 -  Not LTC STOP CODE
 ;
 ;                  2nd piece = if LTC, type of LTC
 ;
 N IBSTOP,IBSCDATA
 ;
 ;  get the stop code in IBSCDATA(40.7,IB407,1,"E")
 D DIQ407^IBEMTSCU(IB407,1)
 I $G(IBSCDATA(40.7,IB407,1,"E"))="" Q 0
 ;
 ;  get the LTC stop type
 S IBSTOP=$T(@("C"_IBSCDATA(40.7,IB407,1,"E"))^IBAECU1)
 ;
 Q $S($L(IBSTOP):+$E(IBSTOP,2,99)_"^"_$P(IBSTOP,";",3),1:0)
 ;
 ;
CLOCK(DFN,IBDATE) ; verfiy a clock exists, if not, one will be added
 N X,Y,IBCL,IBX,DA,DIE,DR,IBFLG
 ;
 ; get last clock for patient
 S IBX=9999999,IBFLG=0
 F  S IBX=$O(^IBA(351.81,"AE",DFN,IBX),-1) Q:+IBX=0!(IBFLG>0)  D
 . S IBCL=0
 . F  S IBCL=$O(^IBA(351.81,"AE",DFN,IBX,IBCL)) Q:+IBCL=0!(IBFLG>0)  D
 . . Q:+$P(^IBA(351.81,IBCL,0),"^",5)'=1  ;if it is not OPEN
 . . S IBFLG=IBCL
 ;
 ; if has an OPEN clock already
 I IBFLG>0 D  Q 1
 . I +$P(^IBA(351.81,IBFLG,0),"^",7)>0 Q  ;already flagged - quit
 . S DIE="^IBA(351.81,",DR=".07////^S X=IBDATE",DA=IBFLG D ^DIE
 ; if there is no OPEN clock the add a new clock, and set CURRENT EVENTS DATE
 S DIE="^IBA(351.81,",DA=+$$ADDCL(DFN,IBDATE),DR=".07////^S X=IBDATE" X $S(DA>0:"D ^DIE S Y=DA",1:"S Y=-1")
 Q +Y
 ;
 ;
YR(IBRTED,IBFR) ; is the effective date of the clock too old?
 ;  Input:   IBRTED  --  Effective Date
 ;             IBFR  --  Event Date
 ;  Output:       1  --  Effective Date is too old
 ;                0  --  Not
 N IBNUM,IBYR
 S IBNUM=$$FMDIFF^XLFDT(IBFR,IBRTED),IBYR=$E(IBFR,1,3)
 Q IBYR#4&(IBNUM>364)!(IBYR#4=0&(IBNUM>365))
 ;
ADDCL(DFN,IBADT) ; adds a LTC clock, returns LTC Clock IEN
 ; needs DFN and IBADT (clock begin date)
 ;
 N %DT,DD,DO,DIC,DR,X,Y,DA,DR,DIE,IBN,IBN1,IBSITE,IBFAC,DINUM,DLAYGO
 L +^IBA(351.81,0):10 I '$T S Y="-1^IB014" G ADDCLQ
 S X=$P($S($D(^IBA(351.81,0)):^(0),1:"^^-1"),"^",3)+1 L -^IBA(351.81,0) I 'X S Y="-1^IB015" G ADDCLQ
 D SITE^IBAUTL
 N IBAEXDT S IBAEXDT=$$GETEXPDT^IBAECU4(IBADT\1) ;expiration date
 S DIC="^IBA(351.81,",DIC(0)="L",DLAYGO=351.81
 F X=X:1 L:$D(IBN1) -^IBA(351.81,IBN1) I X>0,'$D(^IBA(351.81,X)) S IBN1=X L +^IBA(351.81,IBN1):1 I $T,'$D(^IBA(351.81,X)) S DINUM=X,X=+IBSITE_X D FILE^DICN I +Y>0 Q
 S IBN=+Y,DIE="^IBA(351.81,",DA=IBN,DR=".02////"_$S($D(DFN):DFN,1:"")_";.03////"_$S($D(IBADT):IBADT,1:"")_";.04////"_$S($D(IBAEXDT):IBAEXDT,1:"")_";.05////1;.06////21;"_$S(DUZ:"4.01///"_DUZ_";",1:"")_"4.02///NOW" D ^DIE
 L -^IBA(351.81,IBN1)
 S Y=$S('$D(Y):1,1:"-1^IB028")
 ;
ADDCLQ Q $S($G(IBN):IBN,1:Y)
 ;
LTCENC(DFN,DATE) ; Did the patient have LTC on a specified date?
 ; Input:    DFN  --  Pointer to the patient in file #2
 ;          DATE  --  Date of the Outpatient Visit
 ; Output:     0  --  Patient did not have a LTC on the visit date
 ;             1  --  Patient had a LTC on the visit date
 N X,Y,Y0,IBVAL,IBCBK,IBFILTER,IBLTC
 I '$G(DFN)!('$G(DATE)) G LTCENCQ
 ; - check appts, stop codes
 S IBVAL("DFN")=DFN,IBVAL("BDT")=DATE,IBVAL("EDT")=DATE+.9999
 ; Only parent appt or add/edit encounters
 S IBFILTER=""
 S IBCBK="I '$P(Y0,U,6),$P(Y0,U,8)<3,$P(Y0,U,3),$$LTCSTOP^IBAECU($P(Y0,U,3)),$P(Y0,U)'<$$STDATE^IBAECU1 S (IBLTC,SDSTOP)=1"
 S IBLTC=0
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,1) K ^TMP("DIERR",$J)
 I IBLTC S Y=1
LTCENCQ Q +$G(Y)
 ;
 ;
XMBACK(DFN,IBM) ; send a message saying LTC processing has stoped for an event
 ;
 N XMSUB,XMTEXT,XMY,XMZ,XMMG,IBL,IBX,IBT,XMDUZ
 ;
 D XMDEM(DFN,.IBT,.IBL)
 ;
 S XMSUB="LTC Copayment Back Billing/Error",XMY("G.IB LTC BACK BILLING")="",XMTEXT="IBT(",XMDUZ="INTEGRATED BILLING PACKAGE"
 ;
 S IBX=0 F  S IBX=$O(IBM(IBX)) Q:IBX<1  S IBL=IBL+1,IBT(IBL,0)=IBM(IBX)
 ;
 D ^XMD
 ;
 Q
 ;
XMNOEC(DFN,IBDT,IBE) ; send a message saying no 1010EC on file for LTC pt.
 ; IBE is optional additional text
 ;
 N XMSUB,XMTEXT,XMY,XMZ,XMMG,IBL,IBT,XMDUZ,X
 ;
 ; if already done for this patient and month, quit
 I $D(^XTMP("IB1010EC",DFN)) Q
 S ^XTMP("IB1010EC",DFN)=""
 ;
 D XMDEM(DFN,.IBT,.IBL)
 ;
 S XMSUB="1010EC Missing for LTC Patient",XMY("G.IB LTC 1010EC MISSING")="",XMTEXT="IBT(",XMDUZ="INTEGRATED BILLING PACKAGE"
 ;
 S IBL=IBL+1,IBT(IBL,0)="The above patient has received LTC services on "_$$FMTE^XLFDT(IBDT)_" and"
 S IBL=IBL+1,IBT(IBL,0)="does not have a LTC Copayment Test on file.  A LTC Copayment test needs to"
 S IBL=IBL+1,IBT(IBL,0)="be completed as soon as possible to determine the patient's eligibility"
 S IBL=IBL+1,IBT(IBL,0)="for exemption and/or copayment obligation.  Billing cannot be processed"
 S IBL=IBL+1,IBT(IBL,0)="until this information is entered."
 S IBL=IBL+1,IBT(IBL,0)=""
 I $D(IBE)>9 S X=0 F  S X=$O(IBE(X)) Q:'X  S IBL=IBL+1,IBT(IBL,0)=IBE(X)
 ;
 D ^XMD
 ;
 Q
 ;
XMDEM(DFN,IBT,IBL) ; Sets basic demographics in text
 ;
 N VADM,VA,VAERR
 ;
 D DEM^VADPT
 ;
 S IBT(1,0)="  Patient: "_VADM(1)
 S IBT(3,0)="      SSN: "_$P(VADM(2),"^",2)
 S (IBT(2,0),IBT(4,0))=" "
 S IBL=4
 ;
 Q
 ;
LASTDT(X) ; compute the last day of the month in X
 N XM,X1,X2
 I $E(X,4,5)=12 Q $E(X,1,5)_"31"
 S XM=$E(X,4,5)+1
 S:XM<10 XM="0"_XM
 S X1=$E(X,1,3)_XM_"01"
 S X2=-1
 D C^%DTC
 Q X
 ;
TOT ; calculates the total charged for a patient (for the month)
 ; requires IBFR, IBLTCST, DFN
 ; returns IBT (total amount already billed), IBTYP (inpt or opt)
 ;
 N IBDT,IBX,IBZ
 S IBTYP="O",IBT=0
 ;
 S IBDT=-$E(IBFR,1,5)_"00" F  S IBDT=$O(^IB("AFDT",DFN,IBDT),-1) Q:IBDT=""!($E(IBDT,2,6)'=$E(IBFR,1,5))  S IBX=0 F  S IBX=$O(^IB("AFDT",DFN,IBDT,IBX)) Q:IBX<1  S IBZ=$G(^IB(IBX,0)) I $E($G(^IBE(350.1,+$P(IBZ,"^",3),0)),1,7)="DG LTC " D
 . ;
 . ; don't use bills that are cancelled.
 . I $P($G(^IBE(350.21,+$P(IBZ,"^",5),0)),"^",5) Q
 . ;
 . ; don't use cancellation action types either
 . I $P($G(^IBE(350.1,+$P(IBZ,"^",3),0)),"^",5)=2 Q
 . ;
 . S IBT=IBT+$P(^IB(IBX,0),"^",7)
 . I $E(^IBE(350.1,$P(IBZ,"^",3),0),8,11)="INPT" S IBTYP="I"
 ;
 Q
 ;
LASTMJ() ; function to return when the Monthly Job was last run or 0
 N IBLSTDT
 S IBLSTDT=$P($G(^IBE(350.9,1,0)),"^",16)
 Q $S(IBLSTDT>3:IBLSTDT,1:0)
 ;
