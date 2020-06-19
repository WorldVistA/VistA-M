DGOTHMST ;SLC/MKN - OTH PROCESSING FOLLOWING MST SCREENING ;06/21/2019
 ;;5.3;Registration;**977**;Aug 13, 1993;Build 177
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;OTH processing following MST Screening
 ;
MSTCHNG(DA) ;
 ;This API is called when MST Screening changes and, if the previous status was "Y" 
 ;and the new status is either "N" or "D", a MailMan message is sent to the DGEN ELIGIBILITY ALERT group 
 ;
 ;Input Parameter:
 ;  DA = IEN of entry in file #29.11
 ;
 N DGDFN,DGPREST,DGSSN,DGSTAT,IEN2911
 S DGDFN=$$GET1^DIQ(29.11,DA_",",2,"I") Q:'DGDFN
 S DGSTAT=$$GET1^DIQ(29.11,DA_",",3,"I")
 I DGSTAT="Y" D MSTPROC(DGDFN) Q
 S IEN2911=$O(^DGMS(29.11,"C",DGDFN,DA),-1) Q:'IEN2911
 S DGPREST=$$GET1^DIQ(29.11,IEN2911_",",3,"I") Q:DGPREST'="Y"
 S DGSSN=$$GET1^DIQ(2,DGDFN_",",.09)
 S DGMSG(1)="Eligibility personnel should re-evaluate this Patient's"
 S DGMSG(2)="Expanded MH Care Type as their MST Screening CR has been"
 S DGMSG(3)="changed from positive to negative/decline."
 S DGMSG(4)=" "
 S DGMSG(5)="Patient Name: "_$$GET1^DIQ(2,DGDFN_",",.01)
 S DGMSG(6)=" "
 S DGMSG(7)="SSN: "_$E(DGSSN,$L(DGSSN)-3,$L(DGSSN))
 S DGMSG(8)=" "
 S DGMSG(9)="DOB: "_$$GET1^DIQ(2,DGDFN_",",.03)
 S DGMSG(10)=" "
 S DGMSG(11)="SEX: "_$$GET1^DIQ(2,DGDFN_",",.02)
 S DGMSG(12)=" "
 S DGMSG(13)="VPID: "_$$GET1^DIQ(2,DGDFN_",",991.01)
 S DGMSG(14)=" "
 S DGMSG(15)="DFN: "_DGDFN
 S DGMSG(16)=" "
 S DGMSG(17)="STATION NUMBER: "_$P($$SITE^VASITE(),U,3)
 S DGMSG(18)=" "
 D SENDMSG(.DGMSG,"Eligibility re-evaluation needed.")
 Q
 ;
MSTPROC(DGDFN) ;
 ;If the MST status is "Y", and the patient is OTH-90, a MailMan message is sent to the DGEN ELIGIBILITY ALERT group
 ;
 ;Input parameters:
 ; DGDFN = IEN of patient in file #2
 ;
 N DGMSG,DGOTH,DGSSN,Z
 ; check if the patient is OTH-90, if not then quit
 ; if updated by Z11 HL7 message, patient could be OTH-EXT already, but file 33 has not been updated yet
 ; so, check if latest elig, change in 33.02 still says OTH-90 while field 2/.5501 is already OTH-EXT
 S DGOTH=$$GETEXPMH^DGOTHD(DGDFN) Q:DGOTH=""
 S Z=$$LASTELIG^DGOTHEL(DGDFN)
 S DGOTH=$$ISOTH^DGOTHD(DGOTH) Q:'DGOTH  ; 1 = OTH-EXT, 2 = OTH-90
 I DGOTH=1,Z'=0,$$GET1^DIQ(33.02,$P(Z,U,2)_","_$P(Z,U)_",",.03,"I")'="OTH-90" Q
 S DGMSG(1)="Patient Name: "_$$GET1^DIQ(2,DGDFN_",",.01)
 S DGMSG(2)=" "
 S DGMSG(3)="DOB: "_$$GET1^DIQ(2,DGDFN_",",.03)
 S DGMSG(4)=" "
 S DGMSG(5)="SEX: "_$$GET1^DIQ(2,DGDFN_",",.02)
 S DGMSG(6)=" "
 S DGMSG(7)="VPID: "_$$GET1^DIQ(2,DGDFN_",",991.1)
 S DGMSG(8)=" "
 S DGMSG(9)="DFN: "_DGDFN
 S DGMSG(10)=" "
 S DGMSG(11)="STATION NUMBER: "_$P($$SITE^VASITE(),U,3)
 S DGMSG(12)=" "
 S DGMSG(13)=" "
 S DGMSG(14)="This Veteran's EXPANDED MH CARE TYPE has been"
 S DGMSG(15)="automatically changed from OTH-90 to OTH-EXT because"
 S DGMSG(16)="their MST Clinical Reminder Screening resulted in a"
 S DGMSG(17)="Positive response. EXPANDED MH CARE TYPE has been changed"
 S DGMSG(18)=" "
 S DGMSG(19)="Note: If 'STATUS ENTERED BY' field is blank on Registration Eligibility"
 S DGMSG(20)="      Verification Screen #11, it is due to Provider Name not being"
 S DGMSG(21)="      available when the MST Screening CR was processed in CPRS."
 D SENDMSG(.DGMSG,"VistA Registration Information has been updated automatically")
 Q
 ;
