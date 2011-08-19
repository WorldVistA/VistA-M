ORX8 ; slc/dcm,MKB - OE/RR Orders file extracts ;12/16/10  11:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**13,21,48,68,92,141,163,272**;Dec 17, 1997;Build 53
 ;
EN(ORIFN) ;Returns data from file 100 in the ORUPCHUK array [DBIA#871]
 Q:'$D(ORIFN)  Q:'$D(^OR(100,+ORIFN,0))  K ORUPCHUK
 D A
 K ORTX,X0,X3,%X,%Y,J,ORINDX,X
 Q
A S X0=^OR(100,ORIFN,0),X3=^(3),ORUPCHUK("ORPK")=$S($D(^(4)):^(4),1:"")
 S ORUPCHUK("ORVP")=$P(X0,"^",2),ORUPCHUK("ORPCL")=$P(X0,"^",5),X=$P(X0,"^",6),ORUPCHUK("ORDUZ")=X_"^"_$$GET1^DIQ(200,+X,.01),ORUPCHUK("ORODT")=$P(X0,"^",7),ORUPCHUK("ORSTOP")=$P(X0,"^",9),ORUPCHUK("ORL")=$P(X0,"^",10)
 S X=$P(X0,"^",11),ORUPCHUK("ORTO")=X_"^"_$S($D(^ORD(100.98,+X,0)):$P(^(0),"^"),1:"")
 S X=$P(X3,"^",3),ORUPCHUK("ORSTS")=X_"^"_$P(^ORD(100.01,X,0),"^"),ORUPCHUK("ORSTRT")=$P(X0,"^",8),X=$P(X0,"^",4),(ORUPCHUK("ORNP"),ORUPCHUK("ORPV"))=X_"^"_$S(X:$$GET1^DIQ(200,+X,.01),1:"")
 D TEXT^ORQ12(.ORTX,ORIFN,$G(ORLENGTH))
 I $O(ORTX(0)) S %X="ORTX(",%Y="ORUPCHUK(""ORTX""," D %XY^%RCR
 Q
 ;
VALUE(IFN,ID,INST,FORMAT) ; -- Returns value of prompt by ID
 N PRMT
 I '$G(IFN)!('$D(^OR(100,+$G(IFN),0)))!($G(ID)="") Q ""
 N I,Y S I=0,Y="" S:'$G(INST) INST=1
 F  S I=$O(^OR(100,+IFN,4.5,"ID",ID,I)) Q:I'>0  I $P($G(^OR(100,+IFN,4.5,+I,0)),U,3)=INST S PRMT=+$P(^(0),U,2),Y=$G(^(1)) Q
 I $L(Y),$G(PRMT),$G(FORMAT)="E" D  ; get external form of Y
 . N ORDIALOG S ORDIALOG(PRMT,0)=$G(^ORD(101.41,PRMT,1))
 . S ORDIALOG(PRMT,1)=Y,Y=$$EXT^ORCD(PRMT,1)
 Q Y
 ;
OI(IFN) ; -- Returns [first] orderable item for order IFN in the format
 ;    ifn ^ name ^ pkg id   [DBIA#2467]
 I '$G(IFN)!('$D(^OR(100,+$G(IFN),0))) Q ""
 N I,X,Y S I=$O(^OR(100,+IFN,.1,0)),X=$G(^(+I,0)),Y=""
 I X,$D(^ORD(101.43,+X,0)) S Y=+X_U_$P(^(0),U,1,2)
 Q Y
 ;
