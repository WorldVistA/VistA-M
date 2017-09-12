SD5357PT ;ALB/REW - SD*5.3*57 Post-init Checker ; 7 Aug 1996
 ;;5.3;Scheduling;**57**;SEP 25, 1993
EN ;entry point
 ;look through HOSPITAL LOCATION File (#44) to find any active
 ;clinics without a stop code
 N SCCL,SCST,SCNM,SCNODE
 K ^TMP($J,"SC CLEANUP")
 D INTRO
 D SEARCH
 D PRINT
 D EXIT
 Q
 ;
INTRO ;header info for output
 D MES^XPDUTL("     Any clinic record in the HOSPITAL LOCATION File (#44)")
 D MES^XPDUTL("     without a STOP CODE field (#8) will cause errors if used.")
 D BMES^XPDUTL("    ***   Clinics should be created/updated via the Set up a Clinic option.")
 Q
 ;
SEARCH ;look for active clinics without active stop codes
 N SCCL,SC44NODE,SCST,SCNM,SCSTIN
 ;  SCCL - ptr to #44
 ;  SC44NODE - zero node of #44
 ;  SCST - ptr to 40.7 (not amis stop code)
 ;  SCNM - name of clinic
 ;  SCIN - clinic inactivation node: inactivation date^reactivation date
 ;  SCSTND - 0 node of #40.7 (stop code)
 S SCCL=0
 D BMES^XPDUTL(">>>Searching HOSPITAL LOCATION File...")
 F  S SCCL=$O(^SC("AC","C",SCCL)) Q:'SCCL  D
 .N SCIN,SCRE
 .S SCIN=$G(^SC(SCCL,"I"))
 .;quit if inactivate date exists & is before today & not reactive now
 .Q:$S('SCIN:0,(SCIN>DT):0,('$P(SCIN,U,2)):1,($P(SCIN,U,2)<DT):0,1:1)
 .S SC44NODE=$G(^SC(SCCL,0)),SCST=$P(SC44NODE,U,7),SCNM=$P(SC44NODE,U,1)
 .IF 'SCST D
 ..;for no stop code
 ..S ^TMP($J,"SC CLEANUP","B",SCNM,SCCL)=SCNM_" [#"_SCCL_"]"
 .ELSE  D
 ..S SCSTND=$G(^DIC(40.7,SCST,0))
 ..;if stopcode inactive date exists and is before today
 ..S:$P(SCSTND,U,3)&($P(SCSTND,U,3)<DT) ^TMP($J,"SC CLEANUP","B",SCNM,SCCL)=SCNM_" [#"_SCCL_"]  -- inactive STOP CODE: "_$P(SCSTND,U,1)_" ("_$P(SCSTND,U,2)_")"
 Q
 ;
PRINT ;display clinics with stop code problems
 N SCNM,SCCL,SCTMPND
 D BMES^XPDUTL("The following are ACTIVE clinics without an active STOP CODE field:")
 IF '$D(^TMP($J,"SC CLEANUP")) D
 .D MES^XPDUTL("   All active clinics have an active STOP CODE field.")
 .D MES^XPDUTL("   No further action is required.")
 S SCNM=""
 F  S SCNM=$O(^TMP($J,"SC CLEANUP","B",SCNM)) Q:SCNM=""  D
 .S SCCL=0
 .F  S SCCL=$O(^TMP($J,"SC CLEANUP","B",SCNM,SCCL)) Q:'SCCL  S SCTMPND=$G(^(SCCL))  D
 ..D MES^XPDUTL(SCTMPND)
 Q
 ;
EXIT ;final cleanup
 K ^TMP($J,"SC CLEANUP")
 D BMES^XPDUTL("This post-install output is saved in the INSTALL File (#9.7)")
 D MES^XPDUTL("under 'SD*5.3*57'")
 Q
