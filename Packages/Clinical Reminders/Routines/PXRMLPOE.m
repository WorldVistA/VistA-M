PXRMLPOE ;SLC/PJH,PKR - Build OE/RR Team from Patient List ;02/21/2014
 ;;2.0;CLINICAL REMINDERS;**4,24,26**;Feb 04, 2005;Build 404
 ; 
 ; Called from PXRM PATIENT LIST OE/RR protocol
ASK(PLIEN,OPT) ;Verify patient list name
 N DIR,X,Y,TEXT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")=OPT_" patient list "_$P($G(^PXRMXP(810.5,PLIEN,0)),U)_"?: "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I $E(Y(0))="N" S DUOUT=1 Q
 Q
 ;
LOCK(LIST) ;Lock the list
 L +^PXRMXP(100.21,LIST):DILOCKTM
 E  W !!?5,"Another user is using this OE/RR team list" S DUOUT=1
 Q
 ;
OERR(IENO) ;Copy patient list to OE/RR Team
 ;Check if OK to copy
 D ASK(IENO,"Copy") Q:$D(DUOUT)!$D(DTOUT)
 ;
 N IENN,NNAME,ONAME,TEXT,X,Y
 ;
 ;Select OE/RR Team to copy to
 S TEXT="Select OE/RR TEAM name to copy to: "
 D OTEAM(.IENN,.NNAME,TEXT) Q:$D(DUOUT)!$D(DTOUT)  Q:'IENN
 ;
 S ONAME=$P($G(^PXRMXP(810.5,IENO,0)),U)
 ;
 ;Update OE/RR Team list
 D UPDLST(IENO,IENN,NNAME)
 Q
 ;
OK ;Option to overwrite existing list
 N X,Y,TEXT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")="Overwrite existing OE/RR Team list: "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMLCR(1)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I $E(Y(0))="N" S DUOUT=1 Q
 Q
 ;
OTEAM(LIST,NAME,TEXT) ;Select OERR/Team
 N X,Y,DIC,DIE,DR,DLAYGO
 W !
 W !,"To overwrite an existing list you must be the creator of the list and"
 W !,"the OE/RR team list must be defined as a Team List."
OT1 S DIC=100.21,DLAYGO=DIC,DIC(0)="QAEMZL"
 S DIC("S")="I $P($G(^(0)),U,2)=""TM"",$P($G(^(0)),U,5)=DUZ"
 S DIC("A")=TEXT
 W !
 D ^DIC
 I X="" W !,"An OE/RR Team name must be entered" G OT1
 I X=(U_U) S DTOUT=1
 I Y=-1 S DUOUT=1
 I $D(DTOUT)!$D(DUOUT) Q
 ;
 ;Check if OK to overwrite
 I $P(Y,U,3)'=1  D  Q:$D(DTOUT)  G:$D(DUOUT) OT1
 .D OK
 ;Return list ien
 S LIST=$P(Y,U),NAME=$P(Y,U,2)
 Q
 ;
UPDLST(IENO,LIST,NAME) ;Update patient list
 N CNT,DA,DFN,DIK,DUOUT,FDA,FDAIEN,IEN,MSG,SUB,TEMP
 ;Lock patient list
 D LOCK(LIST) Q:$D(DUOUT)
 ;
 ;Clear existing list
 S SUB=0
 F  S SUB=$O(^OR(100.21,LIST,10,SUB)) Q:'SUB  D
 . S DA=SUB,DA(1)=LIST,DIK="^OR(100.21,"_DA(1)_",10,"
 . D ^DIK
 ;
 ;DBIA #4561 covers putting data into OE/RR list.
 ;Create the stub in file #100.21
 W !,"Updating "_NAME
 S FDA(100.21,"?1,",.01)=NAME
 S FDA(100.21,"?1,",.1)=$$UP^XLFSTR(NAME)
 S FDA(100.21,"?1,",1)="TM"
 S FDA(100.21,"?1,",1.6)=DUZ
 S FDA(100.21,"?1,",1.65)=$$NOW^XLFDT
 S FDA(100.21,"?1,",11)="0"
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 ;Error
 I $D(MSG) D  Q
 . N TEXT
 . S TEXT(1)="The patient list copy failed."
 . S TEXT(2)="Examine the following error message for the reason."
 . S TEXT(3)=""
 . D MES^XPDUTL(.TEXT)
 . D AWRITE^PXRMUTIL("MSG")
 . W ! H 3
 . D UNLOCK(LIST)
 ;Do a direct copy of the patients.
 S (CNT,SUB)=0,IEN=FDAIEN(1)
 F  S SUB=$O(^PXRMXP(810.5,IENO,30,SUB)) Q:'SUB  D
 . S DFN=$P($G(^PXRMXP(810.5,IENO,30,SUB,0)),U,1) Q:'DFN
 . S CNT=CNT+1
 . S TEMP=DFN_";DPT("
 . S ^OR(100.21,IEN,10,CNT,0)=TEMP
 . S ^OR(100.21,IEN,10,"B",TEMP,CNT)=""
 . S ^OR(100.21,"AB",TEMP,IEN,CNT)=""
  S ^OR(100.21,IEN,10,0)="^100.2101AV"_U_CNT_U_CNT
 ;Unlock patient list
 D UNLOCK(LIST)
 W !!,"Completed copy of patient list '"_ONAME_"'"
 W !,"into OE/RR Team '"_NNAME_"'",! H 3
 Q
 ;
UNLOCK(LIST) ;Unlock the list
 L -^PXRMXP(100.21,LIST)
 Q
 ;
