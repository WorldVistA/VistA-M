DG53P874 ;OAK/ELZ - POST-INIT FOR DG*5.3*874 ;9/17/2013
 ;;5.3;Registration;**874**;Aug 13, 1993;Build 2
 ;
 ; -- this post install routine will clean up the files associated
 ;    with old VIC cards.
 ; DBIA2172,DBIA10141,DBIA10014
 ;
POST D MES^XPDUTL("  Starting post-install of DG*5.3*874")
 N DGC,DGP,DGX,DIU
 D MES^XPDUTL("   - Deleting obsolete files.")
 S XPDIDTOT=2,DGC=0
 F DGX=39.6,39.7 D
 . S DGP=$G(DILOCKTM,3)
 . D MES^XPDUTL("    - Deleting obsolete file #"_DGX_", Waiting for hardware "_DGP_" seconds...")
 . S DIU=DGX,DIU(0)="EDT"
 . D EN^DIU2
 . S DGC=DGC+1
 . D UPDATE^XPDID(DGC)
 . H DGP  ; need to pause so we don't hit the globals too hard
 ;
 D MES^XPDUTL("  Finished post-install of DG*5.3*874")
 Q
