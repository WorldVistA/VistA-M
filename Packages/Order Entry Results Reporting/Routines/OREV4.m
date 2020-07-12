OREV4 ;SLC/DAN Event delayed orders cont ;08/03/15  15:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,367,377**;Dec 17, 1997;Build 582
 ;DBIA reference section
 ;10006 - DIC
 ;10018 - DIE
 ;10013 - DIK
 ;10103 - XLFDT
 ;2056  - DIQ
 ;2263  - XPAR
 ;
 N Y,DIC,ZTSAVE,IEN
 S DIC="^ORE(100.2,",DIC(0)="AEMQ" D ^DIC
 Q:Y=-1  ;Quit if no selection made
 S IEN=+Y
 W !
 S ZTSAVE("IEN")="",ZTSAVE("DIC")="",ZTSAVE("IO*")=""
 D QUE^ORUTL1("DQI^OREV4","Patient event inquiry",.ZTSAVE) ;Get device to print on
 Q
 ;
DQI ;Tasked entry point or continue if not queued
 U IO
 S DA=IEN
 D EN^DIQ
 Q
 ;
CHKPRM ;Checks to see if event is defined in either the OREVNT DEFAULT
 ;or the OREVNT COMMON LIST parameter.  If so, then it will be removed
 ;from the parameters as PARENT type events are not allowed in these
 ;parameters.  This API is called when an event becomes a parent.
 N DIC,Y,X,PRMC,PRMD,PARAM,I,J
 S DIC=8989.51,DIC(0)="MX",X="OREVNT COMMON LIST" D ^DIC
 Q:Y=-1  ;Parameter doesn't exist
 S PRMC=+Y
 S X="OREVNT DEFAULT" D ^DIC
 Q:Y=-1  ;Parameter doesn't exist
 S PRMD=+Y
 F PARAM=PRMC,PRMD D
 .K ORLST
 .D ENVAL^XPAR(.ORLST,PRMC) ;get list of values
 .Q:ORLST=0  ;No values
 .S I="" F  S I=$O(ORLST(I)) Q:I=""  D
 ..S J="" F  S J=$O(ORLST(I,J)) Q:J=""  D
 ...I ORLST(I,J)=DA D EN^XPAR(I,PARAM,J,"@") ;delete event from parameter
 Q
 ;
DELAYED(DFN) ;Display list of delayed events for a patient, identified by DFN
 N EVT,IFN,DISP
 I '$D(^ORE(100.2,"AE",DFN)) Q  ;Quit if no delayed orders exist for the patient
 S EVT=0,DISP=0
 F  S EVT=$O(^ORE(100.2,"AE",DFN,EVT)) Q:'+EVT  D
 .S IFN=$O(^ORE(100.2,"AE",DFN,EVT,0))
 .Q:$$LAPSED^OREVNTX(IFN)  ;quit if event has lapsed
 .W:'DISP !!,"Delayed orders exist for this patient!",$C(7) S DISP=1
 .W !,"EVENT: ",$P($G(^ORD(100.5,+$P(^ORE(100.2,IFN,0),U,2),0)),U,8),", created on ",$$FMTE^XLFDT($P(^ORE(100.2,IFN,0),U,5),1)
 Q
 ;
PARENTOK() ;This function determines if the event can be a parent
 ;if an event has future delayed orders tied to it then it can't be
 ;a parent
 N OK,SUB,RIEN,PIEN
 S OK=1
 S SUB="^ORE(100.2,""AE"")"
 F  S SUB=$Q(@SUB) Q:SUB'["AE"!('OK)  D
 .S RIEN=$P(SUB,",",4) ;Release event ID
 .S PIEN=+$P(SUB,",",5) ;Patient event ID -- p.367 added "+" to prevent PIEN from containing ")"
 .Q:$$LAPSED^OREVNTX(PIEN)  ;quit if event has lapsed
 .I RIEN=DA W !!,"You may not make ",$P($G(^ORD(100.5,DA,0)),U)," a parent",!,"at this time because there are unprocessed delayed orders assigned to it." H 3 S OK=0
 Q OK
 ;
