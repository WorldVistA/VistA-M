PXRMORCH ; SLC/AGP - Reminder Order Checks ;6/11/2010
 ;;2.0;CLINICAL REMINDERS;**16**;Feb 04, 2005;Build 119
 ;
 Q
 ;
ADD(INPUT) ;
 ;Add code is used when creating a new orderable item group
 N DA,DIC,Y,DTOUT,DUOUT,DTYP,DLAYGO
 S DIC="^PXD(801,"
 ;Set the starting place for additions.
 I INPUT="E" S DIC(0)="AELMQ",DLAYGO=801
 I INPUT="I" S DIC(0)="AEMQ"
 S DIC("A")="Select Reminder Order Check Rule: "
 D ^DIC
 I $D(DUOUT)!($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 K DIC Q
 I INPUT="I" D  Q
 .N BY,DC,DHD,FR,HTEXT,IENN,NOW,TO
 .S HTEXT="REMINDER ORDERABLE ITEM GROUP INQUIRY"
 .D SET^PXRMINQ(Y,HTEXT)
 .;NAME OF PRINT TEMPLATE SHOULD BE CHANGED?
 .D DISP^PXRMINQ("^PXD(801,","[PXRM ORDERABLE ITEM GROUP LIST]")
 I INPUT="E" D EDIT(+Y)
 Q
 ;
BUILD(REF,INPUT,ITEM,CNT,ALPHA,MATCH) ;
 ;build a list of orderable item group entries that contain ITEM
 N ARRAY,IEN,NAME
 K ^TMP($J,"PXRMORCL")
 S CNT=0
 S IEN=0 F  S IEN=$O(^PXD(801,REF,ITEM,IEN)) Q:IEN'>0  D
 .S NAME=$P(^PXD(801,IEN,0),U)
 .S ARRAY(NAME)=IEN
 I '$D(ARRAY) W !,"No matching orderable item group found." Q 0
 ;
 ;build output display text in array alpha this loop is used to build
 ;a format the DIR call can use in the SELECT line tag
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S IEN=ARRAY(NAME)
 .;
 .;if use for inquiry build temp global for inquiry
 .I INPUT="I" S ^TMP($J,"PXRMORCL",IEN)="" Q
 .;
 .S CNT=CNT+1,ALPHA(CNT)=$$RJ^XLFSTR(CNT,4," ")_" "_NAME
 .S MATCH(CNT,IEN)=NAME
 ;
 I INPUT="I" D
 .N BY,DIC,DHD,FLDS,FR,HTEXT,L,PXRMROOT,TO
 .S (DIC,PXRMROOT)="^PXD(801,"
 .S FLDS="[PXRM ORDERABLE ITEM GROUP LIST]"
 .S L=0,L(0)=1,BY=.01,BY(0)="^TMP($J,""PXRMORCL""",FR="",TO=""
 .S HTEXT="REMINDER ORDERABLE ITEM GROUP INQUIRY"
 .S DHD="@@"
 .D EN1^DIP
 K ^TMP($J,"PXRMORCL")
 Q
 ;
CHECK(IEN) ;
 ;This sub routine is called after an edit is done. It validate the
 ;data in the entry. If a rule is incomplete the entry is marked
 ;inactive.
 ;
 N CNT,LOOP,NODE,PIECE,RESULT,RARRAY,RIEN,RNAME,RNODE,ROUT,TNODE,TXT
 ;Quit if no rules are defined
 S RESULT=0
 I $G(IEN(1))="" Q
 I '$D(^PXD(801,IEN(1),3,"B")) Q
 W !,"Checking for errors"
 S RIEN=0 F  S RIEN=$O(^PXD(801,IEN(1),3,RIEN)) Q:RIEN'>0  D
 .S CNT=0
 .S NODE=$G(^PXD(801,IEN(1),3,RIEN,0))
 .;check to see if a rule is defined if not report error and quit
 .S RNAME=$P(NODE,U) I RNAME="" D  Q
 ..S TXT(1)="Rule IEN: "_RIEN_" does not have a name defined."
 ..D DISABLE(IEN(1),RIEN,1,TXT)
 .;loop through the zero node to determine if all the fields are defined
 .F PIECE=2:1:5 D
 ..I $P(NODE,U,PIECE)="" D
 ...S CNT=CNT+1,TXT(CNT)="\\Rule "_RNAME_" does not have a value defined in the "_$S(PIECE=2:"Print Name",PIECE=3:"Active Flag",PIECE=4:"Testing Flag",PIECE=5:"Severity")_" flag."
 .S RNODE=$G(^PXD(801,IEN(1),3,RIEN,3))
 .S TNODE=$G(^PXD(801,IEN(1),3,RIEN,2))
 .;check for an existance of either a term node or a definition node
 .I $P(RNODE,U)="",$P(TNODE,U)="" D
 ..S CNT=CNT+1,TXT(CNT)="\\Rule "_RNAME_" does not have a reminder term or a reminder defintion defined."
 .I $P(RNODE,U)'="",$P(TNODE,U)'="" D
 ..S CNT=CNT+1,TXT(CNT)="\\Rule "_RNAME_" has both a reminder term or a reminder defintion defined."
 .;check on the term node
 .I +$P(TNODE,U)>0 D
 ..I $P(TNODE,U,2)="" D
 ...S CNT=CNT+1,TXT(CNT)="\\Rule "_RNAME_" does not have a reminder term status value defined."
 ..I +$G(^PXD(801,IEN(1),3,RIEN,5))=0 D
 ...S CNT=CNT+1,TXT(CNT)="\\Rule "_RNAME_" does not have the order check text defined."
 .;check on ther definition node
 .I +$P(RNODE,U)>0 D
 ..I $P(RNODE,U,2)="" D
 ...S CNT=CNT+1,TXT(CNT)="\\Rule "_RNAME_" does not have a value for the reminder definition status."
 ..I $P(RNODE,U,3)="" D
 ...S CNT=CNT+1,TXT(CNT)="\\Rule "_RNAME_" does not have an output text value defined."
 ..I $P(RNODE,U,3)="O"!($P(RNODE,U,3)="B") D
 ...I +$G(^PXD(801,IEN(1),3,RIEN,5))=0 D
 ....S CNT=CNT+1,TXT(CNT)="\\Rule "_RNAME_" does not have the order check text defined."
 .I CNT>0 D DISABLE(IEN(1),RIEN,.CNT,.TXT) S RESULT=1
 I RESULT=0 W !!,"No errors found.",!!
 Q
 ;
DELTXT(IEN) ;
 ;delete the order check text called when the order check text
 ;is no longer valid for order check rule
 N DA,DIK,TEMP
 I '$D(^PXD(801,IEN(1),3,IEN,4)) Q
 W !,"Deleting order check output text"
 S DA(2)=IEN(1),DA(1)=IEN
 S DIK="^PXD(801,"_DA(2)_",3,"_DA(1)_",4,"
 S DA=0 F  S DA=$O(^PXD(801,DA(2),3,DA(1),4,DA)) Q:DA'>0  S TEMP(DA)=""
 S DA=0 F  S DA=$O(TEMP(DA)) Q:DA'>0  D ^DIK
 S ^PXD(801,IEN(1),3,IEN,5)=0
 Q
 ;
DISABLE(GIEN,RIEN,CNT,TXTIN) ;
 ;this is used to inactive an incomplete rule
 N DA,DIE,DR,LC,NOUT,TEXTOUT
 S CNT=CNT+1,TXTIN(CNT)="\\\\Reminder Order Check Rule made inactive. Please correct the above errors"
 D FORMAT^PXRMTEXT(1,75,CNT,.TXTIN,.NOUT,.TEXTOUT)
 F LC=1:1:NOUT W !,TEXTOUT(LC)
 W !!
 S DA(1)=GIEN,DA=RIEN,DIE="^PXD(801,"_DA(1)_",3,",DR="2///NO"
 D ^DIE
 Q
 ;
EDIT(DA) ;
 ;PXRMNOIG is used in the template to control editing of fields for
 ;National Orderable Item Groups
 N CS1,CS2,DIDEL,DIE,DINUSE,DR,PXRMNOIG
 I DA>0 S CS1=$$FILE^PXRMEXCS(801,DA)
 S DIDEL=801,DIE="^PXD(801,",DINUSE=0
 S DR="[PXRM EDIT ORDER CHECK]"
 D ^DIE
 I +$G(DA)'>0 Q
 S CS2=$$FILE^PXRMEXCS(801,DA) Q:CS2=CS1  Q:+CS2=0
 S DIC="^PXD(801,"
 D SEHIST^PXRMUTIL(801,DIC,DA)
 D CHECK(.DA)
 Q
 ;
EN(INPUT) ;
EN1 ;
 ;inital editor and inquiry entry point. This controls which
 ;way to select an order check group to edit, inquiry, or to add a new
 ;one. Input="E" editing/adding an entry Input="I" doing an inquiry
 N CNT,DIR,HTEXT,TAG
 S CNT=0
 S CNT=CNT+1,HTEXT(CNT)="\\Select 'N' to select an orderable item group by a group name."
 S CNT=CNT+1,HTEXT(CNT)="\\Select 'D' to select an orderable item group by Drug Class"
 S CNT=CNT+1,HTEXT(CNT)="\\Select 'O' to select an orderable item group by an Orderable Item"
 S CNT=CNT+1,HTEXT(CNT)="\\Select 'R' to select an orderable item group by a Reminder Definition."
 S CNT=CNT+1,HTEXT(CNT)="\\Select 'T' to select an orderable item group by a Reminder Term."
 S CNT=CNT+1,HTEXT(CNT)="\\Select Q to Quit"
 S DIR(0)="SB^"
 ;
 S DIR("A")="Select Reminder Orderable Item Group by"
 S DIR("A",1)="     N:  ORDERABLE ITEM GROUP NAME"
 S DIR("A",2)="     D:  DRUG CLASS"
 S DIR("A",3)="     O:  ORDERABLE ITEM"
 S DIR("A",4)="     R:  REMINDER DEFINITION"
 S DIR("A",5)="     T:  REMINDER TERM"
 S DIR("A",6)="     Q:  QUIT"
 S DIR("A",7)=" "
 S DIR(0)=DIR(0)_"N:ORDERABLE ITEM GROUP NAME;D:DRUG CLASS;O:ORDERABLE ITEM;R:REMINDER DEFINITION;T:REMINDER TERM;Q:QUIT"
 ;
 S DIR("B")="N"
 S DIR("?")="Select one of the above option or '^' to quit. Enter ?? for detail help."
 S DIR("??")=U_"D HELP^PXRMEUT(.HTEXT)"
 W !,"Select Reminder Orderable Item Group by one of the following:",!!
 D ^DIR
 I Y="Q" Q
 I Y[U Q
 D FIND(Y,INPUT)
 G EN1
 Q
 ;
FIND(TYPE,INPUT) ;
FIND1 ;
 ;general file look-up
 N DIC,IEN,ROOT,SCREEN,Y
 I TYPE="N" D ADD(INPUT) Q
 I TYPE="D" S ROOT="^PS(50.605,"
 I TYPE="O" S ROOT="^ORD(101.43,"
 I TYPE="T" S ROOT="^PXRMD(811.5,"
 I TYPE="R" S ROOT="^PXD(811.9,"
 S DIC=ROOT
 S DIC(0)="AEMOQ"
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT))!(Y=-1) Q
 I TYPE="N",+Y>0 D EDIT(+Y) Q
 ;TYPE matches the xref on file 801.
 D SELECT(TYPE,INPUT,+Y)
 K Y G FIND1
 Q
 ;
