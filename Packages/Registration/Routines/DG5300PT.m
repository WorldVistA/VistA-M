DG5300PT ;ALB/SEK NO LONGER APPLICABLE STATUS CLEANUP POST-INS ; 07/31/96
 ;;5.3;Registration;**100**;Aug 13, 1993
 ;
 ;This routine will be run as a post-installation for patch DG*5.3*100.
 ;This routine will change the STATUS field (#.03) to 10 in the 
 ;ANNUAL MEANS TEST file (408.13) for any copay test that has a NO
 ;LONGER REQUIRED DATE (#.17) and the STATUS field of 7.  This
 ;problem only occurred when the patient went from non-exempt SC less
 ;than 50% to SC 50% to 100%.
 ;
POST ;entry point for post-install, setting up checkpoints
 N %
 S %=$$NEWCP^XPDUTL("DGTTDT","EN^DG5300PT",0)
 Q
 ;
EN ; begin processing
 ;
 ;go through ANNUAL MEANS TEST file changing STATUS to 10 for copay
 ;tests that have a NO LONGER REQUIRED DATE and STATUS of 7.
 N DGTTDT
 ;
 D BMES^XPDUTL("  >> Copay no longer applicable status Clean-up")
 ;
 ;get value from checkpoints, previous run
 S DGTTDT=+$$PARCP^XPDUTL("DGTTDT")
 ;
LOOP ;
 N DFN,DGFL,DGFLD,DGIEN,DGMTA,DGVAL,%
 F  S DGTTDT=$O(^DGMT(408.31,"AS",2,7,DGTTDT)) Q:'DGTTDT  D
 .S DFN=0 F  S DFN=$O(^DGMT(408.31,"AS",2,7,DGTTDT,DFN)) Q:'DFN  D
 ..S DGIEN=0 F  S DGIEN=$O(^DGMT(408.31,"AS",2,7,DGTTDT,DFN,DGIEN)) Q:'DGIEN  D
 ...S DGMTA=$G(^DGMT(408.31,DGIEN,0)) Q:'DGMTA
 ...Q:$P(DGMTA,"^",17)=""
 ...S DGFL=408.31,DGFLD=.03,DGVAL=7 D KILL^DGMTR
 ...S DGVAL=10,$P(^DGMT(408.31,DGIEN,0),"^",3)=DGVAL D SET^DGMTR
 .;update checkpoint
 .S %=$$UPCP^XPDUTL("DGTTDT",DGTTDT)
 Q
