PXRMLPU ; SLC/PKR/PJH - Reminder Patient List ;10/11/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;Main entry point for PXRM PATIENT LIST
START(MODE) ;
 N PXRMDONE,VALMBCK,VALMSG,X,XMZ,MODE1
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 D EN^VALM("PXRM PATIENT LIST USER")
 W IORESET
 D KILL^%ZISS
 Q
 ;
ACCESS(IEN,NODE) ;
 ;Holders of the PXRM MANAGER key have full access to all lists.
 ;DBIA #10076
 I $D(^XUSEC("PXRM MANAGER",DUZ)) Q "F"
 N ACCESS,TYPE
 I $G(NODE)="" S NODE=$G(^PXRMXP(810.5,IEN,0))
 S TYPE=$P(NODE,U,8)
 I TYPE="" Q "F"
 I TYPE="PUB" Q "F"
 I $P(NODE,U,7)=DUZ Q "F"
 S ACCESS="N"
 I TYPE="PVT",$D(^PXRMXP(810.5,IEN,40,"B",DUZ)) D
 . N USIEN,STATUS
 . S USIEN=$O(^PXRMXP(810.5,IEN,40,"B",DUZ,""))
 . S ACCESS=$S(USIEN="":"N",1:$P(^PXRMXP(810.5,IEN,40,USIEN,0),U,2))
 Q ACCESS
 ;
BLDLIST ;
 N PLIST
 K ^TMP("PXRMLPU",$J)
 K ^TMP("PXRMLPUH",$J)
 S PLIST="PXRMLPU"
 D LIST(MODE,PLIST)
 S VALMCNT=+$G(^TMP("PXRMLPU",$J,"VALMCNT"))
 Q
 ;
