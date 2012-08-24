PXRMORED ; SLC/AGP - Reminder Order Checks Editor ;04/26/2012
 ;;2.0;CLINICAL REMINDERS;**22**;Feb 04, 2005;Build 160
 ;
 Q
 ;
ADD(INPUT,FILENUM) ;
 ;Add code is used when creating a new orderable item group
 N DA,DIC,Y,DTOUT,DUOUT,DTYP,DLAYGO,NEW
 S DIC=$S(FILENUM=801.1:"^PXD(801.1,",1:"^PXD(801,")
 ;Set the starting place for additions.
 I INPUT="E" S DIC(0)="AELQ",DLAYGO=FILENUM
 I INPUT="I" S DIC(0)="AEQ"
 S DIC("A")=$S(FILENUM=801.1:"Select Reminder Order Check Rule: ",1:"Reminder Order Check Item Group: ")
 D ^DIC
 I $D(DUOUT)!($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 K DIC Q
 S NEW=+$P(Y,U,3)
 I INPUT="I" D  Q
 .N BY,DC,DHD,FLD,FR,HTEXT,IENN,NOW,TO
 .S FLDS="[PXRM ORDER CHECK ITEMS GROUP]"
 .S HTEXT="REMINDER ORDER CHECK ITEMS GROUP INQUIRY"
 .I FILENUM=801.1 D
 ..S FLDS="[PXRM ORDER CHECK RULE INQUIRY]"
 ..S HTEXT="REMINDER ORDER CHECK RULE INQUIRY"
 .D SET^PXRMINQ(Y,HTEXT)
 .;NAME OF PRINT TEMPLATE SHOULD BE CHANGED?
 .D DISP^PXRMINQ(DIC,FLDS)
 I INPUT="E" D EDIT(+Y,FILENUM,NEW)
 Q
 ;
BUILD(FILENUM,REF,INPUT,ITEM,CNT,ALPHA,MATCH) ;
 ;build a list of orderable item group entries that contain ITEM
 N ARRAY,IEN,NAME
 K ^TMP($J,"PXRMORCL")
 S CNT=0
 S IEN=0 F  S IEN=$O(^PXD(FILENUM,REF,ITEM,IEN)) Q:IEN'>0  D
 .S NAME=$P(^PXD(FILENUM,IEN,0),U)
 .S ARRAY(NAME)=IEN
 I '$D(ARRAY) W !,"No matching "_$S(FILENUM=801.1:"order check rules",1:"order check items group")_" found." Q 0
 ;
 ;build output display text in alpha array this loop is used to build
 ;a format for the DIR call can use in the SELECT line tag
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
 .N BY,DIC,DHD,FLDS,FR,GBL,HTEXT,L,PXRMROOT,TO
 .S GBL=$S(FILENUM=801:"^PXD(801,",1:"^PXD(801.1,")
 .S (DIC,PXRMROOT)=GBL
 .S FLDS="[PXRM ORDER CHECK ITEMS GROUP]"
 .S HTEXT="REMINDER ORDER CHECK ITEMS GROUP INQUIRY"
 .I FILENUM=801.1 D
 ..S FLDS="[PXRM ORDER CHECK RULE INQUIRY]"
 ..S HTEXT="REMINDER ORDER CHECK RULE INQUIRY"
 .S L=0,L(0)=1,BY=.01,BY(0)="^TMP($J,""PXRMORCL""",FR="",TO=""
 .S DHD="@@"
 .D EN1^DIP
 K ^TMP($J,"PXRMORCL")
 Q
 ;
DELTXT(IEN) ;
 ;delete the order check text called when the order check text
 ;is no longer valid for order check rule
 N DA,DIK,TEMP
 I '$D(^PXD(801.1,IEN,4)) Q
 W !,"Deleting order check output text"
 S DA(1)=IEN
 S DIK="^PXD(801.1,"_DA(1)_",4,"
 S DA=0 F  S DA=$O(^PXD(801.1,DA(1),4,DA)) Q:DA'>0  S TEMP(DA)=""
 S DA=0 F  S DA=$O(TEMP(DA)) Q:DA'>0  D ^DIK
 S ^PXD(801.1,IEN,5)=0
 Q
 ;
EDIT(DA,FILENUM,NEW) ;
 ;PXRMNOIG is used in the template to control editing of fields for
 ;National Orderable Item Groups
 N DIDEL
 S DIDEL=FILENUM
 I FILENUM=801 D SMANEDIT^PXRMOCG(DA,NEW) Q
 I FILENUM=801.1 D SMANEDIT^PXRMOCR(DA,NEW) Q
 Q
 ;
EN(INPUT,FILENUM) ;
EN1 ;
 ;inital editor and inquiry entry point. This controls which
 ;way to select an order check group to edit, inquiry, or to add a new
 ;one. Input="E" editing/adding an entry Input="I" doing an inquiry
 N CNT,DIR,HTEXT,TAG,TYPE
 S TYPE=$S(FILENUM=801.1:"Order Check Rule",1:"Order Check Items Group")
 S CNT=0
 S CNT=CNT+1,HTEXT(CNT)="\\Select 'N' to select an "_TYPE_" name."
 I FILENUM=801 S CNT=CNT+1,HTEXT(CNT)="\\Select 'C' to select an "_TYPE_" by Drug Class"
 I FILENUM=801 S CNT=CNT+1,HTEXT(CNT)="\\Select 'D' to select an "_TYPE_" by Drug"
 I FILENUM=801 S CNT=CNT+1,HTEXT(CNT)="\\Select 'G' to select an "_TYPE_" by VA Generic"
 I FILENUM=801 S CNT=CNT+1,HTEXT(CNT)="\\Select 'O' to select an "_TYPE_" by an Orderable Item"
 I FILENUM=801 S CNT=CNT+1,HTEXT(CNT)="\\Select 'R' to select an "_TYPE_" by an Order Check Rule"
 I FILENUM=801.1 S CNT=CNT+1,HTEXT(CNT)="\\Select 'R' to select an "_TYPE_" by a Reminder Definition."
 I FILENUM=801.1 S CNT=CNT+1,HTEXT(CNT)="\\Select 'T' to select an "_TYPE_" by a Reminder Term."
 S CNT=CNT+1,HTEXT(CNT)="\\Select Q to Quit"
 S DIR(0)="SB^"
 ;
 S CNT=1
 S DIR("A")="Select Reminder "_TYPE_" by"
 S DIR("A",CNT)="     N:  "_$$UP^XLFSTR(TYPE)_" NAME"
 I FILENUM=801 S CNT=CNT+1,DIR("A",CNT)="     C:  VA DRUG CLASS"
 I FILENUM=801 S CNT=CNT+1,DIR("A",CNT)="     D:  DRUG"
 I FILENUM=801 S CNT=CNT+1,DIR("A",CNT)="     G:  VA GENERIC"
 I FILENUM=801 S CNT=CNT+1,DIR("A",CNT)="     O:  ORDERABLE ITEM"
 I FILENUM=801 S CNT=CNT+1,DIR("A",CNT)="     R:  ORDER CHECK RULE"
 I FILENUM=801.1 S CNT=CNT+1,DIR("A",CNT)="     R:  REMINDER DEFINITION"
 I FILENUM=801.1 S CNT=CNT+1,DIR("A",CNT)="     T:  REMINDER TERM"
 S CNT=CNT+1,DIR("A",CNT)="     Q:  QUIT"
 S CNT=CNT+1,DIR("A",CNT)=" "
 I FILENUM=801 S DIR(0)=DIR(0)_"N:ORDER CHECK ITEM GROUP NAME;C:VA DRUG CLASS;D:DRUG;G:VA GENERIC;O:ORDERABLE ITEM;R:ORDER CHECK RULE;Q:QUIT"
 I FILENUM=801.1 S DIR(0)=DIR(0)_"N:ORDER CHECK RULE NAME;R:REMINDER DEFINITION;T:REMINDER TERM;Q:QUIT"
 ;
 S DIR("B")="N"
 S DIR("?")="Select one of the above option or '^' to quit. Enter ?? for detail help."
 S DIR("??")=U_"D HELP^PXRMEUT(.HTEXT)"
 W !,"Select Reminder "_TYPE_" by one of the following:",!!
 D ^DIR
 I Y="Q" Q
 I Y[U Q
 I $D(DTOUT) Q  ;PXRM*2*22 RMS
 D FIND(Y,INPUT,FILENUM)
 G EN1
 Q
 ;
FIND(TYPE,INPUT,FILENUM) ;
FIND1 ;
 ;general file look-up
 N DIC,IEN,ROOT,SCREEN,Y
 I TYPE="N" D ADD(INPUT,FILENUM) Q
 I TYPE="C" S ROOT="^PS(50.605,"
 I TYPE="D" S ROOT="^PSDRUG("
 I TYPE="G" S ROOT="^PSNDF(50.6,"
 I TYPE="O" S ROOT="^ORD(101.43,"
 I TYPE="T" S ROOT="^PXRMD(811.5,"
 I TYPE="R" S ROOT=$S(FILENUM=801.1:"^PXD(811.9,",1:"^PXD(801.1,")
 S DIC=ROOT
 S DIC(0)="AEMOQ"
 I ROOT="^PXD(811.9," S DIC("S")="I $P($G(^(100)),U,4)[""O"""
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT))!(Y=-1) Q
 I TYPE="N",+Y>0 D EDIT(+Y,801,0) Q
 ;TYPE matches the xref on file 801.
 D SELECT(TYPE,INPUT,+Y,FILENUM)
 K Y G FIND1
 Q
 ;
