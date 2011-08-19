PXRMEFM ; SLC/PKR/PJH - Extract Counting Rule Management ;08/03/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;Main entry point for PXRM EXTRACT COUNTING RULES
START(PIEN) ;
 N PXRMDONE,VALMBCK,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 D EN^VALM("PXRM EXTRACT COUNTING RULES")
 Q
 ;
BLDLIST ;Build workfile
 K ^TMP("PXRMEFM",$J)
 N IEN,IND,PLIST
 D LIST(.PLIST,.IEN,PIEN)
 M ^TMP("PXRMEFM",$J)=PLIST
 S VALMCNT=PLIST("VALMCNT")
 F IND=1:1:VALMCNT S ^TMP("PXRMEFM",$J,"IDX",IND,IND)=IEN(IND)
 Q
 ;
ENTRY ;Entry code
 D BLDLIST,XQORM
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMEFM",$J)
 K ^TMP("PXRMEFMH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
HDR ; Header code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMEFMH"
 D EN^VALM("PXRM EXTRACT HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
PEXIT ;PXRM EXCH MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXTRACT COUNTING RULE SELECT ENTRY",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
 ;
XSEL ;PXRM EXTRACT COUNTING RULE SELECT ENTRY validation
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
 S IEN=^TMP("PXRMEFM",$J,"IDX",SEL,SEL)
 ;Display/Edit Extract Finding
 D START^PXRMEFED(IEN)
 ;
 D BLDLIST
 ;
 S VALMBCK="R"
 Q
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Select DR to display or edit a rule."
 .S HTEXT(2)="Select ED to edit a rule"
 ;
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
EFADD ;Add Rule Option
 ;
 ;Reset Screen Mode
 W IORESET
 ;
 ;Add Rule
 D ADD^PXRMEFED
 ;
 ;Rebuild Workfile
 D BLDLIST
 ;
 S VALMBCK="R"
 Q
 ;
EFINQ ;Extract Finding Inquiry - PXRM EXTRACT FINDINQ DISPLAY/EDIT entry 
 N IND,FRIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;
 ;If there is no list quit.
 I '$D(VALMY) Q
 S PXRMDONE=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the ien.
 .S FRIEN=^TMP("PXRMEFM",$J,"IDX",IND,IND)
 .D START^PXRMEFED(FRIEN)
 ;
 D BLDLIST
 ;
 S VALMBCK="R"
 Q
 ;
LIST(RLIST,IEN,PIEN) ;Build a list of extract findings for parameter.
 N EPCLASS,IND,FNAME,NAME,PLIST
 ;Build the list in alphabetical order.
 S VALMCNT=0
 S NAME=""
 F  S NAME=$O(^PXRM(810.7,"B",NAME)) Q:NAME=""  D
 .S IND=$O(^PXRM(810.7,"B",NAME,"")) Q:'IND
 .S FNAME=$P($G(^PXRM(810.7,IND,0)),U)
 .S EPCLASS=$P($G(^PXRM(810.7,IND,100)),U)
 .S VALMCNT=VALMCNT+1
 .S RLIST(VALMCNT,0)=$$FRE(VALMCNT,FNAME,EPCLASS)
 .S IEN(VALMCNT)=IND
 S RLIST("VALMCNT")=VALMCNT
 Q
 ;
FRE(NUMBER,NAME,CLASS) ;Format  entry number, name
 ;and date packed.
 N TCLASS,TEMP,TNAME,TSOURCE
 S TEMP=$$RJ^XLFSTR(NUMBER,5," ")
 S TNAME=$E(NAME,1,46)
 S TEMP=TEMP_"  "_$$LJ^XLFSTR(TNAME,60," ")
 S TCLASS=$S(CLASS="N":"NATIONAL",CLASS="V":"VISN",1:"LOCAL")
 S TEMP=TEMP_"  "_TCLASS
 Q TEMP
 ;