SENDMSG(DGMSG,XMSUB) ;Send MailMan message to DGEN ELIGIBILITY ALERT group
 N XMDUZ,XMTEXT,XMY
 S XMDUZ="POSTMASTER",XMTEXT="DGMSG(",XMY("G.DGEN ELIGIBILITY ALERT@"_^XMB("NETNAME"))=""
 D ^XMD ; Returns: XMZ(if no error),XMMG(if error)
 Q
 ;
GETFREQ(DFN) ;
 ;This Extrinsic API is called from PXRM processing where frequency of the clinical reminder
 ;is determined. If the patient is OTH, the API will override the frequency computed
 ;by the Clinical Reminder application during patient cohort logic, if MST Screening
 ;has taken place, and the patient declined to answer.
 ;
 ;Input parameter:
 ; DGDFN = IEN of patient in file #2
 ;
 N DA,DGDFN,DGSTAT,EXPMHCT
 Q:DFN="" ""
 S EXPMHCT=$$GETEXPMH^DGOTHD(DFN) Q:EXPMHCT="" ""
 Q:'$$ISOTH^DGOTHD(EXPMHCT) ""
 ;Patient is OTH
 ;Check last MST Screening entry in the MST HISTORY file (#29.11)
 S DA=$O(^DGMS(29.11,"C",DFN,""),-1) Q:DA="" ""
 S DGSTAT=$$GET1^DIQ(29.11,DA_",",3,"I") Q:DGSTAT'="D" ""
 Q "1Y"
 ;
UPDELIG ; update eligibility fields in file 2 when MST status changes
 ; called from "AD" index in file 29.11
 ; X() array is defined in the index
 ;
 N DGERR,DGFDA,DGOTH,IEN33,IEN3302,IENS,Z
 ;check if the patient is OTH-90, if not then quit
 I +X(2)'>0 Q  ; no valid DFN
 I X(3)'="Y" Q  ; quit if MST status is not "yes"
 S IENS=X(2)_","
 S DGOTH=$$ISOTH^DGOTHD($$GETEXPMH^DGOTHD(X(2))) Q:'DGOTH  ; 1 = OTH-EXT, 2 = OTH-90
 S Z=$$LASTELIG^DGOTHEL(X(2)),IEN33=+$P(Z,U),IEN3302=+$P(Z,U,2) I IEN33=0!(IEN3302=0) Q
 ; if OTH-EXT and it's the first eligibility change (not an OTH-90/OTH-EXT flip), bail out
 I DGOTH=1,$O(^DGOTH(33,IEN33,2,IEN3302),-1)=0 Q
 S DGFDA(2,IENS,.3616)=X(4) D FILE^DIE(,"DGFDA","DGERR") K DGFDA Q:$D(DGERR)
 ; if OTH-EXT and last eligibility in 33.02 is not OTH-90, then we just flipped from OTH-90 to OTH-EXT - bail out
 I DGOTH=1,$$GET1^DIQ(33.02,IEN3302_","_IEN33_",",.03,"I")'="OTH-90" Q
 ; if provider = postmaster, then this update came from incoming Z11 message - leave eligibility fields as-is.
 I X(4)=".5" Q
 S DGFDA(2,IENS,.3611)="V"
 S DGFDA(2,IENS,.3612)=$P(X(1),".")
 ; have to set 2/.3616 a second time here due to the trigger in field 2/.3611 populzating 2/.3616 with DUZ
 S DGFDA(2,IENS,.3616)=X(4) D FILE^DIE(,"DGFDA","DGERR")
 S DGFDA(2,IENS,.5501)="OTH-EXT"
 D FILE^DIE(,"DGFDA","DGERR") I $D(DGERR) Q
 D EVENT^IVMPLOG(X(2)) ;Update IVM PATIENT file (#301.5) to send HL7 message to ES
 D CRTEELCH^DGOTHEL(X(2),$$HASENTRY^DGOTHD2(X(2)),$$NOW^XLFDT())
 Q