HASDEF(DA) ;
 I $P($G(^PXD(801.1,DA,3)),U)>0 Q 1
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
NAT(DA,FILENUM) ;
 ;used by the input template to control editing of fields
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 I $G(PXRMINST)=1 Q 0
 I $P($G(^PXD(FILENUM,DA,100)),U)="N" Q 1
 Q 0
 ;
RULEUSEB(RULE) ;
 N IEN,NAME
 I '$D(^PXD(801,"R",RULE)) Q
 W !,"Rule in use by:"
 S IEN=0 F  S IEN=$O(^PXD(801,"R",RULE,IEN)) Q:IEN'>0  D
 .S NAME=$P($G(^PXD(801,IEN,0)),U) Q:NAME=""
 .W !,"   "_NAME
 Q
 ;
RULEIUSE(RULE) ;
 I $D(^PXD(801,"R",RULE)) Q 0
 Q 1
 ;
PHARMINQ ;
 N DIEW,DIWF,DIWL,NAME,PAD,X
 S DIWF="C80",DIWL=2
 S NAME="",PAD="   "
 F  S NAME=$O(^PXD(801,D0,1.5,"PIDO",NAME)) Q:NAME=""  D
 .S X=PAD_NAME
 .D ^DIWP
 Q
 ;
RULEINQ(FILENUM) ;
 ;this entry point is used to build the RULE multiple output for the
 ;INQUIRY option
 ;
 N DIEW,DIWF,DIWL,PAD,RIEN,RJC,NODE,NODE100,X
 K ^TMP($J,"W")
 I FILENUM=801 S RIEN=$G(^PXD(801,D0,3,D1,0))
 I FILENUM=801.1 S RIEN=D0
 D WPFORMAT(RIEN,1)
 D WPFORMAT(RIEN,4)
 S RJC=20,PAD=" "
 S DIWF="C80",DIWL=2
 S NODE=$G(^PXD(801.1,RIEN,0))
 S X=$$RJ^XLFSTR("Rule Name:",RJC,PAD)
 S X=X_" "_$P(NODE,U)
 D ^DIWP
 S X=$$RJ^XLFSTR("Display Name:",RJC,PAD)
 S X=X_" "_$P(NODE,U,2)
 D ^DIWP
 S NODE100=$G(^PXD(801.1,RIEN,100))
 S X=$$RJ^XLFSTR("Class:",RJC,PAD)
 S X=X_" "_$S($P(NODE100,U)="L":"Local",$P(NODE100,U)="V":"VISN",1:"National")
 D ^DIWP
 S X=$$RJ^XLFSTR("Sponsor:",RJC,PAD)
 I $P(NODE100,U,2)>0 S X=X_" "_$P($G(^PXRMD(811.6,$P(NODE100,U,2),0)),U)
 D ^DIWP
 S X=$$RJ^XLFSTR("Review Date:",RJC,PAD)
 I $P(NODE100,U,3)>0 S X=X_" "_$$FMTE^XLFDT($P(NODE100,U,3))
 D ^DIWP
 S X=$$RJ^XLFSTR("Status:",RJC,PAD)
 S X=X_" "_$S($P(NODE,U,3)="I":"Inactive",$P(NODE,U,3)="P":"Production",$P(NODE,U,3)="T":"Testing")
 D ^DIWP
 S X=$$RJ^XLFSTR("Severity:",RJC,PAD)
 S X=X_" "_$S($P(NODE,U,5)=1:"High",$P(NODE,U,5)=2:"Medium",1:"Low")
 D ^DIWP
 I $P($G(^PXD(801.1,RIEN,2)),U)'="" D  Q
 .S X=" " D ^DIWP
 .S NODE=$G(^PXD(801.1,RIEN,2))
 .S X=$$RJ^XLFSTR("Reminder Term:",RJC,PAD)
 .S X=X_" "_$P($G(^PXRMD(811.5,$P(NODE,U),0)),U)
 .D ^DIWP
 .S X=$$RJ^XLFSTR("Reminder Term Status:",RJC,PAD)
 .S X=X_" "_$S($P(NODE,U,2)=1:"TRUE",1:"FALSE")
 .D ^DIWP
 .D WPOUT(4,"Order Check Text",RJC,PAD)
 .D WPOUT(1,"Rule Description",RJC,PAD)
 S X=" " D ^DIWP
 S NODE=$G(^PXD(801.1,RIEN,3)) I +$P(NODE,U)=0 G RULEINQX
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
RNXHELP ;Executable help for RULE NAME.
 N TEXT
 S TEXT(1)="Select an existing rule assigned to the order check items group to edit the rule."
 D EN^DDIOL(.TEXT)
 Q
 ;
