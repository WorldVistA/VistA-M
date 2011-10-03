TIUFXHLX ; SLC/MAM - Xecutable Help  PAUSE, RESET, FLDDESC(FLDNO) ;10/26/95  15:33
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
PAUSE ; Writes Press Return to Continue or ^ to exit on NEXT line without writing !'s.
 N DIR,X,Y
 S DIR("?")="Press the RETURN key when you have read the screen and are ready to go on"
 S DIR(0)="FAO^1:1",DIR("A")="Press RETURN to continue or '^' or '^^' to exit: " D ^DIR
 I X="",'$D(DTOUT) K DIRUT
 Q
 ;
FLDHELP(FLDNO) ; Writes FLDNO Help Prompt
 I $G(TIUFXNOD)["Sort" W !
 D HELP^DIE(8925.1,"",FLDNO,"H")
 D MSG^DIALOG("HW")
 Q
 ;
FLDDESC(FILENO,FLDNO) ; Sets to scroll mode; Writes FLDNO Field Description to Screen
 N TIUI,FLDNAME,HERE,MSG
 K DIRUT
 D HELP^DIE(8925.1,"",FLDNO,"D")
 S FLDNAME=$S(FILENO=8925.1:$G(^TMP("TIUF",$J,FLDNO,"LABEL")),FILENO=8925.14:$G(^TMP("TIUF",$J,10,FLDNO)),FILENO=8925.11:$G(^TMP("TIUF",$J,1,FLDNO,"LABEL")),1:"")
 I FLDNAME="" S FLDNAME=$G(^TMP("TIUF",$J,2,FLDNO,"LABEL"))
 S FLDNAME=$P(FLDNAME,U)
 I $D(TIUFTMPL) D FULL^VALM1 S TIUFFULL=1 W !
 I $G(TIUFXNOD)["Sort" W !
 I FLDNAME'="" W $$CENTER^TIULS("Description of "_FLDNAME),!!
 D HELP^DIE(8925.1,"",FLDNO,"D")
 S HERE=1 I $G(TIUFTMPL)="J",(FLDNO=.04)!(FLDNO=.07) S HERE=0
 F TIUI=1:1:DIHELP S MSG=^TMP("DIHELP",$J,TIUI) D  Q:$D(DIRUT)
 . I FLDNO=.04,$G(TIUFTMPL)="J",MSG["O OBJECT" S HERE=1
 . I FLDNO=.07,$G(TIUFTMPL)="J",MSG["OBJECT STATUS",MSG'["OBJECT STATUS," S HERE=1
 . W:HERE&$$CONTINUE MSG,!
 F  Q:$Y>(IOSL-1)  W !
 I '$D(DIRUT) D PAUSE
FLDDX D CLEAN^DILF
 Q
 ;
RESET ; -- reset scrolling region to bottom of screen
 N DX,DY
 W IOELALL
 S IOTM=10,IOBM=IOSL W IOSC W @IOSTBM W IORC
 S DX=0,DY=(VALM("BM")+1) X IOXY
 Q
 ;
NAME ;XECUTABLE HELP for .01 NAME
 N HELPX S HELPX=X
 I $G(TIUFSTMP)="T" D  Q
 . I HELPX="??" D PAUSE
 . W !," Name may be a preexisting file entry OR a NEW file entry.",!
 . W !," If Name already exists in the file, it must have the appropriate Type for",!
 . W "the parent, must be owned by the user, must NOT already be used elsewhere",!
 . W "(unless it is a Shared Component), must not have the same Name as any Item under",!
 . W "the parent, and must pass Check as OK.",!
 . W !," Option Add Items does not accept and does not list other Names as choices.",!
 . W !," If file already has an available entry of a given name and you want to enter a",!,"new entry of that name instead, enclose it in quotation marks.",!
 . I HELPX'["?" W !," Name is 3-60 characters, not starting with punctuation.",! ; One ?; No to list
 . I HELPX="??" D FLDDESC(8925.1,.01)
 ; Edit Basics, Add Entry, Create Entry, Name (Edit Name from front Template):
 I $G(TIUFTMPL)="C",$G(TIUFSTMP)="" W !!,"You are creating a new entry of Type "_$P(TIUFXNOD,U,3)_" to hang ",!,"under "_$G(TIUFCNM)_".  3-60 characters, not starting with punctuation.",!
 I HELPX="?" D FLDHELP(.01)
 I HELPX="??" D FLDDESC(8925.1,.01)
 Q
 ;
TYPE ; XECUTABLE HELP for .04 TYPE
 N HELPX S HELPX=X
 ; For choosing sort criteria, TIUFXNOD="Sort"
 ; Otherwise, 3rd Piece of TIUFXNOD = "Change View" "Basics" "Create"
 ;"Class/DocumentClass" "Title" "Component" "Create Document Definitions"
 I HELPX="?" D FLDHELP(.04),TYPELST
 I HELPX="??" D FLDDESC(8925.1,.04)
 Q
 ;
TYPELST ; Writes remarks, list of type choices
 ; Requires TIUFTMSG, TIUFTLST from TIUFLF7 if editing type
 N OKTYPES,TAB
 I $G(TIUFXNOD)["Basics" W !," Permitted Types are limited by Parent Type."
 I $G(TIUFXNOD)["Change View"!($G(TIUFXNOD)["Sort") W !," File may contain (faulty) entries with no Type (NONE)."
 I $G(TIUFXNOD)["Sort" W !!," You are limiting the list of entries you will see to those with a",!,"particular Type."
 I $G(TIUFXNOD)["Create Doc" W !," Type is limited by the Type of your Current Position (Highlighted)."
 I $G(TIUFXNOD)'["Sort" D PAUSE
 S OKTYPES=$S($D(TIUFTLST):TIUFTLST,1:"^CL^DC^DOC^CO^O^N^") ;for Sort, Change View
 I $D(TIUFTMSG(1)) W !,TIUFTMSG(1) W:$D(TIUFTMSG(2)) !,TIUFTMSG(2),! D PAUSE
 I OKTYPES="" W !,"Type problem; See IRM" Q
 S TAB=5
 I $G(TIUFXNOD)["Sort" W !
 W !,"Choose from:"
 I OKTYPES["CL" W:TAB=5 ! W ?TAB,"Class" S TAB=$S(TAB=51:5,1:TAB+23)
 I OKTYPES["DC" W:TAB=5 ! W ?TAB,"Document Class" S TAB=$S(TAB=51:5,1:TAB+23)
 I OKTYPES["DOC" W:TAB=5 ! W ?TAB,"Title" S TAB=$S(TAB=51:5,1:TAB+23)
 I OKTYPES["CO" W:TAB=5 ! W ?TAB,"Component" S TAB=$S(TAB=51:5,1:TAB+23)
 I OKTYPES["^O^" W:TAB=5 ! W ?TAB,"Object" S TAB=$S(TAB=51:5,1:TAB+23)
 I OKTYPES["N" W:TAB=5 ! W ?TAB,"NONE"
 I $G(TIUFXNOD)["Sort" W !!
 Q
 ;
STATUS ; XECUTABLE HELP for .07 STATUS
 N HELPX S HELPX=X ;DO I NEED DBIA? MAM
 I HELPX="?" D
 . I $D(TIUFSMSG) W !,TIUFSMSG,! D PAUSE Q:$D(DIRUT)
 . I $G(TIUFSMSG)["OBJECT" D OBJMSG,PAUSE W ! D:'$D(DIRUT) SLIST Q
 . D FLDHELP(.07),SLIST
 I HELPX="??" D FLDDESC(8925.1,.07) W !
 Q
 ;
OBJMSG ; Writes msg about Object Status
 W !," Objects may have Status Active or Inactive.  Active designates objects as ready"
 W !,"for use.  It is up to the SITE to embed only Active Objects in Boilerplate Text."
 W !,"Objects must be Inactive before they can be edited. Inactive objects in",!,"boilerplate text don't retrieve data.  For more, enter ??? and see OBJECT STATUS"
 Q
 ;
SLIST ; Writes remarks, list of Status choices
 ; If used for edit status rather than select status for sort, requires TIUFSLST as set in SELSTAT^TIUFLF5
 I $G(TIUFXNOD)["Basics" W !,"Statuses are limited by Entry Type.  Statuses are also limited (to Inactive)",!,"by faults in Entry or by parent with Inactive Status." D PAUSE
 I $G(TIUFXNOD)["Create",TIUFTMPL="A" W !,"Status is limited to Inactive until the entry is added to the Hierarchy." D PAUSE
 I $G(TIUFXNOD)["Sort"!($G(TIUFXNOD)["Change View") W !," File may contain (faulty) entries with no Status (NONE)."
 I $G(TIUFXNOD)["Sort" W !!,"You are limiting the list of entries you will see to those with a",!,"particular Status.",!
 W !,"Choose from:"_$S($G(TIUFSLST)["A":"    ACTIVE",1:"")_$S($G(TIUFSLST)["I":"    INACTIVE",1:"")_$S($G(TIUFSLST)["T":"    TEST",1:"")_$S($G(TIUFSLST)["N":"    NONE",1:"") W:$G(TIUFXNOD)["Sort" !! W:$G(TIUFXNOD)["Change View" !
 I $G(TIUFSLST)="" W !,"Status problem; See IRM"
 Q
 ;
HELP1(FLDNO) ; Xe help for FLDNO's 5, 6, 6.1, 6.12,  6.13, 6.14, 7, 8
 N HELPX S HELPX=X
 I HELPX="??" D FLDDESC(8925.1,FLDNO)
 Q
 ;
CUSTOM ; Xe help for Allow Custom Form Headers
 N HELPX S HELPX=X
 I HELPX="?" D PAUSE
 I HELPX="??" D FLDDESC(8925.1,6.14)
 Q
 ;
HELP2(FLDNO) ; XECUTABLE HELP for FLDNO's .1 SHARED and .13 Nat'l
 N HELPX S HELPX=X
 I HELPX="?" D FLDHELP(FLDNO)
 I HELPX="??" D FULL^VALM1,FLDDESC(8925.1,FLDNO)
 Q
 ;
CONTINUE() ; Pagination control
 N Y
 I $Y<(IOSL-2) S Y=1 G CONTX
 S Y=$$STOP^TIUU("",1) W:+Y @IOF,!!
CONTX Q Y
 ;
