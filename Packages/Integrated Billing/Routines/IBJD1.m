IBJD1 ;ALB/MR - DIAGNOSTIC MEASURES UTILITIES ;16-DEC-00
 ;;2.0;INTEGRATED BILLING;**123,159**;21-MAR-94
 ;
VA(DFN) ; - Is patient a VA employee?
 ;    Input: DFN - Pointer to the Patient file
 ;       IBEXCEL - Optional global Variable (Print to an Excel format)
 ;   Output: VAEMP - "E" (if IBEXCEL) or "*" - VA employee
 ;
 N ELMD,IEN,SSN,VADM,VAEMP
 S VAEMP="" G:'$G(DFN) VAQ
 D DEM^VADPT S SSN=+$P(VADM(2),"^") G:'SSN VAQ
 S IEN=+$O(^PRSPC("SSN",SSN,0)) G:'IEN VAQ
 I $P($G(^PRSPC(IEN,1)),U,33)'="Y" S VAEMP=$S($G(IBEXCEL):"E",1:"*")
 ;
VAQ Q VAEMP
 ;
PYMT(X) ; - Return most recent bill payment.
 ;    Input: X=Bill pointer to file #399/#430
 ;   Output: Y=Payment date in Fileman format ^ Payment amount
 ;
 N X1,X2,X3,Y S Y="" G:'$G(X) PAYQ
 S X1=9999999
 F  S X1=$O(^PRCA(433,"C",X,X1),-1) Q:'X1  D  Q:Y
 . S X2=$G(^PRCA(433,X1,0)),X3=$G(^PRCA(433,X1,1))
 . I $P(X2,U,4)'=2 Q  ;              Not complete.
 . I "^2^34^"'[(U_$P(X3,U,2)_U) Q  ; Not a payment.
 . S Y=$S(X3:+X3,1:$P(X3,U,9)\1)_U_+$P(X3,U,5)
PAYQ Q Y
 ;
INS(DFN,DTE) ; return the Insurance Company for the Patient on DTE (date)
 ;
 N INS,POL,X,X0,Y
 S INS="",X=0
 F  S X=$O(^DPT(DFN,.312,X)) Q:'X  I $D(^(X,0)) D
 . S X0=^DPT(DFN,.312,X,0)
 . I '$$CHK^IBCNS1(X0,DTE) Q
 . S POL(0)=$G(POL(0))+1,POL(X,0)=X0
 ;
 I $G(POL(0))<1 G QINS
 I $G(POL(0))=1 S Y=+$O(POL(0))
 I $G(POL(0))>1 S Y=$$COB^IBCNS1(.POL)
 ;
 S INS=$P($G(^DIC(36,+POL(Y,0),0)),"^")
 ;
QINS Q INS
 ;
DIV(CLM) ; Returns the Medical Center Division for the Claim
 ; Input: CLM - Pointer to Claim Tracking File (#356)
 ;Output: DIVision for the Claim
 ;
 N ADM,DIV,ENC,PRSC,PRST,X
 ;
 S DIV=0,X=$G(^IBT(356,CLM,0))
 S ENC=+$P(X,"^",4)     ; Encounter    (Pointer to #409.68)
 S ADM=+$P(X,"^",5)     ; Admission    (Pointer to #405)
 ;
 ; Inpatient
 I ADM S DIV=+$P($G(^DIC(42,+$P($G(^DGPM(+$G(ADM),0)),U,6),0)),U,11)
 ;
 ; Outpatient
 I 'DIV,ENC S DIV=$P($$SCE^IBSDU(ENC),"^",11)
 ;
 ; If Pharmacy/Prosthetics or no Division found assume Primary Division
QDIV S:'DIV DIV=$$PRIM^VASITE() S:DIV'>0 DIV=0
 Q DIV
 ;
CATTYP(IBBCAT) ; - Break down AR Categories into First or Third party
 ;
 N IBFOTP,IBBTYP,IBCATDA0
 S IBFOTP="",IBBTYP=""
 I (IBBCAT>2&(IBBCAT<6))!(IBBCAT>23&(IBBCAT<27)) Q IBFOTP
 I '$D(^PRCA(430.2,IBBCAT,0)) Q IBFOTP
 S IBCATDA0=^PRCA(430.2,IBBCAT,0),IBBTYP=$P(IBCATDA0,"^",6)
 S IBFOTP=$S((IBBTYP="P")!(IBBTYP="C"):"F",1:"T")
 I IBBCAT=15 S IBFOTP="F"   ; Exception:Ex-employee is first party
 I IBBCAT=16 S IBFOTP="F"   ; Exception:Current Emp. is first party
 Q IBFOTP
