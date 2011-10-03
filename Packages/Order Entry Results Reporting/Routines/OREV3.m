OREV3 ;SLC/DAN Event delayed orders set up continued ;12/23/02  13:28
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,165**;Dec 17, 1997
 ;DBIA reference section
 ;10116 - VALM1
 ;2324  - USRLM
 ;10009 - DICN
 ;2056  - DIQ
 ;2336  - XPAREDIT
 ;2263  - XPAR
 ;10006 - DIC
 ;10026 - DIR
 ;10018 - DIE
 ;10103 - XLFDT
 ;
ACE ;Add child events to existing events
 N DIC,ORJ,ORTMP,DA,Y,ORGLOB,ADD
 D FULL^VALM1 ;get full screen
 S VALMBCK="R"
 S (DIC,ORGLOB)="^ORD(100.5,"
 I $G(ORNMBR)="" S ORNMBR=$$ORDERS^OREV1("add child events to") Q:ORNMBR="^"  ;If action selected before items, get items
 I $G(ORNMBR)="" D  Q
 .S DIC(0)="AEMQ",DIC("S")="I '+$P($G(^(0)),U,12)" ;Screen children from being parents
 .D ^DIC Q:Y=-1  S DA=+Y
 .Q:'$$PARENTOK^OREV4
 .L +@(ORGLOB_DA_")"):1 I '$T W !!,"This entry is being edited by another user." H 3 Q
 .W !!,"Adding children to parent ",$P(^ORD(100.5,DA,0),U)
 .D ADDCHLD(DA,.ADD) ;Add child to selected event
 .I $G(ADD) D AUDIT^OREV(DA,"E"),CHKPRM^OREV4 ;If child event added update audit history and check parameters
 .L -@(ORGLOB_DA_")")
 F ORJ=1:1:$L(ORNMBR,",")-1 S ORTMP=$P(ORNMBR,",",ORJ),DA=$O(^TMP("OREDO",$J,"IDX",ORTMP,0)) D
 .I $P($G(^ORD(100.5,DA,0)),U,12) W !!,"You may not add child events to events that are already children.",!,$P($G(^ORD(100.5,DA,0)),U)," - SKIPPED!",! H 3 Q
 .Q:'$$PARENTOK^OREV4
 .L +@(ORGLOB_DA_")"):1 I '$T W !!,"This entry is being edited by another user." H 3 Q  ;Lock global
 .W !!,"Adding children to parent ",$P(^ORD(100.5,DA,0),U)
 .D ADDCHLD(DA,.ADD) ;Add child to selected event
 .I $G(ADD) D AUDIT^OREV(DA,"E"),CHKPRM^OREV4 ;If child event added update audit history and check paramters
 .L -@(ORGLOB_DA_")") ;Unlock global
 Q
 ;
ADDCHLD(ENTRY,ADD) ;Add child(ren) to event
 ;ENTRY - Internal entry number of event that will be the parent
 ;ADD - Will be set to 1 if a child is successfully added
 ;
 N DIR,Y,DIC,DIE,DA,DR,DIRUT,X,NEW
 F  D  Q:$G(DIRUT)
 .W !
 .S DIR(0)="FAO^3:50"
 .S DIR("A")="OE/RR CHILD RELEASE EVENT NAME: "
 .S DIR("?")="Enter the name of the child event you wish to create.  It must be free text between 3 and 50 characters and be unique."
 .D ^DIR
 .Q:$G(DIRUT)
 .I $D(^ORD(100.5,"B",Y)) W !,"There is already an entry with this name.  Please select a different name." Q
 .S DIC="^ORD(100.5,",DIC(0)="",X=Y D FILE^DICN ;Add child to file
 .Q:Y=-1
 .S DIE=DIC
 .S DR="[OREV CHILD EVENT"
 .S DA=+Y
 .S NEW=1
 .D ^DIE
 .Q:'$G(DA)  ;Child event deleted, stop processing
 .D AUDIT^OREV(DA,"N") ;Update audit history for child
 .S DR="1///"_$$NOW^XLFDT_";14///`"_ENTRY D ^DIE ;Add parent pointer to child entry
 .S ADD=1 ;Indicate that child was added
 .W !!,"Enter next child name or press enter to stop adding children."
 Q
 ;
