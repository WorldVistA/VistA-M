TIUAUD00 ; SPFO/AJB - AUDIT SIGNED DOCUMENTS ;07/19/22  08:09
 ;;1.0;TEXT INTEGRATION UTILITIES;**343**;Jun 20, 1997;Build 17
 ;
 Q
EN ;
 D HOME^%ZIS,PREP^XGF ; ICR # 3173
 D EN^VALM("TIU VIEW FM AUDITS")
 D CLEAN^XGF
 Q
HDR ;
 K VALMHDR S VALMHDR(1)="",VALMHDR(2)=$$CJ^XLFSTR("Signed Documents [Edited]",IOM)
 Q
INIT ;
 K @VALMAR S VALMCNT=0
 I '$D(^TIU(8925,"AUD")) D SET^VALM10(2,$$CJ^XLFSTR("<no entries>",IOM),0),XQORM Q
 N ENTRY,PREVIOUS S ENTRY="" F  S ENTRY=$O(^TIU(8925,"AUD",ENTRY),-1) Q:'+ENTRY  D
 . N FLD,NODE0 S NODE0=^TIU(8925,"AUD",ENTRY,0),FLD=$P(NODE0,U,3)
 . S PREVIOUS=$O(^TIU(8925,"AUD",ENTRY)) S:+PREVIOUS PREVIOUS=$P($G(^TIU(8925,"AUD",PREVIOUS,0)),U,2)
 . D FIELD^DID(8925,FLD,,"LABEL","FLD")
 . S VALMCNT=VALMCNT+1,X=""
 . S X=$$SETFLD^VALM1(VALMCNT,X,"ENTRY")
 . S X=$$SETFLD^VALM1(+NODE0,X,"DOCUMENT")
 . N VALUE S VALUE=$$FMTE^XLFDT($P(NODE0,U,2)) I +PREVIOUS,$P(NODE0,U,2)>PREVIOUS S VALUE=VALUE_"*"
 . S X=$$SETFLD^VALM1(VALUE,X,"DATE/TIME")
 . S X=$$SETFLD^VALM1(FLD("LABEL"),X,"FIELD")
 . D SET^VALM10(VALMCNT,X,ENTRY)
 D XQORM
 Q
SELECT ;
 I VALMCNT=0 Q
 N SEL S SEL=$S(VALMCNT=1:"1,",+XQORNOD(0):$$LOR(.SEL),1:$P(XQORNOD(0),"=",2)) Q:'+SEL
 I '$D(SEL(0)) S SEL(0)=SEL
 N END,ZTSAVE S ZTSAVE("SEL")="" W !,IOCUON
 D EN^XUTMDEVQ("DISPLAY^TIUAUD00(.SEL)","TIU Audit Display",.ZTSAVE)
 Q
BRK ;
 I $E(IOST,1,2)="C-" S END=$$FMR("EA","Press <Enter> to continue or '^' to exit ")
 Q:END=U
CLS ;
 W:$E(IOST,1,2)="C-" @IOF
 Q
