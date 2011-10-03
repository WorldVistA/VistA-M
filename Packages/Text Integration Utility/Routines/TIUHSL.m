TIUHSL ;;SLC/AJB,AGP - Main List Manager for TIUHS ROutines; 10/25/02
 ;;1.0;TEXT INTEGRATION UTILITIES;**135**;Jun 20, 1997
EN ; -- main entry point for TIUHSLSM
 N CENTER,GMTSHDR,GMTSN,POP,VALMBCK,VALMSG,X
 D EN^VALM("TIUHSLSM")
 Q
 ;
HDR ; -- header code
 N CENTER,HEADER,TITLE,VALMHDR,VALMSG
 S TITLE="TIU Health Summary Object."
 S CENTER=(IOM-$L(TITLE))/2
 S HEADER=$$SETSTR^VALM1(TITLE,"",CENTER,$L(TITLE))
 S VALMHDR(1)=HEADER
 ;display help option
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 D XQORM
 Q
 ;
INIT ; -- init variables and list array
 N DIS,IEN,LINE,HSNAME,HSOBIEN,HSTYPE,NAME,NUM,TMP
 K TMP($J)
 S (LINE,NUM)=0
 ;
 ;searches file 8925.1 for hs obj and places into temp array
 S IEN="" F  S IEN=$O(^TIU(8925.1,"AT","O",IEN)) Q:IEN=""  I $G(^TIU(8925.1,IEN,9))["GMTSOBJ" D
 .S NAME=$P($G(^TIU(8925.1,IEN,0)),U)
 .S HSOBIEN=$P($P($G(^TIU(8925.1,IEN,9)),",",2),")")
 .S HSTYPE=$P($G(^GMT(142.5,HSOBIEN,0)),U,3)
 .I $G(HSTYPE)'=""&($D(^GMT(142.5,HSOBIEN,0))>0) S HSTYPE=$$GET1^DIQ(142,HSTYPE,.01)
 .I $G(HSTYPE)="" S HSTYPE="No Health Summary Type Found"
 .S TMP($J,NAME)=IEN_U_HSTYPE
 ;
 ;sort temp array in alpha order and display output
 S NAME=""
 F  S NAME=$O(TMP($J,NAME)) Q:NAME=""  D
 .S IEN=$P(TMP($J,NAME),U)
 .S HSNAME=$P(TMP($J,NAME),U,2)
 .S LINE=LINE+1
 .S NUM=NUM+1
 .;
 .;set output display
 .S DIS=$$SETSTR^VALM1(NUM,"",1,5)
 .S DIS=$$SETSTR^VALM1(NAME,DIS,6,37)
 .S DIS=$$SETSTR^VALM1(HSNAME,DIS,40,40)
 .D SET^VALM10(LINE,DIS,IEN)
 S VALMCNT=LINE
 K TMP($J)
 Q
 ;
CREATE ;
 ;call to tiuhsobj
 D CLEAN^VALM10
 D FULL^VALM1
 D CREATE^TIUHSOBJ
 D INIT
 S VALMBCK="R"
 Q
EDIT ;
 ;lst man function to allow user to select protocal and line item in one command i.e. det=3
 ;
 N HSOBJ,SEL,TRUE,Y
 S TRUE=0
 S SEL=$P(XQORNOD(0),"=",2)
 I $A($E(SEL,$L(SEL)))<48!($A($E(SEL,$L(SEL)))>57) S SEL=$E(SEL,1,$L(SEL)-1)
 I SEL["," D  Q
 .W $C(7),!,"Only one item number allowed." H 2
 .S VALMBCK="R"
 I SEL="" D
 .W !,"Select Entry:  (1-"_VALMLST_") " R SEL:DTIME
 .I '$T!(SEL=U)!(SEL="") S TRUE=1
 I TRUE=1 Q
 I 'SEL!(SEL>VALMCNT)!('$D(@VALMAR@("IDX",SEL))) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 S Y=$O(@VALMAR@("IDX",SEL,""))
 D CLEAN^VALM10
 D EN^TIUHSV(+Y)
 D CLEAN^VALM10
 D INIT
 Q
 ;
EDITHSO ;
 ;lst man function to allow user to select protocal and line item in one command i.e. det=3
 ;
 N HSOBJ,IEN,OBJMETD,SEL,TRUE,Y,YESNO
 S TRUE=0
 S SEL=$P(XQORNOD(0),"=",2)
 I $A($E(SEL,$L(SEL)))<48!($A($E(SEL,$L(SEL)))>57) S SEL=$E(SEL,1,$L(SEL)-1)
 I SEL["," D  Q
 .W $C(7),!,"Only one item number allowed." H 2
 .S VALMBCK="R"
 I SEL="" D
 .W !,"Select Entry:  (1-"_VALMLST_") " R SEL:DTIME
 .I '$T!(SEL=U)!(SEL="") S TRUE=1
 I TRUE=1 Q
 I 'SEL!(SEL>VALMCNT)!('$D(@VALMAR@("IDX",SEL))) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 S Y=$O(@VALMAR@("IDX",SEL,""))
 S IEN=+Y
 S OBJMETD=^TIU(8925.1,IEN,9)
 S HSOBJ=$P($P($G(OBJMETD),",",2),")")
 S YESNO="Y"
 I $D(^GMT(142.5,HSOBJ,0))=0 D
 . W !,"No HS Object found. Create new HS Object now?"
 . S DIR(0)="YA0"
 . S DIR("B")="NO"
 . S DIR("?")="Enter Y or N. For detailed help type ??"
 . D ^DIR
 . I $D(DIROUT) S DTOUT=1
 . I $D(DTOUT)!($D(DUOUT)) S YESNO="N" Q
 . S YESNO=$E(Y(0))
 . I YESNO="Y" S HSOBJ=$$CRE^GMTSOBJ()
 I $G(YESNO)="Y"&(HSOBJ>0) D
 . S ^TIU(8925.1,IEN,9)="S X=$$TIU^GMTSOBJ(DFN,"_HSOBJ_")"
 . D EN^TIUHSOLM(HSOBJ,IEN)
 D CLEAN^VALM10
 D INIT
 Q
FIND ;
 S DIC=8925.1,DIC("A")="Enter OBJECT NAME:  "
 ;
 ; DIC(0)="ABEOQ" a=ask user for input, b=use b xref only
 ;                e=echo    o=only find 1 if exact match
 ;                q=question erroneous input
 ;
 ; DIC("S") ensures IEN is greater or equal to 1 and will only
 ; lookup objects that contain the health summary object routine
 ;
 S DIC(0)="ABEOQ",DIC("S")="I Y'<1,$G(^TIU(8925.1,+Y,9))[""GMTSOBJ"""
 W ! D ^DIC I Y=-1 K DIC Q
 D EN^TIUHSV(+Y)
 K DIC
 Q
 ;
LSEXIT ;
 ;display help option
 N VALMSG
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 D XQORM
 Q
 ;
XQORM ;
 S XQORM("#")=$O(^ORD(101,"B","TIUHS EDIT",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Action: "
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
