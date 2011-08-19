PXRMSEL2 ; SLC/PJH - PXRM Selection ;04/16/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ; Called from PXRMSEL
 ;
 ;Select Health factors requiring resolutions
 ;-------------------------------------------
START W IORESET
 ;Select to edit individual or reminder's Health Factors
 D OPT(.ANS) Q:$D(DTOUT)!$D(DUOUT)  Q:ANS="I"
 ;Select Reminder
 S DIC("A")="SELECT REMINDER: "
 S LIT1="You must select a reminder!"
 D REM(.ARRAY) Q:$D(DTOUT)!$D(DUOUT)
 ;Scan health factors
 D SKIP
 ;Rebuild listman screen
 D INIT^PXRMSEL
 Q
 ;
 ;Ask ADD/MODIFY or not
 ;---------------------
ASK(YESNO,TEXT) ;
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")=TEXT
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D ZHELP^PXRMSEL(2)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;Select single HF or all HF's for the reminder
 ;---------------------------------------------
OPT(TYPE) ;
 N X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"I:Individual Health Factor;"
 S DIR(0)=DIR(0)_"A:All Health Factors for a Selected Reminder;"
 S DIR("A")="SELECTION OPTION"
 S DIR("B")="I"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D ZHELP^PXRMSEL(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYPE=Y
 Q
 ;
 ;Reminder selection
 ;------------------
REM(ARRAY) ;
 N X,Y,CNT,FSUB,FHF,FIND,FNAM,FOUND,REM
 K DIROUT,DIRUT,DTOUT,DUOUT
 S FOUND=0
 W !
 F  D  Q:$D(DTOUT)  Q:$D(DUOUT)  Q:FOUND
 .S DIC=811.9,DIC(0)="AEMQZ"
 .D ^DIC K DIC S:X=(U_U) DTOUT=1 Q:$D(DTOUT)!$D(DUOUT)!(+Y=-1)
 .;Reminder ien
 .S REM=$P(Y,U) Q:'REM
 .;Get health factor findings on this reminder
 .S FSUB=0
 .F  S FSUB=$O(^PXD(811.9,REM,20,FSUB)) Q:'FSUB  D
 ..S FIND=$P($G(^PXD(811.9,REM,20,FSUB,0)),U)
 ..Q:$P(FIND,";",2)'="AUTTHF("
 ..S FHF=$P(FIND,";") Q:'FHF
 ..S FNAM=$P($G(^AUTTHF(FHF,0)),U) Q:FNAM=""
 ..;Save array used by PXRMGEDT
 ..S FOUND=FOUND+1
 ..S ARRAY(FNAM)=FHF,ARRAYN(FHF)=""
 .I 'FOUND W !!,"No health factor findings on this reminder",! Q
 .S FNAM=""
 .W !!,"HEALTH FACTORS:",!
 .F  S FNAM=$O(ARRAY(FNAM)) Q:FNAM=""  D
 ..S FHF=$P(ARRAY(FNAM),U)
 ..W !,FNAM W:$D(^PXRMD(801.95,FHF,0)) " (Resolution defined)"
 .W !
 Q
 ;
 ;Dialog type selection
 ;---------------------
SEL(TYPE) ;
 W IORESET
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"D:Reminder Dialogs;"
 S DIR(0)=DIR(0)_"E:Dialog Elements;"
 S DIR(0)=DIR(0)_"F:Forced Values;"
 S DIR(0)=DIR(0)_"G:Dialog Groups;"
 S DIR(0)=DIR(0)_"P:Additional Prompts;"
 S DIR(0)=DIR(0)_"R:Reminders;"
 S DIR(0)=DIR(0)_"RG:Result Group (Mental Health);"
 S DIR(0)=DIR(0)_"RE:Result Element (Mental Health);"
 S DIR("A")="TYPE OF VIEW"
 S DIR("B")="R"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMSEL2(3)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYPE=Y
 ;Change display type
 S PXRMGTYP=$S(TYPE="D":"DLG",TYPE="R":"DLGR",1:"DLGE")
 I TYPE'="R" D
 .I TYPE="D" S PXRMDTYP="R" Q
 .I TYPE="RG" S PXRMDTYP="S" Q
 .I TYPE="RE" S PXRMDTYP="T" Q
 .S PXRMDTYP=TYPE
 Q
 ;
 ;Reminders Health Factors
 ;------------------------
SKIP N ANS,FNAM,FHF,EXISTS,TEXT
 S FNAM=""
 F  S FNAM=$O(ARRAY(FNAM)) Q:FNAM=""  D  Q:$D(DUOUT)!$D(DTOUT)
 .S FHF=ARRAY(FNAM),EXISTS=$D(^PXRMD(801.95,FHF,0))
 .I 'EXISTS S TEXT="ADD resolution status for "_FNAM_": "
 .I EXISTS S TEXT="MODIFY resolution status for "_FNAM_": "
 .;Option to ADD/MODIFY
 .D ASK(.ANS,TEXT) Q:$D(DTOUT)!$D(DUOUT)  Q:(ANS'="Y")
 .;Force entry of HF into 801.95
 .I 'EXISTS D
 ..N DA,DIC,DIK,DR
 ..;Store the unique name
 ..S DR=".01///"_FNAM,DIE="^PXRMD(801.95,",DA=FHF
 ..D ^DIE
 ..;Reindex the cross-references.
 ..S DIK="^PXRMD(801.95,",DA=FHF
 ..D IX^DIK
 .;Edit
 .D EDIT^PXRMGEDT(PXRMGTYP,FHF,1)
 Q
 ;
 ;General help text routine.
 ;--------------------------
HELP(CALL) ;
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C75",DIWL=0,DIWR=75
 ;
 I CALL=1 D
 .S HTEXT(1)="Enter I to select an individual health factor. Enter A to"
 .S HTEXT(2)="process all health factor findings on a selected reminder."
 I CALL=2 D
 .S HTEXT(1)="Enter Yes to enter resolution status for this health"
 .S HTEXT(2)="factor. Enter No to continue to the next health factor."
 I CALL=3 D
 .S HTEXT(1)="Select the type of view to be displayed. You may view"
 .S HTEXT(2)="either reminders or selected dialog types."
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
