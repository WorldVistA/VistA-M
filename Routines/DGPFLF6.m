DGPFLF6 ;ALB/RPM - PRF FLAG MANAGEMENT LM SUB-ROUTINE ; 4/19/04 4:25pm
 ;;5.3;Registration;**425,554**;Aug 23, 1993
 ;
 Q
 ;
PRININV(DGFIEN,DGPFLF) ;Prompt for principle investigators
 ;
 ;  Input:
 ;    DGFIEN - (optional) Pointer to PRF LOCAL FLAG (#26.11) file.
 ;                        [default=0]
 ;    DGPFLF - Flag data array
 ;
 ;  Output:
 ;    Function Value - 1 on success, 0 when user enters "^"
 ;    DGPFLF("PRININV") - Array of principal investigators
 ;
 N DGASK   ;answer from prompt as a pointer to NEW PERSON (#200) file 
 N DGCNT   ;place holder for new entries
 N DGDA    ;default answer for prompt
 N DGLAST  ;last entry in field entry array
 N DGLKUP  ;principle investigator dynamic "B" index
 N DGNEWPI  ;principal investigator in FM external form
 N DGORIG  ;principle investigator unmodified "B" index
 N DGPREV  ;next to last entry in field entry array
 N DGQUIT  ;loop termination flag
 N DGRSLT  ;function value
 ;
 S DGFIEN=+$G(DGFIEN)  ;will be zero for 'Add Flag'
 ;
 ;build lookup and "on-file" array
 M DGORIG=^DGPF(26.11,DGFIEN,2,"B")
 M DGLKUP=DGORIG
 ;
 S DGRSLT=1
 S DGQUIT=0
 S (DGLAST,DGCNT)=+$O(DGPFLF("PRININV",""),-1)
 ;
 ;set default answer
 S DGDA=$P($G(DGPFLF("PRININV",DGLAST,0)),U,2)
 ;
 F  D  Q:DGQUIT
 . S DGASK=$$ANSWER^DGPFUT("Enter the Principal Investigator(s)",DGDA,"26.112,.01")
 . ;
 . ;stop prompting if user enters "^" or times out
 . I DGASK=-1 S DGQUIT=1,DGRSLT=0 Q
 . ;
 . ;stop prompting if user accepts default entry
 . I DGASK=$P($G(DGPFLF("PRININV",DGLAST,0)),U,1)!(DGASK="") S DGQUIT=1 Q
 . ;
 . ;perform lookup - re-prompt with new selection when entry exists 
 . I $D(DGLKUP(DGASK)) D  Q
 . . S DGLAST=+$O(DGLKUP(DGASK,0))
 . . S DGDA=$P(DGPFLF("PRININV",DGLAST,0),U,2)
 . ;
 . ;process delete - remove entry from lookup array and move last pointer
 . ;                 to previous entry in list.  Set the field entry
 . ;                 array value to "@" when the entry is "on-file",
 . ;                 otherwise, remove the field entry array node.
 . I DGASK="@" D  Q
 . . Q:'$D(DGPFLF("PRININV",DGLAST,0))
 . . Q:'$$ANSWER^DGPFUT("Sure you want to delete '"_$P(DGPFLF("PRININV",DGLAST,0),U,2)_"' as a PRINCIPAL INVESTIGATOR","Yes","Y")
 . . K DGLKUP($P(DGPFLF("PRININV",DGLAST,0),U,1))
 . . S DGPREV=+$O(DGPFLF("PRININV",DGLAST),-1)
 . . I $D(DGORIG($P(DGPFLF("PRININV",DGLAST,0),U,1))) D
 . . . S DGPFLF("PRININV",DGLAST,0)="@"
 . . E  D
 . . . K DGPFLF("PRININV",DGLAST,0)
 . . S DGLAST=DGPREV
 . . S DGDA=$P($G(DGPFLF("PRININV",DGLAST,0)),U,2)
 . ;
 . ;process new entry - if we make it here, then the entry is not the
 . ;                    default, does not already exist in the field
 . ;                    entry array and is not a delete.  Add entry
 . ;                    to the lookup array and the field entry array.
 . I DGDA=""!(DGASK'=$P($G(DGPFLF("PRININV",DGLAST,0)),U)) D
 . . S DGNEWPI=$$EXTERNAL^DILFD(26.112,.01,"F",DGASK)
 . . Q:'$$ANSWER^DGPFUT("Are you adding '"_DGNEWPI_"' as a new PRINCIPAL INVESTIGATOR","No","Y")
 . . S DGCNT=DGCNT+1
 . . S DGLKUP(DGASK,DGCNT)=""
 . . S DGPFLF("PRININV",DGCNT,0)=DGASK_U_DGNEWPI
 . . S DGDA=""
 ;
 Q DGRSLT
 ;
ASGNCNT(DGFIEN,DGDFNLST) ;counts existing assignments for a given flag
 ;This function searches for assignments for a given flag IEN and
 ;returns the count of assignments.  An optional array parameter will
 ;be loaded with the DFNs assigned to the flag.
 ;
 ;  Input:
 ;    DGFIEN - (required) Pointer to PRF LOCAL FLAG (#26.11) file or
 ;                        PRF NATIONAL FLAG (#26.15) file.
 ;  DGDFNLST - (optional) Array name to contain list of DFNs
 ;
 ;  Output:
 ;    Function Value - count of existing assignments
 ;  DGDFNLST - Defined only when existing assignments are found.
 ;             Array of DFNs from existing assignments.
 ;             Example:  DGDFNLST(7172421)=assignment IEN
 ;
 N DGCNT  ;function value
 N DGDFN   ;pointer to PATIENT (#2) file
 ;
 S DGCNT=0
 ;
 I $G(DGFIEN)]"",$D(^DGPF(26.13,"AFLAG",DGFIEN)) D
 . ;
 . ;count the assignments
 . S DGDFN=0
 . F  S DGDFN=$O(^DGPF(26.13,"AFLAG",DGFIEN,DGDFN)) Q:'DGDFN  D
 . . S DGCNT=DGCNT+1
 . . S DGDFNLST(DGDFN)=+$O(^DGPF(26.13,"AFLAG",DGFIEN,DGDFN,0))
 ;
 Q DGCNT
 ;
 ;
CKTIUPN(DGTITLE,DGARRAY) ;check for progress notes linked to a record flag
 ;This function is used to check all assignment history records of
 ;patients that are assigned to a given Record Flag for any existing
 ;associated Progress Note ien values setup.
 ;
 ;If any associated Progress Notes are found, the given Record Flag's
 ;Progress Note Title should not be edited until all the assignment
 ;history records are un-linked from that given record flag.
 ;
 ;  Input:
 ;    DGTITLE - IEN pointer to the TIU DOCUMENT (#8925.1) file
 ;    DGARRAY - Name of temp global closed root reference that
 ;              contains the list of DFNs assigned to record flag
 ;  i.e.  ^TMP("DGPHTIU",564715668,7172421)=assignment IEN of (#26.13)
 ;
 ;  Output:
 ;    Function result - "1" = if any linked Progress Notes are found
 ;                    - "0" = if none found
 ;
 N DGRSLT  ;function output - 0 or 1
 N DGDFN   ;pointer to PATIENT (#2) file
 N DGHTIU  ;array of return values for each assignment history record
 N DGI     ;for loop var
 ;
 S DGRSLT=0
 ;
 I $G(DGTITLE),$G(DGARRAY)]"" D
 . ;
 . S DGHTIU=$NA(^TMP("DGHTIU",$J))
 . S DGDFN=0
 . F  S DGDFN=$O(@DGARRAY@(DGDFN)) Q:DGDFN=""  D  Q:DGRSLT
 . . K @DGHTIU
 . . I $$GETHTIU^DGPFAPI1(DGDFN,DGTITLE,DGHTIU) D
 . . . S DGI=""
 . . . F  S DGI=$O(@DGHTIU@("HISTORY",DGI)) Q:DGI=""  D  Q:DGRSLT
 . . . . I $P($G(@DGHTIU@("HISTORY",DGI,"TIUIEN")),U)]"" S DGRSLT=1
 . ;
 . K @DGHTIU
 ;
 Q DGRSLT
