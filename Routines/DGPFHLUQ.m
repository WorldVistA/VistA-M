DGPFHLUQ ;ALB/RPM - PRF HL7 INTERACTIVE QUERY ; 8/24/06
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
EN ;entry point
 ;This procedure prompts the user to select a patient and the facility
 ;that they wish to check for existing Category I patient record flags.
 ;An HL7 query is then sent to the selected facility.
 ;
 N DGDFN   ;pointer to patient in PATIENT (#2) file
 N DGFAC   ;selected facility
 N DGTF    ;array of treating facilities
 N DGPAT   ;selected patient
 N DGRSLT  ;result of query call
 ;
 ;select patient
 W !!
 D SELPAT^DGPFUT1(.DGPAT)
 Q:+$G(DGPAT)'>0
 S DGDFN=+DGPAT
 ;
 ;build list of valid query facilities
 I '$$BLDTFL^DGPFUT2(DGDFN,.DGTF) D  Q
 . N DGLINE
 . S DGLINE(1)=""
 . S DGLINE(3)="* No treating facilities are available to query. *"
 . S $P(DGLINE(2),"*",$L(DGLINE(3)))="*"
 . S DGLINE(4)=DGLINE(2)
 . S DGLINE(5)=""
 . D EN^DDIOL(.DGLINE)
 . I $$CONTINUE^DGPFUT()
 ;
 ;select facility
 S DGFAC=$$ANSWER^DGPFUT("Select facility to query",$P($$NS^XUAF4($$GETNXTF^DGPFUT(DGDFN)),U),"P^4:EMZ","","I $D(DGTF(+Y))")
 Q:DGFAC'>0
 S DGFAC=$$STA^XUAF4(DGFAC)
 ;
 ;send query and build display
 S DGRSLT=$$SNDQRY^DGPFHLS(DGDFN,3,DGFAC)
 ;
 Q
 ;
 ;
DISPLAY(DGMTIEN,DGRESULT) ;DISPLAY RESULTS
 ;This procedure is the entry point called from SNDQRY^DGPFHLS that
 ;parses and displays the returned Response to Observation Query
 ;(ORF~R04) HL7 message.
 ;
 ;  Input:
 ;    DGMTIEN - if positive a response was returned from destination;
 ;              otherwise, no response was returned
 ;   DGRESULT - result parameter from HLMA call
 ;
 ;  Output: none
 ;   
 N DGANS     ;pause response
 N DGCNT     ;continuation node counter
 N DGERR     ;parsed message error results array
 N DGFACNAM  ;facility name
 N DGORF     ;parsed data array name
 N DGSEGCNT  ;segment counter
 N DGSTA     ;station number
 N DGTEXT    ;message text array
 N DGWRK     ;HL7 segments array name
 ;
 ;if HL7 package reports failure, notify user and quit
 I +$G(DGMTIEN)<1!(+$P($G(DGRESULT),U,2)) D  Q
 . K DGTEXT
 . S DGTEXT(1)="The facility failed to respond to the query request."
 . D SHOWMSG(.DGTEXT,"*")
 . I $$ANSWER^DGPFUT("Enter RETURN to continue","","E")
 ;
 S DGWRK=$NA(^TMP("DGPFHL7",$J))
 K @DGWRK
 S DGORF=$NA(^TMP("DGPF",$J))
 K @DGORF
 ;
 ;load work global with segments
 F DGSEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S DGCNT=0
 . S @DGWRK@(DGSEGCNT,DGCNT)=HLNODE
 . F  S DGCNT=$O(HLNODE(DGCNT)) Q:'DGCNT  D
 . . S @DGWRK@(DGSEGCNT,DGCNT)=HLNODE(DGCNT)
 ;
 ;parse segments and load into data array
 D PARSORF^DGPFHLQ4(DGWRK,.HL,DGORF,.DGERR)
 ;
 ;get facility name from message
 S DGSTA=$G(@DGORF@("SNDFAC"))
 S DGFACNAM=$$EXTERNAL^DILFD(26.13,.04,"F",$$IEN^XUAF4(DGSTA))
 ;
 ;when assignments are returned, file any that are missing locally
 ;and display all returned assignments
 I $O(@DGORF@(0)) D
 . ;
 . N DGDFN     ;patient
 . N DGFLG     ;flag name
 . N DGI       ;generic index
 . N DGPRE     ;list of flag assignments prior to filing
 . N DGPRECNT  ;count of flag assignments prior to filing
 . N DGPST     ;list of flag assignments following filing
 . ;
 . S DGDFN=$$GETDFN^MPIF001(+$G(@DGORF@("ICN")))
 . ;
 . ;get list of existing Cat I assignments
 . S DGPRECNT=$$GETFNAME(DGDFN,.DGPRE)
 . ;
 . ;store the returned assignments
 . I $$STOORF^DGPFHLR(DGDFN,DGORF)  ;naked IF
 . ;
 . ;get updated list of Cat I assignments and notify user when
 . ;assignments are added
 . I $$GETFNAME(DGDFN,.DGPST)>DGPRECNT D
 . . K DGTEXT
 . . ;
 . . ;remove pre-existing flags from assignment list
 . . S DGFLG=""
 . . F  S DGFLG=$O(DGPST(DGFLG)) Q:DGFLG=""  K:$D(DGPRE(DGFLG)) DGPST(DGFLG)
 . . ;build user message
 . . S DGTEXT(1)="The following Category I Patient Record Flag Assignments"
 . . S DGTEXT(2)="were returned and filed on your system:"
 . . S DGFLG=""
 . . F DGI=3:1 S DGFLG=$O(DGPST(DGFLG)) Q:DGFLG=""  D
 . . . S DGTEXT(DGI)="    "_DGFLG
 . . D SHOWMSG(.DGTEXT,"*")
 . . S DGANS=$$ANSWER^DGPFUT("Enter RETURN to view query results","","E")
 . ;
 . ;display query results
 . I +$G(DGANS)>-1 D EN^DGPFLMQ(DGORF)
 ;
 ;otherwise notify user that none were found
 E  D
 . K DGTEXT
 . S DGTEXT(1)="No Category I Patient Record Flag Assignments found for"
 . S DGTEXT(2)="this patient at "_DGFACNAM_" ("_DGSTA_")."
 . D SHOWMSG(.DGTEXT,"*")
 . I $$ANSWER^DGPFUT("Enter RETURN to continue","","E")
 ;
 ;cleanup
 K @DGWRK
 K @DGORF
 Q
 ;
GETFNAME(DGDFN,DGFLGS) ;get list of assigned flag names
 ;
 ;  Input:
 ;    DGDFN
 ;
 ;  Output:
 ;   Function value - count of assigned flag names
 ;   DGFLGS - array of assigned flag names
 ;            Ex.  DGFLGS("FLAGNAME")=""
 ;
 N DGASGN  ;PRF assignments array
 N DGCNT   ;assigned flag name count
 N DGPFA   ;assignment data array
 N DGIEN   ;assignment record#
 ;
 S DGCNT=0
 I $$GETALL^DGPFAA(DGDFN,.DGASGN,"",1) D
 . S DGIEN=0
 . F  S DGIEN=$O(DGASGN(DGIEN)) Q:'DGIEN  D
 . . I $$GETASGN^DGPFAA(DGIEN,.DGPFA) D 
 . . . S DGFLGS($P(DGPFA("FLAG"),U,2))=""
 . . . S DGCNT=DGCNT+1
 Q DGCNT
 ;
SHOWMSG(DGTEXT,DGBCHAR) ;format and display user message
 ;
 ;  Input:
 ;    DGTEXT  - array of lines to display
 ;    DGBCHAR - border character (optional [DEFAULT="*"])
 ;
 ;  Output:  none
 ;
 N DGBLNK  ;blank line
 N DGBORDER  ;border string
 N DGCNT   ;line counter
 N DGI     ;generic index
 N DGLEN   ;line length
 N DGLINE  ;formatted text line
 N DGMAX   ;max line length
 ;
 S DGBCHAR=$S($G(DGBCHAR)?1.ANP:$E(DGBCHAR),1:"*")
 ;determine max line length
 S (DGI,DGCNT,DGMAX)=0
 F  S DGI=$O(DGTEXT(DGI)) Q:'DGI  D
 . S DGLEN=$L(DGTEXT(DGI))
 . I DGLEN>(IOM-4) D
 . . S DGTEXT(DGI+.1)=$E(DGTEXT(DGI),IOM-3,DGLEN)
 . . S DGTEXT(DGI)=$E(DGTEXT(DGI),1,IOM-4)
 . . S DGLEN=IOM-4
 . S:DGLEN>DGMAX DGMAX=DGLEN
 S $P(DGBLNK," ",DGMAX+1)=""
 S $P(DGBORDER,DGBCHAR,DGMAX+5)=""
 S DGCNT=DGCNT+1
 S DGLINE(DGCNT)=""
 S DGCNT=DGCNT+1
 S DGLINE(DGCNT)=DGBORDER
 S DGI=0
 F  S DGI=$O(DGTEXT(DGI)) Q:'DGI  D
 . S DGCNT=DGCNT+1
 . S DGLINE(DGCNT)=DGBCHAR_" "_DGTEXT(DGI)_$E(DGBLNK,1,$L(DGBLNK)-$L(DGTEXT(DGI)))_" "_DGBCHAR
 S DGCNT=DGCNT+1
 S DGLINE(DGCNT)=DGBORDER
 S DGCNT=DGCNT+1
 S DGLINE(DGCNT)=""
 D EN^DDIOL(.DGLINE)
 ;
 Q
