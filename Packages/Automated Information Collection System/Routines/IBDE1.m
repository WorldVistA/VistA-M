IBDE1 ;ALB/CJM - ENCOUNTER FORM - (IMP/EXP UTILITY ACTIONS) ;AUG 12,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**14**;APR 24, 1997
 ;
ADD ;adds a form to the work space
 N OLDFORM,NEWFORM
 D FULL^VALM1
 S VALMBCK="R"
 S OLDFORM=$$SLCTFORM^IBDFU4("") Q:'OLDFORM
 S NEWFORM=$$COPYFORM^IBDFU2C(OLDFORM,357,358,"",1)
 I NEWFORM K DIE,DR,DA S DIE="^IBE(358,",DA=NEWFORM,DR="1;" D ^DIE K DIE,DR,DA
 D IDXFORMS^IBDE
 Q
 ;
DELETE ;deletes a form from the work space
 N PICK,FORM
 D EN^VALM2($G(XQORNOD(0)))
 S PICK="" F  S PICK=$O(VALMY(PICK)) Q:'PICK  S FORM=+$G(@VALMAR@("IDX",PICK,PICK)) D:FORM DELETE^IBDFU2C(FORM,358,1)
 S VALMBCK="R"
 D IDXFORMS^IBDE
 Q
EDIT ;allows the export notes of a form to be edited
 N PICK,FORM
 D EN^VALM2($G(XQORNOD(0)))
 D FULL^VALM1
 S PICK="" F  S PICK=$O(VALMY(PICK)) Q:'PICK  S FORM=+$G(@VALMAR@("IDX",PICK,PICK)) D:FORM
 .K DIE,DR,DA S DIE="^IBE(358,",DR="1;",DA=FORM D ^DIE K DIE,DA,DR
 S VALMBCK="R"
 D IDXFORMS^IBDE
 Q
IMPORT ;allows the user to pick a form, then import it
 N PICK,FORM,NAME,NEWFORM,IBDVR,FORMVR
 D EN^VALM2($G(XQORNOD(0)))
 D FULL^VALM1
 S PICK="" F  S PICK=$O(VALMY(PICK)) Q:'PICK  S FORM=+$G(@VALMAR@("IDX",PICK,PICK)) D:FORM
 .S IBDVR=+$G(^DD(357,0,"VR")) S:IBDVR<2.1 IBDVR=3.0
 .S FORMVR=+$P($G(^IBE(358,FORM,0)),"^",17) S:FORMVR<2.1 FORMVR=2.0
 .I FORMVR<IBDVR W !!,"This form was created with version "_FORMVR_"." D
 ..; -- ask if want to continue, if not quit
 ..;
 .S NAME=$$NEWNAME^IBDFU2C($P($G(^IBE(358,FORM,0)),"^"))
 .Q:NAME=""
 .S NEWFORM=$$COPYFORM^IBDFU2C(FORM,358,357,NAME)
 .K DIE,DR,DA S DIE="^IBE(357,",DR=".07T;.04////1;",DA=NEWFORM D ^DIE K DIE,DA,DR
 .D:$G(NEWFORM) DELETE^IBDFU2C(FORM,358,0)
 S VALMBCK="R"
 D IDXFORMS^IBDE
 D UPDATE^IBDECLN(1) ;make sure everything is okay (with messages)
 Q
VIEW ;allows the export notes of a form to be edited
 N PICK,FORM,IBARY,IBHDRRTN
 D EN^VALM2($G(XQORNOD(0)),"S")
 S PICK="" F  S PICK=$O(VALMY(PICK)) Q:'PICK  S FORM=+$G(@VALMAR@("IDX",PICK,PICK)) D
 .S IBHDRRTN="D VIEWHDR^IBDE1"
 .S IBARY="^IBE(358,"_FORM_",1)"
 .D EN^VALM("IBDE TEXT DISPLAY")
 S VALMBCK="R"
 Q
VIEWHDR ;
 S VALMHDR(1)="Export Notes For "_$P($G(^IBE(358,FORM,0)),"^")_" Form"
 Q
TEXT ;entry code for the IBDF TEXT DISPLAY list template
 N NODE S NODE=""
 S:$D(IBARY) VALMAR=IBARY
 X:$D(IBHDRRTN) IBHDRRTN
 I $G(IBARY)'="" S NODE=$G(@IBARY@(0))
 S VALMCNT=$S($P(NODE,"^",4)>$P(NODE,"^",3):$P(NODE,"^",4),1:$P(NODE,"^",3))
 I '$G(VALMCNT) S VALMCNT=10
 Q
 ;
INITS ;executes inits to bring stuff into the imp/exp files
 N QUIT,RTN
 S QUIT=0
 S VALMBCK="R"
 I $G(DUZ(0))'["@" W !,"This action requires PROGRAMMER ACCESS!" D PAUSE^IBDFU5 Q
 D FULL^VALM1
 I BLKCNT!FORMCNT D
 .K DIR S DIR(0)="Y"
 .W !,"The work space must be cleared before the INITS are run. Is that okay?"
 .D ^DIR K DIR
 .I $D(DIRUT)!(Y=0) S QUIT=1
 D:'QUIT DLTALL^IBDE2
 ;
 ;ask for the init rtn
 F  Q:QUIT  D
 .S DIR(0)="FA^5:8",DIR("B")=$S($L($T(^IBDEINIT)):"IBDEINIT",1:"")
 .S DIR("?",1)="In order for you to import forms from another site the other site must have",DIR("?")="prepared and sent you inits created using the import/export facility."
 .S DIR("A",1)="What is the name of the init routine that contains the forms that you want to",DIR("A")="import? "
 .D ^DIR K DIR
 .I $D(DIRUT) S QUIT=1 Q
 .I '$L($T(^@Y)) W !!,"That routine does not exist!",! Q
 .S RTN=Y
 .S QUIT=$$MSG^IBDE1B
 .I 'QUIT D @("^"_RTN),IDXFORMS^IBDE,IDXBLKS^IBDE3 S VALMCNT=$S(SCREEN="F":FORMCNT,1:BLKCNT)
 .S QUIT=1
 I SCREEN="F" D HDR^IBDE
 I SCREEN="B" D HDR^IBDE3
 Q
DIFROM ;
 N QUIT S QUIT=0
 S VALMBCK=""
 I $G(DUZ(0))'["@" W !!,"Using the DIFROM action requires PROGRAMMER ACCESS!",! D PAUSE^IBDFU5 Q
 I 'BLKCNT,'FORMCNT D  Q
 .W !!,"There is nothing in the work space to export!"
 .D PAUSE^IBDFU5
 D FULL^VALM1
 S QUIT=$$MSG^IBDE1A
 I 'QUIT D ^DIFROM W !,"DONE",!,"************************"
 S VALMBCK="R"
 Q
BLOCKS ;
 S SCREEN="B"
 D EN^VALM("IBDE IMP/EXP TK BLOCKS")
 S VALMBCK="R",VALMCNT=FORMCNT,SCREEN="F"
 Q
