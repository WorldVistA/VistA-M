PXRMETM ; SLC/PKR/PJH - Extract/Transmission Management ;09/06/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;Main entry point for PXRM EXTRACT MANAGEMENT
START N PXRMDONE,VALMBCK,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 D EN^VALM("PXRM EXTRACT MANAGEMENT")
 W IORESET
 D KILL^%ZISS
 Q
 ;
BLDLIST ;Build workfile
 K ^TMP("PXRMETM",$J)
 N IEN,IND,PLIST
 D LIST("PXRMETM",.VALMCNT)
 Q
 ;
ENTRY ;Entry code
 D BLDLIST,XQORM
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMETM",$J)
 K ^TMP("PXRMETMH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
FMT(NUMBER,NAME,CLASS) ;Format  entry number, name
 ;and date packed.
 N TCLASS,TEMP,TNAME,TSOURCE
 S TEMP=$$RJ^XLFSTR(NUMBER,5," ")
 S TNAME=$E(NAME,1,46)
 S TEMP=TEMP_"  "_$$LJ^XLFSTR(TNAME,60," ")
 S TCLASS=$S(CLASS="N":"NATIONAL",CLASS="V":"VISN",1:"LOCAL")
 S TEMP=TEMP_"  "_TCLASS
 Q TEMP
 ;
GEN ;Ad hoc report option
 ;Reset Screen Mode
 W IORESET
 ;
 N IND,LISTIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S PXRMDONE=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the ien.
 .S LISTIEN=^TMP("PXRMETM",$J,"SEL",IND)
 .D GENSEL(LISTIEN)
 ;
 S VALMBCK="R"
 Q
 ;
GENSEL(IEN) ;Report for selected extract definition
 N ANS,BEGIN,END,RTN,TEXT
 D DATES^PXRMEUT(.BEGIN,.END,"Report")
 ;Options
 S RTN="PXRMETM",TEXT="Run compliance report for this period"
 S ANS=$$ASKYN^PXRMEUT("N",TEXT,RTN,1) Q:'ANS  Q:$D(DUOUT)!$D(DTOUT)
 ;Print Report
 D ADHOC^PXRMETCO(IEN,BEGIN,END)
 Q
 ;
HDR ; Header code
 S VALMHDR(1)="Available Extract Definitions:"
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Select EDM to edit/display extract definitions.\\"
 .S HTEXT(2)="Select VSE to view previous extracts or"
 .S HTEXT(3)="initiate a manual extract or transmission."
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
HLIST ;Extract History
 N IND,LISTIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S PXRMDONE=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the ien.
 .S LISTIEN=^TMP("PXRMETM",$J,"SEL",IND)
 .D START^PXRMETH(LISTIEN)
 S VALMBCK="R"
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMETMH"
 D EN^VALM("PXRM EXTRACT HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
LIST(NODE,VALMCNT) ;Build a list of extract definition entries.
 N EPCLASS,IND,FNAME,NAME
 ;Build the list in alphabetical order.
 S VALMCNT=0
 S NAME=""
 F  S NAME=$O(^PXRM(810.2,"B",NAME)) Q:NAME=""  D
 .S IND=$O(^PXRM(810.2,"B",NAME,"")) Q:'IND
 .S FNAME=$P($G(^PXRM(810.2,IND,0)),U)
 .S EPCLASS=$P($G(^PXRM(810.2,IND,100)),U)
 .S VALMCNT=VALMCNT+1
 .S ^TMP(NODE,$J,VALMCNT,0)=$$FMT(VALMCNT,FNAME,EPCLASS)
 .S ^TMP(NODE,$J,"IDX",VALMCNT,VALMCNT)=""
 .S ^TMP(NODE,$J,"SEL",VALMCNT)=IND
 Q
 ;
PEXIT ;Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
PLIST ;Extract Definition Inquiry
 N IND,EPIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S PXRMDONE=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the ien.
 .S EPIEN=^TMP("PXRMETM",$J,"SEL",IND)
 .D START^PXRMEPED(EPIEN)
 S VALMBCK="R"
 Q
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXTRACT MANAGEMENT SELECT ENTRY",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
 ;
XSEL ;PXRM EXTRACT MANAGEMENT SELECT ENTRY validation
 N EDIEN,SEL
 S SEL=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(SEL,$L(SEL))="," S SEL=$E(SEL,1,$L(SEL)-1)
 ;Invalid selection
 I SEL["," D  Q
 .W $C(7),!,"Only one item number allowed." H 2
 .S VALMBCK="R"
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("SEL",SEL))) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 ;
 ;Get the list ien.
 S EDIEN=^TMP("PXRMETM",$J,"SEL",SEL)
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Options
 N X,Y,DIR,OPTION K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="SBM"_U_"EDM:Extract Definition Management;"
 S DIR(0)=DIR(0)_"VSE:Examine/Schedule Extract;"
 S DIR("A")="Select Action"
 S DIR("B")="VSE"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMETM(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) S VALMBCK="R" Q
 S OPTION=Y
 ;
 ;Display Extract Definitions
 I OPTION="EDM" D START^PXRMEPED(EDIEN)
 ;
 ;Examine/Run Extract
 I OPTION="VSE" D START^PXRMETH(EDIEN)
 ;
 ;Examine/Run Extract
 I OPTION="ERE" D GENSEL(EDIEN)
 ;
 S VALMBCK="R"
 Q
 ;
