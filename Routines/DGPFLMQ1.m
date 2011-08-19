DGPFLMQ1 ;ALB/RPM - PRF QUERY LISTMAN SCREEN BUILDER; 6/19/06
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
BLDHDR(DGORF,DGPFHDR) ;build VALMHDR array
 ;This procedure builds the VALMHDR array to display the ListMan header.
 ;
 ; Supported DBIA #2701: The supported DBIA is used to access the
 ;                       MPI functions to retrieve the ICN and CMOR.
 ;
 ;  Input:
 ;     DGORF - parsed ORF segments data array
 ;   DGPFHDR - header array passed by reference
 ;
 ; Output:
 ;   DGPFHDR - header array
 ;
 N DGDFN     ;pointer to patient in PATIENT (#2) file
 N DGFACNAM  ;facility name
 N DGICN     ;Integrated Control Number
 N DGPFPAT   ;Patient identifying info
 ;
 S DGDFN=+$$GETDFN^MPIF001($G(@DGORF@("ICN")))
 ;
 ;retrieve patient identifying info
 I $$GETPAT^DGPFUT2(DGDFN,.DGPFPAT)
 ;
 ;set 1st line of header
 S DGPFHDR(1)="Patient: "_$G(DGPFPAT("NAME"))_" "
 S DGPFHDR(1)=$$SETSTR^VALM1("("_$G(DGPFPAT("SSN"))_")",DGPFHDR(1),$L(DGPFHDR(1))+1,80)
 S DGPFHDR(1)=$$SETSTR^VALM1("DOB: "_$$FDATE^VALM1($G(DGPFPAT("DOB"))),DGPFHDR(1),54,80)
 ;
 ;set 2nd line of header
 S DGICN=$G(@DGORF@("ICN"))
 S DGICN=$S(DGICN<0:"No ICN for patient",1:DGICN)
 S DGPFHDR(2)="    ICN: "_DGICN
 S DGFACNAM=$$EXTERNAL^DILFD(26.13,.04,"F",$$IEN^XUAF4($G(@DGORF@("SNDFAC"))))
 S DGPFHDR(2)=$$SETSTR^VALM1("FACILITY QUERIED: "_DGFACNAM,DGPFHDR(2),41,27)
 Q
 ;
 ;
BLDLIST(DGORF) ;build list of returned assignments
 ;
 ;  Input:
 ;    DGORF - parsed ORF segments data array
 ;    
 ;  Output: none
 ;
 D CLEAN^VALM10
 N DGSET  ;flag assignment indicator
 ;
 ;
 S DGSET=0,VALMCNT=0
 F  S DGSET=$O(@DGORF@(DGSET)) Q:'DGSET  D
 . S VALMCNT=VALMCNT+1
 . N DGPFA   ;assignment data array
 . ;
 . ;load assignment data array
 . D LDASGN^DGPFLMQ2(DGSET,DGORF,.DGPFA)
 . ;
 . S DGPFA("INITASSIGN")=$O(@DGORF@(DGSET,0))  ;initial assignment date
 . ;
 . ;get most recent assignment history to calculate current status
 . S DGADT=$O(@DGORF@(DGSET,9999999.999999),-1)
 . S DGPFA("STATUS")=$$STATUS^DGPFUT($G(@DGORF@(DGSET,DGADT,"ACTION")))
 . S DGPFA("NUMACT")=$$NUMACT(DGSET,DGORF)
 . ;
 . ;build Assignment line
 . D BLDLIN(VALMCNT,.DGPFA,DGSET)
 ;
 Q
 ;
 ;
BLDLIN(DGLNUM,DGPFA,DGSET) ;build and format lines
 ;This procedure will build and setup ListMan lines and array.
 ;
 ;  Input:
 ;    DGLNUM - line number
 ;     DGPFA - array containing assignment, passed by reference
 ;     DGSET - set id representing a single PRF assignment
 ;
 ; Output: None
 ;
 N DGTXT      ;used as temporary text field
 N DGLINE     ;string to insert field data
 S DGLINE=""  ;init
 S DGLINE=$$SETSTR^VALM1(DGLNUM,DGLINE,1,3)
 ;
 ;flag name
 S DGTXT=$$EXTERNAL^DILFD(26.13,.02,"F",$G(DGPFA("FLAG")))
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"FLAG")
 ;
 ;initial assignment date
 S DGTXT=$$FDATE^VALM1(+$G(DGPFA("INITASSIGN")))
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"ASSIGN DATE")
 ;
 ;status/active (yes/no)
 S DGTXT=$P($G(DGPFA("STATUS")),U)
 S DGTXT=$S(DGTXT=1:"YES",1:"NO")
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"STATUS")
 ;
 ;# of actions
 S DGTXT=DGPFA("NUMACT")
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"ACTION CNT")
 ;
 ;owner site
 S DGTXT=$$EXTERNAL^DILFD(26.13,.04,"F",$G(DGPFA("OWNER")))
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"OWNER SITE")
 ;
 ;construct initial list array and "IDX"
 D SET^VALM10(DGLNUM,DGLINE,+$G(DGSET))
 ;
 Q
 ;
NUMACT(DGSET,DGORF) ;count actions
 ;This function counts the number of assignment actions for a given
 ;flag assignment.
 ;
 ;  Input:
 ;    DGSET - set id representing a single PRF assignment
 ;    DGORF - parsed ORF segments data array
 ;
 ;  Output:
 ;   Function value - count of assignment actions
 ;     
 N DGADT  ;assignment date
 N DGCNT  ;function value
 ;
 S DGADT=0,DGCNT=0
 F  S DGADT=$O(@DGORF@(DGSET,DGADT)) Q:'DGADT  S DGCNT=DGCNT+1
 ;
 Q DGCNT
 ;
 ;
DR ;Display Query Results action
 ;This procedure is called by the DGPF DISPLAY QUERY RESULTS action
 ;protocol.
 ;
 ;  Input:
 ;    DGORF - parsed ORF segments data array passed globally
 ;    
 ;  Output:
 ;    VALMBCK - 'R'= refresh screen
 ;    
 N DGSET  ;flag assignment indicator
 N SEL    ;user selection
 N VALMY  ;output of EN^VALM2 call, array of user selected entries
 ;
 ;set screen to full scroll region
 D FULL^VALM1
 ;
 ;is action selection allowed?
 I '$D(@VALMAR@("IDX")) D  Q
 . W !!?2,">>> '"_$P($G(XQORNOD(0)),U,3)_"' action not allowed at this point.",*7
 . W !?6,"There are no record flag assignment query results for this patient."
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 ;ask user to select a single assignment for detail display
 S (SEL,VALMBCK)=""
 D EN^VALM2($G(XQORNOD(0)),"S")
 ;
 ;process user selection
 S SEL=$O(VALMY(""))
 I SEL,$D(@VALMAR@("IDX",SEL)) D
 . S DGSET=$O(@VALMAR@("IDX",SEL,""))
 . ;-display query result flag assignment details
 . N VALMHDR
 . D EN^DGPFLMQD(DGSET,DGORF)
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
