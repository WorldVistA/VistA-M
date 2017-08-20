PXRMTAXL ;SLC/PKR - List Manager routines for Taxonomies. ;08/11/2016
 ;;2.0;CLINICAL REMINDERS;**26,47**;Feb 04, 2005;Build 289
 ;
 ;=========================================
ADD ;Add a new entry.
 D CLEAR^VALM1
 N DA,DIC,DLAYGO,DTOUT,DUOUT,NEW,Y
 S DIC="^PXD(811.2,"
 S DIC(0)="AEKLQ"
 S DIC("A")="Enter a new Taxonomy Name: "
 S DLAYGO=811.2
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT))!(Y=-1) S VALMBCK="R" Q
 S NEW=$P(Y,U,3)
 I 'NEW D EN^DDIOL("That entry already exists, use EDIT instead.") H 2
 I NEW D
 . S DA=$P(Y,U,1)
 . D SMANEDIT^PXRMTXSM(DA,1,"PXRM TAXONOMY EDIT")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
BLDLIST(NODE) ;Build of list of Taxomomy file entries.
 N IEN,DESC,FMTSTR,IND,NAME,NL,NUM,OUTPUT,START
 K ^TMP(NODE,$J)
 ;Build the list in alphabetical order.
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLL")
 S (NUM,VALMCNT)=0
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . S NUM=NUM+1
 . S ^TMP(NODE,$J,"SEL",NUM)=IEN
 . S ^TMP(NODE,$J,"IEN",IEN)=NUM
 . S DESC=$G(^PXD(811.2,IEN,1,1,0))
 . I $L(DESC)>40 S DESC=$E(DESC,1,37)_"..."
 . D FORMAT(NUM,NAME,DESC,FMTSTR,.NL,.OUTPUT)
 . S START=VALMCNT+1
 . F IND=1:1:NL D
 .. S VALMCNT=VALMCNT+1,^TMP(NODE,$J,VALMCNT,0)=OUTPUT(IND)
 .. S ^TMP(NODE,$J,"IDX",VALMCNT,NUM)=""
 . S ^TMP(NODE,$J,"LINES",NUM)=START_U_VALMCNT
 S ^TMP(NODE,$J,"VALMCNT")=VALMCNT
 S ^TMP(NODE,$J,"NTAX")=NUM
 Q
 ;
 ;=========================================
CLOG(IEN) ;Display the edit change log.
 D LMCLBROW^PXRMSINQ(811.2,"110*",IEN)
 Q
 ;
 ;=========================================
CLOGS ;Display Change Log for a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Display the change log for which taxonomy?")
 I IEN=0 S VALMBCK="R" Q
 D CLOG(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
CODESRCH ;Let the user input a code and then search for all taxonomies
 ;that include that code.
 D FULL^VALM1
 W @IOF
 D SEARCH^PXRMTXCS
 S VALMBCK="R"
 Q
 ;
 ;=========================================
COPY(IEN) ;Copy a selected entry to a new name.
 D FULL^VALM1
 D COPY^PXRMCPLS(811.2,IEN)
 D BLDLIST^PXRMTAXL("PXRMTAXL")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
COPYS ;Copy a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select taxonomy to copy")
 I IEN=0 S VALMBCK="R" Q
 D COPY(IEN)
 Q
 ;
 ;=========================================
EDITS ;Edit a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select the taxonomy to edit")
 I IEN=0 S VALMBCK="R" Q
 D SMANEDIT^PXRMTXSM(IEN,0,"PXRM TAXONOMY EDIT")
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXRMTAXL
 D BLDLIST^PXRMTAXL("PXRMTAXL")
 D XQORM^PXRMTAXL
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXRMTAXL
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
FORMAT(NUMBER,NAME,DESC,FMTSTR,NL,OUTPUT) ;Format  entry number, name,
 ;and first line of description for LM display.
 N TEMP
 S TEMP=NUMBER_U_NAME_U_DESC
 D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NL,.OUTPUT)
 Q
 ;
 ;=========================================
GETSEL(TEXT) ;Get a single selection
 N DIR,NTAX,X,Y
 S NTAX=+$G(^TMP("PXRMTAXL",$J,"NTAX"))
 I NTAX=0 Q 0
 S DIR(0)="N^1:"_NTAX
 S DIR("A")=TEXT
 D ^DIR
 Q +$G(^TMP("PXRMTAXL",$J,"SEL",+Y))
 ;
 ;=========================================
