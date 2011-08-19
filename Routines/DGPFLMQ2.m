DGPFLMQ2 ;ALB/RPM - PRF HL7 QUERY RESULTS DISPLAY UTILITIES ; 1/25/06 11:24
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
EN(DGARY,DGSET,DGCNT) ;display ORF query results
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;    DGSET - set id representing a single PRF assignment
 ;
 ;  Output:
 ;    DGCNT - number of lines in list, pass by reference
 ;
 N DGADT     ;assignment date
 N DGHISCNT  ;history action counter
 N DGLINE    ;list line counter
 N DGPFA     ;assignment data array
 N DGPFAH    ;assignment history data array
 ;
 S (DGLINE,VALMBEG)=1
 S DGCNT=0
 ;
 ;load assignment data array
 D LDASGN(DGSET,DGORF,.DGPFA)
 S DGPFA("INITASSIGN")=$O(@DGORF@(DGSET,0))  ;initial assignment date
 ;
 ;get most recent assignment history to calculate current status
 S DGADT=$O(@DGORF@(DGSET,9999999.999999),-1)
 S DGPFA("STATUS")=$$STATUS^DGPFUT($G(@DGORF@(DGSET,DGADT,"ACTION")))
 ;
 ;build Assignment Details area
 D ASGN(DGARY,.DGPFA,.DGLINE,.DGCNT)
 ;
 ;build Assignment History heading
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,$TR($J("",80)," ","="),1,,,.DGCNT)
 D SET(DGARY,DGLINE,"<Assignment History>",30,IORVON,IORVOFF,.DGCNT)
 ;
 S DGHISCNT=0
 S DGADT=9999999.999999  ;each DGADT represents a single PRF history action
 F  S DGADT=$O(@DGORF@(DGSET,DGADT),-1) Q:'DGADT  D
 . N DGPFAH   ;assignment history data array
 . S DGHISCNT=DGHISCNT+1
 . ;
 . ;load assignment history data array
 . D LDHIST(DGSET,DGADT,DGORF,.DGPFAH)
 . ;
 . ;build History Details area
 . D HIST(DGARY,.DGPFAH,.DGLINE,DGHISCNT,.DGCNT)
 S ^TMP(DGARY,$J,"SET")=DGSET
 Q
 ;
 ;
LDASGN(DGSET,DGORF,DGPFA) ;load assignment data array
 ;
 ;  Input:
 ;    DGSET - set id representing a single PRF assignment
 ;    DGORF - parsed ORF segments data array
 ;
 ;  Output:
 ;    DGPFA - assignment data array
 ;
 S DGPFA("DFN")=+$$GETDFN^MPIF001($G(@DGORF@("ICN")))
 S DGPFA("FLAG")=$G(@DGORF@(DGSET,"FLAG"))
 Q:DGPFA("FLAG")']""
 ;
 ;init STATUS as a placeholder, set value following history retrieval
 S DGPFA("STATUS")=""
 S DGPFA("OWNER")=$G(@DGORF@(DGSET,"OWNER"))
 S DGPFA("ORIGSITE")=$G(@DGORF@(DGSET,"ORIGSITE"))
 M DGPFA("NARR")=@DGORF@(DGSET,"NARR")
 ;
 Q
 ;
 ;
LDHIST(DGSET,DGADT,DGORF,DGPFAH) ;load assignment history data array
 ;
 ;  Input:
 ;    DGSET - set id representing a single PRF assignment
 ;    DGADT - assignment date
 ;    DGORF - parsed ORF segments data array
 ;
 ;  Output:
 ;    DGPFAH - assignment history data array
 ;
 S DGPFAH("ASSIGNDT")=DGADT
 S DGPFAH("ACTION")=$G(@DGORF@(DGSET,DGADT,"ACTION"))
 S DGPFAH("ENTERBY")=.5  ;POSTMASTER
 S DGPFAH("APPRVBY")=.5  ;POSTMASTER
 M DGPFAH("COMMENT")=@DGORF@(DGSET,DGADT,"COMMENT")
 Q
 ;
 ;
