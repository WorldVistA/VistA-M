DG53114T ;ALB/MTC - TRICARE ENHANCEMENT POST INSTALL UPDATES; 3/4/97
 ;;5.3;Registration;**114**;Aug 13, 1993
 ;
EN ;
 ;-- update Patient Type file #391
 D PAT
 ;-- update Eligibility file #8
 D ELIG
 ;-- update Period of Service file 21
 D UPPOS
 ;-- update scheduling patch history
 D UPDAT
 ;
 Q
 ;
PAT ;-- This function will add a TRICARE patient Type to file #391
 ;   if it dies not already exists.
 ;
 N X,Y,DIC,DIE,DR,DA,D0
 ;
 D BMES^XPDUTL(">>> Adding TRICARE to the Patient Type file #391.")
 ;
 S X=$O(^DG(391,"B","TRICARE",0))
 I X D BMES^XPDUTL(" --- Entry Already exists! --- ") G PATQ
 ;
 ;  else add entry to file
 S DIC="^DG(391,",X="TRICARE"
 S DIC("DR")=".02///1;.04///0;.05///0;3///1;6///0;8///0;9///0;11///0;74///0;101///1;102///1",DIC(0)="LS"
 D FILE^DICN
 I Y D BMES^XPDUTL("     Entry Successfully Added. ")
 ;
PATQ ;
 D BMES^XPDUTL(">>> Done.")
 ;
 Q
 ;
ELIG ;-- This function will add a TRICARE/CHAMPUS eligibility to file #8
 ;
 N X,Y,DGE,DIC,DIE,DR,DA,D0
 ;
 D BMES^XPDUTL(">>> Adding 'TRICARE/CHAMPUS' to the Eligibility file #8.")
 S X=$O(^DIC(8,"B","TRICARE/CHAMPUS",0))
 I X D BMES^XPDUTL(" --- Entry Already exists! --- ") G ELIGQ
 ;
 ;  else add entry to file
 S DGE=$O(^DIC(8.1,"B","TRICARE/CHAMPUS",0))
 S DIC="^DIC(8,",X="TRICARE/CHAMPUS"
 S DIC("DR")=".12///0;1///^S X=""RED"";2///^S X=""TRI"";4///^S X=""NO"";5///^S X=""TRICARE/CHAMPUS"";7///1;8////"_DGE,DIC(0)="LS"
 D FILE^DICN
 I Y D BMES^XPDUTL("    Entry Successfully Added. ")
 ;
ELIGQ ;
 D BMES^XPDUTL("Done.")
 D MESS
 ;
 Q
 ;
MESS ;-- This routine will display a message indicating that
 ;   the sites should examine the entries in file #8 to
 ;   check if any need to be pointed to the new Tricare/Champus
 ;   eligibility code.
 ;
 D BMES^XPDUTL("Please examine the entries in the ELGIBILITY file #8")
 D MES^XPDUTL("for any entries that should be associated with the")
 D MES^XPDUTL("'TRICARE/CHAMPUS' entry in the MAS ELIGIBILITY file #8.1.")
 Q
UPDAT ;  update package file for install of Scheduling patch SD*5.3*94
 N PKG,VER,PATCH
 ; find ien of SCHEDULING in PACKAGE file
 S PKG=$O(^DIC(9.4,"B","SCHEDULING",0)) Q:'PKG
 S VER=5.3
 S PATCH="94^"_DT_"^"_DUZ ; patch #^today^installed by
 ;
 D BMES^XPDUTL(" >>Updating Patch Application History for Scheduling with SD*5.3*94")
 S PATCH=$$PKGPAT^XPDIP(PKG,VER,.PATCH)
 Q
 ;
UPPOS ;-- This routine will update the POS file 21 eligibility sub-file
 ;
 N DGX,DGY,DGZ,X,Y,DGCNT,DIC,DLAYGO,DA,DIC
 ;
 D BMES^XPDUTL(">>> Updating Period of Service file with new eligibility information.")
 S DGX=$O(^DIC(8,"B","TRICARE/CHAMPUS",0))
 I 'DGX G UPPOSQ
 S DGCNT=1 F  S DGY=$P($T(POSTEX+DGCNT),";;",2) Q:DGY=""  S DGCNT=DGCNT+1 D
 . S DGZ=$O(^DIC(21,"B",DGY,0))
 . I 'DGZ Q
 . I '$D(^DIC(21,+DGZ,"E",+DGX,0)) D
 .. S DIC="^DIC(21,"_DGZ_",""E"","
 .. S DIC(0)="L",DLAYGO=21,DA(1)=DGZ,DIC("P")=$P(^DD(21,10,0),U,2),X="TRICARE/CHAMPUS"
 .. D ^DIC
 .. K DIC,DA,DA(1),DLAYGO,DIC("P")
UPPOSQ ;
 Q
 ;
POSTEX ;
 ;;AIR FORCE--ACTIVE DUTY
 ;;ARMY--ACTIVE DUTY
 ;;BENEFICIARIES-FOREIGN GOV
 ;;CAV/NPS
 ;;COAST GUARD--ACTIVE DUTY
 ;;NAVY, MARINE--ACTIVE DUTY
 ;;OTHER NON-VETERANS
 ;;WORLD WAR II
 ;;CHAMPUS
 ;;
