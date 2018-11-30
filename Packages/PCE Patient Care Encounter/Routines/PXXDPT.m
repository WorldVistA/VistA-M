PXXDPT ;ISL/DLT - Synchronize Patient File (2) and IHS Patient File (#9000001) ;10/12/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,211**;Aug 12, 1996;Build 244
 ;;1.0;PCE Patient/IHS Subset;;Nov 01, 1994
 ;
SETSSN ; Entry Point from PX09 cross-reference on File 2, field .09
 ;to define patient entry in 9000001.
 D CHECK Q:'$T
EN Q:PX=""
 ;DA is the DFN and PX is the SSN.
 N FDA,FDAIEN,MSG,PXXLOC
 S PXXLOC=+$P($G(^PX(815,1,"PXPT")),"^",1)
 I PXXLOC=0 S PXXLOC=$P($$SITE^VASITE,U,1)
 S FDAIEN(1)=DA,FDAIEN(2)=PXXLOC
 S FDA(9000001,"+1,",.01)=DA
 S FDA(9000001.41,"+2,+1,",.01)=PXXLOC
 S FDA(9000001.41,"+2,+1,",.02)=PX
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D
 . D EN^DDIOL("Could not create the PATIENT/IHS entry, due to the following error:")
 . D AWRITE^PXUTIL("MSG")
 Q
 ;
KILLSSN ;Entry point from PX09 cross-reference on File 2, field .09 to kill SSN
 ;information from 9000001.
 D CHECK Q:'$T
 N DFN S DFN=+DA N DA,X
 S X=PX,DA(1)=DFN,DA=$P($G(^PX(815,1,"PXPT")),"^",1) Q:'+DA  X ^DD(9000001.41,.02,1,1,2)
 Q
 ;
CHECK ;Check for appropriate variables and globals defined before proceeding
 I $D(^AUPNPAT),$G(DA),$D(^DPT(DA))
 Q
 ;
LOAD ;Logic to use during install to initially load ^AUPNPAT(
 S PXFG=0
 S DA=+$P($G(^PX(815,1,"PXPT")),"^",2)
 F  S DA=$O(^DPT(DA)) Q:'DA  Q:PXFG=1  S PX=$P($G(^DPT(DA,0)),"^",9) D SETSSN D
 .S $P(^PX(815,1,"PXPT"),"^",2)=DA
 .I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,PXFG=1
 I PXFG'=1 S $P(^PX(815,1,"PXPT"),"^",2)=0
 K DR,DIE,DA,PXDA,PXFG
 Q
