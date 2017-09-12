PSB3P58 ;BIRMINGHAM/GN - POST INSTALL FOR PSB-3-58 ;4/28/11 11:23am
 ;;3.0;BAR CODE MED ADMIN;**58**;Mar 2004;Build 37
 ;
 ; Init New XPAR Divisional parameter for all BCMA active Medical
 ; Center Divisions.
 ;
 ;    PSB NON-NURSE VERIFIED PROMPT = "N"
 ;      Emulates how BCMA worked prior to this patch.
 ;
 ; Reference/IA
 ; File #40.8/2817
 ;
BEGIN ;set all medical center divisions Non-ver prompts if BCMA online
 N ENT,DV,T5,T10,T20
 S T5="",$P(T5," ",5)=" ",T10="",$P(T10," ",10)=" ",T20="",$P(T20," ",20)=" "
 D MES^XPDUTL("")
 D MES^XPDUTL("*** PSB*3*58 POST INSTALL NOW RUNNING ***")
 D LIST(0)
 D LIST(1) H 6
 Q
 ;
LIST(UPD) ;update or list
 ; input: UPD=1 update, else list only
 N FOUND,WORD S FOUND=0,WORD=$S(UPD:"After",1:"Before")
 D MES^XPDUTL("")
 D MES^XPDUTL(T20_WORD_" update")
 D MES^XPDUTL("")
 ;loop thru all medical divisions and only update those that use BCMA
 F DV=0:0 S DV=$O(^DG(40.8,"AD",DV)) Q:'DV  D
 . S ENT=DV_";DIC(4,"
 . Q:'$$GET^XPAR(ENT,"PSB ONLINE")
 . S FOUND=1
 . I UPD,$$GET^XPAR(ENT,"PSB NON-NURSE VERIFIED PROMPT")="" D
 .. D EN^XPAR(ENT,"PSB NON-NURSE VERIFIED PROMPT",1,"N")
 . D MES^XPDUTL("  "_$E($P(^DIC(4,+ENT,0),U)_T20,1,25)_T10_$$GET^XPAR(ENT,"PSB NON-NURSE VERIFIED PROMPT",,"E"))
 D:'FOUND MES^XPDUTL(T5_"** NO DIVISIONS FOUND WITH BCMA ONLINE **")
 D MES^XPDUTL("")
 Q
