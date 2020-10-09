DGOTHMST ;SLC/MKN - OTH PROCESSING FOLLOWING MST SCREENING ; 06/21/2019
 ;;5.3;Registration;**977,1016**;Aug 13, 1993;Build 6
 ;
 ;OTH processing following MST Screening
 ;
MSTCHNG(DA) ; DG*5.3*1016
 ;This API is called when MST Screening changes and, if the previous status was "Y" 
 ;and the new status is either "N" or "D", a MailMan message is sent to the DGEN ELIGIBILITY ALERT group 
 ;
 ;Input Parameter:
 ;  DA = IEN of entry in file #29.11
 ;
 N DGDFN,DGPREDTM,DGPREST,DGSSN,IEN2911,IENS,IENS2,PATDATA
 S DGDFN=$$GET1^DIQ(29.11,DA_",",2,"I") Q:'DGDFN
 I $$GET1^DIQ(29.11,DA_",",3,"I")="Y" D MSTPROC(DGDFN) Q  ; current MST status is "YES"
 I '$$ISOTHD^DGOTHD(DGDFN) Q  ; primary eligibility is not Expanded MH Care
 I $$GETEXPMH^DGOTHD(DGDFN)'="OTH-EXT" Q  ; MH care type (2/.5501) is not OTH-EXT
 ; quit if previous MST status is not "YES"
 S IEN2911=$O(^DGMS(29.11,"C",DGDFN,DA),-1) Q:'IEN2911
 S IENS=IEN2911_","
 S DGPREST=$$GET1^DIQ(29.11,IENS,3,"I") Q:DGPREST'="Y"
 ;
 S DGPREDTM=$$GET1^DIQ(29.11,IENS,.01,"I") ; timestamp of the previous MST status
 S IENS2=DGDFN_"," D GETS^DIQ(2,IENS2,".01;.02;.03;.09;.5502;991.01","EI","PATDATA") I '$D(PATDATA) Q
 ; if previous MST status change happened while primary eligibility was Expanded MH Care and last MH care type change was not automatic, quit
 I '$$CHKELIG(DGDFN,DGPREDTM)&'$$CHKADTM(DGDFN,PATDATA(2,IENS2,.5502,"I")) Q
 ;
 S DGSSN=PATDATA(2,IENS2,.09,"E")
 S DGMSG(1)="Eligibility personnel should re-evaluate this Patient's"
 S DGMSG(2)="Expanded MH Care Type as their MST Screening CR has been"
 S DGMSG(3)="changed from positive to negative/decline."
 S DGMSG(4)=" "
 S DGMSG(5)="Patient Name: "_PATDATA(2,IENS2,.01,"E")
 S DGMSG(6)=" "
 S DGMSG(7)="SSN: "_$E(DGSSN,$L(DGSSN)-3,$L(DGSSN))
 S DGMSG(8)=" "
 S DGMSG(9)="DOB: "_PATDATA(2,IENS2,.03,"E")
 S DGMSG(10)=" "
 S DGMSG(11)="SEX: "_PATDATA(2,IENS2,.02,"E")
 S DGMSG(12)=" "
 S DGMSG(13)="VPID: "_PATDATA(2,IENS2,991.01,"E")
 S DGMSG(14)=" "
 S DGMSG(15)="DFN: "_DGDFN
 S DGMSG(16)=" "
 S DGMSG(17)="STATION NUMBER: "_$P($$SITE^VASITE(),U,3)
 S DGMSG(18)=" "
 D SENDMSG(.DGMSG,"Eligibility re-evaluation needed.")
 Q
 ;
CHKADTM(DGDFN,AUTODTM) ; check if last MH care type change was automatic  DG*5.3*1016
 ;
 ; DGDFN - patient's DFN
 ; AUTODTM - timestamp of automatic MH care type change (from 2/.5502)
 ;
 ; returns: 1 if last MH care type change was automatic,
 ;          0 if last MH care type change was not automatic,
 ;          -1 if error was encountered
 ;
 N IEN33,LASTDTM
 I +DGDFN'>0 Q -1   ; invalid DFN
 S IEN33=$O(^DGOTH(33,"B",DGDFN,"")) I 'IEN33 Q -1  ; no entry in file 33
 I 'AUTODTM Q 0  ; no automatic change timestamp
 S LASTDTM=+$O(^DGOTH(33,IEN33,2,"B",""),-1)  ; timestamp of last eligibility change from sub-file 33.02
 I $$FMDIFF^XLFDT(LASTDTM,AUTODTM,2)'=0 Q 0  ; timestamps don't match
 Q 1
 ; 
CHKELIG(DGDFN,MSTDTM) ; check if given MST status change happened while primary eligibility was not Expanded MH Care  DG*5.3*1016
 ;
 ; DGDFN - patient's DFN
 ; MSTDTM - timestamp of the MST status change (from 29.11/.01)
 ;
 ; returns: 1 if MST status change happened while primary eligibility was not Expanded MH Care,
 ;          0 if MST status change happened while primary eligibility was Expanded MH Care,
 ;          -1 if error was encountered
 ;
 N DGDTM,IEN33,IEN3302
 I +DGDFN'>0 Q -1   ; invalid DFN
 I +MSTDTM'>0 Q -1  ; invalid MST timestamp
 S IEN33=+$O(^DGOTH(33,"B",DGDFN,"")) I 'IEN33 Q -1  ; no entry in file 33
 S DGDTM=+$O(^DGOTH(33,IEN33,2,"B",MSTDTM),-1) I 'DGDTM Q 1  ; no prior eligibility change in file 33 = patient was not OTH
 S IEN3302=+$O(^DGOTH(33,IEN33,2,"B",DGDTM,"")) I 'IEN3302 Q 1
 I $$GET1^DIQ(33.02,IEN3302_","_IEN33_",",.02)'="EXPANDED MH CARE NON-ENROLLEE" Q 1  ; prior eligibility change was not OTH
 Q 0
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
 N DGERR,DGFDA,DGNOW,DGOTH,IEN33,IEN3302,IENS,Z
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
 S DGNOW=$$NOW^XLFDT()  ; DG*5.3*1016
 S DGFDA(2,IENS,.3611)="V"
 S DGFDA(2,IENS,.3612)=$P(X(1),".")
 ; have to set 2/.3616 a second time here due to the trigger in field 2/.3611 populating 2/.3616 with DUZ
 S DGFDA(2,IENS,.3616)=X(4) D FILE^DIE(,"DGFDA","DGERR")
 S DGFDA(2,IENS,.5501)="OTH-EXT"
 S DGFDA(2,IENS,.5502)=DGNOW  ; DG*5.3*1016
 D FILE^DIE(,"DGFDA","DGERR") I $D(DGERR) Q
 D EVENT^IVMPLOG(X(2)) ;Update IVM PATIENT file (#301.5) to send HL7 message to ES
 D CRTEELCH^DGOTHEL(X(2),$$HASENTRY^DGOTHD2(X(2)),DGNOW)  ; DG*5.3*1016
 Q
