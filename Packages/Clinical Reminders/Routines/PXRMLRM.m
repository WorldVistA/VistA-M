PXRMLRM ; SLC/PJH/PKR - List Rule Management ; 03/06/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
 ;Main entry point for PXRM LIST RULE MANAGEMENT
START N IND,PXRMDONE,PXRMTYP,VALMBCK,VALMBGS,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 ;Default view is Rule Sets
 S PXRMTYP=3
 ;Initialize list positions.
 F IND=1:1:5 S VALMBGS(IND)=1
 D EN^VALM("PXRM LIST RULE MANAGEMENT")
 Q
 ;
BLDLIST ;Build workfile
 K ^TMP("PXRMLRM",$J)
 N IEN,IND,PLIST
 D LIST(.PLIST,.IEN,PXRMTYP)
 M ^TMP("PXRMLRM",$J)=PLIST
 S VALMCNT=PLIST("VALMCNT")
 F IND=1:1:VALMCNT S ^TMP("PXRMLRM",$J,"IDX",IND,IND)=IEN(IND)
 I PXRMTYP=1 D CHGCAP^VALM("HEADER2","Finding Rule Name")
 I PXRMTYP=2 D CHGCAP^VALM("HEADER2","Reminder Rule Name")
 I PXRMTYP=3 D CHGCAP^VALM("HEADER2","Rule Set Name")
 I PXRMTYP=4 D CHGCAP^VALM("HEADER2","Report Output Rule Name")
 I PXRMTYP=5 D CHGCAP^VALM("HEADER2","Patient List Rule Name")
 S VALMBG=VALMBGS(PXRMTYP)
 Q
 ;
ENTRY ;Entry code
 D BLDLIST,XQORM
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMLRM",$J)
 K ^TMP("PXRMLRMH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
FRE(NUMBER,NAME,CLASS) ;Format  entry number, name
 ;and date packed.
 N TCLASS,TEMP,TNAME,TSOURCE
 S TEMP=$$RJ^XLFSTR(NUMBER,5," ")
 S TNAME=$E(NAME,1,60)
 S TEMP=TEMP_"  "_$$LJ^XLFSTR(TNAME,60," ")
 S TCLASS=$S(CLASS="N":"NATIONAL",CLASS="V":"VISN",1:"LOCAL")
 S TEMP=TEMP_"  "_TCLASS
 Q TEMP
 ;
HDR ; Header code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Select DE to display or edit a rule.\\"
 .S HTEXT(2)="Select ED to edit a rule.\\"
 ;
 I CALL=2 D
 .S HTEXT(1)="Select F to edit term based finding rules.\\"
 .S HTEXT(2)="Select P to edit patient list based finding rules.\\"
 .S HTEXT(3)="Select R to edit reminder rules.\\"
 .S HTEXT(4)="Select S to edit rule sets. A rule set may contain"
 .S HTEXT(5)="any of the following:\\"
 .S HTEXT(6)=" finding list rules, patient list rules, reminder rules\\"
 .S HTEXT(7)="These component list rules must be created before the rule set"
 .S HTEXT(8)="can be constructed."
 ;
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMLRMH"
 D EN^VALM("PXRM LIST RULE HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
LIST(RLIST,IEN,LRTYP) ;Build a list of list rule entries.
 N DATA,IND,LRCLASS,LRNAME,NAME
 ;Build the list in alphabetical order.
 S VALMCNT=0
 S NAME=""
 F  S NAME=$O(^PXRM(810.4,"B",NAME)) Q:NAME=""  D
 .S IND=$O(^PXRM(810.4,"B",NAME,"")) Q:'IND
 .S DATA=$G(^PXRM(810.4,IND,0))
 .I $P(DATA,U,3)'=LRTYP Q
 .S LRNAME=$P(DATA,U)
 .S LRCLASS=$P($G(^PXRM(810.4,IND,100)),U)
 .S VALMCNT=VALMCNT+1
 .S RLIST(VALMCNT,0)=$$FRE(VALMCNT,LRNAME,LRCLASS)
 .S IEN(VALMCNT)=IND
 S RLIST("VALMCNT")=VALMCNT
 Q
 ;
LRADD ;Add Rule Option
 ;
 ;Reset Screen Mode
 W IORESET
 ;
 ;Add Rule
 D ADD^PXRMLRED
 ;
 ;Rebuild Workfile
 D BLDLIST
 S VALMBCK="R"
 Q
 ;
LRINQ ;Rule Inquiry - PXRM LIST RULE DISPLAY/EDIT entry 
 N IND,LRIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S PXRMDONE=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the ien.
 .S LRIEN=^TMP("PXRMLRM",$J,"IDX",IND,IND)
 .D START^PXRMLRED(LRIEN,PXRMTYP)
 D BLDLIST
 S VALMBCK="R"
 Q
 ;
PEXIT ;Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
VIEW ;Select view
 W IORESET
 S VALMBCK="R"
 N X,Y,CODE,DIR
 ;Save current position in list before changing the view
 S VALMBGS(PXRMTYP)=VALMBG
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"F:Finding Rule;"
 S DIR(0)=DIR(0)_"P:Patient List Rule;"
 S DIR(0)=DIR(0)_"R:Reminder Rule;"
 S DIR(0)=DIR(0)_"S:Rule Set;"
 S DIR("A")="TYPE OF VIEW"
 S DIR("B")="F"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMLRM(2)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 ;Change display type
 S PXRMTYP=$S(Y="F":1,Y="P":5,Y="S":3,1:4)
 S PXRMTYP=$S(Y="F":1,Y="P":5,Y="S":3,Y="R":2,1:4)
 ;Rebuild Workfile
 D BLDLIST,HDR
 Q
 ;
XSEL ;PXRM LIST RULE MANAGEMENT SELECT ENTRY validation
 N SEL,IEN
 S SEL=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(SEL,$L(SEL))="," S SEL=$E(SEL,1,$L(SEL)-1)
 ;Invalid selection
 I SEL["," D  Q
 .W $C(7),!,"Only one item number allowed." H 2
 .S VALMBCK="R"
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("IDX",SEL))) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 ;
 ;Get the list ien.
 S IEN=^TMP("PXRMLRM",$J,"IDX",SEL,SEL)
 ;
 ;Option to Display/Edit or Test Rule Set.
 N DIR,OPTION,RIEN,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="SBM"_U_"DR:Display/Edit Rule;"
 I $G(PXRMTYP)=3 S DIR(0)=DIR(0)_"TEST:Test Rule Set"
 S DIR("A")="Select Action: "
 S DIR("B")="DR"
 S DIR("?")="Select from the codes displayed."
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) S VALMBCK="R" Q
 S OPTION=Y
 I $G(OPTION)="" G XSELE
 ;
 ;Display/Edit
 I OPTION="DR"   D START^PXRMLRED(IEN,PXRMTYP)
 Q:$D(DUOUT)!$D(DTOUT)
 ;
 ;Rule set test
 I OPTION="TEST" D RSTEST^PXRMRST(IEN)
 Q:$D(DUOUT)!$D(DTOUT)
 ;
XSELE ;
 D CLEAN^VALM10
 D BLDLIST,XQORM
 S VALMBCK="R"
 Q
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM LIST RULE MANAGEMENT SELECT ENTRY",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
 ;