GETOCTXT(DFN,IEN,RULEIEN,OI,SEV,PNAME,CNT) ;
 ;this get the order check text out of file 801. It also format and
 ;expand any TIU Objects and stores the results in the temp global
 N LC,NIN,NLINES,NOUT,PXRMRM,TEXT,TEXTIN,TEXTOUT
 ;
 S NIN=$G(^PXD(801,IEN,3,RULEIEN,5))
 I +NIN=0 Q
 S NLINES=0,PXRMRM=80
 ;
 ;if text contains a TIU Object call the Found/Not Found Text expansion
 I NIN["T" D
 .F LC=1:1:+NIN S TEXTIN(LC)=$G(^PXD(801,IEN,3,RULEIEN,4,LC,0))
 .D FNFTXTO^PXRMFNFT(1,+NIN,.TEXTIN,DFN,"",.NLINES,.TEXT)
 ;
 ;if it does not contain the TIU Object call the normal format code
 I NIN'["T" D
 .F LC=1:1:NIN S TEXTIN(LC)=$G(^PXD(801,IEN,3,RULEIEN,4,LC,0))
 .D FORMAT^PXRMTEXT(1,PXRMRM,NIN,.TEXTIN,.NLINES,.TEXT)
 ;
 ;put the output in the TMP global
 F LC=1:1:NLINES S CNT=CNT+1,^TMP($J,OI,SEV,PNAME,CNT)=TEXT(LC)
 Q
 ;
HASDEF(DA) ;
 I $P($G(^PXD(801,DA(1),3,DA,3)),U)>0 Q 1
 Q 0
 ;
HELP(TYPE) ;
 N LC,NIN,NLINES,NOUT,TEXT,TEXTIN,TEXTOUT
 I TYPE=1 D
 .S TEXTIN(1)="Select 'Yes' to add all orderable items by a specific drug class."
 .S TEXTIN(2)="After the orderable items are added the user will be able to do additional edits to the orderable item list."
 .S TEXTIN(3)="\\Select 'No' if not adding medication orderable items,or not adding all orderable items for a drug class."
 .S NIN=3
 I '$D(TEXTIN) Q
 D FORMAT^PXRMTEXT(1,75,NIN,.TEXTIN,.NLINES,.TEXT)
 ;write out the output
 F LC=1:1:NLINES D
 .S CNT=CNT+1 W !,TEXT(LC)
 Q
 ;
NAT(DA) ;
 ;used by the input template to control editing of fields
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 I $G(PXRMINST)=1 Q 0
 I $P($G(^PXD(801,DA,100)),U)="N" Q 1
 Q 0
 ;
ORDERCHK(DFN,OI,TEST,TESTER) ;
 ;main order check API
 ;Input
 ;  OI=IEN of Orderable Item from file 101.43
 ;  DFN=Patient DFN
 ;  TEST=Value that matches the Testing Flag either 1 or 0
 ;
 ;Output
 ;  ^TMP($J,OI,SEV,DISPLAY NAME,n)=TEXT
 ;  SEV=is the value assigned to the severity field
 ;  DISPLAY NAME=is the value assigned to the Display Field Name
 ;
 K ^TMP($J,OI)
 N CNT,IEN,IENOI,IENR,NODE,NUM,OIREM,PNAME,RIEN,RNAME
 N RULEIEN,REMEVLST,RSTAT,SEV,TEXTTYPE,TIEN,TNAME,TSTAT
 ;
 ;loop through AOIR xref to find the group IEN and the corresponding
 ;Rules assigned to the orderable item
 ;
 S IEN=0 F  S IEN=$O(^PXD(801,"AOIR",OI,TEST,IEN)) Q:IEN'>0  D
 .S RULEIEN=0
 .F  S RULEIEN=$O(^PXD(801,"AOIR",OI,TEST,IEN,RULEIEN)) Q:RULEIEN'>0  D 
 ..;
 ..S NODE=$G(^PXD(801,IEN,3,RULEIEN,0))
 ..S PNAME=$P(NODE,U,2)
 ..S SEV=$P(NODE,U,5)
 ..S TIEN=$P($G(^PXD(801,IEN,3,RULEIEN,2)),U)
 ..;
 ..;Reminder Term defined used branching logic code
 ..I TIEN>0 D  Q
 ...S TSTAT=$$TERM^PXRMDLLB(TIEN,DFN,RULEIEN,"O")
 ...S CNT=0
 ...I TESTER=1 D
 ....S TNAME=$P(^PXRMD(811.5,TIEN,0),U)
 ....S CNT=CNT+1,^TMP($J,OI,SEV,PNAME,CNT)="INTERNAL: Reminder Term: "_TNAME_" Status: "_$S(TSTAT=1:"True",1:"False")
 ....S CNT=CNT+1,^TMP($J,OI,SEV,PNAME,CNT)=" "
 ...I TSTAT'=$P(^PXD(801,IEN,3,RULEIEN,2),U,2) Q
 ...;load order check text needs to be converted
 ...D GETOCTXT(DFN,IEN,RULEIEN,OI,SEV,PNAME,.CNT)
 ..;if not TERM do reminder evaluation
 ..S NODE=$G(^PXD(801,IEN,3,RULEIEN,3))
 ..S RIEN=$P(NODE,U),RSTAT=$P(NODE,U,2),TEXTTYPE=$P(NODE,U,3)
 ..S NODE=$G(^PXD(811.9,RIEN,0))
 ..;
 ..S RNAME=$S($P(NODE,U,3)'="":$P(NODE,U,3),1:$P(NODE,U))
 ..D REMEVAL(DFN,OI,RIEN,PNAME,IEN,RULEIEN,RNAME,TEXTTYPE,RSTAT,SEV,TESTER)
 Q
 ;
 ;
REMEVAL(DFN,OI,RIEN,PNAME,IEN,RULEIEN,RNAME,TEXTTYE,RSTAT,SEV,TESTER) ;
 ;used by ORDECHK this does the reminder evaluation and put the
 ;reminder text in the temp global
 K ^TMP("PXRHM",$J),^TMP("PXRMORTMP",$J)
 N CNT,NUM,STATUS
 S CNT=0
 ;
 ;standard reminder evaluation results, final output like the
 ;HS COMPONENT REMINDER FINDINGS
 ;
 D MAIN^PXRM(DFN,RIEN,55,1)
 S STATUS=$P($G(^TMP("PXRHM",$J,RIEN,RNAME)),U)
 I TESTER=1 D
 .S CNT=CNT+1,^TMP($J,OI,SEV,PNAME,CNT)="INTERNAL: Reminder Definition: "_RNAME_" Status: "_STATUS
 .S CNT=CNT+1,^TMP($J,OI,SEV,PNAME,CNT)=" "
 ;if not valid status quit
 I (STATUS="CNBD")!(STATUS="ERROR") Q
 ;if Reminder Status does not match status field quit.
 I $$STATMTCH(STATUS,RSTAT)=0 Q
 ;save off the evaluation temp global into another global. This
 ;prevent a problem with TIU Objects for reminder evaluation
 M ^TMP("PXRMORTMP",$J)=^TMP("PXRHM",$J)
 ;
 S NUM=0
 ;load order check text if requested
 I TEXTTYPE="O"!(TEXTTYPE="B") D GETOCTXT(DFN,IEN,RULEIEN,OI,SEV,PNAME,.CNT)
 I TEXTTYPE="O" Q
 ;
 I TEXTTYPE="B" S CNT=CNT+1,^TMP($J,OI,SEV,PNAME,CNT)=""
 ;build reminder text if requested
 F  S NUM=$O(^TMP("PXRMORTMP",$J,RIEN,RNAME,"TXT",NUM)) Q:NUM'>0  D
 .S CNT=CNT+1
 .S ^TMP($J,OI,SEV,PNAME,CNT)=$G(^TMP("PXRMORTMP",$J,RIEN,RNAME,"TXT",NUM))
 K ^TMP("PXRHM",$J),^TMP("PXRMORTMP",$J)
 Q
 ;
RNXHELP ;Executable help for RULE NAME.
 N TEXT
 S TEXT(1)="Select an existing rule assigned to the orderable item group to edit the rule."
 S TEXT(2)="Or enter a new rule name to add a rule the orderable item group."
 D EN^DDIOL(.TEXT)
 Q
 ;
RULEINQ ;
 ;this entry point is used to build the RULE multiple output for the
 ;INQUIRY option
 ;
 N DIEW,DIWF,DIWL,PAD,RJC,NODE,X
 K ^TMP($J,"W")
 D WPFORMAT(D0,D1,1)
 D WPFORMAT(D0,D1,4)
 S RJC=20,PAD=" "
 S DIWF="C80",DIWL=2
 S NODE=$G(^PXD(801,D0,3,D1,0))
 S X=$$RJ^XLFSTR("Rule Name:",RJC,PAD)
 S X=X_" "_$P(NODE,U)
 D ^DIWP
 S X=$$RJ^XLFSTR("Display Name:",RJC,PAD)
 S X=X_" "_$P(NODE,U,2)
 D ^DIWP
 S X=$$RJ^XLFSTR("Active Flag:",RJC,PAD)
 S X=X_" "_$S($P(NODE,U,3)=1:"Yes",1:"No")
 D ^DIWP
 S X=$$RJ^XLFSTR("Testing Flag:",RJC,PAD)
 S X=X_" "_$S($P(NODE,U,4)=1:"Yes",1:"No")
 D ^DIWP
 S X=$$RJ^XLFSTR("Severity:",RJC,PAD)
 S X=X_" "_$S($P(NODE,U,5)=1:"High",$P(NODE,U,5)=2:"Medium",1:"Low")
 D ^DIWP
 I $P($G(^PXD(801,D0,3,D1,2)),U)'="" D  Q
 .S X=" " D ^DIWP
 .S NODE=$G(^PXD(801,D0,3,D1,2))
 .S X=$$RJ^XLFSTR("Reminder Term:",RJC,PAD)
 .S X=X_" "_$P($G(^PXRMD(811.5,$P(NODE,U),0)),U)
 .D ^DIWP
 .S X=$$RJ^XLFSTR("Reminder Term Status:",RJC,PAD)
 .S X=X_" "_$S($P(NODE,U,2)=1:"TRUE",1:"FALSE")
 .D ^DIWP
 .D WPOUT(4,"Order Check Text",RJC,PAD)
 .D WPOUT(1,"Rule Description",RJC,PAD)
 S X=" " D ^DIWP
 S NODE=$G(^PXD(801,D0,3,D1,3)) I +$P(NODE,U)=0 G RULEINQX
 S X=$$RJ^XLFSTR("Reminder Definition:",RJC,PAD)
 S X=X_" "_$P($G(^PXD(811.9,$P(NODE,U),0)),U)
 D ^DIWP
 S X=$$RJ^XLFSTR("Definition Status:",RJC,PAD)
 S X=X_" "_$S($P(NODE,U,2)="D":"Due",$P(NODE,U,2)="A":"Applicable",1:"N/A")
 D ^DIWP
 S X=$$RJ^XLFSTR("Output Text:",RJC,PAD)
 S X=X_" "_$S($P(NODE,U,3)="O":"Order Check Text Only",$P(NODE,U,3)="D":"Definition Text Only",1:"Both Order Check and Definition Text")
 D ^DIWP
 D WPOUT(4,"Order Check Text",RJC,PAD)
 D WPOUT(1,"Rule Description",RJC,PAD)
RULEINQX ;
 K ^TMP($J,"W")
 Q
 ;
SELECT(REF,INPUT,ITEM) ;
 ;if requested to find an orderable item group by Orderable, Definition,
 ;term this line tag is used
 ;
 N ALPHA,CNT,DIROUT,DIRUT,DIR,DONE,MATCH,NAME
 ;build array by name of rules containing ITEM
 D BUILD(REF,INPUT,ITEM,.CNT,.ALPHA,.MATCH)
 ;
 I INPUT="I" Q
 I CNT=0 Q
 S DONE=0
 ;allow multiple edits of different orderable item groups
 F  Q:DONE  D
 .M DIR("A")=ALPHA
 .S DIR("A")="Select a reminder orderable item group"
 .S DIR(0)="NO^1:"_CNT
 .W !!,"Select a reminder order check group from the following list:"
 .D ^DIR
 .I (Y="")!(Y["^") S DONE=1 Q
 .I $D(DIROUT)!($D(DIRUT))!($D(DUOUT))!($D(DTOUT)) S DONE=1 Q
 .S IEN=$O(MATCH(Y,"")) I IEN=0 Q
 .D EDIT(IEN)
 .;rebuild build array by name of rules containing ITEM
 .D BUILD(REF,INPUT,ITEM,.CNT,.ALPHA,.MATCH)
 Q
 ;
SNOCTL(DA) ;
 ;set the number of lines in the order check text multiple
 N NUM,NOLC,PIPECNT
 S (NUM,NOLC,PIPECNT)=0
 F  S NUM=$O(^PXD(801,DA(1),3,DA,4,NUM)) Q:NUM'>0  D
 .S PIPECNT=PIPECNT+$L(^PXD(801,DA(1),3,DA,4,NUM,0),"|")-1
 .S NOLC=NOLC+1
 I (PIPECNT#2)=1 D TIUOBJW^PXRMFNFT("Order Check Text",PIPECNT)
 I PIPECNT>0 S NOLC=NOLC_"T"
 S ^PXD(801,DA(1),3,DA,5)=NOLC
 Q
 ;
STATMTCH(REMSTAT,RULESTAT) ;
 I RULESTAT="D",REMSTAT["DUE" Q 1
 I RULESTAT="A",REMSTAT'="N/A",REMSTAT'="NEVER" Q 1
 I RULESTAT="N",$E(REMSTAT,1)="N" Q 1
 Q 0
 ;
WPFORMAT(D0,D1,SUB) ;
 ;use for inquiry, build word-processing fields to be used later
 ;because of DIWP API
 ;
 N CNT,NLINES,NUM,TEXTIN,TEXTOUT,TITLE
 I '$D(^PXD(801,D0,3,D1,SUB)) Q
 S CNT=0,NUM=0
 F  S CNT=$O(^PXD(801,D0,3,D1,SUB,CNT)) Q:CNT'>0  D
 .S NUM=NUM+1,TEXTIN(NUM)=$G(^PXD(801,D0,3,D1,SUB,CNT,0))
 D FORMAT^PXRMTEXT(22,74,NUM,.TEXTIN,.NLINES,.TEXTOUT)
 S ^TMP($J,"W",SUB)=NLINES
 F CNT=1:1:NLINES D
 .S ^TMP($J,"W",SUB,CNT)=TEXTOUT(CNT)
 Q
 ;
WPOUT(SUB,TITLE,RJC,PAD) ;
 ;print out word processing field text used by INQUIRY
 I '$D(^TMP($J,"W",SUB)) Q
 N IND,PADS,X
 S PADS="          "
 S X=$$RJ^XLFSTR(TITLE_":",RJC,PAD)
 D ^DIWP
 F IND=1:1:^TMP($J,"W",SUB) D
 .S X=^TMP($J,"W",SUB,IND)
 .D ^DIWP
 Q
 ;