ASGN(DGARY,DGPFA,DGLINE,DGCNT) ;format assignment details
 ;This procedure will build and format the lines of FLAG ASSIGNMENT
 ;details.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;    DGPFA - assignment array, pass by reference
 ;   DGLINE - line counter, pass by reference
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 ;temporary variables used
 N DGSUB
 N DGTMP
 N DGTXT
 ;
 ;set flag name
 S DGTXT=$$EXTERNAL^DILFD(26.13,.02,"F",$G(DGPFA("FLAG")))
 I DGTXT="" S DGTXT="**FLAG not defined**"
 D SET(DGARY,DGLINE,"Flag Name: "_DGTXT,12,,,.DGCNT)
 ;
 ;set flag assignment status
 S DGLINE=DGLINE+1
 S DGTXT=$$EXTERNAL^DILFD(26.13,.03,"F",$G(DGPFA("STATUS")))
 D SET(DGARY,DGLINE,"Assignment Status: "_DGTXT,4,,,.DGCNT)
 ;
 ;set initial assignment date
 S DGLINE=DGLINE+1
 S DGTXT=$$FDTTM^VALM1($P(+$G(DGPFA("INITASSIGN")),U))
 D SET(DGARY,DGLINE,"Initial Assignment: "_DGTXT,3,,,.DGCNT)
 ;
 ;set owner site
 S DGLINE=DGLINE+1
 S DGTXT=$$EXTERNAL^DILFD(26.13,.04,"F",$G(DGPFA("OWNER")))
 D SET(DGARY,DGLINE,"Owner Site: "_DGTXT_"  "_$$FMTPRNT^DGPFUT1($P($G(DGPFA("OWNER")),U)),11,,,.DGCNT)
 ;
 ;set originating site
 S DGLINE=DGLINE+1
 S DGTXT=$$EXTERNAL^DILFD(26.13,.04,"F",$G(DGPFA("ORIGSITE")))
 D SET(DGARY,DGLINE,"Originating Site: "_DGTXT_"  "_$$FMTPRNT^DGPFUT1($P($G(DGPFA("ORIGSITE")),U)),5,,,.DGCNT)
 ;
 ;set assignment narrative
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"",1,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Record Flag Assignment Narrative:",1,IORVON,IORVOFF,.DGCNT)
 I '$D(DGPFA("NARR",1,0)) D  Q
 . S DGLINE=DGLINE+1
 . D SET(DGARY,DGLINE,"No Narrative Text",1,,,.DGCNT)
 S (DGSUB,DGTMP)=""
 F  S DGSUB=$O(DGPFA("NARR",DGSUB)) Q:'DGSUB  D
 . S DGTMP=$G(DGPFA("NARR",DGSUB,0))
 . S DGLINE=DGLINE+1
 . D SET(DGARY,DGLINE,DGTMP,1,,,.DGCNT)
 ;
 ;set blank lines
 S DGLINE=DGLINE+2
 D SET(DGARY,DGLINE,"",1,,,.DGCNT)
 ;
 Q
 ;
 ;
HIST(DGARY,DGPFAH,DGLINE,DGHISCNT,DGCNT) ;format history details
 ;This procedure will build and format the lines of FLAG ASSIGNMENT
 ;HISTORY details.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;   DGPFAH - assignment history array, pass by reference
 ;   DGLINE - line counter, pass by reference
 ; DGHISCNT - counter of history record
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 ;temporary variables used
 N DGTMP
 N DGSUB
 ;
 ;set blank line
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"",1,,,.DGCNT)
 ;
 ;add an additional blank line except on the first history
 I DGHISCNT>1 D
 . S DGLINE=DGLINE+1
 . D SET(DGARY,DGLINE,"",1,,,.DGCNT)
 ;
 ;set action
 S DGLINE=DGLINE+1
 S DGTMP=DGHISCNT_"."
 D SET(DGARY,DGLINE,DGTMP,1,IORVON,IORVOFF,.DGCNT)
 D SET(DGARY,DGLINE,"Action: "_$$EXTERNAL^DILFD(26.14,.03,"F",$G(DGPFAH("ACTION"))),10,IORVON,IORVOFF,.DGCNT)
 ;
 ;set assignment date
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Action Date: "_$$FDTTM^VALM1($P($G(DGPFAH("ASSIGNDT")),U)),5,,,.DGCNT)
 ;
 ;set history comments
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Action Comments:",1,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"----------------",1,,,.DGCNT)
 I $D(DGPFAH("COMMENT",1,0)) D
 . S (DGSUB,DGTMP)=""
 . F  S DGSUB=$O(DGPFAH("COMMENT",DGSUB)) Q:'DGSUB  D
 .. S DGTMP=$G(DGPFAH("COMMENT",DGSUB,0))
 .. S DGLINE=DGLINE+1
 .. D SET(DGARY,DGLINE,DGTMP,1,,,.DGCNT)
 E  D
 . S DGLINE=DGLINE+1
 . D SET(DGARY,DGLINE,"No Comments on file.",1,,,.DGCNT)
 ;
 Q
 ;
 ;
SET(DGARY,DGLINE,DGTEXT,DGCOL,DGON,DGOFF,DGCNT) ;This procedure will set the lines of flag assignment details into the LM display area.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;   DGLINE - line number
 ;   DGTEXT - text
 ;    DGCOL - starting column
 ;     DGON - highlighting on
 ;    DGOFF - highlighting off
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 N DGX  ;temp variable for line of display text
 ;
 S DGCNT=DGLINE
 S DGX=$S($D(^TMP(DGARY,$J,DGLINE,0)):^(0),1:"")
 S ^TMP(DGARY,$J,DGLINE,0)=$$SETSTR^VALM1(DGTEXT,DGX,DGCOL,$L(DGTEXT))
 D:$G(DGON)]""!($G(DGOFF)]"") CNTRL^VALM10(DGLINE,DGCOL,$L(DGTEXT),$G(DGON),$G(DGOFF))
 Q
