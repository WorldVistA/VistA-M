ORWOR ; SLC/KCM - Orders Calls ; 3/15/11 8:10am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,132,141,163,187,190,215,243,307,330,280,347**;Dec 17, 1997;Build 4
 ;
CURRENT(LST,DFN) ; Get Current Orders for a Patient
 ; Returns two lists in ^TMP("ORW",$J), fields and text
 N TM,IEN,X,X0,X3,CTR,IDX,I
 K ^TMP("ORW",$J)
 S IDX=0,DFN=DFN_";DPT("
 S TM=0 F  S TM=$O(^OR(100,"AC",DFN,TM)) Q:TM<1  D
 . S IEN=0 F  S IEN=$O(^OR(100,"AC",DFN,TM,IEN)) Q:IEN<1  D
 . . S X0=^OR(100,IEN,0),X3=^(3)
 . . S X=IEN_U_$P(X0,U,7)_U_$P(X0,U,11)_U_$P(X3,U,6)_U_$P(X3,U,3)
 . . S ^TMP("ORW",$J,IDX+1)=X
 . . S (CTR,I)=0,X=""
 . . F  S I=$O(^OR(100,IEN,1,I)) Q:I<1  D  Q:CTR>244
 . . . S X=X_$E(^OR(100,IEN,1,I,0),1,(245-CTR)),CTR=$L(X)
 . . S ^TMP("ORW",$J,IDX+2)=X,IDX=IDX+2
 ; S LST=$NA(^TMP("ORW",$J))
 M LST=^TMP("ORW",$J)
 Q
DETAIL(LST,ORID,DFN)    ; Return details of ORID (shell to kill VIDEO subs)
 Q:'+ORID
 I $G(DFN) N ORVP S ORVP=DFN_";DPT("
 S LST="^TMP(""ORTXT"",$J)"
 D DETAIL^ORQ2(.LST,ORID)
 K @LST@("VIDEO")
 S LST=$NA(^TMP("ORTXT",$J)),@LST=""
 Q
RESULT(REF,DFN,ORID,ID)      ; Return results of order identified by ID
 K ^TMP("ORXPND",$J)
 N ORESULTS,ORVP,LCNT S ORESULTS=1,LCNT=0,ORVP=DFN_";DPT("
 D ORDERS^ORCXPND1
 K ^TMP("ORXPND",$J,"VIDEO")
 S REF=$NA(^TMP("ORXPND",$J))
 Q
RESHIST(REF,DFN,ORID,ID)      ; Return result history of associated tests identified by ID
 K ^TMP("ORXPND",$J)
 N ORESULTS,ORVP,LCNT
 S ORESULTS=1,LCNT=0,ORVP=DFN_";DPT("
 D ORDHIST^ORWOR2
 K ^TMP("ORXPND",$J,"VIDEO")
 S REF=$NA(^TMP("ORXPND",$J))
 Q
TSALL(LST)      ; Return list of treating specialties
 N Y S Y=0
 F  S Y=$O(^DIC(45.7,Y)) Q:'Y  I $$ACTIVE^DGACT(45.7,Y) S LST(Y)=Y_U_$P(^DIC(45.7,Y,0),U)
 Q
DT(X) ; -- Returns FM date for X (SEE ORCHTAB1)
 N Y,%DT S %DT="T",Y="" D:X'="" ^%DT
 Q +Y
VWSET(ORERR,VIEW)       ; Set the preferred view for orders
 ; VIEW:  semi-colon delimited record
 ;        1 - Relative From Date/Time or ""
 ;        2 - Relative Thru Date/Time or ""
 ;        3 - Filter
 ;        4 - Display Group Pointer
 ;        5 - Format (preserve for list manager)
 ;        6 - chronological display (R or F)
 ;        7 - sort by display group
 N FMT
 ; use short name for display group instead of pointer
 ;*347 Allow times to be saved.
 ;I $E($P(VIEW,";",2))="T" S $P(VIEW,";",2)=$P($P(VIEW,";",2),"@") ;allows all orders for Today
 S $P(VIEW,";",4)=$P($G(^ORD(100.98,+$P(VIEW,";",4),0)),U,3)
 ; use last saved format, since this is used only by LM
 S FMT=$P($$GET^XPAR("ALL","ORCH CONTEXT ORDERS",1,"I"),";",5)
 S:'$L(FMT) FMT="L" S $P(VIEW,";",5)=FMT
 ; and save the parameter
 D EN^XPAR(DUZ_";VA(200,","ORCH CONTEXT ORDERS",1,VIEW,.ORERR)
 Q