ACTSURG(ORTYPE,DA) ;Function returns 1 if an active surgery event already exists
 N ACT,DIV,I
 S ACT=0
 I ORTYPE="E" D
 .S DIV=$P($G(^ORD(100.5,DA,0)),U,3)
 .S I=0 F  S I=$O(^ORD(100.5,"ADT","O",I)) Q:'+I  I DA'=I I DIV=$P($G(^ORD(100.5,I,0)),U,3)&('$G(^ORD(100.5,I,1))) S ACT=1
 .Q
 I ORTYPE="A" D
 .S DIV=$P($G(^ORD(100.6,DA,0)),U,3)
 .S I=0 F  S I=$O(^ORD(100.6,"AE",DIV,"O",I)) Q:'+I  I I'=DA S ACT=1
 .Q
 Q ACT
 ;
FROMTO(MUL,SUB1,SUB2) ;Check FROM - TO entries in file 100.6
 N DA,DIK,LOC0,X,Y,DEL,ERR
 I MUL="S" D  Q
 .I '$D(^ORD(100.6,SUB1,4,SUB2,1,"B")) D  ;Check for TO entries in specialties multiple
 ..W !!,"ERROR - Missing TO entry - ",$P($G(^DIC(45.7,$P(^ORD(100.6,SUB1,4,SUB2,0),U),0)),U)," DELETED.",!
 ..S DA(1)=SUB1,DA=SUB2,DIK="^ORD(100.6,"_DA(1)_",4," D ^DIK
 ;
 I MUL="L" D
 .S LOC0=^ORD(100.6,SUB1,5,SUB2,0)
 .I +$P(LOC0,U,2)=0&($P(LOC0,U,3)="") S DEL=1,ERR=1
 .I +$P(LOC0,U,4)=0&($P(LOC0,U,5)="") S DEL=1,ERR=1
 .I $G(ERR) W !!,"ERROR - Missing FROM or TO location - '",$P(LOC0,U),"' DELETED.",! Q
 .I $P(LOC0,U,2) D CLEAR(SUB1,SUB2,2) ;If user selects "all" clear "from" field
 .I $P(LOC0,U,4) D CLEAR(SUB1,SUB2,4) ;If user selects "all" clear "to" field
 .I $P(LOC0,U,2)&($P(LOC0,U,4)) W !!,"WARNING - You've defined a 'FROM ALL' locations to 'TO ALL' locations entry",!,"and it will supercede all other entries.",! Q
 .I $O(^ORD(100.6,SUB1,5,"ADC",$S($P(LOC0,U,2)=1:"ALL",1:$P(LOC0,U,3)),$S($P(LOC0,U,4)=1:"ALL",1:$P(LOC0,U,5)),SUB2)) S DEL=1,ERR=1
 .I $O(^ORD(100.6,SUB1,5,"ADC",$S($P(LOC0,U,2)=1:"ALL",1:$P(LOC0,U,3)),$S($P(LOC0,U,4)=1:"ALL",1:$P(LOC0,U,5)),SUB2),-1) S DEL=1,ERR=1
 .I $G(ERR) W !!,"ERROR - Duplicate entry exists - '",$P(LOC0,U),"' DELETED.",!
 I $G(DEL) S DIK="^ORD(100.6,"_SUB1_",5,",DA=SUB2,DA(1)=SUB1 D ^DIK
 Q
 ;
CLEAR(TENT,MENT,FIELD) ;Clear selected fields
 N DA,DIE,Y,X,FILE
 S FILE(100.62,MENT_","_TENT_",",FIELD)="@" D FILE^DIE("","FILE")
 Q
 ;
EXCOI(IEN) ;
 ;
EXCOI1 ;
 ;Protect FileMan variables
 W !,"EXCEPT ORDERABLE ITEMS"
 N D,D0,DA,DC,DDES,DE,DG,DH,DI,DIC,DIDEL,DIE,DIEDA,DIEL,DIEN,DIR,DIETMP
 N DIEXREF,DIFLD,DIEIENS,DINUSE,DIP,DISYS,DK,DL,DM,DP,DQ,DR,DU
 ;
 N ADD,C,ARRAY,EXIT,DISPLAY,EDIT,EXCLUDE,HELP,IND,LIST,NAME,NODE,NUM,OI,OINODE,PROMPT,RESULT,SEQ,SARRAY,TEMP,VAL,X,Y
 ;find existing OI, capture ones that cannot be remove
 S C=0,EXIT=""
 S SEQ=0 F  S SEQ=$O(^ORD(100.6,IEN,8,SEQ)) Q:SEQ'>0  D
 .S NODE=$G(^ORD(100.6,IEN,8,SEQ,0)),OI=$P(NODE,U) Q:OI'>0
 .S OINODE=$G(^ORD(101.43,OI,0))
 .S NAME=$P(OINODE,U) Q:NAME=""  Q:$P(OINODE,U,5)'>0
 .S DISPLAY=$P($G(^ORD(100.98,$P(OINODE,U,5),0)),U) Q:DISPLAY=""
 .I +$P(NODE,U,2)'=1 S EDIT(NAME,OI)=SEQ_U_DISPLAY Q
 .S EXCLUDE(NAME,OI)=SEQ_U_DISPLAY
 ;
 I '$D(EXCLUDE),'$D(EDIT) S ADD=$$ADD(IEN) G:ADD=1 EXCOI1 G:ADD=0 EXCOIX
 S VAL="" I $D(EDIT) D
 .S TEMP="S^A:New Orderablle Item to Exclude Orderable Item List;D:Delete exisitng Exclude Orderable Item;Q:Quit",PROMPT="Delete/Add'"
 .S VAL=$$ASK(TEMP,PROMPT,1)
 I VAL="Q" G EXCOIX
 I VAL="A" D ADD(IEN) G EXCOI1
 ;
 I $D(EXCLUDE) D
 .W !,"Cannot remove the following orderable item(s):"
 .S NAME="" F  S NAME=$O(EXCLUDE(NAME)) Q:NAME=""  D
 ..S OI=0 F  S OI=$O(EXCLUDE(NAME,OI)) Q:OI'>0  W !,"  "_NAME_" ("_$P(EXCLUDE(NAME,OI),U,2)_")"
 .H 1
 ;
 I '$D(EDIT) S ADD=$$ADD(IEN) G:ADD=1 EXCOI1 G:ADD=0 EXCOIX
 W !!,"Can delete the following orderable item(s):"
 W !,"Deletion occurs immediately after selection"
 S NAME="" F  S NAME=$O(EDIT(NAME)) Q:NAME=""  D
 .S OI=0 F  S OI=$O(EDIT(NAME,OI)) Q:OI'>0  D
 ..S NODE=$G(EDIT(NAME,OI)) S SEQ=$P(NODE,U) Q:SEQ'>0
 ..S C=C+1,ARRAY(C)=" "_$J(C,4)_" - "_NAME_" ("_$P(EDIT(NAME,OI),U,2)_")",SEQARRAY(C)=SEQ_U_OI_U_NAME_U_$P(EDIT(NAME,OI),U,2)
 ;
 M DIR("A")=ARRAY
 S DIR("A")="Select number to delete from 'Exclude Orderable Item List'"
 S DIR(0)="LO^1:"_C
 D ^DIR
 S NUM=$L(Y,",")-1
 I NUM=0 Q
 S LIST=Y
 F IND=1:1:NUM D
 .S SEQ=$P(LIST,",",IND)
 .S NODE=SEQARRAY(SEQ)
 .D DELETE(IEN,NODE)
 I EXIT=U G EXCOI1
 ;
EXCOIX ;
 Q
 ;
ASK(TEMP,PROMPT,HELP) ;
 N DIR,Y
 S DIR(0)=TEMP
 S DIR("A")=PROMPT
 S DIR("??")=U_"D HELP^OREV4("_HELP_")"
 D ^DIR
 Q Y
 ;
ADD(IEN) ;
 N ARRAY,PROMPT,TEMP,VAL
 D LOOKUP(.ARRAY)
 I '$D(ARRAY) Q 0
 S VAL="" F  S VAL=$O(ARRAY(VAL)) Q:VAL=""  D
 .N DA,DIC,X,Y
 .S DA(1)=IEN,X=+VAL
 .S DIC="^ORD(100.6,"_DA(1)_",8,",DIC(0)="L"
 .D FILE^DICN
 .I Y=-1 W !,"Error adding OI "_$P(VAL,U,2)_" to Auto-DC Rule" H 1
 Q 1
 ;
DELETE(IEN,NODE) ;
 W !,"Deleting Orderable Item: "_$P(NODE,U,3)
 N DA,DIK
 S DA(1)=IEN,DA=+NODE
 S DIK="^ORD(100.6,"_DA(1)_",8,"
 D ^DIK
 Q
 ;
LOOKUP(ARRAY) ;
 N DIC,DUOUT,QUIT,Y
 S QUIT=0
 F  D  Q:QUIT=1
 .S DIC="^ORD(101.43,",DIC("S")="I '$G(^ORD(101.43,Y,.1))"
 .S DIC("A")="Select Orderable Item: ",DIC(0)="ABE"
 .D ^DIC
 .I $G(DUOUT)!(Y=-1) S QUIT=1 Q
 .S ARRAY(Y)=""
 Q
 ;
HELP(HELP) ;
 W !,"Select A to add Orderable Item(s) to the 'Exclude Orderble Item List'. Select D "
 W !,"to delete Orderable Item(s) from the 'Exclude Orderable List'."
 Q
 ;
FILESCR() ;
 I $G(ORMGR)=1 Q 1
 Q 0