HELP ;Display help.
 N DDS,DIR0,DONE,IND,TEXT
 ;DBIA #5746 covers kill and set of DDS. DDS needs to be set or the
 ;Browser will kill some ScreenMan variables.
 S DDS=1,DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(HTEXT+IND),";",3,99)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 D BROWSE^DDBR("TEXT","NR","Taxonomy Management Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="Taxonomy File Entries."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=========================================
HTEXT ;Taxonomy mangement help text.
 ;;Select one of the following actions:
 ;; ADD  - add a new taxonomy.
 ;; EDIT - edit a taxonomy.
 ;; UIDE - edit the UID status of the selected codes in a taxonomy.
 ;; COPY - copy an existing taxonomy to a new taxonomy.
 ;; INQ  - taxonomy inquiry.
 ;; CL   - taxonomy change log.
 ;; CS   - code search. Input a code and search for all taxonomies that include
 ;;        the code.
 ;; IMP  - import codes from another taxonomy or a CSV file. Each line of the CSV
 ;;        file should have the format:
 ;;        term/code,coding system,code 1,code 2,...code n
 ;; VSC  - For taxonomies that were generated from a value set, compare the codes
 ;;        in the taxonomy with the codes in the most recent version of the value
 ;;        set. 
 ;;
 ;;You can select the action first and then the entry or choose the entry and then
 ;;the action.
 ;;
 ;;**End Text**
 Q
 ;
 ;=========================================
IMPS ;Import codes into a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select the taxonomy to import into")
 I IEN=0 S VALMBCK="R" Q
 D IMP^PXRMTXIM(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
INITMPG ;Initialize all the ^TMP globals.
 K ^TMP("PXRMTAXL",$J)
 Q
 ;
 ;=========================================
INQ(IEN) ;Taxonomy inquiry.
 D BTAXINQ^PXRMTXIN(IEN)
 Q
 ;
 ;=========================================
INQS ;Display inquiry for selected entries.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Display inquiry for which taxonomy?")
 I IEN=0 S VALMBCK="R" Q
 D INQ(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
PEXIT ; Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM^PXRMTAXL
 Q
 ;
 ;=========================================
START ;Main entry point for PXRM Taxonomy Management
 N VALMBCK,VALMSG,X
 S X="IORESET"
 D ENDR^%ZISS
 D EN^VALM("PXRM TAXONOMY MANAGEMENT")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;=========================================
UIDE(TAXIEN) ;Edit UID for a selected taxonomy.
 K ^TMP("PXRMTAX",$J)
 S ^TMP("PXRMTAX",$J,"TAXIEN")=TAXIEN
 D EN^VALM("PXRM TAXONOMY UID EDIT")
 K ^TMP("PXRMTAX",$J)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
UIDES ;Edit UID for a selected taxonomy.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select the taxonomy for UID edit")
 I IEN=0 S VALMBCK="R" Q
 D UIDE^PXRMTAXL(IEN)
 Q
 ;
 ;=========================================
VSCMP(TAXIEN,VSOID) ;For taxonomies generated from a value compare the codes
 ;in the taxonomy with those in the value set.
 N NL,OUTPUT
 S NL=0
 I VSOID'="" D CMPTXVS^PXRMVSTX(IEN,VSOID,.NL,.OUTPUT)
 I VSOID="" S NL=NL+1,OUTPUT(NL)="This taxonomy was not generated from a value set."
 D BROWSE^DDBR("OUTPUT","NR","Taxonomy Value Set Code Comparison")
 Q
 ;
 ;=========================================
VSCMPS ;Value set comparison.
 N DIR,IEN,VSOID,X,Y
 S DIR(0)="SAB"_U_"A:All;O:One"
 S DIR("A")="Compare one taxonomy or all? "
 S DIR("B")="O"
 D ^DIR
 I Y="A" D CMPALL^PXRMVSTX("B")
 I Y="O" D
 .;Get the single entry
 . S IEN=+$$GETSEL("Value sets comparison for which taxonomy?")
 . I IEN=0 S VALMBCK="R" Q
 . S VSOID=$P($G(^PXD(811.2,IEN,40)),U,1)
 . D VSCMP(IEN,VSOID)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
XQORM ;Set range for selection.
 N NTAX
 S NTAX=^TMP("PXRMTAXL",$J,"NTAX")
 S XQORM("#")=$O(^ORD(101,"B","PXRM TAXONOMY SELECT ENTRY",0))_U_"1:"_NTAX
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PXRM TAXONOMY SELECT ENTRY.
 N CLASS,EDITOK,IEN,SEL,VSOID
 S SEL=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(SEL,$L(SEL))="," S SEL=$E(SEL,1,$L(SEL)-1)
 ;Invalid selection
 I SEL["," D  Q
 . W !,"Only one item number allowed." H 2
 . S VALMBCK="R"
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("SEL",SEL))) D  Q
 . W !,SEL_" is not a valid item number." H 2
 . S VALMBCK="R"
 ;
 ;Get the IEN.
 S IEN=^TMP("PXRMTAXL",$J,"SEL",SEL)
 S CLASS=$P(^PXD(811.2,IEN,100),U,1)
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Action list.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U
 S EDITOK=$S(CLASS'="N":1,1:($G(PXRMINST)=1)&($G(DUZ(0))="@"))
 I EDITOK S DIR(0)=DIR(0)_"EDIT:Edit;"
 S DIR(0)=DIR(0)_"COPY:Copy;"
 S DIR(0)=DIR(0)_"UIDE:UID Edit;"
 S DIR(0)=DIR(0)_"INQ:Inquire;"
 S DIR(0)=DIR(0)_"CL:Change Log;"
 S VSOID=$P($G(^PXD(811.2,IEN,40)),U,1)
 I VSOID'="" S DIR(0)=DIR(0)_"VSC:Value Set Compare;"
 S DIR("A")="Select Action: "
 S DIR("B")=$S(CLASS="N":"INQ",1:"EDIT")
 S DIR("?")="Select from the actions displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 D CLEAR^VALM1
 ;
 I OPTION="COPY" D COPY^PXRMTAXL(IEN)
 I OPTION="EDIT" D SMANEDIT^PXRMTXSM(IEN,0,"PXRM TAXONOMY EDIT")
 I OPTION="UIDE" D UIDE^PXRMTAXL(IEN)
 I OPTION="INQ" D INQ^PXRMTAXL(IEN)
 I OPTION="CL" D CLOG^PXRMTAXL(IEN)
 I OPTION="VSC" D VSCMP^PXRMTAXL(IEN,VSOID)
 S VALMBCK="R"
 Q
 ;
