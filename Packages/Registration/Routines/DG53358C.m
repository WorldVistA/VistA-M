DG53358C ;ALB/AEG,GN DG*5.3*296 DELETE INC TEST CON'T;01 JUNE 2000 ; 10/29/03 2:41pm
 ;;5.3;REGISTRATION;**358,558**;JUNE 1 2000
 ;
 ;This is a modified version for IVMCMD1. It deletes records
 ;from the Annual Means Test(#408.31) file.  It does not open
 ;a case record in the IVM Patient (#301.5)file, does not send 'delete'
 ;bulletin/notification to local mail group, does not call the means
 ;test event driver and does not call DGMTR.
 ;
 ;DG*53*558 - re-deploy with this patch
 ;
EN ;This entry point is called from the routine (DG53358D) and
 ;contains calls that are responsible for completing the
 ;deletion of an income test.
 ;
 ; Delete record from Annual Means Test (#408.31) file
 D DEL31(IVMMTIEN)
 S IVMDONE=1
 ;
 ; Cleanup variables
 D CLEAN
 ;
ENQ Q
 ;
 ;
DEL31(IVMDIEN) ; Delete record from Annual Means Test (#408.31) file.
 ;
 ;  Input(s):
 ;    IVMDIEN - as IEN of the Annual Means Test (#408.31) file
 ;
 ; Output(s): None
 ;
 N DA,DIK
 S DA=IVMDIEN,DIK="^DGMT(408.31,"
 D ^DIK
 Q
 ;
 ;
 ;
CLEAN ; Cleanup variables used for deletion.
 K DA,DFN,DGINC,DGINR,DGMTA,DGMTACT,DGMTI,DGMTP
 K DGMTYPT,DIE,DIK,DR,IVM12,IVM121,IVM13,IVM41,IVM411
 K IVMAR1,IVMDEP,IVMFILE,IVMNOD,IVMOLD
 K IVMPAT,IVMTEXT,IVMVAMCA,XMSUB,Y
 Q
