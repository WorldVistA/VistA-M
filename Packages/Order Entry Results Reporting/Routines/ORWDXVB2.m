ORWDXVB2 ;slc/dcm - Order dialog utilities for Blood Bank Cont.;3/2/04  09:31
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,243,212,309,332**;Dec 17 1997;Build 44
 ;
ERROR(OROOT) ;Process error
 N ORERR,ORI,X,Y,I
 S VBERROR=$P(ORX("ERROR"),"^",2) D LN
 D GETWP^XPAR(.ORERR,"ALL","OR VBECS ERROR MESSAGE")
 S ORI=0,Y="" F  S ORI=$O(ORERR(ORI)) Q:ORI<1  D
 . S Y=$G(ORERR(ORI,0))
 . D WRAP^ORU2(.Y,79)
 . F I=1:1 S X=$P(Y,"|",I) Q:'$L(X)  D
 .. S @OROOT@(GCNT,0)=$$S^ORU4($S(I=1:2,1:1),CCNT,X,.CCNT) D LN
 D WRAP^ORU2(.VBERROR,77)
 I X'?1."*" S @OROOT@(GCNT,0)=$$S^ORU4(1,CCNT,"********************************************************************************",.CCNT) D LN
 S @OROOT@(GCNT,0)=$$S^ORU4(1,CCNT,"*                                                                              *",.CCNT) D LN
 S @OROOT@(GCNT,0)=$$S^ORU4(1,CCNT,"*                                Error Message                                 *",.CCNT) D LN
 S @OROOT@(GCNT,0)=$$S^ORU4(1,CCNT,"*                                                                              *",.CCNT) D LN
 F I=1:1 S X=$P(VBERROR,"|",I) Q:'$L(X)  D
 . S @OROOT@(GCNT,0)=$$S^ORU4(1,CCNT,"*",.CCNT)
 . S @OROOT@(GCNT,0)=@OROOT@(GCNT,0)_$$S^ORU4(80-$L(X)/2,CCNT,X,.CCNT)
 . S @OROOT@(GCNT,0)=@OROOT@(GCNT,0)_$$S^ORU4(80,CCNT,"*",.CCNT) D LN
 S @OROOT@(GCNT,0)=$$S^ORU4(1,CCNT,"*                                                                              *",.CCNT) D LN
 S @OROOT@(GCNT,0)=$$S^ORU4(1,CCNT,"********************************************************************************",.CCNT) D LN
 D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 Q
PULL(OROOT,ORVP,ITEMID,SDATE,EDATE) ;Get list of orders matching ITEM
 ;ITEM = Orderable Item ID e.g. "1;99VBC" for Type and Screen
 ;SDATE = Start Date for search
 ;EDATE = End Date for search
 Q:'$G(ORVP)
 N ORTNSB
 I $P(ORVP,";",2)="" S ORVP=ORVP_";DPT("
 S ORTNSB=$$GET^XPAR("ALL","ORWDXVB VBECS TNS CHECK",1,"I")
 S:'ORTNSB ORTNSB=3 ;Use Default of DT-3 or Parameter [ORWDXVB VBECS TNS CHECK] if no start date passed in
 S ITEMID=$S($D(ITEMID):ITEMID,1:"1;99VBC") ;Default to Type and Screen if nothing passed in
 S SDATE=$S($D(SDATE):SDATE,1:$$FMADD^XLFDT(DT-ORTNSB))
 S EDATE=$S($D(EDATE):EDATE,1:DT) ;Default to DT if no End date passed in
 N ORDG,FLG,ORLIST,ORX0,ORX3,ORSTAT,ORIFN,I,X,J,CNT,ITEM,ITEMNM,ORLOC,DIV
 S ITEM=+$O(^ORD(101.43,"ID",ITEMID,0)),ITEMNM=$P($G(^ORD(101.43,ITEM,0)),"^")
 S CNT=0,ORDG=$O(^ORD(100.98,"B","VBEC",0)) Q:'ORDG
 F FLG=4,23 D  ;Get completed, active/pending
 . K ^TMP("ORR",$J)
 . D EN^ORQ1(ORVP,ORDG,FLG,0,SDATE,EDATE)
 . I '$O(^TMP("ORR",$J,ORLIST,0)) Q
 . S I=0
 . F  S I=$O(^TMP("ORR",$J,ORLIST,I)) Q:'I  S X=^(I) D
 .. S ORIFN=+X,J=0,DIV=""
 .. Q:'$D(^OR(100,ORIFN,0))  S ORX0=^(0),ORX3=^(3)
 .. I (($P(ORX3,"^",3)=2)!($P(ORX3,"^",3)=7)),'$L($G(ORX("SPECIMEN"))) Q  ;Test completed/expired, yet VBECS doesn't have a specimen
 .. S ORSTAT=$S($D(^ORD(100.01,+$P(ORX3,"^",3),0)):$P(^(0),"^"),1:""),ORLOC=$S($L($P($G(^SC(+$P(ORX0,"^",10),0)),"^")):$P(^(0),"^"),1:"UNKNOWN")
 .. I +$P(ORX0,"^",10) S DIV=$P($G(^SC(+$P(ORX0,"^",10),0)),U,15),DIV=$S(DIV:$P($$SITE^VASITE(DT,DIV),"^",2),1:"")
 .. F  S J=$O(^OR(100,ORIFN,4.5,"ID","ORDERABLE",J)) Q:'J  I +$G(^OR(100,ORIFN,4.5,J,1))=ITEM D
 ... S CNT=CNT+1,OROOT(CNT)="Duplicate order: "_ITEMNM_" entered "_$$FMTE^XLFDT($P(ORX0,"^",7))_" Div/Loc: "_DIV_":"_ORLOC_" ["_ORSTAT_"]"
 Q
LN ;Increment counts
 S GCNT=GCNT+1,CCNT=1
 Q
