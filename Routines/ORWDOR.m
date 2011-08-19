ORWDOR ; SLC/KCM - Generic Orders calls for Windows Dialogs [ 08/05/96  8:21 AM ];03:50 PM  17 Jun 1998
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,164,253,243**;Dec 17, 1997;Build 242
NXT() ; -- returns next available index in return data array
 S ILST=ILST+1
 Q ILST
 ;
VMSLCT(LST) ; return default lists for vitals dialog
 N ILST S ILST=0
 S LST($$NXT)="~Measurements" D MEAS
 S LST($$NXT)="~Schedules"    D SCHED
 Q
MEAS ; called from VMSLCT
 N I,X
 S X="" F  S X=$O(^ORD(101.43,"S.V/M",X)) Q:X=""  D
 . S I=$O(^ORD(101.43,"S.V/M",X,0))
 . S LST($$NXT)="i"_I_U_$P(^ORD(101.43,"S.V/M",X,I),U,2)
 Q
SCHED ; called from VMSLCT
 N X,I
 K ^TMP($J,"ORWDGX APGMRV")
 D AP^PSS51P1("GMRV",,,,"ORWDGX APGMRV")
 S X="" F  S X=$O(^TMP($J,"ORWDGX APGMRV","APGMRV",X)) Q:X=""  D
 . S I=$O(^TMP($J,"ORWDGX APGMRV","APGMRV",X,0)),LST($$NXT)="i"_I_U_X
 K ^TMP($J,"ORWDGX APGMRV")
 Q
VALNUM(ERR,X,DOM) ; return error if invalid number
 N LOW,HIGH,DEC
 S LOW=$P(DOM,":"),HIGH=$P(DOM,":",2),DEC=$P(DOM,":",3),ERR=0
 I $L($P(X,"."))>24 S ERR="1^Exceeded maximum number of 24 characters" Q
 I X'?.1"-".N.1".".N S ERR="1^Entry must be numeric" Q
 I X>HIGH!(X<LOW) S ERR="1^Out of Range - value must be between "_LOW_" and "_HIGH_" inclusive" Q
 I $L($P(+X,".",2))>DEC D
 . I DEC=0 S ERR="1^No decimal places allowed"
 . E  I DEC=1 S ERR="1^Only one decimal place allowed"
 . E  S ERR="1^No more than "_DEC_" decimal places allowed"
 Q
LKSCRN(ORLST,FROM,DIR,REF,GBL,SCR) ; Return a set of entries from xref in REF
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 ; REF=subscript indirection global ref including xref,
 ; GBL=standard FM global ref, SCR=reference to screen in 101.41
 N I,IEN,CNT,X,Y,D,ORTYPE
 S I=0,CNT=44,SCR=$G(SCR)
 I $L(SCR) S SCR=$G(^ORD(101.41,+SCR,10,+$P(SCR,":",2),4))
 S D=$P(REF,"""",2),ORTYPE="D" ;for OI screen
 F  Q:I'<CNT  S FROM=$O(@REF@(FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(@REF@(FROM,IEN)) Q:'IEN  D
 . . ; if screen, set naked ref & Y, then execute screen
 . . I $L(SCR) S Y=IEN,X=$P($G(@(GBL_"Y,0)")),U) X SCR Q:'$T
 . . S I=I+1,ORLST(I)=IEN_"^"_FROM
 Q
MNUTREE(LST,ROOT) ; return menu tree for a menu type dialog
 N ILST S ILST=0
 S ILST=ILST+1,LST(ILST)=ROOT_U_$P(^ORD(101.41,ROOT,0),U,2)_"^0^+"
 D LSTCHLD(ROOT)
 Q
LSTCHLD(PARENT) ; list descendends of this node (recursive)
 N CHILD,I,J
 S I=0 F  S I=$O(^ORD(101.41,PARENT,10,"B",I)) Q:'I  D
 . S J=0 F  S J=$O(^ORD(101.41,PARENT,10,"B",I,J)) Q:'J  D
 . . S CHILD=+$P(^ORD(101.41,PARENT,10,J,0),U,2) Q:'CHILD
 . . ; also quit if child is not a generic order
 . . S ILST=ILST+1,LST(ILST)=CHILD_U_$P(^ORD(101.41,CHILD,0),U,2)_U_PARENT
 . . I $P(^ORD(101.41,CHILD,0),U,4)="M",$D(^ORD(101.41,CHILD,10))>1 D
 . . . S LST(ILST)=LST(ILST)_"^+"
 . . . D LSTCHLD(CHILD)
 Q
