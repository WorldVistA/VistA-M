PXRMLPAU ; SLC/AGP - Reminder Patient List ;09/06/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;
 ;Main entry point for PXRM PATIENT LIST
START(IEN) ;
 N PXRMDONE,VALMBCK,VALMSG,X,XMZ
 S X="IORESET"
 S VALMCNT=0
 D EN^VALM("PXRM PATIENT LIST AUTH USERS")
 W IORESET
 Q
 ;
BLDLIST ;
 N PLIST,PIEN
 K ^TMP("PXRMLPAU",$J)
 K ^TMP("PXRMLPAH",$J)
 D LIST(.PLIST,.PIEN)
 I $D(PLIST)=0 G EXIT
 M ^TMP("PXRMLPAU",$J)=PLIST
 S VALMCNT=PLIST("VALMCNT")
 F IND=1:1:VALMCNT D
 .S ^TMP("PXRMLPAU",$J,"IDX",IND,IND)=PIEN(IND)
 Q
 ;
LIST(RLIST,PIEN) ;Build a list of patient list users.
 N ACCESS,ARRAY,COUNT,DATE,DFN,IND,SIEN,FNAME,NAME,NODE,LEVEL
 ;Build the list in alphabetical order.
 S VALMCNT=0
 S DFN=""
 F  S DFN=$O(^PXRMXP(810.5,IEN,40,"B",DFN)) Q:DFN=""  D
 .S IND=""
 .F  S IND=$O(^PXRMXP(810.5,IEN,40,"B",DFN,IND)) Q:'IND  D
 ..S ACCESS=$P($G(^PXRMXP(810.5,IEN,40,IND,0)),U,2)
 ..S FNAME=$$GET1^DIQ(200,DFN,.01) Q:$G(FNAME)=""
 ..S ARRAY(FNAME)=$G(IND)_U_$G(ACCESS)
 I $D(ARRAY)=0 Q
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S VALMCNT=VALMCNT+1
 .S RLIST(VALMCNT,0)=$$FRE(VALMCNT,NAME,$P($G(ARRAY(NAME)),U,2))
 .S PIEN(VALMCNT)=$P($G(ARRAY(NAME)),U)
 S RLIST("VALMCNT")=VALMCNT
 Q
 ;
FRE(NUMBER,NAME,ACCESS) ;Format  entry number, name, source,
 ;and date packed.
 N TEMP,TNAME,TSOURCE
 S TEMP=$$RJ^XLFSTR(NUMBER,5," ")
 S TNAME=$E(NAME,1,45)
 S TEMP=TEMP_"  "_TNAME
 S TEMP=$$LJ^XLFSTR(TEMP,40," ")_ACCESS
 Q TEMP
 ;
ENTRY ;Entry code
 D BLDLIST,XQORM
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMLPAU",$J)
 K ^TMP("PXRMLPAH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 Q
 ;
HDR ; Header code
 S VALMHDR(1)="Available Patient Lists."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMLPAH"
 D EN^VALM("PXRM PATIENT LIST HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
PEXIT ;PXRM MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
ADD ;add a user
 N CREAT,CNT,DIC,DIE,FDA,MSG,USER,Y
 S CREAT=$P($G(^PXRMXP(810.5,IEN,0)),U,7)
 I $G(CREAT)'=DUZ D  G ADDE
 . W !,"Only the creator of this list can add an user." H 2
 D FULL^VALM1
 S DIC="^VA(200,"
 S DIC(0)="QAEB"
 S DIC("A")="Select Users: "
 D ^DIC
 I Y=-1 Q
 S USER=+Y
 K Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S^F:Full Control;V:View Only"
 S DIR("A")="Select level of control: "
 S DIR("B")="V"
 S DIR("?")="Enter F or V. For detailed help type ??"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I $G(Y)="" W !,"A level of control must be entered." H 2 Q
 S YESNO=$E(Y(0))
 S FDA(810.54,"+2,"_IEN_",",.01)=USER
 S FDA(810.54,"+2,"_IEN_",",1)=Y
 D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
ADDE ;
 D BLDLIST
 S VALMBCK="R"
 Q
 ;
XQORM ;
 S XQORM("#")=$O(^ORD(101,"B","PXRM PATIENT LIST AUTH USER SELECT",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
 ;
XSEL ;PXRM SELECT COMPONENT validation
 N EPIEN,LISTIEN,LRIEN,SEL
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
 ;Get the patient list ien
 S LISTIEN=^TMP("PXRMLPAU",$J,"IDX",SEL,SEL)
 ;Full screen mode
 D FULL^VALM1
 D PDELETE
 ;
 ;Option to Install, Delete or Install History
 ;
 S VALMBCK="R"
 Q
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Select CO to copy the patient list.\\"
 .S HTEXT(2)="Select COE to copy the patient list to an OE/RR Team.\\"
 .S HTEXT(3)="Select DE to delete the patient list.\\"
 .S HTEXT(4)="Select DSP to display the patient list.\\"
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
PDELETE ;Patient list delete
 ;
 ;Full Screen
 W IORESET
 ;
 N CREAT,IND,LISTIEN,NODE
 I DUZ'=$P($G(^PXRMXP(810.5,IEN,0)),U,7) D  G PDELEX
 .W !,"Only the creator of this list can delete it." H 2
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) D BLDLIST S VALMBCK="R" Q
 S IND="",PXRMDONE=0
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the patient list ien.
 .S LISTIEN=^TMP("PXRMLPAU",$J,"IDX",IND,IND)
 .S DA(1)=IEN,DA=LISTIEN,DIK="^PXRMXP(810.5,"_DA(1)_",40," D ^DIK
 .W !,"Patient list deleted"
 ;
PDELEX ;
 D BLDLIST
 ;
 S VALMBCK="R"
 Q
 ;
