KMPRUTL1 ;OAK/KAK/RAK - Resource Usage Monitor Utility ;11/19/04  10:32
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
DATERNG(KMPUY,KMPUSTR,KMPUEND) ;-- date range
 ;---------------------------------------------------------------------
 ; KMPUY..... Value returned in four pieces:
 ;            fmstartdate^fmenddate^ouputstartdate^outputenddate
 ;
 ;            Piece one and two are the date ranges in fileman format.
 ;            Piece three and four are the same dates in output format:
 ;                             dy-Mon-yr
 ;
 ;                               ********
 ;                               * NOTE *
 ;                               ********
 ;          - The first piece will always be the earliest date entered.
 ;
 ;  Optional Parameters:
 ;
 ; KMPUSTR... If defined, the earliest date that may be selected.
 ;            (must be in fileman format)
 ;
 ; KMPUEND... If defined, the latest date that may be selected.
 ;            (must be in fileman format)
 ;-----------------------------------------------------------------------
 ;
 N DATE1,DATE2,DIR,DIRUT,LINE,X,Y
 ;
 S KMPUY="",KMPUSTR=$G(KMPUSTR),KMPUEND=$G(KMPUEND)
 ;
RANGE ;-- Ask date ranges
 S DIR(0)="DOA^"_$S(KMPUSTR:KMPUSTR,1:"")_":"_$S(KMPUEND:KMPUEND,1:"")_":E)"
 S DIR("A")="Start with Date: "
 S:KMPUSTR DIR("B")=$$FMTE^XLFDT(KMPUSTR,2)
 S DIR("?")=" "
 S DIR("?",1)="Enter the starting date.",LINE=2
 ; if starting date.
 I KMPUSTR D 
 .S DIR("?",LINE)="Date must not precede "_$$FMTE^XLFDT(KMPUSTR)
 .S LINE=LINE+1
 ; if ending date.
 I KMPUEND S DIR("?",LINE)="Date must not follow "_$$FMTE^XLFDT(KMPUEND)
 W ! D ^DIR I $D(DIRUT) S KMPUY="" Q
 S DATE1=Y
 S DIR("A")="  End with Date: "
 S:KMPUEND DIR("B")=$$FMTE^XLFDT(KMPUEND,2)
 S DIR("?",1)="Enter the ending date."
 D ^DIR G:Y="" RANGE I Y="^" S KMPUY="" Q
 S DATE2=Y
 ; Set earliest date into first piece.
 S KMPUY=$S(DATE2<DATE1:DATE2,1:DATE1)_U_$S(DATE2>DATE1:DATE2,1:DATE1)
 S $P(KMPUY,U,3)=$$FMTE^XLFDT($P(KMPUY,U))
 S $P(KMPUY,U,4)=$$FMTE^XLFDT($P(KMPUY,U,2))
 ;
 Q
 ;
ENVCHECK(KMPRENV,KMPRQIET) ;-- environment check.
 ;-----------------------------------------------------------------------
 ; KMPRENV... Result of environment check in format:
 ;            KMPRENV=Number^Text
 ;            1-99: system status (not an error condition).
 ;                 0 - RUM turned on and background job queued
 ;                 1 - RUM is not turned on
 ;                 2 - 'KMPR BACKGROUND' job has been queued to run
 ;
 ;            100>: error condition.
 ;               100 - RUM not available for 'OS' at this time
 ;               200 - RUM is on but the option 'KMPR BACKGROUND DRIVER'
 ;                     is not scheduled to run."
 ;               201 - The RUM background driver option [KMPR BACKGROUND
 ;                     DRIVER] is missing
 ;
 ; KMPRQIET.. Output message: 0 - output message (not quiet).
 ;                            1 - do not output message (quiet).
 ;-----------------------------------------------------------------------
 ;
 K KMPRENV
 S KMPRENV="0^RUM turned on and background job queued"
 S KMPRQIET=+$G(KMPRQIET)
 ;
 N IEN,IEN1,TEXT
 ;
 ; check for operating system availability.
 S TEXT=$P($G(^%ZOSF("OS")),U)
 I TEXT'["DSM"&(TEXT'["OpenM") D  Q
 .S KMPRENV="100^RUM not available for '"_TEXT_"' at this time"
 .D:'KMPRQIET ENVOUTPT(KMPRENV,1,1)
 ;
 ; if rum not started quit.
 I '$G(^%ZTSCH("LOGRSRC")) D  Q
 .S KMPRENV="1^RUM is not turned on"
 .D:'KMPRQIET ENVOUTPT(KMPRENV,1,1)
 ;
 S TEXT="KMPR BACKGROUND DRIVER"
 S IEN=$O(^DIC(19,"B",TEXT,0))
 I 'IEN D  Q
 .S KMPRENV="201^The RUM background driver option [KMPR BACKGROUND DRIVER] is missing"
 .D:'KMPRQIET ENVOUTPT(KMPRENV,1,1)
 ;
 S IEN1=$O(^DIC(19.2,"B",IEN,0))
 I 'IEN1!($P($G(^DIC(19.2,+IEN1,1)),U)']"") D 
 .S KMPRENV="200^RUM is on but the option '"_TEXT_"' is not scheduled to run"
 ;
 Q:KMPRQIET
 D ENVOUTPT(KMPRENV,1,1) I +KMPRENV<100 Q
 ;
 K DIR S DIR(0)="YO",DIR("B")="YES"
 S DIR("A")="Do you want me to queue this option to run every night at 1 a.m."
 W ! D ^DIR Q:'Y
 ;
 D QUEBKG
 ;
 W !
 S KMPRENV="0^RUM turned on and background job queued"
 ;
 Q
 ;
