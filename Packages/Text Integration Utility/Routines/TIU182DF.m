TIU182DF ; SLC/MAM - Create new HP DDEFS ; 7/22/04
 ;;1.0;Text Integration Utilities;**182**;Jun 20, 1997
 ; Run this after installing patch 182.
 ;Use option: TIU182 DDEFS, MED CONVERSION
 ; External References
 ;   DBIA 3409  ^USR(8930,"B"
BEGIN ; Create DDEFS
 W !!,"This option creates Historical Procedure Document Definitions (DDEFS) for",!,"the Medicine Package conversion."
 W !,"It may take one or two minutes to run.  It will tell you whether or not",!,"it is successful."
 W ! K IOP N %ZIS S %ZIS="Q" D ^%ZIS I POP K POP Q
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTRTN="MAIN^TIUPS182"
 .S ZTDESC="Create DDEFS for Medicine Conversion - TIU*1*182"
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .D HOME^%ZIS
 U IO D MAIN,^%ZISC
 Q
 ;
MAIN ; Create Historical Procedure DDEFS for Medicine Conversion
 N TIUDUPS,TMPCNT,TIUSTTS
 ; -- Set ^XTMP deletion date for about 2 years hence:
 ;    Set it even if all are already created, in case it's in test
 ;      for more than 2 years, so sites can reset it by running option.
 S ^XTMP("TIU182",0)=$$FMADD^XLFDT(DT,730)_U_DT_U_"Tracks DDEFS created by Option TIU182 DDEFS, MED CONVERSION"
 K ^TMP("TIU182MSG",$J),^TMP("TIU182ERR",$J),^TMP("TIU182",$J)
 ; -- Begin message array ^TMP("TIU182MSG",$J:
 S TMPCNT=0
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="*** Historical Procedure Document Definitions for the Medicine Conversion ***"
 ; -- Check if ALL done; check for Class Clinical Coord:
 I $G(^XTMP("TIU182","DONE"))="ALL" D  G MAINX
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="All DDEFS exported for the conversion have already been created"
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="by option TIU182 DDEFS, MED CONVERSION."
 N CPCLASS S CPCLASS=$$CLASS^TIUCP I 'CPCLASS D
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="I can't find Class CLINICAL PROCEDURES, exported in patch TIU*1*109."
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="Option cannot be run without it."
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)=""
 I $O(^USR(8930,"B","CLINICAL COORDINATOR",""))="" D
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="I can't find User Class CLINICAL COORDINATOR. Option cannot be run without it."
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)=""
 ; -- Set basic DDEF data into BASICS node of data array ^TMP("TIU182":
 D SETBASIC^TIUEN182
 ; -- Check for potential DDEF duplicates at site:
 D TIUDUPS^TIUEN182(.TIUDUPS,1)
 ; -- If potential duplicates exist, add them to message array:
 I TIUDUPS D LISTDUPS^TIUEN182(.TIUDUPS,.TMPCNT,1) G MAINX
 I $O(^USR(8930,"B","CLINICAL COORDINATOR",""))="" G MAINX
 I 'CPCLASS G MAINX
 ; -- If no potential dups, User Class exists, CLINICAL PROCEDURES
 ;    Class exists, go on:
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="Environment looks OK."
 ; -- Check if some DDEFS done:
 I $G(^XTMP("TIU182","DONE"))="SOME" D
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="Some of the DDEFS exported for the conversion have already been"
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="created by this option. I will now create the others..."
 ; -- If none created yet:
 I '$D(^XTMP("TIU182","DONE")) D
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="Creating the Document Definitions..."
 ; -- Set flds for FILE call & item data into nodes FILEDATA & DATA
 ;    of array ^TMP("TIU182":
 D SETDATA^TIU182D
 ; -- Loop through DDEFS to create them:
 N NUM
 F NUM=1:1:13 D
 . N TIUIEN,YDDEF,TIUDA,PIEN,ITEMDA
 . ; -- If DDEF was previously created by this option,
 . ;    quit and get next DDEF:
 . S TIUIEN=+$G(^XTMP("TIU182",NUM,"DONE")) Q:TIUIEN
 . ; -- If not, create new DDEF:
 . S YDDEF=$$CREATE^TIU182D1(NUM)
 . ; -- If DDEF couldn't be created or was found by lookup
 . ;    instead of being created, quit and get next DDEF: 
 . I $G(^TMP("TIU182ERR",$J,NUM))="CREATE" Q
 . S TIUDA=+YDDEF
 . ; -- Call FILE to stuff fields from ^TMP("TIU182",$J,"FILEDATA",NUM:
 . D FILE^TIU182D1(NUM,TIUDA)
 . I $G(^TMP("TIU182ERR",$J,NUM))="FILE" D DELETE^TIU182D1(TIUDA) Q
 . ; -- Add item to parent, stuff item data:
 . S PIEN=$$PARENT^TIU182D1(NUM)
 . I $G(^TMP("TIU182ERR",$J,NUM))="FINDPARENT" D DELETE^TIU182D1(TIUDA) Q
 . S ITEMDA=+$$ADDITEM^TIU182D1(NUM,TIUDA,PIEN)
 . I $G(^TMP("TIU182ERR",$J,NUM))="ADDITEM" D DELETE^TIU182D1(TIUDA) Q
 . D FILEITEM^TIU182D1(NUM,PIEN,ITEMDA)
 . I $G(^TMP("TIU182ERR",$J,NUM))="FILEITEM" D DELETE^TIU182D1(TIUDA,PIEN,ITEMDA) Q
 . ; -- DDEF NUM has been created and edited successfully:
 . S ^XTMP("TIU182",NUM,"DONE")=TIUDA
 . S ^XTMP("TIU182","DONE")="SOME"
 . Q
 ; -- Add results from CREATE loop to message array:
 N NUM S NUM=0
 I $O(^TMP("TIU182ERR",$J,NUM))="" D  G MAINX
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="All Document Definitions have now been created successfully."
 . S ^XTMP("TIU182","DONE")="ALL"
 . ; -- Kill indiv DONE nodes:
 . N NUMBER F NUMBER=1:1:13 K ^XTMP("TIU182",NUMBER)
 . ; -- Edit Print Form Header,delete PF Number of Class CP:
 . N FDA,TIUFPRIV S FDA(8925.1,CPCLASS_",",6.1)="CLINICAL PROCEDURES"
 . S FDA(8925.1,CPCLASS_",",6.12)="@"
 . S TIUFPRIV=1
 . D FILE^DIE("TE","FDA")
 . Q:'$D(^TMP("DIERR",$J))
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="Couldn't update CP Print Fields. See patch description or contact EVS."
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="Problems were encountered creating the following Document Definitions:"
 F  S NUM=$O(^TMP("TIU182ERR",$J,NUM)) Q:NUM=""  D
 . N PROB S PROB=^TMP("TIU182ERR",$J,NUM)
 . D
 . . I PROB="CREATE" S PROB="Couldn't create DDEF." Q
 . . I PROB="FILE" S PROB="Couldn't file fields. DDEF deleted." Q
 . . I PROB="FINDPARENT" S PROB="Couldn't find parent. DDEF deleted." Q
 . . I PROB="ADDITEM" S PROB="Couldn't add DDEF to parent. DDEF deleted."
 . . I PROB="FILEITEM" S PROB="Couldn't file Menu Text. DDEF deleted."
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)=$S(NUM=1:"Document Class ",1:"Title ")_^TMP("TIU182",$J,"BASICS",NUM,"NAME")_": "
 . S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="  "_PROB
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="Please contact Enterprise VistA Support. When problems have been resolved,"
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="come back and rerun the option."
MAINX ; Exit
 ; -- Leave latest error arrays ^TMP("DIERR",$J) & TIUIERR around until
 ;    now in case modules are run separately for debugging:
 K TIUIERR,^TMP("DIERR",$J)
 ; -- Finish message array ^TMP("TIU182MSG",$J and print it:
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("TIU182MSG",$J,TMPCNT)="                           *************"
 D PRINT^TIU182D
 K ^TMP("TIU182MSG",$J),^TMP("TIU182ERR",$J),^TMP("TIU182",$J)
 Q
