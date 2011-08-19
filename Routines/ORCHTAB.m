ORCHTAB ;SLC/MKB-Build Chart tab listings ;05:58 PM  23 Aug 2000
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**27,72,68,94**;Dec 17, 1997
EN ; -- rebuild ORTAB listing
 N CONTEXT,DEFCXT,LCNT,NUM,ORTITLE,ORCAPTN,ORMENU,ORACTNS,ORCHANGE,Z,ORMAX,ORRM
 S CONTEXT=$S($P($G(^TMP("OR",$J,ORTAB,0)),U,4):"",1:$P($G(^(0)),U,3))
 S (LCNT,NUM)=0,ORMAX=40 K ^TMP("OR",$J,ORTAB)
 D EN^ORCHTAB1 ; rebuild ORTAB via CONTEXT
 I 'LCNT S LCNT=1,^TMP("OR",$J,ORTAB,1,0)="     "_$$PAD("No data available.",40)_"|"
 S ^TMP("OR",$J,ORTAB,0)=LCNT_U_NUM_U_CONTEXT_U_$G(DEFCXT),^("TITLE")=$G(ORTITLE),^("RM")=$S($G(ORRM):ORRM,1:240)
 I $D(ORCHANGE) S Z=$O(^ORD(101,"B",ORCHANGE,0)) S:Z ^TMP("OR",$J,ORTAB,"CHANGE")=Z_";ORD(101,"
 I $D(ORACTNS),NUM S Z=$O(^ORD(101,"B",ORACTNS,0)) S:Z ^TMP("OR",$J,ORTAB,"#")=Z_"^1:"_NUM
 I $D(ORMENU) S Z=$O(^ORD(101,"B",ORMENU,0)) S:Z ^TMP("OR",$J,ORTAB,"MENU")=Z_";ORD(101,"
 I $D(ORCAPTN) M ^TMP("OR",$J,ORTAB,"CAPTION")=ORCAPTN
 Q
 ;
SUBHDR(X) ; -- add subheader X to listing
 S LCNT=LCNT+1,^TMP("OR",$J,ORTAB,LCNT,0)="     "_$$PAD(X,40)_"|"
 D SETVIDEO(LCNT,6,$L(X),IOUON,IOUOFF)
 S ^TMP("OR",$J,ORTAB,"HDR",X)=LCNT
 Q
 ;
ADD ; -- add item to listing
 N FIRST,LINES,I
 S LCNT=LCNT+1,NUM=NUM+1,FIRST=LCNT,LINES=+$G(ORTX)
 S:+$G(DATA)>LINES LINES=+DATA
 S ^TMP("OR",$J,ORTAB,"IDX",NUM)=ID_U_FIRST_U_LINES_U_$G(ORIFN)
 S ^TMP("OR",$J,ORTAB,LCNT,0)=$$PAD(NUM,5)_$$PAD($G(ORTX(1)),40)_"| "_$G(DATA(1))
 F I=2:1:LINES S LCNT=LCNT+1,^TMP("OR",$J,ORTAB,LCNT,0)="     "_$$PAD($G(ORTX(I)),40)_"| "_$G(DATA(I))
 D:$L(ID) SETVIDEO(FIRST,1,5,IOINHI,IOINORM) ; hilite selectable items
 K ORTX
 Q
 ;
LINE ; -- add line X with DATA to listing
 S LCNT=LCNT+1,^TMP("OR",$J,ORTAB,LCNT,0)="     "_$$PAD(X,40)_"| "_$G(DATA)
 Q
 ;
BLANK ; -- add blank line
 S LCNT=LCNT+1,^TMP("OR",$J,ORTAB,LCNT,0)=$$REPEAT^XLFSTR(" ",45)_"|"
 Q
 ;
SETVIDEO(LINE,COL,WIDTH,ON,OFF) ; -- set video attributes
 S ^TMP("OR",$J,ORTAB,"VIDEO",LINE,COL,WIDTH)=ON
 S ^TMP("OR",$J,ORTAB,"VIDEO",LINE,COL+WIDTH,0)=OFF
 Q
 ;
