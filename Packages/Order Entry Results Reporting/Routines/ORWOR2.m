ORWOR2 ; slc/dcm - Result RPC functions
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141**;Dec 17, 1997
ORDHIST  ; -- orders - compare with ORDERS^ORCXPND1
 I '$G(ORESULTS) D ORDERS^ORCXPND2 Q
 ; -- Result History Display (Add more packages as available)
 N PKG,TAB,ORIFN
 S PKG=+$P($G(^OR(100,+ID,0)),"^",14),PKG=$$NMSP^ORCD(PKG)
 S TAB=$S(PKG="LR":"LABS",PKG="GMRC":"CONSULTS",PKG="RA":"XRAYS",1:"")
 I '$L(TAB)!(ID'>0) D  Q  ; no display available
 . N ORY,I
 . D TEXT^ORQ12(.ORY,+ID,80)
 . S I=0 F  S I=$O(ORY(I)) Q:I'>0  D ITEM^ORCXPND(ORY(I))
 . D BLANK^ORCXPND
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="There are no results to report in this time range."
 I $O(^OR(100,+ID,2,0)) S ORIFN=+ID,ID=0 F  S ID=$O(^OR(100,ORIFN,2,ID)) Q:ID<1  I $D(^OR(100,ID,0)) D @TAB
 I '$O(^OR(100,+ID,2,0)) D @TAB
 Q
