RCXVUTIL ;DAOU/ALA - AR Data Extract Utility Program ;29-JUL-03
 ;;4.5;Accounts Receivable;**201,299,308**;Mar 20, 1995;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
SPAR(REF) ;  HL7 Segment Parsing
 ;  Input Parameter
 ;    REF = Array or global reference
 ;       Global or array should end with ')'
 ;       e.g. ^TMP($J,"XXX",#)
 ;
 ;  Output Parameters
 ;    RCXSEG(#) = Each sequence of the segment in the array
 ;
 NEW ISCT,II,IJ,IK,ISDATA,ISPEC,ISBEG,ISEND,IS,LSDATA,IM,NPC
 ;
 S ISCT="",II=0,IS=0
 F  S ISCT=$O(@REF@(ISCT)) Q:ISCT=""  D
 . S IS=IS+1
 . S ISDATA(IS)=$G(@REF@(ISCT))
 . I $O(@REF@(ISCT))="" S ISDATA(IS)=ISDATA(IS)_HLFS
 . S ISPEC(IS)=$L(ISDATA(IS),HLFS)
 ;
 S IM=0,LSDATA=""
LP S IM=IM+1 Q:IM>IS
 S LSDATA=LSDATA_ISDATA(IM),NPC=ISPEC(IM)
 F IJ=1:1:NPC-1 D
 . S II=II+1,RCXSEG(II)=$$CLNSTR($P(LSDATA,HLFS,IJ),HL("ECH"),$E(HL("ECH")))
 S LSDATA=$P(LSDATA,HLFS,NPC)
 G LP
 ;
CLNSTR(STRING,CHARS,SUBSEP) ;  Remove extra trailing components and subcomponents
 ;  in the HL7 segment
 ;
 ;  Input parameters
 ;    STRING - The data value to be 'cleansed'
 ;    CHARS - The component character to be removed
 ;    SUSEP - The subcomponent character to be removed
 ;
 N RTSTRING,NUMPEC,PEC
 S RTSTRING=$$RTRIMCH(STRING,CHARS)
 ; Now we have string without trailing chars, remove from subs
 S NUMPEC=$L(RTSTRING,SUBSEP)
 F PEC=1:1:NUMPEC S $P(RTSTRING,SUBSEP,PEC)=$$RTRIMCH($P(RTSTRING,SUBSEP,PEC),CHARS)
 Q RTSTRING
 ;
RTRIMCH(STR,CHRS) ;  Remove the trailing chars from string
 N R,L
 S L=1,CHRS=$G(CHRS," ")
 F R=$L(STR):-1:1 Q:CHRS'[$E(STR,R)
 I L=R,(CHRS[$E(STR)) S STR=""
 Q $E(STR,L,R)
 ;
DFP(IBN) ;  Date of First Payment Function
 ;  Input Parameter
 ;    IBN = IEN of the bill number from file 430
 ;
 N VAL,IBPAY,IBT,IBT0,IBT1
 S VAL=0
 ;  No payments made.
 I '$P($G(^PRCA(430,IBN,7)),U,7) Q ""
 S (IBPAY,IBT)=0 F  S IBT=$O(^PRCA(433,"C",IBN,IBT)) Q:'IBT  D  Q:IBPAY
 . S IBT0=$G(^PRCA(433,IBT,0)),IBT1=$G(^(1))
 . I $P(IBT0,U,4)'=2 Q  ;                  Not complete.
 . I $P(IBT1,U,2)'=2,$P(IBT1,U,2)'=34 Q  ; Not a payment.
 . S X=$S(+IBT1:+IBT1,1:$P(IBT1,U,9)\1),$P(VAL,U,4)=X,IBPAY=1
 Q $P(VAL,U,4)
 ;
DATE(X) ;  Pass in External Date and get FileMan date format
 ;
 ;  Input Parameter
 ;    X = a date in any regular date format
 ;  Output Parameter
 ;    Y = a date in FileMan format
 ;  Parameters
 ;    DIC(0) = FileMan date parameter
 ;
 I X["@" S %DT="T"
 I $G(DIC(0))="" S DIC(0)=""
 D ^%DT
 I Y=-1 S Y=""
 K DIC,%DT
 Q Y
 ;
TASK(RCDSC) ;  Check on Task Status
 ;
 ;  Input Parameter
 ;    RCDSC = Task Description
 ;
 NEW RTASKS,RTSK,ZTSK,ZTKEY
 D DESC^%ZTLOAD(RCDSC,"RTASKS")
 S RTSK=""
 F  S RTSK=$O(RTASKS(RTSK)) Q:RTSK=""  D
 . S ZTSK=RTSK D STAT^%ZTLOAD
 ;
 K RTASKS
 I $G(ZTSK(2))="Inactive: Finished" Q 0
 I $G(ZTSK(2))="Inactive: Interrupted" Q 0
 I $G(ZTSK(2))="Active: Pending" Q 1
 Q 0
 ;
SAT(RDATE) ;  Find the next Saturday date from the passed in date
 NEW CDOW,FDATE,NDAYS
 S CDOW=$$DOW^XLFDT(RDATE,1),NDAYS=6-CDOW
 I NDAYS=0 S NDAYS=7
 S FDATE=$$FMADD^XLFDT(RDATE,NDAYS)
 Q FDATE
 ;
CARE(RCXVIEN) ;  Is bill VA or NON-VA care?
 ;
 ;  Input parameter
 ;    RCXVIEN = Bill ien
 ;
 ;  Output parameter
 ;    RCXVCFL = Care Flag
 ;    0 = Non-VA Care
 ;    1 = VA Care
 ; *308 phase II criteria for inpatient and outpatient
 ; -Non-VA care if op visit in 9000010/.22 & stop code=669 in /.08
 ; -VA care if the bill # with prosthetic item is found in 362.5
 ; -VA care if rate type'=REIMBURSABLE INS or none of types below:
 ;  FEE;FEE BASIS;FEE-INPT;NON VA CARE;NON-VA;NON-VA FEE BASIS CARE
 ; -VA care if item type=RX in 399.042/.1 & charge item found in 362.4
 ; -Non-VA care if item type=RX in 399.042/.1 & charge item not found
 ; -Non-VA care if op visit in 9000010/.22 matching to any below:
 ;  NVCC;NVC;VCL;NON-VA CARE;NONVA CARE;NONCOUNT FEE;FEE BASIS
 ; -VA care if op vist in 9000010/.22 not matching to any above
 ; -Non-VA care if no encounter on op visit date(s) is found in 409.68
 ; -VA care if the bill not meet above criteria
 ; 
 ; *299 criteria for inpatient and outpatient
 ; -Non-VA care if bill classification is inpt/(med. part A) & no ptf #.
 ; -Non-VA care if ptf # & discharge dt are not null and ward is null.
 ; -VA care if ptf # & discharge dt are not null and ward is not null.
 ; -Non-VA care if ptf # & fee basis are not null, otherwise VA care.
 ; -VA care if at least one assoc. opt encounter is not a NON-COUNT (12)
 ;  encounter, otherwise Non-VA care.
 ; -VA care or Non-VA care in the final indicator is determined based on
 ;  the opt encounter criteria if the flow reaches it.
 ;  
 N RCXVCARE,RCXVRATE,RCXVODT,RPTF
 N RCIBX,RCIBY,RCTY,RCTYPE,RCTMP,RCIBRX
 ;
 ; if visit has hospital location & stop code 669, it's non-va care
 N RCDAT,RCDFN,RCXTMP S (RCDAT,RCTYPE)=0
 S RCDFN=$P($G(^DGCR(399,RCXVIEN,0)),U,2)
 ; if no date then check yymm only 
 S RCTY="N RCIBX S RCIBX=$P($P($G(^(0)),U),""."") S:'+$E(RCDAT,6,7) RCIBX=$E(RCIBX,1,5) I RCIBX=RCDAT"
 F  S RCDAT=$O(^DGCR(399,RCXVIEN,"OP",RCDAT)) Q:'RCDAT  D  Q:RCTYPE
 . K RCXTMP D FIND^DIC(9000010,,"@;.01I","QPX",RCDFN,,"C",RCTY,,"RCXTMP")
 . S RCIBX=0 F  S RCIBX=$O(RCXTMP("DILIST",RCIBX)) Q:'RCIBX  D  Q:RCTYPE
 .. S RCIBY=$$GET1^DIQ(9000010,+RCXTMP("DILIST",RCIBX,0),.22) Q:RCIBY=""
 .. S RCIBY=$$GET1^DIQ(9000010,+RCXTMP("DILIST",RCIBX,0),.08,"I") Q:RCIBY=""
 .. I +$P($G(^DIC(40.7,+RCIBY,0)),U,2)=669 S RCTYPE=1 Q
 I RCTYPE S RCXVCFL=0 Q
 ;
 ; if the bill # with prosthetics item in file 362.5, it's va care
 S RCIBRX="AIFN"_RCXVIEN
 I $D(^IBA(362.5,RCIBRX)) S RCXVCFL=1 Q
 ; 
 ; if not Reimbursable Insurance & not fee basis, it's va care
 S RCTYPE=0
 S RCIBX=+$P($G(^DGCR(399,RCXVIEN,0)),U,7)
 S RCXVRATE=$P($G(^DGCR(399.3,RCIBX,0)),U)
 I $F(",FEE,FEE BASIS,FEE-INPT,NON VA CARE,NON-VA,NON-VA CARE,NON-VA FEE BASIS CARE,",","_RCXVRATE_",") S RCTYPE=1
 I 'RCTYPE,RCXVRATE'="REIMBURSABLE INS." S RCXVCFL=1 Q
 ;
 ; non-va discharge date
 I $P($G(^DGCR(399,RCXVIEN,0)),U,16)'="" S RCXVCFL=0 Q
 ;
 ; non-va facility, non-va care type, non-va care id
 S RCXVCARE=$G(^DGCR(399,RCXVIEN,"U2"))
 I $P(RCXVCARE,U,10)'="" S RCXVCFL=0 Q
 I $P(RCXVCARE,U,11)'="" S RCXVCFL=0 Q
 I $P(RCXVCARE,U,12)'="" S RCXVCFL=0 Q
 ;
 ; Prescription item charge in file 362.4
 S (RCIBX,RCTYPE)=0,RCIBRX="AIFN"_RCXVIEN
 ; DBIA#3811
 K RCTMP D RCITEM^IBCSC5A(RCXVIEN,"RCTMP",3)
 F  S RCIBX=$O(^IBA(362.4,RCIBRX,RCIBX)) Q:'RCIBX  S RCIBY=0 D  Q:'RCTYPE
 . F  S RCIBY=$O(^IBA(362.4,RCIBRX,RCIBX,RCIBY)) Q:'RCIBY  D  Q:'RCTYPE
 .. I $$IBCHG(RCIBY,3,.RCTMP)'="" S RCTYPE=1 Q
 ; no item and no charge, then continue to check
 I $O(RCTMP(3,""))'="" S RCXVCFL=0 Q
 I RCTYPE S RCXVCFL=1 Q
 ;
 ; Check inpatient
 ; -ptf entry number (#399/.08) & bill classification (#399/.05)
 S RPTF=$P($G(^DGCR(399,RCXVIEN,0)),U,8)
 I $P($G(^DGCR(399,RCXVIEN,0)),U,5)=1,RPTF="" S RCXVCFL=0 Q
 ;
 ; -discharge date (#45/70) and ward at discharge (#45/2.2)
 ; -fee basis (#45/4) exits, it's non-va care
 ; DBIA#6030
 I RPTF'="" D  Q
 . I $P($G(^DGPT(RPTF,70)),U,1)'="" D  Q
 .. N X S X="" D PTF^DGPMUTL(RPTF)
 .. I X="" S RCXVCFL=0 Q
 .. S RCXVCFL=1
 . I $P($G(^DGPT(RPTF,0)),U,4)=1 S RCXVCFL=0 Q
 . S RCXVCFL=1
 ;
 ; If at least bedsection=non-va care, it's non-va care
 S (RCIBX,RCTYPE)=0
 F  S RCIBX=$O(^DGCR(399,RCXVIEN,"RC",RCIBX)) Q:'RCIBX  D  Q:RCTYPE
 . S RCIBY=$P($G(^DGCR(399,RCXVIEN,"RC",RCIBX,0)),U,5)
 . S RCIBY=$P(^DGCR(399.1,+RCIBY,0),U) Q:RCIBY=""
 . I $F(",NON-VA CARE,NON-VA CARE AT VA EXPENSE,NON-VA CARE%,",","_RCIBY_",") S RCTYPE=1
 I RCTYPE S RCXVCFL=0 Q
 ;
 ; Hospital location meets the va care checks
 S RCTYPE=0
 S RCIBX=0 F  S RCIBX=$O(RCXTMP("DILIST",RCIBX)) Q:'RCIBX  D  Q:RCTYPE
 . S RCIBY=$$GET1^DIQ(9000010,+RCXTMP("DILIST",RCIBX,0),.22) Q:RCIBY=""
 . F RCTY="NVCC","NON-VA CARE","NONVA CARE","NONCOUNT FEE","FEE BASIS" I $F(RCIBY,RCTY) S RCTYPE=1 Q
 . Q:RCTYPE  ;abbreviation
 . S RCIBY=+$O(^SC("B",RCIBY,0)),RCIBY=$P($G(^SC(RCIBY,0)),U,2)
 . F RCTY="NVCC","NVC","VCL" I $F(RCIBY,RCTY) S RCTYPE=1
 ; if no op visit then continue to check
 I $O(RCXTMP("DILIST",0))'="" S RCXVCFL=$S('RCTYPE:1,1:0) Q
 ;
 ; Check outpatient encounter
 ; If no encounter on op visit date, it's non va care
 NEW IBCBK,IBVAL
 S IBCBK="I '$P(Y0,U,6) S ^TMP(""RCXVOE"",$J,+$P(Y0,U,8),Y)=Y0"
 S IBVAL("DFN")=$P(^DGCR(399,RCXVIEN,0),U,2)
 S (RCTYPE,RCXVODT)=0 K ^TMP("RCXVOE",$J)
 ; DBIA# 2351 for call to scan^ibsdu
 F  S RCXVODT=$O(^DGCR(399,RCXVIEN,"OP",RCXVODT)) Q:'RCXVODT  D
 . S RCTYPE=1,IBVAL("BDT")=RCXVODT,IBVAL("EDT")=RCXVODT+.9999
 . D SCAN^IBSDU("PATIENT/DATE",.IBVAL,"",IBCBK,1)
 I RCTYPE,$O(^TMP("RCXVOE",$J,0))="" S RCXVCFL=0 Q
 K ^TMP("RCXVOE",$J)
 S RCXVCFL=1
 Q 
 ;
IBCHG(RCIBY,RCTY,RCTMP) ; Return charge for item entry or null if no charge
 ; RCTMP=array containing the RC and unit(s) and unit charge
 ; RCTY=3 for prescription or RCTY=5 for prosthetics or RCTY=4 for cpt
 ; delete charge entry in rctmp if item found
 N RCIBZ,RCIBYC
 S RCTMP=$S($D(RCTMP(RCTY,RCIBY)):RCIBY,1:0),RCIBYC=""
 F RCTMP=RCTMP,0 Q:'$D(RCTMP(RCTY,RCTMP))  S RCIBZ="" D  Q:RCIBZ'=""!(RCTMP=0)
 . F  S RCIBZ=$O(RCTMP(RCTY,RCTMP,RCIBZ)) Q:RCIBZ=""  I RCTMP(RCTY,RCTMP,RCIBZ) S $P(RCTMP(RCTY,RCTMP,RCIBZ),U)=RCTMP(RCTY,RCTMP,RCIBZ)-1,RCIBYC=$P(RCTMP(RCTY,RCTMP,RCIBZ),U,2) K:'RCTMP(RCTY,RCTMP,RCIBZ) RCTMP(RCTY,RCTMP,RCIBZ) Q
 Q RCIBYC
 ;
