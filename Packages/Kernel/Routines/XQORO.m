XQORO ; SLC/KCM - Order Entry Calls ;08/24/98  12:36
 ;;8.0;KERNEL;**48,56,94**;Jul 10, 1995
ENTRY ;Setup initial 'add orders' context
 Q:$D(ORNOAD)  ;Flag for MAS protocols  Phase out by 11/90
 I $S($D(^DD(100,0,"VR")):^("VR")<1.89,1:1) D WARN Q
 I $D(^ORD(100.99,1,0)),$P(^(0),"^",16) S DIROUT="^^" W !!,$C(7),"OE/RR Software is currently being updated. Access temporarily denied.",! Q
 ; I $D(XRTL) D T0^%ZOSV ; Start RT Log
 S XQORQUIT=1 Q:'$D(ORACTION)  Q:ORACTION  S (ORGY,ORACTION,OREND)=0
 D ADD^OR1 I OREND!$D(ORPTLK) D:OREND PT1^ORX2 S OREND=0 Q
 S ^TMP("XQORS",$J,0,"CTXT","ADD")=XQORS,^TMP("XQORS",$J,XQORS,"CTX","AD")=""
 K XQORQUIT Q
EVERY ;Setup for every new node in 'add orders' context
 I $D(^TMP("ORPAT",$J)),^($J)'=ORVP S XQORPOP=1 W !!,"Unable to process orders for "_$P(^DPT(+ORVP,0),"^")_" until",!,"the ordering session for "_$P(^DPT(+^TMP("ORPAT",$J),0),"^"),!,"has been completed." D READ^ORUTL Q
 Q:$D(ORNOAD)  ;Flag for MAS protocols  Phase out by 11/90
 I $S($D(^DD(100,0,"VR")):^("VR")<1.89,1:1) D WARN Q
 I $D(^ORD(100.99,1,0)),$P(^(0),"^",16) S DIROUT="^^" W !!,$C(7),"OE/RR Software is currently being updated. Access temporarily denied.",! Q
 K ORIFN,ORCOST,ORIT,ORSTRT,ORSTOP,ORTO,ORPURG,ORTX,ORSTS,ORPK,ORLOG,ORPCL,OR,ORZ,ORNS
 D RSTR I $P(^TMP("XQORS",$J,XQORS,"FLG"),"^")="Q",($G(^ORD(101,+XQORNOD,26))'["^OR") S XQORM("H")="S ORUIEN=XQORNOD D OE^ORUHDR K ORUIEN" D:$L($T(^ORGKEY)) SET^ORGKEY
 ;I "OL"[$P(^TMP("XQORS",$J,XQORS,"FLG"),"^") S X="(for "_ORPNM_")" W !?(40-($L(X)\2)),X
 I $P(^TMP("XQORS",$J,XQORS,"FLG"),"^",3),"OL"[$P(^TMP("XQORS",$J,XQORS,"FLG"),"^"),$P(^ORD(100.99,1,0),"^",11) W !!,"<Orders for ",ORPNM,">"
 S:$D(@(^TMP("XQORS",$J,XQORS,"REF")_"0)")) ORNS=$P(^(0),"^",12),ORTX=$P(^(0),"^",2)
 I $S(ORNS:$S($D(^ORD(100.99,1,20,ORNS,0)):$S($P(^(0),"^",2):0,1:1),$D(^ORD(100.99,1,5,ORNS,0)):$S($P(^(0),"^",3):0,1:1),1:1),1:1) W $C(7),!,"This item is not setup to order from OE/RR",!,"(Package not setup)" S XQORQUIT=1 D READ^ORUTL Q
 I ORNS,'$D(ORUP(ORNS)) S ORUP(ORNS)="" I $D(^ORD(100.99,1,5,ORNS,3)),$L(^(3)) X ^(3)
 S OREND=0 K ORNS
 Q
EXIT ;When done adding, accept orders and transact them
 N XRTN
 I $S($D(^DD(100,0,"VR")):^("VR")<1.89,1:1) D WARN Q
 D RSTR,AFT^OR1,RSTR K ^TMP("XQORS",$J,0,"CTXT","ADD"),^TMP("XQORS",$J,XQORS,"CTX","AD"),^TMP("ORPAT",$J) S (ORGY,ORACTION)=""
 D PT1^ORX2
 ; I $D(XRT0) S XRTN="ADD ORDERS" D T1^%ZOSV ; Stop RT Log
 Q
RSTR S ORVP=$P(OROLD,"^"),ORPV=$P(OROLD,"^",2),ORL=$P(OROLD,"^",3),ORTS=$P(OROLD,"^",4),ORL(0)=$P(OROLD,"^",5),ORL(1)=$P(OROLD,"^",6),ORDUZ=$P(OROLD,"^",7),ORNP=$P(OROLD,"^",8),ORL(2)=$P(OROLD,"^",9),OROLOC=$P(OROLD,"^",10)
 S OROLOC=$S($L($P(OROLD,"^",10)):$P(OROLD,"^",10),1:ORL),DFN=$P(OROLD,"^",11) S:$D(^TMP("XQORS",$J,0,"CTXT","ADD")) (ORGY,ORACTION)=0
 Q
WARN W !,$C(7),"OE/RR is not installed.  Options of this type should not be used.",$C(7),!
 Q
