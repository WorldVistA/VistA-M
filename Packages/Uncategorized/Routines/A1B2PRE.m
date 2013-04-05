A1B2PRE ;ALB/MJK - ODS PRE-INIT Version 1.5; 14 JAN 1991
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
EN ; -- pre-init entry point
 D REL,DD:$D(DIFQ)
 Q
 ;
REL ; -- check if version 1 was loaded
 ;
 F A1B2PKG=0:0 S A1B2PKG=+$O(^DIC(9.4,"C","A1B2",A1B2PKG)) Q:'A1B2PKG  I $D(^DIC(9.4,A1B2PKG,0)),$P(^(0),U)="OPERATION DESERT SHIELD" Q
 I '$D(^DIC(9.4,A1B2PKG,0)) D MES G RELQ
 I $S('$D(^DIC(9.4,A1B2PKG,"VERSION")):1,1:+^("VERSION")<1) D MES G RELQ
RELQ K A1B2PKG Q
 ;
MES ; -- error message
 W !!,*7,"You must load version 1 of 'OPERATION DESERT SHIELD' package first."
 W !!,"Initialization aborted." K DIFQ
 Q
 ;
DD ; -- del 11500.2
 W !,">>> Deleting ODS ADMISSIONS file data dictionary..."
 S DIU=11500.2,DIU(0)="" D EN^DIU2 K DIU
 W !,"    Data dictionary will be restored by inits."
 Q
 ;
