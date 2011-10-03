ORWCOM ;SLC/JM - Wraps RPCs for COM Objects Hooks ;8/02/2001
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109**;Dec 17, 1997
 Q
DETAILS(ORY,ID) ; Returns Details about a specific COM Object
 N NODE
 S ORY=0
 I +ID D
 .S NODE=$G(^ORD(101.15,+ID,0))
 .I NODE'="",$P(NODE,U,3)'="I" S ORY=ID_U_NODE
 Q
GETOBJ(ORY,PARAM,ORIDX) ; Returns COM Object info
 N SRV,ID
 S SRV=$$GET1^DIQ(200,DUZ,29,"I")
 S ID=$$GET^XPAR(DUZ_";VA(200,^SRV.`"_+$G(SRV)_"^DIV^SYS",PARAM,ORIDX,"I")
 D DETAILS(.ORY,ID)
 Q
PTOBJ(ORY) ; Returns Patient COM Object
 D GETOBJ(.ORY,"ORWCOM PATIENT SELECTED",1)
 Q
ORDEROBJ(ORY,ORGRP) ; Returns Accept Order COM Object
 D GETOBJ(.ORY,"ORWCOM ORDER ACCEPTED",ORGRP)
 Q
GETOBJS(ORY) ; Returns list of all active COM objects
 N I,J,IDX,NODE
 S I="",IDX=0
 F  S I=$O(^ORD(101.15,"B",I)) Q:I=""  D
 .S J=$O(^ORD(101.15,"B",I,0)) Q:'+J
 .S NODE=$G(^ORD(101.15,J,0))
 .I $P(NODE,U,3)'="I" D
 ..S IDX=IDX+1
 ..S ORY(IDX)=J_U_NODE
 Q
