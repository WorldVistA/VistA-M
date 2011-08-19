ORCDFH ;SLC/MKB-Utility functions for FH dialogs ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,73,92,141,215**;Dec 17, 1997
 ;
EN ; -- entry action
 S ORCAT=$S($G(ORTYPE)="Z":"",$$INPT^ORCD:"I",1:"O")
 I ORCAT="O" D  Q:$G(ORQUIT)
 . I $P($G(^ORD(100.98,+$G(ORDG),0)),U,3)="DO" W $C(7),!!,"This patient is not an inpatient!" H 2 S ORQUIT=1 Q
 . I '$L($T(EN2^FHWOR8)) W $C(7),!!,"Dietetics v5.5 must be installed to place outpatient diet orders!" H 2 S ORQUIT=1 Q
 . D EN2^FHWOR8(+$G(ORVP),"",.ORDT) I '$O(ORDT(0)) W $C(7),!!,"There are no existing recurring meals with which to associate this type of",!,"order!" H 2 S ORQUIT=1 Q
 N X S X=$S($G(OREVENT):$$LOC^OREVNTX(OREVENT),1:$G(ORL))  Q:X<1
 D EN1^FHWOR8(X,.ORPARAM)
 S:'$L($G(ORPARAM(3))) ORPARAM(3)="TCD" ;for QO editor
 Q
 ;
CKFUTURE ; -- Ck for future diet orders
 N DG,ORDT,ORSTRT,ORIFN,ORTX
 S DG=$O(^ORD(100.98,"B","DO",0)),ORDT=$$NOW^XLFDT
 F  S ORDT=$O(^OR(100,"AW",ORVP,DG,ORDT)) Q:ORDT'>0  S ORIFN=0 D
 . F  S ORIFN=$O(^OR(100,"AW",ORVP,DG,ORDT,ORIFN)) Q:ORIFN'>0  I $P($G(^OR(100,+ORIFN,3)),U,3)=8 S ORSTRT(ORDT)=ORIFN ;incl only if still sched
 Q:'$D(ORSTRT)  W !,"Future Diet Orders: ",! S ORDT=0
 F  S ORDT=$O(ORSTRT(ORDT)) Q:ORDT'>0  D TEXT^ORQ12(.ORTX,+ORSTRT(ORDT)) W !,$$FMTE^XLFDT(ORDT,2)_"    "_$G(ORTX(1))
 W !!,"A new order with no expiration date will CANCEL these diets."
 Q:$$CONT  S ORQUIT=1
 W !!,"Diet Order for this Patient is UNCHANGED -- No order entered!" H 2
 Q
 ;
CONT() ; -- Ok to continue?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="Do you wish to CONTINUE? ",DIR("B")="NO"
 D ^DIR
 Q +Y
 ;
EN2 ; -- Reformat ORPARAM() into ORTIME(<tray>,<meal>,1-3)=ext^ext
 N X,M,T,I,CNT,OFFSET,TIMES,EARLY,LATE
 S TIMES=$G(ORPARAM(1)),OFFSET=0 Q:TIMES=""
 F I="EARLY","LATE" S @I=+$O(^ORD(101.43,"S.E/L T",I_" TRAY",0))
 F M="B","N","E" F T=EARLY,LATE S CNT=0 D
 . F I=1:1:3 S X=$P(TIMES,U,I+OFFSET) S:X CNT=CNT+1,ORTIME(T,M,I)=X_U_X,ORTIME(T,M,"B",X)=X,ORTIME(T,M,"C",X)=I
 . S OFFSET=OFFSET+3 S:CNT ORTIME(T,M)=CNT_"^1"
 Q
 ;
FMTIME(X) ; -- Returns FM format of time
 N Y,%DT S %DT="TX" D ^%DT
 Q "."_$P(Y,".",2)
 ;
EX ; -- exit action
 K ORPARAM,ORTIME,ORNPO,ORTRAIL,ORCAT,ORDT
 Q
 ;
DIET(DFN) ; -- Returns patient DFN's current diet order
 N ADM,X1,FHORD,FHLD,FHOR,X,Y,FHDU,%,A1,D3
 S ADM=+$G(^DPT(DFN,.105)),Y="" I $G(DFN),ADM D CUR^FHORD7
 Q Y
 ;
