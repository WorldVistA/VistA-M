DGQPT2 ; HIRMFO/DAD-Patient Look-Up Security Check and Notification ;1/31/97  07:57
 ;;5.3;Registration;**447**;Aug 13, 1993
 ;
EN1(DGDFN) ;
 ; Sensitive Patient record check
 ;  Input
 ;   DGDFN = Pointer to the Patient file (#2)
 ;  Output
 ;   0 - Patient record IS NOT sensitive
 ;   1 - Patient record IS sensitive
 ;
 Q ''$$GET1^DIQ(38.1,+$G(DGDFN),2,"I")
 ;
EN2(DGDFN) ;
 ; Update DG Security Log file (#38.1) and sends
 ; the 'Restricted Patient Accessed' bulletin to the
 ; mailgroup specified in the 'Sensitive Rec Accessed
 ; Group' field (43,509)
 ;  Input
 ;   DGDFN = Pointer to the Patient file (#2)
 ;  Output
 ;   None
 ;
 I $S($G(DGDFN)'>0:1,$G(DUZ)'>0:1,1:'$$EN1(DGDFN)) Q
 ;
 N DFN,DG1,DGA1,DGT,DGXFR0,DGINPT,DGINVNOW,DGMAILGR,DGNOW,DGOPT
 N X,XQOPT
 ;
 D OP^XQCHK
 S DGOPT=$S(+XQOPT<0:"^UNKNOWN",1:$P(XQOPT,U)_U_$P(XQOPT,U,2))
 S DGNOW=$E($$NOW^XLFDT,1,12)
 S DFN=DGDFN,DGT=DGNOW D EN^DGPMSTAT S DGINPT=$S(DG1:"y",1:"n")
 S DGMAILGR=$$GET1^DIQ(43,1,509)
 ;
 I DGINPT="n",'$D(^XUSEC("DG SENSITIVITY",DUZ)),DGMAILGR]"" D
 . N DGTEXT,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 . S XMSUB="RESTRICTED PATIENT RECORD ACCESSED"
 . S XMY("G."_DGMAILGR)=""
 . S XMTEXT="DGTEXT("
 . S XMDUZ=DUZ
 . S XMCHAN=1
 . S DGTEXT(1)="The following sensitive patient record has been accessed:"
 . S DGTEXT(2)=""
 . S DGTEXT(3)="  Patient Name: "_$$GET1^DIQ(2,DGDFN,.01)
 . S DGTEXT(4)="  Soc Sec Num : "_$$GET1^DIQ(2,DGDFN,.09)
 . S DGTEXT(5)="  Option Used : "_$P(DGOPT,U,2)
 . D ^XMD
 . Q
 ;
 F  L +^DGSL(38.1,DGDFN):1 Q:$T
 ;
 I '$D(^DGSL(38.1,DGDFN)) D
 . N DGFDA,DGIEN,DGMSG
 . S DGFDA(38.1,"+1,",.01)=DGDFN
 . S DGIEN(1)=DGDFN
 . D UPDATE^DIE("","DGFDA","DGIEN","DGMSG")
 . Q
 F  S DGINVNOW=9999999.9999-DGNOW Q:'$D(^DGSL(38.1,DGDFN,"D",DGINVNOW))  S DGNOW=DGNOW+.00001
 N DGFDA,DGIEN,DGMSG
 S DGFDA(38.11,"+1,"_DGDFN_",",.01)=DGNOW
 S DGFDA(38.11,"+1,"_DGDFN_",",2)=DUZ
 S DGFDA(38.11,"+1,"_DGDFN_",",3)=$P(DGOPT,U,2)
 S DGFDA(38.11,"+1,"_DGDFN_",",4)=DGINPT
 S DGIEN(1)=DGINVNOW
 D UPDATE^DIE("","DGFDA","DGIEN","DGMSG")
 ;
 L -^DGSL(38.1,DGDFN)
 ;
 S X="MPRCHK" X ^%ZOSF("TEST") I $T D EN^MPRCHK(DGDFN)
 ;
 Q
 ;
CWAD(DFN) ;
 ; Crisis notes, clinical Warnings, Allergies, advance Directives
 ;  Input:
 ;   DFN = A Patient file (#2) IEN
 ;  Output:
 ;   A string of 0-4 nonrepeating characters consisting
 ;   of the letters C,W,A,D.  The string will be returned
 ;   with the letters in the order shown.
 ;
 I $G(DFN)'>0 Q ""
 N ACRN,CTR,ORLST,MSG
 D ENCOVER^TIUPP3(DFN)
 ; DGLST initialized with lower case 'cwad' to generate
 ; correct ordering of letters.  Lower case letter indicates
 ; that the patient does not have that item.  Upper case
 ; indicates that the patient has the item.
 S DGLST="cwad"
 S CTR=0
 F  S CTR=$O(^TMP("TIUPPCV",$J,CTR)) Q:(CTR'>0)!(DGLST?4U)  D
 . S ACRN=$P($G(^TMP("TIUPPCV",$J,CTR)),U,2)
 . ; If patient has item, convert item to uppercase
 . I "^C^W^A^D^"[(U_ACRN_U) S DGLST=$TR(DGLST,$C($A(ACRN)+32),ACRN)
 . Q
 K ^TMP("TIUPPCV",$J)
 ; Remove any remaining lower case items
 S DGLST=$TR(DGLST,"cwad")
 Q DGLST
