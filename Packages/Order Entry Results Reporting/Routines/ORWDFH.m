ORWDFH ; SLC/KCM/JLI - Diet Order calls for Windows Dialogs ;12/12/00  14:44
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,92,141,187,215,243**;Dec 17, 1997;Build 242
TXT(LST,DFN)    ; Return text of current & future diets for a patient
 S LST(1)="Current Diet:  "_$$DIET^ORCDFH(DFN)
 N FUTLST D FUT(.FUTLST,DFN) I $D(FUTLST)>1 D
 . S LST(2)="Future Diet Orders:",ILST=2
 . S I=0 F  S I=$O(FUTLST(I)) Q:'I  D
 . . S X=$$FMTE^XLFDT(I,2)_"  "_$P(FUTLST(I),U,2)
 . . S LST(ILST)=$S(ILST=2:"Future Diet Orders:  "_X,1:"   "_X)
 . . S ILST=ILST+1
 Q
FUT(LST,DFN)    ; Return a list of future diet orders
 N DGRP,NXTDT,ORIFN,ORVP,ORTX
 S ORVP=DFN_";DPT(",DGRP=$O(^ORD(100.98,"B","DO",0)),NXTDT=$$NOW^XLFDT
 F  S NXTDT=$O(^OR(100,"AW",ORVP,DGRP,NXTDT)) Q:NXTDT'>0  D
 . S ORIFN=+$O(^OR(100,"AW",ORVP,DGRP,NXTDT,0))
 . I $P($G(^OR(100,ORIFN,3)),U,3)'=8 Q  ; only scheduled diets
 . D TEXT^ORQ12(.ORTX,ORIFN) S LST(NXTDT)=NXTDT_U_$G(ORTX(1))
 Q
PARAM(ORLST,ORVP,ORLOC)  ; Return dietetics parameters for a patient at a location
 ; ORLOC: hospital location ptr to ^SC #44
 ; ORLST(1)=EB1^EB2^EB3^LB1^LB2^LB3^EN1^EN2^...LE2^LE3
 ; ORLST(2)=BAB^BAE^NAB^NAE^EAB^EAE^BegB^BegN^BegE^Bagged
 ; ORLST(3)=type of service^RegIEN^NPOIEN^EarlyIEN^LateIEN^TFIFN
 ; ORLST(4)=max days in future for outpatient recurring meals
 ; ORLST(5)=default outpatient diet
 Q:'+ORVP
 N X,IEN,CURTM
 S ORVP=+ORVP_";DPT(",ORLOC=+ORLOC
 S CURTM=$$NOW^XLFDT
 I +$G(^SC(ORLOC,42)) S ORLOC=$G(^SC(ORLOC,42))_";DIC(42"
 E  S ORLOC=ORLOC_";SC("
 D EN1^FHWOR8(ORLOC,.ORLST)
 ;
 I '$L($G(ORLST(3))) S ORLST(3)="T"
 S $P(ORLST(3),U,2)=$O(^ORD(101.43,"S.DIET","REGULAR",0))
 S $P(ORLST(3),U,3)=$O(^ORD(101.43,"S.DIET","NPO",0))
 S $P(ORLST(3),U,4)=$O(^ORD(101.43,"S.E/L T","EARLY TRAY",0))
 S $P(ORLST(3),U,5)=$O(^ORD(101.43,"S.E/L T","LATE TRAY",0))
 N TF S TF=$$CURRENT^ORCDFH("TF") I $L(TF,";")=1 S TF=TF_";1"
 I TF,'$$FUTURE^ORCDFH("EFFECTIVE DATE/TIME") S $P(ORLST(3),U,6)=TF
 I $$VERSION^XPDUTL("FH")>5 D
 . S ORLST(4)=$$MAXDAYS^FHOMAPI(ORLOC)
 . D DIETLST^FHOMAPI Q:'$G(FHDIET(1))
 . S IEN=$O(^ORD(101.43,"ID",$P(FHDIET(1),U,1)_";99FHD",0)) Q:+IEN=0
 . S X=^ORD(101.43,"S.DIET",$P(FHDIET(1),U,2),IEN)
 . I +$P(X,U,3),$P(X,U,3)<CURTM Q
 . I $P($G(^ORD(101.43,IEN,"FH")),U)'="D",($P($G(^(0)),U)'="NPO") Q
 . S ORLST(5)=+$G(IEN)
 Q
ATTR(REC,OI)    ; Return OI^Text^Type^Precedence^AskExpire for a diet
 I $G(^ORD(101.43,OI,.1)),^(.1)'>$$NOW^XLFDT S REC="0^"_$P($G(^ORD(101.43,OI,0)),U)_" has been inactivated and may not be ordered anymore." Q
 S REC=OI_U_$P($G(^ORD(101.43,OI,0)),U)_U_$G(^("FH"))
 Q
