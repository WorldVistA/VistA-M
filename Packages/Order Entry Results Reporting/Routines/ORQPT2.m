ORQPT2 ; HIRMFO/DAD-Patient Look-Up Security Check and Notification ;1/31/97  07:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
EN1(ORDFN) ;
 ; Sensitive Patient record check
 ;  Input
 ;   ORDFN = Pointer to the Patient file (#2)
 ;  Output
 ;   0 - Patient record IS NOT sensitive
 ;   1 - Patient record IS sensitive
 ;
 Q ''$$GET1^DIQ(38.1,+$G(ORDFN),2,"I")
 ;
EN2(ORDFN) ;
 ; Update DG Security Log file (#38.1) and sends
 ; the 'Restricted Patient Accessed' bulletin to the
 ; mailgroup specified in the 'Sensitive Rec Accessed
 ; Group' field (43,509)
 ;  Input
 ;   ORDFN = Pointer to the Patient file (#2)
 ;  Output
 ;   None
 ;
 I $S($G(ORDFN)'>0:1,$G(DUZ)'>0:1,1:'$$EN1(ORDFN)) Q
 ;
 N DFN,DG1,DGA1,DGT,DGXFR0
 N ORINPT,ORINVNOW,ORMAILGR,ORNOW,OROPT
 N X,XQOPT
 ;
 D OP^XQCHK
 S OROPT=$S(+XQOPT<0:"^UNKNOWN",1:$P(XQOPT,U)_U_$P(XQOPT,U,2))
 S ORNOW=$E($$NOW^XLFDT,1,12)
 S DFN=ORDFN,DGT=ORNOW D EN^DGPMSTAT S ORINPT=$S(DG1:"y",1:"n")
 S ORMAILGR=$$GET1^DIQ(43,1,509)
 ;
 I ORINPT="n",'$D(^XUSEC("DG SENSITIVITY",DUZ)),ORMAILGR]"" D
 . N ORTEXT,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 . S XMSUB="RESTRICTED PATIENT RECORD ACCESSED"
 . S XMY("G."_ORMAILGR)=""
 . S XMTEXT="ORTEXT("
 . S XMDUZ=DUZ
 . S XMCHAN=1
 . S ORTEXT(1)="The following sensitive patient record has been accessed:"
 . S ORTEXT(2)=""
 . S ORTEXT(3)="  Patient Name: "_$$GET1^DIQ(2,ORDFN,.01)
 . S ORTEXT(4)="  Soc Sec Num : "_$$GET1^DIQ(2,ORDFN,.09)
 . S ORTEXT(5)="  Option Used : "_$P(OROPT,U,2)
 . D ^XMD
 . Q
 ;
 F  L +^DGSL(38.1,ORDFN):1 Q:$T
 ;
 I '$D(^DGSL(38.1,ORDFN)) D
 . N ORFDA,ORIEN,ORMSG
 . S ORFDA(38.1,"+1,",.01)=ORDFN
 . S ORIEN(1)=ORDFN
 . D UPDATE^DIE("","ORFDA","ORIEN","ORMSG")
 . Q
 F  S ORINVNOW=9999999.9999-ORNOW Q:'$D(^DGSL(38.1,ORDFN,"D",ORINVNOW))  S ORNOW=ORNOW+.00001
 N ORFDA,ORIEN,ORMSG
 S ORFDA(38.11,"+1,"_ORDFN_",",.01)=ORNOW
 S ORFDA(38.11,"+1,"_ORDFN_",",2)=DUZ
 S ORFDA(38.11,"+1,"_ORDFN_",",3)=$P(OROPT,U,2)
 S ORFDA(38.11,"+1,"_ORDFN_",",4)=ORINPT
 S ORIEN(1)=ORINVNOW
 D UPDATE^DIE("","ORFDA","ORIEN","ORMSG")
 ;
 L -^DGSL(38.1,ORDFN)
 ;
 S X="MPRCHK" X ^%ZOSF("TEST") I $T D EN^MPRCHK(ORDFN)
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
 ; ORLST initialized with lower case 'cwad' to generate
 ; correct ordering of letters.  Lower case letter indicates
 ; that the patient does not have that item.  Upper case
 ; indicates that the patient has the item.
 S ORLST="cwad"
 S CTR=0
 F  S CTR=$O(^TMP("TIUPPCV",$J,CTR)) Q:(CTR'>0)!(ORLST?4U)  D
 . S ACRN=$P($G(^TMP("TIUPPCV",$J,CTR)),U,2)
 . ; If patient has item, convert item to uppercase
 . I "^C^W^A^D^"[(U_ACRN_U) S ORLST=$TR(ORLST,$C($A(ACRN)+32),ACRN)
 . Q
 K ^TMP("TIUPPCV",$J)
 ; Remove any remaining lower case items
 S ORLST=$TR(ORLST,"cwad")
 Q ORLST