UPDTCHLD(PARENT,CDT) ;Update children to inactive when parent is inactivated
 N DA,DIE,CHILD,DR,DONE
 S DONE=0
 S CHILD="" F  S CHILD=$O(^ORD(100.5,"DAD",PARENT,CHILD)) Q:'+CHILD  D
 .I 'DONE W !!,"Updating children..." S DONE=1
 .Q:$G(^ORD(100.5,CHILD,1))  ;Child is already inactive
 .S DA=CHILD
 .S DIE="^ORD(100.5,"
 .S DR="1///"_CDT
 .D ^DIE ;Sets inactivated date/time for child
 .;
 .S DA(1)=DA
 .S DA=$O(^ORD(100.5,DA(1),2,"ACT",0))
 .S DIE="^ORD(100.5,DA(1),2,"
 .S DR="1///"_CDT
 .D ^DIE ;Update inactivated date/time of activation multiple for child
 Q
 ;
PARAM ;Allow user to edit event delayed order parameters
 N DIR,Y
 S VALMBCK="R" D FULL^VALM1
 F  D  Q:'Y
 .S DIR(0)="SO^1:Write orders list by event;2:Default release event;3:Common release event list;4:Manual release controlled by;5:Set manual release parameter;6:Exclude display groups from copy"
 .S DIR("A")="Select parameter to edit"
 .D ^DIR Q:'Y
 .I Y=2!(Y=3) D:Y=2 SETDFLT() D:Y=3 EVENTLST Q
 .D EDITPAR^XPAREDIT($S(Y=1:"ORWDX WRITE ORDERS EVENT LIST",Y=4:"OREVNT MANUAL RELEASE CONTROL",Y=5:"OREVNT MANUAL RELEASE",1:"OREVNT EXCLUDE DGRP"))
 Q
 ;
CANREL() ;Function to determine if delayed order can be manually released
 N ORMAN,CAN
 S ORMAN=$$GET^XPAR("ALL","OREVNT MANUAL RELEASE CONTROL")
 S:ORMAN="" ORMAN="K" ;If no value found, default to checking for keys
 I ORMAN="K",'$$KEY Q 0
 I ORMAN="P",'$$MANPARAM Q 0
 I ORMAN="B" D  Q:$G(CAN)=0 0
 .I $$KEY,$$MANPARAM=0 S CAN=0 Q
 .I '$$KEY,'$$MANPARAM S CAN=0
 Q 1
 ;
KEY() ;Check for ORES or ORELSE keys
 I '$D(^XUSEC("ORES",DUZ))&('$D(^XUSEC("ORELSE",DUZ))) Q 0
 Q 1
 ;
