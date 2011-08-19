TIUPS169 ; SLC/MAM - After installing TIU*1*169 ; 7/27/2004
 ;;1.0;Text Integration Utilities;**169**;Jun 20, 1997
 ; Option TIU169 DDEFS, C&P WORKSHEETS. Run after installing patch 169.
 ; External References
 ;   DBIA 3409  ^USR(8930,"B"
BEGIN ; Create DDEFS
 N TIUY,DESDC,TIUDUPS,TIUQUIT
 W !!,"This option creates Document Definitions (DDEFS) for C&P Worksheets."
 W !,"It may take one or two minutes to run.  It will tell you whether or not",!,"it is successful."
 ; -- Set ^XTMP deletion date for about 2 years hence:
 ;    Set it even if all are already created, in case it's in test
 ;      for more than 2 years, so sites can reset it by running option.
 S ^XTMP("TIU169",0)=$$FMADD^XLFDT(DT,730)_U_DT_U_"Tracks DDEFS created by Option TIU169 DDEFS, C&P WORKSHEETS"
 ; -- Check if ALL done; check for Class Clinical Coord:
 I $G(^XTMP("TIU169","DONE"))="ALL" D  Q
 . W !,"All C&P Document Definitions have already been created."
 I $O(^USR(8930,"B","CLINICAL COORDINATOR",""))="" D  Q
 . W !,"I can't find User Class CLINICAL COORDINATOR. Option cannot be run without it."
 ; -- Set basic DDEF data into BASICS node of data array ^TMP("TIU169":
 D SETBASIC^TIUEN169
 ; -- If DC was created or designated on previous run, set DESDC &
 ;    check for new dups:
 I $G(^XTMP("TIU169",1,"DONE")) D  Q:$G(TIUQUIT)
 . S DESDC=^XTMP("TIU169",1,"DONE")
 . W !!,"Proceeding with Document Class C&P EXAMINATION REPORTS..."
 . D TIUDUPS^TIUEN169(.TIUDUPS,+DESDC)
 . I $G(TIUDUPS("NOTINDC")) D LISTDUPS^TIUEN169(.TIUDUPS,0) S TIUQUIT=1 Q
 ; -- If DC NOT created or designated on previous run, designate:
 I '$G(^XTMP("TIU169",1,"DONE")) D  Q:$G(TIUQUIT)
 . S DESDC=$$DESGNATE^TIUEN169
 . I +DESDC=-1 W !,"Try later." S TIUQUIT=1 Q
 . D TIUDUPS^TIUEN169(.TIUDUPS,+DESDC)
 . I +$G(TIUDUPS("NOTINDC")) D LISTDUPS^TIUEN169(.TIUDUPS,0) S TIUQUIT=1 Q
 . ; -- User has not designated a DC:
 . I +DESDC=0 D  Q:$G(TIUQUIT)
 . . S TIUY=$$READ^TIUU("YO","I will create a new Document Class with new Titles under it. OK","YES")
 . . I +TIUY'=1 W !,"OK, try again when you're ready." S TIUQUIT=1
 . ; -- No matching titles in Des DC:
 . I +DESDC>0,'$G(TIUDUPS("INDC")) D  Q:$G(TIUQUIT)
 . . S TIUY=$$READ^TIUU("YO","I will create the new Titles under Document Class "_$P(DESDC,U,2)_". OK","YES")
 . . I +TIUY'=1 W !,"OK, try again when you're ready." S TIUQUIT=1
 . ; -- Matching titles in Des DC:
 . I +DESDC>0,+$G(TIUDUPS("INDC")) D  Q:$G(TIUQUIT)
 . . D LISTDUPS^TIUEN169(.TIUDUPS,1)
 . . S TIUY=$$READ^TIUU("YO","I will create the non-matching Titles under Document Class "_$P(DESDC,U,2)_", and skip the matching Titles. OK","YES")
 . . I +TIUY'=1 W !,"OK, try again when you're ready." S TIUQUIT=1
 . ; -- If user has designated DC and agreed, change Name & set DONE node:
 . I +DESDC>0 D
 . . N DCNAME,DA,DIE,DR,X,Y S DCNAME="C&P EXAMINATION REPORTS",DA=+DESDC,DIE=8925.1,DR=".01///^S X=DCNAME" D ^DIE
 . . S ^XTMP("TIU169",1,"DONE")=+DESDC
 ; -- If DDEFs are being skipped, set their DONE nodes:
 N NUM,ALLFLG S ALLFLG=1
 F NUM=2:1:58 D
  . I '$G(TIUDUPS("INDC",NUM)),'$D(^XTMP("TIU169",NUM,"DONE")) S ALLFLG=0 Q
  . I $G(TIUDUPS("INDC",NUM)) S ^XTMP("TIU169",NUM,"DONE")=TIUDUPS("INDC",NUM)
 I ALLFLG S ^XTMP("TIU169","DONE")="ALL" D  Q
 . W !,"All Document Definitions have already been created."
 W ! K IOP N %ZIS S %ZIS="Q" D ^%ZIS
 I POP W !,"Nothing created." K POP Q
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTRTN="MAIN^TIUPS169"
 .S ZTDESC="Create DDEFS for C&P Worksheets - TIU*1*169"
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .D HOME^%ZIS
 U IO D MAIN,^%ZISC
 Q
 ;
MAIN ; Create DDEFS for C&P
 N TMPCNT,TIUSTTS
 K ^TMP("TIU169MSG",$J),^TMP("TIU169ERR",$J)
 ; -- Begin message array ^TMP("TIU169MSG",$J:
 S TMPCNT=0
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)="         ***** Document Definitions (DDEFS) for C&P Worksheets *****"
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)="Creating the Document Definitions..."
 ; -- Set flds for FILE call & item data into nodes FILEDATA & DATA
 ;    of array ^TMP("TIU169":
 D SETDATA^TIU169D
 ; -- Loop through DDEFS to create them:
 N NUM
 F NUM=1:1:58 D
 . N TIUIEN,YDDEF,TIUDA,PIEN,ITEMDA
 . ; -- If DDEF was previously created by this option, or is being
 . ;    skipped, quit and get next DDEF:
 . S TIUIEN=+$G(^XTMP("TIU169",NUM,"DONE")) Q:TIUIEN
 . ; -- If not, create new DDEF:
 . S YDDEF=$$CREATE(NUM)
 . ; -- If DDEF couldn't be created or was found by lookup
 . ;    instead of being created, quit and get next DDEF: 
 . I $G(^TMP("TIU169ERR",$J,NUM))="CREATE" Q
 . S TIUDA=+YDDEF
 . ; -- Call FILE to stuff fields from ^TMP("TIU169",$J,"FILEDATA",NUM:
 . D FILE(NUM,TIUDA)
 . I $G(^TMP("TIU169ERR",$J,NUM))="FILE" D DELETE^TIU169D(TIUDA) Q
 . ; -- Add item to parent, stuff item data:
 . S PIEN=$$PARENT(NUM)
 . I $G(^TMP("TIU169ERR",$J,NUM))="FINDPARENT" D DELETE^TIU169D(TIUDA) Q
 . S ITEMDA=+$$ADDITEM^TIU169D(NUM,TIUDA,PIEN)
 . I $G(^TMP("TIU169ERR",$J,NUM))="ADDITEM" D DELETE^TIU169D(TIUDA) Q
 . D FILEITEM^TIU169D(NUM,PIEN,ITEMDA)
 . I $G(^TMP("TIU169ERR",$J,NUM))="FILEITEM" D DELETE^TIU169D(TIUDA,PIEN,ITEMDA) Q
 . ; -- DDEF NUM has been created and edited successfully:
 . S ^XTMP("TIU169",NUM,"DONE")=TIUDA
 . Q
 ; -- Add results from CREATE loop to message array:
 N NUM S NUM=0
 I $O(^TMP("TIU169ERR",$J,NUM))="" D  G MAINX
 . S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)="All Document Definitions have now been created successfully."
 . S ^XTMP("TIU169","DONE")="ALL"
 . ; -- Kill indiv DONE nodes:
 . N NUMBER F NUMBER=1:1:58 K ^XTMP("TIU169",NUMBER)
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)="Problems were encountered creating the following Document Definitions:"
 F  S NUM=$O(^TMP("TIU169ERR",$J,NUM)) Q:NUM=""  D
 . N PROB S PROB=^TMP("TIU169ERR",$J,NUM)
 . D
 . . I PROB="CREATE" S PROB="Couldn't create DDEF." Q
 . . I PROB="FILE" S PROB="Couldn't file fields. DDEF deleted." Q
 . . I PROB="FINDPARENT" S PROB="Couldn't find parent. DDEF deleted." Q
 . . I PROB="ADDITEM" S PROB="Couldn't add DDEF to parent. DDEF deleted."
 . . I PROB="FILEITEM" S PROB="Couldn't file Menu Text. DDEF deleted."
 . S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)=$S(NUM=1:"Document Class ",1:"Title ")_^TMP("TIU169",$J,"BASICS",NUM,"NAME")_": "
 . S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)="  "_PROB
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)="Please contact Enterprise VistA Support. When problems have been resolved,"
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)="come back and rerun the option."
MAINX ; Exit
 ; -- Leave latest error arrays ^TMP("DIERR",$J) & TIUIERR around until
 ;    now in case modules are run separately for debugging:
 K TIUIERR,^TMP("DIERR",$J)
 ; -- Finish message array ^TMP("TIU169MSG",$J and print it:
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("TIU169MSG",$J,TMPCNT)="                           *************"
 D PRINT^TIU169D
 K ^TMP("TIU169MSG",$J),^TMP("TIU169ERR",$J),^TMP("TIU169",$J)
 Q
 ;
PARENT(NUM) ; Return IEN of parent new DDEF should be added to
 N PIEN,PNUM
 ; Parent node has form:
 ;   ^TMP("TIU169",$J,"DATA",NUM,PIEN) = IEN of parent if known, or
 ;   ^TMP("TIU169",$J,"DATA",NUM,PNUM) = DDEF# of parent if not
 S PIEN=$G(^TMP("TIU169",$J,"DATA",NUM,"PIEN"))
 ; -- If parent IEN is known, we're done:
 I +PIEN G PARENTX
 ; -- If not, get DDEF# of parent
 S PNUM=+$G(^TMP("TIU169",$J,"DATA",NUM,"PNUM"))
 ; -- Get Parent IEN from "DONE" node, which was set
 ;    when parent was created:
 S PIEN=+$G(^XTMP("TIU169",PNUM,"DONE"))
PARENTX I 'PIEN!'$D(^TIU(8925.1,PIEN,0)) D
 . S ^TMP("TIU169ERR",$J,NUM)="FINDPARENT"
 Q PIEN
 ;
FILE(NUM,TIUDA) ; File fields for new DDEF TIUDA
 ; Files ALL FIELDS set in "FILEDATA" nodes of ^TMP:
 ;   ^TMP("TIU169",$J,"FILEDATA",NUM,Field#)
 N TIUFPRIV,FDA
 K ^TMP("DIERR",$J)
 S TIUFPRIV=1
 M FDA(8925.1,TIUDA_",")=^TMP("TIU169",$J,"FILEDATA",NUM)
 D FILE^DIE("TE","FDA")
 I $D(^TMP("DIERR",$J)) S ^TMP("TIU169ERR",$J,NUM)="FILE"
 Q
 ;
CREATE(NUM) ; Create new DDEF entry
 N DIC,DLAYGO,DA,X,Y
 S DIC="^TIU(8925.1,",DLAYGO=8925.1
 S DIC(0)="LX",X=^TMP("TIU169",$J,"BASICS",NUM,"NAME")
 S DIC("S")="I $P(^(0),U,4)="_""""_^TMP("TIU169",$J,"BASICS",NUM,"INTTYPE")_""""
 D ^DIC
 I $P($G(Y),U,3)'=1 S ^TMP("TIU169ERR",$J,NUM)="CREATE"
 Q $G(Y)