VWGET(REC)      ; Get the preferred view for orders
 N FROM,THRU,FILTER,DGRP,FRMT,CHRN,BYGRP,S,VNAME,FL,I
 S REC=$$GET^XPAR("ALL","ORCH CONTEXT ORDERS",1,"I"),S=";"
 S FROM=$$DT($P(REC,S)),THRU=$$DT($P(REC,S,2)),FILTER=$P(REC,S,3)
 S DGRP=$P(REC,S,4),FRMT=$P(REC,S,5),CHRN=$P(REC,S,6),BYGRP=$P(REC,S,7)
 S:'$L(DGRP) DGRP="ALL" S DGRP=+$O(^ORD(100.98,"B",DGRP,0))
 I FILTER="" S FILTER=2  ; active orders
 I CHRN="" S CHRN="R"    ; reverse chronological
 I BYGRP="" S BYGRP=1    ; sort by display group
 ; set up view name
 D REVSTS^ORWORDG(.FL)
 S I=0 F  S I=$O(FL(I)) Q:'I  Q:+FL(I)=FILTER
 S VNAME=$P($G(FL(+I)),U,2)
 I '("^6^8^9^10^19^20^"[(U_FILTER_U)) S VNAME=VNAME_" Orders"
 I FILTER=2 S VNAME="Active Orders (includes Pending & Recent Activity)"
 I FILTER=23 S VNAME="Current Orders (Active & Pending Status Only)"
 S VNAME=VNAME_" - "_$P($G(^ORD(100.98,DGRP,0)),U)
 I (FROM>0)!(THRU>0) D
 . S VNAME=VNAME_" ("_$$FMTE^XLFDT(FROM,"2D")_" thru "
 . S VNAME=VNAME_$S(THRU>0:$$FMTE^XLFDT(THRU,"2D"),1:"")_")"
 S REC=FROM_S_THRU_S_FILTER_S_DGRP_S_FRMT_S_CHRN_S_BYGRP_S_VNAME
 Q
SHEETS(LST,ORVP) ; Return Order Sheets for a patient
 N ELST,ETYP,ORIFN,TS,I
 S ORVP=ORVP_";DPT("
 S ETYP="" F  S ETYP=$O(^OR(100,"AEVNT",ORVP,ETYP)) Q:ETYP=""  D
 . S ORIFN=0 F  S ORIFN=$O(^OR(100,"AEVNT",ORVP,ETYP,ORIFN)) Q:'ORIFN  D
 . . I (ETYP="A")!(ETYP="T") S ELST(ETYP,$P($G(^OR(100,+ORIFN,0)),U,13))=""
 S LST(1)="C;O^Current View",I=1
 S TS="" F  S TS=$O(ELST("A",TS)) Q:TS=""  D
 . S I=I+1,LST(I)="A;"_TS_U_"Admit to "_$P($G(^DIC(45.7,TS,0)),U)
 S I=I+1,LST(I)="A;-1^Admit..."
 S TS="" F  S TS=$O(ELST("T",TS)) Q:TS=""  D
 . S I=I+1,LST(I)="T;"_TS_U_"Transfer to "_$P($G(^DIC(45.7,TS,0)),U)
 I $L($G(^DPT(+ORVP,.1))) D
 . S I=I+1,LST(I)="T;-1^Transfer..."
 . S I=I+1,LST(I)="D;0^Discharge"
 Q
EVENTS(LST,EVT) ; Return general delayed events categories for a patient
 N EVTI
 S EVTI=0
 S EVTI=EVTI+1,LST(EVTI)="A;-1^Admit..."
 S EVTI=EVTI+1,LST(EVTI)="T;-1^Transfer..."
 S EVTI=EVTI+1,LST(EVTI)="D;0^Discharge"
 Q
