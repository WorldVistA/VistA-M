ORCDFHO ;SLC/MKB-Utility functions for Outpt FH dialogs ;8/27/03  15:28
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17, 1997
 ;
EN ; -- entry action
 I $$INPT^ORCD W $C(7),!!,"This patient is not an outpatient!" S ORQUIT=1 H 2 Q
 I '$L($T(EN2^FHWOR8))!'$L($T(DIETLST^FHOMAPI)) W $C(7),!!,"Dietetics v5.5 must be installed to place outpatient diet orders!" S ORQUIT=1 H 2 Q
 N X S X=$S($G(OREVENT):$$LOC^OREVNTX(OREVENT),1:$G(ORL)) Q:X<1
 D EN1^FHWOR8(X,.ORPARAM) S ORCAT="O"
 I $G(ORPARAM(3))'["B" S ORPARAM(3)=$G(ORPARAM(3))_"B" ;bagged meal
 I $G(OREWRITE) D  ;remove addl diets
 . N I,P1,P2 S P1=$$PTR("ADDL DIETS"),P2=$$PTR("MEAL DATE")
 . S I=0 F  S I=$O(ORDIALOG(P1,I)) Q:I<1  K ORDIALOG(P1,I),ORDIALOG(P2,I)
 Q
 ;
EX ; -- exit action
 K ORPARAM,ORNPO,ORTRAIL,ORDAY,ORDT,ORCAT
 Q
 ;
PTR(X) ; -- Returns ptr value of prompt OR GTX X in Dialog file
 Q +$O(^ORD(101.41,"AB",$E("OR GTX "_X,1,63),0))
 ;
OPDIETS ; -- Get list of diets ok for outpatients
 Q:$G(ORDIALOG(PROMPT,"LIST"))  N FHDIET,I,X,Y,CNT
 D DIETLST^FHOMAPI S CNT=0
 S I=0 F  S I=$O(FHDIET(I)) Q:I<1  D
 . S Y=FHDIET(I),X=+Y,Y=$P(Y,U,2)
 . S X=+$O(^ORD(101.43,"ID",X_";99FHD",0))
 . I X S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=X_U_Y,ORDIALOG(PROMPT,"LIST","B",Y)=X
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT_"^1"
 Q
 ;
ONETIME() ; -- Condition for SCHEDULE
 N X,Y
 S Y=$$FTDCOMP^ORCD("END DATE","START DATE",">")
 S X=$G(ORDIALOG(PROMPT,INST))
 S:'Y ORDIALOG(PROMPT,INST)="ONCE" I Y,X="ONCE" K ORDIALOG(PROMPT,INST)
 Q 'Y
 ;
TIMES ; -- get existing outpatient meal times
 Q:$G(ORDIALOG(PROMPT,"LIST"))  D EN2^FHWOR8(+$G(ORVP),"",.ORDT)
 N I,CNT,X,Y,M S (I,CNT)=0 F  S I=$O(ORDT(I)) Q:I<1  D
 . S X=ORDT(I),Y=$$FMTE^XLFDT(+X),M=$P(X,U,2)
 . S Y=Y_"  "_$S(M="B":"Breakfast",M="N":"Noon",M="E":"Evening",1:"")
 . S X=$TR(X,"^",";"),CNT=CNT+1
 . S ORDIALOG(PROMPT,"LIST",I)=X_U_Y,ORDIALOG(PROMPT,"LIST","B",Y)=X
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT_"^1"
 Q
 ;
ENDT ; -- setup START
 ;S $P(ORDIALOG(PROMPT,0),":",3)="ETX" ;allow time
 D TIMES I FIRST,$G(ORDIALOG(PROMPT,"LIST")) D LIST^ORCD
 Q
 ;
EXDT(X) ; -- populate E/L T values from START
 Q:X'[";"  N DATE,MEAL
 S DATE=+X,MEAL=$P(X,";",2)
 S ORDIALOG(PROMPT,INST)=DATE,ORDIALOG($$PTR("STOP DATE"),1)=DATE
 S ORDIALOG($$PTR("MEAL"),1)=MEAL
 Q
 ;
MEALTIME(IFN) ; -- gets meal time for order IFN [from STARTDT^ORCSAVE2]
 N ORPARAM,ORLOC,X,Y S IFN=+$G(IFN)
 S ORLOC=$S($G(ORL):ORL,1:$P($G(^OR(100,IFN,0)),U,10))
 D EN1^FHWOR8(ORLOC,.ORPARAM) S X=$$VALUE^ORCSAVE2(IFN,"MEAL")
 S:'$D(ORPARAM(2)) ORPARAM(2)="^^^^^^6:00A^12:00P^6:00P"
 S Y=$S(X="B":$P(ORPARAM(2),U,7),X="N":$P(ORPARAM(2),U,8),X="E":$P(ORPARAM(2),U,9),1:"")
 Q Y
 ;
