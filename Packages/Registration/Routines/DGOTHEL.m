DGOTHEL ;SLC/MKN - OTHD (OTHER THAN HONORABLE DISCHARGE) ELIGIBILITY CHANGES ;Mar 13, 2019@08:07
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;  ICR#  TYPE  DESCRIPTION
 ;------  ----  -----------
 ;  2056  Sup   GET1^DIQ
 ; 10015  Sup   GETS^DIQ
 ; 10026  Sup   ^DIR
 ;
 ;This API is called by the DG LOAD EDIT SCREEN 7 Input Template after the Primary Eligibility 
 ;has been entered/changed or the Eligibility Factor has been changed to save to the 
 ;ELIGIBILITY CHANGES multiple in file #33
CRTEELCH(DGDFN,DGIEN,DGDT) ;
 ;Input parameters:
 ;  DGDFN   The IEN of the patient in file #2
 ;  DGIEN   If it contains a number, it is the IEN of the entry in file #33
 ;          Otherwise we need to check if there is an entry and use it if necessary
 ;  DGDT    Date of activity
 ;Result:
 ;  0   No entry necessary - no change in Primary Eligibility
 ;  1   An entry was made to subfile #33.02
 ;  -1^Message  The update failed
 ;
 N DGEH,DGEL,DGERR,DGEX,DGFDA,DGIEN33,DGIENS,DGLAST,DGPEX,DGPREEL,DGQUIT,DGREASON,DGX
 ;If DGIEN is null, this call came from the start of XPANDED^DGOTHD1
 S DGIEN33=DGIEN,DGQUIT=0 I 'DGIEN S DGIEN33=$$HASENTRY^DGOTHD2(DGDFN) Q:'DGIEN33 0
 S DGREASON=""
 S DGPEX=$$GET1^DIQ(2,DGDFN_",",.5501,"I")
 ;Check the EXPANDED MH CARE TYPE that was just updated to see if it changed from
 ;  the last entry in #33.02. If it did, we need to make another entry in #33.02.
 S DGPREEL=$$GET1^DIQ(2,DGDFN_",",.361)
 S DGLAST=+$P($G(^DGOTH(33,DGIEN33,2,0)),U,3)
 I DGLAST>0 K DGEH D GETS^DIQ(33.02,DGLAST_","_DGIEN33_",","**","IE","DGEH")
 I DGLAST,DGPREEL'=$G(DGEH(33.02,DGLAST_","_DGIEN33_",",.02,"E")) S DGQUIT=1 Q  ;Only file if Primary Eligibility is same
 I DGLAST,DGPEX=$G(DGEH(33.02,DGLAST_","_DGIEN33_",",.03,"I")) S DGQUIT=1 Q  ;Only file if Expanded MH Care code changed
 S DGREASON=$$RSN4CHG(DGIEN33)
 Q:DGQUIT 0
 S DGERR=0 I DGIEN33 D
 .S DGIENS=DGIEN33_"," D
 ..;If last entry was missing the EXPANDED MH CARE TYPE, update that entry
 ..I DGLAST,$G(DGEH(33.02,DGLAST_","_DGIEN33_",",.03,"I"))="" S DGIENS=DGLAST_","_DGIENS
 ..E  S DGIENS="+1,"_DGIENS
 .S DGFDA(33.02,DGIENS,.01)=DGDT
 .S DGFDA(33.02,DGIENS,.02)=$$GET1^DIQ(2,DGDFN_",",.361,"I")
 .S DGFDA(33.02,DGIENS,.03)=$$GET1^DIQ(2,DGDFN_",",.5501,"I")
 .S DGFDA(33.02,DGIENS,.04)=DGREASON
 .S DGFDA(33.02,DGIENS,.05)=+$$SITE^VASITE()
 .S DGFDA(33.02,DGIENS,.06)=$S($G(DUZ)>0:$$GET1^DIQ(200,DUZ,.01),1:"POSTMASTER") ;the user name, otherwise - POSTMASTER
 .D UPDATE^DIE("","DGFDA","","DGERR")
 I DGERR Q "-1^"_$G(DGERR("DIERR",1,"TEXT",1),"Update Error")
 Q 1
 ;
 ;Get reason for change to EXPANDED MH CARE TYPE