PAD(X,WIDTH) ; -- returns X padded with spaces to total WIDTH
 N Y S Y=X_$$REPEAT^XLFSTR(" ",WIDTH-$L(X))
 Q Y
 ;
DATE(X) ;
 N D,Y S D=$P(X,".") I D="" Q ""
 I 'D Q $E($$FTDATE^ORCD(D),1,8) ; free text date
 S Y=$E(D,4,5)_"/"_$E(D,6,7)_"/"_$E(D,2,3)
 Q Y
 ;
DATETIME(X,LF) ;
 N D,T,Y,YR,TM I X="" Q ""
 I X'>0 S X=$$FTDT(X) Q:X'?7N.1".".6N X ;free text date/time
 S D=$P(X,"."),T=$P(X,".",2) I D="" Q ""
 S Y=$E(D,4,5)_"/"_$E(D,6,7),YR=1700+$E(D,1,3),TM=""
 I T S:$L(T)<4 T=T_$E("0000",1,4-$L(T)) S TM=$E(T,1,2)_":"_$E(T,3,4)
 I '$G(LF) S Y=Y_"/"_$E(YR,3,4)_$S(T:" "_TM,1:"") ;not Order Long Format
 E  S Y=Y_$S(X'<($$NOW^XLFDT-10000):" "_TM,LF=1:" "_YR,1:"/"_$E(YR,3,4))
 Q Y
 ;
FTDT(X) ; -- Return free text date for use in Tab displays
 N Y,%DT S X=$$UP^XLFSTR(X)
 Q:"NOW"[X "NOW" I X?1"NOW+"1.N.E Q X
 I "NOON"[X Q "NOON"
 I $E("MIDNIGHT",1,$L(X))[X Q "MIDNIGHT"
 I (X="AM")!(X="NEXT")!(X="CLOSEST") Q X
 I X="NEXTA" Q "NEXT"
 I $E(X)="T" D  Q Y
 . N X1,X2 S X1=$P(X,"@"),X2=$P(X,"@",2)
 . S Y=$S(X1="T":"TODAY",1:X1)_" "_X2
 S %DT="TX" D ^%DT
 Q Y
 ;
LNAMEF(X) ; -- Returns user X name as LNAME,F
 N LN,FN,Y S X=$P($G(^VA(200,+X,0)),U) Q:X="" "UNKNOWN"
 S LN=$P(X,","),FN=$P(X,",",2) S:$E(FN)=" " FN=$E(FN,2,99)
 S Y=$E(LN,1,8)_","_$E(FN)
 Q Y
 ;
TXT ; -- Add text in X to ORTX() up to ORMAX width
 N I,Y S:'$G(ORTX) ORTX=1,ORTX(1)="" S Y=$L(ORTX(ORTX))
 I $L(ORTX(ORTX)_" "_X)'>ORMAX S ORTX(ORTX)=ORTX(ORTX)_$S(Y:" ",1:"")_X Q
 F I=1:1:$L(X," ") S:$L(ORTX(ORTX)_" "_$P(X," ",I))>ORMAX ORTX=ORTX+1,Y=0 S ORTX(ORTX)=$G(ORTX(ORTX))_$S(Y:" ",1:"")_$P(X," ",I),Y=1
 Q
 ;
ACCESS() ; -- Does user have menu tree access to CPRS?
 I '$L($T(ACCESS^XQCHK)) Q 1 ;Can't check - allow access
 N OROK,ORTYP,OROPT S OROK=0
 F ORTYP="WARD CLERK","NURSE","CLINICIAN" D  Q:OROK
 . S OROPT=+$$FIND1^DIC(19,"","QX","OR OE/RR MENU "_ORTYP) Q:OROPT'>0
 . S:$$ACCESS^XQCHK(DUZ,OROPT)>0 OROK=1
 Q OROK
