KMPDU4 ;OAK/RAK - CM Tools Utilities ;2/17/04  09:54
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
ASSCROU(KMPDRES,KMPDIEN,KMPDROU) ;-- add/remove Associate Routines to file 8972.1
 ;-----------------------------------------------------------------------
 ; KMPDIEN... Ien for file #8972.1 (CM CODE EVALUATOR).
 ; KMPDROU(). Array containing list of routines for this Ien.
 ;-----------------------------------------------------------------------
 ;
 K KMPDRES
 I '$G(KMPDIEN) S KMPDRES(0)="[IEN not defined]" Q
 I '$D(^KMPD(8972.1,+KMPDIEN,0)) D  Q
 .S KMPDRES(0)="[IEN #"_KMPDIEN_" not defined for this file]"
 ;
 N DA,DIK,FDA,I,MESSAGE,ZIEN
 ;
 ; delete all entries in ASSOCIATED ROUTINE multiple (#11)
 S DA=0,DA(1)=+KMPDIEN,DIK="^KMPD(8972.1,"_+KMPDIEN_",11,"
 F  S DA=$O(^KMPD(8972.1,+KMPDIEN,11,DA)) Q:'DA  D ^DIK
 ;
 ; add routines to list
 S I=""
 F  S I=$O(KMPDROU(I)) Q:I=""  I KMPDROU(I)]"" D 
 .K FDA
 .S FDA($J,8972.111,"+2,"_KMPDIEN_",",.01)=KMPDROU(I)
 .D UPDATE^DIE("","FDA($J)",.ZIEN,"MESSAGE")
 ;
 S KMPDRES(0)="<Update Complete>"
 ;
 Q
