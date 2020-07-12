ORQQPP ;SLC/CLA - Functions which return patient postings ;Jun 14, 2019@10:19
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
LIST(ORY,ORPT) ;return pt's patient posting list
 Q:'$L($G(ORPT))
 N I,J,X,FMDT,MSG
 K ^TMP("TIUPPCV",$J)
 D ENCOVER^TIUPP3(ORPT)
 I +MSG'=0 S ORY(1)="^No patient postings found."
 S I=0,J=1,X=""
 F  S I=$O(^TMP("TIUPPCV",$J,I)) Q:I<1  D
 .S X=^TMP("TIUPPCV",$J,I),ORY(J)=$P(X,U)_U_$P(X,U,3)_U_$P(X,U,5),J=J+1
 K ^TMP("TIUPPCV",$J)
 D POSTLIST^WVRPCOR(.ORY,ORPT,.J)
 Q
PPIMM(ORY,ORPT) ;return pt's patient postings and immunizations
 Q:'$L($G(ORPT))
 N IMM,IVDT,IEN,X,ORJ
 D LIST(.ORY,ORPT)
 S ORJ=$O(ORY("?"),-1)+1
 I $L($T(IMMUN^PXRHS03))<1 S ORY(ORJ)=";I^Immunizations not available." Q
 K ^TMP("PXI",$J)
 D IMMUN^PXRHS03(ORPT)
 S IMM="",IVDT="",IEN=0
 F  S IMM=$O(^TMP("PXI",$J,IMM)) Q:IMM=""  D
 .F  S IVDT=$O(^TMP("PXI",$J,IMM,IVDT)) Q:IVDT=""  D
 ..F  S IEN=$O(^TMP("PXI",$J,IMM,IVDT,IEN)) Q:IEN<1  D
 ...S X=$G(^TMP("PXI",$J,IMM,IVDT,IEN,0)) Q:'$L(X)
 ...S ORY(ORJ)=IEN_";I"_U_IMM_U_$P(X,U,3),ORJ=ORJ+1
 S:'$L($G(ORY(ORJ))) ORY(ORJ)=";I^No immunizations found.^2900101"
 K ^TMP("PXI",$J)
 Q
