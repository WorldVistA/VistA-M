VSIT0 ;ISL/JVS,dee - Front End Check to Visit Tracking ;7/29/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996
 Q
 ;
GETPKG(VSITPKG) ;Pass in packaga name space and returns a pointer
 ; to that package in the Visit Tracking paramaters file.
 N VSITIEN,VSITPIEN
 S VSITPIEN=$$PKG2IEN($G(VSITPKG))
 Q:VSITPIEN<1 -1
 S VSITIEN=""
 S VSITIEN=$O(^DIC(150.9,1,3,"B",VSITPIEN,VSITIEN)) ;Parameter file IEN
 Q $S(VSITIEN<1:-1,1:VSITIEN)
 ;
ACTIVE(VSITPKGP) ;Pass pointer to that package in the Visit Tracking
 ; paramaters file and returns active flag.
 Q $P($G(^DIC(150.9,1,3,+VSITPKGP,3)),U,1)
 ;
PKG2IEN(VSITPKG) ;
 N XQOPT,X,Y,DA,DIC,DIE,DR
 I $G(VSITPKG)="" Q -1 ;Calling package name must be passed
 S X=VSITPKG
 S DIC="^DIC(9.4,",DIC(0)="MX"
 D ^DIC
 Q +Y
 ;
PKG(PKG,VALUE) ; -- Install package into multiple and add active flag
 I PKG=""!(VALUE="") Q -1
 N X,Y,DA,DIC,DIE,DR
 S X=PKG
 S DA(1)=1,DIC="^DIC(150.9,1,3,",DIC(0)="MXL",DIC("P")="150.93P"
 S DLAYGO=150.9
 D ^DIC
 I Y=-1 Q -1
 S DIE=DIC
 K DA
 S DA=+Y
 S DR="4///^S X=VALUE"
 D ^DIE
 Q 1_"^"_$P($G(^DIC(150.9,1,3,DA,3)),"^",1)
 ;
PKGON(PKG) ; -- Check value of ACTIVE FLAG
 I PKG="" Q -1
 N X,Y,DA,DIC
 S X=PKG
 S DA(1)=1
 S DIC="^DIC(150.9,1,3,"
 S DIC(0)="MX"
 S DIC("P")="150.93P"
 D ^DIC
 I Y=-1 Q -1
 Q $P($G(^DIC(150.9,1,3,+Y,3)),"^",1)
 ;
