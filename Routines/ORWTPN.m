ORWTPN ; SLC/STAFF Personal Preference - Notes ;2/21/01  08:11 [1/29/04 2:32pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,149,187,195**;Dec 17, 1997
 ;
GETSUB(VALUE,USER) ; from ORWTPP
 ; get Ask for Subject on notes for user
 N NODE
 S NODE=+$O(^TIU(8926,"B",USER,0))
 S VALUE=+$P($G(^TIU(8926,NODE,0)),U,8)
 Q
 ;
SETSUB(OK,VALUE,USER) ; from ORWTPP
 ; set Ask for Subject on note for user
 N DA,DIE,DIK,DR,NODE,NUM
 S OK=1
 S VALUE=+$G(VALUE),VALUE=$S(VALUE=1:1,VALUE=0:0,1:"")
 I VALUE="" S OK=0 Q
 S NODE=+$O(^TIU(8926,"B",USER,0))
 I 'NODE D  Q  ; make new entry if user does not have TIU preferences
 .I 'VALUE Q  ; no need to set since default for no user preference is 0
 .L +^TIU(8926,0):5 I '$T S OK=0 Q
 .S NUM=1+$P(^TIU(8926,0),U,3)
 .F  Q:'$D(^TIU(8926,NUM,0))  S NUM=NUM+1
 .S $P(^(0),U,4)=1+$P(^TIU(8926,0),U,4),$P(^(0),U,3)=NUM
 .S ^TIU(8926,NUM,0)=USER_"^^^^^^^1"
 .L -^TIU(8926,0)
 .S DA=NUM,DIK="^TIU(8926,"
 .D IX1^DIK
 I USER'=+$G(^TIU(8926,NODE,0)) Q
 S DA=NODE,DIE="^TIU(8926,",DR=".08///"_VALUE
 D ^DIE
 Q
 ;
GETCOS(ORY,ORUSER,ORFROM,ORDIR,ORVIZ) ; Get cosigners for user (from ORWTPP).
 ; (Keep this code matched with NP1^ORWU1 / NEWPERS^ORWU.)
 ;
 ; Params:
 ;  .ORY=returned list, ORFROM=text to $O from, ORDIR=$O direction.
 ;  ORDIR=Direction to move through x-ref.
 ;  ORFROM=Starting value to use.
 ;  ORUSER=User seeking a Cosigner.
 ;  ORVIZ=If true, includes RDV users; otherwise not (optional).
 ;
 N OR1DIV,ORCNT,ORDATE,ORDD,ORDIV,ORDUP,ORGOOD,ORI,ORIEN1,ORIEN2,ORKEY,ORLAST,ORMAX,ORMRK,ORMULTI,ORNODE,ORPREV,ORSRV,ORTTL
 ;
 S ORI=0,ORMAX=44,(ORLAST,ORPREV)="",ORKEY=$G(ORKEY),ORDATE=$G(ORDATE)
 S ORMULTI=$$ALL^VASITE ; Do once at beginning of call.
 ;
 ; NP3^ORWU1 tag includes visitors, uses full "B" x-ref.
 I +$G(ORVIZ)=1 D NP3^ORWU1(1) Q  ; Use alt. version, skip rest.
 ;
 F  Q:ORI'<ORMAX  S ORFROM=$O(^VA(200,"AUSER",ORFROM),ORDIR) Q:ORFROM=""  D
 .S ORIEN1=""
 .F  S ORIEN1=$O(^VA(200,"AUSER",ORFROM,ORIEN1),ORDIR) Q:'ORIEN1  D
 ..;
 ..; Screen default cosigner selection:
 ..I '$$SCRDFCS^TIULA3(ORUSER,ORIEN1) Q
 ..S ORNODE=$P($G(^VA(200,ORIEN1,0)),U)
 ..I '$L(ORNODE) Q
 ..S ORI=ORI+1,ORY(ORI)=ORIEN1_"^"_$$NAMEFMT^XLFNAME(ORFROM,"F","DcMPC")
 ..S ORDUP=0                            ; Init flag, check dupe.
 ..I ($P(ORPREV_" "," ")=$P(ORFROM_" "," ")) S ORDUP=1
 ..;
 ..; Append Title if not duplicated:
 ..I 'ORDUP D
 ...S ORIEN2=ORIEN1
 ...D NP4^ORWU1(0)                      ; Get Title.
 ...I ORTTL="" Q
 ...S ORY(ORI)=ORY(ORI)_U_"- "_ORTTL
 ..;
 ..; Get data in case of dupes:
 ..I ORDUP D
 ...S ORIEN2=ORLAST                     ; Prev IEN for NP2^ORWU1 call.
 ...;
 ...; Reset, use previous array element, call for extended data:
 ...S ORI=ORI-1,ORY(ORI)=$P(ORY(ORI),U)_U_$P(ORY(ORI),U,2)  D NP2^ORWU1
 ...;
 ...; Then return to current user for second extended data call:
 ...S ORIEN2=ORIEN1,ORI=ORI+1  D NP2^ORWU1
 ..S ORLAST=ORIEN1,ORPREV=ORFROM        ; Reassign vars for next pass.
 ;
 Q
 ;
GETDCOS(VALUE,USER) ; from ORWTPP
 ; get default cosigner for user
 N IEN,NAME,NODE
 S NODE=+$O(^TIU(8926,"B",USER,0))
 S IEN=+$P($G(^TIU(8926,NODE,0)),U,9)
 S NAME=$P($G(^VA(200,IEN,0)),U)
 S VALUE=IEN_U_NAME
 Q
 ;
SETDCOS(OK,VALUE,USER) ; from ORWTPP
 ; set default cosigner for user
 N DA,DIE,DIK,DR,NODE,NUM
 S OK=1
 S VALUE=+$G(VALUE)
 I 'VALUE S VALUE="@"
 S NODE=+$O(^TIU(8926,"B",USER,0))
 I 'NODE D  Q  ; make new entry if user does not have TIU preferences
 .I 'VALUE Q
 .I '$$SCRDFCS^TIULA3(USER,VALUE) Q
 .L +^TIU(8926,0):5 I '$T S OK=0 Q
 .S NUM=1+$P(^TIU(8926,0),U,3)
 .F  Q:'$D(^TIU(8926,NUM,0))  S NUM=NUM+1
 .S $P(^(0),U,4)=1+$P(^TIU(8926,0),U,4),$P(^(0),U,3)=NUM
 .S ^TIU(8926,NUM,0)=USER_"^^^^^^^^"_VALUE
 .L -^TIU(8926,0)
 .S DA=NUM,DIK="^TIU(8926,"
 .D IX1^DIK
 I USER'=+$G(^TIU(8926,NODE,0)) Q
 S DA=NODE,DIE="^TIU(8926,",DR=".09///"_$S(VALUE:"`"_VALUE,1:"@")
 D ^DIE
 Q
 ;
GETCLASS(VALUES) ; RPC
 ; get available document classes
 N CNT,NODE,NUM K VALUES
 S CNT=0
 S NUM=0 F  S NUM=$O(^TIU(8925.1,"AT","CL",NUM)) Q:NUM<1  D
 .I '$$CLASPICK^TIULA4(38,NUM,"CL") Q
 .S NODE=$G(^TIU(8925.1,NUM,0))
 .I '$L(NODE) Q
 .S CNT=CNT+1
 .S VALUES(CNT)=NUM_U_NODE
 Q
 ;
GETTC(VALUES,CLASS,FROM,DIR) ; RPC
 ; get titles for a class
 N CNT,IEN,NODE,NUM K VALUES
 S CNT=44,NUM=0
 F  Q:NUM>CNT  S FROM=$O(^TIU(8925.1,"B",FROM),DIR) Q:FROM=""  D
 .S IEN=0 F  S IEN=$O(^TIU(8925.1,"B",FROM,IEN)) Q:IEN<1  D
 ..I '$D(^TIU(8925.1,"AT","DOC",IEN)) Q
 ..I '$$ISA^TIULX(IEN,CLASS) Q
 ..I '$$CANPICK^TIULP(IEN) Q
 ..I '$$CANENTR^TIULP(IEN) Q
 ..S NODE=$G(^TIU(8925.1,IEN,0))
 ..I '$L(NODE) Q
 ..S NUM=NUM+1
 ..S VALUES(NUM)=IEN_U_NODE
 Q
 ;
GETTU(VALUES,CLASS,USER) ; from ORWTPP
 ; get titles for a user
 N CNT,IEN,NUM,NUM1,NODE K VALUES
 S CNT=0
 S NUM=+$O(^TIU(8925.98,"AC",USER,CLASS,0))
 I 'NUM Q
 S NUM1=0 F  S NUM1=$O(^TIU(8925.98,NUM,10,NUM1)) Q:NUM1<1  D
 .S IEN=+$G(^TIU(8925.98,NUM,10,NUM1,0))
 .S NODE=$P($G(^TIU(8925.1,IEN,0)),U)
 .I '$L(NODE) Q
 .S CNT=CNT+1
 .S VALUES(CNT)=IEN_U_NODE_U_(.0000001*$P(^TIU(8925.98,NUM,10,NUM1,0),U,2))_U_$P(^(0),U,3)
 Q
 ;
GETTD(VALUE,CLASS,USER) ; from ORWTPP
 ; get default title for user
 N IEN,NUM,NODE
 S VALUE=-1,USER=+$G(USER)
 S NUM=+$O(^TIU(8925.98,"AC",USER,CLASS,0))
 I 'NUM Q
 S IEN=+$P($G(^TIU(8925.98,NUM,0)),U,3)
 S NODE=$G(^TIU(8925.1,IEN,0))
 I '$L(NODE) Q
 S VALUE=IEN
 Q
 ;
SAVET(OK,CLASS,DEFAULT,VALUES,USER) ; from ORWTPP
 ; save titles for user
 N CNT,DA,DIK,IEN,NUM,VALUE K DA
 S CLASS=+$G(CLASS),DEFAULT=+$G(DEFAULT),OK=1
 I DEFAULT'>0 S DEFAULT=""
 S IEN=+$O(^TIU(8925.98,"AC",USER,CLASS,0))
 I IEN D  Q
 .S DA(1)=IEN
 .S DIK="^TIU(8925.98,"_DA(1)_",10,"
 .L +^TIU(8925.98,IEN):5 I '$T S OK=0 Q
 .S DA=0 F  S DA=$O(^TIU(8925.98,IEN,10,DA)) Q:DA<1  D
 ..D ^DIK
 .S CNT=0
 .S NUM=0 F  S NUM=$O(VALUES(NUM)) Q:NUM<1  D
 ..S VALUE=+VALUES(NUM) I 'VALUE Q
 ..S CNT=CNT+1
 ..S ^TIU(8925.98,IEN,10,CNT,0)=VALUE_U_CNT_U_$P(VALUES(NUM),U,4)
 .S ^TIU(8925.98,IEN,10,0)="^8925.9801IP^"_CNT_U_CNT
 .S $P(^TIU(8925.98,IEN,0),U,3)=DEFAULT
 .K DA S DA=IEN,DIK="^TIU(8925.98,"
 .D IX1^DIK
 .L -^TIU(8925.98,IEN)
 S DA=1+$P(^TIU(8925.98,0),U,3)
 L +^TIU(8925.98,0):5 I '$T S OK=0 Q
 F  Q:'$D(^TIU(8925.98,DA))  S DA=DA+1
 S ^TIU(8925.98,DA,0)=USER_U_CLASS_U_DEFAULT
 S $P(^(0),U,4)=1+$P(^TIU(8925.98,0),U,4),$P(^(0),U,3)=DA
 L -^TIU(8925.98,0)
 S CNT=0
 S NUM=0 F  S NUM=$O(VALUES(NUM)) Q:NUM<1  D
 .S VALUE=+VALUES(NUM)
 .I 'VALUE Q
 .S CNT=CNT+1
 .S ^TIU(8925.98,DA,10,CNT,0)=VALUE
 S ^TIU(8925.98,DA,10,0)="^8925.9801IP^"_CNT_U_CNT
 S DIK="^TIU(8925.98,"
 D IX1^DIK
 Q
