DGROMAIL ;DJH/AMA - ROM HL7 MAIL MESSAGE PROCESSING ; 28 Apr 2004  4:16 PM
 ;;5.3;Registration;**533,572**;Aug 13, 1993
 ;
 Q
 ;
MPIMAIL(DGQRY) ;LOG MPI EXCEPTION FROM LAST SITE TREATED
 ;The ICN sent from the MPI does not match the patient at the Last Site
 ;Treated, even though the site was on the Treatment Facility List
 ;received from the MPI.  Send the MPI an exception to this effect.
 ;CALLED FROM RCVQRY^DGROHLR
 ;
 ; Input:
 ;   DGQRY - Patient lookup components array
 N FACNAM,LINE,TEXT,DGXMTXT,MPIFL,SITE,HLMID,LST,QS
 S HLMID=$G(HL("MID"))
 S LST=+$G(HL("RFN"))
 S QS=+$G(HL("SAF"))
 ;
 S FACNAM="",LINE="",MPIFL=1,HL("MID")=""
 I '$G(DGQRY("RCVFAC")) D
 . S SITE=$$SITE^VASITE
 . S DGQRY("RCVFAC")=$P(SITE,U,3)
 . S QS=DGQRY("RCVAC")
 ;
 S RGEXC=219
 S TEXT="Unable to find ICN # "_DGQRY("ICN")_" at "_LST_" for a Register Once call from Station # "_QS
 D EXC^RGHLLOG(RGEXC,TEXT)
 S HL("MID")=HLMID
 Q
 ;
DODMAIL(DGDATA,DFN,LSTDFN) ;SEND MAIL MESSAGE TO DATE OF DEATH MAIL GROUP
 ;Date of Death data has been received from the Last Site Treated,
 ;so notify the appropriate people that this person is listed as
 ;deceased at the LST.
 ;  CALLED FROM DOD^DGRODEBR
 ;
 ; Input:
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 ;   LSTDFN - Pointer to the patient data from the LST, in DGDATA
 N U,LINE,LNCNT,TEXT,DGXMTXT,MPIFL
 ;
 S U="^",LINE="",LNCNT=7,MPIFL=0
 S LINE(1)="* * * *  DG REGISTER ONCE NOTIFICATION  * * * *"
 S LINE(2)="Death Information has been received for the following patient:"
 S LINE(3)="Patient Name: "_$$GET1^DIQ(2,DFN,.01)
 S LINE(4)="Social Security Number: "_$$GET1^DIQ(2,DFN,.09)
 S LINE(5)="Date Of Birth: "_$$FMTE^XLFDT($$GET1^DIQ(2,DFN,.03,"I"))
 S LINE(6)="Integrated Control #: "_$$GET1^DIQ(2,DFN,991.01)
 ;
 S LINE(LNCNT)="Death data received:"
 I $D(@DGDATA@(2,LSTDFN_",",.351)) D
 . S LNCNT=LNCNT+1
 . ;* Format External date received per XLFDT for output consistency
 . K X,%DT,Y ;* DG*5.3*572
 . S X=@DGDATA@(2,LSTDFN_",",.351,"E")
 . S %DT="TSN"
 . D ^%DT
 . S LINE(LNCNT)="   Date of Death: "_$$FMTE^XLFDT(Y)
 ;
 I $D(@DGDATA@(2,LSTDFN_",",.353)) D
 . N DGSET,DGSRCE
 . ;* External DOD Source returned from LST
 . S DGSRCE=@DGDATA@(2,LSTDFN_",",.353,"E") ;* DG*5.3*572
 . S LNCNT=LNCNT+1
 . S LINE(LNCNT)="   Source Of Notification of D.o.D.: "_DGSRCE
 ;
 I $D(@DGDATA@(2,LSTDFN_",",.352)) D
 . S LNCNT=LNCNT+1
 . S LINE(LNCNT)="   D.o.D. Entered By: "_@DGDATA@(2,LSTDFN_",",.352,"E")
 ;
 I $D(@DGDATA@(2,LSTDFN_",",.354)) D
 . S LNCNT=LNCNT+1
 . ;* Format External date received per XLFDT for output consistency
 . K X,%DT,Y ;* DG*5.3*572
 . S X=@DGDATA@(2,LSTDFN_",",.354,"E")
 . S %DT="TSN"
 . D ^%DT
 . S LINE(LNCNT)="   D.o.D. Last Updated: "_$$FMTE^XLFDT(Y)
 ;
 ;DG*5.3*572 -- added field .355
 I $D(@DGDATA@(2,LSTDFN_",",.355)) D
 . S LNCNT=LNCNT+1
 . S LINE(LNCNT)="   D.o.D. Last Edited By: "_@DGDATA@(2,LSTDFN_",",.355,"E")
 ;
 S DGXMTXT=$NA(TEXT)
 D BLDMSG(.LINE,DGXMTXT)
 D SNDMSG(DGXMTXT,"DG REGISTER ONCE",MPIFL)
 K X,%DT,Y ;* DG*5.3*572
 Q
 ;
