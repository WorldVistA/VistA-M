PXRMEGM ; SLC/PKR/PJH - Extract Counting Group Management ;08/03/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;Main entry point for PXRM EXTRACT COUNTING GROUPS
START(EFIEN) ;
 N EFCLASS,EFNAME,PXRMDONE,GROUP
 N VALMBCK,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 I EFIEN D
 .S EFNAME=$P($G(^PXRM(810.7,EFIEN,0)),U)
 .S EFCLASS=$P($G(^PXRM(810.7,EFIEN,100)),U)
 .S EFCLASS=$S(EFCLASS="N":"National",EFCLASS="V":"VISN",1:"Local")
 D EN^VALM("PXRM EXTRACT COUNTING GROUPS")
 Q
 ;
BLDLIST ;Build workfile
 K ^TMP("PXRMEGM",$J)
 N IEN,IND,PLIST
 D LIST(.PLIST,.IEN,EFIEN)
 M ^TMP("PXRMEGM",$J)=PLIST
 S VALMCNT=PLIST("VALMCNT")
 F IND=1:1:VALMCNT D
 .S ^TMP("PXRMEGM",$J,"IDX",IND,IND)=IEN(IND)
 Q
 ;
ENTRY ;Entry code
 D BLDLIST,XQORM
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMEGM",$J)
 K ^TMP("PXRMEGMH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
HDR ; Header code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions" Q:'EFIEN
 S VALMHDR(1)="Extract Finding: "_EFNAME
 S VALMHDR(2)="          Class: "_EFCLASS
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMEGMH"
 D EN^VALM("PXRM EXTRACT HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
PEXIT ;Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXTRACT COUNTING GROUP SELECT ENTRY",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
 ;
XSEL ;PXRM EXTRACT COUNTING GROUP SELECT ENTRY validation
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
 S IEN=^TMP("PXRMEGM",$J,"IDX",SEL,SEL)
 ;Display/Edit Extract Counting Group
 D START^PXRMEGED(IEN)
 ;
 D BLDLIST
 ;
 S VALMBCK="R"
 Q
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Select DE to display or edit a rule."
 .S HTEXT(2)="Select ED to edit a rule"
 ;
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
EGADD ;Add Rule Option
 ;
 ;Reset Screen Mode
 W IORESET
 ;
 ;Add Rule
 D ADD^PXRMEGED
 ;
 ;Rebuild Workfile
 D BLDLIST
 ;
 S VALMBCK="R"
 Q
 ;
EGINQ ;Counting Group Inquiry - PXRM EXTRACT COUNTING GROUP DISPLAY/EDIT entry 
 N IND,FGIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;
 ;If there is no list quit.
 I '$D(VALMY) Q
 S PXRMDONE=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the ien.
 .S FGIEN=^TMP("PXRMEGM",$J,"IDX",IND,IND)
 .D START^PXRMEGED(FGIEN)
 ;
 D BLDLIST
 ;
 S VALMBCK="R"
 Q
 ;
LIST(RLIST,IEN,EFIEN) ;Build a list of extract counting groups for 
 ;extract definition.
 N EPCLASS,IND,FNAME,NAME,PLIST
 ;If called for a selected extract finding build list of groups
 I EFIEN D
 .N SUB,FGIEN
 .S SUB=0
 .F  S SUB=$O(^PXRM(810.7,EFIEN,10,SUB)) Q:'SUB  D
 ..S FGIEN=$P($G(^PXRM(810.7,EFIEN,10,SUB,0)),U,2) Q:'FGIEN
 ..S GROUP(FGIEN)=""
 ;
 ;Build the list in alphabetical order.
 S VALMCNT=0
 S NAME=""
 F  S NAME=$O(^PXRM(810.8,"B",NAME)) Q:NAME=""  D
 .S IND=$O(^PXRM(810.8,"B",NAME,"")) Q:'IND
 .;For extract counting rule only include finding counting groups
 .I EFIEN,'$D(GROUP(IND)) Q
 .S FNAME=$P($G(^PXRM(810.8,IND,0)),U)
 .S EPCLASS=$P($G(^PXRM(810.8,IND,100)),U)
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
