PRCTDELA ;MNTFW/RGB - STOP TASKED OPTION PRCHLO CLO PROCUREMENT;02/18/16
 ;;5.1;IFCAP;**194**;Feb 09, 1996;Build 3
 ;CLRS FTP server has been shut down. The system will now utilize the 
 ;CDW to gather the data obtained from the GIP job and it extracts 
 ;the Procurement portion
 ;
 Q
EN ; Entry Point
 ;
 D DELETE
 D BMES^XPDUTL("Task option removal completed")
 Q
 ;
 ;
DELETE ;Delete Task
 N PRCHTSK,PRCHOPT,DA,DIK
 S PRCHTSK="PRCHLO CLO PROCUREMENT"
 S PRCHOPT=$O(^DIC(19,"B",PRCHTSK,"")) Q:'PRCHOPT
 S DA="" S:'$G(DT) DT=$$DT^XLFDT
 F  S DA=$O(^DIC(19.2,"B",PRCHOPT,DA)) Q:'+DA  D
 . S ^XTMP("PRCHTSKA",$J,0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^copy of PRCHLO CLO PROCUREMENT Task^"_DA
 . M ^XTMP("PRCHTSKA",$J,"DIC",19.2,DA)=^DIC(19.2,DA)
 . S DIK="^DIC(19.2," D ^DIK
 . D BMES^XPDUTL("Legacy task "_PRCHTSK_" Deleted.")
 Q
 ;