RSN4CHG(DGIEN33) ;
 N DGINIT,DGN
 S (DGINIT,DGN)=0 F  S DGN=$O(^DGOTH(33,DGIEN33,2,DGN)) Q:'DGN!(DGINIT)  D
 .S DGINIT='$$GET1^DIQ(33.02,DGN_","_DGIEN33_",",.04,"I")
 I DGINIT Q 1
 Q 0
 ;
 ;This API is called from the "AG" cross-reference in the PATIENT file #2 filed .361 (PRIMARY ELIGIBILITY)
INACT33(DFN) ;
 ;Next line is to preserve certain variables that are used by ^DIE and are needed in DGRPX73
 ;(DGRPX73 is a generated routine on field #2,#.361 PRIMARY ELIGIBILITY)
 N DA,DGEH,DGELIG,DGERR,DGFDA,DGIEN33,DGIENS,DGLAST,DGPREEL,DIE,DP,DQ,DR
 S DGELIG=$$GET1^DIQ(2,DFN_",",.361,"E")
 I DGELIG="EXPANDED MH CARE NON-ENROLLEE" D SETACTVE Q
 I DGELIG="" D EMHCT^DGOTHD1(DFN)
 D DEACTIVE
 Q
 ;
DEACTIVE ;
 S DGIEN33=$O(^DGOTH(33,"B",DFN,"")) Q:'DGIEN33
 ;Inactivate the clock entry if it exists
 ;Note: This is a hard set because INACT33 is called from index #2,#.361 "AG", and ^DIE was killing
 ;various FileMan variables that the generated routines needed
 S $P(^DGOTH(33,DGIEN33,0),U,2)=0 D EMHCT^DGOTHD1(DFN)
 ;Now check if last history entry was for EXPANDED MH CARE NON-ENROLLEE, and make new one for this P.E.
 S DGLAST=+$P($G(^DGOTH(33,DGIEN33,2,0)),U,3) Q:'DGLAST
 K DGEH D GETS^DIQ(33.02,DGLAST_","_DGIEN33_",","**","IE","DGEH")
 S DGPREEL=$G(DGEH(33.02,DGLAST_","_DGIEN33_",",.02,"E"))
 I DGPREEL="EXPANDED MH CARE NON-ENROLLEE" D
 .S DGERR=0
 .S DGIENS=DGIEN33_","
 .S DGFDA(33.02,"+1,"_DGIENS,.01)=$$NOW^XLFDT()
 .S DGFDA(33.02,"+1,"_DGIENS,.02)=$$GET1^DIQ(2,DFN_",",.361,"I")
 .S DGFDA(33.02,"+1,"_DGIENS,.03)=$$GET1^DIQ(2,DFN_",",.5501,"I")
 .S DGFDA(33.02,"+1,"_DGIENS,.04)=1
 .S DGFDA(33.02,"+1,"_DGIENS,.05)=+$$SITE^VASITE()
 .S DGFDA(33.02,"+1,"_DGIENS,.06)=$S($G(DUZ)>0:$$GET1^DIQ(200,DUZ,.01),1:"POSTMASTER") ;the user name, otherwise - POSTMASTER
 .D UPDATE^DIE("","DGFDA","","DGERR")
 Q
 ;
SETACTVE ;
 S DGIEN33=$O(^DGOTH(33,"B",DFN,"")) Q:'DGIEN33
 ;Activate the clock entry if it exists
 ;Note: This is a hard set because INACT33 is called from index #2,#.361 "AG", and ^DIE was killing
 ;various FileMan variables that the generated routines needed
 S $P(^DGOTH(33,DGIEN33,0),U,2)=1
 ;Now check if last history entry was not for EXPANDED MH CARE NON-ENROLLEE, and if so make new one
 S DGLAST=+$P($G(^DGOTH(33,DGIEN33,2,0)),U,3) Q:'DGLAST
 K DGEH D GETS^DIQ(33.02,DGLAST_","_DGIEN33_",","**","IE","DGEH")
 S DGPREEL=$G(DGEH(33.02,DGLAST_","_DGIEN33_",",.02,"E"))
 I DGPREEL'="EXPANDED MH CARE NON-ENROLLEE" D
 .S DGERR=0
 .S DGIENS=DGIEN33_","
 .S DGFDA(33.02,"+1,"_DGIENS,.01)=$$NOW^XLFDT()
 .S DGFDA(33.02,"+1,"_DGIENS,.02)=$$GET1^DIQ(2,DFN_",",.361,"I")
 .S DGFDA(33.02,"+1,"_DGIENS,.03)=$$GET1^DIQ(2,DFN_",",.5501,"I")
 .S DGFDA(33.02,"+1,"_DGIENS,.04)=1
 .S DGFDA(33.02,"+1,"_DGIENS,.05)=+$$SITE^VASITE()
 .S DGFDA(33.02,"+1,"_DGIENS,.06)=$S($G(DUZ)>0:$$GET1^DIQ(200,DUZ,.01),1:"POSTMASTER") ;the user name, otherwise - POSTMASTER
 .D UPDATE^DIE("","DGFDA","","DGERR")
 Q
 ;
GETTIMST(DFN) ;
 ;Get Timestamp for latest entry in #33.02 where PRIMARY ELIGIBILITY or EXPANDED MH CARE TYPE has changed
 N DGELL,DGELP,DGIEN33,DGIENS,DGLAST,DGN,DGNP,DQUIT,DGTYPEL,DGTYPEP
 S DGIEN33=$O(^DGOTH(33,"B",DFN,"")) Q:'DGIEN33 ""
 S DGLAST=+$P($G(^DGOTH(33,DGIEN33,2,0)),U,3) Q:'DGLAST ""
 S DQUIT="" F DGN=DGLAST:-1:1 D  Q:DGQUIT
 . S DGIENS=DGN_","_DGIEN33_","
 . S DGELL=$$GET1^DIQ(33.02,DGIENS,.02),DGTYPEL=$$GET1^DIQ(33.02,DGIENS,.03)
 . S DGNP=$O(^DGOTH(33,DGIEN33,2,DGN),-1) I 'DGNP S DGQUIT=$$GET1^DIQ(33.02,DGIENS,.01,"I") Q
 . S DGIENS=DGNP_","_DGIEN33_","
 . S DGELP=$$GET1^DIQ(33.02,DGIENS,.02),DGTYPEP=$$GET1^DIQ(33.02,DGIENS,.03)
 . I DGELL'=DGELP!(DGTYPEL'=DGTYPEP) S DGQUIT=$$GET1^DIQ(33.02,DGN_","_DGIEN33_",",.01,"I") Q
 Q DGQUIT
 ;