MANPARAM() ;Check setting of OREVNT MANUAL RELEASE parameter
 N LST,I,FND,PRM,X,Y,DIC,EXP,STR,VAL,FNDNO
 S DIC=8989.51,DIC(0)="MX",X="OREVNT MANUAL RELEASE" D ^DIC
 I Y=-1 Q 0  ;Parameter not found so quit
 S PRM=+Y
 ;Check USER level
 S VAL=$$GET^XPAR("USR",PRM) I VAL'="" Q VAL
 ;Check USER CLASS
 D WHATIS^USRLM(DUZ,"LST")
 I $O(LST(0))'="" D  I FND'="" Q FND
 .S FND=""
 .S I=0 F  S I=$O(LST(I)) Q:I=""!(FND)  S EXP=+$P(LST(I),U,5),STR=+$P(LST(I),U,4) I 'EXP!(EXP'<DT) I 'STR!(STR'>DT) S FND=$G(^XTV(8989.5,"AC",PRM,$P(LST(I),U)_";USR(8930,",1)) I FND=0 S FNDNO=1
 .I 'FND,$G(FNDNO) S FND=0
 ;Check OE/RR Teams
 K LST,FNDNO
 D TEAMPR^ORQPTQ1(.LST,DUZ)
 I +$G(LST(1)) D  I FND'="" Q FND
 .S FND=""
 .S I=0 F  S I=$O(LST(I)) Q:I=""!(FND)  S FND=$G(^XTV(8989.5,"AC",PRM,$P(LST(I),U)_";OR(100.21,",1)) S:FND=0 FNDNO=1
 .I 'FND,$G(FNDNO) S FND=0
 ;Check location
 I +$G(LOC) S VAL=$$GET^XPAR("LOC.`"_+$G(LOC),PRM) I VAL'="" Q VAL
 ;Check Service
 S VAL=$G(^XTV(8989.5,"AC",PRM,+$$GET1^DIQ(200,DUZ,29,"I")_";DIC(49,",1)) I VAL'="" Q VAL
 ;Check Division and System
 S VAL=$$GET^XPAR("DIV^SYS",PRM) I VAL'="" Q VAL
 Q ""
 ;
DEFHELP ;Provide detailed help for setting default treating specialty
 N DEF,DEFTS,DEFTSNM
 I $D(^ORD(100.5,DA(1),"TS","DEF")) D  Q
 .S DEF=$O(^ORD(100.5,DA(1),"TS","DEF",1,0))
 .I DEF=DA Q  ;Default is current entry
 .S DEFTS=$P(^ORD(100.5,DA(1),"TS",DEF,0),U)
 .S DEFTSNM=$$GET1^DIQ(45.7,DEFTS_",",.01)
 .W !?5,"You may not set this treating specialty as the default because"
 .W !?5,DEFTSNM," is already set as the default."
 .W !?5,"If you would like to change the default you must first delete the",!?5,"default designation from the above mentioned treating specialty.",!
 ;
 W !?5,"Currently there is no default treating specialty set for this event.",!
 Q
 ;
EVENTLST ;Allow user to edit OREVNT COMMON LIST parameter and set a default for that list
 N DIC,X,Y,PRM,ORENT
 S DIC=8989.51,DIC(0)="MX",X="OREVNT COMMON LIST" D ^DIC
 Q:Y=-1  ;Parameter doesn't exist
 S PRM=Y
 D GETENT^XPAREDIT(.ORENT,PRM)
 Q:ORENT=""  ;Nothing selected
 D EDIT^XPAREDIT(ORENT,PRM) ;edit selected entity
 Q:$G(DUOUT)!($G(DTOUT))  ;User ^ or timed out
 I '$D(^XTV(8989.5,"AC",+PRM,ORENT)) Q  ;No value stored for entity don't ask for default
 D SETDFLT(ORENT,PRM)
 Q
 ;
