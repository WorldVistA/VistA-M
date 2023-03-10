ORQOCONV ; SLC/AGP - Utility report for Order Dialogs ;Dec 08, 2021@10:45:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**405**;DEC 17, 1997;Build 211
 ;
 ; DBIA 5133: reading ^PXRMD file #801.41
 ;
 Q
 ;Prompt to determine what to when moving to the next quick order
ASK() ;
 N DIR,Y
 S DIR(0)="S^E:EDIT THIS QUICK ORDER;K:SKIP THIS QUICK ORDER;Q:QUIT THE CONVERSION UTILITY"
 S DIR("A")="Select the action"
 S DIR("B")="E"
 S DIR("?")="Select the action"
 S DIR("??")="^D HELP^ORQOCONV(2)"
 D ^DIR
 Q Y
 ;
 ;determine if the type of orders has a complex version of it.
CANBECOMPL(ORDIALOG) ;
 N NAME
 S NAME=$P(^ORD(101.41,ORDIALOG,0),U)
 I NAME="PSJ OR PAT OE" Q 1
 I NAME="PSO OERR" Q 1
 I NAME="PSJ OR CLINIC OE" Q 1
 I NAME="PSH OERR" Q 1
 Q 0
 ;
CONT() ;
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")="Process next Quick Order"
 S DIR("B")="Yes"
 S DIR("?")="Select Yes to continue to the next quick order. Or No to exit."
 D ^DIR
 Q Y
 ;
 ;determine if disable Quick Orders should be shown
SKIPDIS() ;
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")="Skip Disable Quick Orders"
 S DIR("B")="Yes"
 S DIR("?")="Select Yes to skip disable quick orders."
 D ^DIR
 Q Y
 ;
REPTYPE() ;
 N DIR,Y
 S DIR(0)="S^A:SHOW ALL FIELDS IN THE QUICK ORDER;F:SHOW ONLY THE FIELDS THE UTILITY IS CHECKING"
 S DIR("A")="Select the fields to display in the report"
 S DIR("B")="A"
 S DIR("?")="Select the display"
 S DIR("??")="^D HELP^ORQOCONV(2)"
 D ^DIR
 Q Y
 Q
 ;
 ;This write out a before and after of the QO and drop the user into the standard QO editor
