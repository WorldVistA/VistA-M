SD5364PT ;ALB/REW - SD*5.3*64 Post-installation ; 5 OCT 1996
 ;;5.3;Scheduling;**64**;SEP 25, 1993
EN ;entry point
 ;look through TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73) to find
 ;encounters without an encounter that occured prior to 10/1/96
 ;delete all such entries that are awaiting transmittal
 ;
 D INTRO
 D SEARCH
 D EXIT
 Q
 ;
INTRO ;header info for output
 D MES^XPDUTL("     The TRANSMITTED OUTPATIENT ENCOUNTER File (#409.73)")
 D MES^XPDUTL("     should only contain records for visits after 10/1/96.")
 D BMES^XPDUTL("     This deletes records in this file for all visits prior to 10/1/96")
 Q
SEARCH ;look for erroneous OUTPATIENT ENCOUNTER ENTRIES
 ;   SCE  = ien of OUTPATIENT ENCOUNTER (#409.68)
 ;   SCD  = ien of DELETED OUTPATIENT ENCOUNTER (#409.74)
 ;   SCCNT = Count of actually deleted records
 ;   SCNODE = Zero Node of Associated File (409.68 or 409.74)
 ;   SCTEST = Testing parameter to prevent deletion & list records
 ;
 N SCE,SC40973,SCCNT,SCNODE,SCD
 D:$G(SCTEST) BMES^XPDUTL("*** Warning !!! with SCTEST flag, no records are deleted!!")
 D:$G(SCTEST) MES^XPDUTL("    Clear the SCTEST variable to delete records and avoid listing records")
 D BMES^XPDUTL(">>>OUTPATIENT ENCOUNTER File (#409.68) related entries...")
 S SCCNT=0
 S SCE=0 F  S SCE=$O(^SD(409.73,"AENC",SCE)) Q:'SCE  D
 .S SCNODE=$G(^SCE(SCE,0))
 .Q:+SCNODE'<2961001
 .S SC40973=+$O(^SD(409.73,"AENC",SCE,""))
 .D:$G(SCTEST) MES^XPDUTL("   409.73 IEN: "_SC40973_"   409.68 IEN:  "_SCE_"   Enc Date: "_+SCNODE)
 .IF '$G(SCTEST) IF $$DELXMIT^SCDXFU03(SC40973,0) D
 ..D MES^XPDUTL("   409.73 IEN: "_SC40973_"   409.68 IEN:  "_SCE_"   Enc Date: "_+SCNODE)
 ..D MES^XPDUTL("   ***Entry could not be deleted. Please check.")
 .S SCCNT=SCCNT+1
 D BMES^XPDUTL("        "_SCCNT_" records deleted related to File #409.68")
 S SCCNT=0
 D BMES^XPDUTL(">>>DELETED OUTPATIENT ENCOUNTER File (#409.74) related entries...")
 S SCD=0 F  S SCD=$O(^SD(409.73,"ADEL",SCD)) Q:'SCD  D
 .S SCNODE=$G(^SD(409.74,SCD,0))
 .Q:+SCNODE'<2961001
 .S SCCNT=SCCNT+1
 .S SC40973=+$O(^SD(409.73,"ADEL",SCD,""))
 .D MES^XPDUTL("   409.73 IEN: "_SC40973_"   409.74 IEN:  "_SCD_"   Enc Date: "_+SCNODE)
 .IF '$G(SCTEST) IF $$DELXMIT^SCDXFU03(SC40973,0) D
 ..D MES^XPDUTL("   ***Entry could not be deleted. Please check.")
 D BMES^XPDUTL("        "_SCCNT_" records deleted related to File #409.74")
 Q
PRINT ;
 Q
EXIT ;final cleanup
 D BMES^XPDUTL("This post-install output is saved in the INSTALL File (#9.7)")
 D MES^XPDUTL("under 'SD*5.3*64'")
 Q
