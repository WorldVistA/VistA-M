TIUADCL1 ; SLC/AJB - UNK Addenda Cleanup ; 10/01/04
 ;;1.0;TEXT INTEGRATION UTILITIES;**173**;Jun 20, 1997
 ;
 ; Cleanup Utility for OPERATION REPORT addenda.
 ; Finds parentless/unknown addenda and attaches to user
 ; selected parent.
 ;
 Q
EN ; main entry point for TIU UNK ADDENDA CLEANUP
 N DTR2,TIUADD,TIULVL,TIUQUIT
 D SAVEADD
 D DTRANGE^TIUADCL(.DTR2) Q:$D(TIUQUIT)
 D EN^VALM("TIU UNK ADDENDA ATTACH")
 K ^TMP("VALMAR",$J,TIULVL)
 Q
EXIT ;
 D XQORM
 Q
HDR ; sets header
 N HDR
 S HDR="OPERATION REPORTS from "_$$FMTE^XLFDT(DTR2("BEGDT"),"D")_" to "_$$FMTE^XLFDT(DTR2("ENDDT"),"D")
 S VALMHDR(1)=$$SETSTR^VALM1(HDR,"",(IOM-$L(HDR))/2,$L(HDR))
 D XQORM
 Q
HELP ; help code
 N DIR
 I X="?" S DIR("A")="Enter RETURN to continue or '^' to exit",DIR(0)="E"
 D FULL^VALM1
 W !!,"The following actions are available:"
 W !,"Browse a Document  - View a selected document (if authorized)"
 W !,"Change View        - Modify search criteria"
 W !,"Detailed Display   - View detailed display of a document (if authorized)"
 W !,"Attach to Parent   - Attach the currently selected "
 W $S($$MULTI^TIUADCL("TIUADD")>1:"addenda",1:"addendum")," to one OPERATION"
 W !,"                     REPORT",!
 I $D(DIR("A")) D ^DIR
 S VALMBCK="R"
 Q
INIT ; finds unknown addenda & creates list
 N OPREPORT,STRTDT,TIUDA,TIU
 S TIULVL=VALMEVL,TIU("IOCUOFF")=$C(27)_"[?25l",TIU("IOCUON")=$C(27)_"[?25h"
 W TIU("IOCUOFF")
 W !!,"Searching for the documents."
 S OPREPORT=$$CHKFILE^TIUADCL(8925.1,"OPERATION REPORT","I $P(^(0),U,4)=""DOC"""),TIUDA="",STRTDT=DTR2("BEGDT"),VALMCNT=0
 F  S STRTDT=$O(^TIU(8925,"F",STRTDT)) Q:STRTDT=""!(STRTDT>DTR2("ENDDT"))  F  S TIUDA=$O(^TIU(8925,"F",STRTDT,TIUDA)) Q:TIUDA=""  I +$G(^TIU(8925,TIUDA,0))=OPREPORT D
 . N DATA,DISPLAY,MSG
 . I '$D(TIUADD($$GET1^DIQ(8925,TIUDA,.02))) Q
 . ; D CANDO^TIUSRVA(.MSG,TIUDA,"MAKE ADDENDUM") I '+MSG Q
 . S VALMCNT=VALMCNT+1 W:VALMCNT#3=0 "."
 . S DISPLAY=$$SETSTR^VALM1(VALMCNT,"",1,4)
 . S DISPLAY=$$SETSTR^VALM1($$PATIENT^TIU144($P($G(^TIU(8925,TIUDA,0)),U,2)),DISPLAY,6,38)
 . S DISPLAY=$$SETSTR^VALM1(TIUDA,DISPLAY,40,50)
 . S DISPLAY=$$SETSTR^VALM1($$FDATE^VALM1($$GET1^DIQ(8925,TIUDA,1201,"I")),DISPLAY,52,62)
 . S DISPLAY=$$SETSTR^VALM1($$GET1^DIQ(8925,TIUDA,.05),DISPLAY,62,71)
 . S DISPLAY=$$SETSTR^VALM1("#"_+$P($G(^TIU(8925,TIUDA,14)),U,5),DISPLAY,75,80)
 . D SET^VALM10(VALMCNT,DISPLAY,TIUDA)
 I VALMCNT=0 D
 . D SET^VALM10(2,$$SETSTR^VALM1("No records found to satisfy search criteria.","",(IOM-$L("No records found to satisfy search criteria."))/2,$L("No records found to satisfy search criteria.")),0)
 Q
XQORM ; default action for list manager
 S XQORM("#")=$O(^ORD(101,"B","TIU UNK ADDENDA SELECT",0))_U_"1:"_VALMCNT
 Q
