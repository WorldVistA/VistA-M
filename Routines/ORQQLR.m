ORQQLR ; slc/CLA - Functions which return patient lab results ;12/15/97 [ 04/02/97  3:46 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,143**;Dec 17, 1997
 ;
LIST(Y,PT,SDT,EDT,SUBSECT) ; return patient's lab results between start date and stop date for the lab sub section:
 N I,J,SUB,INVDT,SEQ,DIFF,X,EXTDT,ORSRV
 S J=1,SUB=0,INVDT=0,SEQ=0
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 I '$L($G(SDT))  S Y(1)="^Error in date range." Q
 I '$L($G(EDT)) D NOW^%DTC S EDT=+% K %
 S:'$L($G(SUBSECT)) SUBSECT="ALL"
 K ^TMP("LRRR",$J)
 D RR^LR7OR1(PT,"",SDT,EDT,SUBSECT)
 F  S SUB=$O(^TMP("LRRR",$J,PT,SUB)) Q:SUB=""  D
 .S INVDT=0 F  S INVDT=$O(^TMP("LRRR",$J,PT,SUB,INVDT)) Q:INVDT=""  D
 ..S SEQ=0 F  S SEQ=$O(^TMP("LRRR",$J,PT,SUB,INVDT,SEQ)) Q:SEQ=""!(SEQ<1)  D
 ...S X=^(SEQ),Y(J)=$P(X,U)_U_$P(X,U,15)_U_$P(X,U,2)_U_$P(X,U,4)_U_$P(X,U,3)_U
 ...S EXTDT=$$EXTERNAL^DILFD(4.302,.01,"",9999999-INVDT),Y(J)=Y(J)_EXTDT
 ...S J=J+1
 K ^TMP("LRRR",$J)
 S:+$G(Y(1))<1 Y(1)="^No results found."
 Q
 ;
ORDER(Y,PATIENT,ORDER) ; return patient's lab results for an order:
 N RSLT
 S RSLT=$$GETDATA^OCXCACHE(.Y,"ORDERC^ORQQLR(.OCXDATA,"_PATIENT_","_ORDER_")",PATIENT,)
 Q
 ;
ORDERC(Y,PATIENT,ORDER) ; return patient's lab results for an order:
 N SUB,INVDT,SEQ,RESULT,J,LRORD S SUB="",INVDT=0,SEQ=0,J=1
 K ^TMP("LRRR",$J)
 S LRORD=$G(^OR(100,+ORDER,4))
 Q:'$L(LRORD)
 D RR^LR7OR1(PATIENT,LRORD,"","","","","")
 S SUB=$O(^TMP("LRRR",$J,PATIENT,SUB)) Q:SUB=""
 S INVDT=$O(^TMP("LRRR",$J,PATIENT,SUB,INVDT)) Q:'INVDT
 F  S SEQ=$O(^TMP("LRRR",$J,PATIENT,SUB,INVDT,SEQ)) Q:'SEQ  D
 .S RESULT=^(SEQ),Y(J)=$P(RESULT,U)_U_$P(RESULT,U,15)_U_$P(RESULT,U,2)_U_$P(RESULT,U,4)_U_$P(RESULT,U,3)_U_$P(RESULT,U,5)_U_INVDT,J=J+1
 K ^TMP("LRRR",$J)
 Q
DETAIL(LST,DFN,ORDER) ; return lab results for an order
 N LRORD,SUB,IDT,I,DATE,FLAG,REF,ILST
 S LST(1)="No detailed information found.",ILST=0
 S LRORD=$G(^OR(100,+ORDER,4))
 Q:'$L(LRORD)
 K ^TMP("LRRR",$J)
 D RR^LR7OR1(DFN,LRORD,"","","","","")
 S SUB="" F  S SUB=$O(^TMP("LRRR",$J,DFN,SUB)) Q:SUB=""  D
 . S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:'IDT  D
 . . S I=0 F  S I=$O(^TMP("LRRR",$J,DFN,SUB,IDT,I)) Q:'I  S X=^(I) D
 . . . S DATE=$$FMTE^XLFDT(9999999-IDT),FLAG=$P(X,U,3)
 . . . S REF=$P(X,U,5)
 . . . S:$L(REF) REF="("_$P(X,U,5)_")"
 . . . S X=$P(X,U,15)_U_$P(X,U,2)_U_$P(X,U,4)_U_FLAG_U_DATE_U_REF
 . . . S X=$$TABPIECE(X,"1,2,3,4,5,6","9,18,24,27,50")
 . . . S ILST=ILST+1,LST(ILST)=X
 K ^TMP("LRRR",$J)
 Q
TABPIECE(X,PIECES,TABS) ; return pieces with withspace between them
 N I,J,Y,APIECE S Y=""
 F I=1:1:$L(PIECES,",") S APIECE=+$P(PIECES,",",I) D
 . S Y=Y_$P(X,U,APIECE)
 . F J=$L(Y):1:+$P(TABS,",",I) S Y=Y_" "
 Q Y
ZDETAIL(Y,PATIENT,ORDER) ; return detailed, narrative results for an order:
 N CR,J,SUB,INVDT,SEQ,RESULT,EXTDT,FLAG,LRORD
 S CR=$CHAR(13),J=1,SUB="",INVDT=0,SEQ=0
 S LRORD=$$OETOLAB^ORQQLR1(+ORDER)
 I '$L($G(LRORD)) S Y(J)="No detailed information found." Q
 K ^TMP("LRRR",$J)
 D RR^LR7OR1(PATIENT,LRORD,"","","","","")
 S SUB=$O(^TMP("LRRR",$J,PATIENT,SUB))
 I '$L($G(SUB)) S Y(J)="No detailed information found." Q
 S INVDT=$O(^TMP("LRRR",$J,PATIENT,SUB,INVDT))
 I '$L($G(INVDT)) S Y(J)="No detailed information found." Q
 F  S SEQ=$O(^TMP("LRRR",$J,PATIENT,SUB,INVDT,SEQ)) Q:'SEQ  D
 .S RESULT=^(SEQ),Y(J)=$P(RESULT,U,15)_" "_$P(RESULT,U,2)_" "_$P(RESULT,U,4),FLAG=$P(RESULT,U,3)
 .S Y(J)=Y(J)_$S($L($G(FLAG)):" "_FLAG,1:"")
 .S EXTDT=$$EXTERNAL^DILFD(4.302,.01,"",9999999-INVDT)
 .S Y(J)=Y(J)_" "_EXTDT_" (ref. "_$P(RESULT,U,5)_")",J=J+1
 K ^TMP("LRRR",$J)
 Q
SROUT(ORY) ;return lab results search date range for an outpatient
 N DIFF,SDT,EDT,ORSRV
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S DIFF=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORQQLR SEARCH RANGE OUTPT",1,"E")
 S:+$G(DIFF)<1 DIFF=14  ;if no default defined use 14 days
 S ORY=DIFF
 Q
SRIN(ORY,ORPT) ;return lab results search date range for an inpatient
 N DIFF,SDT,EDT,ORSRV,ORLOC
 ;
 ;get patient's location flag (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 I +$G(ORPT)>0 D
 .N DFN S DFN=ORPT,VA200="" D OERR^VADPT
 .I +$G(VAIN(4))>0 S ORLOC=+$G(^DIC(42,+$G(VAIN(4)),44))
 .K VA200,VAIN
 ;
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S DIFF=$$GET^XPAR("USR^LOC.`"_$G(ORLOC)_"^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORQQLR SEARCH RANGE INPT",1,"E")
 S:+$G(DIFF)<1 DIFF=2  ;if no default defined use 2 days
 S ORY=DIFF
 Q