CKMEAL(Y,DAY,MEAL,LOC) ; -- Returns Y if valid mealtime or not
 ;   Y = 0^msg if invalid
 ;       1     if valid
 ;       2     if valid, but latetray will be needed
 ; RPC = ORCDFHO CKMEAL
 ;
 N TIMES,NOW,BEGIN,LATE S Y=1 Q:$G(ORTYPE)="Z"
 S DAY=$$FMDATE($G(DAY)) I DAY<0 S Y="0^Invalid date." Q
 Q:DAY>DT  I DAY<DT S Y="0^Cannot order for past days." Q
 I "^B^N^E^"'[(U_$G(MEAL)_U) S Y="0^Invalid meal." Q
 S TIMES=$G(ORPARAM(2)),NOW="."_$P($$NOW^XLFDT,".",2)
 I TIMES="" D  Q:Y<1  ;get meal times for location
 . I '$G(LOC) S Y="0^Missing or invalid location." Q
 . N ORPARAM D EN1^FHWOR8(LOC,.ORPARAM)
 . S TIMES=$G(ORPARAM(2))
 I TIMES="" S Y="0^No meal times defined for this location." Q
 S BEGIN=$P(TIMES,U,$S(MEAL="B":7,MEAL="N":8,1:9)) Q:NOW<$$FMTIME(BEGIN)
 S LATE="."_$P(TIMES,U,$S(MEAL="B":2,MEAL="N":4,1:6)) ;late alarm end
 I NOW>LATE S Y="0^This meal can no longer be ordered today." Q
 S LATE="."_$P(TIMES,U,$S(MEAL="B":1,MEAL="N":3,1:5)) ;late alarm start
 S:NOW>LATE Y=2 ;within alarm window for late tray, else ok
 Q
 ;
FMDATE(X) ; -- Ensure X is in FM date format, return day only
 N Y,%DT S %DT="TX" D ^%DT
 Q $P(Y,".")
 ;
FMTIME(X) ; -- Returns FM format of time
 N Y,%DT S %DT="TX" D ^%DT
 Q "."_$P(Y,".",2)
 ;
LATETRAY ; -- Check if latetray is needed, if so place order [from VALID^ORCSIGN]
 ;     Expects ORIFN, ORL, ORVP
 ;     Returns ORES(orifn;1)="" of new latetray order
 Q:'$G(ORIFN)  Q:$E($$VALUE^ORX8(ORIFN,"ORDERABLE",1,"E"),1,3)="NPO"
 N X,Y,%DT,ORDATE,ORNP
 S X=$O(^OR(100,ORIFN,4.5,"ID","START",0)),X=$G(^OR(100,ORIFN,4.5,+X,1))
 Q:X=""  S %DT="TX" D ^%DT Q:Y'>0  Q:$P(Y,".")>DT  ;invalid or future
 S ORDATE=$P(Y,"."),ORNP=$P(^OR(100,ORIFN,0),U,4)
LTRAY ; -- enter here w/ORDATE,ORNP,ORL [reinstated diet after dc'ing NPO]
 N ORPARAM,ORMEAL,ORTRAY,ORTIME,ORSTRT,Y,I
 D EN1^FHWOR8(ORL,.ORPARAM) Q:'$D(ORPARAM(2))
 S I=$O(^OR(100,ORIFN,4.5,"ID","MEAL",0)),ORMEAL=$G(^OR(100,ORIFN,4.5,+I,1))
 D CKMEAL(.Y,ORDATE,ORMEAL) Q:Y'=2  ;no late tray needed
 S ORTRAY=+$O(^ORD(101.43,"S.E/L T","LATE TRAY",0))
 S ORSTRT=+$E($P($$NOW^XLFDT,".",2)_"0000",1,4) D EN2^ORCDFH
 F I=1:1:3 S Z=$G(ORTIME(ORTRAY,ORMEAL,I)) I Z S Z=$$FMTIME($P(Z,U)),Z=+$E($P(Z,".",2)_"0000",1,4) I Z>ORSTRT S OK=1 Q
 Q:'$G(OK)  Q:'$$ORDTRAY^ORCDFH(ORMEAL)  ;Else, cont w/late tray order
LT1 N ORIFN,ORDIALOG,ORDG,ORTYPE,ORCHECK,ORQUIT,ORDUZ,ORLOG,ORCAT,SEQ,DA,FIRST
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW2",0)) Q:'ORDIALOG
 S ORTYPE="D",FIRST=1,ORDUZ=DUZ,ORLOG=+$E($$NOW^XLFDT,1,12),ORCAT="O"
 D GETDLG^ORCD(ORDIALOG) S ORDIALOG($$PTR^ORCD("OR GTX MEAL"),1)=ORMEAL
 S ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1)=ORTRAY
 S ORDIALOG($$PTR^ORCD("OR GTX START DATE"),1)=ORDATE,ORDIALOG($$PTR^ORCD("OR GTX STOP DATE"),1)=ORDATE
 F SEQ=6,7 S DA=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ,0)) Q:'DA  D EN^ORCDLG1(DA) Q:$G(ORQUIT)  ; prompt for meal time, bagged meal
 I $G(ORQUIT) W $C(7),!!,"No late tray ordered!",! H 2 Q
 D EN^ORCSAVE Q:'$G(ORIFN)  S ORES(ORIFN_";1")=""
 W !?10,"... order placed.",!
 Q
