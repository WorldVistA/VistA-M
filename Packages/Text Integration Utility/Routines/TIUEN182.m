TIUEN182 ; SLC/MAM - Environment Check Rtn for TIU*1*182 ; 6/9/04
 ;;1.0;Text Integration Utilities;**182**;Jun 20, 1997
 ; External References
 ;   DBIA 3409  ^USR(8930,"B"
MAIN ; Check environment.  If problems found, warn but do not abort install.
 ; -- Check if done:
 I $G(^XTMP("TIU182","DONE"))="ALL" W !,"All Document Definitions exported for the Medicine Conversion have already",!," been created. You won't need to rerun the option." Q
 I '$$CLASS^TIUCP W !,"I can't find Class CLINICAL PROCEDURES, exported in patch TIU*1*109. You",!,"won't be able to run the option that creates the Document Definitions",!,"without this class. See patch description.",!
 I $O(^USR(8930,"B","CLINICAL COORDINATOR",""))="" W !,"I can't find User Class CLINICAL COORDINATOR. You won't be able to run",!,"the option that creates the Document Definitions without this class. See",!,"patch description.",!
 ; -- Check for potential DDEF duplicates at site:
 D SETBASIC ; Set basic data for DDEFS into ^TMP for dups check
 W !,"Checking for potential duplicate Document Definitions..."
 N TIUDUPS
 D TIUDUPS(.TIUDUPS)
 I 'TIUDUPS W !,"     No potential duplicates found.",!,"Remember to run option TIU182 DDEFS, MED CONVERSION after installing the patch." G MAINX
 ; -- If potential duplicates exist, list them:
 K ^TMP("TIU182MSG",$J) ; LISTDUPS needs new ^TMP("TIU182MSG",$J)
 D LISTDUPS(.TIUDUPS,0,0)
MAINX K ^TMP("TIU182MSG",$J) ; Clean up after LISTDUPS
 K ^TMP("TIU182",$J) ; Clean up after SETBASIC
 Q
 ;
SETBASIC ; Set up basic data in ^TMP("TIU182",$J,"BASICS")
 N NUMBER
 ; -- Set ^TMP("TIU182",$J,"BASICS",[NUMBER],["INTTYPE" or "NAME"])
 ; -- Set basic data NAME and interior TYPE for new DDEFS into TMP.
 ;    Reference DDEFS by NUMBER.
 ;    Number parent-to-be BEFORE child.
 ;    Name MUST be upper case or ADDITEM fails
 S ^TMP("TIU182",$J,"BASICS",1,"INTTYPE")="DC"
 F NUMBER=2:1:13 S ^TMP("TIU182",$J,"BASICS",NUMBER,"INTTYPE")="DOC"
 F NUMBER=1:1:13 S ^TMP("TIU182",$J,"BASICS",NUMBER,"NAME")=$P($T(NAME+NUMBER),";;",2,99)
 Q
 ;
TIUDUPS(TIUDUPS,OPTFLG) ; Set array TIUDUPS of potential duplicate DDEFS
 N NUM S TIUDUPS=0,OPTFLG=+$G(OPTFLG)
 I $G(^XTMP("TIU182","DONE"))="ALL" Q
 F NUM=1:1:13 Q:'NUM  D
 . ; -- When looking for duplicates, ignore DDEF if
 . ;    previously created by this patch:
 . Q:$G(^XTMP("TIU182",NUM,"DONE"))
 . ; -- If site already has DDEF w/ same Name & Type as one
 . ;    we are exporting, set its number into array TIUDUPS:
 . N NAME,TYPE,TIUDA S TIUDA=0
 . S NAME=^TMP("TIU182",$J,"BASICS",NUM,"NAME")
 . S TYPE=^TMP("TIU182",$J,"BASICS",NUM,"INTTYPE")
 . F  S TIUDA=$O(^TIU(8925.1,"B",NAME,TIUDA)) Q:+TIUDA'>0  D
 . . I $P($G(^TIU(8925.1,+TIUDA,0)),U,4)=TYPE S TIUDUPS(NUM)=+TIUDA,TIUDUPS=1
 Q
 ;
LISTDUPS(TIUDUPS,TMPCNT,OPTFLG) ; List duplicates by name
 ; TIUDUPS = array as set in TIUDUPS. Required.
 ; TMPCNT = Count at which to start message array ^TMP("TIU182MSG",$J,TMPCNT); Received by reference. (Array already has some nodes if called from option.) Optional.
 ; OPTFLG = 1 if called from option;
 ;	 0 if called from env check. Optional.
 N NUM
 S OPTFLG=+$G(OPTFLG)
 S TMPCNT=$S($G(TMPCNT):TMPCNT,1:0)
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="You already have the following Document Definitions exported by this patch."
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="I don't want to overwrite them. Please change their names so they no longer"
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="match the exported ones, or if you are not using them, delete them. If you"
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="change the name of a Document Definition you plan to continue using, remember"
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="to update its Print Name, as well. For help, contact Enterprise VistA Support."
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1
 I 'OPTFLG D
 . S ^TMP("TIU182MSG",$J,TMPCNT)="You will not be able to run option TIU182 DDEFS, MED CONVERSION to create the"
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="DDEFS until these matches are eliminated."
 E  S ^TMP("TIU182MSG",$J,TMPCNT)="You may not run this option until these matches are eliminated."
 S NUM=0
 F  S NUM=$O(TIUDUPS(NUM)) Q:'NUM  D
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="     "_^TMP("TIU182",$J,"BASICS",NUM,"NAME")
 ; -- If called from env check, not option, write list:
 I OPTFLG Q
 N TIUI S TIUI=0
 F  S TIUI=$O(^TMP("TIU182MSG",$J,TIUI)) Q:'TIUI  D
 . W !,^TMP("TIU182MSG",$J,TIUI)
 Q
 ;
NAME ; Names of DDEFS in order from 1 to 13
 ;;HISTORICAL PROCEDURES
 ;;HISTORICAL CARDIAC CATHETERIZATION PROCEDURE
 ;;HISTORICAL ELECTROCARDIOGRAM PROCEDURE
 ;;HISTORICAL ECHOCARDIOGRAM PROCEDURE
 ;;HISTORICAL ELECTROPHYSIOLOGY PROCEDURE
 ;;HISTORICAL HOLTER PROCEDURE
 ;;HISTORICAL EXERCISE TOLERANCE TEST PROCEDURE
 ;;HISTORICAL PRE/POST SURGERY RISK NOTE
 ;;HISTORICAL ENDOSCOPIC PROCEDURE
 ;;HISTORICAL PULMONARY FUNCTION TEST PROCEDURE
 ;;HISTORICAL HEMATOLOGY PROCEDURE
 ;;HISTORICAL PACEMAKER IMPLANTATION PROCEDURE
 ;;HISTORICAL RHEUMATOLOGY PROCEDURE
 Q
