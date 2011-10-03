XOBWPST ;ALB/MJK - HWSC - Post-Init ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
EN ;  -- main entry point for post-init
 NEW XOBSTAT
 ;
 ; -- delete all classes in xobw package
 DO DELETE()
 ;
 ; -- build primary key indices (for those who had installed early developer previews)
 DO INDEX()
 ;
 ; -- delete IP ADDRESS field (for those who had installed early developer previews)
 DO DELIP()
 ;
 ; -- remove HtttpProxy* fields and 2 node (for those who had installed early developer previews)
 DO DELHP()
 ;
 ; -- load hwsc support classes (mapped FM classes, etc.)
 NEW XOBSTAT
 SET XOBSTAT=$$IMPORT^XOBWLIB1($$GETDIR(),$$SUPPORT^XOBWENV())
 IF 'XOBSTAT DO  GOTO ENQ
 . DO BMES^XPDUTL("Error occurred during the importing of support classes file:")
 . DO MES^XPDUTL("  Directory: "_$$GETDIR())
 . DO MES^XPDUTL("  File Name: "_$$SUPPORT^XOBWENV())
 . DO MES^XPDUTL("      Error: "_$PIECE(XOBSTAT,"^",2))
 . DO MES^XPDUTL(" o  Classes not imported.")
 ELSE  DO
 . DO MES^XPDUTL(" o  Support classes imported successfully.")
 . DO MES^XPDUTL(" ")
 ;
ENQ ;
 QUIT
 ;
DELETE() ; -- delete classes for clean slate and remove previous releases
 NEW XOBSTAT
 ; -- delete all classes in xobw package
 DO BMES^XPDUTL(" o  Deleting xobw classes:")
 ;
 SET XOBSTAT=$SYSTEM.OBJ.DeletePackage("xobw")
 DO BMES^XPDUTL("       ...[xobw] deletion "_$SELECT(XOBSTAT:"finished successfully.",1:"failed."))
 DO MES^XPDUTL("")
 QUIT
 ;
INDEX() ; -- build indices if data exists but index not defined
 NEW XOBFILE,DIK,DA,XOBCNT
 ; -- primary key indices for 18.02,18.12
 FOR XOBFILE=18.02,18.12 DO
 . IF $ORDER(^XOB(XOBFILE,0)),$ORDER(^XOB(XOBFILE,"PRIMARY",""))="" DO
 . . SET DIK="^XOB("_XOBFILE_","
 . . SET DIK(1)=".01^PRIMARY"
 . . DO ENALL^DIK
 . . DO BMES^XPDUTL(" o PRIMARY index set for "_$SELECT(XOBFILE="18.02":"WEB SERVICE",1:"WEB SERVER")_" (#"_XOBFILE_") file.")
 ; AB index for 18.121
 IF $ORDER(^XOB(18.12,0)),$ORDER(^XOB(18.12,"AB",""))="" DO
 . SET XOBCNT=0,DA(1)=0 FOR  SET DA(1)=$ORDER(^XOB(18.12,DA(1))) Q:DA(1)'>0  DO
 . . SET DIK="^XOB(18.12,"_DA(1)_",100,"
 . . SET DIK(1)=".01^AB"
 . . DO ENALL^DIK SET XOBCNT=XOBCNT+1
 . DO BMES^XPDUTL(" o AB whole-file index set for "_XOBCNT_" AUTHORIZED WEB SERVICES (#18.121) subfiles.")
 QUIT
 ;
DELIP() ; -- move IP ADDRESS to SERVER field if blank and delete IP ADDRESS (#.02)
 NEW XOBDA,XOBDA0,XOBY,XOBERR
 ; -- make sure IP ADDRESS field is present
 DO FIELD^DID(18.12,.02,"N","LABEL","XOBY","XOBERR")
 IF $GET(XOBY("LABEL"))'="IP ADDRESS" GOTO DELIPQ
 ;
 ; -- move data
 SET XOBDA=0
 FOR  SET XOBDA=$ORDER(^XOB(18.12,XOBDA)) Q:'XOBDA  SET XOBDA0=$GET(^(XOBDA,0)) DO
 . NEW SERVER,IP
 . SET SERVER=$PIECE(XOBDA0,"^",4)
 . SET IP=$PIECE(XOBDA0,"^",2)
 . IF IP]"" DO
 . . NEW XOBIENS,XOBFDA,XOBERR
 . . SET XOBIENS=XOBDA_","
 . . ; -- Set up array with field values
 . . IF SERVER="" SET XOBFDA(18.12,XOBIENS,.04)=IP
 . . SET XOBFDA(18.12,XOBIENS,.02)="@"
 . . DO FILE^DIE("","XOBFDA","XOBERR")
 DO BMES^XPDUTL(" o  IP ADDRESS (#.02) field data moved to SERVER (#.04) if SERVER blank")
 DO MES^XPDUTL("    in WEB SERVER (#18.12) file")
 ;
 ; -- delete field
 DO DELFLD(.02,"IP ADDRESS")
DELIPQ ; 
 QUIT
 ; 
DELHP() ; -- remove HtttpProxy* fields and 2 node
 NEW XOBX
 ; -- delete HtttpProxy* field definitions
 DO DELFLD(2.01,"HttpProxyHTTPS")
 DO DELFLD(2.02,"HttpProxyServer")
 DO DELFLD(2.03,"HttpProxyPort")
 ; -- remove 2 nodes
 NEW XOBDA
 SET XOBDA=0
 FOR  SET XOBDA=$ORDER(^XOB(18.12,XOBDA)) Q:'XOBDA  KILL ^XOB(18.12,XOBDA,2)
 QUIT
 ;
DELFLD(XOBNUM,XOBLABEL) ; -- delete a field from WEB SERVER file
 NEW XOBY,XOBERR,DIK,DA
 DO FIELD^DID(18.12,XOBNUM,"N","LABEL","XOBY","XOBERR")
 IF $GET(XOBY("LABEL"))'=XOBLABEL GOTO DELFLDQ
 SET DIK="^DD(18.12,"
 SET DA=XOBNUM
 SET DA(1)=18.12
 DO ^DIK
 DO BMES^XPDUTL(" o  "_XOBLABEL_" (#"_XOBNUM_") field deleted from WEB SERVER (#18.12) file")
DELFLDQ ;
 QUIT
 ;
GETDIR() ; -- get directory where install files are located
 QUIT $$DEFDIR^%ZISH($G(XPDQUES("POSXMLDIR"),""))
 ;