SPMAIL(DFN) ;SEND MAIL MESSAGE REGARDING A SENSITIVE PATIENT
 ;Sensitive Patient data has been received from the Last Site Treated,
 ;so notify the appropriate people that this person is listed as
 ;Sensitive at the LST.
 ;  CALLED FROM SP^DGRODEBR
 ;
 ; Input:
 ;   DGDATA - Data element array from LST, ^TMP("DGROFDA",$J)
 ;      DFN - Pointer to the PATIENT (#2) file
 N U,LINE,TEXT,DGXMTXT,MPIFL
 ;
 S U="^",LINE="",MPIFL=0
 S LINE(1)="* * * *  DG REGISTER ONCE NOTIFICATION  * * * *"
 S LINE(2)="Sensitive Patient Information has been received for the following patient:"
 S LINE(3)="Patient Name: "_$$GET1^DIQ(2,DFN,.01)
 S LINE(4)="Social Security Number: "_$$GET1^DIQ(2,DFN,.09)
 S LINE(5)="Date Of Birth: "_$$FMTE^XLFDT($$GET1^DIQ(2,DFN,.03,"I"))
 S LINE(6)="Integrated Control #: "_$$GET1^DIQ(2,DFN,991.01)
 ;
 S DGXMTXT=$NA(TEXT)
 D BLDMSG(.LINE,DGXMTXT)
 D SNDMSG(DGXMTXT,"DG REGISTER ONCE",MPIFL)
 Q
 ;
BLDMSG(LINE,DGXMTXT) ;build MailMan message array
 ;
 ;  Input:
 ;    LINE - message array
 ;
 ;  Output:
 ;    DGXMTXT - array of MailMan text lines
 ;
 N DGLIN   ;line counter
 N DGMAX   ;maximum line length
 N DGCNT   ;counter
 ;
 S DGLIN=0
 S DGMAX=65
 ;
 S DGCNT=0 F  S DGCNT=$O(LINE(DGCNT)) Q:'DGCNT  D
 . D ADDLINE("",0,DGMAX,.DGLIN,DGXMTXT)
 . D ADDLINE(LINE(DGCNT),0,DGMAX,.DGLIN,DGXMTXT)
 ;
 D ADDLINE("",0,DGMAX,.DGLIN,DGXMTXT)
 Q
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
 ;determine available space for text
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
SNDMSG(DGXMTXT,MAILGRP,MPIFL) ;send the MailMan message
 ;
 ;  Input:
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
 S XMDUZ="DG Register Once Module"
 S XMSUB="DG REGISTER ONCE MESSAGE"
 S XMTEXT=$$OREF^DILF(DGXMTXT)
 S XMY("G."_MAILGRP)=""
 I '$G(MPIFL) S XMY(DUZ)=""
 D ^XMD
 Q