DIETS(Y,FROM,DIR)       ; Return a subset of active diets, including NPO
 ; Y(n)=IEN^.01 Name^.01 Name  -or-  IEN^Synonym <.01 Name>^.01 Name
 N I,IEN,CNT,X,CURTM
 S I=0,CNT=44,CURTM=$$NOW^XLFDT
 F  Q:I'<CNT  S FROM=$O(^ORD(101.43,"S.DIET",FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(^ORD(101.43,"S.DIET",FROM,IEN)) Q:'IEN  D
 . . S X=^ORD(101.43,"S.DIET",FROM,IEN)
 . . I +$P(X,U,3),$P(X,U,3)<CURTM Q
 . . I $P($G(^ORD(101.43,IEN,"FH")),U)'="D",($P($G(^(0)),U)'="NPO") Q
 . . S I=I+1
 . . I 'X S Y(I)=IEN_U_$P(X,U,2)_U_$P(X,U,2)
 . . E  S Y(I)=IEN_U_$P(X,U,2)_$C(9)_"<"_$P(X,U,4)_">"_U_$P(X,U,4)
 Q
OPDIETS(ORY,FROM,DIR)   ;Return a list of up to 5 outpatient diets from file 119.9
 N X,I,J,IEN,CURTM,SYNCNT,SYNTOT,FHDIET
 D DIETLST^FHOMAPI
 S CURTM=$$NOW^XLFDT,I=0,SYNTOT=1
 F  S I=$O(FHDIET(I)) Q:'I  D
 . S IEN=$O(^ORD(101.43,"ID",$P(FHDIET(I),U,1)_";99FHD",0)) Q:+IEN=0
 . S X=^ORD(101.43,"S.DIET",$P(FHDIET(I),U,2),IEN)
 . I +$P(X,U,3),$P(X,U,3)<CURTM Q
 . I $P($G(^ORD(101.43,IEN,"FH")),U)'="D",($P($G(^(0)),U)'="NPO") Q
 . S X=$P(^ORD(101.43,IEN,0),U,1)
 . S SYNCNT=$P($G(^ORD(101.43,IEN,2,0)),U,4),J=0
 . S ORY(X)=IEN_U_X_U_X
 . I +SYNCNT  D  Q
 . . S SYNTOT=SYNTOT+SYNCNT
 . . F  S J=$O(^ORD(101.43,IEN,2,J)) Q:'J  D
 . . . S ORY(^ORD(101.43,IEN,2,J,0))=IEN_U_^ORD(101.43,IEN,2,J,0)_$C(9)_"<"_X_">"_U_X
 Q
TFPROD(Y)     ; Return a list of active tubefeeding products
 N I,IEN,NAM,X,CURTM
 S I=0,NAM="",CURTM=$$NOW^XLFDT
 F  S NAM=$O(^ORD(101.43,"S.TF",NAM)) Q:NAM=""  D
 . S IEN=0 F  S IEN=$O(^ORD(101.43,"S.TF",NAM,IEN)) Q:'IEN  D
 . . S X=^ORD(101.43,"S.TF",NAM,IEN)
 . . I +$P(X,U,3),$P(X,U,3)<CURTM Q
 . . S I=I+1
 . . I 'X S Y(I)=IEN_U_$P(X,U,2)_U_$P(X,U,2)
 . . E  S Y(I)=IEN_U_$P(X,U,2)_$C(9)_"<"_$P(X,U,4)_">"_U_$P(X,U,4)
 Q
