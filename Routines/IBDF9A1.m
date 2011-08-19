IBDF9A1 ;ALB/CJM - ENCOUNTER FORM - (create,edit,delete selection list - continued) ;FEB 1,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
NEWLIST ;creates a new list
 ;expects IBBLK to be defined
 N IBLIST,IBLEN,IBP,IBRTN,NAME,IBDELETE,IBDYN,IBINPUT,IBDFLTF,IBDFLTB,IBDFLTL
 S (IBDFLTF,IBDFLTB,IBDFLTL,IBOLD,IBLIST)=0,VALMBCK="R"
 D FULL^VALM1
 S IBRTN=$$RTN^IBDF9A Q:'IBRTN
 S IBDFLTF=$$DFLTS^IBDFU5 D:IBDFLTF
 .S IBDFLTB=0 F  S IBDFLTB=$O(^IBE(357.1,"C",IBDFLTF,IBDFLTB)) Q:'IBDFLTB  D  Q:IBDFLTL
 ..S IBDFLTL=0 F  S IBDFLTL=$O(^IBE(357.2,"C",IBDFLTB,IBDFLTL)) Q:'IBDFLTL  Q:$P($G(^IBE(357.2,IBDFLTL,0)),"^",11)=IBRTN
 I IBDFLTL D  Q:IBLIST
 .S IBLIST=$$COPYLIST^IBDFU2(IBDFLTL,IBDFLTB,IBBLK,357.2,357.2)
 .Q:'IBLIST
 .K DIE,DA,DR S DIE=357.2,DA=IBLIST,DR="[IBDF POSITION/SIZE COLUMNS]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .S VALMBCK="R" D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 S NAME=$$NEWNAME^IBDF9A Q:NAME=-1
 K DIC,DIE,DD,DO,DINUM,DA
 N DLAYGO
 S DIC="^IBE(357.2,",DIC(0)="FL",X=NAME,DLAYGO=357.2
 D FILE^DICN K DIC,DA
 S IBLIST=$S(+Y<0:"",1:+Y)
 I 'IBLIST D
 .W !,"Unable to create a new selection list!" D PAUSE^IBDFU5
 I IBLIST D
 .D DLISTCNT^IBDFU3(IBLIST,357.2) ;deletes anything that may have been left lying around that now points to IBLIST
 .K DIE,DA,DR S DIE=357.2,DA=IBLIST,DR="[IBDF EDIT SELECTION LIST]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .I IBDELETE K DA S DIK="^IBE(357.2,",DA=IBLIST D ^DIK K DIK,DA
 .I IBLIST,'IBDELETE D ADDGROUP("BLANK",0)
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 S VALMBCK="R"
 Q
ADDGROUP(NAME,ORDER) ;adds a group to the selection list=IBLIST
 N GROUP
 K DIC,DIE,DD,DO,DINUM,DA
 N DLAYGO
 S DIC="^IBE(357.4,",DIC(0)="FL",X=NAME,DLAYGO=357.4
 D FILE^DICN K DIC,DA
 S GROUP=$S(+Y<0:"",1:+Y)
 I GROUP D
 .S NODE=$G(^IBE(357.4,GROUP,0)) S $P(NODE,"^",2)=ORDER,$P(NODE,"^",3)=IBLIST S ^IBE(357.4,GROUP,0)=NODE
 .S DIK="^IBE(357.4,",DA=GROUP D IX1^DIK K DIK,DA
 Q
 ;
FORMAT ;allows the user to format all of the selections on the list in mass
 ;
 ;
 ;TYPE = type of formating - U=upper case,L=lower case,C=capitalize
 ;SUBCOL is the subcolumn to format
 ;
 N TYPE,SUBCOL,SLCTN
 ;
 ;ask for the subcolumn to format
 S SUBCOL=$$SUBCOL
 ;
 ;ask for the type of fomatting
 S TYPE=$S(SUBCOL:$$TYPE,1:"")
 ;
 ;find all the sections to be formatted and do so
 I TYPE'="",SUBCOL S SLCTN=0 F  S SLCTN=$O(^IBE(357.3,"C",IBLIST,SLCTN)) Q:'SLCTN  D:$P($G(^IBE(357.3,SLCTN,0)),"^",3)=IBLIST CHANGE(SLCTN,SUBCOL,TYPE)
 ;
 S VALMBCK="R"
 Q
 ;
FORMAT2 ;allows the user to format all of the selections in the group in mass
 ;
 ;
 ;TYPE = type of formating - U=upper case,L=lower case,C=capitalize
 ;SUBCOL is the subcolumn to format
 ;
 N TYPE,SUBCOL,SLCTN
 ;
 ;ask for the subcolumn to format
 S SUBCOL=$$SUBCOL
 ;
 ;ask forthe type of fomatting
 S TYPE=$S(SUBCOL:$$TYPE,1:"")
 ;
 ;find all the sections to be formatted and do so
 I TYPE'="",SUBCOL S SLCTN=0 F  S SLCTN=$O(^IBE(357.3,"D",IBGRP,SLCTN)) Q:'SLCTN  D:$P($G(^IBE(357.3,SLCTN,0)),"^",4)=IBGRP CHANGE(SLCTN,SUBCOL,TYPE)
 ;
 D IDXSLCTN^IBDF4
 S VALMBCK="R"
 Q
 ;
TYPE() ;ask the user what type of formatting
 N TYPE S TYPE=""
 K DIR S DIR(0)="SOB^UPPERCASE:U;LOWERCASE:L;CAPITALIZE:C"
 S DIR("A")="Select the type of formatting",DIR("B")="C"
 D ^DIR K DIR
 I '$D(DIRUT),Y'=-1 S TYPE=Y
 Q $E(TYPE,1)
 ;
CHANGE(SLCTN,SUBCOL,TYPE) ;
 ;
 N DA,NODE,STR
 S DA=$O(^IBE(357.3,SLCTN,1,"B",SUBCOL,0))
 Q:'DA
 S NODE=$G(^IBE(357.3,SLCTN,1,DA,0))
 S STR=$P(NODE,"^",2)
 D:$L(STR)
 .I TYPE="U" S STR=$$UP^XLFSTR(STR)
 .I TYPE="L" S STR=$$LOW^XLFSTR(STR)
 .I TYPE="C" S STR=$$CAPS(STR)
 .S $P(^IBE(357.3,SLCTN,1,DA,0),"^",2)=STR
 Q
 ;
CAPS(STR) ;returns STR with each word in it capitalized
 N FIRST,I,CHAR,LEN
 S FIRST=1,LEN=$L(STR)
 F I=1:1 S CHAR=$E(STR,I) Q:CHAR=""  D
 .I CHAR?1A,FIRST D
 ..S FIRST=0,CHAR=$$UP^XLFSTR(CHAR)
 .E  I CHAR?1A D
 ..S CHAR=$$LOW^XLFSTR(CHAR)
 .E  S FIRST=1
 .S STR=$E(STR,1,I-1)_CHAR_$E(STR,I+1,LEN)
 Q STR
 ;
SUBCOL() ;ask what subcolumn to format
 ;SCLIST - used to record the subcolumns that can be formated - each digit will signify a subcolum
 ;
 N SCLIST,NODE,SUBCOL,ANS
 ;first get the list of subcolumns that can be formatted
 S SCLIST="",SUBCOL=0
 F  S SUBCOL=$O(IBLIST("SCTYPE",SUBCOL)) Q:'SUBCOL  I $G(IBLIST("SCW",SUBCOL)),IBLIST("SCTYPE",SUBCOL)=1,IBLIST("SCEDITABLE",SUBCOL) S SCLIST=SCLIST_","_SUBCOL
 ;if there is at most one subcolumn that can be edited return that
 I $L(SCLIST)<3 Q $E(SCLIST,2)
 ;
 ;now ask what subcolumn to format
AGAIN W !,"What subcolumn do you want formated? Choose from (",$E(SCLIST,2,10),"): "
 R ANS:DTIME
 I '$T!(ANS["^") Q ""
 I ANS?1N,SCLIST[ANS Q ANS
 G AGAIN
 Q ANS
