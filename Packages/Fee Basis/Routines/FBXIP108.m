FBXIP108 ;WOIFO/SAB - PATCH INSTALL ROUTINE ;6/17/2009
 ;;3.5;FEE BASIS;**108**;JAN 30, 1995;Build 115
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PR ; pre-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="OPT" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP108")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
OPT ; pre-install: remove options from supervisor menu
 ; ICR 1157 for $$DELETE^XPDMENU()
 N FBMENU,FBX
 D BMES^XPDUTL("  Updating Supervisor Main Menu...")
 S FBMENU="FBAA SUPERVISOR OPTIONS"
 S FBX=$$DELETE^XPDMENU(FBMENU,"FBUC ADD NEW PERSON")
 S FBX=$$DELETE^XPDMENU(FBMENU,"FBUC DISAPPROVAL REASONS FILE")
 S FBX=$$DELETE^XPDMENU(FBMENU,"FBUC DISPOSITIONS FILE")
 S FBX=$$DELETE^XPDMENU(FBMENU,"FBUC REQUEST INFO FILE")
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="HRO","PAR" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP108")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
HRO ; Add HERO contracts
 ; ICR 2541 for $$KSP^XUPARAM
 N FBDINST,FBVISN
 ; get default institution ien
 S FBDINST=$$KSP^XUPARAM("INST")
 ; determine VISN
 S FBVISN=$$VISN(FBDINST)
 ; Enter HERO data if VISN is 8, 16, 20, or 23
 I "^VISN 8^VISN 16^VISN 20^VISN 23^"[("^"_FBVISN_"^") D
 . N FBCNTRN,FBFDA,FBV,FBVID,FBVNM
 . ; Delta contract
 . S FBCNTRN="VA101(049A3)-P-0269"
 . S FBVID="942761537"
 . S FBVNM="Delta"
 . I $D(^FBAA(161.43,"B",FBCNTRN)) D
 . . D BMES^XPDUTL(FBCNTRN_" is already set up as a contract.")
 . I '$D(^FBAA(161.43,"B",FBCNTRN)) D
 . . D BMES^XPDUTL("  Adding "_FBCNTRN_" as a contract for "_FBVNM_"...")
 . . S FBV=$$FIND1^DIC(161.2,"","X",FBVID,"C")
 . . I 'FBV D
 . . . D MES^XPDUTL("    Can't find Fee Basis Vendor with ID "_FBVID)
 . . . D MES^XPDUTL("    The contract must be manually edited to add")
 . . . D MES^XPDUTL("    the applicable vendor.")
 . . S FBFDA(161.43,"+1,",.01)=FBCNTRN
 . . S FBFDA(161.43,"+1,",2)="A"
 . . S:FBV FBFDA(161.433,"+2,+1,",.01)=FBV
 . ; HVHS contract
 . S FBCNTRN="VA101049A3-P-0270"
 . S FBVID="208418853"
 . S FBVNM="HVHS"
 . I $D(^FBAA(161.43,"B",FBCNTRN)) D
 . . D BMES^XPDUTL(FBCNTRN_" is already set up as a contract.")
 . I '$D(^FBAA(161.43,"B",FBCNTRN)) D
 . . D BMES^XPDUTL("  Adding "_FBCNTRN_" as a contract for "_FBVNM_"...")
 . . S FBV=$$FIND1^DIC(161.2,"","X",FBVID,"C")
 . . I 'FBV D
 . . . D MES^XPDUTL("    Can't find Fee Basis Vendor with ID "_FBVID)
 . . . D MES^XPDUTL("    The contract must be manually edited to add")
 . . . D MES^XPDUTL("    the applicable vendor.")
 . . S FBFDA(161.43,"+3,",.01)=FBCNTRN
 . . S FBFDA(161.43,"+3,",2)="A"
 . . S:FBV FBFDA(161.433,"+4,+3,",.01)=FBV
 . I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 Q
 ;
VISN(FBSTAI) ; VISN extrinsic function
 ; ICR 2171 for PARENT^XUAF4
 ; input   - IEN of an entry in the INSTITUTION (#4) file
 ; returns - the name of the parent VISN or a null value
 N FBARR,FBRET,FBVISNI
 S FBRET=""
 I FBSTAI D
 . D PARENT^XUAF4("FBARR","`"_FBSTAI,"VISN")
 . S FBVISNI=$O(FBARR("P",""))
 . I FBVISNI S FBRET=$P(FBARR("P",FBVISNI),"^")
 Q FBRET
 ;
PAR ; Populate new parameter fields
 N FBFDA,FBY
 S FBY=$G(^FBAA(161.4,1,"FBNUM"))
 I $P(FBY,"^",3)="" S FBFDA(161.4,"1,",17)=85
 I $P(FBY,"^",3)>85 S FBFDA(161.4,"1,",17)=85
 I $P(FBY,"^",4)="" S FBFDA(161.4,"1,",17.1)=42
 I $P(FBY,"^",5)="" S FBFDA(161.4,"1,",17.2)=61
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 Q
 ;FBXIP108