EDITOR(QOIEN) ;
 N ORDG,TEMP
 W !,"Before value:"
 D SHOW(QOIEN)
 W !
 S TEMP=$$ASK()
 I TEMP[U!(TEMP="Q") Q -1
 I TEMP="K" Q 0
 S ORDG=$P($G(^ORD(101.41,QOIEN,0)),U,5)
 W !
 D QCK0^ORCMEDT1(QOIEN)
 W !,"After value:"
 D SHOW(QOIEN)
 Q 1
 ;
 ;main entry point into the code. Convert is the identifier used by the code to determine what to do. WHERE is used to default how to find the QO.
 ;If Where is defined then line tag WHERE is not called.
EN(CONVERT,WHERE) ;
 N ARRAY,PERARR,QOS,REPSUB,REPTYPE,RETMENU,RETSTRCT,SKIPDIS,SUB,TEMP,TYPE
 S SUB="ORQOCONV",REPSUB="ORQOCONV REPORT"
 K ^TMP($J,SUB),^TMP($J,REPSUB)
EN1 ;
 D SETUP(.ARRAY,CONVERT)
 D INSTR(CONVERT)
 S QOS=+$O(ARRAY("A"),-1)
 S TYPE=0
 I QOS>1 S TYPE=$$GETQOSEL(.ARRAY) I TYPE[U Q
 I TYPE=0 S TYPE=1
 S TEMP=$$SPECIAL(CONVERT,.ARRAY)
 I TEMP=U G EN1
 I TEMP="^^" Q
EN2 ;
 S REPTYPE=""
 I WHERE="" S WHERE=$$WHERE
 I WHERE=U S WHERE="" G EN1
 I WHERE="^^"!(WHERE="Q") Q
 I WHERE="S" D SPECIFIC Q
 I WHERE="R" S REPTYPE=$$REPTYPE()
 I REPTYPE=U Q
 I REPTYPE="^^" G EN2
 S SKIPDIS=0
 I WHERE'="R",WHERE'="P" S SKIPDIS=$$SKIPDIS
 I SKIPDIS=U Q
 I SKIPDIS="^^" G EN2
 W !!,"Collecting Quick Order List, this may take some time",!
 S RETSTRCT=0,RETMENU=0
 I WHERE'="P",WHERE'="A" S RETMENU=1
 D GETQOS(TYPE,SUB,RETMENU,RETSTRCT,.ARRAY,SKIPDIS)
 W !!,"Processing Quick Order List"
 D PROCESS(.ARRAY,SUB,WHERE,.PERARR,REPSUB)
 I WHERE="P" D PERREP(.PERARR)
 I WHERE="R" D REPORT^ORQOCONV1(REPSUB,REPTYPE,.ARRAY)
 K ^TMP($J,SUB),^TMP($J,REPSUB)
 Q
 ;
FORMAT(TEXT) ;
 N NL,NOUT,TEXTOUT,X
 S NL=+$O(TEXT(""),-1)
 D FORMAT^PXRMTEXT(1,80,.NL,.TEXT,.NOUT,.TEXTOUT)
 F X=1:1:NOUT W !,TEXTOUT(X)
 Q
 ;
GETQOS(TYPE,SUB,RETMENU,RETSTRCT,INPUTS,SKIPDIS) ;
 N ARRAY,CNT,QOTYPES
 S CNT=0 F  S CNT=$O(INPUTS(TYPE,CNT)) Q:CNT'>0  D
 .S QOTYPES(INPUTS(TYPE,CNT))=""
 D FINDQO^ORQOUTL(.ARRAY,.QOTYPES,SUB,RETMENU,RETSTRCT,1,SKIPDIS)
 Q
 ;
 ;This section is used to prompt the user for selection information to help limit the QO to search for.
 ;This is used if the GETQOSEL array is defined in the setup section.
GETQOSEL(INPUTS) ;
 N CNT,DIR,HELP,PROMPT,Y
 S HELP=+$G(INPUTS("GETQOSEL","HELPID"))
 S PROMPT=$S($G(INPUTS("GETQOSEL","PROMPT"))'="":INPUTS("GETQOSEL","PROMPT"),1:"Select Quick Order Type")
 I HELP=0 S HELP=3
 S CNT=0,DIR(0)="S^" F  S CNT=$O(INPUTS(CNT)) Q:CNT'>0  D
 .I CNT=1 S DIR(0)=DIR(0)_CNT_":"_INPUTS(CNT) Q
 .S DIR(0)=DIR(0)_";"_CNT_":"_INPUTS(CNT)
 S DIR("A")=INPUTS("GETQOSEL","PROMPT")
 S DIR("?")="Select the type of Quick Order to search for."
 S DIR("??")="^D HELP^ORQOCONV("_HELP_")"
 D ^DIR
 Q Y
 ;
HASTEXT(ORDIALOG,IEN) ;
 N CNT,INST,TIDX,VALUE
 S CNT=0
 S INST=0 F  S INST=$O(ORDIALOG(IEN,INST)) Q:INST'>0!(CNT>0)  D
 .S VALUE=$G(ORDIALOG(IEN,INST)) I VALUE'["^TMP(" Q
 .S TIDX=0 F  S TIDX=$O(@VALUE@(TIDX)) Q:TIDX'>0!(CNT>0)  D
 ..I @VALUE@(TIDX,0)'="" S CNT=CNT+1
 Q $S(CNT>0:1,1:0)
 ;
 ;This is used to determine if a prompt has a value. This will only check prompts that were defined
 ;in the HASVALUE array that is defined in the SETUP line tag.
HASVALUE(ORDIALOG,ARRAY) ;
 N CNT,IEN,NODE,NOVALUE,PROMPT,RESULT,TYPE
 S NOVALUE=0
 S PROMPT=""
 F  S PROMPT=$O(ARRAY("HASVALUE",PROMPT)) Q:PROMPT=""!(NOVALUE=1)  D
 .S NODE=$G(ORDIALOG("B",PROMPT))
 .S IEN=+$P(NODE,U,2)
 .I +$O(ORDIALOG(IEN,"?"),-1)=0 S NOVALUE=1 Q
 .S TYPE=$P($G(ORDIALOG(IEN,0)),U)
 .;I TYPE="W" BREAK
 .S CNT=0 F  S CNT=$O(ORDIALOG(IEN,CNT)) Q:CNT'>0!(NOVALUE=1)  D
 ..I $G(ORDIALOG(IEN,CNT))="" S NOVALUE=1 Q
 ..I TYPE="W",'$$HASTEXT(.ORDIALOG,IEN) S NOVALUE=1 Q
 ..S NOVALUE=0
 S RESULT=$S(NOVALUE=1:0,1:1)
 Q RESULT
 ;
 ;Entry point to defined any specific instructions to display to the end user for the QO editor
INSTR(CONVERT) ;
 N TEXT
 I CONVERT="INDICATION" D
 .S TEXT(1)="This option provides a quick way to update Quick Orders for the new indication prompt. "
 .S TEXT(2)="This option will prompt filtering questions to help decrease the number of Quick Orders to"
 .S TEXT(3)=" review in a session. For each Quick Orders that is found the user will automatically enter the Quick Order Editor."
 I CONVERT="TITRATION" D
 .S TEXT(1)="This option provides a quick way to update Quick Orders for the new titration prompt. This option will search "
 .S TEXT(2)="for Complex Outpatient Quick Orders containing a 'Then' conjunction. For each Quick Orders that is found the user "
 .S TEXT(3)="will automatically enter the Quick Order Editor."
 I $D(TEXT) W ! D FORMAT(.TEXT)
 Q
 ;
 ;this determine if the QO is a complex quick order by checking the instruction fields.
ISCOMPL(ORDIALOG) ;
 N CNT,INSTR,RESULT
 S RESULT=0
 S INSTR=$$PTR^ORCD("OR GTX INSTRUCTIONS")
 S CNT=0 F  S CNT=$O(ORDIALOG(INSTR,CNT)) Q:CNT'>0!(RESULT>1)  D
 .I $G(ORDIALOG(INSTR,CNT))'="" S RESULT=RESULT+1
 Q RESULT
 ;
 ;this execute any special logic defined in the SETUP line tag
DOLOGIC(ARRAY,ORDIALOG) ;
 N CODE,RESULT,RET
 S CODE=ARRAY("LOGIC")
 X CODE
 S RESULT=RET
 Q RESULT
 ;
 ;This is used to determine if a prompt does not have a value. This will only check prompts that were defined
 ;in the NOVALUE array that is defined in the SETUP line tag.
NOVALUE(ORDIALOG,ARRAY) ;
 N CNT,IEN,HASVALUE,NODE,PROMPT,RESULT,TYPE
 S HASVALUE=0
 S PROMPT=""
 F  S PROMPT=$O(ARRAY("NOVALUE",PROMPT)) Q:PROMPT=""!(HASVALUE=1)  D
 .S NODE=$G(ORDIALOG("B",PROMPT))
 .S IEN=+$P(NODE,U,2)
 .I IEN=0
 .S TYPE=$P($G(ORDIALOG(IEN,0)),U)
 .S CNT=0 F  S CNT=$O(ORDIALOG(IEN,CNT)) Q:CNT'>0!(HASVALUE=1)  D
 ..I TYPE="W",$$HASTEXT(.ORDIALOG,IEN) S HASVALUE=1 Q
 ..I $G(ORDIALOG(IEN,CNT))'="" S HASVALUE=1 Q
 S RESULT=$S(HASVALUE=1:0,1:1)
 Q RESULT
 ;
 ;Write out the personal quick assigned by users
PERREP(PERARR) ;
 N IEN,NAME,NODE,QOIEN,TEMP,USER,USRARR
 S QOIEN=0
 F  S QOIEN=$O(PERARR(QOIEN)) Q:QOIEN'>0  D
 .S NODE=PERARR(QOIEN),IEN=0
 .F  S IEN=$O(^ORD(101.44,"C",QOIEN,IEN)) Q:IEN'>0  D
 ..S TEMP=^ORD(101.44,IEN,0)
 ..I TEMP'["ORWDQ USR" Q
 ..S USER=+$P(TEMP,"USR",2)
 ..S NAME=$$GET1^DIQ(200,USER_",",.01)
 ..S USRARR(NAME,$P(NODE,U,2))=NODE
 S NAME=""
 F  S NAME=$O(USRARR(NAME)) Q:NAME=""  D
 .W !!,"User: "_NAME
 .S TEMP=""
 .F  S TEMP=$O(USRARR(NAME,TEMP)) Q:TEMP=""  D
 ..W !,"  Print Name: "_TEMP
 H 1
 Q
 ;
 ;searches for quick orders
PROCESS(ARRAY,SUB,WHERE,PERARR,REPSUB) ;
 ;WHERE can be set to A: ALL, M: QO assigned to menu, order set, reminder, N: Qo not assigned to menu, order set, R: for Report searches as All
 N DONE,HASVALUE,NOVALUE,ORDIALOG,PROMPT,QOIEN,TEMP
 S DONE=0
 S QOIEN=0 F  S QOIEN=$O(^TMP($J,SUB,QOIEN)) Q:QOIEN'>0!(DONE=1)  D
 .I WHERE'="P",^TMP($J,SUB,QOIEN,"ISPERQO")=1 Q
 .I WHERE="M",'$D(^TMP($J,SUB,QOIEN,"ORDER MENUS")),'$D(^TMP($J,SUB,QOIEN,"REMINDER DIALOGS")) Q
 .I WHERE="N"&($D(^TMP($J,SUB,QOIEN,"ORDER MENUS"))!($D(^TMP($J,SUB,QOIEN,"REMINDER DIALOGS")))) Q
 .K ORDIALOG D GETQDLG^ORCD(QOIEN)
 .;M ORDIALOG=^TMP($J,SUB,QOIEN,"ORDIALOG")
 .I +$G(ARRAY("ISCOMPLEX"))=1,$$CANBECOMPL(ORDIALOG),$$ISCOMPL(.ORDIALOG)<2 Q
 .I +$G(ARRAY("ISSIMPLE"))=1,$$CANBECOMPL(ORDIALOG),$$ISCOMPL(.ORDIALOG)>1 Q
 .;I QOIEN=15689 BREAK
 .S HASVALUE=0,NOVALUE=0
 .I $D(ARRAY("NOVALUE"))>1,$$NOVALUE(.ORDIALOG,.ARRAY)=0 Q
 .I $D(ARRAY("HASVALUE"))>1,$$HASVALUE(.ORDIALOG,.ARRAY)=0 Q
 .I $G(ARRAY("LOGIC"))'="",$$DOLOGIC(.ARRAY,.ORDIALOG)=0 Q
 .;what to do with personal qo
 .I WHERE="P" D  Q
 ..I ^TMP($J,SUB,QOIEN,"ISPERQO")=1 S PERARR(QOIEN)=^TMP($J,SUB,QOIEN)
 .I WHERE="R" D  Q
 ..S ^TMP($J,REPSUB,QOIEN)=$S($D(^TMP($J,SUB,QOIEN,"ORDER MENUS")):1,$D(^TMP($J,SUB,QOIEN,"REMINDER DIALOGS")):1,1:0)
 .I ARRAY("ACTION")="E" D  Q
 ..S TEMP=$$EDITOR(QOIEN)
 ..I TEMP=-1 S DONE=1 Q
 ..I TEMP=0 Q
 ..I $$CONT^ORQOCONV()'=1 S DONE=1
 Q
 ;
 ;entry point to editor one specific quick order selected by the end user
SPECIFIC ;
 N DIC,Y
 S DIC="^ORD(101.41,",DIC(0)="AEMQZ"
 S DIC("S")="I $P($G(^ORD(101.41,Y,0)),U,4)=""Q"""
 D ^DIC
 I Y=-1 Q
 D EDITOR(+Y)
 Q
 ;
SETUP(OUTPUT,INPUT) ;
 I INPUT="INDICATION" D  Q
 .S OUTPUT(1)="All medication and supplies Quick Orders"
 .S OUTPUT(1,1)="PSJ OR CLINIC OE",OUTPUT(1,2)="CLINIC OR PAT FLUID OE"
 .S OUTPUT(1,3)="PSJI OR PAT FLUID OE",OUTPUT(1,4)="PSH OERR",OUTPUT(1,5)="PSO OERR"
 .S OUTPUT(1,6)="PSO SUPPLY",OUTPUT(1,7)="PSJ OR PAT OE"
 .S OUTPUT(2)="Clinic Medications"
 .S OUTPUT(2,1)="PSJ OR CLINIC OE"
 .S OUTPUT(3)="Clinic Infusions",OUTPUT(3,1)="CLINIC OR PAT FLUID OE"
 .S OUTPUT(4)="Infusion",OUTPUT(4,1)="PSJI OR PAT FLUID OE"
 .S OUTPUT(5)="Non-VA Meds (Documentation)",OUTPUT(5,1)="PSH OERR"
 .S OUTPUT(6)="Out. Meds",OUTPUT(6,1)="PSO OERR"
 .S OUTPUT(7)="Supplies",OUTPUT(7,1)="PSO SUPPLY"
 .S OUTPUT(8)="Inpt. Meds",OUTPUT(8,1)="PSJ OR PAT OE"
 .S OUTPUT("GETQOSEL","PROMPT")="Select which quick orders to convert"
 .S OUTPUT("GETQOSEL","HELPID")=5
 .;S OUTPUT("ISCOMPLEX")=1
 .;S OUTPUT("ISSIMPLE")=0
 .S OUTPUT("HASVALUE","COMMENTS")=""
 .S OUTPUT("NOVALUE","INDICATION")=""
 .S OUTPUT("ACTION")="E"
 .S OUTPUT("SPECIAL")=1
 .S OUTPUT("SPECIAL","HELPID")=4
 .S OUTPUT("SPECIAL","HELP")="Select the prompt conditions to search for."
 .S OUTPUT("SPECIAL","PROMPT")="Select prompt conditions"
 .S OUTPUT("TYPE")="INDICATION"
 I INPUT="TITRATION" D  Q
 .S OUTPUT(1)="Out. Meds",OUTPUT(1,1)="PSO OERR"
 .S OUTPUT("NOVALUE","TITRATION")=""
 .S OUTPUT("ACTION")="E"
 .S OUTPUT("TYPE")="TITRATION"
 .S OUTPUT("ISCOMPLEX")=1
 .S OUTPUT("PROMPT","AND/THEN","*","VALUE")="T"
 .S OUTPUT("LOGIC")="S RET=$$ASKTITR^ORCDPS3()"
 Q
 ;
SHOW(IEN) ;
 N CNT
 K ^TMP($J,"OR DESC",IEN)
 D EN^ORORDDSC(IEN,"OR DESC")
 S CNT=0 F  S CNT=$O(^TMP($J,"OR DESC",IEN,CNT)) Q:CNT'>0  D
 .W !,^TMP($J,"OR DESC",IEN,CNT)
 Q
 ;
SPECIAL(TYPE,ARRAY) ;
 I +$G(ARRAY("SPECIAL"))=0 Q ""
 N DIR,HELP,HELPID,PROMPT,RESULT,Y
 S RESULT=""
 S HELPID=$S(+$G(ARRAY("SPECIAL","HELPID"))>0:ARRAY("SPECIAL","HELPID"),1:0)
 S PROMPT=$S($G(ARRAY("SPECIAL","PROMPT"))'="":ARRAY("SPECIAL","PROMPT"),1:"Select the action")
 S HELP=$s($G(ARRAY("SPECIAL","HELP"))'="":ARRAY("SPECIAL","HELP"),1:"Select the correct action")
 I TYPE="INDICATION" D  Q RESULT
 .S DIR(0)="S^B:Both populated comment and no Indication field defined;C:Populated Comment Only;I:No Indication field defined"
 .S DIR("A")=PROMPT
 .S DIR("?")=HELP
 .I HELPID>0 S DIR("??")="^D HELP^ORQOCONV("_HELPID_")"
 .D ^DIR
 .S RESULT=Y
 .I Y'="B",Y'="C",Y'="I" Q
 .I Y="B" Q
 .I Y="C" K ARRAY("NOVALUE")
 .I Y="I" K ARRAY("HASVALUE")
 Q RESULT
 ;
WHERE() ;
 N DIR,STR,Y
 S STR="S^A:ALL (excluding personal quick order);M:QO ASSIGNED TO ORDER MENUS, ORDER SETS, OR REMINDER DIALOGS;N:QO NOT ASSIGNED TO ANY OF THESE ITEMS;"
 S STR=STR_"P:PERSONAL QUICK ORDER REPORT;S:SPECIFIC QUICK ORDER;R:REPORT OUTPUT ONLY;Q:QUIT THE UPDATE UTILITY"
 S DIR(0)=STR
 S DIR("A")="Which QO to convert?"
 S DIR("??")="^D HELP^ORQOCONV(1)"
 D ^DIR
 Q Y
 ;
HELP(ID) ;
 N CNT,TEXT
 S CNT=0
 I ID=1 D
 .S CNT=CNT+1,TEXT(CNT)="Select ALL to non personal quick orders\\   \\"
 .S CNT=CNT+1,TEXT(CNT)="Select QO ASSIGNED TO ORDER MENUS, ORDER SETS, OR REMINDER DIALOGS to convert"
 .S CNT=CNT+1,TEXT(CNT)="quick orders that are used in one of the following: Order Menus, Order Sets,"
 .S CNT=CNT+1,TEXT(CNT)="or Reminder Dialogs.\\   \\"
 .S CNT=CNT+1,TEXT(CNT)="Select QO NOT ASSIGNED TO ANY OF THESE ITEMS to convert quick orders that are"
 .S CNT=CNT+1,TEXT(CNT)="not use in the following: Order Menus, Order Sets, or Reminder Dialogs.\\   \\"
 .S CNT=CNT+1,TEXT(CNT)="Select PERSONAL QUICK ORDER REPORT this option create a list of all personal quick orders"
 .S CNT=CNT+1,TEXT(CNT)="by user that meets the search criteria.\\   \\"
 .S CNT=CNT+1,TEXT(CNT)="Select REPORT OUTPUT ONLY to display a report of the Quick Orders that need to be reviewed"
 .S CNT=CNT+1,TEXT(CNT)="Select SPECIFIC QUICK ORDER to convert an individual quick order."
 I ID=2 S CNT=CNT+1,TEXT(CNT)="Select E to edit the quick order. Select K to skip this quick order and move to the next one. Select Q to exit the conversion utility."
 I ID=3 S CNT=CNT+1,TEXT(CNT)="Select a specific quick order type to search for."
 I ID=4 D
 .S CNT=CNT+1,TEXT(CNT)="Select B to search for Quick Orders that have text in the comment field and the indication field is blank.\\   \\"
 .S CNT=CNT+1,TEXT(CNT)="Select C to search for Quick Orders that have text in the comment field and the indication field can either be blank or defined.\\   \\"
 .S CNT=CNT+1,TEXT(CNT)="Select I to search for Quick Orders that have a blank indication field."
 I ID=5 D
 .S CNT=CNT+1,TEXT(CNT)="Select a specific quick order type to search for or select All medication and supplies Quick Orders to search for all the listed quick order types."
 I ID=6 D
 .S CNT=CNT+1,TEXT(CNT)="Select A to show all fields in the quick order report or select F to only display the fields the conversion utility is checking against"
 D FORMAT(.TEXT)
 Q
 ;
