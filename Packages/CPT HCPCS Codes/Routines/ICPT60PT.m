ICPT60PT ;ALB/ABR - ICPT Post-init Driver; 3/6/96
 ;;6.0;CPT/HCPCS;;May 19, 1997
 ;
EN ; -- main entry point
 D UPDAT ; update pce patch file for PX*1*32
 D UPDAT2 ; update dg patch file for DG*5.3*123
 ;
 D BMES^XPDUTL("*** YOU MUST LOAD THE CPT GLOBALS FROM THE APPROPRIATE ***"),MES^XPDUTL("*** ICPT6_*.GBL UPON COMPLETION OF THIS INSTALLATION! ***")
Q Q
 ;
UPDAT ;  update package file for install of PCE patch PX*1*32
 N PKG,VER,PATCH
 ; find ien of PCE in PACKAGE file
 S PKG=$O(^DIC(9.4,"B","PCE PATIENT CARE ENCOUNTER",0)) Q:'PKG
 S VER="1.0" ; version
 S PATCH="32^"_DT_"^"_DUZ ; patch #^today^installed by
 ;
 D BMES^XPDUTL(" >>Updating Patch Application History for PCE with PX*1*32")
 S PATCH=$$PKGPAT^XPDIP(PKG,VER,.PATCH)
 Q
UPDAT2 ;  update package file for install of DG patch DG*5.3*123
 N PKG,VER,PATCH
 S PKG=$O(^DIC(9.4,"B","REGISTRATION",0)) Q:'PKG
 S VER="5.3" ; version
 S PATCH="123^"_DT_"^"_DUZ ; patch #^today^installed by
 D MES^XPDUTL(" >>Updating Patch Application History for REGISTRATION with DG*5.3*123")
 S PATCH=$$PKGPAT^XPDIP(PKG,VER,.PATCH)
 Q
