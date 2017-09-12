SCMCHL7K ;ALB/DJS - STOP PCMM HL7 TRANSMISSIONS;08/18/14
 ;;5.3;Scheduling;**624**;AUG 13, 1993;Build 19
 ;
 ; #1157 [Supported] Kernel XPDMENU call
 ; #2051 - Database Server API: Lookup Utilities (DIC)
 ; #6121 - Remove Task from #19.2
 ; SCOPT - Menu option to mark out-of-order
 ; SCTXT - Out-of-order message text
 ; PLAN - Turn off Logical Links, empty HL7 event file and HL7 error file,
 ;        set all HL7 related options Out-Of-Order, set all HL7 Protocols
 ;        Out-Of-Order.
 Q
EN ; Entry Point
 ;
 D LOGLNK,EMFILE,OPTOUT,DELETE
 D BMES^XPDUTL("Patch Completed")
 Q
 ;
LOGLNK ; This Routine will turn off Logical Links for PCMM.
 N SCMCL,SCMCVAL,DA,DR
 S SCMCL="1" F  S SCMCL=$O(^HLCS(870,SCMCL)) Q:SCMCL'>0  D
 . I $P(^HLCS(870,SCMCL,0),U,1)="PCMM" D
 .. N DIE S DIE="^HLCS(870,",DA=SCMCL,DR="4.5///0;14///1" D ^DIE
 .. D BMES^XPDUTL("Logical Links for PCMM HL7 have been shut down and Autostart disabled.")
 Q
 ;
EMFILE ;Empty HL7 Event File and Error File
 ;
 N SCMCN,SCMCL,SCMCVAL,SCMCZ,SCFN,DA
 F SCMCN=1:1 S SCFN=$P($TEXT(FILELIST+SCMCN),";;",2) Q:SCFN="$$END"!(SCFN="")  D
 . S ^XTMP("SD",$J,0)=$$FMADD^XLFDT(DT+90)_"^"_DT_"^copy of SCPT global deleted"
 . M ^XTMP("SD",$J,"SCPT",SCFN)=^SCPT(SCFN)
 . K ^SCPT(SCFN)
 . S ^SCPT(SCFN,0)=^XTMP("SD",$J,"SCPT",SCFN,0)
 . S SCMCZ=$P(^SCPT(SCFN,0),U,1,2)_"^0^0"
 . S ^SCPT(SCFN,0)=SCMCZ
 D BMES^XPDUTL("All PCMM HL7 related data files have been deleted.")
 Q
 ; 
OPTOUT ;Set option out-of-order
 N SCMCN,SCOPT,SCTXT
 S SCTXT="This functionality is now accomplished by CDW/VSSC."
 F SCMCN=1:1 S SCOPT=$P($TEXT(OPTLIST+SCMCN),";;",2) Q:SCOPT="$$END"!(SCOPT="")  D
 . D OUT^XPDMENU(SCOPT,SCTXT)  ;Mark option out-of-order
 D BMES^XPDUTL("Legacy PCMM options were marked Out-of-Order.")
 Q
 ;
DELETE ;Delete Task
 N SCTSK,SCOPT,DA,DIK
 S SCTSK="SCMC PCMM HL7 TRANSMIT"
 S SCOPT=$O(^DIC(19,"B",SCTSK,""))
 S DA=""
 F  S DA=$O(^DIC(19.2,"B",SCOPT,DA)) Q:'+DA  D
 . S ^XTMP("SCTSK",$J,0)=$$FMADD^XLFDT(DT+90)_"^"_DT_"^copy of PCMM HL7 Task^"_DA
 . M ^XTMP("SCTSK",$J,"DIC",19.2,DA)=^DIC(19.2,DA)
 . S DIK="^DIC(19.2," D ^DIK
 . D BMES^XPDUTL("Legacy task "_SCTSK_" Deleted.")
 Q
 ;
OPTLIST ;OPTIONS LIST
 ;;SCMC HL7 MENU
 ;;SCMC PCMM ERR CODE REPORT
 ;;SCMC PCMM HL7 TRANSMIT
 ;;SCMC PCMM REJECT TRANS MENU
 ;;SCMC PCMM TRANS ERROR PROC
 ;;SCMC PCMM TRANS ERROR REPORT
 ;;$$END
 ;
FILELIST ;LIST OF FILES TO EMPTY
 ;;404.471
 ;;404.48
 ;;404.49
 ;;$$END