LABS ; -- laboratory [RESULTS ONLY for ID=OE order #]
 N ORIFN,X,Y,SUB,NAME,SS,IDE,IVDT,TST,CC,ORCY,IG,TCNT,ITEM,ORY,SDATE,EDATE,ITDATE,ITMDATE,NDT,STAR,LNM
 K ^TMP("LRRR",$J),^TMP("LRAPI",$J)
 S ORIFN=+ID,IDE=$G(^OR(100,+ID,4))
 Q:'$L(IDE)  ; OE# -> Lab#
 S ITEM=$$VALUE^ORX8(ID,"ORDERABLE",,"I"),ITMDATE=$S($P(ID,";",2):$P($G(^OR(100,ORIFN,8,$P(ID,";",2),0)),"^",16),1:$P(^OR(100,ORIFN,0),"^",8)),ITDATE=$$FMTE^XLFDT(ITMDATE,"1M")
 Q:'ITEM
 S ITEM=+$P($G(^ORD(101.43,+ITEM,0)),"^",2)
 S $P(IDE,";",1,3)=";;"
 S SDATE=9999999-$S($P(IDE,";",5):$P(IDE,";",5),1:ITMDATE),EDATE=$$FMADD^XLFDT(DT,-1825) ;Set for previous 5 years
 D RR^LR7OR1(+ORVP,,SDATE,EDATE,,ITEM,,5)
 K ORCY D TEXT^ORQ12(.ORCY,ORIFN,80)
 S IG=0 F  S IG=$O(ORCY(IG)) Q:IG<1  S X=ORCY(IG) D ITEM^ORCXPND(X)
 D BLANK^ORCXPND
 I '$D(^TMP("LRRR",$J,+ORVP)) S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="No data available." Q
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Order Released: "_ITDATE_$S('$P(IDE,";",5):" (Results not yet available for this order)",1:"  (* Results for this order)")
 S CC=0,SS="",TCNT=0
 F  S SS=$O(^TMP("LRRR",$J,+ORVP,SS)) Q:SS=""  S IVDT=0 F  S IVDT=$O(^TMP("LRRR",$J,+ORVP,SS,IVDT)) Q:'IVDT  D  Q:SS="MI"  Q:SS="BB"
 . S NDT=1,STAR=" "
 . I SS="BB" K ^TMP("LRC",$J) D EN1^LR7OSBR(+ORVP) Q:'$D(^TMP("LRC",$J))  D  Q
 .. N I S I=0 F  S I=$O(^TMP("LRC",$J,I)) Q:I<1  S X=^(I,0),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X
 .. K ^TMP("LRC",$J)
 . I SS="MI" K ^TMP("LRC",$J) D EN^LR7OSMZ0(+ORVP) Q:'$D(^TMP("LRC",$J))  D  Q
 .. S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Previous 5 sets of related results within 5 years... "
 .. N I S I=0 F  S I=$O(^TMP("LRC",$J,I)) Q:I<1  S X=^(I,0),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X
 .. K ^TMP("LRC",$J)
 . I SS="CH",$O(^TMP("LRRR",$J,+ORVP,SS,IVDT,0)) D  Q
 .. S TST=0 F  S TST=$O(^TMP("LRRR",$J,+ORVP,SS,IVDT,TST)) Q:TST=""  S CC=0,Y="",TCNT=TCNT+1,X=$S(TST:^TMP("LRRR",$J,+ORVP,SS,IVDT,TST),1:"") D
 ... I TCNT=1 D
 .... S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Previous 5 sets of related results within 5 years... "
 .... D BLANK^ORCXPND
 .... S CC=0,LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$$S(1,CC," ")_$$S(1,CC,"Collection Time")_$$S(21,CC,"Test Name")_$$S(34,CC,"Result")_$$S(42,CC,"Units")_$$S(58,CC,"Range")
 .... S CC=0,LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$$S(1,CC," ")_$$S(1,CC,"------------------")_$$S(21,CC,"---------")_$$S(34,CC,"------")_$$S(42,CC,"-----")_$$S(58,CC,"-----")
 ... I TST S X=^TMP("LRRR",$J,+ORVP,SS,IVDT,TST),CC=0 I +X D
 .... I NDT=1,$P(IDE,";",5)=IVDT S STAR="*"
 .... S LCNT=LCNT+1,LNM=$S($D(^LAB(60,+X,.1)):$P(^(.1),U),1:$P(^(0),U))
 .... S ^TMP("ORXPND",$J,LCNT,0)=STAR_$S(NDT=1:$$S(1,CC,$$FMTE^XLFDT(9999999-IVDT,"1M")),1:$$S(1,CC,"   "))_$$S(20,CC,LNM)_$$S(30,CC,$J($P(X,U,2),7))
 .... I $L($P(X,U,2))<8 S ^TMP("ORXPND",$J,LCNT,0)=^TMP("ORXPND",$J,LCNT,0)_$$S(36,CC,$S($L($P(X,U,3)):$P(X,U,3),1:""))_$$S(41,CC,$P(X,U,4))_$$S(47,CC,$J($P(X,U,5),15))
 .... E  S CC=0,LCNT=LCNT+1,$P(Y," ",38)="",^TMP("ORXPND",$J,LCNT,0)=$$S(1,CC,Y)_$$S(36,CC,$S($L($P(X,U,3)):$P(X,U,3),1:""))_$$S(42,CC,$P(X,U,4))_$$S(58,CC,$J($P(X,U,5),15))
 .... S NDT=0
 ... I TST="N" S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="  Comments: " D
 .... N CMT S CMT=0 F  S CMT=$O(^TMP("LRRR",$J,+ORVP,SS,IVDT,"N",CMT)) Q:'CMT  S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="   "_^TMP("LRRR",$J,+ORVP,SS,IVDT,"N",CMT)
 K ^TMP("LRRR",$J),^TMP("LRAPI",$J)
 Q
CONSULTS ; -- consults
 N I,X,SUB,ORTX
 I $G(ORTAB)="CONSULTS" S X=$P($G(^TMP("OR",$J,ORTAB,"IDX",NUM)),U,4)
 E  D TEXT^ORQ12(.ORTX,+ID) S X=ORTX(1),ID=+$G(^OR(100,+ID,4)) ; OE->GMRC order#
 D ITEM^ORCXPND(X),BLANK^ORCXPND
 I ID'>0 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="No data available." Q
 I '$G(ORESULTS) D  ;DT action
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Consult No.:           "_ID
 . N GMRCOER S GMRCOER=2 D DT^GMRCSLM2(ID) S SUB="DT"
 I $G(ORESULTS) D RT^GMRCGUIA(ID,"^TMP(""GMRCR"",$J,""RT"")") S SUB="RT"
 S I=0 F  S I=$O(^TMP("GMRCR",$J,SUB,I)) Q:I'>0  S X=$G(^(I,0)),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X
 K ^TMP("GMRCR",$J)
 Q
 ;
XRAYS ; -- Radiology
 I '$G(ORESULTS) S ID=+ORVP_U_$TR(ID,"-","^") D EN3^RAO7PC3(ID)
 I $G(ORESULTS) S ID=+$G(^OR(100,+ID,4)) D EN30^RAO7PC3(ID)
 N CASE,PROC,PSET
 S PSET=$D(^TMP($J,"RAE3",+ORVP,"PRINT_SET")),CASE=0
 F  S CASE=$O(^TMP($J,"RAE3",+ORVP,CASE)) Q:CASE'>0  D
 . I PSET S PROC=$O(^TMP($J,"RAE3",+ORVP,CASE,"")) D ITEM^ORCXPND(PROC) Q
 . S PROC="" F  S PROC=$O(^TMP($J,"RAE3",+ORVP,CASE,PROC)) Q:PROC=""  D ITEM^ORCXPND(PROC),BLANK^ORCXPND,XRPT,BLANK^ORCXPND
 I PSET S CASE=$O(^TMP($J,"RAE3",+ORVP,0)),PROC=$O(^(CASE,"")) D BLANK^ORCXPND,XRPT,BLANK^ORCXPND ;printset=list all procs, then one report
 K ^TMP($J,"RAE3",+ORVP) S VALM("RM")=81
 Q
XRPT ; -- body of report for CASE, PROC
 N ORD,X,I
 S ORD=$S($L($G(^TMP($J,"RAE3",+ORVP,"ORD"))):^("ORD"),$L($G(^("ORD",CASE))):^(CASE),1:"") I $L(ORD),ORD'=PROC S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Proc Ord: "_ORD
 S I=1 F  S I=$O(^TMP($J,"RAE3",+ORVP,CASE,PROC,I)) Q:I'>0  S X=^(I),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X ;Skip pt ID on line 1
 Q
 ;
S(X,Y,Z) ;Pad over
 ;X=Column #
 ;Y=Current length
 ;Z=Text
 ;SP=TEXT SENT
 ;CC=Line position after input text
 I '$D(Z) Q ""
 N SP S SP=Z I X,Y,X>Y S SP=$E("                                                                             ",1,X-Y)_Z
 S CC=$$INC(CC,SP)
 Q SP
INC(X,Y) ;Character position count
 ;X=Current count
 ;Y=Text
 N INC S INC=X+$L(Y)
 Q INC
