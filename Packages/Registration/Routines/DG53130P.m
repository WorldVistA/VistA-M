DG53130P ;ALB/SEK INCORRECT COPAY STATUS CLEANUP POST-INS ; 06/24/97
 ;;5.3;Registration;**130**;Aug 13, 1993
 ;
 ;This routine will be run as post-installation for patch DG*5.3*130.
 ;This routine will change the STATUS field (#.03) to 8 (non-exempt)
 ;from 9 (incomplete) in the ANNUAL MEANS TEST file (#408.13) for
 ;copay tests when the veteran declines to give income information.
 ;
POST ;entry point for post-install, setting up checkpoints
 N %
 S %=$$NEWCP^XPDUTL("DGTTDT","EN^DG53130P",-9999999)
 Q
 ;
EN ;begin processing
 ;
 ;update PACKAGE file for installation of IVM patch IVM*2*8
 D UPDATE
 ; 
 ;go through ANNUAL MEANS TEST file changing STATUS to 8 from 9
 ;for copay tests when veteran declines to give income information.
 N DGTTDT
 ;
 D BMES^XPDUTL("  >> Copay incomplete status cleanup")
 ;
 ;get value from checkpoints, previous run
 S DGTTDT=+$$PARCP^XPDUTL("DGTTDT")
 ;
 D LOOP
 D MAIL
 Q
 ;
 ;
UPDATE ;  update PACKAGE file for install of IVM patch IVM*2*8
 N PKG,VER,PATCH
 ; find ien of IVM in PACKAGE file
 S PKG=$O(^DIC(9.4,"B","INCOME VERIFICATION MATCH",0)) Q:'PKG
 S VER="2.0" ; version
 S PATCH="8^"_DT_"^"_DUZ ; patch #^today^installed by
 ;
 D BMES^XPDUTL(" >>Updating Patch Application History for IVM with IVM*2*8")
 S PATCH=$$PKGPAT^XPDIP(PKG,VER,.PATCH)
 Q
 ;
 ;
LOOP ;
 N DFN,DGFL,DGFLD,DGIEN,DGINY,DGMTA,DGVAL,%
 S ^XTMP("DG53130P",0)=$$FMADD^XLFDT(DT+30)_"^"_DT_"^"_"COPAY STATUS CHANGED LOG"  ;temp array
 F  S DGTTDT=$O(^DGMT(408.31,"AS",2,9,DGTTDT)) Q:'DGTTDT  D
 .S DFN=0 F  S DFN=$O(^DGMT(408.31,"AS",2,9,DGTTDT,DFN)) Q:'DFN  D
 ..S DGIEN=0 F  S DGIEN=$O(^DGMT(408.31,"AS",2,9,DGTTDT,DFN,DGIEN)) Q:'DGIEN  D
 ...S DGMTA=$G(^DGMT(408.31,DGIEN,0)) Q:'DGMTA
 ...Q:'$P(DGMTA,"^",14)
 ...S DGFL=408.31,DGFLD=.03,DGVAL=9 D KILL^DGMTR
 ...S DGVAL=8,$P(^DGMT(408.31,DGIEN,0),"^",3)=DGVAL D SET^DGMTR
 ...;
 ...;get income year
 ...S Y=$E(DGTTDT,2,4) S Y=Y-1 X ^DD("DD") S DGINY=Y
 ...;
 ...; - build list of copay tests changed
 ...D BUILDLN
 ...;
 .;update checkpoint
 .S %=$$UPCP^XPDUTL("DGTTDT",DGTTDT)
 Q
 ;
 ;
 ;
BUILDLN ; Build storage array with data
 ;
 ;  Output:  
 ;        ^XTMP("DG53130P",pt name,pt ssn,income year)=""
 ;
 N DGNAME,DGSSN
 ;
 ; - pt name and ssn from Patient (#2) file
 S DGNAME=$P($G(^DPT(DFN,0)),"^"),DGSSN=$P($G(^(.36)),"^",3)
 S:DGNAME="" DGNAME=DFN
 S:DGSSN="" DGSSN="MISSING"
 ;
 S ^XTMP("DG53130P",DGNAME,DGSSN,DGINY)=""
 Q
 ;
 ;
MAIL ; Send a mailman msg to user listing copay tests with status change
 N DIFROM,%
 N DGCTR,DGCTXT,DGCX,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 D BMES^XPDUTL("  >> cleanup done.")
 D BMES^XPDUTL("  >> Sending mailman msg listing copay tests with status change.")
 S XMSUB="LIST OF COPAY TESTS WITH STATUS CHANGE"
 S XMDUZ="REGISTRATION PACKAGE",XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="DGCTXT("
 S DGCX=$$SITE^VASITE
 D NOW^%DTC S Y=% D DD^%DT
 S DGCTXT(1)="LIST OF COPAY TESTS WITH STATUS CHANGE FROM INCOMPLETE TO NON-EXEMPT"
 S DGCTXT(2)="        WHEN THE PATIENT DECLINES TO GIVE INCOME INFORMATION"
 S DGCTXT(3)="  "
 I $O(^XTMP("DG53130P",0))']"" D  G MAIL1
 .S DGCTXT(4)="No copay tests changed."
 .S DGCTXT(5)=" "
 S DGCTXT(4)="Patient Name                    Patient SSN      Income Year"
 S DGCTXT(5)="============================================================"
 ;
 ; - create list of patients
 N DGBLANK,DGLINE,DGNM,DGNUM
 S DGBLANK="",$P(DGBLANK," ",30)="",DGCTR=8
 S DGNM="" F  S DGNM=$O(^XTMP("DG53130P",DGNM)) Q:DGNM']""  D
 .S DGNUM="" F  S DGNUM=$O(^XTMP("DG53130P",DGNM,DGNUM)) Q:DGNUM']""  D
 ..S DGLINE="" F  S DGLINE=$O(^XTMP("DG53130P",DGNM,DGNUM,DGLINE)) Q:DGLINE']""  D
 ...S DGCTR=DGCTR+1
 ...S DGCTXT(DGCTR)=$E(DGNM_DGBLANK,1,30)_"  "_$E(DGNUM_DGBLANK,1,15)_"  "_$E(DGLINE_DGBLANK,1,10)
 ;
MAIL1 D ^XMD
 D MES^XPDUTL("  >> message sent.")
 K ^XTMP("DG53130P")
 Q
