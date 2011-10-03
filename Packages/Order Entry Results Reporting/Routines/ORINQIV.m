ORINQIV ; SLC/AGP - Utility report for Order Dialogs ; 12/6/10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**301,296,337**;DEC 17, 1997;Build 84
 ;
 ; DBIA 5133: reading ^PXRMD file #801.41
 ; 
 Q
 ;
ASK(PROMPT,QUEST,HELP,DEFAULT) ;
 N DIR,STR,Y
 S STR=QUEST_";K:SKIP THIS QUICK ORDER;Q:QUIT THE CONVERSION UTILITY"
 S DIR("A")=PROMPT
 I DEFAULT'="" S DIR("B")=DEFAULT
 S DIR(0)="S^"_STR
 S DIR("??")="^D HELP^ORINQIV("_HELP_")"
 D ^DIR
 Q Y
 ;
AWRITE(REF) ;Write all the descendants of the array reference.
 ;REF is the starting array reference, for example A or ^TMP("OR",$J).
 N DONE,IND,LEN,PROOT,ROOT,START,TEMP
 I REF="" Q
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . W !,PROOT_IND,"=",@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 Q
 ;
BLDMSG(ARRAY) ;
 N CNT,LC,NAME,PQO,SPACE,SUCCESS,TEMP,TEXT,USER,XMSUB,Y
 W !
 S CNT=1,TEXT(CNT)="Below is a list of personal QO that can be converted to the Infusion format."
 S CNT=CNT+1,TEXT(CNT)="These items should not be converted unless the quick order is remove from"
 S CNT=CNT+1,TEXT(CNT)="the user personal quick order menu."
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)=NAME,CNT=CNT+1,TEXT(CNT)="_"
 .F SPACE=1:1:78 S TEXT(CNT)=TEXT(CNT)_"_"
 .S PQO="" F  S PQO=$O(ARRAY(NAME,PQO)) Q:PQO=""  D
 ..S CNT=CNT+1,TEXT(CNT)=$G(ARRAY(NAME,PQO))
 S CNT=0 F  S CNT=$O(TEXT(CNT)) Q:CNT'>0  W !,TEXT(CNT)
 ;
 S DIR(0)="Y"
 S DIR("A")="Send this information in a mailman message"
 D ^DIR
 I Y'=1 Q
 S XMSUB="List of personal QO that can be converted to Infusion format"
 S TEMP=$$SUBCHK^XMGAPI0(XMSUB,0)
 I $P(TEMP,U)'="" S XMSUB=$E(XMSUB,1,65)
RETRY ;
 D XMZ^XMA2
 I XMZ<1 G RETRY
 S SUCCESS("XMZ")=XMZ
 S SUCCESS("SUB")=XMSUB
 S CNT=0,LC=0 F  S CNT=$O(TEXT(CNT)) Q:CNT'>0  D
 .S LC=LC+1,^XMB(3.9,XMZ,2,LC,0)=TEXT(CNT)
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_LC_"^"_LC_"^"_DT
 ;S $P(^XMB(3.9,XMZ,0),U,12)="Y"
 D ENT2^XMD
 Q
 ;
EDIT(IEN,PERQOAR) ;
 N ASKADD,CNT,CONF,DA,DIE,DIK,DR,DRPSIVDG,DUR,EXIT,ERR,ERROR,FDA,FDAIEN
 N IVTYPE,LOC,NAME,NODE,OUTPUT,PSIVDG,PSNODE,TERMIN,USER
 S EXIT=0,ERROR=0
 N OI,OINAME,PTR,UPDADD,UPDDSG
 S USER=$$ISPERQO(IEN) I USER>0 D  Q EXIT
 .S NODE=$G(^ORD(101.41,IEN,0))
 .D GETS^DIQ(200,USER_",",".01;9.2","EI","OUTPUT","ERR")
 .I $D(ERR) D AWRITE(ERR) Q
 .S TERMIN=$G(OUTPUT(200,USER_",",9.2,"I"))
 .I TERMIN>0,TERMIN<DT Q
 .S PERQOAR(OUTPUT(200,USER_",",.01,"E"),$P(NODE,U))=$P(NODE,U,2)
 K ^TMP($J,"OR DESC")
 S UPDDSG="N",UPDADD="N"
 S OI=$$GETOI(IEN) I OI="" Q 0
 S OINAME=$P($G(^ORD(101.43,OI,0)),U) I OINAME="" Q 0
 S PSNODE=$G(^ORD(101.43,OI,"PS"))
 S ASKADD=$S($P(PSNODE,U,4)=1:1,1:0)
 S DA=IEN
 D EN^ORORDDSC(IEN,"OR DESC")
 S CNT=0 F  S CNT=$O(^TMP($J,"OR DESC",IEN,CNT)) Q:CNT'>0  D
 .W !,^TMP($J,"OR DESC",IEN,CNT)
 ;