QTY2CC(VAL,PRD,STR,QTY)     ; Return cc's given a product, strength, & quantity
 N X,VQTY,DUR
 S VQTY=$$VALIDQTY^ORCDFHTF(QTY) I '$L(VQTY)!('PRD)!('STR) S VAL="" Q
 S PRD=+$P($G(^ORD(101.43,PRD,0)),U,2)
 S DUR=$P(VQTY," X ",2) I $L(DUR) S DUR=$S(DUR["H":"H",1:"X")_+DUR
 S X=+VQTY_"&"_$E($P(VQTY," ",2))_U_$P($P(VQTY,"/",2)," ")_U_DUR
 S VAL=$$QUAN^FHWOR5R(PRD_"-"_STR,X)_U_VQTY
 Q
FINDTYP(VAL,DGRP)       ; Return type of dietetics order based on display group
 S VAL=$P($G(^ORD(100.98,DGRP,0)),U,3)
 S:VAL="D AO" VAL="A" S VAL=$E(VAL)
 Q
ISOIEN(VAL)     ; Return IEN for the Isolation/Precaution orderable item
 S VAL=$O(^ORD(101.43,"S.PREC","ISOLATION PROCEDURES",0))
 Q
CURISO(VAL,ORVP) ; Return a patient's current isolation
 S ORVP=ORVP_";DPT(" S VAL=$P($$IP^ORMBLD,U,2)
 I '$L(VAL) S VAL="<none>"
 Q
ISOLIST(LST)    ; Return list of active isolations/precautions
 N I,X,IEN
 S I=0,X="" F  S X=$O(^FH(119.4,"B",X)) Q:X=""  S IEN=$O(^(X,0)) D
 . I '$D(^FH(119.4,IEN,"I")) S I=I+1,LST(I)=IEN_U_X
 Q
MILTM(X)        ; return military time for am/pm time
 N TM
 S TM=$P(X,":",1)_+$P(X,":",2)
 I X["P",TM<1200 S TM=TM+1200
 I X["A",TM>1200 S TM=TM-1200
 Q TM
 ;
ASKLATE(REC,DFN,ORIFN)        ; Return info for ordering late tray for diet order
 ; REC=0  or  1^meal^bagged^time^time^time
 S REC=0 Q:'$G(ORIFN)  Q:$E($$VALUE^ORX8(ORIFN,"ORDERABLE",1,"E"),1,3)="NPO"
 N X,Y,%DT,STRT,DATE,ORPARAM,I,MEAL,MEALTIME
 S X=$O(^OR(100,ORIFN,4.5,"ID","START",0)),X=$G(^OR(100,ORIFN,4.5,+X,1))
 Q:X=""  S %DT="TX" D ^%DT Q:Y'>0  Q:$P(Y,".")>DT  ;invalid or future
 S DATE=$P(Y,"."),STRT=+$E($P(Y,".",2)_"0000",1,4),MEAL=0
 D EN^FHWOR8(DFN,.ORPARAM) Q:'$D(ORPARAM(2))
 F I=1,3,5 I $P(ORPARAM(2),U,I)<STRT,STRT<$P(ORPARAM(2),U,I+1) S MEAL=I Q
 S MEAL=$S(MEAL=1:4,MEAL=3:10,MEAL=5:16,1:0) Q:'MEAL
 S MEALTIME=$P(ORPARAM(1),U,MEAL,MEAL+2)
 S MEAL=$S(MEAL=4:"B",MEAL=10:"N",MEAL=16:"E",1:"")
 F I=1:1:3 S X=$$MILTM($P(MEAL,U,I)) I X<STRT S $P(MEAL,U,I)=""
 S REC="1"_U_MEAL_U_$P(ORPARAM(2),U,10)_U_MEALTIME
 I $P(REC,U,2,4)="^^" S REC=0
 Q
ADDLATE(REC,ORVP,ORNP,ORL,MEAL,TIME,BAG)      ; Add late tray order
 N ORIFN,ORNEW,ORDUZ,ORSTS,OREVENT,ORCAT,ORDA,ORTS,ORCHECK,ORLOG
 N ORDIALOG,ORDG,ORTYPE,DA,FIRST,TRAY
 S ORVP=ORVP_";DPT(",ORL(2)=ORL_";SC(",ORL=ORL(2)
 S ORTYPE="D",FIRST=1,ORDUZ=DUZ,ORLOG=+$E($$NOW^XLFDT,1,12)
 S TRAY=+$O(^ORD(101.43,"S.E/L T","LATE TRAY",0))
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW2",0))
 D GETDLG^ORCD(ORDIALOG)
 S ORDIALOG($$PTR^ORCD("OR GTX MEAL"),1)=MEAL
 S ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1)=TRAY
 S ORDIALOG($$PTR^ORCD("OR GTX START DATE"),1)=DT
 S ORDIALOG($$PTR^ORCD("OR GTX STOP DATE"),1)=DT
 S ORDIALOG($$PTR^ORCD("OR GTX MEAL TIME"),1)=TIME
 S ORDIALOG($$PTR^ORCD("OR GTX YES/NO"),1)=BAG
 D EN^ORCSAVE
 S REC="" I ORIFN D GETBYIFN^ORWORR(.REC,ORIFN)
 Q
CURMEALS(ORY,ORDFN,ORMEAL)     ;Return current list of recurring meals for AO and TF orders
 N I,Y,X S I=0
 S ORMEAL=$G(ORMEAL,"")
 D EN2^FHWOR8(ORDFN,ORMEAL,.ORY)
 F  S I=$O(ORY(I)) Q:'I  D
 . S X=$P(ORY(I),U,2)
 . S Y=$P(ORY(I),U,1) D DD^%DT S $P(ORY(I),U,2)=Y
 . S $P(ORY(I),U,3)=$S(X="B":"Breakfast",X="N":"Noon",X="E":"Evening",1:"")
 Q
NFSLOC(ORLOC) ;Get NUTRITION LOCATION name for HOSPITAL LOCATION
 Q $$NFSLOC^FHOMAPI(ORLOC)
OPLOCOK(ORY,ORLOC) ; OK to order OP Meals from this location
 I 'ORLOC S ORY=0 Q
 S ORY=$S($L($$NFSLOC^FHOMAPI(ORLOC))>0:1,1:0)
 Q
