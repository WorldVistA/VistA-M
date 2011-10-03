OREVNTX ; SLC/MKB - Event delayed orders RPC's ;06/16/10  05:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,243,280**;Dec 17, 1997;Build 85
 ;
PAT(ORY,DFN)    ; -- Returns currently delayed events for patient DFN
 N EVT,CNT,X,Y S DFN=+$G(DFN),(EVT,CNT)=0
 F  S EVT=+$O(^ORE(100.2,"AE",DFN,EVT)) Q:EVT<1  S Y=+$O(^(EVT,0)) D
 . I $G(^ORE(100.2,Y,1)) K ^ORE(100.2,"AE",DFN,EVT,Y) Q
 . Q:$$LAPSED(Y)  ;I $$EMPTY(Y) D CANCEL(Y) Q
 . Q:$O(^ORE(100.2,"DAD",Y,0))  ;has children
 . S X=$P($G(^ORD(100.5,EVT,0)),U,8),X="Delayed "_$$LOWER^VALM1(X)
 . S CNT=CNT+1,ORY(CNT)=Y_U_X
 S:CNT ORY(0)=CNT
 Q
 ;
EXISTS(DFN,EVT) ; -- Returns 1 if patient DFN has delayed orders for EVT,
 ;    or 2 if parent/sibling event has delayed orders, else 0
 ;
 N X,Y,I S Y=0 I '$G(DFN)!'$G(EVT) G EXQ
 I $O(^ORE(100.2,"AE",+DFN,+EVT,0)) S Y=1 G EXQ
 S X=+$P($G(^ORD(100.5,+EVT,0)),U,12) I X D  G EXQ ;ck parent,siblings
 . I $O(^ORE(100.2,"AE",+DFN,X,0)) S Y=2 Q
 . S I=0 F  S I=+$O(^ORD(100.5,"DAD",X,I)) Q:I<1  I $O(^ORE(100.2,"AE",+DFN,I,0)) S Y=2 Q
EXQ Q Y
 ;
