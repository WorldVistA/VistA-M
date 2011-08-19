DG53653U ;TDM - Patch DG*5.3*653 Install Utility Routine ; 11/28/05 4:58pm
 ;;5.3;Registration;**653**;AUG 13, 1993;Build 2
 Q
 ;
EP ; Add new entries to the INCONSISTENT DATA ELEMENTS file (#38.6)
 N BRNG,ERNG,DGKRTN,KEYREQ
 D ADDINC(301,312,"DG53653V",0) Q:$G(XPDABORT)=2
 D ADDINC(401,413,"DG53653W",0) Q:$G(XPDABORT)=2
 D ADDINC(501,517,"DG53653X",0) Q:$G(XPDABORT)=2
 D ADDINC(701,726,"DG53653Y",0) Q:$G(XPDABORT)=2
 Q
 ;
ADDINC(BRNG,ERNG,DGKRTN,KEYREQ) ; add new entries to the INCONSISTENT DATA ELEMENTS file (#38.6)
 ;-----------------------------------------------------------------
 ; Input:    BRNG = Beginning Number
 ;           ERNG = Ending Number
 ;         DGKRTN = Routine Name for the Range
 ;         KEYREQ = Key Required
 ;                    0=No Key Required
 ;                    1=Eligibility Verified
 ;                    2=Money Verified
 ;                    3=Service Verified
 ;                    4=Key Always Required
 ;-----------------------------------------------------------------
 N DGK,DGKSUB,DGWP,ROOT,DGFDA,DGWP,DGERR,DGIEN,DGTITL
 K XPDABORT
 D BMES^XPDUTL("  >> Adding entries "_BRNG_"-"_ERNG_" into the INCONSISTENT DATA ELEMENTS file (#38.6)")
 F DGK=BRNG:1:ERNG Q:$G(XPDABORT)=2  D
 .I $D(^DGIN(38.6,DGK)) D  Q
 ..D BMES^XPDUTL("     Internal Entry # "_DGK_" already exists in file #38.6")
 ..S ROOT="DGFDA(38.6,"""_DGK_","")" S DGKSUB=DGK_U_DGKRTN D @DGKSUB
 ..I $P($G(^DGIN(38.6,DGK,0)),"^")=$G(@ROOT@(.01)) D MES^XPDUTL("Entry "_DGK_" matches incoming entry - OK") Q
 ..D MES^XPDUTL("     >>> ERROR: Entry # "_DGK_" needs to be reviewed by NVS! <<<")
 ..D MES^XPDUTL("           Existing entry: "_$P($G(^DGIN(38.6,DGK,0)),"^"))
 ..D MES^XPDUTL("           Incoming entry: "_$G(@ROOT@(.01)))
 ..D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 ..S XPDABORT=2
 .K DGFDA,ROOT,DGWP
 .S ROOT="DGFDA(38.6,""?+1,"")"
 .S DGKSUB=DGK_U_DGKRTN D @DGKSUB Q:'$D(DGFDA)
 .S DGIEN(1)=DGK,DGTITL=@ROOT@(.01),@ROOT@(3)=KEYREQ,@ROOT@(4)=0,@ROOT@(5)=0,@ROOT@(6)=1,@ROOT@(50)="DGWP"
 .D UPDATE^DIE("","DGFDA","DGIEN","DGERR")
 .I $D(DGERR) D  Q
 ..D BMES^XPDUTL("   >>> ERROR! "_DGTITL_" not added to file #38.6")
 ..D MES^XPDUTL("     "_DGERR("DIERR",1)_": "_DGERR("DIERR",1,"TEXT",1))
 ..D BMES^XPDUTL("                        <<<< INSTALLATION ABORTED >>>>")
 ..S XPDABORT=2
 .D BMES^XPDUTL("      "_DGTITL_" successfully added.")
 Q
