DG53672D ;ALB/ERC - PATCH INSTALL UTILITIES FOR DG 672 ; 9/21/05 4:32pm
 ;;5.3;Registration;**672**; Aug 13, 1993
 ;convert values from Patient file, field .362 (Disability Retirement 
 ;from the Military) and 1010.158 (Disability Discharge on 1010EZ)
 ;to two new fields, Military Disability Retirement (.3602) and 
 ;Discharge Due to Disability? (.3603)
 ;
 ;for field .362 values converted to .3602
 ;  0 (NO)  not converted
 ;  1 (YES, RECEIVING MILITARY RETIREMENT) converted to 1(yes)
 ;  2 (YES, RECEIVING MILITARY RETIREMENT IN LIEU OF VA COMPENSATION) 
 ;    converted to 1(yes)
 ;  3 (UNKNOWN) not converted
 ;for field 1010.158 to .3603
 ;  0 (NO) to 0
 ;  1 (YES) to 1
 ;
 ;this routine is called from DG53672C
 ;
EN(DFN) ;entry from DG53672C
 N DGD,DGFDA,DGDIS,DGERR,DGLOD,DGRAND
 D GETS^DIQ(2,DFN_",",".362;1010.158","I","DGD","DGERR")
 S DGDIS=$G(DGD(2,DFN_",",.362,"I"))
 S DGLOD=$G(DGD(2,DFN_",",1010.158,"I"))
 I $G(DGLOD)]"" D
 . D LOD
 . S ^XTMP("DG53672C","DG53672D",1010.158,"CNT")=$G(^XTMP("DG53672C","DG53672D",1010.158,"CNT"))+1
 I $G(DGDIS)=1!($G(DGDIS)=2) D
 . D DIS
 . S ^XTMP("DG53672C","DG53672D",.362,"CNT")=$G(^XTMP("DG53672C","DG53672D",.362,"CNT"))+1
FILE ;
 D FILE^DIE("K","DGFDA","DGERR")
 I $G(DGERR)']"" D
 .I $G(DGDIS)]"" D
 . . S ^XTMP("DG53672C","DG53672D","DATA",.362,DGDIS)=$G(^XTMP("DG53672C","DG53672D","DATA",".362",DGDIS))+1
 . I $G(DGLOD)]"" D
 . . S ^XTMP("DG53672C","DG53672D","DATA",1010.158,DGLOD)=$G(^XTMP("DG53672C","DG53672D","DATA","1010.158",DGLOD))+1
 Q
 ;
DIS ;convert Disability Retirement to new fields
 S DGFDA(2,DFN_",",.3602)=1
 I $G(DGFDA(2,DFN_",",.3603))']"" S DGFDA(2,DFN_",",.3603)=1
 Q
 ;
LOD ;Discharge Due to Disability is populated
 S DGFDA(2,DFN_",",.3603)=DGLOD
 Q
 ;
SNDMSG ; Send Mailman bulletin when process completes
 N SITE,STATN,SITENM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),U,3),SITENM=$P($G(SITE),U,2)
 S:$$GET1^DIQ(869.3,"1,",.03,"I")'="P" STATN=STATN_" [TEST]"
 S XMDUZ="DISABILITY RETIREMENT DATA CONVERSION",XMSUB=XMDUZ_" - "_STATN
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),U,3),SITENM=$P($G(SITE),U,2)
 S:$$GET1^DIQ(869.3,"1,",.03,"I")'="P" STATN=STATN_" [TEST]"
 S XMDUZ="DISABILITY RETIREMENT DATA CONVERSION",XMSUB=XMDUZ_" - "_STATN
 S XMY(DUZ)=""
 S XMY("CURTIN,EDNA@MNTVMM.FO-ALBANY")=""
 S XMTEXT="MSG("
 S MSG(1)="The Disability Retirement Data Conversion has completed successfully."
 S MSG(2)="Fields .362 (DISABILITY RET. FROM MILITARY?) and 1010.158 (DISABILITY"
 S MSG(3)="DISCHARGE ON 1010EZ), both in the Patient file, have been converted"
 S MSG(4)="to fields .3602 (MILITARY DISABILITY RETIREMENT) and .3603 (DISCHARGE DUE"
 S MSG(5)="TO DISABILITY), according to the following algorithm:"
 S MSG(6)="      value of 'Yes' in 1010.158 is now 'Yes' in field .3603"
 S MSG(7)="      value of 'No' in 1010.158 is now 'No' in field .3603"
 S MSG(8)=""
 S MSG(9)="      value of 1 or 2 in .362 is now 'Yes' in .3602 and .3603"
 S MSG(10)="      value of 0 or 3 in .362 was not converted"
 S MSG(12)=""
 S MSG(13)="Task: "_$G(^XTMP("DG53672C",0,"TASK"))
 S MSG(14)="Site Station Number: "_STATN
 S MSG(15)="Site Name: "_SITENM
 S MSG(16)=""
 S MSG(17)="Process started   : "_$$FMTE^XLFDT($P($G(^XTMP("DG53672C",0)),U,2))
 S MSG(18)="Process completed : "_$$FMTE^XLFDT($P($G(^XTMP("DG53672C",0)),"^",4))
 S MSG(19)=""
 S MSG(20)="Total Patients processed             : "_+$G(^XTMP("DG53672C","TCNT"))
 S MSG(21)="Total with 'Yes' in 1010.158: "_+$G(^XTMP("DG53672C","DG53672D","DATA","1010.158",1))
 S MSG(22)="Total with 'No' in 1010.158: "_+$G(^XTMP("DG53672C","DG53672D","DATA","1010.158",0))
 S MSG(23)="Total with 1 in .362: "_+$G(^XTMP("DG53672C","DG53672D","DATA",".362",1))
 S MSG(24)="Total with 2 in .362: "_+$G(^XTMP("DG53672C","DG53672D","DATA",".362",2))
 D ^XMD
 Q