ENTRY ;Entry code
 ;MODE=0 ORDER BY NAME
 ;MODE=1 ORDER BY TYPE
 I $G(MODE)'>0 S MODE=0
 D BLDLIST,XQORM
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMLPU",$J)
 K ^TMP("PXRMLPUH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="R"
 Q
 ;
HDR ; Header code
 N NAME
 S VALMHDR(1)="Available Patient Lists."
 Q
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Select CO to copy the patient list.\\"
 .S HTEXT(2)="Select COE to copy the patient list to an OE/RR Team.\\"
 .S HTEXT(3)="Select DE to delete the patient list.\\"
 .S HTEXT(4)="Select DCD to display creation documentation.\\"
 .S HTEXT(5)="Select DSP to display the patient list.\\"
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMLPUH"
 D EN^VALM("PXRM PATIENT LIST HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
LIST(MODE,PLIST) ;Build a list of patient list entries.
 N ACCESS,COUNT,DATA,DATE,IND,FMTSTR,FNAME,OUTPUT,NAME,NL,NUM
 N STR,SUB,TYPE
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLRRC")
 ;MODE=0 build list in alphabetical order
 ;MODE=1 build list by type of list.
 K ^TMP($J,PLIST),^TMP(PLIST,$J)
 S VALMCNT=0,NAME="",NUM=0,TYPE=""
 F  S NAME=$O(^PXRMXP(810.5,"B",NAME)) Q:NAME=""  D
 .S IND="" F  S IND=$O(^PXRMXP(810.5,"B",NAME,IND)) Q:'IND  D
 ..S DATA=$G(^PXRMXP(810.5,IND,0))
 ..S ACCESS=$$ACCESS(IND,DATA)
 ..I ACCESS="N" Q
 ..S FNAME=$P($G(DATA),U),DATE=$P($G(DATA),U,4)
 ..S COUNT=+$P($G(^PXRMXP(810.5,IND,30,0)),U,4)
 ..S TYPE=$P(DATA,U,8)
 ..S SUB=$S(MODE=0:"NAME",1:TYPE)
 ..S ^TMP($J,PLIST,SUB,FNAME)=IND_U_DATE_U_COUNT_U_TYPE_U_ACCESS
 I '$D(^TMP($J,PLIST)) Q
 ;Loop through ARRAY to populate the output list
 ;sub is either the type of list or 'NAME'. If sort is
 ;by TYPE show PVT lists first.
 S SUB=""
 F  S SUB=$O(^TMP($J,PLIST,SUB),-1) Q:SUB=""  D
 . S FNAME=""
 . F  S FNAME=$O(^TMP($J,PLIST,SUB,FNAME)) Q:FNAME=""  D
 .. S DATA=^TMP($J,PLIST,SUB,FNAME),NUM=NUM+1
 .. S ^TMP("PXRMLPU",$J,"SEL",NUM)=$P(DATA,U,1)
 .. S DATE=$P(DATA,U,2),DATE=$$FMTE^XLFDT(DATE,2)
 .. S $P(DATA,U,2)=DATE
 .. S STR=NUM_U_FNAME_U_$P(DATA,U,2,5)
 .. D COLFMT^PXRMTEXT(FMTSTR,STR," ",.NL,.OUTPUT)
 .. F IND=1:1:NL D
 ... S VALMCNT=VALMCNT+1,^TMP(PLIST,$J,VALMCNT,0)=OUTPUT(IND)
 ... S ^TMP("PXRMLPU",$J,"IDX",VALMCNT,NUM)=""
 S ^TMP(PLIST,$J,"VALMCNT")=VALMCNT
 K ^TMP($J,PLIST)
 Q
 ;
PCOPY ;Patient list copy
 S SUB="PXRMLPU"
 D PCOPY1(SUB)
 D BLDLIST
 S VALMBCK="R"
 Q
 ;
PCOPY1(SUB) ;
 ;Full Screen
 W IORESET
 N IND,LISTIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S IND="",PXRMDONE=0
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the patient list ien.
 .S LISTIEN=^TMP(SUB,$J,"SEL",IND)
 .D COPY^PXRMRUL1(LISTIEN)
 Q
 ;
PDELETE ;Patient list delete
 ;Full Screen
 W IORESET
 N DELOK,IND,LISTIEN,NODE,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S IND="",PXRMDONE=0
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the patient list ien.
 .S LISTIEN=^TMP("PXRMLPU",$J,"SEL",IND)
 .S NODE=$G(^PXRMXP(810.5,LISTIEN,0))
 .S DELOK=$$LDELOK^PXRMEUT(LISTIEN)
 .I DELOK D DELETE^PXRMRUL1(LISTIEN) Q
 .E  D  Q
 ..W !,"In order to delete a list you must be the creator or a Reminder Manager!"
 ..S PXRMDONE=1 H 2
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
POERR ;Patient list copy to OERR Team (#101.21)
 ;Full Screen
 W IORESET
 N ACCESS,IND,LISTIEN,NODE,USIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S IND="",PXRMDONE=0
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the patient list ien.
 .S LISTIEN=^TMP("PXRMLPU",$J,"SEL",IND)
 .S NODE=$G(^PXRMXP(810.5,LISTIEN,0))
 .S ACCESS=$$ACCESS^PXRMLPU(LISTIEN,NODE)
 .I ACCESS="F" D OERR^PXRMLPOE(LISTIEN)
 .I ACCESS="N" D
 ..W !,"The list cannot be copied; you must have full access to copy the list to an OE/RR team!"
 ..S PXRMDONE=1 H 2
 S VALMBCK="R"
 Q
 ;
PLIST ;Patient list inquiry.
 N CREAT,NAME,IND,LISTIEN,USIEN,VALMY,CREAT,NODE,TRUE
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 ;PXRMDONE is newed in PXRMLPU
 S PXRMDONE=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .S LISTIEN=^TMP("PXRMLPU",$J,"SEL",IND)
 .D START^PXRMLPP(LISTIEN)
 D BLDLIST
 S VALMBCK="R"
 Q
 ;
VIEW ;
 D FULL^VALM1
 N DIR,DTOUT,DUOUT,DIROUT,DIROUT,Y
 S DIR(0)="SO^N:NAME;T:TYPE"
 S DIR("A")="Select View Type"
 D ^DIR
 I $D(DTOUT),$D(DUOUT),$D(DIROUT) Q
 I Y="N" S MODE=0 D ENTRY
 I Y="T" S MODE=1 D ENTRY
 Q
 ;
XQORM ;
 S XQORM("#")=$O(^ORD(101,"B","PXRM PATIENT LIST USER SELECT ENTRY",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
 ;
XSEL ;SELECT validation
 N EPIEN,LEVEL,LISTIEN,LRIEN,NODE,SEL
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
 ;Get the patient list ien
 S LISTIEN=^TMP("PXRMLPU",$J,"SEL",SEL)
 ;Get extract definition ien (if present)
 S EPIEN=$P($G(^PXRMXP(810.5,LISTIEN,0)),U,5)
 ;Get list rule ien
 S LRIEN=$P($G(^PXRMXP(810.5,LISTIEN,0)),U,6)
 S NODE=$G(^PXRMXP(810.5,LISTIEN,0))
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Option to Install, Delete or Install History
 N ACCESS,DELOK,DIR,OPTION,RIEN,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S ACCESS=$$ACCESS(LISTIEN,NODE)
 S DELOK=$$LDELOK^PXRMEUT(LISTIEN)
 S DIR(0)="SBM"_U_"CO:Copy Patient List;"
 S DIR(0)=DIR(0)_"COE:Copy to OE/RR Team;"
 I DELOK S DIR(0)=DIR(0)_"DE:Delete Patient List;"
 S DIR(0)=DIR(0)_"DCD:Display Creation Documentation;"
 S DIR(0)=DIR(0)_"DSP:Display Patient List;"
 S DIR("A")="Select Action: "
 S DIR("B")="DSP"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMLPU(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) S VALMBCK="R" Q
 S OPTION=Y
 ;
 I $G(OPTION)="" G XSELE
 ;
 ;Copy patient list
 I OPTION="CO" D COPY^PXRMRUL1(LISTIEN)
 Q:$D(DUOUT)!$D(DTOUT)
 ;
 ;Copy to OE/RR Team
 I OPTION="COE" D OERR^PXRMLPOE(LISTIEN)
 Q:$D(DUOUT)!$D(DTOUT)
 ;
 ;Delete patient list
 I OPTION="DE" D PDELETE
 ;
 ;Display creation documentation
 I OPTION="DCD" D EN^PXRMLCD(LISTIEN)
 ;
 ;Display patient list
 I OPTION="DSP" D START^PXRMLPP(LISTIEN)
 ;
XSELE ;
 D CLEAN^VALM10
 D BLDLIST,XQORM
 S VALMBCK="R"
 Q
