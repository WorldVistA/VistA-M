DGPFLF5 ;ALB/RBS - PRF FLAG MANAGEMENT LM PROTOCOL ACTIONS CONT. ; 3/23/05 1:01pm
 ;;5.3;Registration;**425,554**;Aug 13, 1993 
 ;
 ;no direct entry
 QUIT
 ;
EFCONT(DGPFLF,DGPFLH,DGPFORIG,DGABORT,DGIDXIEN) ; EF  Edit Flag action
 ;-- Continue entry point for DGPF EDIT FLAG action protocol.
 ;
 ;  Input:
 ;      DGPFLF  - array of flag record fields (passed by reference)
 ;      DGPFLH  - array for REASON field (passed by reference)
 ;    DGPFORIG  - DGPFLF copy of original values (passed by reference)
 ;     DGABORT  - abort flag - value passed in = 0
 ;    DGIDXIEN  - ien of flag record from the "IDX"
 ;
 ; Output:
 ;      DGPFLF  - Edited array of flag record fields
 ;     DGABORT  - 1 if user wishes to abort, 0 otherwise
 ;
 N DIC,DGWPROOT,DIWETXT,DIWESUB,DWLW,DWPK ;input vars for EN^DIWE call
 N DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT       ;input/output vars for ^DIR
 N DGDA       ;default answer
 N DGCKWP     ;check if word-processing is OK
 N DGASK      ;return value from $$ANSWER^DGPFUT call
 N DGRDAY     ;review frequency
 N DGQ,DGSUB  ;counters and quit flag
 N DGACNT     ;count of existing assignments assigned to flag
 N DGDFNLST   ;array of DFN's when existing assignments are found
 N DGTITLE    ;pointer of the progress note title
 N DGARRAY    ;array of assignment history data
 ;
 S (DGACNT,DGQ,DGSUB)=0
 S DGARRAY=$NA(^TMP("DGPFLF5",$J)) K @DGARRAY
 ;
 ; check for assignments to the flag and load the array with the DFN's
 S DGACNT=$$ASGNCNT^DGPFLF6(DGIDXIEN,.DGDFNLST)
 I DGACNT M @DGARRAY=DGDFNLST K DGDFNLST
 ;
 ;-- user prompts
 D
 . ;-- prompt for flag name, quit if one not entered
 . S DGDA=$P($G(DGPFLF("FLAG")),U,2)
 . S DGASK=$$ANSWER^DGPFUT("Enter the Record Flag Name",DGDA,"26.11,.01^^I X'=DGDA,$D(^DGPF(26.11,""B"",X)) K X W "" *** Flag name already on file""")
 . I DGASK=-1!(DGASK=0) S DGABORT=1 Q
 . I DGASK'=DGDA D
 . . I DGACNT D  Q
 . . . W !,"   >>> Name change not allowed ... "_DGACNT_" patients are assigned to this flag."
 . . . S DGABORT=1
 . . ;
 . . S DGPFLF("OLDFLAG")=DGDA      ;save for name change lookup
 . . S DGPFLF("FLAG")=DGASK_U_DGASK
 . ;
 . Q:DGABORT
 . ;
 . ;-- prompt for status of the flag, quit if one not entered
 . S DGDA=$P($G(DGPFLF("STAT")),U,2)
 . S DGASK=$$ANSWER^DGPFUT("Enter the Status of the Flag",DGDA,"26.11,.02")
 . I DGASK<0 S DGABORT=1 Q
 . S:DGASK'=$P($G(DGPFLF("STAT")),U) DGPFLF("STAT")=DGASK_U_$$EXTERNAL^DILFD(26.11,.02,"F",DGASK)
 . ;
 . ; check for any Active Patient Assignments and give warning
 . ;  that all patients will be inactivated when this edit is filed
 . I DGASK=0,$D(^DGPF(26.13,"ASTAT",1,DGIDXIEN)) D
 . . W *7,!,"   >>> WARNING - All Patient's assigned to this flag will be"
 . . W !?17,"Inactivated automatically after filing this edit."
 . . ;
 . . I $$ANSWER^DGPFUT("Enter RETURN to continue or '^' to exit","","E")=-1 S DGABORT=1
 . ;
 . Q:DGABORT
 . ;
 . ;-- prompt for flag type, quit if one not entered
 . S DGDA=$P($G(DGPFLF("TYPE")),U,2)
 . S DGASK=$$ANSWER^DGPFUT("Enter the Type of the Flag",DGDA,"26.11,.03")
 . I DGASK'>0 S DGABORT=1 Q
 . I DGASK'=$P($G(DGPFLF("TYPE")),U) D
 . . I DGACNT D  Q
 . . . W !,"   >>> Flag Type change not allowed ... "_DGACNT_" patients are assigned to this flag."
 . . . S DGABORT=1
 . . S DGPFLF("TYPE")=DGASK_U_$$EXTERNAL^DILFD(26.11,.03,"F",DGASK)
 . Q:DGABORT
 . ;
 . ;-- delete all principal investigator(s) if flag type not RESEARCH
 . I +DGPFLF("TYPE")'=2,$D(DGPFLF("PRININV")) D
 . . S DGSUB=0
 . . F  S DGSUB=$O(DGPFLF("PRININV",DGSUB)) Q:DGSUB=""  D
 . . . S DGPFLF("PRININV",DGSUB,0)="@"
 . ;
 . ;-- prompt for principal investigator(s) name for RESEARCH type flag
 . I +DGPFLF("TYPE")=2,'$$PRININV^DGPFLF6(+DGIDXIEN,.DGPFLF) D  Q:DGABORT
 . . I $$ANSWER^DGPFUT("Enter RETURN to continue or '^' to exit","","E")=-1 S DGABORT=1
 . ;
 . ;-- prompt for review frequency, quit if one not entered
 . S DGDA=$P($G(DGPFLF("REVFREQ")),U,2)
 . S DGASK=$$ANSWER^DGPFUT("Enter the Review Frequency Days",DGDA,"26.11,.04^^K:$L(X)>4!(X[""."") X")
 . I DGASK<0 S DGABORT=1 Q
 . S:DGASK'=$P($G(DGPFLF("REVFREQ")),U) DGPFLF("REVFREQ")=DGASK_U_DGASK
 . S DGRDAY=DGASK
 . I DGASK=0 D  ;don't ask notification/review group when review freq = 0
 . . S DGPFLF("NOTIDAYS")=0_U_0
 . . S DGPFLF("REVGRP")=""_U_""
 . . ;
 . E  D  Q:DGABORT
 . . ;
 . . ;-- prompt for notification days
 . . S DGDA=$P($G(DGPFLF("NOTIDAYS")),U,2)
 . . S DGASK=$$ANSWER^DGPFUT("Enter the Notification Days",DGDA,"26.11,.05^^K:$L(X)>4!(X[""."")!(X>DGRDAY) X")
 . . I DGASK<0 S DGABORT=1 Q
 . . S DGPFLF("NOTIDAYS")=DGASK_U_DGASK
 . . ;
 . . S DGQ=0
 . . F  D  Q:(DGQ!DGABORT)
 . . . ;-- prompt for review mail group name, optional entry
 . . . S DGDA=$P($G(DGPFLF("REVGRP")),U,2)
 . . . S DGASK=$$ANSWER^DGPFUT("Enter the Review Mail Group",DGDA,"26.11,.06r")
 . . . I DGASK<0 S DGABORT=1 Q
 . . . I DGASK'>0 D  Q
 . . . . W !,"   >>> You've entered the Review Frequency and Notification Days,"
 . . . . W !,"       now enter a Review Mail Group or abort this process.",*7
 . . . . I '$$CONTINUE^DGPFUT() S DGABORT=1
 . . . ;
 . . . S DGPFLF("REVGRP")=DGASK_U_$$EXTERNAL^DILFD(26.11,.06,"F",DGASK)
 . . . S DGQ=1  ;set entry, quit
 . ;
 . ;-- prompt for associated TIU PN Title
 . S DGDA=$P($G(DGPFLF("TIUTITLE")),U,2),DGQ=0
 . S DGTITLE=$P($G(DGPFLF("TIUTITLE")),U)
 . S DGASK=$$ANSWER^DGPFUT("Enter the Progress Note Title",DGDA,"26.11,.07r")
 . I DGASK<0 S DGABORT=1 Q
 . ;
 . ; Do not allow the title to change using the following logic:
 . ; - if the existing progress note title changes,
 . ;    and there are patients assigned to the record flag name,
 . ;     and there are any linked TIU progress notes on any patients
 . ;      assignment history record
 . ;
 . I DGASK'=DGTITLE D
 . . I $$FNDTITLE^DGPFAPI1(DGASK) S DGQ=1  ;should never happen...but
 . . I 'DGQ,DGTITLE,DGACNT D
 . . . ; check all DFN's assigned to the record flag
 . . . I $$CKTIUPN^DGPFLF6(DGTITLE,DGARRAY) S DGQ=1
 . . I DGQ D  Q
 . . . W !!,"   >>> Unable to edit, there are Progress Note(s) associated with a",!,"       patient's PRF Assignment action.",!,*7
 . . ;
 . . ; ok to add or change the TIU Progress Note Title
 . . S DGPFLF("TIUTITLE")=DGASK_U_$$EXTERNAL^DILFD(26.11,.07,"F",DGASK)
 . ;
 . Q:DGABORT
 . ;
 . ;-- ask user if they want to edit the flag description text
 . I $$ANSWER^DGPFUT("Would you like to edit the description of this record flag","NO","Y")>0 D  Q:DGABORT
 . . S DGCKWP=0 K DGERR
 . . S DGWPROOT=$NA(^TMP($J,"DGPFDESC"))
 . . K @DGWPROOT
 . . S DGDA=$$GET1^DIQ(26.11,$P(DGIDXIEN,";"),"1","Z",DGWPROOT,"DGERR")
 . . I $D(DGERR)!(DGDA="") S DGABORT=1 D  Q
 . . . W !,"An error has occurred while trying to retrieve the Flag Description Text.",*7
 . . F  D  Q:(DGCKWP!DGABORT)
 . . . S DIC=$$OREF^DILF(DGWPROOT)
 . . . S DIWETXT="Patient Record Flag - Flag Description Text"
 . . . S DIWESUB="Flag Description Text"
 . . . S DWLW=75 ;max # chars allowed to be stored on WP global node
 . . . S DWPK=1  ;if line editor, don't join line
 . . . D EN^DIWE
 . . . I $$CKWP^DGPFUT(DGWPROOT) S DGCKWP=1 Q
 . . . W !,"Flag Description Text is required!",!,*7
 . . . I '$$CONTINUE^DGPFUT() S DGABORT=1 K @DGWPROOT
 . . ;
 . . ;-- quit if required flag description not entered
 . . Q:DGABORT
 . . ;
 . . ;-- place flag description text into assignment array
 . . I DGCKWP D
 . . . K DGPFLF("DESC")
 . . . M DGPFLF("DESC")=@DGWPROOT
 . . . K @DGWPROOT
 . ;
 . Q:DGABORT
 . ;
 . ;-- have user enter edit reason (required)
 . S DGCKWP=0
 . S DGWPROOT=$NA(^TMP($J,"DGPFREASON"))
 . K @DGWPROOT
 . F  D  Q:(DGCKWP!DGABORT)
 . . W !!,"Enter the reason for editing this record flag:"  ;needed for line editor
 . . S DIC=$$OREF^DILF(DGWPROOT)
 . . S DIWETXT="Patient Record Flag - Edit Reason Text"
 . . S DIWESUB="Edit Reason Text"
 . . S DWLW=75 ;max # chars allowed to be stored on WP global node
 . . S DWPK=1  ;if line editor, don't join line
 . . D EN^DIWE
 . . I $$CKWP^DGPFUT(DGWPROOT) S DGCKWP=1 Q
 . . W !,"Edit Reason Text is required!",!,*7
 . . I '$$CONTINUE^DGPFUT() S DGABORT=1 K @DGWPROOT
 . ;
 . Q:DGABORT
 . I DGCKWP M DGPFLH("REASON")=@DGWPROOT K @DGWPROOT
 . ;
 . S:'DGCKWP DGABORT=1
 ;
 I DGACNT K @DGARRAY
 Q
