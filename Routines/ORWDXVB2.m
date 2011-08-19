ORWDXVB2 ;slc/dcm - Order dialog utilities for Blood Bank Cont.;3/2/04  09:31
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,243,212,309**;Dec 17 1997;Build 26
 ;
ERROR ;Process error
 N ORERR,ORI,X
 S VBERROR=$P(ORX("ERROR"),"^",2) D LN
 D GETWP^XPAR(.ORERR,"ALL","OR VBECS ERROR MESSAGE")
 S ORI=0,X="" F  S ORI=$O(ORERR(ORI)) Q:ORI<1  D
 . S X=$G(ORERR(ORI,0))
 . S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,X,.CCNT) D LN
 I X'?1."*" S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"******************************************************************",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                         Error Message                          *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*",.CCNT)
 I $L(VBERROR)<68 D
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(70-$L(VBERROR)/2,CCNT,VBERROR,.CCNT)
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(67,CCNT,"*",.CCNT) D LN
 I $L(VBERROR)>68 D
 . I $L(VBERROR)>136 S VBERROR=$E(VBERROR,1,136)_"..."
 . N L1 S L1=$E(VBERROR,1,$L(VBERROR)/2)
 . I $E(L1,$L(L1))'=" " D
 . . S LINE1=$E(L1,1,($L(L1)-($L($P(L1," ",$L(L1," ")))))),LINE2=$E(VBERROR,$L(LINE1)+1,$L(VBERROR))
 . E  S LINE1=$E(L1),LINE2=$E(VBERROR,$L(LINE1)+1,$L(VBERROR))
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(70-$L(LINE1)/2,CCNT,LINE1,.CCNT)
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(67,CCNT,"*",.CCNT) D LN
 . S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*",.CCNT)
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(70-$L(LINE2)/2,CCNT,LINE2,.CCNT)
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(67,CCNT,"*",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"******************************************************************",.CCNT) D LN
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
