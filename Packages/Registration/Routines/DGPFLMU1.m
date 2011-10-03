DGPFLMU1 ;ALB/KCL - PRF DISPLAY FLAG DETAIL LM UTILITIES CONT ; 10/12/05 10:26am
 ;;5.3;Registration;**425,554,650**;Aug 13, 1993;Build 3
 ;
 ;no direct entry
 QUIT
 ;
EN(DGARY,DGIEN,DGDFN,DGCNT) ;Entry point to build flag assignment detail list area.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;    DGIEN - ien of PATIENT ASSIGNMENT (#26.13) file
 ;    DGDFN - ien of PATIENT (#2) file
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 N DGHIEN   ;assignment history ien
 N DGHIENS  ;contains assignment history ien's 
 N DGHISCNT ;count of history records
 N DGLINE   ;line counter
 N DGPFA    ;assignment array
 N DGPFAH   ;assignment history array
 N DGPFF    ;flag array
 N DGSUB    ;subscript of history ien's array
 ;
 ;init variables
 S DGCNT=0
 S (DGLINE,VALMBEG)=1
 K DGPFA
 K DGPFAH
 K DGPFF
 K DGHIENS
 ;
 Q:'$G(DGIEN)
 ;
 ;get assignment into DGPFA array
 Q:'$$GETASGN^DGPFAA(DGIEN,.DGPFA)
 S DGPFA("INITASSIGN")=$$GETADT^DGPFAAH(DGIEN)  ;initial assign date
 ;
 ;get most recent assignment history and place in DGPFAH array
 Q:'$$GETHIST^DGPFAAH($$GETLAST^DGPFAAH(DGIEN),.DGPFAH)
 ;
 ;get record flag into DGPFF array
 Q:'$$GETFLAG^DGPFUT1($P($G(DGPFA("FLAG")),U),.DGPFF)
 ;
 ;build Assignment Details area
 D ASGN(DGARY,.DGPFA,.DGPFAH,.DGPFF,.DGLINE,.DGCNT)
 ;
 ;build Assignment History heading
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,$TR($J("",80)," ","="),1,,,.DGCNT)
 D SET(DGARY,DGLINE,"<Assignment History>",30,IORVON,IORVOFF,.DGCNT)
 ;
 ;get all history ien's associated with the assignment
 Q:'$$GETALLDT^DGPFAAH(DGIEN,.DGHIENS)
 ;
 ;reverse loop through each assignment history ien
 ;and get record into DGPFAH array
 S DGHISCNT=0,DGSUB=9999999.999999
 F  S DGSUB=$O(DGHIENS(DGSUB),-1) Q:DGSUB=""  D
 . S DGHIEN=+$G(DGHIENS(DGSUB))
 . K DGPFAH
 . I $$GETHIST^DGPFAAH(DGHIEN,.DGPFAH) D
 . . ;
 . . ;-history record counter
 . . S DGHISCNT=DGHISCNT+1
 . . ;
 . . ;-build assignment history area
 . . D HIST(DGARY,.DGPFAH,.DGPFA,.DGLINE,DGHISCNT,.DGCNT)
 Q
 ;
 ;
ASGN(DGARY,DGPFA,DGPFAH,DGPFF,DGLINE,DGCNT) ;This procedure will build the lines of FLAG ASSIGNMENT details.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;    DGPFF - flag array, pass by reference
 ;    DGPFA - assignment array, pass by reference
 ;   DGPFAH - assignment history array, pass by reference
 ;   DGLINE - line counter
 ;
 ; Output:
 ;    DGCNT - number of lines in the list, pass by reference
 ;
 ;temporary variables used
 N DGSUB
 N DGTMP
 ;
 ;set flag name
 D SET(DGARY,DGLINE,"Flag Name: "_$P($G(DGPFA("FLAG")),U,2),12,,,.DGCNT)
 ;
 ;set flag type
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Flag Type: "_$P($G(DGPFF("TYPE")),U,2),12,,,.DGCNT)
 ;
 ;set flag category
 S DGLINE=DGLINE+1
 S DGTMP=$S($P($G(DGPFA("FLAG")),U)["26.11":"II (LOCAL)",1:"I (NATIONAL)")
 D SET(DGARY,DGLINE,"Flag Category: "_DGTMP,8,,,.DGCNT)
 ;
 ;set flag assignment status
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Assignment Status: "_$P($G(DGPFA("STATUS")),U,2),4,,,.DGCNT)
 ;
 ;set initial assignment date
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Initial Assignment: "_$$FDTTM^VALM1($P(+$G(DGPFA("INITASSIGN")),U)),3,,,.DGCNT)
 ;
 ;set last review date (do not set if only initial assignment)
 S DGLINE=DGLINE+1
 I (+$G(DGPFAH("ASSIGNDT")))=(+$G(DGPFA("INITASSIGN"))) D
 . S DGTMP="N/A"
 E  S DGTMP=$$FDATE^VALM1(+$G(DGPFAH("ASSIGNDT")))
 D SET(DGARY,DGLINE,"Last Review Date: "_DGTMP,5,,,.DGCNT)
 ;
 ;set next review date
 S DGLINE=DGLINE+1
 S DGTMP=+$G(DGPFA("REVIEWDT"))
 S DGTMP=$S(DGTMP:$$FDATE^VALM1(DGTMP),1:"N/A")
 D SET(DGARY,DGLINE,"Next Review Date: "_DGTMP,5,,,.DGCNT)
 ;
 ;set owner site
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Owner Site: "_$P($G(DGPFA("OWNER")),U,2)_"  "_$$FMTPRNT^DGPFUT1($P($G(DGPFA("OWNER")),U)),11,,,.DGCNT)
 ;
 ;set originating site
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Originating Site: "_$P($G(DGPFA("ORIGSITE")),U,2)_"  "_$$FMTPRNT^DGPFUT1($P($G(DGPFA("ORIGSITE")),U)),5,,,.DGCNT)
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
HIST(DGARY,DGPFAH,DGPFA,DGLINE,DGHISCNT,DGCNT) ;This procedure will build the lines of FLAG ASSIGNMENT HISTORY details.
 ;
 ;  Input:
 ;    DGARY - global array subscript
 ;   DGPFAH - assignment history array, pass by reference
 ;    DGPFA - assignment array, pass by reference
 ;   DGLINE - line counter
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
 D SET(DGARY,DGLINE,"Action: "_$P($G(DGPFAH("ACTION")),U,2),10,IORVON,IORVOFF,.DGCNT)
 ;
 ;set assignment date
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Action Date: "_$$FDTTM^VALM1($P($G(DGPFAH("ASSIGNDT")),U)),5,,,.DGCNT)
 ;
 ;set entered by
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Entered By: "_$P($G(DGPFAH("ENTERBY")),U,2),6,,,.DGCNT)
 ;
 ;set approved by
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Approved By: "_$P($G(DGPFAH("APPRVBY")),U,2),5,,,.DGCNT)
 ;
 ;set progress note linked
 I $D(^DG(40.8,"AD",+$P($G(DGPFA("OWNER")),U))) D
 . Q:+$G(DGPFAH("ACTION"))=5  ;don't display ENTERED IN ERROR action
 . S DGLINE=DGLINE+1
 . D SET(DGARY,DGLINE,"Progress Note: "_$P($G(DGPFAH("TIULINK")),U,2),3,,,.DGCNT)
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
