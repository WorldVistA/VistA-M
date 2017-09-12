SD5348PT ;ALB/REW - SD*5.3*48 Post-init Checker ; 7 Aug 1996
 ;;5.3;Scheduling;**48**;AUG 13, 1993
EN ;entry point
 ;look through patient file's DD for potentially problematic ID nodes
 N SCFILE,SCFLG2
 D MES^XPDUTL("     Any command that 'talks' in the background will cause problems.")
 D MES^XPDUTL("        Using EN^DDIOL is OK.")
 D MES^XPDUTL("        Using the WRITE command will cause problems.")
 D BMES^XPDUTL("     Please review each of the ID nodes displayed below: ")
 F SCFILE=2,44,404.51,200 D
 .D IDCHK(SCFILE)
 IF $G(SCFLG2) D
 .D BMES^XPDUTL("     Please review asterisked nodes closely (they don't contain DDIOL).")
 .D MES^XPDUTL("     Replace any WRITE commands with ones that use 'EN^DDIOL'.")
 D BMES^XPDUTL("Prior to making any changes to File #200, Contact IRMFO Customer Support.")
 Q
 ;
IDCHK(FILE) ;look through a file's DD for potential ID nodes that 'talk'
 N SCSUB,SCND,SCFL,SCFLG3,SCSTAR
 S SCSUB=""
 D FILE^DID(FILE,"","NAME","SCFL")
 D MES^XPDUTL(" ")
 D BMES^XPDUTL(">>> WRITE-Type ID nodes in "_SCFL("NAME")_" File (#"_FILE_"):")
 F  S SCSUB=$O(^DD(FILE,0,"ID",SCSUB)) Q:SCSUB=""  S SCND=$G(^(SCSUB)) D
 .S SCFLG3=1 ;has one id-write node
 .N SCFLG
 .Q:(SCSUB=+SCSUB)  ;FileMan correctly handles these entries
 .IF SCND'["^DDIOL" D
 ..S SCFLG=1
 ..S SCFLG2=1
 .D MES^XPDUTL($S($G(SCFLG):"  ***",1:"     ")_"  ^DD("_FILE_",0,""ID"","_SCSUB_"):")
 .D MES^XPDUTL("          "_SCND)
 D:'$G(SCFLG3) MES^XPDUTL("    ...none.")  
 Q
 ;
