OREV1 ;SLC/DAN Event delayed orders set up continued ;1/14/03  11:54
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**142,141,165**;Dec 17, 1997
 ;DBIA reference section
 ;2686 - ^XTV(8989.5 and ^XTV(8989.51
 ;519  - ^DIC(45.7
 ;2263  - XPAR
 ;10039- ^DIC(42
 ;10009- DICN
 ;10018- DIE
 ;10026- DIR
 ;10116- VALM1
 ;10103- XLFDT
SCR ;Sets DIC("S") for MAS MOVEMENT TYPE field of either file
 N FILE
 S FILE="^ORD("_$O(DR(1,0))_","
 S DIC("S")="S TMP=$P("_FILE_"DA,0),U,2),TTP=$E($P(^DG(405.3,$P(^DG(405.2,Y,0),U,2),0),U)) I $S(TMP=TTP:1,1:0)"_$S('$G(@(FILE_DA_",1)")):"&('$$INUSEDC^OREV1())",1:"")
 Q
 ;
ACT ;Inactivate or reactivate an event or auto dc rule
 N ORJ,Y,ORTMP,DA,DIC,ORGLOB
 S VALMBCK="R" D FULL^VALM1
 S ORGLOB="^ORD(100."_$S(ORTYPE="E":"5,",1:"6,")
 I $G(ORNMBR)="" S ORNMBR=$$ORDERS("activate/inactivate")
 F ORJ=1:1:$L(ORNMBR,",")-1 S ORTMP=$P(ORNMBR,",",ORJ),DA=$O(^TMP("OREDO",$J,"IDX",ORTMP,0)) D FLIP(DA)
 Q
 ;
FLIP(DA) ;Check status and flip if necessary
 N STAT,DIR,DIE,DR,Y,NAME,CDT,MULT,IEN,SUB,USED,EVNTYPE
 S NAME=$P(@(ORGLOB_DA_",0)"),U),EVNTYPE=$P(^(0),U,2)
 S CDT=$$NOW^XLFDT
 S STAT=$S($G(@(ORGLOB_DA_",1)")):^(1),1:0) ;Status is date/time if already inactivated
 W !!,NAME," is currently ",$S(STAT:"IN",1:"")_"ACTIVE."
 I ORTYPE="E",$$RELEVNTS(DA),'STAT W !!,"There are delayed orders awaiting release that are associated with this event.",!,"This event, even if inactivated, will still be applied to these delayed orders.",!!
 I ORTYPE="A",'STAT W !!,"Inactivating auto-dc rules takes effect immediately.",!
 I STAT,$G(EVNTYPE)="O",$$ACTSURG^OREV4(ORTYPE,DA) D  Q
 .W !,NAME,!,"can not be activated because you already have an active surgery rule for this",!,"division.  Only one active surgery rule per division is allowed.",!
 .S DIR(0)="E",DIR("A")="Press enter to continue" D ^DIR K DIR
 I STAT,ORTYPE="E",$P($G(^ORD(100.5,DA,0)),U,12),$G(^ORD(100.5,$P(^(0),U,12),1)) D  Q  ;If inactive child event and parent is inactive don't activate child
 .W !,NAME,!,"can not be activated until its parent event is active.",!
 .S DIR(0)="E",DIR("A")="Press enter to continue" D ^DIR K DIR
 I STAT,ORTYPE="E",'$$CANACT(DA,.USED) D  Q
 .W !,NAME,!,"can not be activated because the following locations",!,"and/or treating specialties are currently in use by other entries.",!
 .F MULT="LOC","TS" W:$D(USED(MULT)) !,$S(MULT="LOC":"LOCATIONS:",1:"TREATING SPECIALTIES:"),! D
 ..S IEN=0 F  S IEN=$O(USED(MULT,IEN)) Q:'+IEN  D
 ...S SUB=0 F  S SUB=$O(USED(MULT,IEN,SUB)) Q:'+SUB  D
 ....W !,$S(MULT="LOC":$P($G(^DIC(42,SUB,0)),"^"),1:$P($G(^DIC(45.7,SUB,0)),"^"))," is in use by ",$P($G(@(ORGLOB_IEN_",0)")),"^"),!
 .W !,"For active entries, LOCATIONS and TREATING SPECIALTIES",!,"must be unique within division and event type."
 .S DIR(0)="E",DIR("A")="Press enter to continue" D ^DIR K DIR
 I STAT I ORTYPE="A" I '$$CANACT(DA,.USED) D  Q
 .W !,NAME,!,"can not be activated because the following MAS movements",!,"are currently in use by other entries.",!
 .S IEN=0 F  S IEN=$O(USED(IEN)) Q:'+IEN  D
 ..S SUB=0 F  S SUB=$O(USED(IEN,SUB)) Q:'+SUB  D
 ...W !,$P($G(^DG(405.2,IEN,0)),U)," is in use by ",$P($G(^ORD(100.6,SUB,0)),U)
 .W !,"For active entries, MAS movements within DIVISION must be unique."
 .S DIR(0)="E",DIR("A")="Press return to continue" D ^DIR K DIR
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to "_$S(STAT:"",1:"IN")_"ACTIVATE this entry" D ^DIR
 I Y'=1 W !,"Nothing changed!" Q
 S DIE=ORGLOB,DR="1///"_$S(STAT:"@",1:CDT) D ^DIE W !,NAME," is now "_$S(STAT:"",1:"IN")_"ACTIVATED!"
 I 'STAT S DA(1)=DA,DA=$O(@(ORGLOB_DA(1)_",2,"_"""ACT"""_",0)")),DIE=ORGLOB_DA(1)_",2,",DR="1///"_CDT D ^DIE D:ORTYPE="E" UPDTCHLD^OREV3(DA(1),CDT) Q
 D SET(DA,CDT)
 Q
 ;
SET(MIEN,X) ;add new multiple to activation history
 N DIC,DA
 S DA(1)=MIEN
 S DIC=ORGLOB_DA(1)_",2,",DIC(0)="L"
 D FILE^DICN
 Q
 ;
INUSE(MULT) ;determine if location or treating specialty is already in use
 N ACTIVE,USED,NAME,TYPE,DIV,FMIEN
 S USED=0,NAME="",FMIEN=$G(DA(1),DA)
 S TYPE=$P($G(^ORD(100.5,FMIEN,0)),"^",2) ;movement type of entry being checked
 S DIV=$P($G(^ORD(100.5,FMIEN,0)),"^",3) ;division of entry being checked
 F  S NAME=$O(^ORD(100.5,"C",NAME)) Q:NAME=""!(USED)  D
 .S ACTIVE=0 F  S ACTIVE=$O(^ORD(100.5,"C",NAME,ACTIVE)) Q:'+ACTIVE!USED  D
 ..Q:DIV'=$P($G(^ORD(100.5,ACTIVE,0)),"^",3)  ;stop processing if not same division
 ..Q:TYPE'=$P($G(^ORD(100.5,ACTIVE,0)),"^",2)  ;stop processing if not the same type
 ..S USED=$D(^ORD(100.5,ACTIVE,MULT,"B",Y)) I USED S WHO=ACTIVE
 Q USED
 ;
CANACT(DA,USED) ;Function returns whether or not an entry can be activated.
 ;For EVENTS, locations and specialties must be unique within division
 ;and EVENT TYPE.  For AUTO DC, movement types must be unique within
 ;division.
 N MULT,SUB,Y,CANACT,WHO
 S CANACT=1
 I ORTYPE="E" F MULT="LOC","TS" D
 .S SUB=0 F  S SUB=$O(^ORD(100.5,DA,MULT,SUB)) Q:'+SUB  D
 ..S Y=$G(^(SUB,0)) I Y I $$INUSE(MULT) S CANACT=0,USED(MULT,WHO,Y)=""
 ;
 I ORTYPE="A" D
 .S SUB=0 F  S SUB=$O(^ORD(100.6,DA,3,SUB)) Q:'+SUB  D
 ..S Y=+$G(^(SUB,0)) I Y I $$INUSEDC() S CANACT=0,USED(Y,WHO)=""
 Q CANACT
 ;
INUSEDC() ;Checks AUTO-DC rules for unique movement types
 N DIV,USED
 S USED=0
 S DIV=+$P($G(^ORD(100.6,DA,0)),U,3)
 I DIV I $D(^ORD(100.6,"AC",DIV,Y)) S WHO=$O(^(Y,0)),USED=1
 Q USED
 ;
HASREQD() ;Function returns whether entry has required entries or not
 N REQD
 S REQD=0
 I ORTYPE="E" D
 .I "^22^23^24^"[("^"_$P($G(^ORD(100.5,DA,0)),U,7)_"^") S REQD=1 Q  ;From pass (transfer) doesn't require treating specialty
 .I $O(^ORD(100.5,DA,"LOC",0))>0!($O(^ORD(100.5,DA,"TS",0))>0) S REQD=1 ;Has locations or treating specialties
 .I $O(^ORD(100.5,DA,"LOC",0))>0&($O(^ORD(100.5,DA,"TS",0))>0) S REQD=2 ;Warn user that both must be true if both defined.
 I ORTYPE="A" D
 .I $P($G(^ORD(100.6,DA,0)),U,2)="O" S REQD=1 ;If type is operating room then movements not required
 .I $P($G(^ORD(100.6,DA,0)),U,2)'="O"&($O(^ORD(100.6,DA,3,0))>0) S REQD=1 ;movement type exists
 .I $P($G(^ORD(100.6,DA,0)),U,2)="T",$D(^ORD(100.6,DA,3,"B",4)),$P($G(^ORD(100.6,DA,3,0)),U,4)>1 S REQD=2 ;If transfer type and interward transfer type not by itself
 Q REQD
 ;
CHKTYP(IEN) ;Check type of event and delete fields that are no longer needed based on the event type
 N J,DR,DIE,DA,DIC,TYPE
 I ORTYPE="E" D  Q
 .S TYPE=$P(^ORD(100.5,IEN,0),U,2)
 .I TYPE'="A"&(TYPE'="T") D DELMUL(100.5,IEN,"""LOC"""),DELMUL(100.5,IEN,"""TS""") ;if not admit or transfer delete locations and treating specialties
 .S DA=IEN,DIE=100.5,DR="7///@" D ^DIE ;Delete MAS MOVEMENT when type changes as movement types are associated with event type
 ;If not event type must be auto-dc
 S TYPE=$P(^ORD(100.6,IEN,0),U,2)
 I TYPE'="D" S DA=IEN,DIE=100.6,DR="6///@" D ^DIE ;Delete 'except from observation" if not discharge type
 D DELMUL(100.6,IEN,3) ;delete MAS MOVEMENT
 I TYPE'="S" D DELMUL(100.6,IEN,4) ;If not specialty type delete excluded treating specialties
 I TYPE'="T" D DELMUL(100.6,IEN,5),DELMUL(100.6,IEN,6) ;If not transfer type delete included locations and included divisions
 Q
 ;
ORDERS(ACTION) ; -- Return order numbers to act on, if action chosen first
 N X,Y,DIR,MAX
 S MAX=$G(VALMCNT) Q:MAX'>0 ""
 I ACTION="edit" W !!,"Enter item number to edit or press enter to create a new entry"
 S DIR(0)="LAO^1:"_MAX,DIR("A")="Select item(s): "
 S DIR("?")="Enter the items you wish to "_ACTION_", as a range or list of numbers."_$S(ACTION="edit":" Press enter to create a NEW entry",1:"")
 D ^DIR S:$D(DTOUT) Y="^"
 I $D(Y(1)) W !,">>>Too many entries selected, try using smaller ranges" H 2 S Y="^"
 Q Y
 ;
 ;
CANDEL(FILE) ;Determines if event or rule can be deleted
 N DEL,EVENT,LIST,I,J
 S DEL=1
 S EVENT=$O(^XTV(8989.51,"B","ORWDX WRITE ORDERS EVENT LIST",0))
 S LIST=$O(^XTV(8989.51,"B","OREVNT COMMON LIST",0))
 I FILE=100.5 D
 .I $O(^ORE(100.2,"E",DA,0)) W !,"< Can't delete this event because file 100.2 is pointing to it >  " S DEL=0 Q
 .I $D(^ORD(100.5,"DAD",DA)) W !,"< Can't delete parent events that have children >  " S DEL=0 Q
 .S FND=0
 .K LST D ENVAL^XPAR(.LST,LIST)
 .S I="" F  S I=$O(LST(I)) Q:I=""!(FND)  D
 ..S J="" F  S J=$O(LST(I,J)) Q:J=""!(FND)  I LST(I,J)=DA S FND=1
 .I 'FND K LST D ENVAL^XPAR(.LST,EVENT) D
 ..S I="" F  S I=$O(LST(I)) Q:I=""!(FND)  D
 ...S J="" F  S J=$O(LST(I,J)) Q:J=""!(FND)  I DA=J S FND=1
 .I FND W !,"< Can't delete event because parameters are pointing to it >  " S DEL=0
 ;
 I FILE=100.6 D
 .I $O(^ORE(100.2,"DC",DA,0)) S DEL=0 W !,"< Can't delete this rule because file 100.2 is pointing to it >  " Q
 ;
 Q 'DEL  ;Reverse value of DEL so that $T is set correctly for fileman to determine if entry can be deleted.  Code is in ^DD(file#,.01,"DEL",.01,0)
 ;
ASKOBS() ;Function to determine if 'except from observation' field should be asked.
 N ANS
 S ANS=1
 I ETYPE="D" I $D(^ORD(100.6,DA,3,"B",12))!($D(^ORD(100.6,DA,3,"B",38))) S ANS=0 ;Don't ask if MAS MOVEMENT TYPE is 12 (death) or 38 (death with autopsy)
 I ETYPE="T" I '$D(^ORD(100.6,DA,3,"B",14)) S ANS=0 ;If MAS MOVEMENT TYPE doesn't contain FROM ASIH (VAH) when type is transfer then don't ask
 Q ANS
 ;
DELMUL(FILE,IEN,LOC) ;Delete multiple entries for entry IEN in file FILE stored at location LOC
 N I,DR,DIE,DA,DIC,GLOB,Y,DQ,DP,DL,DM,DI,DK
 S GLOB="^ORD("_FILE_","_IEN_","
 S I=0 F  S I=$O(@(GLOB_LOC_","_I_")")) Q:'+I  S DA(1)=IEN,DA=I,DR=".01///@",DIE="^ORD("_FILE_",DA(1),"_LOC_"," D ^DIE
 Q
 ;
RELEVNTS(DA) ;Check to see if release event is currently being pointed to
 N DFN,EVENT
 S (DFN,EVENT)=0
 F  S DFN=$O(^ORE(100.2,"AE",DFN)) Q:'+DFN  I $D(^ORE(100.2,"AE",DFN,DA)) S EVENT=1 Q
 Q EVENT