LIST(ORY,DFN)   ; -- Returns all processed events for patient DFN as
 ;    ORY(#) = PatEvtIEN ^ Display Text ^ EvtDateTime
 ;             in reverse chronological order
 N IDT,DA,CNT,X0,X1,EVT,DC,X
 S DFN=+$G(DFN),(IDT,CNT)=0
 F  S IDT=$O(^ORE(100.2,"AC",DFN,IDT)) Q:IDT<1  D
 . S DA=0 F  S DA=+$O(^ORE(100.2,"AC",DFN,IDT,DA)) Q:DA<1  D
 .. S X0=$G(^ORE(100.2,DA,0)),X1=$G(^(1)) Q:$P(X1,U,5)  ;has parent
 .. S EVT=+$P(X0,U,2),DC=+$P(X1,U,3)
 .. I '$P(X0,U,4),'$O(^ORE(100.2,DA,2,0)),'$O(^ORE(100.2,DA,3,0)),'$D(^OR(100,"AEVNT",DFN_";DPT(",DA)) Q  ;no orders
 .. S I=+$O(^ORE(100.2,DA,10,"B"),-1),X=$P($G(^(I,0)),U,2) I X="LP"!(X="CA") Q  ;lapsed or cancelled
 .. ;Q if not current admission?
 .. S X=$S(EVT:$P($G(^ORD(100.5,EVT,0)),U,8),DC:$P($G(^ORD(100.6,DC,0)),U,5),1:"UNSPECIFIED EVENT")
 .. S X=$$LOWER^VALM1(X),CNT=CNT+1,ORY(CNT)=DA_U_X_U_$P(X1,U)
 S:CNT ORY(0)=CNT
 Q
 ;
COMP(PTEVT) ; -- Returns 1 or 0, if PTEVT has been completed
 N Y,I S Y=$S($G(^ORE(100.2,+$G(PTEVT),1)):1,1:0)
 I Y S I=+$O(^ORE(100.2,+$G(PTEVT),10,0)) S:$P($G(^(I,0)),U,2)="CA" Y=0
 Q Y
 ;
ACTIVE(ORY,TYPE)     ; -- Returns all active events [of TYPE] from #100.5
 ;  where TYPE=string containing any of the codes from the TYPE field
 N NM,IEN,CNT,X0,X S CNT=0,TYPE=$G(TYPE)
 S NM="" F  S NM=$O(^ORD(100.5,"C",NM)) Q:NM=""  D
 . S IEN=0 F  S IEN=+$O(^ORD(100.5,"C",NM,IEN)) Q:IEN<1  D
 .. S X0=$G(^ORD(100.5,IEN,0)) I '$L($P(X0,U,2)) D  ;Child event
 ... S X=$P(X0,U,12) S:X $P(X0,U,2)=$P($G(^ORD(100.5,+X,0)),U,2)
 .. I $L(TYPE),TYPE'[$P(X0,U,2) Q
 .. Q:$O(^ORD(100.5,"DAD",IEN,0))  ;Parent event
 .. S CNT=CNT+1,ORY(CNT)=IEN_U_X0
 S:CNT ORY(0)=CNT
 Q
 ;
NAME(PTEVT)     ; -- Return name of Patient Event
 N X,Y,Z S X=+$P($G(^ORE(100.2,+$G(PTEVT),0)),U,2),Z=$G(^(1))
 S:X Y=$P($G(^ORD(100.5,X,0)),U,8)
 I 'X S X=+$P(Z,U,3),Y=$P($G(^ORD(100.6,X,0)),U,5)
 S Y=$S('Z:"Delayed ",1:"")_$$LOWER^VALM1(Y)
 Q Y
 ;
SHORTNM(PTEVT)  ; -- Return Short Name of Patient Event
 ;   or first 15 characters of Event Name if unspecified
 N X,Y,Y0 S X=+$P($G(^ORE(100.2,+$G(PTEVT),0)),U,2) I X D
 . S Y0=$G(^ORD(100.5,X,0)),Y=$P(Y0,U,10)
 . S:'$L(Y) Y=$E($P(Y0,U,8),1,15)
 I 'X S X=+$P($G(^ORE(100.2,+$G(PTEVT),1)),U,3),Y=$E($P($G(^ORD(100.6,X,0)),U,5),1,15)
 Q Y
 ;
EVT(PTEVT)      ; -- Return Event ptr #100.5, given PTEVT ptr #100.2
 Q +$P($G(^ORE(100.2,+$G(PTEVT),0)),U,2)
 ;
DC(PTEVT) ; -- Return DC Rule ptr #100.6, given PTEVT ptr #100.2
 I $P($G(^ORE(100.2,+$G(PTEVT),1)),U,5) S PTEVT=$P(^(1),U,5) ;use parent
 Q +$P($G(^ORE(100.2,+$G(PTEVT),1)),U,3)
 ;
TYPE(PTEVT)     ; -- Return Type of Patient Event (i.e. A/D/T)
 N X,Y S X=+$P($G(^ORE(100.2,+$G(PTEVT),0)),U,2)
 I $P($G(^ORD(100.5,X,0)),U,12) S X=$P(^(0),U,12) ;use parent
 S Y=$S(X:$P($G(^ORD(100.5,X,0)),U,2),1:"DC")
 Q Y
 ;
DIV(PTEVT)      ; -- Return Division for PTEVT
 N X,Y S X=+$P($G(^ORE(100.2,+$G(PTEVT),0)),U,2)
 I $P($G(^ORD(100.5,X,0)),U,12) S X=$P(^(0),U,12) ;use parent
 S Y=+$P($G(^ORD(100.5,X,0)),U,3) S:Y<1 Y=+$G(DUZ(2))
 Q Y
 ;
LOC(PTEVT)      ; -- Return Default Ordering Location for PTEVT
 N X,X0,Y S X=+$P($G(^ORE(100.2,+$G(PTEVT),0)),U,2)
 S X0=$G(^ORD(100.5,X,0)),Y=+$P(X0,U,9)_";SC("
 I Y<1,$P(X0,U,12) S Y=+$P($G(^ORD(100.5,+$P(X0,U,12),0)),U,9)_";SC("
 S:Y<1 Y=$G(ORL)
 Q Y
 ;
EMPTY(PTEVT)    ; -- Returns 1 or 0, if PTEVT has delayed orders
 N Y,OR0,PAT,TYPE,PSO,IFN,STS S Y=1 I '$G(PTEVT) Q Y
 S OR0=$G(^ORE(100.2,+PTEVT,0)),PAT=+$P(OR0,U)_";DPT("
 S TYPE=$$TYPE(PTEVT) I TYPE="D" S PSO=+$O(^DIC(9.4,"C","PSO",0))
 S IFN=0 F  S IFN=$O(^OR(100,"AEVNT",PAT,PTEVT,IFN)) Q:IFN<1  D  Q:'Y
 . S STS=$P($G(^OR(100,IFN,3)),U,3) I STS=10 S Y=0 Q
 . ;I IFN=+$P(OR0,U,4),STS=11!(STS=6) S Y=0 Q
 . I TYPE="D",$P($G(^OR(100,IFN,0)),U,14)=PSO,STS=5!(STS=6) S Y=0 Q
 I Y,$D(^ORE(100.2,"DAD",PTEVT)) D  ;ck child events
 . N CHLD S CHLD=0
 . F  S CHLD=+$O(^ORE(100.2,"DAD",PTEVT,CHLD)) Q:CHLD<1  D  Q:'Y
 .. S IFN=0 F  S IFN=$O(^OR(100,"AEVNT",PAT,CHLD,IFN)) Q:IFN<1  I $P($G(^OR(100,IFN,3)),U,3)=10 S Y=0 Q
 Q Y
 ;
EVTORDER(ORDER) ; -- Returns 1 or 0, if ORDER is for event
 ;    Will return 0 if action DA is included but not NW
 N X0,X,Y S X0=$G(^OR(100,+ORDER,0)),X=+$P(ORDER,";",2),Y=0
 I $P(X0,U,17),X'>1 D
 . I $P($G(^ORE(100.2,+$P(X0,U,17),0)),U,4)=+ORDER S Y=1 Q
 . S DAD=+$P($G(^ORE(100.2,+$P(X0,U,17),1)),U,5) ;has parent?
 . I DAD,$P($G(^ORE(100.2,DAD,0)),U,4)=+ORDER S Y=1
 Q Y
 ;
MANREL(ORDER)   ; -- Returns 1 or 0, if ORDER was manually released
 N EVT,Y,RELDT,TYPE,EVTDT S Y=0
 S EVT=+$P($G(^OR(100,+ORDER,0)),U,17),RELDT=+$P($G(^(8,1,0)),U,16)
 G:EVT<1 MNQ G:RELDT<1 MNQ ;not delayed or released
 I '$D(^ORE(100.2,EVT,2,+ORDER)) S Y=1 G MNQ ;not rel'd by event
 S TYPE=$$TYPE(EVT),EVTDT=+$G(^ORE(100.2,EVT,1))
 I TYPE="M",$$FMDIFF^XLFDT(EVTDT,RELDT,2)<300 S Y=1
MNQ Q Y
 ;
CANCEL(PTEVT)   ; -- Cancel empty PTEVT, event order
 S PTEVT=+$G(PTEVT) D DONE(PTEVT),ACTLOG(PTEVT,"CA")
 N IFN,DAD S IFN=+$P($G(^ORE(100.2,PTEVT,0)),U,4)
 I IFN<1 D  ;ck for parent w/event order
 . S DAD=+$P($G(^ORE(100.2,PTEVT,1)),U,5) Q:DAD<1
 . Q:'$G(^ORE(100.2,DAD,1))  ;parent still active
 . S IFN=+$P($G(^ORE(100.2,DAD,0)),U,4)
 I IFN D:'$$DCD^ORCACT2(IFN) CLRDLY^ORCACT2(IFN) ;cancel event order
 Q
 ;
DONE(PTEVT,WHEN,MVT,OR)    ; -- Terminate PTEVT
 Q:'$G(PTEVT)  Q:'$D(^ORE(100.2,PTEVT,0))
 N X0,X1,PAT,EVT,DAD
 S:'$G(WHEN) WHEN=+$E($$NOW^XLFDT,1,12) D D1
 S DAD=$P(X1,U,5) I DAD,$$ALLDONE(DAD) S PTEVT=DAD D D1 Q
 S DAD=PTEVT,PTEVT=0 ;if PTEVT=parent, terminate children too
 F  S PTEVT=+$O(^ORE(100.2,"DAD",DAD,PTEVT)) Q:PTEVT<1  D D1
 Q
D1 S X0=$G(^ORE(100.2,+PTEVT,0)),X1=$G(^(1)) Q:'$L(X0)
 S PAT=+$P(X0,U),EVT=+$P(X0,U,2) ;,ORD=+$P(X0,U,4)
 S $P(X1,U,1,2)=WHEN_U_$G(MVT),$P(X1,U,4)=$G(OR),^ORE(100.2,PTEVT,1)=X1
 S ^ORE(100.2,"AC",PAT,9999999-WHEN,PTEVT)=""
 S:$G(OR) ^ORE(100.2,"ASR",OR,PTEVT)=""
 K:EVT ^ORE(100.2,"AE",PAT,EVT,PTEVT)
 Q
 ;
ALLDONE(DAD) ; -- Returns 1 or 0, if all child events are done
 N I,Y S Y=1,I=0
 F  S I=+$O(^ORE(100.2,"DAD",+$G(DAD),I)) Q:I<1  I '$G(^ORE(100.2,I,1)) S Y=0 Q
 Q Y
 ;
CHGEVT(IFN,NEWEVT)      ; -- Change the Patient Event for order IFN to NEWEVT
 ;    Includes adding or removing event pointer to order
 Q:'$G(IFN)  N PAT,OLDEVT,OR3 S:$G(NEWEVT) NEWEVT=+NEWEVT
 S PAT=$P($G(^OR(100,+IFN,0)),U,2),OLDEVT=$P($G(^(0)),U,17),OR3=$G(^(3))
 Q:OLDEVT=NEWEVT  K:OLDEVT ^OR(100,"AEVNT",PAT,OLDEVT,+IFN)
 S $P(^OR(100,+IFN,0),U,17)=NEWEVT S:NEWEVT ^OR(100,"AEVNT",PAT,NEWEVT,+IFN)=""
 I NEWEVT,$P(OR3,U,3)'=10 S $P(^OR(100,+IFN,3),U,3)=10,$P(^(8,1,0),U,15)=10
 I 'NEWEVT,$P(OR3,U,3)=10 S $P(^OR(100,+IFN,3),U,3)=11,$P(^(8,1,0),U,15)=11 D SET^ORDD100(+IFN,1)
 Q
 ;
ACTLOG(PTEVT,ACTION,EVTYPE,SAVE)  ; -- Log a note for ACTION on PTEVT
 ;    SAVE => new data in VAIP() will be saved
 Q:'$G(PTEVT)  Q:'$D(^ORE(100.2,PTEVT,0))  Q:'$L($G(ACTION))
 N I,HDR,LAST,TOTAL,DA,ORNOW,MVT
 F I=1:1:10 L +^ORE(100.2,PTEVT,10,0):1 Q:$T  H 2
 Q:'$T "^" S HDR=$G(^ORE(100.2,PTEVT,10,0)) S:'$L(HDR) HDR="^100.25DA^^"
 S TOTAL=+$P(HDR,U,4),LAST=+$O(^ORE(100.2,PTEVT,10,"B"),-1)
 S I=LAST F I=(I+1):1 Q:'$D(^ORE(100.2,PTEVT,10,I,0))
 S DA=I,$P(HDR,U,3,4)=DA_U_(TOTAL+1)
 S ^ORE(100.2,PTEVT,10,0)=HDR L -^ORE(100.2,PTEVT,10,0)
 S ORNOW=+$$NOW^XLFDT,^ORE(100.2,PTEVT,10,"B",ORNOW,DA)=""
 S ^ORE(100.2,PTEVT,10,DA,0)=ORNOW_U_ACTION_U_$S(ACTION="LP":"",1:$G(DUZ))_U_$G(EVTYPE)
 S MVT=+$P($G(^ORE(100.2,PTEVT,1)),U,2)
 S:MVT ^ORE(100.2,"ADT",MVT,ORNOW,PTEVT,DA)=""
 I $G(SAVE),$G(VAIP(4)) S $P(^ORE(100.2,PTEVT,10,DA,0),U,5,7)=+VAIP(4)_U_+VAIP(8)_U_+VAIP(5)
 Q
 ;
LAPSED(PTEVT)   ; -- Ck if PTEVT has lapsed, if so lapse all orders
 N Y,X0,EVT,ENTERED,DAYS,ORN,ORCA,ORSIGDT S Y=0
 I $G(^ORE(100.2,PTEVT,1)) G LPQ ;already terminated
 S X0=$G(^ORE(100.2,PTEVT,0)),EVT=+$P(X0,U,2)
 S:$P($G(^ORD(100.5,EVT,0)),U,12) EVT=+$P(^(0),U,12) ;parent
 S ENTERED="9999999"
 ; if event order is signed then ENTERED needs to be the DT it was signed from file 100
 S ORN=$P(^ORE(100.2,PTEVT,0),U,4)
 I +ORN S ORCA=$P($G(^OR(100,+ORN,3)),U,7)
 I $G(ORCA) S ORSIGDT=$P($G(^OR(100,+ORN,8,ORCA,0)),U,6)
 I $G(ORSIGDT) S ENTERED=ORSIGDT
 ; if event order is not signed then ENTERED needs to be the ENTERED DT from file 100.2
 I ENTERED="9999999" S ENTERED=+$P(X0,U,5)
 S DAYS=+$P($G(^ORD(100.5,EVT,0)),U,6) I DAYS<1 G LPQ ;doesn't lapse
 I ENTERED>$$FMADD^XLFDT(DT,(0-DAYS)) G LPQ ;not lapsed yet
 D LP1(PTEVT) S Y=1 ;lapse orders, event
 N J S J=0 F  S J=$O(^ORE(100.2,"DAD",PTEVT,J)) Q:'J  D LP1(J)
LPQ Q Y
 ;
LP1(PTEVT) ; -- Lapse orders, event PTEVT
 N X0,PAT,IFN,STS
 S X0=$G(^ORE(100.2,PTEVT,0)),PAT=+$P(X0,U)_";DPT("
 S IFN=0 F  S IFN=$O(^OR(100,"AEVNT",PAT,PTEVT,IFN)) Q:IFN<1  D
 . S STS=$P($G(^OR(100,IFN,3)),U,3) I (STS=10)!(STS=11)!(IFN=+$P(X0,U,4)) D
 .. D STATUS^ORCSAVE2(IFN,14)
 .. D ALPS^ORCSAVE2(IFN,1,"DELAYED ORDER")
 .. S $P(^OR(100,IFN,8,1,0),U,15)="" D:$P(^(0),U,4)=2 SIGN^ORCSAVE2(IFN,"","",5,1)
 D DONE(PTEVT),ACTLOG(PTEVT,"LP")
 Q
