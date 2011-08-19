ORQ2 ; SLC/MKB/GSS - Detailed Order Report ;03/14/11  09:33
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**12,56,75,94,141,213,195,243,282,293,280,346**;Dec 17, 1997;Build 5
 ;
 ;
 ;Reference to ^DIC(45.7 supported by IA #519
 ;Reference to OERR^VADPT supported by IA #4325
 ;
DETAIL(ORY,ORIFN) ; -- Returns details of order ORIFN in ORY(#)
 N X,X2,I,CNT,ORDIALOG,OR0,OR3,OR6,SEQ,ITEM,PRMT,MULT,FIRST,TITLE,INST,DIWL,DIWR,DIWF,ACTION,VAIN,ORIGVIEW,ORNMSP,ORYT
 S CNT=0,ORIFN=+ORIFN,OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),OR6=$G(^(6))
 S ORNMSP=$$NMSP^ORCD($P(OR0,U,14))
 K @ORY,ORYT S ORIGVIEW=1 D TEXT^ORQ12(.ORYT,+ORIFN_";"_+$P(OR3,U,7),80) ;CurrTx
 M @ORY=ORYT ;Move text to global
 S I=0 F CNT=1:1 S I=$O(ORYT(I)) Q:I'>0  D:$D(IORVON) SETVIDEO(I,1,$L(ORYT(I)),IORVON,IORVOFF)
 S CNT=CNT+1,@ORY@(CNT)="   " ;blank
D1 I $O(^OR(100,+ORIFN,2,0)) D
 . S CNT=CNT+1,@ORY@(CNT)="Sub Orders:"
 . D:$D(IOUON) SETVIDEO(CNT,1,11,IOUON,IOUOFF)
 . N IFN S IFN=0
 . F  S IFN=+$O(^OR(100,+ORIFN,2,IFN)) Q:IFN<1  I $D(^OR(100,IFN,0)) D SUB(IFN)
 . S CNT=CNT+1,@ORY@(CNT)="   " ;blank
 I $P(OR3,U,9),$D(^OR(100,+$P(OR3,U,9),0)) D
 . S CNT=CNT+1,@ORY@(CNT)="Parent Order:"
 . D:$D(IOUON) SETVIDEO(CNT,1,12,IOUON,IOUOFF)
 . D SUB(+$P(OR3,U,9))
 . S CNT=CNT+1,@ORY@(CNT)="   " ;blank
 I $P(OR3,U,11)=1,$P(OR3,U,5) D  ;Changed - show previous order
 . S CNT=CNT+1,@ORY@(CNT)="Previous Order:"
 . D:$D(IOUON) SETVIDEO(CNT,1,15,IOUON,IOUOFF) ;prev order original text
 . N ORZ,I,ORIGVIEW S ORIGVIEW=2 D TEXT^ORQ12(.ORZ,+$P(OR3,U,5),55)
 . S CNT=CNT+1,@ORY@(CNT)="     Order Text:        "_$G(ORZ(1))
 . S I=1 F  S I=$O(ORZ(I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=$$REPEAT^XLFSTR(" ",24)_$G(ORZ(I))
D2 S CNT=CNT+1,@ORY@(CNT)="Activity:"
 D:$D(IOUON) SETVIDEO(CNT,1,9,IOUON,IOUOFF)
 S DIWL=1,DIWR=64,DIWF="C64",ORI=0 K ^UTILITY($J,"W")
 F  S ORI=$O(^OR(100,ORIFN,8,ORI)) Q:ORI'>0  S ACTION=$G(^(ORI,0)) D ACT^ORQ20
 I "^1^12^13^"[(U_$P(OR3,U,3)_U),$L(OR6),$P(ACTION,U,2)'="DC" D DC^ORQ20
 I $P(OR3,U,3)=2,$P(OR6,U,6) S CNT=CNT+1,@ORY@(CNT)=$$DATE^ORQ20($P(OR6,U,6))_"  Completed"_$S($P(OR6,U,7):" by "_$$USER^ORQ20($P(OR6,U,7)),1:"")
 S CNT=CNT+1,@ORY@(CNT)="   " ;blank
D3 S CNT=CNT+1,@ORY@(CNT)="Current Data:"
 D:$D(IOUON) SETVIDEO(CNT,1,13,IOUON,IOUOFF)
 D VA I $G(VAIN(2)) S CNT=CNT+1,@ORY@(CNT)="Current Primary Provider:     "_$P(VAIN(2),"^",2)
 I $G(VAIN(11)) S CNT=CNT+1,@ORY@(CNT)="Current Attending Physician:  "_$P(VAIN(11),"^",2)
 S CNT=CNT+1,@ORY@(CNT)="Treating Specialty:           "_$P($G(^DIC(45.7,+$P(OR0,U,13),0)),U)
 S CNT=CNT+1,@ORY@(CNT)="Ordering Location:            "_$P($G(^SC(+$P(OR0,U,10),0)),U)
 S CNT=CNT+1,@ORY@(CNT)="Start Date/Time:              "_$S($P(OR0,U,8):$$DATE^ORQ20($P(OR0,U,8)),1:"")
 I $P(OR3,U,5),$P(OR3,U,11)=2 S X=$$ORIG(ORIFN),@ORY@(CNT)=@ORY@(CNT)_" (originally "_$$DATE^ORQ20(X)_")"
 S CNT=CNT+1,@ORY@(CNT)="Stop Date/Time:               "_$S($P(OR0,U,9):$$DATE^ORQ20($P(OR0,U,9)),1:"")
 I $P(OR3,U,3)=1,$P(OR6,U,6) S @ORY@(CNT)=@ORY@(CNT)_"  (expired "_$$DATE^ORQ20($P(OR6,U,6))_")"
 S CNT=CNT+1,@ORY@(CNT)="Current Status:               "_$S($D(^ORD(100.01,+$P(OR3,U,3),0)):$P(^(0),"^"),1:"-")
 I $$GET^XPAR("ALL","ORPF SHOW STATUS DESCRIPTION",1,"I"),$P(OR3,U,3),$D(^ORD(100.01,$P(OR3,U,3),0)) N J S J=0 F  S J=$O(^ORD(100.01,$P(OR3,U,3),1,J)) Q:J<1  S CNT=CNT+1,@ORY@(CNT)="  "_^(J,0)
 S CNT=CNT+1,@ORY@(CNT)="Order #"_ORIFN
 S CNT=CNT+1,@ORY@(CNT)="   " ;blank
D4 S CNT=CNT+1,@ORY@(CNT)="Order:" D:$D(IOUON) SETVIDEO(CNT,1,6,IOUON,IOUOFF)
 I '$O(^OR(100,ORIFN,4.5,0)),ORNMSP="RA" D RAD^ORQ21("") Q
 S ORDIALOG=$P(OR0,U,5) Q:$P(ORDIALOG,";",2)="ORD(101,"  ; 2.5 order
 D GETDLG^ORCD(+ORDIALOG),GETORDER^ORCD(ORIFN)
 S DIWL=1,DIWR=50,DIWF="C50"
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ)) Q:SEQ'>0  S DA=0 F  S DA=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ,DA)) Q:'DA  D
 . S ITEM=$G(^ORD(101.41,+ORDIALOG,10,DA,0)) Q:$P(ITEM,U,11)  ; child
 . S PRMT=$P(ITEM,U,2),MULT=$P(ITEM,U,7) Q:$P(ITEM,U,9)["*"  ;hide
 . S FIRST=$O(ORDIALOG(PRMT,0)) Q:'FIRST  ; no values
 . S TITLE=$S(MULT&$L($G(ORDIALOG(PRMT,"TTL"))):ORDIALOG(PRMT,"TTL"),1:ORDIALOG(PRMT,"A"))
 . S TITLE=TITLE_$$REPEAT^XLFSTR(" ",30-$L(TITLE))
 . S INST=0 F  S INST=$O(ORDIALOG(PRMT,INST)) Q:INST'>0  D
 . . I $E(ORDIALOG(PRMT,0))="W" D WP Q
 . . K ^UTILITY($J,"W") S X=$$EXT^ORCD(PRMT,INST) I TITLE["Infusion Rate"&(X'="")&(X'["ml/hr") S TITLE="Infuse Over Time:",TITLE=TITLE_$$REPEAT^XLFSTR(" ",30-$L(TITLE))
 . . D ^DIWP
 . . D:$D(^ORD(101.41,+ORDIALOG,10,"DAD",PRMT)) CHILDREN(PRMT)
 . . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=$S((INST=FIRST)&(I=1):TITLE,1:$$REPEAT^XLFSTR(" ",30))_^(I,0)
 I ORNMSP="GMRC",$G(^OR(100,ORIFN,4)) S CNT=CNT+1,@ORY@(CNT)="Consult No.:                  "_+^(4)
 S CNT=CNT+1,@ORY@(CNT)="   " ;blank
 D RAD^ORQ21(1):ORNMSP="RA",MED^ORQ21:ORNMSP="PS" ;add'l data
 D BA^ORQ21 ;call for CIDC data
D5 K ^TMP($J,"OCDATA") I $$OCAPI^ORCHECK(+ORIFN,"OCDATA") D
 . N CK,OK,X0,X,CDL,I S CNT=CNT+1,@ORY@(CNT)="Order Checks:"
 . D:$D(IOUON) SETVIDEO(CNT,1,13,IOUON,IOUOFF)
 . S CK=0 F  S CK=$O(^TMP($J,"OCDATA",CK)) Q:CK'>0  D
 .. S X0=^TMP($J,"OCDATA",CK,"OC NUMBER")_U_^TMP($J,"OCDATA",CK,"OC LEVEL")_U_U_^TMP($J,"OCDATA",CK,"OR REASON")_U_^TMP($J,"OCDATA",CK,"OR PROVIDER")_U_^TMP($J,"OCDATA",CK,"OR DT")
 .. S X=^TMP($J,"OCDATA",CK,"OC TEXT",1,0)
 .. S CDL=$$CDL($P(X0,U,2)) I $P(X0,U,6),'$D(OK) S OK=$P(X0,U,4,6)
 .. I $L(X)'>68 S CNT=CNT+1,@ORY@(CNT)=CDL_X D XTRA Q
 .. S DIWL=1,DIWR=68,DIWF="C68" K ^UTILITY($J,"W") D ^DIWP
 .. S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=CDL_^(I,0),CDL="            "
 .. D XTRA
 . K ^TMP($J,"OCDATA")
 . Q:'$L($G(OK))  S CNT=CNT+1,@ORY@(CNT)="Override:   "_$S($P(OK,U,2):$$USER^ORQ20($P(OK,U,2))_" on ",1:"")_$$DATE^ORQ20($P(OK,U,3))
 . I $L($P(OK,U))'>68 S CNT=CNT+1,@ORY@(CNT)="            "_$P(OK,U) Q
 . S DIWL=1,DIWR=68,DIWF="C68",X=$P(OK,U) K ^UTILITY($J,"W") D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)="            "_^(I,0)
 K ^TMP("ORWORD",$J),^UTILITY($J,"W")
 Q
 ;
XTRA ;
 I $O(^TMP($J,"OCDATA",CK,"OC TEXT",1)) N ORXT S ORXT=1 F  S ORXT=$O(^TMP($J,"OCDATA",CK,"OC TEXT",ORXT)) Q:'ORXT  D
 . S X=^TMP($J,"OCDATA",CK,"OC TEXT",ORXT,0),CDL="              "
 . I $L(X)'>68 S CNT=CNT+1,@ORY@(CNT)=CDL_X Q
 . S DIWL=1,DIWR=68,DIWF="C68" K ^UTILITY($J,"W") D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=CDL_^(I,0),CDL="              "
 I $O(^TMP($J,"OCDATA",CK,"OC TEXT",1)) S X="",CNT=CNT+1,@ORY@(CNT)="              "
 Q
 ;
SUB(IFN) ; -- add suborder or parent
 N ORCY,STS,STRT,IG,A,STOP,SCHED D TEXT^ORQ12(.ORCY,IFN,58)
 S STS=$G(^ORD(100.01,+$P($G(^OR(100,IFN,3)),U,3),.1))
 S A=^OR(100,IFN,0),STRT=$P(A,U,8),STOP=$P(A,U,9)
 S SCHED=$$VALUE^ORX8(IFN,"SCHEDULE",1,"E")
 S:STRT'="" STRT=$$DATE^ORQ20(STRT) I ORNMSP="LR" S:STOP]"" STOP=$$DATE^ORQ20(STOP)
 S IG=0 F  S IG=$O(ORCY(IG)) Q:IG<1  S CNT=CNT+1,@ORY@(CNT)=$J(STS,4)_" "_ORCY(IG)_" "_STRT,(STS,STRT)=" "
 I ORNMSP="LR",STOP]"" S CNT=CNT+1,@ORY@(CNT)=$J("How often: ",16)_SCHED_"   Stops:  "_STOP
 Q
 ;
WP ; -- add word-processing
 N WP,ORI,X M WP=@ORDIALOG(PRMT,INST)
 S CNT=CNT+1,@ORY@(CNT)=TITLE
 S ORI=0 F  S ORI=$O(WP(ORI)) Q:ORI'>0  S X=WP(ORI,0) S:X'="" CNT=CNT+1,@ORY@(CNT)="  "_X
 Q
 ;
CHILDREN(PARENT) ; -- add children
 N SEQ,DA,ITM,PRMT,TYPE,X
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"DAD",PARENT,SEQ)) Q:SEQ'>0  S DA=$O(^(SEQ,0)) D
 . S ITM=$G(^ORD(101.41,+ORDIALOG,10,DA,0)),PRMT=$P(ITM,U,2)
 . Q:$G(ORDIALOG(PRMT,INST))=""  Q:$P(ITM,U,9)["*"  ;no value or hide
 . S TYPE=$E(ORDIALOG(PRMT,0)) D:TYPE="W" WP
 . I TYPE'="W" D
 . . S X=$$EXT^ORCD(PRMT,INST)
 . . I $L(X,"|")=2 S X=$$REPLACE^ORHLESC(X,"|","||")
 . . D ^DIWP
 Q
 ;
SETVIDEO(LINE,COL,WIDTH,ON,OFF) ; -- set video attributes
 S ORY("VIDEO",LINE,COL,WIDTH)=ON
 S ORY("VIDEO",LINE,COL+WIDTH,0)=OFF
 Q
 ;
VA ; -- Call VADPT
 N ORY,DFN,Y S DFN=+$P(OR0,"^",2) D OERR^VADPT
 Q
 ;
CDL(X) ; -- Returns Clinical Danger Level X
 N Y S Y=$S(X=1:"HIGH:",X=2:"MODERATE:",X=3:"LOW:",1:"NONE:")
 S Y=$E(Y_"        ",1,12)
 Q Y
 ;
ORIG(IFN) ; -- Return original start date of [renewal] order
 N I,Y,X3,DONE
 S I=IFN,Y=$P($G(^OR(100,IFN,0)),U,8),DONE=0
 F  S X3=$G(^OR(100,I,3)) D  Q:DONE
 . I $P(X3,U,11)=2,$P(X3,U,5) S I=$P(X3,U,5) Q  ;loop
 . S Y=$P($G(^OR(100,I,0)),U,8),DONE=1
 Q Y
