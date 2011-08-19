LROR6 ;SLC/DCM - EDIT LAB ORDERS FOR OE/RR ;8/11/97
 ;;5.2;LAB SERVICE;**100,121,202**;Sep 27, 1994
DC(REQ,STAT) ;DC reason
 ;REQ=1 to require a response
 ;STAT=1 to set the variable LRMSTATI for sending status back to OE/RR.
 I $$VER^LR7OU1<3 Q  ;OE/RR 2.5 Check
 N DEF,R,PKG,X,OK
 S PKG=$O(^DIC(9.4,"B","LAB SERVICE",0))
 S DEF=$P($G(^LAB(69.9,1,"OR")),"^",2)
AGAIN S X=$$DC^ORX1(DEF,+$G(REQ),PKG,"Cancellation Reason"),LRNATURE=$S(X:"^^^"_$P(X,"^",1,2)_"^99ORR",1:-1)
 I $G(STAT)=1 S OK=1,LRMSTATI=$P(X,"^",9) I LRMSTATI,LRMSTATI'=1 D  G:'OK AGAIN
 . W !,"This Cancellation Reason will ONLY remove the accession.",!,"The Doctor's original order will NOT be canceled, so that it may be"
 . W !,"re-accessioned at a later time.  OK"
 . ;"To later cancel the order, use the option: ",!,"  Delete entire order or individual tests",!
 . S %=1 D YN^DICN I %'=1 S OK=0
 . I %=0 W !!,"You may enter a different Cancellation Reason, if you wish.",!
 Q
DC1(REASON,TEXT) ;Set HL7 String for DC Reason
 ;REASON=ptr to DC Reason (100.03)
 ;TEXT=free text reason to be associated with order (optional)
 I $$VER^LR7OU1<3 Q "" ;OE/RR 2.5 Check
 Q:'$G(REASON) ""
 N X S X=$G(^ORD(100.03,REASON,0)),X="^^^"_REASON_"^"_$S($L($G(TEXT)):TEXT,1:$P(X,"^"))_"^99ORR"
 Q X
NEW(REQ) ;Get Nature of order
 ;REQ=1 to require a response
 I $$VER^LR7OU1<3 Q  ;OE/RR 2.5 Check
 N DEF,X
 S DEF=$P($G(^LAB(69.9,1,"OR")),"^"),X=$$NA^ORX1(DEF,+$G(REQ),"B","Nature of Order/Change"),LRNATURE=$S(X:$P(X,"^",1,2)_"^99ORN",1:-1)
 Q
NEW1(NATURE) ;Set HL7 String for Nature of Order
 ;NATURE=ptr to Nature of Order (100.02)
 I $$VER^LR7OU1<3 Q "" ;OE/RR 2.5 Check
 Q:'$G(NATURE)
 N X S X=$G(^ORD(100.02,NATURE,0)),X="^^^"_NATURE_"^"_$P(X,"^")_"^99ORN"
 Q X
EN ;OE/RR 2.5 Nature of Order processes
 I ORSTS=""!(+ORSTS=11) D EDITUR^LROR6A Q
 I ORGY'=0 S OREND=0 D C^LROR3 Q
EDIT ;Edit orders for OE/RR 2.5
 S LRODT=$P(ORPK,"^"),LRSN=$P(ORPK,"^",2),I=$P(ORPK,"^",3)
 S X="" W !!,"Released laboratory orders are UNEDITABLE." Q:+ORSTS=6  W !,"You may use this action to ADD a test to the existing lab order number."
 N ORACTION,ORPARAM S ORNDO=1 D EN^LROR9
 K LRODT,LRSN,LRSX
 Q
OT ;OE/RR 2.5 Natuer of Order processing
 S DIR("?",1)="This order/change will be recorded in the  patient's electronic record."
 S DIR("?",2)="A notification will be sent to the requesting clinician to electronically"
 S DIR("?",3)="sign this action, and a copy of this action will be printed in the"
 S DIR("?",4)="ward/clinic to be placed in the chart, unless specified as a 'CORRECTION'"
 S DIR("?",5)="(not affecting the original order), or 'WRITTEN REQUEST' (Signed on chart)."
 S DIR("?",6)=""
 S DIR("?")="Enter reason: (C)ORRECTION, (W)RITTEN, (V)ERBAL, (P)HONED"
 S DIR("A")="NATURE OF ORDER/CHANGE: "
 S DIR("B")=$S($D(^XUSEC("LRLAB",DUZ)):"CORRECTION",1:"WRITTEN")
 S DIR(0)="SA^C:CORRECTION (internal to lab);W:WRITTEN REQUEST (Signed on chart);P:TELEPHONED REQUEST;V:VERBAL REQUEST"
 D ^DIR K DIR S ORNATR=$S($L(Y)&(Y="P"!(Y="V")):Y,1:"C") ;Correction=""
 I "VPWC"'[Y W !,"NATURE OF ORDER/CHANGE must be entered",$C(7),! G OT
 Q