CONVERT ;
 W !!,"Convert the above Quick Order to an Infusion Quick Order?"
 S UPDDSG=$$ASK("Convert?","Y:YES;N:NO",1,"")
 I UPDDSG="Q"!(UPDDSG=U)!(UPDDSG="^^") S EXIT=1 G EDITX
 I UPDDSG'="Y" G EDITX
IVTYPE ;
 W !!,"Select the IV Type for this Quick Order."
 S IVTYPE=$$ASK("IV TYPE","C:CONTINUOUS;I:INTERMITTENT",2,"")
 I IVTYPE=U G CONVERT
 I IVTYPE="^^"!(IVTYPE="Q") S EXIT=1 G EDITX
 I IVTYPE="K" G EDITX
 ;
ADDIT ;
 I ASKADD=1 D
 .I $P(PSNODE,U,3)=0 D  Q
 ..S UPDADD="Y"
 ..W !,"Orderable item "_OINAME_"  is not marked as a solution."
 ..W !,"This orderable item will be moved to the additive value."
 .W !!,"Change orderable item "_OINAME_" to an additive?"
 .S UPDADD=$$ASK("Convert to Additive?","Y:YES;N:NO",3,"")
 .I UPDADD=U G IVTYPE
 .I UPDADD="^^"!(UPDADD="Q") S EXIT=1 G EDITX
 .I UPDADD="K" G EDITX
 ;
CONFIRM ;
 W !!,"Please confirm the selected changes below."
 W !,"If these changes are accepted, the Quick Order will be converted to an"
 W !,"Infusion Quick Order. This Quick Order will not be able to be converted back to"
 W !,"an Inpatient Quick Order."
 W !!,"Convert to Infusion Quick Order: YES"
 W !,"IV TYPE: "_$S(IVTYPE="I":"Intermittent",1:"Continuous")
 I UPDADD="Y" W !,"Change orderable item "_OINAME_" to an additive: YES"
 S CONF=$$ASK("Confirm Changes?","Y:YES;N:NO",4,"")
 I CONF=U G:ASKADD=1 ADDIT I ASKADD=0 G IVTYPE
 I CONF="^^"!(CONF="Q") S EXIT=1 G EDITX
 I CONF="K"!(CONF="N") G EDITX
 ;
UPDATES ;Do updates
 W !
 S DIE="^ORD(101.41,"
 S PSIVDG=$O(^ORD(100.98,"B","IV MEDICATIONS","")) Q:PSIVDG'>0
 S DR="5///^S X=PSIVDG"
 D ^DIE
 S PTR=$$PTR^ORMBLDPS("IV TYPE") Q:PTR'>0
 S IENS="?+3,"_IEN_","
 S FDA(101.416,IENS,.01)=35
 S FDA(101.416,IENS,.02)=PTR
 S FDA(101.416,IENS,.03)=1
 S FDA(101.416,IENS,1)=IVTYPE
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(ERR) D AWRITE("ERR") S ERROR=1
 I UPDADD="Y" D
 .S PTR=$$PTR^ORMBLDPS("ADDITIVE") Q:PTR'>0
 .N FDA,IENS
 .S IENS="?+2,"_IEN_","
 .S FDA(101.416,IENS,.01)=30
 .S FDA(101.416,IENS,.02)=PTR
 .S FDA(101.416,IENS,.03)=1
 .S FDA(101.416,IENS,1)=OI
 .D UPDATE^DIE("","FDA","FDAIEN","ERR")
 .I $D(ERR) D AWRITE("ERR") S ERROR=1
 .I '$D(ERR) W !!,"**CHECK THE STRENGTH ASSOCIATED WITH THE ADDITIVE VALUE IN THE EDITOR." H 1
 .S PTR=$$PTR^ORMBLDPS("ORDERABLE ITEM") Q:PTR'>0
 .S LOC=$O(^ORD(101.41,IEN,6,"D",PTR,"")) Q:LOC'>0
 .S DA(1)=IEN,DA=LOC
 .S DIK="^ORD(101.41,"_DA(1)_",6," D ^DIK
 ;Check for duration
 I IVTYPE="C" D
 .S PTR=$$PTR^ORMBLDPS("SCHEDULE") Q:PTR'>0
 .S LOC=$O(^ORD(101.41,IEN,6,"D",PTR,"")) Q:LOC'>0
 .S DA(1)=IEN,DA=LOC
 .S DIK="^ORD(101.41,"_DA(1)_",6," D ^DIK
 S DUR=$$PTR^ORMBLDPS("DURATION")
 I DUR>0,$D(^ORD(101.41,IEN,6,"D",DUR))>0 D
 .W !!,"**CHECK THE LIMITATION VALUE ASSIGNED TO THE QUICK ORDER IN THE EDITOR." H 1
 I ERROR=1 W !,"Due to the errors in conversion please valiate the quick order in the editor."
 ;
 ;Call the QO editor
 W !
 D QCK0^ORCMEDT1(IEN)
