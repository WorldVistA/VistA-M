DG531057P ;EDE/YMG - POST-INSTALL FOR DG*5.3*1057 ;07-JUN-2021
 ;;5.3;Registration;**1057**;Aug 13, 1993;Build 17
 ;
 Q
 ;
EN ; entry point
 D PTFERR
 D RIT
 Q
 ;
PTFERR ; update PTF errors in file 45.64
 N FDA,IEN
 D MES^XPDUTL("Updating error messages in file 45.64...")
 ; error 437
 S IEN=$O(^DGP(45.64,"B",437,""))
 I IEN S FDA(45.64,IEN_",",.02)="Date of surgery coded greater than 72 hours prior to admission date." D FILE^DIE("","FDA")
 ; error 637
 S IEN=$O(^DGP(45.64,"B",637,""))
 I IEN K FDA S FDA(45.64,IEN_",",.02)="Date of procedure coded greater than 72 hours prior to admission date." D FILE^DIE("","FDA")
 ; error 640
 S IEN=$O(^DGP(45.64,"B",640,""))
 I IEN K FDA S FDA(45.64,IEN_",",.02)="Date of procedure coded later than discharge date." D FILE^DIE("","FDA")
 D MES^XPDUTL("Done.")
 Q
 ;
RIT ; recompile input templates
 N DMAX,X,Y,NM
 D MES^XPDUTL("Recompiling PTF input templates...")
 F NM="DG501-10D","DG401-10P","DG501F","DG501F-10D","DG701-10D" D
 .S Y=$$FIND1^DIC(.402,,"X",NM,"B") I Y'>0 Q
 .S X=$P($$GET1^DIQ(.402,Y_",",1815),U,2,99) I X="" Q
 .S DMAX=$$ROUSIZE^DILF
 .D EN^DIEZ
 .Q
 D MES^XPDUTL("Recompile completed.")
 Q
