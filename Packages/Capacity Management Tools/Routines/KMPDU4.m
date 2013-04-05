KMPDU4 ;OAK/RAK - CM Tools Utilities ;2/17/04  09:54
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
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
 ;
REPDEF(KMPDY,KMPDREP) ; - rpc - get report definition
 ;---------------------------------------------------------------------------
 ; KMPDREP - Report Name for file #8973.3 (CP REPORT)
 ;           either field #.01 (NAME) or field #2.01 (DISPLAY NAME) can be
 ;           used.
 ;           
 ; KMPDY   - return array containing free text report definition
 ;---------------------------------------------------------------------------
 K KMPDY
 I $G(KMPDREP)="" S KMPDY(0)="[Missing Report Name]" Q
 ;
 N I,IEN,LN
 S IEN=$O(^KMPD(8973.3,"B",KMPDREP,0))
 S:'IEN IEN=$O(^KMPD(8973.3,"C",KMPDREP,0))
 I 'IEN S KMPDY(0)="["_KMPDREP_" is not a valid report name]" Q
 S I=0,LN=1
 F  S I=$O(^KMPD(8973.3,IEN,10,I)) Q:'I  D 
 .S KMPDY(LN)=$G(^KMPD(8973.3,IEN,10,I,0))
 .S LN=LN+1
 ;
 I '$D(KMPDY) S KMPDY(0)="<No Definition for Report>"
 ;
 Q