SELECT(REF,INPUT,ITEM,FILENUM) ;
 ;if requested to find an orderable item group by Orderable, Definition,
 ;term this line tag is used
 ;
 N ALPHA,CNT,DIROUT,DIRUT,DIR,DONE,MATCH,NAME
 I REF="C"!(REF="D")!(REF="G") D
 .S ITEM=ITEM_$S(REF="D":";PSDRUG(",REF="C":";PS(50.605,",REF="G":";PSNDF(50.6,",1:"")
 .S REF="P"
 ;build array by name of rules containing ITEM
 D BUILD(FILENUM,REF,INPUT,ITEM,.CNT,.ALPHA,.MATCH)
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
 .D EDIT(IEN,FILENUM,0)
 .;rebuild build array by name of rules containing ITEM
 .D BUILD(REF,INPUT,ITEM,.CNT,.ALPHA,.MATCH)
 Q
 ;
SNOCTL(DA) ;
 ;set the number of lines in the order check text multiple
 N NUM,NOLC,PIPECNT
 S (NUM,NOLC,PIPECNT)=0
 F  S NUM=$O(^PXD(801.1,DA,4,NUM)) Q:NUM'>0  D
 .S PIPECNT=PIPECNT+$L(^PXD(801.1,DA,4,NUM,0),"|")-1
 .S NOLC=NOLC+1
 I (PIPECNT#2)=1 D TIUOBJW^PXRMFNFT("Order Check Text",PIPECNT)
 I PIPECNT>0 S NOLC=NOLC_"T"
 S ^PXD(801.1,DA,5)=NOLC
 Q
 ;
WPFORMAT(RIEN,SUB) ;
 ;use for inquiry, build word-processing fields to be used later
 ;because of DIWP API
 ;
 N CNT,NLINES,NUM,TEXTIN,TEXTOUT,TITLE
 I '$D(^PXD(801.1,RIEN,SUB)) Q
 S CNT=0,NUM=0
 F  S CNT=$O(^PXD(801.1,RIEN,SUB,CNT)) Q:CNT'>0  D
 .S NUM=NUM+1,TEXTIN(NUM)=$G(^PXD(801.1,RIEN,SUB,CNT,0))
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