ENVOUTPT(KMPRENV,KMPRHILT,KMPRCNTR) ;-- environment check output.
 ;-----------------------------------------------------------------------
 ; KMPRENV... Environment output (see ENVCHECK).
 ; KMPRHILT.. Highlight text: 0 - do not highlight.
 ;                            1 - highlight text.
 ; KMPRCNTR.. Center text:    0 - do not center text.
 ;                            1 - center text.
 ;-----------------------------------------------------------------------
 ;
 S KMPRENV=$G(KMPRENV),KMPRHILT=+$G(KMPRHILT),KMPRCNTR=+$G(KMPRCNTR)
 Q:KMPRENV=""
 ;
 N INDENT,IORVOFF,IORVON,TEXT
 S X="IORVOFF;IORVON" D ENDR^%ZISS
 S KMPRENV=$P(KMPRENV,U,2)
 S:KMPRHILT KMPRENV=IORVON_" "_KMPRENV_" "_IORVOFF
 S TEXT(1)=KMPRENV
 I KMPRCNTR S INDENT=80-$L(TEXT(1))\2,TEXT(1,"F")="!?"_INDENT
 D EN^DDIOL(.TEXT)
 ;
 Q
 ;
PKG(PACKAGE) ; Select Package(s)
 ; Output Variable:
 ;   PACKAGE = Contains array of package names
 ;           = PACKAGE("^") if DTOUT or DUOUT
 ;
 N DIR,DTOUT,DUOUT,Y
 S DIR(0)="FO^1:999:0"
 F  D  Q:$D(DTOUT)!$D(DUOUT)!(Y="")
 .S DIR("A")="Select Package Namespace" D ^DIR I Y'="" S PACKAGE(Y)=""
 .I Y=" " W !,*7,"Please enter a valid package namespace.",!
 S:$D(DTOUT)!$D(DUOUT)!('$D(PACKAGE)) PACKAGE("^")=""
 W !
 Q
 ;
QUEBKG ;-- queue background job KMPR BACKGROUND DRIVER
 N DA,DIK,FDA,ERROR,IEN,IEN1,IENZ,TEXT,X,Y,Z
 S:'$G(DT) DT=$$DT^XLFDT
 S TEXT="KMPR BACKGROUND DRIVER"
 S IEN=$O(^DIC(19,"B",TEXT,0)) Q:'IEN
 S IEN1=$O(^DIC(19.2,"B",IEN,0))
 ; if already in file 19.2 then kill.
 I IEN1 S DIK="^DIC(19.2,",DA=IEN1 D ^DIK
 ; schedule for tomorrow@1am.
 S FDA($J,19.2,"+1,",.01)=IEN
 ; queued to run at what time - set to tomorrow@1am
 S FDA($J,19.2,"+1,",2)=$$FMADD^XLFDT(DT,1)_".01"
 ; rescheduling frequency.
 S FDA($J,19.2,"+1,",6)="1D"
 D UPDATE^DIE("","FDA($J)",.IENZ,"ERROR")
 I $D(ERROR) D MSG^DIALOG("W","",60,10,"ERROR")
 Q
