DGPFLMA2 ;ALB/KCL - PRF ASSIGNMENT LM PROTOCOL ACTIONS CONT. ; 6/12/06 12:46pm
 ;;5.3;Registration;**425,623,554,650**;Aug 13, 1993;Build 3
 ;
 ;no direct entry
 QUIT
 ;
AF ;Entry point for DGPF ASSIGN FLAG action protocol.
 ;
 ;  Input:
 ;     DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ; Output:
 ;   VALMBCK - 'R' = refresh screen
 ;
 N DIC,DGWPROOT,DIWETXT,DIWESUB,DWLW,DWPK  ;input vars for EN^DIWE call
 N DGABORT   ;abort flag for entering assignment narrative
 N DGFAC     ;pointer to INSTITUTION (#4) file
 N DGOK      ;ok flag for entering assignment narrative
 N DGPFA     ;assignment array
 N DGPFAH    ;assignment history array
 N DGRDAT    ;results of review date calculation
 N DGRESULT  ;result of STOALL api call
 N DGERR     ;if unable to add assignment
 N DGPFERR   ;if error returned from STOALL
 ;
 ;set screen to full scroll region
 D FULL^VALM1
 ;
 ;quit if patient not selected
 I '$G(DGDFN) D  Q
 . D BLD^DIALOG(261129,"Patient has not been selected.","","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W *7
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 ;is user's DUZ(2) an enabled Division for PRF ASSIGNMENT OWNERSHIP
 I '$D(^DG(40.8,"APRF",+$G(DUZ(2)))) D  Q
 . D BLD^DIALOG(261129,"Your Division, "_$$STA^XUAF4($G(DUZ(2)))_", is not enabled for PRF Assignment Ownership.","","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W *7
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 D  ;drops out of DO block on assignment failure
 . ;
 . ;init assignment and history arrays
 . K DGPFA,DGPFAH
 . ;
 . ;get patient DFN into assignment array
 . S DGPFA("DFN")=$G(DGDFN)
 . Q:'DGPFA("DFN")
 . ;
 . ;select flag for assignment
 . S DGPFA("FLAG")=$$ANSWER^DGPFUT("Select a flag for this assignment","","26.13,.02")
 . Q:(DGPFA("FLAG")'>0)
 . ;
 . ;National ICN when Cat I assignment?
 . I $P(DGPFA("FLAG"),U)["26.15",'$$MPIOK^DGPFUT(DGPFA("DFN")) D  Q
 . . W !!,"Unable to proceed with flag assignment..."
 . . D BLD^DIALOG(261132,"","","DGERR","F")
 . . D MSG^DIALOG("WE","","","","DGERR") W *7
 . . D PAUSE^VALM1
 . ;
 . ;run query for Cat I assignments
 . I $P(DGPFA("FLAG"),U)["26.15",$$GETSTAT^DGPFHLL1(DGDFN)'="C" D
 . . N DGDIFF    ;difference between pre and post query count
 . . N DGFLGCNT  ;total count of Cat I flags
 . . N DGPRECNT  ;pre-query count of Cat I assignments
 . . N DGPSTCNT  ;post-query count of Cat I assignments
 . . ;
 . . ;get count of current assignments
 . . S (DGPRECNT,DGPSTCNT)=$$GETALL^DGPFAA(DGDFN,,,1)
 . . ;
 . . ;get total count of possible Category I flags
 . . S DGFLGCNT=$$CNTRECS^DGPFUT1(26.15)
 . . ;
 . . ;stop if all flags are assigned
 . . Q:DGPRECNT=DGFLGCNT
 . . ;
 . . ;execute the query...stop on failure
 . . Q:'$$SNDQRY^DGPFHLS(DGDFN,1,.DGFAC)
 . . ;
 . . ;recheck current assignment count
 . . S DGPSTCNT=$$GETALL^DGPFAA(DGDFN,,,1)
 . . S DGDIFF=DGPSTCNT-DGPRECNT
 . . W !!,"    ",$S(DGDIFF=1:"A ",DGDIFF>1:"",1:"No ")_"Category I patient record flag assignment"_$S(DGDIFF>1!('DGDIFF):"s were",1:" was")_" returned"
 . . W !,"    from "_$P($$NS^XUAF4($G(DGFAC)),U)_$S(DGDIFF:" and filed on your system.",1:".")
 . . W !
 . . ;
 . . ;re-build list when flag assignments have been added
 . . I DGDIFF D BLDLIST^DGPFLMU(DGDFN)
 . ;
 . ;ok to add new assignment?
 . I '$$ADDOK^DGPFAA2(DGPFA("DFN"),$P(DGPFA("FLAG"),U),"DGERR") D  Q
 . . W !!,"Unable to proceed with flag assignment..."
 . . D MSG^DIALOG("WE","","",5,"DGERR")
 . . D PAUSE^VALM1
 . ;
 . ;prompt for owner site
 . S DGPFA("OWNER")=$$ANSWER^DGPFUT("Enter Owner Site",$$EXTERNAL^DILFD(26.13,.04,"",DUZ(2),"DGERR"),"P^4:EMZ","","I $D(^DG(40.8,""APRF"",+Y)),$$TF^XUAF4(+Y)")
 . Q:(DGPFA("OWNER")'>0)
 . ;
 . ;prompt user for approved by person, quit if not selected
 . S DGPFAH("APPRVBY")=$$ANSWER^DGPFUT("Approved By","","P^200:EMZ")
 . Q:(DGPFAH("APPRVBY")'>0)
 . ;
 . ;have user enter assignment narrative text (required)
 . S (DGABORT,DGOK)=0
 . S DGWPROOT=$NA(^TMP($J,"DGPFNARR"))
 . K @DGWPROOT
 . F  D  Q:(DGOK!DGABORT)
 . . W !!,"Enter Narrative Text for this record flag assignment:" ;needed for line editor
 . . S DIC=$$OREF^DILF(DGWPROOT)
 . . S DIWETXT="Patient Record Flag - Assignment Narrative Text"
 . . S DIWESUB="Assignment Narrative Text"
 . . S DWLW=75 ;max # of chars allowed to be stored on WP global node
 . . S DWPK=1  ;if line editor, don't join lines
 . . D EN^DIWE
 . . I $$CKWP^DGPFUT(DGWPROOT) S DGOK=1 Q
 . . W !,"Assignment Narrative Text is required!",*7
 . . I '$$CONTINUE^DGPFUT() S DGABORT=1
 . . ;
 . ;quit if required assignment narrative not entered
 . Q:$G(DGABORT)
 . ;
 . ;place assignment narrative text into assignment array
 . M DGPFA("NARR")=@DGWPROOT K @DGWPROOT
 . ;
 . ;setup remaining assignment and history array nodes for filing
 . S DGPFA("STATUS")=1  ;active
 . S DGPFA("ORIGSITE")=DUZ(2)  ;current user's login site
 . S DGPFAH("ASSIGNDT")=$$NOW^XLFDT()  ;current date/time
 . S DGPFAH("ACTION")=1  ;new assignment
 . S DGPFAH("ENTERBY")=DUZ  ;current user
 . S DGPFAH("COMMENT",1,0)="New record flag assignment."
 . ;
 . ;calculate the default review date
 . S DGRDAT=$$GETRDT^DGPFAA3($P(DGPFA("FLAG"),U),DGPFAH("ASSIGNDT"))
 . ;
 . ;prompt for review date on valid default review date, otherwise null
 . I DGRDAT>0 D
 . . S DGPFA("REVIEWDT")=$$ANSWER^DGPFUT("Enter Review Date",$$FMTE^XLFDT(DGRDAT,"5D"),"D^"_DT_":"_DGRDAT_":EX")
 . E  S DGPFA("REVIEWDT")=""
 . Q:DGPFA("REVIEWDT")<0
 . ;
 . ;display flag assignment review screen to user
 . D REVIEW^DGPFUT3(.DGPFA,.DGPFAH,"",XQY0,XQORNOD(0))
 . ;
 . Q:$$ANSWER^DGPFUT("Would you like to file this new record flag assignment","YES","Y")'>0
 . ;
 . ;file the assignment and history using STOALL api
 . W !,"Filing the patient's new record flag assignment..."
 . S DGRESULT=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,.DGPFERR)
 . W !?5,"Assignment was "_$S(+$G(DGRESULT):"filed successfully.",1:"not filed successfully.")
 . ;
 . ;send HL7 message if adding an assignment to a CAT I flag
 . I $G(DGRESULT),DGPFA("FLAG")["26.15",$$SNDORU^DGPFHLS(+DGRESULT) D
 . . W !?5,"Message sent...updating patient's sites of record."
 . ;
 . D PAUSE^VALM1
 . ;
 . ;re-build list of flag assignments for patient
 . D BLDLIST^DGPFLMU(DGDFN)
 ;
 S VALMBCK="R"
 ;
 Q
