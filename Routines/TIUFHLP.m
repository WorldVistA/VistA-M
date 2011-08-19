TIUFHLP ; SLC/MAM,JER - On-line help library: HELP ;4/23/97  11:19
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
HELP ; Action Help for TIUF Document Definition Templates A, C, H, J,T,D,X
 N TIUX,ORU,ORUPRMT,VALMDDF,VALMPGE,CREATE,DTOUT,DIRUT,DIROUT
 S TIUX=$$UPPER^TIULS(X),CREATE=$G(TIUFCBEG)
 S VALMBCK="R",VALMSG=$$VMSG^TIUFL
 D ONE:TIUX="?NEW",ONE:TIUX="?",TWO:TIUX="??",THREE:TIUX="???"
HELPX I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
ONE ; Help for One ?.
 ;Requires CREATE
 I TIUX="?NEW" W !?3 D FULL^VALM1,ITEM(^TMP("TIUF",$J,"NEWHELP")) D  Q  ;Option Create
 . W !,"   Enter ? for Help"
 . W !,"   Enter ?? for detailed help on actions including PRINTING"
 . W !,"   Enter ??? for detailed help on display"
 . D PAUSE^TIUFXHLX
 I TIUFTMPL="C",'$D(TIUFSTMP) W !,TIUFCMSG(1),!,TIUFCMSG(2),! W:$D(TIUFCMSG(3)) TIUFCMSG(3),! D PAUSE^TIUFXHLX Q:$D(DIRUT)
 D DISP^XQORM1 D PAUSE^TIUFXHLX Q:$D(DIRUT)
 W !!," Type action name from Action List. Example: Type 'D' or 'DET' for Detailed",!,"Display.  There are also 'Hidden Actions' which don't show on the Action List",!,"such as PL Print List."
 W "  Enter ?? to see hidden actions, and for",!,"descriptions of actions."
 D PAUSE^TIUFXHLX Q:$D(DIRUT)
 W !," Action and Entry Number can be selected in a single step.  Examples: To see a",!,"Detailed Display of Entry 3, enter 'DET=3'.  To scroll to the extreme right,",!,"enter '>=>'.",!
 D PAUSE^TIUFXHLX Q:$D(DIRUT)
 I ("HACJ"[TIUFTMPL&'$D(TIUFSTMP))!($G(TIUFSTMP)="T") D  Q:$D(DIRUT)
 . W !!,"To see more columns of essential information, enter '>' to scroll to the right",!,"whenever >>> shows on the highlighted message bar.  Enter '<' to scroll left.",!!
 . D PAUSE^TIUFXHLX
 W !,"  Enter ? for Help"
 W !,"  Enter ?? for detailed help on actions including PRINTING"
 W !,"  Enter ??? for detailed help on display",!
 I TIUFTMPL="C" W "  Enter '?NEW' for New User Help"
 D PAUSE^TIUFXHLX Q:$D(DIRUT)
 W !,"  When editing a field (as opposed to Selecting an Action), ? will give you one"
 W !,"line of help on the field.  ?? will give you a complete description of the"
 W !,"field and how it works.",!
 D PAUSE^TIUFXHLX
 Q
 ;
TWO ; Help for ??
 D FULL^VALM1,CLEAR^VALM1
 W !!,$$CENTER^TIUFL("Help on Listed Actions",80),!!
 W !,"Actions are not selectable when they are enclosed in parentheses.",!!
 K DIRUT D MENU(XQORNOD) Q:$D(DIRUT)
 W !!,$$CENTER^TIUFL("Help on Hidden Actions including PRINTING",80),!!
 D MENU(^TMP("TIUF",$J,"HIDDEN"))
 Q
 ;
THREE ; Help for ???
 D FULL^VALM1,CLEAR^VALM1
 I "HACJ"[TIUFTMPL,'$D(TIUFSTMP) D BASINFD
 I $G(TIUFSTMP)="T" D ITEMINFD
 I $G(TIUFSTMP)="D" D EDITVW^TIUFHLP1
 I $G(TIUFSTMP)="X" D BOILTX^TIUFHLP1
 Q
 ;
BASINFD ; Write Field Description for Basic Info Fields
 N TIUI,FLDNM,FLDNO,MSG,HERE
 W !,$$CENTER^TIUFL("Help on Display",80),! K DIROUT
 F FLDNO=.01,.04,.1,.13,.07,.05,.06,.08,.12,.03,.11 D  Q:$D(DIROUT)
 . I $G(TIUFTMPL)="J",(FLDNO=.1)!(FLDNO=.08)!(FLDNO=.12)!(FLDNO=.11) Q
 . S FLDNM=$P(^TMP("TIUF",$J,FLDNO,"LABEL"),U)
 . K DIRUT W:$$CONTINUE !?1,$G(IOINHI),FLDNM,$G(IOINORM),! Q:$D(DIRUT)
 . I FLDNO=.01,TIUFTMPL="H",'$D(TIUFSTMP) W !,"   Plus (+) indicates entry has Items under it and can be expanded.",!!
 . D HELP^DIE(8925.1,"",FLDNO,"D")
 . S HERE=1 I $G(TIUFTMPL)="J",(FLDNO=.04)!(FLDNO=.07)!(FLDNO=.01) S HERE=0
 . F TIUI=1:1:DIHELP S MSG=^TMP("DIHELP",$J,TIUI) K DIRUT D  Q:$D(DIRUT)
 . . I FLDNO=.04,$G(TIUFTMPL)="J",MSG["O OBJECT" S HERE=1
 . . I FLDNO=.07,$G(TIUFTMPL)="J",MSG["OBJECT STATUS",MSG'["OBJECT STATUS," S HERE=1
 . . I FLDNO=.01,$G(TIUFTMPL)="J",MSG["OBJECT Name" S HERE=1
 . . W:HERE&$$CONTINUE ?3,MSG,!
 D CLEAN^DILF
 Q
 ;
ITEMINFD ; Write Field Description for Item Fields
 N TIUI,FLDNM,FLDNO,MSG
 W !,$$CENTER^TIUFL("Help on Display",80),! K DIROUT
 F FLDNO=10 D  Q:$D(DIROUT)
 . S FLDNM=^TMP("TIUF",$J,FLDNO,"LABEL")
 . K DIRUT W:$$CONTINUE !?1,$G(IOINHI),FLDNM,$G(IOINORM),! Q:$D(DIRUT)
 . D HELP^DIE(8925.1,"",FLDNO,"D")
 . F TIUI=1:1:DIHELP S MSG=^TMP("DIHELP",$J,TIUI) K DIRUT D  Q:$D(DIRUT)
 . . W:$$CONTINUE ?3,MSG,!
 K DIROUT F FLDNO=2:1:4 D  Q:$D(DIROUT)
 . S FLDNM=^TMP("TIUF",$J,10,FLDNO,"LABEL")
 . K DIRUT W:$$CONTINUE !?1,$G(IOINHI),FLDNM,$G(IOINORM),! Q:$D(DIRUT)
 . D HELP^DIE(8925.14,"",FLDNO,"D")
 . F TIUI=1:1:DIHELP S MSG=^TMP("DIHELP",$J,TIUI) K DIRUT D  Q:$D(DIRUT)
 . . W:$$CONTINUE ?3,MSG,!
 D CLEAN^DILF
 Q
 ;
MENU(XQORNOD) ; Unwind protocol menus for help
 N TIUSEQ,TIUI,TIUJ
 K DIRUT W:$$CONTINUE "The following actions are available:",! Q:$D(DIRUT)
 S TIUI=0 F  S TIUI=$O(^ORD(101,+XQORNOD,10,TIUI)) Q:+TIUI'>0  K DIRUT D  Q:$D(DIRUT)
 . S TIUJ=+$P($G(^ORD(101,+XQORNOD,10,TIUI,0)),U,3) S:$D(TIUSEQ(TIUJ)) TIUJ=TIUJ+.1
 . S TIUSEQ(TIUJ)=+$P(^ORD(101,+XQORNOD,10,TIUI,0),U)
 S TIUI=0 F  S TIUI=$O(TIUSEQ(TIUI)) Q:+TIUI'>0  K DIRUT D  Q:$D(DIRUT)
 . I $D(^ORD(101,+TIUSEQ(TIUI),0)) D ITEM(+TIUSEQ(TIUI))
 Q
ITEM(XQORNOD) ; Show descriptions of protocol menu actions
 N TIUI,TMPQUIT,HERE
 Q:$P($G(^ORD(101,+XQORNOD,0)),U,2)']""
 I $G(TIUFTMPL)="J",$G(TIUFSTMP)="D",(^ORD(101,+XQORNOD,0)["Items")!(^ORD(101,+XQORNOD,0)["Boil")!(^ORD(101,+XQORNOD,0)["Upload") Q
 I $G(TIUFSTMP)="T",^ORD(101,+XQORNOD,0)["Try" Q
 Q:XQORNOD=^TMP("TIUF",$J,"STOP")  ;protocol TIUF QUIT1  in hidden actions - dummy to allow user to enter QU
 ; ?NEW for create is contained in protocol TIUFC ACTION MENU; don't write the name of the protocol:
 ; Note on heritable fields is contained in protocol TIUFD ACTION MENU MGR; don't write the name of the protocol:
 I XQORNOD'=^TMP("TIUF",$J,"NEWHELP"),XQORNOD'=^TMP("TIUF",$J,"INHERIT") K DIRUT W:$$CONTINUE ?1,$G(IOINHI),$$UPPER^TIULS($P($G(^ORD(101,+XQORNOD,0)),U,2)),$G(IOINORM),! Q:$D(DIRUT)
 S HERE=1 I $G(TIUFTMPL)="J",$G(^ORD(101,+XQORNOD,0))["Delete" S HERE=0
 S TIUI=0 F  S TIUI=$O(^ORD(101,+XQORNOD,1,TIUI)) Q:+TIUI'>0  K DIRUT D  Q:$D(DIRUT)
 . S LINE=$G(^ORD(101,+XQORNOD,1,TIUI,0))
 . Q:'$$CONTINUE
 . I 'HERE,LINE["OBJECT DELETE" S HERE=1
 . I 'HERE Q
 . ; ?NEW for create, note on heritable: first 2 lines aren't relevant:
 . I XQORNOD=^TMP("TIUF",$J,"NEWHELP")!(XQORNOD=^TMP("TIUF",$J,"INHERIT")),TIUI<3 Q
 . ;protocol description is written in 2 parts, first for clinicians, second for managers. Display appropriate part:
 . I TIUFWHO="C" D
 . . Q:LINE["CLINICIAN OPTIONS"
 . . I LINE'["MANAGER OPTIONS" W ?3,$G(^ORD(101,+XQORNOD,1,TIUI,0)),! Q
 . . S TIUI=5000
 . I "NM"[TIUFWHO D
 . . I LINE["CLINICIAN OPTIONS" S TMPQUIT=1 Q
 . . I LINE["MANAGER OPTIONS" S TMPQUIT=0 Q
 . . Q:$G(TMPQUIT)
 . . W ?3,$G(^ORD(101,+XQORNOD,1,TIUI,0)),!
 Q:XQORNOD=^TMP("TIUF",$J,"NEWHELP")  ;don't show items of TIUFC ACTION MENU
 Q:XQORNOD=^TMP("TIUF",$J,"INHERIT")  ;don't show items of TIUFD ACTION MENU MGR
 S TIUI=0 F  S TIUI=$O(^ORD(101,+XQORNOD,10,TIUI)) Q:+TIUI'>0  K DIRUT D  Q:$D(DIRUT)
 . D ITEM(+$G(^ORD(101,+XQORNOD,10,+TIUI,0))_";ORD(101,")
 Q
CONTINUE() ; Pagination control
 N Y K DIRUT
 I $Y<(IOSL-2) S Y=1 G CONTX
 S Y=$$BOTTM W @IOF,!
CONTX Q Y
 ;
BOTTM() ; Call DIR at bottom of screen
 N DIR,X,Y
 I $E(IOST)'="C" S Y=1 G BOTTX
 I (IOSL>($Y+5)) F  W ! Q:IOSL<($Y+6)
 S DIR(0)="FO^1:1",DIR("A")="Press RETURN to continue or '^' or '^^' to exit"
 S DIR("?")="Enter '^' to quit present section or '^^' to quit to menu"
 D ^DIR I $D(DIRUT),(Y="") K DIRUT
 S Y=$S(Y="^"!(Y="^^"):Y,$D(DTOUT):"",1:1)
BOTTX Q Y
