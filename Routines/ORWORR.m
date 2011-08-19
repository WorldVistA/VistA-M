ORWORR ; SLC/KCM/JLI - Retrieve Orders for Broker ;8/24/09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,92,116,110,132,141,163,189,195,215,243,280**;Dec 17, 1997;Build 85
 ;
GET(LST,DFN,FILTER,GROUPS) ; procedure
 Q  ; don't call until using same treating specialty logic as AGET
 ;    & until MULT, ORWARD, & ORIGVIEW implemented
 ;    & until the date ranges implemented
 ; Get orders for patient
 ;        1   2    3     4      5     6   7   8   9   10     11    12    13    14     15     16 17    18
 ; .LST=~IFN^Grp^ActTm^StrtTm^StopTm^Sts^Sig^Nrs^Clk^PrvID^PrvNam^ActDA^Flag^DCType^ChrtRev^DEA#^^Schedule
 ; .LST=tOrder Text (repeating as necessary)
 ;     DFN=Patient ID
 ;  FILTER=# indicates which orders to return, default=2 (current)
 ;  GROUPS=display grp of orders to show (default=ALL)
 ; -- section uses ORQ1 to get orders list rather than XGET --
 N ORLIST,ORIFN,X0,X3,X8,IDX,IFN,ACT,PRV,LN,TXT,STRT,STOP,CSTS,EYE,DEA ;PKI
 K ^TMP("ORR",$J)
 S (IDX,LST)=0 S:'$D(GROUPS) GROUPS=1 S:'$D(FILTER) FILTER=2
 D EN^ORQ1(DFN_";DPT(",GROUPS,FILTER,"","","",0,1)
 S EYE=0 F  S EYE=$O(^TMP("ORR",$J,ORLIST,EYE)) Q:'EYE  S IFN=^(EYE) D
 . S ACT=$P(IFN,";",2),IFN=+IFN,X0=^OR(100,IFN,0),X3=^(3),X8=^(8,ACT,0)
 . D GETFLDS
 K ^TMP("ORR",$J)
 G EXIT
