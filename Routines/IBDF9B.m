IBDF9B ;ALB/CJM - ENCOUNTER FORM - (edit,delete,add data fields) ;FEB 1,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
FIELD ;Create, Edit, or Delete a data field from the form
 S VALMBCK="R"
 D FULL^VALM1
 K DIR S DIR("?",1)="A DISPLAY FIELD outputs data from VISTA, MULTIPLE CHOICE FIELDS",DIR("?")="and HAND PRINT FIELDS allow input of data, LABELS are for fixed text fields"
 W !,DIR("?",1),!,DIR("?"),!!
 S DIR("B")="D",DIR(0)="SB^D:Display Field;M:Multiple Choice Field;H:Hand Print;L:Label Only",DIR("A")="Edit fields for: [D]isplay,  [M]ultiple Choice, [H]and Print, [L]abel only"
 D ^DIR K DIR I $D(DIRUT)!(Y<0) Q
 I Y="M" D MFIELD^IBDF9B2 Q
 I Y="H" D HFIELD^IBDF9B4 Q
 I Y="L" D LABELS^IBDF9B3 Q
 ;
 N IBVALMBG,QUIT
 S QUIT=0
 S IBVALMBG=VALMBG
 S VALMBCK="R"
 ;
 F  D  Q:QUIT
 .D FULL^VALM1
 .K DIR S DIR("?",1)="You can Create, Edit, or Delete a data field, Shift all of the data fields",DIR("?")="within a range up or down, or List their locations ."
 .W !!,DIR("?",1),!,DIR("?"),!
 .S DIR("B")="C",DIR(0)="SB^C:Create;E:Edit;D:Delete;S:Shift;L:List;Q:Quit",DIR("A")="[C]reate,  [D]elete,  [E]dit,   [S]hift,  [L]ocations,  [Q]uit"
 .D ^DIR K DIR I $D(DIRUT)!(Y<0) S QUIT=1 Q
 .I Y="Q" S QUIT=1 Q
 .D @$S(Y="C":"NEWFLD",Y="E":"EDITFLD",Y="D":"DLTFLD",Y="S":"SHIFT",Y="L":"^IBDF9B1",1:"")
 .D RE^VALM4
 S VALMBCK="R",VALMBG=IBVALMBG
 Q
SHIFT ;expects IBBLK to be defined - shifts all fields within range supplied by user
 D SHIFT^IBDF10("D")
 D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
EDITFLD ;expects IBBLK to be defined
 N IBFIELD,RTN,NODE
 N IBMF,IBWP,IBLIST,IBI,IBOLD,IBX,IBY,IBW,IBP,IBLEN,IBDELETE ;these are used in the input template
 ;IBMF=1 if display interface returns records,IBWP=1 display interface returns a word processing field
 D SELECT
 I IBFIELD D
 .D RE^VALM4
 .S (IBMF,IBLIST,IBWP)=0,IBOLD=1,(IBX,IBY)=""
 .S RTN=$P($G(^IBE(357.5,IBFIELD,0)),"^",3)
 .I RTN D DATATYPE(RTN)
 .K DR,DIE,DA S DIE=357.5,DA=IBFIELD,DR="[IBDF EDIT DATA FIELD]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
SELECT ;
 S IBFIELD=0
 Q:'$G(IBBLK)
 I '$O(^IBE(357.5,"C",IBBLK,0)) W !,"There is no data field!" D PAUSE^IBDFU5 Q
AGAIN K DIC S DIC="^IBE(357.5,",DIC(0)="EFQ",DIC("B")="",D="C",X=IBBLK
 S DIC("S")="I $P(^(0),U,2)=IBBLK,+$P(^(0),U,3)>0"
 D IX^DIC K DIC
 S:+Y>0 IBFIELD=+Y
 I 'IBFIELD,'$D(DTOUT),'$D(DUOUT) K DIR S DIR(0)="Y",DIR("A")="No data field selected! Try again",DIR("B")="YES" D ^DIR K DIR I '$D(DIRUT),Y=1 G AGAIN
 Q
DLTFLD ;expects IBBLK to be defined
 N IBFIELD
 D SELECT
 I IBFIELD D
 .Q:'$$RUSURE^IBDFU5($P($G(^IBE(357.5,IBFIELD,0)),"^"))
 .D DLTFLD^IBDFU3(357.5,IBBLK,IBFIELD)
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
NEWFLD ;adds a new field, expects IBBLK to be defined
 N NAME,FIELD,NODE,IBRTN,DLAYGO
 N IBX,IBY,IBLIST,IBLEN,IBWP,IBMF,IBW,IBP,IBDELETE,IBOLD ;these are used in the input template
 S NAME=$$NEWNAME Q:NAME=-1
 S IBRTN=$$LOOKUP Q:'IBRTN
 S IBOLD=0,(IBX,IBY)=""
 K DIC,DIE,DD,DO,DINUM S DIC="^IBE(357.5,",DIC(0)="FL",X=NAME,DLAYGO=357.5
 D FILE^DICN K DIC,DIE,DA
 S FIELD=$S(+Y<0:"",1:+Y)
 I 'FIELD D
 .W !,"Unable to create a new data field!" D PAUSE^IBDFU5
 I FIELD D
 .S IBDELETE=1
 .K DIE,DA,DR S DIE=357.5,DA=FIELD,DR="[IBDF EDIT DATA FIELD]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA,DIC
 .I IBDELETE K DA S DIK="^IBE(357.5,",DA=FIELD D ^DIK K DIK,DA Q
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
NEWNAME() ;
 K DIR S DIR(0)="357.5,.01A",DIR("A")="New Field Name: ",DIR("B")=""
 D ^DIR K DIR I $D(DIRUT) Q -1
 Q Y
 ;
DATATYPE(RTN) ;
 ;INPUT - RTN is a ptr to the package interface file
 ;
 ;OUTPUT - IBLEN() stores the lengths of the pieces of the record returned by the package interface
 ;IBLIST=1 if list,IBMF=1 if record, IBWP=1 if word processing
 ;
 N IBSUB,NODE,DATATYPE
 S (IBMF,IBWP,IBLIST)=0
 Q:'$G(RTN)
 S DATATYPE=$P($G(^IBE(357.6,RTN,0)),"^",7) S:DATATYPE=5 IBWP=1 S:(DATATYPE=2)!(DATATYPE=4) IBMF=1 S:(DATATYPE=3)!(DATATYPE=4) IBLIST=1
 I 'IBWP D
 .N IEN
 .S IEN=0 F  S IEN=$O(^IBE(357.6,RTN,15,"C",IEN)) Q:'IEN  S NODE=$G(^IBE(357.6,RTN,15,IEN,0)) I $P(NODE,"^",3) S IBLEN($P(NODE,"^",3))=+$P(NODE,"^",2)
 .S IBLEN(1)=$P($G(^IBE(357.6,RTN,2)),"^",2)
 Q
 ;
LOOKUP() ;does a lookup on the package interface file using the E cross-reference, which uses the name with the prefix=namespace removed
 K DIC S DIC("S")="I $P(^(0),U,6)=2,$P(^(0),U,9)=1"
 S DIC="^IBE(357.6,",DIC(0)="MQEA",D="E^D^B",DIC("A")="Select the TYPE OF DATA that should be displayed:" D MIX^DIC1 K DIC,DA,D
 Q $S((Y<0)!$D(DTOUT)!$D(DUOUT):0,1:+Y)
 ;