UNSIGN(LST,ORVP,HAVE)   ; Return Unsigned Orders that are not on client
 N DC,DEL,DG,IFN,ACT,X0,X3,X8,ENT,LVL,TM,ILST,ORELSE
 S ILST=0
 Q:'$D(^XUSEC("ORES",DUZ))&('$D(^XUSEC("ORELSE",DUZ))&'$D(^ORAM(103,+ORVP)))
 S ORVP=ORVP_";DPT("
 S ENT="ALL"_$S($G(^VA(200,DUZ,5)):"^SRV.`"_+^(5),1:"")
 S LVL=$$GET^XPAR(ENT,"OR UNSIGNED ORDERS ON EXIT")
 ; Nurses only see their own unsigned orders, independent of OR UNSIGNED ORDERS ON EXIT
 S ORELSE=$D(^XUSEC("ORELSE",DUZ))
 I ORELSE S LVL=1
 Q:'LVL
 S TM=0 F  S TM=$O(^OR(100,"AS",ORVP,TM)) Q:TM<1  D
 . S IFN=0 F  S IFN=$O(^OR(100,"AS",ORVP,TM,IFN)) Q:IFN<1  D
 . . S ACT=0 F  S ACT=$O(^OR(100,"AS",ORVP,TM,IFN,ACT)) Q:ACT<1  D
 . . . Q:$D(HAVE(IFN_";"_ACT))  ;in Changes
 . . . S X0=$G(^OR(100,IFN,0)),X3=$G(^OR(100,IFN,3))
 . . . S X8=$G(^OR(100,IFN,8,ACT,0))
 . . . ;determine Display Group
 . . . S DG=$P($G(^ORD(100.98,$P(X0,U,11),0)),U,2)
 . . . ;determine if DC
 . . . S DC=$S($P(X8,U,2)="DC":1,1:0)
 . . . ;determine if Delay
 . . . S DEL=$$CHKORD^OREVNTX1(IFN)
 . . . I '$S(LVL=1&($P(X8,U,3)=DUZ):1,ORELSE&($P(X8,U,13)=DUZ):1,LVL=2:1,1:0) Q  ;chk user
 . . . ;if Nurse, and order is already released or held for signature, don't include in list
 . . . I ORELSE,$S((+$P(X8,U,16)>0):1,$D(^OR(100,IFN,5)):1,1:0) Q
 . . . S ILST=ILST+1,LST(ILST)=IFN_";"_ACT_U_$P(X8,U,3)_U_DG_U_DC_U_DEL
 Q
PKIUSE(RETURN) ; RPC determines user can use PKI Digital Signature
 S RETURN=0
 I $$GET^XPAR("ALL^USR.`"_DUZ,"ORWOR PKI USE",1,"Q") S RETURN=1
 Q
PKISITE(RETURN) ; RPC determines if PKI is turned on at the site
 S RETURN=0
 Q:'$L($T(STORESIG^XUSSPKI))  ;Check for Kernel piece
 Q:'$L($T(DOSE^PSSOPKI1))  ;Check for Pharmacy piece
 I $$GET^XPAR("ALL","ORWOR PKI SITE",1,"Q") S RETURN=1
 Q
ACTXT(ORY,ORIFN) ;Return detail action information
 N ORI,CNT,OR0,OR3,OR6,ACTION
 K ^TMP("ORACTXT",$J)
 S ORY="^TMP(""ORACTXT"",$J)",ORI=$P(ORIFN,";",2)
 S CNT=0,ORIFN=+ORIFN,OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),OR6=$G(^(6))
 F  S ORI=$O(^OR(100,+ORIFN,8,ORI)) Q:ORI'>0  S ACTION=$G(^(ORI,0)) D ACT^ORQ20
 S ORY=$NA(^TMP("ORACTXT",$J)),@ORY=""
 Q
EXPIRED(ORY) ;return FM date/time to begin search for expired orders
 N HRS
 S HRS=$$GET^XPAR("ALL","ORWOR EXPIRED ORDERS",1,"I")
 S ORY=$$FMADD^XLFDT($$NOW^XLFDT,"","-"_HRS,"","")
 Q