SETDFLT(ORENT,PRM) ;Set default for given list
 N DIC,Y,X,PRMD,DEF,I,J,DIR,FND,ORLST
 I $G(PRM)="" S DIC=8989.51,DIC(0)="MX",X="OREVNT COMMON LIST" D ^DIC Q:Y=-1  S PRM=Y
 S DIC=8989.51,DIC(0)="MX",X="OREVNT DEFAULT" D ^DIC
 Q:Y=-1  ;Parameter doesn't exist
 S PRMD=Y
 I $G(ORENT)="" D GETENT^XPAREDIT(.ORENT,PRMD) Q:ORENT=""  ;Nothing selected
 D GETLST^XPAR(.ORLST,ORENT,+PRM)
 I ORLST=0 W !!,"No common list is defined for this entity and therefore a default",!,"may not be set.  Create a common list first.",! Q
 S DEF=$$GET^XPAR(ORENT,+PRMD,,"B") F I=1:1:ORLST I $P(ORLST(I),U,2)=+DEF S FND=1
 I '$G(FND) S DEF="" D EN^XPAR(ORENT,+PRMD,,"@") ;Delete default if no longer in list
 W !!,$S(DEF'="":"Current DEFAULT is "_$P(DEF,U,2)_$S($G(^ORD(100.5,+DEF,1)):" (*INACTIVE*)",1:""),1:"No DEFAULT has been set yet.")
 W ! F J=1:1:ORLST W !,J,") ",$P(^ORD(100.5,$P(ORLST(J),U,2),0),U),$S($G(^(1)):" (*INACTIVE*)",1:"")
 I DEF'="" S ORLST=ORLST+1 W !!,ORLST,") DELETE CURRENT DEFAULT"
 W ! S DIR(0)="NO^1:"_ORLST,DIR("A")="Select default release event"_$S(DEF'="":" or delete current event",1:"") D ^DIR
 I 'Y Q  ;No selection made
 I Y=ORLST&(DEF'="") D EN^XPAR(ORENT,+PRMD,,"@") W !,"Default deleted" Q
 I $G(^ORD(100.5,$P(ORLST(Y),U,2),1)) W !,"You cannot set an inactive event as the default." Q  ;No inactive defaults can be set
 ;write updated parameter
 D EN^XPAR(ORENT,+PRMD,,"`"_$P(ORLST(Y),"^",2))
 Q
 ;
GETLST(LST) ;Return common list and default event
 N I,FND,PRM,X,Y,DIC,TLST,ORCLST,ENT,EXP,STR
 S DIC=8989.51,DIC(0)="MX",X="OREVNT COMMON LIST" D ^DIC
 I Y=-1 Q  ;Parameter not found so quit
 S PRM=+Y
 D ENVAL^XPAR(.ORCLST,PRM) Q:ORCLST=0  ;Nothing defined at any level
 ;Check USER level
 S ENT=DUZ_";VA(200," I $D(ORCLST(ENT)) D RETLST Q
 ;Check USER CLASS
 D WHATIS^USRLM(DUZ,"TLST")
 I $O(TLST(0))'="" D  I FND Q
 .S FND=0
 .S I=0 F  S I=$O(TLST(I)) Q:I=""!(FND)  S ENT=$P(TLST(I),U)_";USR(8930," S EXP=+$P(TLST(I),U,5),STR=+$P(TLST(I),U,4) I 'EXP!(EXP'<DT) I 'STR!(STR'>DT) I $D(ORCLST(ENT)) D RETLST S FND=1
 ;Check OE/RR Teams
 K TLST
 D TEAMPR^ORQPTQ1(.TLST,DUZ)
 I +$G(TLST(1)) D  I FND Q
 .S FND=0
 .S I=0 F  S I=$O(TLST(I)) Q:I=""!(FND)  S ENT=$P(TLST(I),U)_"OR(100.21," I $D(ORCLST(ENT)) D RETLST S FND=1
 ;Check location
 I +$G(LOC) S ENT=+LOC_";SC(" I $D(ORCLST(ENT)) D RETLST Q
 ;Check Service
 S ENT=$$GET1^DIQ(200,DUZ,29,"I")_";DIC(49,"
 I $D(ORCLST(ENT)) D RETLST Q
 ;Check Division 
 S ENT=DUZ(2)_";DIC(4," I $D(ORCLST(ENT)) D RETLST Q
 Q
 ;
RETLST ;Sets up list for entity
 N DEF,Y,DIC,I,CNT,X
 S DIC=8989.51,DIC(0)="MQ",X="OREVNT DEFAULT" D ^DIC
 Q:'Y  ;Stop if parameter doesn't exist
 S CNT=1
 S DEF=$$GET^XPAR(ENT,+Y,,"B")
 S I=0 F  S I=$O(ORCLST(ENT,I)) Q:'+I  I '$G(^ORD(100.5,ORCLST(ENT,I),1))&('$D(^ORD(100.5,"DAD",ORCLST(ENT,I)))) S LST(CNT)=ORCLST(ENT,I) S:ORCLST(ENT,I)=+DEF $P(LST(CNT),U,2)=1 S CNT=CNT+1
 Q
