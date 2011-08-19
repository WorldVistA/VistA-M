RCXVUTIL ;DAOU/ALA-AR Data Extract Utility Program ;29-JUL-03
 ;;4.5;Accounts Receivable;**201**;Mar 20, 1995
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
 ;
 NEW RCXVCARE,RCXVRATE,RCXVODT,RPTF
 S RCXVCFL=0
 ;
 ;  If not Reimbursable Insurance, it's VA CARE
 S RCXVRATE=$O(^DGCR(399.3,"B","REIMBURSABLE INS.",""))
 I $P($G(^DGCR(399,RCXVIEN,0)),U,7)'=RCXVRATE S RCXVCFL=1 Q
 ;
 ; If prescription, it's VA Care
 I $D(^IBA(362.4,"C",RCXVIEN))>0 S RCXVCFL=1 Q
 ;
 I $P($G(^DGCR(399,RCXVIEN,0)),U,16)'="" Q
 ;
 S RCXVCARE=$G(^DGCR(399,RCXVIEN,"U2"))
 I $P(RCXVCARE,U,10)'="" Q
 I $P(RCXVCARE,U,11)'="" Q
 I $P(RCXVCARE,U,12)'="" Q
 I $P(RCXVCARE,U,13)'="" Q
 I $P(RCXVCARE,U,14)'="" Q
 I $P(RCXVCARE,U,15)'="" Q
 ;
 ;  Check inpatient
 I $P($G(^DGCR(399,RCXVIEN,0)),U,5)<3 D  Q:RCXVCFL
 . S RPTF=$P($G(^DGCR(399,RCXVIEN,0)),U,8)
 . I RPTF="" Q
 . I $P($G(^DGPT(RPTF,0)),U,4)=1 Q
 . S RCXVCFL=1
 ;
 ;  Check outpatient encounter
 NEW IBCBK,IBVAL
 S IBCBK="I '$P(Y0,U,6) S ^TMP(""RCXVOE"",$J,+$P(Y0,U,8),Y)=Y0"
 S IBVAL("DFN")=$P(^DGCR(399,RCXVIEN,0),U,2)
 S RCXVODT=0 K ^TMP("RCXVOE",$J)
 F  S RCXVODT=$O(^DGCR(399,RCXVIEN,"OP",RCXVODT)) Q:'RCXVODT  D
 . S IBVAL("BDT")=RCXVODT,IBVAL("EDT")=RCXVODT+.9999
 . D SCAN^IBSDU("PATIENT/DATE",.IBVAL,"",IBCBK,1)
 I $O(^TMP("RCXVOE",$J,""))'="" S RCXVCFL=1 K ^TMP("RCXVOE",$J) Q
 Q