EDITX ;
 K ^TMP($J,"OR DESC")
 Q EXIT
 ;
EN ;
 K ^TMP($J,"OR REMMDLG")
 N DIR,DSGPAR,DSGRP,EXIT,NANSC,ODIEN,PERQOAR,QOIEN,Y
 ;
 D HELP(6)
 ;Build a list of Display Groups that contains the default dialog of
 ;PSJ OR PAT OE
 S ODIEN=$O(^ORD(101.41,"AB","PSJ OR PAT OE","")) Q:ODIEN=""
 S DSGRP=0 F  S DSGRP=$O(^ORD(100.98,DSGRP)) Q:DSGRP'>0  D
 .I $P(^ORD(100.98,DSGRP,0),U,4)=ODIEN S DSGPAR(DSGRP)=""
 ;
 S DIR(0)="S^A:QO ASSIGNED TO ORDER MENUS, ORDER SETS, OR REMINDER DIALOGS;N:QO NOT ASSIGNED TO ANY OF THESE ITEMS;S:SPECIFIC QUICK ORDER;Q:QUIT THE CONVERSION UTILITY"
 S DIR("A")="Which QO to convert?"
 S DIR("??")="^D HELP^ORINQIV(5)"
 D ^DIR
 I Y=U!(Y="^^")!(Y="Q") Q
 I Y="S" D IND^ORINQIV(.DSGPAR) Q
 S NANSC=Y
 I NANSC="A" D FQOIRDLG
 ;
 S OIIEN=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM","")) Q:OIIEN'>0
 S EXIT=0
 S QOIEN=0 F  S QOIEN=$O(^ORD(101.41,QOIEN)) Q:QOIEN'>0!(EXIT=1)  D
 .I $$ISVALID(QOIEN,NANSC,.DSGPAR)=0 Q
 .S EXIT=$$EDIT(QOIEN,.PERQOAR)
UTLEXIT ;
 I $D(PERQOAR) D BLDMSG(.PERQOAR)
 K ^TMP($J,"OR REMDLG")
 Q
 ;
GETOI(IEN) ;
 N OIIEN,OROI,POS
 N OIIEN,OROI,POS
 S OIIEN=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM","")) Q:OIIEN'>0 ""
 S POS=$O(^ORD(101.41,IEN,6,"D",OIIEN,"")) Q:POS'>0 ""
 S OROI=+$G(^ORD(101.41,IEN,6,POS,1)) Q:OROI'>0 ""
 Q OROI
 ;