ATTACH ;
 N DISPLAY,LINE,PARENT
 D FULL^VALM1 W @IOF
 W "Attach the following UNKNOWN "_$S($$MULTI^TIUADCL("TIUADD")>1:"Addenda",1:"Addendum")_":",!!
 W "TIU",!,"Doc No.",?9,"Patient",?40,"Entry DT/Time",?59,"Status",?71,"Parent",!
 S LINE="",PARENT=$$ONEDOC^TIUADCL()
 S $P(LINE,"-",80)="-" W LINE
 S TIUADD="" F  S TIUADD=$O(TIUADD(TIUADD)) Q:TIUADD=""!(+TIUADD'>0)  D
 . N TIUDA
 . S TIUDA=TIUADD(TIUADD)
 . S DISPLAY=$$SETSTR^VALM1(TIUDA,"",1,8)
 . S DISPLAY=$$SETSTR^VALM1($$PATIENT^TIU144($P($G(^TIU(8925,TIUDA,0)),U,2)),DISPLAY,10,40)
 . S DISPLAY=$$SETSTR^VALM1($$FDTTM^VALM1($$GET1^DIQ(8925,TIUDA,1201,"I")),DISPLAY,41,51)
 . S DISPLAY=$$SETSTR^VALM1($$GET1^DIQ(8925,TIUDA,.05),DISPLAY,60,67)
 . S DISPLAY=$$SETSTR^VALM1($S($$GET1^DIQ(8925,TIUDA,.06)="":"None",1:$$GET1^DIQ(8925,TIUDA,.06)),DISPLAY,72,80)
 . W $E(DISPLAY,1,80)
 W !!,"to the following "_$$GET1^DIQ(8925,PARENT,.01)_"?",!
 S DISPLAY=$$SETSTR^VALM1(PARENT,"",1,8)
 S DISPLAY=$$SETSTR^VALM1($$PATIENT^TIU144($P($G(^TIU(8925,PARENT,0)),U,2)),DISPLAY,10,40)
 S DISPLAY=$$SETSTR^VALM1($$FDTTM^VALM1($$GET1^DIQ(8925,PARENT,1201,"I")),DISPLAY,41,51)
 S DISPLAY=$$SETSTR^VALM1($$GET1^DIQ(8925,PARENT,.05),DISPLAY,60,67)
 S DISPLAY=$$SETSTR^VALM1("#"_+$P($G(^TIU(8925,PARENT,14)),U,5),DISPLAY,72,80)
 W !,"TIU",?71,"Surgical",!,"Doc No.",?9,"Patient",?40,"Entry DT/Time",?59,"Status",?71,"Case No.",!
 W LINE,$E(DISPLAY,1,80),!
 S VALMBCK="R"
 I '$$READ^TIUU("Y","Do you wish to begin attaching","NO","Enter 'Y' or 'N'") W ! I $$READ^TIUU("EA","Press <RETURN> to continue") Q
 S VALMBCK="Q"
 S TIUADD="" F  S TIUADD=$O(TIUADD(TIUADD)) Q:TIUADD=""!(+TIUADD'>0)  D
 . N TIUDA
 . S TIUDA=TIUADD(TIUADD)
 . W !!,"Attaching #",TIUDA," to #",PARENT,"  ... "
 . D ATNOW(PARENT,TIUDA)
 W ! I $$READ^TIUU("EA","Press <RETURN> to continue")
 Q
ATNOW(PARENT,ADDENDUM) ;
 N FDA,FDARR,IENS,FLAGS,TIUMSG,TIUA0,TIUA12,TIUP0,TIUP12,TIUWARN
 S TIUP0=$G(^TIU(8925,PARENT,0)),TIUA0=$G(^TIU(8925,ADDENDUM,0))
 S TIUP12=$G(^TIU(8925,PARENT,12)),TIUA12=$G(^TIU(8925,ADDENDUM,12))
 I $P(TIUP0,U,2)'=$P(TIUA0,U,2) W !,"ERROR:  Parent and Addendum have different patients!" S TIUWARN=1
 I $P(TIUA12,U)'>$P(TIUP12,U) W !,"ERROR:  The addendum's ENTRY DATE/TIME precedes the parent's ENTRY DATE/TIME!" S TIUWARN=1
 I +$G(TIUWARN) Q
 S IENS=""""_ADDENDUM_",""",FDARR="FDA(8925,"_IENS_")",FLAGS="K"
 S @FDARR@(.06)=PARENT
 S @FDARR@(1405)=$$GET1^DIQ(8925,PARENT,1405,"I")
 D FILE^DIE(FLAGS,"FDA","TIUMSG")
 I $D(TIUMSG) D  Q
 . N LINE S LINE=""
 . F  S LINE=$O(TIUMSG("DIERR",1,"TEXT",LINE)) Q:LINE=""  W !,TIUMSG("DIERR",1,"TEXT",LINE)
 W ?29," success!"
 Q
SAVEADD ;
 S TIUADD=0
 F  S TIUADD=$O(TIUDOCS(TIUADD)) Q:TIUADD=""  S TIUADD(TIUADD)=TIUDOCS(TIUADD),TIUADD($$GET1^DIQ(8925,TIUADD(TIUADD),.02))=""
 Q
PREP ;
 N DA,DIC,DIK,X,Y
 S DIC="^SD(409.61,",DIC(0)="X"
 F X="TIU UNK ADDENDA ATTACH","TIU UNK ADDENDA CLEANUP" D
 . D ^DIC I +Y D
 .. S DA=+Y,DIK=DIC D ^DIK
 Q
