GMTSXQ13 ; SLC/JER - XQORO for Export w/Health Summary ;1/10/92  15:12
 ;;2.5;Health Summary;;Dec 16, 1992
XQORO ; SLC/KCM - Order Entry Calls ;7/26/91  09:13 ;
 ;;6.52;Copyright 1990, DVA;
ENTRY ;Setup initial 'add orders' context
 Q:$D(ORNOAD)  ;Flag for MAS protocols  Phase out by 11/90
 I $S($D(^DD(100,0,"VR")):^("VR")<1.89,1:1) D WARN Q
 S XQORQUIT=1 Q:'$D(ORACTION)  Q:ORACTION  S (ORACTION,OREND)=0
 D ADD^OR1 I OREND!$D(ORPTLK) S OREND=0 Q
 S ^UTILITY("XQORS",$J,0,"CTXT","ADD")=XQORS,^UTILITY("XQORS",$J,XQORS,"CTX","AD")=""
 K XQORQUIT Q
EVERY ;Setup for every new node in 'add orders' context
 Q:$D(ORNOAD)  ;Flag for MAS protocols  Phase out by 11/90
 I $S($D(^DD(100,0,"VR")):^("VR")<1.89,1:1) D WARN Q
 K ORIFN,ORCOST,ORIT,ORSTRT,ORSTOP,ORTO,ORPURG,ORTX,ORSAMP,ORSPEC,ORSTS,ORPK,ORLOG,ORPCL,OR,ORZ,ORNS
 D RSTR I $P(^UTILITY("XQORS",$J,XQORS,"FLG"),"^")="Q" S XQORM("H")="S ORUIEN=XQORNOD D OE^ORUHDR K ORUIEN"
 ;I "OL"[$P(^UTILITY("XQORS",$J,XQORS,"FLG"),"^") S X="(for "_ORPNM_")" W !?(40-($L(X)\2)),X
 I $P(^UTILITY("XQORS",$J,XQORS,"FLG"),"^",3),"OL"[$P(^UTILITY("XQORS",$J,XQORS,"FLG"),"^"),$P(^ORD(100.99,1,0),"^",11) W !!,"<Orders for ",ORPNM,">"
 S:$D(@(^UTILITY("XQORS",$J,XQORS,"REF")_"0)")) ORNS=$P(^(0),"^",12),ORTX=$P(^(0),"^",2)
 I $S(ORNS:$S($D(^ORD(100.99,1,5,ORNS,0)):$S($P(^(0),"^",3):0,1:1),1:1),1:1) W *7,!,$P(XQORNOD(0),"^",3)_" not setup to order from OE/RR",!,"(Package not setup)" S XQORQUIT=1 D READ^ORUTL Q
 I ORNS,'$D(ORUP(ORNS)) S ORUP(ORNS)="" I $D(^ORD(100.99,1,5,ORNS,3)),$L(^(3)) X ^(3)
 S OREND=0
 Q
EXIT ;When done adding, accept orders and transact them
 I $S($D(^DD(100,0,"VR")):^("VR")<1.89,1:1) D WARN Q
 D RSTR,AFT^OR1,RSTR K ^UTILITY("XQORS",$J,0,"CTXT","ADD"),^UTILITY("XQORS",$J,XQORS,"CTX","AD") S ORACTION=""
 Q
RSTR S ORVP=$P(OROLD,"^"),ORPV=$P(OROLD,"^",2),ORL=$P(OROLD,"^",3),ORTS=$P(OROLD,"^",4),ORL(0)=$P(OROLD,"^",5),ORL(1)=$P(OROLD,"^",6),ORDUZ=$P(OROLD,"^",7),ORNP=$P(OROLD,"^",8),ORL(2)=$P(OROLD,"^",9)
 S:$D(^UTILITY("XQORS",$J,0,"CTXT","ADD")) ORACTION=0
 Q
WARN W !,*7,"OE/RR is not installed.  Options of this type should not be used.",*7,!
 Q
