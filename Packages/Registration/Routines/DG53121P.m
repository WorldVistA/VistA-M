DG53121P ;ALB/CJM - LOCAL ENROLLMENT ENHANCEMENT POST INSTALL UPDATES; 7/23/97
 ;;5.3;Registration;**121**;Aug 13, 1993
 ;
EN ;
 ;-- update Eligibility file #8
 D ELIG
 Q
 ;
ELIG ;-- This function will add a CATASTROPHICALLY DISABLED eligibility to file #8
 ;
 N X,Y,DGE,DIC,DIE,DR,DA,D0
 ;
 D BMES^XPDUTL(">>> Adding 'CATASTROPHICALLY DISABLED' to the Eligibility file #8.")
 S X=$O(^DIC(8,"B","CATASTROPHICALLY DISABLED",0))
 I X D BMES^XPDUTL(" --- Entry Already exists! --- ") G ELIGQ
 ;
 ;  else add entry to file
 S DGE=$O(^DIC(8.1,"B","CATASTROPHICALLY DISABLED",0))
 S DIC="^DIC(8,",X="CATASTROPHICALLY DISABLED"
 S DIC("DR")="1///^S X=""BLUE"";2///^S X=""CD"";4///^S X=""Y"";5///^S X=""CATASTROP. DISAB."";7///1;3///10;9///^S X=""VA STANDARD"";11///^S X=""VA"";8////"_DGE,DIC(0)="LS"
 D FILE^DICN
 I ((+Y)>0) D BMES^XPDUTL("    Entry Successfully Added. ")
 I Y=-1 D BMES^XPDUTL(" Entry was NOT successfully added. ")
 ;
ELIGQ ;
 D BMES^XPDUTL("Done.")
 Q