AGET(REF,DFN,FILTER,GROUPS,DTFROM,DTTHRU,EVENT,ORRECIP) ;Get abbrev. event delayed order list for patient 
 ; returns ^TMP("ORR",$J,ORLIST,n)=IFN^DGrp^ActTm
 ; see input parameters above
 ; -- from ORWORR
 ; -- section uses ORQ1 to get orders list rather than XGET --
 N ORLIST,ORIFN,IFN,I,ORWTS,TOT,MULT,ORWARD,TXTVW,ORYD,PTEVTID,EVTNAME
 S (PTEVTID,EVTNAME)=""
 K ^TMP("ORR",$J),^TMP("ORRJD",$J)
 S:'$D(GROUPS) GROUPS=1 S:'$D(FILTER) FILTER=2
 S ORWTS=+$P(FILTER,U,2),FILTER=+FILTER
 S MULT=$S("^1^6^8^9^10^11^13^14^20^22^"[(U_FILTER_U):1,1:0)
 I $L($G(^DPT(DFN,.1))) S ORWARD=1 ; normally ptr to 42
 S:'$L($G(DTFROM)) DTFROM=0
 S:'$L($G(DTTHRU)) DTTHRU=0
 I $P(DTFROM,".")=$P(DTTHRU,"."),$P(DTFROM,".",2)>$P(DTTHRU,".",2),$P(DTTHRU,".",2)="" S $P(DTTHRU,".",2)=2359
 S:'$L($G(EVENT)) EVENT=0
 I $G(EVTDCREL)="TRUE" D
 . D EN^ORQ1(DFN_";DPT(",GROUPS,FILTER,"",DTFROM,DTTHRU,2,MULT,"",1,EVENT)
 . D GET2^ORWORR1
 E  D
 . D EN^ORQ1(DFN_";DPT(",GROUPS,FILTER,"",DTFROM,DTTHRU,0,MULT,"",1,EVENT)
 . D GET1^ORWORR1
 Q
RGET(REF,DFN,FILTER,GROUPS,DTFROM,DTTHRU,EVENT) ;Orders of AutoDC/Release Event
 N EVTDCREL
 S EVTDCREL="TRUE"
 D AGET(.REF,DFN,FILTER,GROUPS,DTFROM,DTTHRU,EVENT)
 Q
XGET ; retrieval algorithm before all the AC xref changes
 N X,X0,X3,IDX,IFN,LN,TIME,DGRP,MASK,TXT,ACT,PRV,ID,DEA,PASS ;PKI
 S DFN=DFN_";DPT(",IDX=0,LST=0
 I '$G(FILTER) S FILTER=2                    ; Default: Current/Active
 I $D(GROUPS)=1 D
 . S:'GROUPS GROUPS=$O(^ORD(100.98,"B",GROUPS,0))
 . D XPND(GROUPS)
 I FILTER=1  D DOALL G EXIT                  ; All
 I FILTER=2  D DOCUR G EXIT                  ; Current
 I FILTER=3  S PASS=";1;"                    ; Discontinued
 I FILTER=4  S PASS=";2;7;"                  ; Comp/Expired
 I FILTER=5  S PASS=";3;4;5;6;8;9;"          ; Expiring
 I FILTER=6  S PASS=";1;2;3;4;5;6;7;8;9;11;" ; New Activity
 I FILTER=7  S PASS=";5;"                    ; Pending
 I FILTER=8  Q                               ; Expanded
 I FILTER=9  S PASS=";3;4;5;6;8;9;11;"       ; Unverified by Nurse
 I FILTER=10 S PASS=";3;4;5;6;8;9;11;"       ; Unverified by Clerk
 I FILTER=11 S PASS=";3;4;5;6;7;8;11;"       ; Unsigned
 I FILTER=12 S PASS=";4;"                    ; Flagged
 I FILTER=13 S PASS=""                       ; Verbal/Phone
 I FILTER=14 S PASS=""                       ; Verbal/Phone Unsigned
 D DOGET
EXIT I LST=0 D
 . N %,X,%I D NOW^%DTC
 . S LST(1)="~0^0^"_%_"^^^97",LST(2)="tNo Orders Found."
 Q
DOGET ; Here to filter orders 
 S TIME=0 F  S TIME=$O(^OR(100,"AO",DFN,TIME)) Q:'TIME  D
 . S DGRP=0 F  S DGRP=$O(^OR(100,"AO",DFN,TIME,DGRP)) Q:'DGRP  D
 . . I $D(GROUPS)>1 Q:'$D(GROUPS(DGRP))           ;filter by display grp
 . . S IFN=0 F  S IFN=$O(^OR(100,"AO",DFN,TIME,DGRP,IFN)) Q:'IFN  D
 . . . S X0=^OR(100,IFN,0),X3=^(3)                ;get main nodes
 . . . I $P(X3,U,8)!$P(X3,U,9)!($P(X3,U,3)=99) Q  ;skip veil,chld,sts=99
 . . . I $L(PASS),(PASS'[(";"_$P(X3,U,3)_";")) Q  ;filter by status
 . . . ; any other filtering
 . . . D GETFLDS
 Q
DOALL ; Here to get all orders (no filter by status)
 S TIME=0 F  S TIME=$O(^OR(100,"AO",DFN,TIME)) Q:'TIME  D
 . S DGRP=0 F  S DGRP=$O(^OR(100,"AO",DFN,TIME,DGRP)) Q:'DGRP  D
 . . I $D(GROUPS)>1 Q:'$D(GROUPS(DGRP))           ;filter by display grp
 . . S IFN=0 F  S IFN=$O(^OR(100,"AO",DFN,TIME,DGRP,IFN)) Q:'IFN  D
 . . . S X0=^OR(100,IFN,0),X3=^(3)                ;get main nodes
 . . . I $P(X3,U,8)!$P(X3,U,9)!($P(X3,U,3)=99) Q  ;skip veil,chld,sts=99
 . . . D GETFLDS
 Q
DOCUR ; Here to get all current orders
 N AOCTXT,STS,STOP,%
 S X=-$$GET^XPAR("ALL","ORPF ACTIVE ORDERS CONTEXT HRS")
 S %H=$H,X=(%H*86400+$P(%H,",",2))+(X*3600),%H=(X\86400)_","_(X#86400)
 D YMD^%DTC S AOCTXT=X_%
 S MASK="110000100101110"   ; mask out STS=1,2,7,10,12,13,14
 S TIME=0 F  S TIME=$O(^OR(100,"AC",DFN,TIME)) Q:'TIME  D
 . S IFN=0 F  S IFN=$O(^OR(100,"AC",DFN,TIME,IFN)) Q:'IFN  D
 . . ; filter out display groups here
 . . S ACT=0 F  S ACT=$O(^OR(100,"AC",DFN,TIME,IFN,ACT)) Q:'ACT  D
 . . . S X0=^OR(100,IFN,0),X3=^(3),X8=^(8,ACT,0)
 . . . S STS=$P(X3,U,3),STOP=$P(X0,U,9)
 . . . I $P(X3,U,8)!$P(X3,U,9)!(STS=99) Q
 . . . I $P(X8,U,15)=13,($P(X8,U)<AOCTXT) D ACKILL Q
 . . . I $P(X8,U,15)=13!($P(X8,U,15)=""),("RN^XX"[$P(X8,U,2)) D ACKILL Q
 . . . I $E(MASK,STS),STOP<AOCTXT D ACKILL Q
 . . . D GETFLDS
 Q
ACKILL ; called only from DOCUR - kill AC xref
 ; K ^OR(100,"AC",DFN,TIME,IFN,ACT)  ; let ORQ1 kill if for now
 Q
GET4V11(LST,TXTVW,ORYD,IFNLST) ; get order fields TEMP
 G GET41
GET4LST(LST,IFNLST) ; get order fields for list of orders
GET41 N ACT,ACTID,IDX,X0,X3,X8,PRV,ID,LN,TXT,STRT,STOP,CSTS,IFN,IFNIDX,ORIGVIEW,DEA ;PKI
 N LOC ;IMO
 S (IDX,LST,IFNIDX)=0
 F  S IFNIDX=$O(IFNLST(IFNIDX)) Q:'IFNIDX  S IFN=IFNLST(IFNIDX) D
 . S ACT=$S($P(IFN,";",2):$P(IFN,";",2),1:1),IFN=+IFN
 . S X0=$G(^OR(100,IFN,0)),X3=$G(^(3)),X8=$G(^(8,ACT,0))
 . D GETFLDS
 Q
GETBYIFN(LST,IFN) ; procedure
 ; get fields for single order
 ; .LST(n)=described above in GET
 ;  IFN=internal entry # for order
 I 'IFN Q
 N ACT,IDX,X0,X3,X8,PRV,ID,LN,TXT,STRT,STOP,CSTS,ACTID,ORIGVIEW,ORYD,TXTVW,DEA ;PKI
 S IDX=0,LST=0,ORYD=0
 S X0=$G(^OR(100,+IFN,0)),X3=$G(^(3))
 S ACT=$S($P(IFN,";",2):$P(IFN,";",2),$P(X3,U,7):$P(X3,U,7),1:1)
 S IFN=+IFN,X8=$G(^OR(100,IFN,8,ACT,0))
GETFLDS ; used by entry points to place order fields into list
 ; expects IDX=sequence #, IFN=order, X0=node 0, X3=node 3, LST=results
 ; LST(IDX)=~IFN^Grp^OrdTm^StrtTm^StopTm^Sts^Sig^Nrs^Clk^PrvID^PrvNam^Act^Flagged[^DCType]^ChartRev^DEA#^^DigSig^LOC^[DCORIGNAL]^IsPendingDCorder^IsDelayOrder
 S PRV=$P(X8,U,5) S:'PRV PRV=$P(X8,U,3) S PRV=PRV_U
 I PRV S PRV=PRV_$P(^VA(200,+PRV,0),U)
 S DEA=$$DEA^XUSER(,+PRV) ; get user DEA info - PKI
 S IDX=IDX+1,LST=LST+1,ID=IFN_";"_ACT,ACTID=$P(X8,U,2)
 S CSTS=$S($P(X8,U,15):$P(X8,U,15),1:$P(X3,U,3))
 I $P(X8,U,15)=10,$P(X3,U,3)=14 S CSTS=14 ;delayed-lapsed order
 S STRT=$S($P(X3,U,3)=11:$$RSTRT,ACTID="NW"!(ACTID="XX")!(ACTID="RL"):$P(X0,U,8),ACTID="DC":"",1:$P(X8,U)) ;110
 S STOP=$S($P(X3,U,3)=11:$$RSTOP,ACTID="HD":$P($G(^OR(100,+IFN,8,ACT,2)),U),1:$P(X0,U,9))
 S LST(IDX)="~"_ID_U_$P(X0,U,11)_U_$P(X8,U)_U_STRT_U_STOP_U_CSTS_U_$P(X8,U,4)_U_$P(X8,U,8)_U_$P(X8,U,10)_U_PRV
 S $P(LST(IDX),U,13)=+$G(^OR(100,IFN,8,ACT,3))    ; flagged
 I +$P(X8,U,8) S $P(LST(IDX),U,8)=$$INITIALS^ORCHTAB2(+$P(X8,U,8))    ;nurse
 I +$P(X8,U,10) S $P(LST(IDX),U,9)=$$INITIALS^ORCHTAB2(+$P(X8,U,10))  ;clerk
 I +$P(X8,U,18) S $P(LST(IDX),U,15)=$$INITIALS^ORCHTAB2(+$P(X8,U,18)) ;chart review
 I $L($G(DEA)) S $P(LST(IDX),U,16)=DEA ;PKI
 I $P($G(^OR(100,IFN,8,ACT,2)),"^",5) S $P(LST(IDX),U,18)=$P(^(2),"^",4)
 I '$P($G(^OR(100,IFN,8,ACT,2)),"^",5),$P(X0,"^",5) D  ;Copy orders PKI fix
 . N OI,ORVP,ORCAT,PKG
 . S OI=+$O(^OR(100,IFN,4.5,"ID","ORDERABLE",0)),OI=+$G(^OR(100,IFN,4.5,OI,1)) Q:'OI
 . S ORVP=$P(X0,"^",2),PKG=$P(X0,"^",14)
 . S ORCAT=$S($L($P($G(^DPT(+ORVP,.1)),U)):"I",1:"O")
 . I PKG'=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",0)) Q
 . D PKI^ORWDPS1(.ORY,OI,ORCAT,+ORVP,$$GET^XPAR("ALL^USR.`"_DUZ,"ORWOR PKI USE",1,"Q"))
 . I $E($G(ORY))=2 S $P(LST(IDX),U,18)=ORY
 ; Change to display location for Clinic Orders, Inpatients, & IV infusion orders.
 N DGID,DGNAM
 S LOC=""
 S DGID=$P(X0,U,11)
 I $L(DGID) D 
 .S DGNAM=$P($G(^ORD(100.98,DGID,0)),U)
 .;I DGNAM="CLINIC ORDERS"!(DGNAM="INPATIENT MEDICATIONS")!(DGNAM="IV MEDICATIONS")!(DGNAM="UNIT DOSE MEDICATIONS") D
 .S LOC=$P(X0,U,10) ;IMO
 .S:+LOC LOC=$P($G(^SC(+LOC,0)),U)_":"_+LOC ;IMO
 S $P(LST(IDX),U,19)=LOC ;IMO
 ;need a way to determine if order is in an unsigned DC state.
 S $P(LST(IDX),U,21)=$S(ACTID="DC":1,1:0)
 S $P(LST(IDX),U,22)=$$CHKORD^OREVNTX1(IFN)
 ;
 S ORIGVIEW=$S($G(TXTVW)=0:0,$G(TXTVW)=1:1,ORYD=-1:1,'ORYD:1,$P(X8,U)'<ORYD:0,1:1)
 K TXT D TEXT^ORQ12(.TXT,ID,255)                  ; optimize later
 I $O(^OR(100,+IFN,2,0)) S LN=$O(TXT(0)),TXT(LN)="+"_TXT(LN)
 I $O(^OR(100,+IFN,8,"C","XX",0)) S LN=$O(TXT(0)),TXT(LN)="*"_TXT(LN)
 S LN=0 F  S LN=$O(TXT(LN)) Q:'LN  S IDX=IDX+1,LST(IDX)="t"_TXT(LN)
 I $O(^OR(100,+IFN,8,1,.2,0)) S IDX=IDX+1,LST(IDX)="|" D  ;PKI XMLText
 . S I=0 F  S I=$O(^OR(100,+IFN,8,1,.2,I)) Q:'I  S IDX=IDX+1,LST(IDX)="x"_^(I,0)
 Q
RSTRT() ; return start date from responses
 Q $G(^OR(100,IFN,4.5,+$O(^OR(100,IFN,4.5,"ID","START",0)),1))
RSTOP() ; return stop date from responses
 Q $G(^OR(100,IFN,4.5,+$O(^OR(100,IFN,4.5,"ID","STOP",0)),1))
GETTXT(LST,IFN) ; get text of an order
 I $L(IFN,";")=1 S IFN=IFN_";1"
 D TEXT^ORQ12(.LST,IFN,255)
 Q
XPND(AGRP) ; procedure
 ; Expand display group (GROUPS defined outside of call)
 N I,CHLD
 S GROUPS(AGRP)=^ORD(100.98,AGRP,0),I=0
 F  S I=$O(^ORD(100.98,AGRP,1,I)) Q:'I  S CHLD=$P(^(I,0),U) D XPND(CHLD)
 Q
GETPKG(Y,IFN) ; get order pkg
 N ORDERID,PKGID
 Q:+IFN<1
 S ORDERID=+IFN,Y=""
 S PKGID=$P(OR(100,ORDERID,0),U,14)
 S:PKGID>0 Y=$P(^DIC(9.4,PKGID,0),U,2)
 Q