VALID() ; -- Returns 1 or 0, if selected diet modification is valid
 N Y,NUM,I,TOTAL,OI
 S Y=1,TOTAL=+$G(ORDIALOG(PROMPT,"TOT"))
 S OI=$P($G(^ORD(101.43,+ORDIALOG(PROMPT,ORI),0)),U)
 I (OI="REGULAR")!(OI="NPO") D  Q Y
 . I '$D(ORESET),TOTAL=0 S ORDIALOG(PROMPT,"MAX")=1,MAX=1 Q  ; add first
 . I $G(ORESET),TOTAL'>1 S ORDIALOG(PROMPT,"MAX")=1,MAX=1 Q  ; edit first
 . S Y=0 W $C(7),!,OI_" may not be ordered with other diets!"
 S ORDIALOG(PROMPT,"MAX")=5,MAX=5
 I $$DUP^ORCD(PROMPT,ORI) W $C(7),"This diet has already been selected!" Q 0
 S NUM=$P($G(^ORD(101.43,+ORDIALOG(PROMPT,ORI),"FH")),U,2) ; precedence #
 S I=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  D  Q:Y'>0
 . Q:I=ORI  Q:$P($G(^ORD(101.43,+ORDIALOG(PROMPT,I),"FH")),U,2)'=NUM  ;ok
 . S Y=0 W $C(7),!,"This diet is not orderable with those already selected!",!
 Q Y
 ;
CURRENT(DG) ; -- Returns order number of currently active DG order
 N TYPE,START,ORIFN
 S TYPE=$O(^ORD(100.98,"B",DG,0)),START=$$NOW^XLFDT
 F  S START=$O(^OR(100,"AW",ORVP,TYPE,START),-1) Q:START'>0  S ORIFN=$O(^(START,0)) Q:$P($G(^OR(100,ORIFN,3)),U,3)=6  K ORIFN
 Q $G(ORIFN)
 ;
FUTURE(FLD) ; -- Returns 1 or 0, if date from FLD is future
 N X,Y,Z,%DT
 S X=$$VAL^ORCD(FLD),%DT="TX" D ^%DT S Z=$S($P(Y,".")>DT:1,1:0)
 Q Z
 ;
SCHEDOK(X) ; -- Validates days of the week
 N Y,I S X=$$UP^XLFSTR(X),Y=1
 F I=1:1:$L(X) I "^M^T^W^R^F^S^X^"'[(U_$E(X,I)_U) S Y=0 Q
 Q Y
 ;
MEALS ; -- Sets meal times into ORDIALOG(PROMPT,"LIST")
 K ORDIALOG(PROMPT,"LIST") Q:'$L($G(ORMEAL))  Q:'$G(ORTRAY)
 M ORDIALOG(PROMPT,"LIST")=ORTIME(ORTRAY,ORMEAL)
 Q
 ;
NOTIMES(MEAL,TIME) ; -- If no tray times defined, write msg and reask
 N I,Y,PAST S Y=0 G:'$L($G(MEAL)) NTQ G:'$G(TIME) NTQ
 I '$D(ORTIME(TIME,MEAL)) K DONE W $C(7),!,"There are no "_$P($G(^ORD(101.43,TIME,0)),U)_" times defined for the "_$S(MEAL="B":"breakfast ",MEAL="N":"noon ",MEAL="E":"evening ",1:"")_"meal at this location!",! S Y=1 G NTQ
 G:$G(ORDATE)'=DT NTQ S PAST=1,NOW="."_$P($$NOW^XLFDT,".",2)
 F I=1:1:3 S X=$G(ORTIME(TIME,MEAL,I)) I X,$$FMTIME($P(X,U))>NOW S PAST=0 Q
 I PAST K DONE W $C(7),!,"All "_$P($G(^ORD(101.43,TIME,0)),U)_" times have passed for the "_$S(MEAL="B":"breakfast ",MEAL="N":"noon ",MEAL="E":"evening ",1:"")_"meal at this location!",! S Y=1
NTQ Q Y
 ;
CKTIME ; -- Validate meal time
 Q:$G(ORDATE)'=DT  N NOW,X S NOW="."_$P($$NOW^XLFDT,".",2)
 S X=ORDIALOG(PROMPT,ORI),X=$$FMTIME(X)
 I X'>NOW W $C(7),!,"This time has already passed!",! K DONE Q
 Q
 ;
DELIVERY ; -- Set available delivery/service types by location
 I $G(ORNPO) K ORDIALOG(PROMPT,INST) Q
 Q:$D(ORDIALOG(PROMPT,"LIST"))
 N X,Y,Z,I S X=$G(ORPARAM(3))
 S Z="" F I=1:1:$L(X) S Y=$E(X,I) S Z=Z_Y_":"_$S(Y="T":"TRAY",Y="C":"CAFETERIA",Y="D":"DINING ROOM",Y="B":"BAGGED",1:"")_";"
 S:$L(Z) $P(ORDIALOG(PROMPT,0),U,2)=Z
 S ORDIALOG(PROMPT,"LIST")=$L(X)
 Q
 ;
