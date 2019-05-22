DGPFLMA3 ;ALB/KCL - PRF ASSIGNMENT LM PROTOCOL ACTIONS CONT. ; 6/2/05 3:24pm
 ;;5.3;Registration;**425,623,554,650,864,951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/SGM - Sep 25, 2018 17:31
 ;NOTES:
 ; 1/23/2018 - with addition of DBRS, when to not complete action
 ;             changes from previous version.  One can edit DBRS#
 ;             only with no other changes.
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  -------------------------------
 ; 2050  Sup   ^DIALOG: BLD, MSG
 ; 2051  Sup   UPDATE^DIE
 ; 2054  Sup   $$OREF^DILF
 ; 2056  Sup   $$GET1^DIQ
 ;10028  Sup   EN^DIWE
 ;10060  Sup   File 200 FM read of all fields
 ;10103  Sup   ^XLFDT: $$FMTE, $$NOW
 ;10113  Sup   ^DIK
 ;10116  Sup   ^VALM1: FULL, PAUSE
 ;10119  Sup   EN^VALM2
 ;
 QUIT
 ;
EF ;Entry point for DGPF EDIT ASSIGNMENT action protocol.
 ;
 ;  Input: None
 ;
 ; Output:
 ;   VALMBCK - 'R' = refresh screen
 ;
 ;input vars for EN^DIWE call
 N X,Y,DIC,DGWPROOT,DIWETXT,DIWESUB,DWLW,DWPK
 N DGAROOT   ;assignment narrative word processing root
 N DGCROOT   ;assignment history comment word processing root
 N DGABORT   ;abort flag for entering assignment narrative
 N DGASK     ;return value from $$ANSWER^DGPFUT call
 N DGOK      ;ok flag for entering assignment narrative
 N DGCODE    ;action code
 N DGDFN     ;pointer to patient in PATIENT (#2) file
 N DGIEN     ;assignment ien
 N DGPFA     ;assignment array
 N DGPFAH    ;assignment history array
 N DGPFERR   ;if error returned from STOALL api call
 N DGQ       ;quit var for narrative edit
 N DGRDAT    ;review date
 N DGRESULT  ;result of STOALL api call
 N DGERR     ;error if unable to edit assignment
 N DGETEXT   ;error text
 N DGSUB     ;for loop var
 N SEL       ;user selection (list item)
 N VALMY     ;output of EN^VALM2 call, array of user selected entries
 ;
 ;set screen to full scroll region
 D FULL^VALM1
 ;
 ;quit if selected action is not appropriate
 I '$D(@VALMAR@("IDX")) D  Q
 . I '$G(DGDFN) S DGETEXT(1)="Patient has not been selected."
 . E  S DGETEXT(1)="Patient has no record flag assignments."
 . D BLD^DIALOG(261129,.DGETEXT,"","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W $C(7)
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 ;allow user to select a SINGLE flag assignment for editing
 S (DGIEN,VALMBCK)=""
 D EN^VALM2($G(XQORNOD(0)),"S")
 ;
 ;process user selection
 S SEL=$O(VALMY(""))
 I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 . N X
 . S DGIEN=$P($G(@VALMAR@("IDX",SEL,SEL)),U)
 . S DGDFN=$P($G(@VALMAR@("IDX",SEL,SEL)),U,2)
 . ;
 . ;attempt to obtain lock on assignment record
 . I '$$LOCK^DGPFAA3(DGIEN) D  Q
 . . W !!,"Record flag assignment currently in use, cannot be edited!"
 . . D PAUSE^VALM1
 . ;
 . ;init word processing arrays 
 . S DGAROOT=$NA(^TMP($J,"DGPFNARR"))
 . S DGCROOT=$NA(^TMP($J,"DGPFCMNT"))
 . K @DGAROOT,@DGCROOT
 . ;
 . ;get assignment into DGPFA array
 . I '$$GETASGN^DGPFAA(DGIEN,.DGPFA,1) D  Q
 . . W !!,"Unable to retrieve the record flag assignment selected."
 . . D PAUSE^VALM1
 . ;
 . ;urgent address as female flag can't be edited dg*5.3*864
 . I $P(DGPFA("FLAG"),",",2)="^URGENT    ADDRESS AS FEMALE" D  Q
 . . W !!
 . . W !!,"The URGENT    ADDRESS AS FEMALE Flag assignment cannot be edited."
 . . W !!
 . . D PAUSE^VALM1
 . ;
 . ;is assignment edit allowed?
 . I '$$EDTOK^DGPFAA2(.DGPFA,DUZ(2),"DGERR") D  Q
 . . W !!,"Assignment can not be edited..."
 . . D MSG^DIALOG("WE","","",5,"DGERR")
 . . D PAUSE^VALM1
 . ;
 . ;-if assignment is active, set available action codes to Continue
 . ; and Inactivate; else set code to Reactivate
 . ;-if Local Flag or PRF Phase 2 active, add Entered in Error code
 . ;-dg*951 - add DBRS edit option.  This action is worded to allow
 . ;    for future fields to be added without having to add new
 . ;    actions.  DBRS edit action only available on actions Continue
 . ;    and Reactivate
 . I +DGPFA("STATUS")=1 D
 . . S DGCODE="S^C:Continue Assignment;I:Inactivate Assignment"
 . . I $$P2ON^DGPFPARM()!(DGPFA("FLAG")["26.11") S DGCODE=DGCODE_";E:Entered in Error"
 . . I $P(DGPFA("FLAG"),U,2)="BEHAVIORAL" D  ;          dg*5.3*951
 . . . S DGCODE=DGCODE_";X:DBRS/Other Field Edit Only"
 . . . Q
 . . Q
 . E  S DGCODE="S^R:Reactivate Assignment"
 . ;
 . ;prompt user for assignment action, quit if no action selected
 . ;"ACTION" will have a value from 1-6 ; dg*951
 . S X=$$ANSWER^DGPFUT("Select an assignment action","",DGCODE)
 . Q:(X=-1)
 . S X=$F("CIREX",X) Q:'X  S DGPFAH("ACTION")=X
 . ;
 . ;if assignment action is 'Inactivate' or 'Entered in Error',
 . ;set status to 'Inactive'. default='Active'
 . ;if action is DBRS do not change current status; DG*5.3*951
 . I DGPFAH("ACTION")'=6 D
 . . S DGPFA("STATUS")=$S(DGPFAH("ACTION")=3:0,DGPFAH("ACTION")=5:0,1:1)
 . . Q
 . ;
 . ;  DBRS ; DG*5.3*951
 . I $$BEH,'$$EIE I '$$DBRSEDIT^DGPFUT6 Q
 . ;
 . ;if action is not 'Inactivate', then prompt user to edit the narr
 . S (DGABORT,DGOK,DGQ)=0
 . I 36'[DGPFAH("ACTION") D
 . . F  D  Q:(DGOK!DGABORT!DGQ)
 . . . N I,DGTX
 . . . ; if action code not 'Entered in Error', can't force edit
 . . . I '$$EIE D  Q:(DGQ!DGABORT)
 . . . . S DGASK=$$ANSWER^DGPFUT("Would you like to edit the assignment narrative","YES","Y")
 . . . . I DGASK<0 S DGABORT=1 Q  ;abort edit action
 . . . . I DGASK'=1 S DGQ=1 Q
 . . . ;
 . . . ;--edit narrative - only '5;Entered in Error' Required
 . . . ;--edit the assignment narrative
 . . . S DGAROOT=$$GET1^DIQ(26.13,DGIEN,"1","Z",DGAROOT)
 . . . S DIC=$$OREF^DILF(DGAROOT)
 . . . S DIWETXT="Patient Record Flag - Assignment Narrative Text"
 . . . S DIWESUB="Assignment Narrative Text"
 . . . S DWLW=75 ;max # of chars allowed to be stored on WP global node
 . . . S DWPK=1  ;if line editor, don't join lines
 . . . D EN^DIWE
 . . . I '$$CKWP^DGPFUT(DGAROOT,.DGTX) D  Q
 . . . . W !,"Assignment Narrative Text is required!"_$C(7)
 . . . . I $D(DGTX) S I=0 F  S I=$O(DGTX(I)) Q:'I  W !,DGTX(I)
 . . . . I '$$CONTINUE^DGPFUT() S DGABORT=1
 . . . . Q
 . . . ;  if number of text lines not the same, a change was made
 . . . I $O(DGPFA("NARR",""),-1)'=$O(@DGAROOT@(""),-1) S DGOK=1 Q
 . . . ;  now check for a difference in text line content
 . . . S DGSUB=0
 . . . F  S DGSUB=$O(DGPFA("NARR",DGSUB)) Q:DGSUB=""  D  Q:DGOK
 . . . . I DGPFA("NARR",DGSUB,0)'=@DGAROOT@(DGSUB,0) S DGOK=1
 . . . Q:DGOK
 . . . I 'DGOK,$$EIE D  Q  ;required edit
 . . . . W !!,"No editing was found to the Narrative text."
 . . . . W !,"For 'Entered in Error' Action, you must edit the Assignment Narrative Text."_$C(7),!
 . . . . I '$$CONTINUE^DGPFUT() S DGABORT=1
 . . . S DGOK=1
 . . . Q
 . . Q
 . ;
 . Q:$G(DGABORT)
 . ;
 . ;if narrative edited, place new narrative into DGPFA array
 . I $G(DGOK) D
 . . K DGPFA("NARR")  ;remove old narrative text
 . . M DGPFA("NARR")=@DGAROOT K @DGAROOT
 . ;
 . ;prompt user for 'Approved By' person, quit if not selected
 . S DGPFAH("APPRVBY")=$$ANSWER^DGPFUT("Approved By","","P^200:EMZ")
 . Q:(DGPFAH("APPRVBY")'>0)
 . ;
 . ;have user enter the edit reason/history comments (required)
 . ;quit if required edit reason/history comments not entered
 . S (DGABORT,DGOK)=0
 . F  D  Q:(DGOK!DGABORT)
 . . N I,DGTX,DIC,DIWESUB,DIWETXT,DWLW,DWPK
 . . W !!,"Enter the reason for editing this assignment:"  ;needed for line editor
 . . S DIC=$$OREF^DILF(DGCROOT)
 . . S DIWETXT="Patient Record Flag - Edit Reason Text"
 . . S DIWESUB="Edit Reason Text"
 . . S DWLW=75 ;max # of chars allowed to be stored on WP global node
 . . S DWPK=1  ;if line editor, don't join lines
 . . D EN^DIWE
 . . I $$CKWP^DGPFUT(DGCROOT,.DGTX) S DGOK=1
 . . E  D
 . . . W !,"Edit Reason is required!"_$C(7)
 . . . I $D(DGTX) S I=0 F  S I=$O(DGTX(I)) Q:'I  W !,DGTX(I)
 . . . I '$$CONTINUE^DGPFUT() S DGABORT=1
 . . . Q
 . . Q
 . ;
 . ;quit if required edit reason/history comments not entered
 . Q:$G(DGABORT)
 . ;
 . ; place comments into history array
 . I 'DGABORT M DGPFAH("COMMENT")=@DGCROOT K @DGCROOT
 . ;
 . ;setup remaining assignment history nodes for filing
 . S DGPFAH("ASSIGNDT")=$$NOW^XLFDT  ;current date/time
 . S DGPFAH("ENTERBY")=DUZ             ;current user
 . ;
 . ;calculate the default review date
 . S DGRDAT=$$GETRDT^DGPFAA3($P(DGPFA("FLAG"),U),DGPFAH("ASSIGNDT"))
 . ;
 . ;prompt for review date when valid default review date and ACTIVE
 . ;status, otherwise null
 . ; DG*3.5*951 - for new X action, no review date changes
 . ;              move pre-DG*5.3*951 code inside first argumentless DO
 . I DGPFAH("ACTION")<6 D
 . . I DGRDAT>0,DGPFA("STATUS")=1 D
 . . . N Y,XDT S Y=$$FMTE^XLFDT(DGRDAT,"5D")
 . . . S XDT="D^"_DT_":"_DGRDAT_":EX"
 . . . S DGPFA("REVIEWDT")=$$ANSWER^DGPFUT("Enter Review Date",Y,XDT)
 . . . Q
 . . E  S DGPFA("REVIEWDT")=""
 . . Q
 . Q:DGPFA("REVIEWDT")<0
 . ;
 . ;DG*5.3*951 - update DGPFA() and DGPFAH() as appropriate
 . I $$EIE D EIEARR
 . S DGPFA("ACTION")=$P(DGPFAH("ACTION"),U)
 . ;
 . ;display flag assignment review screen to user
 . D REVIEW^DGPFUT3(.DGPFA,.DGPFAH,DGIEN,XQY0,XQORNOD(0))
 . ;
 . ;if EIE,Behavioral flag, display warning ; DG*5.3*951
 . I $$EIE,$$BEH D EIE^DGPFUT6(.DGPFAH)
 . ;
 . Q:$$ANSWER^DGPFUT("Would you like to file the assignment changes","YES","Y")'>0
 . ;
 . ;file the assignment and history using STOALL api
 . W !,"Updating the patient's record flag assignment..."
 . S DGRESULT=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,.DGPFERR,"D")
 . S X="Assignment was "_$S('DGRESULT:"not ",1:"")_"filed successfully."
 . W !?5,X
 . ;
 . ;send HL7 message if editing assignment to a CAT I flag
 . I DGRESULT,DGPFA("FLAG")["26.15",$$SNDORU^DGPFHLS(+DGRESULT) D
 . . W !?5,"Message sent...updating patient's sites of record."
 . . Q
 . ;
 . D PAUSE^VALM1
 . ;re-build list of flag assignments for patient
 . D BLDLIST^DGPFLMU(DGDFN)
 . Q
 ;
 ;release lock after edit
 D UNLOCK^DGPFAA3(DGIEN)
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 ;
 Q
 ;
BEH() ;
 N X,Y S X=$G(DGPFA("FLAG"))
 S Y=0 I X[26.15,$P(X,U,2)="BEHAVIORAL" S Y=1
 Q Y
 ;
EIE() ;  was this action ENTERED IN ERROR
 Q +$G(DGPFAH("ACTION"))=5
 ;
EIEARR ;
 ;  Reset DGPFA() and DGPFAH() for DBRS EIE action
 N I,J,X,Y
 K DGPFAH("DBRS")
 S (I,J)=0 F  S I=$O(DGPFA("DBRS#",I)) Q:'I  D
 . S X=$P(DGPFA("DBRS#",I),U)
 . S $P(X,U,2)=$P($G(DGPFA("DBRS OTHER",I)),U)
 . S $P(X,U,3)=$P($G(DGPFA("DBRS DATE",I)),U)
 . S $P(X,U,4)="D"
 . S $P(X,U,5)=$P($G(DGPFA("DBRS SITE",I)),U)
 . S J=J+1,DGPFAH("DBRS",J)=X
 . Q
 F Y="DBRS#","DBRS DATE","DBRS OTHER","DBRS SITE" K DGPFA(Y)
 Q