DISPLAY(SEL) ;
 S END=0
 D:$E(IOST,1,2)="C-" CLS
 N NODE S NODE="" F  S NODE=$O(SEL(NODE)) Q:NODE=""!(END=U)  S SEL=($L(SEL(NODE),",")-1) N PIECE F PIECE=1:1:SEL D  Q:END=U
 . N ENTRY,IEN S ENTRY=$P(SEL(NODE),",",PIECE),IEN=$O(@VALMAR@("IDX",ENTRY,""))
 . N NODE0 S NODE0=$G(^TIU(8925,"AUD",IEN,0))
 . N DTE S DTE=$$FMTE^XLFDT($P(NODE0,U,2))
 . N FLD S FLD=$P(NODE0,U,3) D FIELD^DID(8925,FLD,,"LABEL","FLD")
 . N RTX S RTX=$S(FLD=2:1,1:0)
 . N TTL S TTL=$P(^TIU(8925.1,$P(^TIU(8925,+NODE0,0),U),0),U)
 . N USR S USR=$$GET1^DIQ(200,$P(NODE0,U,4),.01)
 . N NV S NV=$G(^TIU(8925,"AUD",IEN,3),"<deleted>")
 . N OV S OV=$G(^TIU(8925,"AUD",IEN,2),"<null>")
 . N LINE,X F X=1:1 S LINE=$P($T(OUTPUT+X),";;",2) Q:LINE="EOM"!(END=U)  D
 . . D BRK:$Y+4>IOSL Q:END=U  W @LINE,!
 . Q:END=U
 . I 'RTX W ! F X="OV","NV" D BRK:$Y+4>IOSL Q:END=U  W ?13,$S(X="NV":"New",1:"Old")," Value: ",@X,! W:X="NV" !
 . I +RTX D
 . . N NODE F NODE=2.14,3.14 D  Q:END=U
 . . . D BRK:$Y+4>IOSL Q:END=U  W !
 . . . D BRK:$Y+4>IOSL Q:END=U  W $S(NODE=2.14:$$CJ^XLFSTR("< original REPORT TEXT>",IOM),NODE=3.14:$$CJ^XLFSTR("< updated  REPORT TEXT>",IOM))
 . . . S LINE=0 F  S LINE=$O(^TIU(8925,"AUD",IEN,NODE,LINE)) Q:'+LINE!(END=U)  D
 . . . . D BRK:$Y+4>IOSL Q:END=U  W !
 . . . . D BRK:$Y+4>IOSL Q:END=U  W ^TIU(8925,"AUD",IEN,NODE,LINE,0)
 . . . Q:END=U
 . . . D BRK:$Y+4>IOSL Q:END=U  W !
 . . . D BRK:$Y+4>IOSL Q:END=U  W $S(NODE=2.14:$$CJ^XLFSTR("</original REPORT TEXT>",IOM),NODE=3.14:$$CJ^XLFSTR("</updated  REPORT TEXT>",IOM)) W:NODE=3.14 !!
 . . Q:END=U
 . Q:END=U
 . I IOSL=24 F  Q:$Y+4>IOSL  W !
 . I $E(IOST,1,2)="C-",$O(SEL(NODE))="",PIECE=SEL S END=$$FMR("EA",IOCUOFF_IORVON_"Press <ENTER> to continue "_IORVOFF)
 D INIT ; refresh entries
 Q
RTXINF ;
 ;;""
 ;;$$CJ^XLFSTR("<original  REPORT TEXT>",IOM)
 ;;EOM
OUTPUT ;
 ;;?5,"    Audit Entry #: ",ENTRY
 ;;?5,"=================================================="
 ;;?5,"Date/Time of Edit: ",DTE
 ;;?5,"     Field Edited: ",FLD("LABEL")
 ;;?5,"       Document #: ",+NODE0
 ;;?5,"   Document Title: ",$E(TTL,1,60)
 ;;?5,"        Edited By: ",USR
 ;;EOM
HTXT ;
 ;;
 ;; Detailed View allows you to select one or more entries from the AUDIT data and
 ;; ouput the information to the desired DEVICE for display or printing.
 ;;
 ;; Entries should always be in descending order by Date/Time of Edit.
 ;; An asterisk (*) with the Date/Time of Edit indicates that audit data has been
 ;; deleted via programmer mode since these entries will never be removed by TIU
 ;; or FileMan.
 ;;EOM
HELP ;
 D FULL^VALM1 W @IOF
 N LINE,X F X=1:1 S LINE=$P($T(HTXT+X),";;",2) Q:LINE="EOM"  D
 . W LINE,!
 I VALMANS="?" D FMR("EA"," Press <Enter> to continue or '^' to exit. ")
 S VALMBCK="R"
 Q
EXIT ;
 D XQORM,FULL^VALM1
 Q
XQORM ;
 S XQORM("#")=$O(^ORD(101,"B","TIU FM AUDIT VIEW",0))_U_"1:"_VALMCNT
 Q
EXPND ;
 Q
FMR(DIR,PRM,DEF,HLP,SCR) ; fileman reader
 N DILN,DILOCKTM,DISYS
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=DIR S:$G(PRM)'="" DIR("A")=PRM S:$G(DEF)'="" DIR("B")=DEF S:$G(SCR)'="" DIR("S")=SCR
 I $G(HLP)'="" S DIR("?")=HLP
 I $D(HLP) M DIR=HLP
 W $G(IOCUON) D ^DIR W $G(IOCUOFF)
 Q $S($D(DIROUT):U,$D(DIRUT):U,$D(DTOUT):U,$D(DUOUT):U,1:Y)
LOR(SEL) ; list or range of numbers
 N DIR,X,Y
 S DIR(0)="LOA^1:"_VALMCNT_":0",DIR("A")="Select one or more ENTRIES (1-"_VALMCNT_"): "
 S DIR("?")="Enter a list or range of numbers from 1 to "_VALMCNT
 D ^DIR
 M SEL=Y
 Q SEL