CANCEL(ORIFN) ; -- Return 1 or 0, if future trays should be cancelled
 N DA,Y S DA=$O(^OR(100,+ORIFN,4.5,"ID","CANCEL",0)),Y=0
 S:DA Y=+$G(^OR(100,+ORIFN,4.5,+DA,1))
 Q Y
 ;
RESUME(ORDER) ; -- Returns 1 or 0, if tray service should be resumed
 N I,X S I=$O(^OR(100,+ORDER,4.5,"ID","RESUME",0)),X=0
 I I S X=+$G(^OR(100,+ORDER,4.5,+I,1))
 Q X
 ;
LATETRAY ; -- Order a late tray with diet ORIFN? [from VALID^ORCSIGN]
 Q:'$G(ORIFN)  Q:$E($$VALUE^ORX8(ORIFN,"ORDERABLE",1,"E"),1,3)="NPO"
 N X,Y,%DT,ORSTRT,ORDATE,ORNP
 S X=$O(^OR(100,ORIFN,4.5,"ID","START",0)),X=$G(^OR(100,ORIFN,4.5,+X,1))
 Q:X=""  S %DT="TX" D ^%DT Q:Y'>0  Q:$P(Y,".")>DT  ;invalid or future
 S ORDATE=$P(Y,"."),ORSTRT=+$E($P(Y,".",2)_"0000",1,4)
 S ORNP=$P(^OR(100,ORIFN,0),U,4)
LTRAY ; -- enter here w/ORDATE,ORSTRT,ORNP [reinstated diet after dc'ing NPO]
 N ORPARAM,ORTIME,I,ORMEAL,ORTRAY
 D EN^FHWOR8(+ORVP,.ORPARAM),EN2 Q:'$D(ORPARAM(2))
 F I=1,3,5 I $P(ORPARAM(2),U,I)<ORSTRT,ORSTRT<$P(ORPARAM(2),U,I+1)  S ORMEAL=I Q
 Q:'$G(ORMEAL)  S ORMEAL=$S(ORMEAL=1:"B",ORMEAL=3:"N",ORMEAL=5:"E",1:U)
 Q:ORMEAL="^"  S ORTRAY=+$O(^ORD(101.43,"S.E/L T","LATE TRAY",0))
 F I=1:1:3 S Z=$G(ORTIME(ORTRAY,ORMEAL,I)) I Z S Z=$$FMTIME($P(Z,U)),Z=+$E($P(Z,".",2)_"0000",1,4) I Z>ORSTRT S OK=1 Q
 Q:'$G(OK)  Q:'$$ORDTRAY(ORMEAL)  ;Else, continue w/order for late tray
LT1 N ORIFN,ORDIALOG,ORDG,ORTYPE,ORCHECK,ORQUIT,ORDUZ,ORLOG,SEQ,DA,FIRST
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW2",0)) Q:'ORDIALOG
 S ORTYPE="D",FIRST=1,ORDUZ=DUZ,ORLOG=+$E($$NOW^XLFDT,1,12)
 D GETDLG^ORCD(ORDIALOG) S ORDIALOG($$PTR^ORCD("OR GTX MEAL"),1)=ORMEAL
 S ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1)=ORTRAY
 S ORDIALOG($$PTR^ORCD("OR GTX START DATE"),1)=ORDATE,ORDIALOG($$PTR^ORCD("OR GTX STOP DATE"),1)=ORDATE
 F SEQ=6,7 S DA=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ,0)) Q:'DA  D EN^ORCDLG1(DA) Q:$G(ORQUIT)  ; prompt for meal time, bagged meal
 I $G(ORQUIT) W $C(7),!!,"No late tray ordered!",! H 2 Q
 D EN^ORCSAVE Q:'$G(ORIFN)  S ORES(ORIFN_";1")=""
 W !?10,"... order placed.",!
 Q
 ;
ORDTRAY(M) ; -- Want to order tray for meal M?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A",1)="You have missed the "_$S(M="B":"breakfast",M="N":"noon",M="E":"evening",1:"")_" cut-off.",DIR("A")="Do you wish to order a late tray? ",DIR("B")="YES"
 D ^DIR
 Q +Y
 ;
ASKSTOP() ; -- Ck OI's for parameter
 N I,OI,Y S OI=+$$PTR^ORCD("OR GTX ORDERABLE ITEM"),Y=0
 S I=0 F  S I=$O(ORDIALOG(OI,I)) Q:I'>0  I $P($G(^ORD(101.43,+ORDIALOG(OI,I),"FH")),U,3)="Y" S Y=1 Q
 Q Y