CHKDGEN(DGDFN) ;If Expanded MH Care Type has changed from one type to another, send MailMan message
 N DGCH,DGHIST,DGIEN33,DGLAST,DGMSG,DGN,DGX,DGY,XMDUZ,XMSUB,XMTEXT,XMY
 S DGIEN33=$$HASENTRY^DGOTHD2(DGDFN) Q:'DGIEN33
 S DGLAST=+$P($G(^DGOTH(33,DGIEN33,2,0)),U,3) Q:'DGLAST ""
 D GETS^DIQ(33,DGIEN33_",","2*","IE","DGHIST")
 F DGN=DGLAST:-1:1 S DGX=$G(DGHIST(33.02,DGN_","_DGIEN33_",",.03,"E")) I DGX]"" S DGCH=U_DGX Q
 Q:DGCH=""
 F DGN=(DGN-1):-1:1 S DGY=$G(DGHIST(33.02,DGN_","_DGIEN33_",",.03,"E")) D:DGY]""&(DGY'=$P(DGCH,U,2))  Q
 .S $P(DGCH,U)=DGY
 Q:$P(DGCH,U)=""!($P(DGCH,U,2)="")
 ;Send MailMan message to DGEN ELIGIBILITY ALERT mail group
 S DGMSG(1)="Patient "_$$GET1^DIQ(2,DGDFN_",",.01)_": "
 S DGMSG(2)="Please note that the Expanded MH Care Type for this"
 S DGMSG(3)="patient was changed from "_$P(DGCH,U)_" to"
 S DGMSG(4)=$P(DGCH,U,2)_"."
 S XMSUB="Expanded MH Care Type was changed"
 S XMDUZ="POSTMASTER",XMTEXT="DGMSG(",XMY("G.DGEN ELIGIBILITY ALERT@"_^XMB("NETNAME"))=""
 D ^XMD ; Returns: XMZ(if no error),XMMG(if error)
 Q
 ; 
CLEAN ;
 N DA,DGERR,DGIEN33,DGIEN332,DGFAC,DIE
 S DGFAC=+$$SITE^VASITE()
 S DGIEN33=0 F  S DGIEN33=$O(^DGOTH(33,DGIEN33)) Q:'DGIEN33  D
 .S DGIEN332=0 F  S DGIEN332=$O(^DGOTH(33,DGIEN33,2,DGIEN332)) Q:'DGIEN332  D
 ..K DGFDA S DGFDA(33.02,DGIEN332_","_DGIEN33_",",.05)=DGFAC D FILE^DIE(,"DGFDA","DGERR")
 Q
 ;
