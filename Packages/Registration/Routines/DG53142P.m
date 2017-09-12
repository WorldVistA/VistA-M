DG53142P ;ALB/ABR - POST INSTALL ROUTINE ; 12 - Sep - 97
 ;;5.3;Registration;**142**;Aug 13, 1993
 ;
 ;  This routine is being sent as an environment check routine
 ;  in order to load code in advance that is needed for the
 ;  Post-Install questions.
 ;  
 ;  There is no environment check done.
 ;
EN ;  ENVIRONMENT CHECK ENTRY POINT
 QUIT
 ;
FTS ;  code for the KIDS post-install questions.
 N DGX,DGY,DGZ
 S (DGY,DGZ)=$O(DIR("A",99),-1) ; find last line of DIR(A) for question
 F DGX=0:0 S DGX=$O(^DIC(45.7,"ASPEC",76,DGX)) Q:'DGX  D
 . S DGY=DGY+1,DIR("A",DGY)="      "_$P($G(^DIC(45.7,DGX,0)),"^")
 I DGZ=DGY D
 . S DGY=DGY+1,DIR("A",DGY)="   ** No TREATING SPECIALTIES point to PTF CODE 76 **"
 . S DGY=DGY+1,DIR("A",DGY)="   ** Accept Default, no changes will be made to file 45.7"
 S DIR("A",DGY+1)="   "
 Q
POS ; entry point for post-install
 N DGINA,ERR
 I $D(XPDQUES("POS1")) D  Q:$G(ERR)
 .D ADDSP Q:$G(ERR)
 .D SPEC
 .D SUFFIX
 ;
 ; if Yes to inactivate Fac. Treating Specialty
 ;  check if coming from KIDS install, or separate run
 ;  DGINA=1 if yes to POST-INSTALL question, 0 if no
 ;  DGINA=2 if direct run of routine (XPDQUES("POS1") not defined.) 
 S DGINA=$G(XPDQUES("POS1"),2) D:DGINA INAFTS
 Q
 ;
ADDSP ; add SPECIALTY 38 and 39
 N I
 F I=1,2 D
 . K DD,DO
 . N DA,DIC,DIE,DINUM,DLAYGO,DR,CDR,NAM,SPC,TXT,X,Y
 . S DLAYGO=42.4
 . S (DIC,DIE)="^DIC(42.4,",DIC(0)="XLZ"
 . S TXT=$P($T(ADDCO+I),";;",2),(X,NAM)=$P(TXT,U,2),(SPC,DINUM)=+TXT,CDR=$P(TXT,U,3)
 . D ^DIC
 . I Y<0 D BMES^XPDUTL(">> Error adding PTF CODE "_SPC_". Call Customer Support.") Q
 . I '$P(Y,U,3) S DA=SPC
 . S DR="1///^S X=NAM;3///^S X=""P"";4////1;5///^S X=""PSYCHIATRIC CARE"";6///"_CDR
 . D ^DIE
 . S (DIC,DIE)="^DIC(42.4,"_SPC_",""E"",",DA(1)=SPC,DIC("P")=$P(^DD(42.4,10,0),U,2),DIC(0)="XLZ"
 . S X=2971001
 . D BMES^XPDUTL(" >> Adding Specialty "_$P(TXT,U,2)_", PTF CODE "_+TXT)
 . D ^DIC I Y<0 D BMES^XPDUTL(">> Error adding PTF CODE Effective Date.  Call Customer Support.") Q
 . S DR=".02////1",DA=+Y,DA(1)=SPC
 . D ^DIE
 Q
 ;
ADDCO ;PTF CODE^NAME^CDR ACCT
 ;;38^PTSD CWT/TR^1716.00
 ;;39^GENERAL CWT/TR^1717.00
 Q
SPEC ; inactivate SPECIALTY 76
 K DD,DO
 N DA,DIC,DIE,DR,X,Y
 S (DIC,DIE)="^DIC(42.4,76,""E"",",DIC(0)="XLZ",DIC("P")=$P(^DD(42.4,10,0),U,2)
 S X=2971001,DA(1)=76
 D ^DIC
 I Y<0 D BMES^XPDUTL(" >> Error inactivating PTF CODE 76.  CALL CUSTOMER SUPPORT.") S ERR=1 Q
 I $P(Y(0),"^",2)=0 D BMES^XPDUTL("PTF CODE 76, PSYCHIATRIC MENTALLY INFIRM already inactive for 10/1/97") Q
 S DA=+Y,DA(1)=76,DR=".02////0"
 D ^DIE
 D MES^XPDUTL(">> Inactivating PTF CODE 76, PSYCHIATRIC MENTALLY INFIRM")
 D MES^XPDUTL("   from SPECIALTY file (#42.4)")
 Q
 ;
SUFFIX ; Add Suffix
 K DD,DO
 N DA,DIC,DIE,DLAYGO,DR,X,Y
 S DLAYGO=45.68
 S DIC="^DIC(45.68,",DIC(0)="XLZ"
 S X="PA"
 D ^DIC I Y<0 D BMES^XPDUTL(">> Error adding PA Suffix.  Call Customer Support.") Q
 D BMES^XPDUTL(" >> PA suffix added to FACILITY SUFFIX file.")
 S (DIC,DIE)="^DIC(45.68,"_+Y_",""E"",",DA(1)=+Y,DIC("P")=$P(^DD(45.68,10,0),U,2),DIC(0)="XLZ",X=2971001
 D ^DIC
 I Y<0 D BMES^XPDUTL(">> Error adding PA Suffix Effective Date.  Call Customer Support.") Q
 S DA=+Y
 S DR=".01////2971001;.02////1"
 D ^DIE
 Q
 ;
INAFTS ; inactivate associated facility treating specialties
 K DD,DO
 N DA,DIC,DIE,DR,X,Y,DGX,DGNAME,DGOKAY
 F DGX=0:0 S DGX=$O(^DIC(45.7,"ASPEC",76,DGX)) Q:'DGX  D
 . S (DIC,DIE)="^DIC(45.7,"_DGX_",""E"",",DIC(0)="XLZ",DIC("P")=$P(^DD(45.7,100,0),U,2),DA(1)=DGX
 . S X=2971001
 . S DGNAME=$P(^DIC(45.7,DGX,0),"^")
 . ; if direct run of routine, get okay for each TS
 . I DGINA=2 S DGOKAY=0 D ASK Q:'DGOKAY
 . D ^DIC I Y<0 D BMES^XPDUTL(" >> Error updating file 45.7.  CALL CUSTOMER SUPPORT.") Q
 . I $P(Y(0),"^",2)=0  D BMES^XPDUTL(DGNAME_" already inactivated for 10/1/97") Q
 . S DA=+Y,DA(1)=DGX,DR=".02////0"
 . D ^DIE
 .D BMES^XPDUTL(">> Inactivating FACILITY TREATING SPECIALTY:  "_DGNAME)
 Q
 ;
ASK ;  for individual run, ask ok for each ts
 N DIR,X,Y
 S DIR("A")="Inactivate FACILITY TREATING SPECIALTY: "_DGNAME
 S DIR("A",1)=" ",DIR(0)="Y",DIR("B")="NO"
 D ^DIR S DGOKAY=+Y
 Q