FQOIRDLG ;
 N AFIND,DIEN,PTEXT,TYPE
 F TYPE="G","E" S DIEN="" D
 . F  S DIEN=$O(^PXRMD(801.41,"TYPE",TYPE,DIEN)) Q:DIEN'>0  D  ;DBIA 5133
 .. ; PTEXT is 'FINDING ITEM' where 101.41 refers to ^ORD(101.41)
 .. S PTEXT=$P($G(^PXRMD(801.41,DIEN,1)),U,5),AFIND=""
 .. I PTEXT[101.41 S ^TMP($J,"OR REMDLG",$P(PTEXT,";"))=DIEN
 .. F  S AFIND=$O(^PXRMD(801.41,DIEN,3,"B",AFIND)) Q:AFIND=""  D
 ... I AFIND[101.41 S ^TMP($J,"OR REMDLG",$P(AFIND,";"))=DIEN
 Q
 ;
IND(DSGPAR) ;
 N DIC,DIR,EXIT,PERQOAR
 S DIC="^ORD(101.41,",DIC(0)="AEMQZ"
 S DIC("S")="I $$ISVALID^ORINQIV(Y,""S"",.DSGPAR)=1"
 D ^DIC
 I +$P(Y,U)'>0 Q
 S EXIT=$$EDIT($P(Y,U),.PERQOAR)
 I EXIT=1 Q
 W !
 S DIR(0)="Y"
 S DIR("A")="Convert another Quick Order?"
 D ^DIR
 I Y=1 D IND(.DSGPAR)
 I $D(PERQOAR) D BLDMSG(.PERQOAR)
 Q
 ;
ISCONT(IEN) ;
 ;This is use to determine if the Entry from file 101.41 is used in an
 ;another entry from file 101.41 or in a reminder dialog.
 I $O(^ORD(101.41,"AD",IEN,0)) Q 1
 I $D(^TMP($J,"OR REMDLG",IEN))>0 Q 1
 Q 0
 ;
ISIV(IEN) ;
 ;This is use to determine if orderable item is marked as a solution or
 ;an additive
 N PSNODE
 S PSNODE=$G(^ORD(101.43,IEN,"PS"))
 I $P(PSNODE,U,3)=1 Q 1
 I $P(PSNODE,U,4)=1 Q 1
 Q 0
 ;
ISPERQO(IEN) ;
 N NUM,RESULT,USER
 I $D(^ORD(101.44,"C",IEN)) D  Q RESULT
 .S NUM=$O(^ORD(101.44,"C",IEN,"")) Q:NUM'>0
 .S USER=$P($G(^ORD(101.44,NUM,0)),U)
 .S USER=$P(USER,"USR",2)
 .S RESULT=+$P(USER," ")
 Q 0
 ;
ISVALID(IEN,NANSC,DSGPAR) ;
 N CONT,NODE,QODSG,PSNODE,RESULT
 S NODE=$G(^ORD(101.41,IEN,0))
 ;Quit if not a quick order
 I $P(NODE,U,4)'="Q" Q 0
 ;Disregard order dialog entry does not contain a valid display group
 S QODSG=$P(NODE,U,5) I QODSG="" Q 1
 I '$D(DSGPAR(QODSG)) Q 0
 ;
 S CONT=$S($O(^ORD(101.41,"AD",IEN,0)):1,$D(^TMP($J,"OR REMDLG",IEN)):1,1:0)
 ;
 ;S CONT=$$ISCONT(IEN)
 I NANSC="A",CONT=0 Q 0
 I NANSC="N",CONT=1 Q 0
 S OROI=$$GETOI(IEN) I OROI="" Q 0
 S PSNODE=$G(^ORD(101.43,OROI,"PS"))
 I $P(PSNODE,U,3)=1 Q 1
 I $P(PSNODE,U,4)=1 Q 1
 Q 0
 ;
HELP(NUM) ;
 N CNT,TAB,TEXT
 S CNT=0,TAB="     "
 I NUM=1 D
 .S CNT=CNT+1,TEXT(CNT)="By selecting YES this quick order will be converted to a Infusion QO."
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="This quick order will not be able to be converted back to a unit dose quick"
 .S CNT=CNT+1,TEXT(CNT)="order. However, you can edit the specific fields of the Infusion quick order in the"
 .S CNT=CNT+1,TEXT(CNT)="quick order editor."
 I NUM=2 D
 .S CNT=CNT+1,TEXT(CNT)="This value defines the type of Infusion quick order that is being setup."
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)=TAB_"Select INTERMITTENT to set-up a quick order that should be administered at"
 .S CNT=CNT+1,TEXT(CNT)=TAB_"scheduled intervals (Q4H, QDay) or One-Time only, ""over a specified time"
 .S CNT=CNT+1,TEXT(CNT)=TAB_"period"" (e.g. ""Infuse over 30 min."")."
 .S CNT=CNT+1,TEXT(CNT)=TAB_TAB_"An example is an a IVP/IVPB order."
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)=TAB_"Select CONTINUOUS to set-up a quick order that run at a specified ""Rate"""
 .S CNT=CNT+1,TEXT(CNT)=TAB_"(_ml/hr, _mcg/kg/min, etc)"
 .S CNT=CNT+1,TEXT(CNT)=TAB_TAB_"An example is an a Infusion/drip quick order."
 I NUM=3 D
 .S CNT=CNT+1,TEXT(CNT)="Select Yes to switch the orderable item from the solution to the additive value in the quick order."
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="Select No to leave the orderable item as the solution in the quick order."
 I NUM=4 D
 .S CNT=CNT+1,TEXT(CNT)="Select Yes to convert the quick order to an infusion quick order with the"
 .S CNT=CNT+1,TEXT(CNT)="selected change. When the conversion is complete you will be drop into the"
 .S CNT=CNT+1,TEXT(CNT)="quick order editor to make any changes to the quick order."
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="Select No to stop the conversion process for this quick order."
 I NUM<5 D
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="Select SKIP THIS QUICK ORDER to leave the current quick order as an"
 .S CNT=CNT+1,TEXT(CNT)="Inpatient quick order and select another quick order to convert."
 I NUM=5 D
 .S CNT=CNT+1,TEXT(CNT)="Select QO ASSIGNED TO ORDER MENUS, ORDER SETS, OR REMINDER DIALOGS to convert"
 .S CNT=CNT+1,TEXT(CNT)="quick orders that are used in one of the following: Order Menus, Order Sets,"
 .S CNT=CNT+1,TEXT(CNT)="or Reminder Dialogs."
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="Select QO NOT ASSIGNED TO ANY OF THESE ITEMS to convert quick orders that are"
 .S CNT=CNT+1,TEXT(CNT)="not use in the following: Order Menus, Order Sets, or Reminder Dialogs."
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="Select SPECIFIC QUICK ORDER to convert an individual quick order."
 I NUM=6 D
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="This conversion utility enables users to convert IV quick orders set-up as"
 .S CNT=CNT+1,TEXT(CNT)="Inpatient quick orders to Infusion quick orders. For each quick order,"
 .S CNT=CNT+1,TEXT(CNT)="the conversion utility asks a series of questions to populate the minimum"
 .S CNT=CNT+1,TEXT(CNT)="prompts needed to convert the quick order. Once the conversion is"
 .S CNT=CNT+1,TEXT(CNT)="done, the user is placed into the Infusion quick order editor to add any"
 .S CNT=CNT+1,TEXT(CNT)="values to the additional fields in the Infusion quick order, if needed."
 .S CNT=CNT+1,TEXT(CNT)="Possible conflicts at the time of conversion will be displayed before entering"
 .S CNT=CNT+1,TEXT(CNT)="the editor. An example of a conflict may be that the user should review the"
 .S CNT=CNT+1,TEXT(CNT)="strength associated with the additive in the editor."
 I NUM=7 D
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="This conversion utility enables users to edit an existing Continuous IV quick"
 .S CNT=CNT+1,TEXT(CNT)="order's Additive Frequency field. This utility will display the additive and the"
 .S CNT=CNT+1,TEXT(CNT)="possible additive frequency values. The default value for the additive"
 .S CNT=CNT+1,TEXT(CNT)="frequency prompt is loaded from the pharmacy package."
 I NUM=8 D
 .S CNT=CNT+1,TEXT(CNT)="Select YES add Additive Frequency values to the quick order"
 I NUM=9 D
 .S CNT=CNT+1,TEXT(CNT)="The default value for this prompt is provided from "
 .S CNT=CNT+1,TEXT(CNT)="the pharmacy package. However, you can select one of the three"
 .S CNT=CNT+1,TEXT(CNT)="possible values for an additive frequency"
 I NUM=10 D
 .S CNT=CNT+1,TEXT(CNT)="Select Yes to update the quick order with the additive frequency values."
 .S CNT=CNT+1,TEXT(CNT)="When the update is complete you will be drop into the"
 .S CNT=CNT+1,TEXT(CNT)="quick order editor to make any changes to the quick order."
 .S CNT=CNT+1,TEXT(CNT)=" "
 .S CNT=CNT+1,TEXT(CNT)="Select No to stop the conversion process for this quick order."
 S CNT=CNT+1,TEXT(CNT)=" "
 I NUM<6!(NUM>7) S CNT=CNT+1,TEXT(CNT)="Select QUIT THE CONVERSION UTILITY to exit this utility."
 S CNT=0 F  S CNT=$O(TEXT(CNT)) Q:CNT'>0  W !,TEXT(CNT)
 Q
 ;
