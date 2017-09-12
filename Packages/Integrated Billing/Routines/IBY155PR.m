IBY155PR ;ALB/TMP - IB*2*155 PRE-INSTALL ;11-APR-02
 ;;2.0;INTEGRATED BILLING;**155**;21-MAR-94
 ;
 ;
 D BMES^XPDUTL("    Pre-Installation Updates")
 D BMES^XPDUTL("    Delete output formatter data that will be updated during install")
 N Z,DA,DIK
 F Z=3,26,27,127 K ^IBA(364.5,Z,3)
 S DA=353,DIK="^IBA(364.7,"
 D ^DIK   ; remove entry 353 because the .03 field changed
 S DA=964,DIK="^IBA(364.6,"
 D ^DIK   ; remove entry 964 because the .1 field changed
 ;
 D BMES^XPDUTL("    Delete fields in file 361.1 that will be updated during install")
 ; Remove selective Data Dictionay Elements related to this build
 ;
 ; Remove the Multiple 361.13 (File 361.1, Field 2.1 - Original Modifiers)
 N DIU
 S DIU=361.13,DIU(0)="S" D EN^DIU2
 K DIU
 ;
 ; Remove field .16 of File 361.1 - REVIEW STATUS
 N DIK,DA
 S DIK="^DD(361.1,",DA=.16,DA(1)=361.1 D ^DIK
 ; Remove Field .2 of File 361.1 - FINAL REVIEW ACTION
 S DA=.2 D ^DIK
 ; Remove Field 2.1 of File 361.1 - ORIGINAL MODIFIERS
 S DA=2.1 D ^DIK
 ;
 ; Remove Field 9 of File 399 - AUTHORIZE BILL GENERATION?
 S DIK="^DD(399,",DA=9,DA(1)=399 D ^DIK
 ; Remove Field 25 of File 399 - REQUEST AN MRA?
 S DA=25 D ^DIK
 ;
 D BMES^XPDUTL("    Delete list templates which will be updated during install")
 D LSTDEL("IBCEM MRA DETAIL")
 ;
 D BMES^XPDUTL("    Pre-install complete")
 Q
 ;
INCLUDE(Y) ; Code to execute to decide if the data element definition 
 ;  should be sent with this patch ... it must exist in the list at
 ;  line ENT5+2 below
 N IBOUT,Z,Z0
 I Y>9999 S IBOUT=0 G INCQ1
 I $P($T(ENT5+2),";;",2)[(U_+Y_U) S IBOUT=1 G INCQ1
INCQ1 Q +$G(IBOUT)
 ;
ENT5 ; Changed entries from 364.5 that should be in the build
 ;
 ;;^3^26^27^55^127^177^248^249^251^225^257^
 Q
 ;
LSTDEL(LSTNM) ; Delete list templates from file 409.61 before installation
 I $G(LSTNM)="" G LSTDELX
 S DA=$O(^SD(409.61,"B",LSTNM,""))
 I 'DA G LSTDELX
 S DIK="^SD(409.61,"
 D ^DIK
LSTDELX ;
 Q
 ;
BFT ; Add new Bill Form Type for MRA reports;
 ; Called by the post-install routine IBY155PO;
 ; File 353, new internal entry number 6;
 ; Default the printer defined for the Bill Addendum entry
 ;
 NEW DA,DIC,DO,X,Y,DD,DLAYGO,DINUM,DG,DICR,DIW,BAPRT
 I $P($G(^IBE(353,6,0)),U,1)="MRA" G BFTX     ; already on file
 I $D(^IBE(353,6)) D
 . ; some other entry is defined at ien=6, so get rid of it
 . S DA=6,DIK="^IBE(353," D ^DIK
 . Q
 ;
 S DIC="^IBE(353,",DIC(0)="F"
 S X="MRA"
 S DINUM=6
 S DIC("DR")="2.02////P"   ; format type
 S BAPRT=$P($G(^IBE(353,4,0)),U,2)  ; bill addendum default printer
 I BAPRT'="" S DIC("DR")=DIC("DR")_";.02////"_BAPRT
 D FILE^DICN
BFTX ;
 Q
 ;
