TIUHSV ;;SLC/AJB,AGP Edit Menu for TIUHS Routines;06/24/09
 ;;1.0;TEXT INTEGRATION UTILITIES;**135,249**;Jun 20, 1997;Build 48
EN(IEN) ; -- main entry point for TIUHSLSV
 N MSG
 K ^TMP("VALMAR",$J)
 D EN^VALM("TIUHSLSV")
 Q
 ;
HDR ; -- header code
 N CENTER,HEADER,OBJNAME,OBJNODE,TITLE,VALMHDR
 S OBJNODE=^TIU(8925.1,IEN,0)
 S OBJNAME=$P($G(OBJNODE),U)
 S TITLE="Detailed Display/Edit for "_OBJNAME
 S CENTER=(IOM-$L(TITLE))/2
 S HEADER=$$SETSTR^VALM1(TITLE,"",CENTER,$L(TITLE))
 S VALMHDR(1)=HEADER
 Q
 ;
INIT ; -- init variables and list array
 N ANS,CNT,DISP,HSONAME,HSTNAME,HSTYPE,LINE
 N NUM,OBJMETD,OBJNAME,OBJNODE,OBJSTAT,OWNER
 S OBJNODE=^TIU(8925.1,IEN,0)
 S OBJSTAT=$S($P($G(OBJNODE),U,7)=11:"ACTIVE",$P($G(OBJNODE),U,7)=13:"INACTIVE")
 S OBJNAME=$P($G(OBJNODE),U)
 S OBJMETD=^TIU(8925.1,IEN,9)
 S OWNER=$$GET1^DIQ(200,$P($G(OBJNODE),U,5),.01)
 I OWNER="" S OWNER="<UNKNOWN> OR 0"
 S HSOBJ=$P($P($G(OBJMETD),",",2),")")
 I $G(HSOBJ)'=""&($D(^GMT(142.5,HSOBJ))>0) D
 . S HSONAME=$$GET1^DIQ(142.5,HSOBJ,.01)
 . S HSTYPE=$P($G(^GMT(142.5,HSOBJ,0)),U,3)
 . I $G(HSTYPE)'=""&($D(^GMT(142,HSTYPE))>0) S HSTNAME=$$GET1^DIQ(142,HSTYPE,.01)
 . E  S HSTNAME="Invalid Health Summary Type IEN"
 E  S HSONAME="Invalid Health Summary Object IEN",HSTNAME="Invalid Health Summary Type IEN"
 S HSTYPE=$P($G(^GMT(142.5,HSOBJ,0)),U,3)
 ;
 ;
 S LINE=1
 S DISP=""
 D SET^VALM10(LINE,DISP)
 F CNT=1:1:6 D
 .S LINE=LINE+1
 .S DISP=$P($T(OUTPUT+CNT),";;",2)
 .S ANS=$S(CNT=1:OBJNAME,CNT=2:OWNER,CNT=3:OBJSTAT,CNT=4:HSONAME,CNT=5:HSTNAME,CNT=6:OBJMETD)
 .S DISP=($J(DISP,25))_" "_ANS
 .D SET^VALM10(LINE,DISP)
 S VALMCNT=LINE
 Q
OUTPUT ;
 ;;TIU Object Name:
 ;;Owner:
 ;;Status:
 ;;HS Object:
 ;;HS Type:
 ;;Technical Field:
 ;
TIUN ;
 D FULL^VALM1
 D EDIT^TIUHSOBJ(IEN)
 D CLEAN^VALM10
 D INIT
 Q
 ;
HSEDIT ;
 N DIC,DIR,DIR,DIROUT,DTOUT,DUOUT,HIEN,POP,TEXT,X,Y,YESNO
 D FULL^VALM1
 I DUZ'=$P($G(^TIU(8925.1,IEN,0)),U,5) W !,"Can't edit this TIU Object:  Only the owner can edit this TIU Object" H 2 Q
 W !,"***WARNING***",!,"Changing the HS Object will change the output data and may change the HS Type."
 S DIR(0)="YA0"
 S DIR("A")="Continue? "
 S DIR("B")="NO"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 I YESNO="Y" D
 .S DIC=142.5,DIC(0)="AEMQ",DIC("S")="I Y'<1",DIC("A")="Enter HEALTH SUMMARY OBJECT: "
 .W ! D ^DIC
 .I Y=-1 K DIC Q
 .S HIEN=+Y
 .S ^TIU(8925.1,IEN,9)="S X=$$TIU^GMTSOBJ(DFN,"_HIEN_")"
 D CLEAN^VALM10
 D INIT
 Q
 ;
CHHST ;
 N DA,DIC,DIE,DIR,DIROUT,DR,DTOUT,DUOUT,HSIEN,POP,TEXT,X,Y,YESNO
 I $P($G(^GMT(142.5,HSOBJ,0)),U,20)=1 W !,"Can't edit this National Object." H 2 Q
 I $P($G(^GMT(142.5,HSOBJ,0)),U,17)'=DUZ,'$D(^XUSEC("GMTSMGR",DUZ)) W !,"Can't edit this HS object:  Only the owner can edit this HS object." H 2 Q
 W !,"***WARNING*** Changing the HS Type will change the output data."
 S DIR(0)="YA0"
 S DIR("A")="Continue? "
 S DIR("B")="NO"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 I YESNO="Y" D
 .S DIC=142,DIC(0)="AEMQ",DIC("S")="I Y'<1",DIC("A")="Enter HEALTH SUMMARY TYPE: "
 .W ! D ^DIC
 .I Y=-1 K DIC Q
 .S HSIEN=+Y
 .S DIE="^GMT(142.5,",DA=HSOBJ,DR=".03///^S X=HSIEN" D ^DIE
 D CLEAN^VALM10
 D INIT
 Q
 ;
HSOBJ ;
 D FULL^VALM1
 N HSTYNAM,YESNO
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