LATEST(ORPAT,ORIT,ORY) ; -- Return most recent orders for ORPAT,ORIT as
 ;        ORY = total number of orders found (or 0 if none found)
 ; ORY(ORSTS) = ORIFN ^ Ord'd By ^ Entered ^ StartDt ^ StopDt ^ Loc ^ Sts
 ; where ORSTS is the ien in the Order Status file #100.01  [DBIA#2842]
 ;
 N ORVP,ORIDT,ORIFN,OR0,OR3,ORSTS,ORSTSNM
 S ORVP=+ORPAT_";DPT(",ORY=0 Q:'$G(ORPAT)  Q:'$G(ORIT)  ;invalid input
 S ORIDT=0 F  S ORIDT=$O(^OR(100,"AOI",+ORIT,ORVP,ORIDT)) Q:ORIDT'>0  D
 . S ORIFN=0 F  S ORIFN=$O(^OR(100,"AOI",+ORIT,ORVP,ORIDT,ORIFN)) Q:ORIFN'>0  D
 .. S OR0=$G(^OR(100,+ORIFN,0)),OR3=$G(^(3)),ORSTS=+$P(OR3,U,3)
 .. Q:ORSTS'>0  Q:$G(ORY(ORSTS))  ;return only latest order per status
 .. S ORSTSNM=$$LOW^XLFSTR($P($G(^ORD(100.01,ORSTS,0)),U))
 .. S ORY=ORY+1,ORY(ORSTS)=ORIFN_U_$P(OR0,U,4)_U_$P(OR0,U,7,10)_U_ORSTSNM
 Q
 ;
DELAYED(ORY,ORDER) ; -- Return delayed order(s) with same OrdItem as ORDER
 ;    in ORY(ORIFN) = PatEventPtr ^ EventName
 ;
 N ORI,ORIT,ORIFN,EVT,PTEVT S (ORY,ORI)=0
 F  S ORI=$O(^OR(100,+ORDER,.1,ORI)) Q:ORI'>0  S ORIT=+$G(^(ORI,0)) D
 . S EVT=0 F  S EVT=$O(^ORE(100.2,"AE",+ORVP,EVT)) Q:EVT<1  S PTEVT=+$O(^(EVT,0)) D  ;pending events
 .. S ORIFN=0 F  S ORIFN=+$O(^OR(100,"AEVNT",ORVP,PTEVT,ORIFN)) Q:ORIFN<1  D  ;delayed orders
 ... Q:ORIFN=+ORDER  Q:'$D(^OR(100,ORIFN,.1,"B",ORIT))
 ... Q:"^1^2^7^12^13^14^"[(U_$P($G(^OR(100,ORIFN,3)),U,3)_U)  ;terminated
 ... S ORY=ORY+1,ORY(ORIFN)=PTEVT_U_$P($G(^ORD(100.5,EVT,0)),U)
 Q
 ;
PKGID(ORIFN) ; -- Return package identifier for order ORIFN  [DBIA#3071]
 Q $G(^OR(100,+$G(ORIFN),4))
 ;
ES(ORDER) ; -- Returns the signature status of ORDER [DBIA#3632]
 ;  -1 = invalid order#
 ;  "" = no signature required
 ;   0 = not signed (needs ES)
 ;   1 = electronically or digitally signed
 ;   2 = signed on chart
 ;   3 = corrected or canceled order
 N X,Y,DA I '$G(ORDER)!'$D(^OR(100,+$G(ORDER),0)) Q -1
 S DA=+$P(ORDER,";",2) S:DA<1 DA=+$P($G(^OR(100,+ORDER,3)),U,7)
 S X=$P($G(^OR(100,+ORDER,8,DA,0)),U,4)
 S Y=$S(X=2:0,X=1!(X=7):1,X=0!(X=4):2,X=5!(X=6):3,1:"")
 Q Y
 ;
AND(DAD) ; -- Return 1 or 0, if all conjunctions are AND [DBIA#3632]
 N I,Y S I=0,Y=1
 F  S I=+$O(^OR(100,+$G(DAD),4.5,"ID","CONJ",I)) Q:I<1  I $E($G(^OR(100,+$G(DAD),4.5,I,1)))'="A" S Y=0 Q
 Q Y
OITM(IEN,FILE) ; -- Return 101.43 ien for package IEN;FILE
 ;    where FILE = "99xxx" as passed in HL7 messages
 Q $O(^ORD(101.43,"ID",+$G(IEN)_";"_$G(FILE),0))
