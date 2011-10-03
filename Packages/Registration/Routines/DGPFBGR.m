DGPFBGR ;ALB/RPM - PRF BACKGROUND PROCESSING DRIVER ; 6/3/05 12:25pm
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
 ;
 Q   ;no direct entry
 ;
EN ;entry point for PRF background processing
 ;
 D NOTIFY($$NOW^XLFDT())  ;send review notification
 D RUNQRY^DGPFHLRT        ;run query for incomplete HL7 event status
 Q
 ;
NOTIFY(DGDATE) ;Send notification message for pending Patient Record Flag
 ;Assignment reviews.
 ;
 ;  Input:
 ;    DGDATE - (optional) notification date requested in FM format,
 ;             defaults to now ($$NOW^XLFDT())
 ;
 ;  Output:
 ;    none
 ;
 N DGAIEN    ;pointer to PRF ASSIGNMENT (#26.13) file
 N DGDFN     ;pointer to patient in PATIENT (#2) file
 N DGDEM     ;patient demographics array
 N DGDOB     ;patient date of birth
 N DGFLG     ;flag data array
 N DGLIST    ;closed root array list of patient IENs in a mail group
 N DGMSGTXT  ;closed root of mail message text
 N DGNAME    ;patient name
 N DGNDT     ;notification date
 N DGPFA     ;assignment data array
 N DGMGROUP  ;review mail group
 N DGSSN     ;patient social security number
 ;
 S DGLIST=$NA(^TMP("DGPFREV",$J))
 K @DGLIST
 ;
 S DGMSGTXT=$NA(^TMP("DGPFMSG",$J))
 K @DGMSGTXT
 ;
 I '+$G(DGDATE) S DGDATE=$$NOW^XLFDT()
 ;
 S DGNDT=0
 F  S DGNDT=$O(^DGPF(26.13,"ANDAT",DGNDT)) Q:('DGNDT!(DGNDT>DGDATE))  D
 . S DGAIEN=0
 . F  S DGAIEN=$O(^DGPF(26.13,"ANDAT",DGNDT,DGAIEN)) Q:'DGAIEN  D
 . . N DGPFA,DGDEM,DGFLG
 . . ;
 . . ;get assignment record
 . . Q:'$$GETASGN^DGPFAA(DGAIEN,.DGPFA)
 . . ;
 . . ;retrieve pointer to patient record in PATIENT (#2) file
 . . S DGDFN=$P($G(DGPFA("DFN")),U,1)
 . . Q:'DGDFN
 . . ;
 . . ;retrieve patient demographics
 . . Q:'$$GETPAT^DGPFUT2(DGDFN,.DGDEM)
 . . S DGNAME=$G(DGDEM("NAME"))
 . . S DGSSN=$G(DGDEM("SSN"))
 . . S DGDOB=$G(DGDEM("DOB"))
 . . ;
 . . ;retrieve review date
 . . S DGREVDT=$P($G(DGPFA("REVIEWDT")),U,1)
 . . Q:'DGREVDT
 . . ;
 . . ;get flag review criteria, notice days and review mail group
 . . Q:'$$GETFLAG^DGPFUT1($P($G(DGPFA("FLAG")),U,1),.DGFLG)
 . . ;
 . . ;retrieve review mail group
 . . S DGMGROUP=$P($G(DGFLG("REVGRP")),U,2)
 . . Q:(DGMGROUP']"")
 . . ;
 . . ;build list
 . . S @DGLIST@(DGMGROUP,DGAIEN)=DGNAME_U_DGSSN_U_DGDOB_U_$P(DGPFA("FLAG"),U,2)_U_DGREVDT
 . . ;
 . . ;remove notification index entry
 . . K ^DGPF(26.13,"ANDAT",DGNDT,DGAIEN)
 ;
 ;build and send the message for each mail group
 S DGMGROUP=""
 F  S DGMGROUP=$O(@DGLIST@(DGMGROUP)) Q:(DGMGROUP="")  D
 . I $$BLDMSG(DGMGROUP,DGLIST,DGMSGTXT) D SEND(DGMGROUP,DGMSGTXT)
 . K @DGMSGTXT
 ;
 ;cleanup
 K @DGLIST
 ;
 Q
 ;
BLDMSG(DGMGROUP,DGLIST,DGXMTXT) ;build MailMan message array
 ;
 ;  Input:
 ;   DGMGROUP - mail group name
 ;     DGLIST - closed root array of assignment IENs by mail group
 ;
 ;  Output:
 ;    DGXMTXT - array of MailMan text lines
 ;
 N DGDOB    ;formatted date of birth
 N DGFLAG   ;formatted flag name
 N DGLIN    ;line counter
 N DGNAME   ;formatted patient name
 N DGMAX    ;maximum line length
 N DGREC    ;contents of a single node of the DGLIST array
 N DGREVDT  ;review date
 N DGSITE   ;results of VASITE call
 N DGSSN    ;formatted social security number
 ;
 S DGLIN=0
 S DGMAX=78
 S DGSITE=$$SITE^VASITE()
 D ADDLINE("",0,DGMAX,.DGLIN,DGXMTXT)
 D ADDLINE($$CJ^XLFSTR("* * * *  PRF ASSIGNMENT REVIEW NOTIFICATION  * * * *",78," "),0,DGMAX,.DGLIN,DGXMTXT)
 D ADDLINE("",0,DGMAX,.DGLIN,DGXMTXT)
 D ADDLINE("The following Patient Record Flag Assignments are due for review for continuing appropriateness:",0,DGMAX,.DGLIN,DGXMTXT)
 D ADDLINE("",0,DGMAX,.DGLIN,DGXMTXT)
 D ADDLINE($$LJ^XLFSTR("Patient Name",22," ")_$$LJ^XLFSTR("SSN",11," ")_$$LJ^XLFSTR("DOB",10," ")_$$LJ^XLFSTR("Flag Name",22," ")_"Review Date",0,DGMAX,.DGLIN,DGXMTXT)
 D ADDLINE($$REPEAT^XLFSTR("-",DGMAX),0,DGMAX,.DGLIN,DGXMTXT)
 ;
 S DGAIEN=0,DGCNT=0
 F  S DGAIEN=$O(@DGLIST@(DGMGROUP,DGAIEN)) Q:'DGAIEN  D
 . ;record description: patient_name^SSN^DOB^flag_name^review_date
 . S DGREC=@DGLIST@(DGMGROUP,DGAIEN)
 . ;
 . ;format the fields
 . S DGNAME=$$LJ^XLFSTR($E($P(DGREC,U,1),1,20),22," ")
 . S DGSSN=$$LJ^XLFSTR($P(DGREC,U,2),11," ")
 . S DGDOB=$$LJ^XLFSTR($$FMTE^XLFDT($P(DGREC,U,3),"5D"),10," ")
 . S DGFLAG=$$LJ^XLFSTR($E($P(DGREC,U,4),1,20),22," ")
 . S DGREVDT=$$FMTE^XLFDT($P(DGREC,U,5),"5D")
 . ;
 . ;add the line
 . D ADDLINE(DGNAME_DGSSN_DGDOB_DGFLAG_DGREVDT,0,DGMAX,.DGLIN,DGXMTXT)
 . D ADDLINE("",0,DGMAX,.DGLIN,DGXMTXT)
 . ;
 . ;success
 . S DGCNT=DGCNT+1
 ;
 Q DGCNT
 ;
ADDLINE(DGTEXT,DGINDENT,DGMAXLEN,DGCNT,DGXMTXT) ;add text line to message array
 ;
 ;  Input:
 ;     DGTEXT - text string
 ;   DGINDENT - number of spaces to insert at start of line
 ;   DGMAXLEN - maximum desired line length (default: 60)
 ;      DGCNT - line number passed by reference
 ;
 ;  Output:
 ;    DGXMTXT - array of text strings
 ;
 N DGAVAIL  ;available space for text
 N DGLINE   ;truncated text
 N DGLOC    ;location of space character
 N DGPAD    ;space indent
 ;
 S DGTEXT=$G(DGTEXT)
 S DGINDENT=+$G(DGINDENT)
 S DGMAXLEN=+$G(DGMAXLEN)
 S:'DGMAXLEN DGMAXLEN=60
 I DGINDENT>(DGMAXLEN-1) S DGINDENT=0
 S DGCNT=$G(DGCNT,0)  ;default to 0
 ;
 S DGPAD=$$REPEAT^XLFSTR(" ",DGINDENT)
 ;
 ;determine availaible space for text
 S DGAVAIL=(DGMAXLEN-DGINDENT)
 F  D  Q:('$L(DGTEXT))
 . ;
 . ;find potential line break
 . S DGLOC=$L($E(DGTEXT,1,DGAVAIL)," ")
 . ;
 . ;break a line that is too long when it has potential line breaks
 . I $L(DGTEXT)>DGAVAIL,DGLOC D
 . . S DGLINE=$P(DGTEXT," ",1,$S(DGLOC>1:DGLOC-1,1:1))
 . . S DGTEXT=$P(DGTEXT," ",$S(DGLOC>1:DGLOC,1:DGLOC+1),$L(DGTEXT," "))
 . E  D
 . . S DGLINE=DGTEXT,DGTEXT=""
 . ;
 . S DGCNT=DGCNT+1
 . S @DGXMTXT@(DGCNT)=DGPAD_DGLINE
 Q
 ;
SEND(DGGROUP,DGXMTXT) ;send the MailMan message
 ;
 ;  Input:
 ;    DGGROUP - mail group name
 ;    DGXMTXT - name of message text array in closed format
 ;
 ;  Output:
 ;    none
 ;
 N DIFROM  ;protect FM package
 N XMDUZ   ;sender
 N XMSUB   ;message subject
 N XMTEXT  ;name of message text array in open format
 N XMY     ;recipient array
 N XMZ     ;returned message number
 ;
 S XMDUZ="Patient Record Flag Module"
 S XMSUB="PRF ASSIGNMENT REVIEW NOTIFICATION"
 S XMTEXT=$$OREF^DILF(DGXMTXT)
 S XMY("G."_DGGROUP)=""
 D ^XMD
 Q
