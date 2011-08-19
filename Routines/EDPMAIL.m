EDPMAIL ;SLC/KCM - Process incoming mail for posted events
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
MSG(MSG) ; parse message passed in from SEND^EDPFMON
 N I,PARAM,LOG,ORIFN,EDPDBUG
 S EDPDBUG=$$DEBUG^EDPCDBG("messages")
 I EDPDBUG D PUTREQ^EDPCDBG(EDPDBUG,.MSG)
 ;
 S I=0 F  S I=$O(MSG(I)) Q:'I  S PARAM($P(MSG(I),"="))=$P(MSG(I),"=",2,99)
 S LOG=$$VAL("id"),ORIFN=$$VAL("orifn")
 I $$VAL("command")="newOrder" D NEW
 I $$VAL("command")="updateOrder" D UPD
 I $$VAL("command")="deleteOrder" D DEL
 I $$VAL("command")="verifyOrder" D VER
 I $$VAL("command")="completeOrder" D COMP
 I $$VAL("command")="patientCheckIn" D CHKIN
 I $$VAL("command")="convertVisit" D VST^EDPCONV(.PARAM)
 I $$VAL("command")="convertConfiguration" D CONFIG^EDPCONV1(.PARAM)
 Q
 ;
NEW ; add new order
 Q:'LOG  Q:'ORIFN
 N X,Y,DIC,DA
 S DIC="^EDP(230,"_LOG_",8,",DIC(0)="LZ",DA(1)=LOG,X=+ORIFN
 S DIC("DR")=".02///"_$$VAL("pkg")_";.03///N;.05///"_$$VAL("release")
 S:$$VAL("stat") DIC("DR")=DIC("DR")_";.04///1"
 D FILE^DICN
 Q
UPD ; update order
 Q:'LOG  Q:'ORIFN  Q:'$L($$VAL("sts"))
 N IEN S IEN=$$FIND Q:IEN<1
 I $D(^EDP(230,LOG,8,+IEN,0)) S $P(^(0),U,3)=$$VAL("sts")
 Q
DEL ; delete order
 Q:'LOG  Q:'ORIFN
 N DIK,DA
 S DA=$$FIND Q:DA<1
 S DIK="^EDP(230,"_LOG_",8,",DA(1)=LOG
 D ^DIK
 Q
VER ; verify order
 Q:'LOG  Q:'ORIFN
 N IEN S IEN=$$FIND Q:IEN<1
 I $P($G(^EDP(230,LOG,8,IEN,0)),U,3)'="C" S $P(^(0),U,3)="A"
 Q
COMP ; complete order
 Q:'LOG  Q:'ORIFN
 N IEN S IEN=$$FIND Q:IEN<1
 S $P(^EDP(230,LOG,8,IEN,0),U,3)="C"
 Q
 ;
FIND() ; -- return ien of ORIFN in multiple
 N Y S Y=+$O(^EDP(230,LOG,8,"B",+ORIFN,0))
 Q Y
 ;
VAL(X) ; -- return parameter value or null if undefined
 Q $G(PARAM(X))
 ;
CHKIN ; check in a patient
 Q:'$$VAL("dfn")  Q:'$$VAL("ssn")  Q:'$L($$VAL("ptNm"))  Q:'$L($$VAL("site"))
 N NEWPT
 S NEWPT="dfn="_$$VAL("dfn")_$C(9)_"name="_$$VAL("ptNm")_$C(9)_"dob="_$$VAL("dob")_$C(9)_"ssn="_$$VAL("ssn")_$C(9)_"clinic="_$$VAL("hloc")
 S NEWPT=NEWPT_$C(9)_"create=1"  ; set Creation Source to Scheduling
 N AREA
 S AREA=$O(^EDPB(231.9,"C",$$VAL("site"),0)) Q:'AREA
 N EDPXML,EDPSITE,EDPSTA
 S EDPUSER=DUZ,EDPSITE=DUZ(2),EDPSTA=$$STA^XUAF4(DUZ(2))
 D ADD^EDPLOGA(NEWPT,AREA,$$VAL("time"),0)
 Q
