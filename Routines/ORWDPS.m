ORWDPS ; SLC/KCM - Pharmacy Calls for Windows Dialog [ 08/04/96  6:57 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
LOAD(LST,OI,PTYP) ;
 ; -- For a given orderable item, load appropriate lists & defaults
 N I,X,CNT,ORTMP,ILST S ILST=0
 S LST($$NXT)="~FORMULTN" D FRMLTN
 S LST($$NXT)="~INSTRUCT" D INSTRCT
 S LST($$NXT)="~ROUTE" D ROUTE
 S LST($$NXT)="~SCHEDULE" D SCHED
 S LST($$NXT)="~PRIORITY" D PRIOR
 S LST($$NXT)="~MESSAGE" D MESSAGE
 I PTYP="O" D
 . S LST($$NXT)="~PICKUP" D PICKUP
 . S LST($$NXT)="~SCSTATUS" D SCSTS
 . S LST($$NXT)="~REFILLS" D REFILLS
 Q
DISPDRUG(LST,OI) ; list dispense drugs for an orderable item
 N ILST,PTYP S ILST=0,PTYP="U" D FRMLTN
 Q
FRMLTN ; formulations
 D ENDD^PSJORUTL("^^^"_+$P($G(^ORD(101.43,OI,0)),"^",2),PTYP,.ORTMP)
 S I="" F  S I=$O(ORTMP(I)) Q:I=""  S LST($$NXT)="i"_ORTMP(I)
 Q
INSTRCT ; instructions
 D ^PSSJORDF(+$P(^ORD(101.43,OI,0),U,2))
 S I="" F  S I=$O(^TMP("PSJINS",$J,I)) Q:I=""  S X=^(I) D
 . I PTYP="U",$P(X,U,1)="TAKE" S $P(X,U,1)="GIVE"
 . S LST($$NXT)="i"_$P(X,U,2)_U_$P(X,U,1)_" "_$P(X,U,2)
 ; S I=$O(^TMP("PSJINS",$J,0))  (default instruction text)
 ; I I S X=$P($G(^TMP("PSJINS",$J,I)),U) S:$L(X) LST($$NXT)="d"_X_" "
 Q
ROUTE ; routes
 S I="",CNT=0
 F  S I=$O(^TMP("PSJMR",$J,I)) Q:I=""  D 
 . S LST($$NXT)="i"_I_U_^(I),CNT=CNT+1
 I CNT=1 S X=LST(ILST),LST($$NXT)="d"_$P(X,"^",3)
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J)
 Q
SCHED ; schedules
 S I="" F  S I=$O(^PS(51.1,"APPSJ",I)) Q:I=""  D
 . S LST($$NXT)="i"_$O(^(I,0))_U_I
 Q
PRIOR ; priorities
 F X="ROUTINE","ASAP","STAT","DONE" D
 . S LST($$NXT)="i"_$O(^ORD(101.42,"B",X,0))_U_X
 S LST($$NXT)="dROUTINE"
 Q
PICKUP ; routing
 F X="W^at Window","M^by Mail","C^in Clinic" S LST($$NXT)="i"_X
 S LST($$NXT)="dat Window"
 Q
SCSTS ; SC for drug
 F X="0^No","1^Yes" S LST($$NXT)="i"_X
 ; later: see if last order for this OI was SC and set default
 Q
REFILLS ; refills
 F X=0:1:11 S LST($$NXT)="i"_X_U_X
 S LST($$NXT)="d0"
 Q
MESSAGE ; message
 S I=0 F  S I=$O(^ORD(101.43,OI,8,I)) Q:I'>0  S LST($$NXT)="i"_^(I,0)
 Q
NXT() ; -- Function returns next available index in return data array
 S ILST=ILST+1
 Q ILST
DEF(LST,INOUT)     ; Load defaults for pharmacy dialogs (common lists)
 N TMPLST,IEN,I,X,ILST S ILST=0
 S LST($$NXT)="~Common" D COMMON
 Q
COMMON ; get list of common meds
 S X="ORWD COMMON MED "_$S($G(INOUT)="O":"OUTPT",1:"INPT")
 D GETLST^XPAR(.TMPLST,"ALL",X)
 S I=0 F  S I=$O(TMPLST(I)) Q:'I  D
 . S IEN=$P(TMPLST(I),U,2)
 . S LST($$NXT)="i"_IEN_U_$P(^ORD(101.43,IEN,0),U,1)
 Q
INPT(OK,DFN,PRV) ; For inpatient meds, check restrictions
 N NAME,AUTH,INACT,X S OK=0
 I '$D(^DPT(DFN,.1)) S OK="1^Patient is not an inpatient." Q
 S NAME=$P($G(^VA(200,PRV,20)),U,2) S:'$L(NAME) NAME=$P(^(0),U)
 S X=$G(^VA(200,PRV,"PS")),AUTH=$P(X,U),INACT=$P(X,U,4)
 I 'AUTH!(INACT&(DT>INACT)) D
 . S OK="1^"_NAME_" is not authorized to write medication orders."
 Q
OUTPT(OK,PRV) ; For outpatient meds, check restrictions
 N NAME,AUTH,INACT,X S OK=0
 S NAME=$P($G(^VA(200,PRV,20)),U,2) S:'$L(NAME) NAME=$P(^(0),U)
 S X=$G(^VA(200,PRV,"PS")),AUTH=$P(X,U),INACT=$P(X,U,4)
 I 'AUTH!(INACT&(DT>INACT)) D
 . S OK="1^"_NAME_" is not authorized to write medication orders."
 Q
