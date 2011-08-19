PXRMLPOE ; SLC/PJH - Build OE/RR Team from Patient List;07/08/2002
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ; 
 ; Called from PXRM PATIENT LIST OE/RR protocol
 ;
OERR(IENO) ;Copy patient list to OE/RR Team
 ;
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
 ;Load list into ^TMP
 D LOAD("PXRMRULE",IENO)
 ;Update OE/RR Team list
 D UPDLST("PXRMRULE",IENN,NNAME)
 ;
 W !!,"Completed copy of patient list '"_ONAME_"'"
 W !,"into OE/RR Team '"_NNAME_"'",! H 4
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
ASK(PLIEN,OPT) ;Verify patient list name
 N X,Y,TEXT
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
 ;
LOAD(NODE,LIST) ;Load Patient List
 N DFN,INC,SUB
 S SUB=0,INC=0
 K ^TMP(NODE,$J)
 F  S SUB=$O(^PXRMXP(810.5,LIST,30,SUB)) Q:'SUB  D
 .S DFN=$P($G(^PXRMXP(810.5,LIST,30,SUB,0)),U) Q:'DFN
 .S INC=INC+1,^TMP(NODE,$J,INC)=DFN
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
UPDLST(NODE,LIST,NAME) ;Update patient list
 N CNT,DA,DFN,DIK,DUOUT,FDA,MSG,SUB,TEMP
 ;Lock patient list
 D LOCK Q:$D(DUOUT)
 ;
 ;Clear existing list
 S SUB=0
 F  S SUB=$O(^OR(100.21,LIST,10,SUB)) Q:'SUB  D
 .S DA=SUB,DA(1)=LIST,DIK="^OR(100.21,"_DA(1)_",10,"
 .D ^DIK
 ;
 ;DBIA #4561 putting data into OE/RR list
 ;Merge ^TMP into Patient List
 W !,"Updating "_NAME
 S DFN=0,CNT=1
 F  S DFN=$O(^TMP(NODE,$J,DFN)) Q:'DFN  D
 .S CNT=CNT+1
 .S ^TMP("PXRMFDA",$J,100.2101,"?+"_CNT_",?1,",.01)=$G(^TMP(NODE,$J,DFN))_";DPT("
 ;Update
 S ^TMP("PXRMFDA",$J,100.21,"?1,",.01)=NAME
 S ^TMP("PXRMFDA",$J,100.21,"?1,",.1)=$$UP^XLFSTR(NAME)
 S ^TMP("PXRMFDA",$J,100.21,"?1,",1)="TM"
 S ^TMP("PXRMFDA",$J,100.21,"?1,",1.6)=DUZ
 S ^TMP("PXRMFDA",$J,100.21,"?1,",1.65)=$$NOW^XLFDT
 S TEMP="^TMP(""PXRMFDA"","_$J_")"
 D UPDATE^DIE("",TEMP,"","MSG")
 ;Error
 I $D(MSG) D ERR
 ;Unlock patient list
 D UNLOCK
 K ^TMP(NODE,$J)
 Q
 ;
 ;File locking
UNLOCK L -^PXRMXP(100.21,LIST) Q
LOCK L +^PXRMXP(100.21,LIST):0
 E  W !!?5,"Another user is using this OE/RR team list" S DUOUT=1
 Q
 ;
ERR ;Error Handler
 N ERROR,IC,REF
 S ERROR(1)="Unable to build patient list : "
 S ERROR(2)=NAME
 S ERROR(3)="Error in UPDATE^DIE, needs further investigation"
 ;Move MSG into ERROR
 S REF="MSG"
 F IC=4:1 S REF=$Q(@REF) Q:REF=""  S ERROR(IC)=REF_"="_@REF
 ;Screen message
 D BMES^XPDUTL(.ERROR)
 Q
