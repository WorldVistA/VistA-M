PX152PST ;ALB/SCK - PX*1.0*52 POST INIT INSTALL
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**52**;Aug 12, 1996
 Q
 ;
EN ; Replace blank space holder with PXCE GAF protocol
 N PX1,PX2,PX3,DA
 D BMES^XPDUTL("Removing the blank space holder from the PXCE SDAM MENU")
 D MES^XPDUTL("This space will be replaced by the GAF Score protocol.")
 ;
 S PX1=$O(^ORD(101,"B","PXCE SDAM MENU",0))
 I '$G(PX1) D  G ENQ
 . D MES^XPDUTL("Warning ... Unable to locate PXCE SDAM MENU protocol")
 ;
 S PX2=$O(^ORD(101,"B","PXCE BLANK 1",0))
 G:'$G(PX2) ENQ
 S PX3=$O(^ORD(101,PX1,10,"B",PX2,0))
 G:'$G(PX3) ENQ
 ;
 S DA(1)=PX1,DA=PX3
 S DIK="^ORD(101,"_DA(1)_",10,"
 D ^DIK K DIK
 D BMES^XPDUTL("Space holder removed...")
ENQ Q
