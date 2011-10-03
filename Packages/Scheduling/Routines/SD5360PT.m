SD5360PT ;ALB/REW - SD*5.3*60 Post-installation ; 10-DEC-1996
 ;;5.3;Scheduling;**60,132**;SEP 25, 1993
 ;
EN ;entry point
 ;search TRANSMITTED OUTPATIENT ENCOUNTER ERROR file (#409.75) to find
 ;rejected encounters of type #510 -'Diagnosis Priority is not 1 or null
 ;if there is only one diagnosis associated with the encounter, the 
 ;diagnosis will be marked as 'primary' in the V POV file
 ; (#9000010.07) and the encounter will be re-transmitted
 ;
 D INTRO
 D SEARCH
 D EXIT
 Q
 ;
INTRO ;header info for output
 D MES^XPDUTL(">>>Searching TRANSMITTED OUTPATIENT ENCOUNTER ERROR File (#409.75)")
 D MES^XPDUTL("   for error code=510 (Diagnosis Priority is not '1' or null.)")
 D MES^XPDUTL("   All such encounters will be displayed.")
 D BMES^XPDUTL("   If there is exactly one DX for an encounter, it will be marked as primary")
 D MES^XPDUTL("   and the encounter marked for nightly transmission to Austin (NPCDB).")
 D MES^XPDUTL("")
 Q
SEARCH ;look for TRANSMITTED OUTPATIENT ENCOUNTER ENTRIES with error code 510
 ;   SC40975 = ien of TRANSMITTED OUTPATIENT ENCOUNTER ERROR (#409.75)
 ;   SC40943 = ien of OUTPATIENT DIAGNOSIS (#409.43) 
 ;   SCNODE  = zero node of #409.75
 ;   SCENODE = zero node of #409.68
 ;   SCPTR   = ptr value for error code for value of '510'
 N SCE,SCNONE,SC40975,SCNODE,SCPTR,SC40973
 S SCNONE=1
 S SCPTR=$O(^SD(409.76,"B","510",0))
 IF 'SCPTR D  Q
 .D BMES^XPDUTL(">>> Missing Cross-Reference for code 510 in file 409.76.  Aborting")
 S SC40975=0
 F  S SC40975=$O(^SD(409.75,SC40975)) Q:'SC40975  S SCNODE=$G(^(SC40975,0)) D
 .N SCDXDX,SC40943,SCENODE,SCDATE,Y
 .Q:$P(SCNODE,U,2)'=SCPTR  ;must be #510 error
 .S SCE=$P($G(^SD(409.73,+$P(SCNODE,U,1),0)),U,2) ;null or 409.68  ptr
 .;quit if a deleted encounter
 .Q:'SCE
 .S SCENODE=$G(^SCE(SCE,0))
 .IF ('$P(SCENODE,U,1))!('$P(SCENODE,U,2)) D  Q
 ..D BMES^XPDUTL("    File #409.68 ien: "_SCE_"  Corrupt/Missing")
 ..D MES^XPDUTL("    File #409.68 zero node: "_SCENODE)
 .S Y=+SCENODE D DD^%DT S SCDATE=Y
 .S SCNONE=0
 .D MES^XPDUTL("    File #409.68 ien: "_SCE_"   "_$P(^DPT($P(SCENODE,U,2),0),U,1)_"     "_SCDATE)
 .D DIAG^SCDXUTL1(SCE,"SCDXDX")
 .S SC40943=0
 .S SC40943=$O(SCDXDX(0))
 .IF $$PRIMPDX^SCDXUTL1(SCE)>0 D  Q
 ..D MES^XPDUTL("       ..Encounter has already been changed to have a primary dx")
 .IF 'SC40943 D  Q
 ..D MES^XPDUTL("       ..No diagnosis for this encounter")
 .IF $O(SCDXDX(SC40943)) D  Q
 ..D MES^XPDUTL("       ..Multiple diagnoses - can't know which is primary dx")
 .D MES^XPDUTL("       ..Making DX Primary DX & Resetting Transmission Flag")
 .Q:$G(SCTEST)  ;put in to allow test sites to first run as diagnostic
 .D PDX^PXAPIOE(SC40943,"P")  ;update outpatient diagnosis to be primary for enc
 .S SC40973=$$FINDXMIT^SCDXFU01(SCE) ;ptr to 409.73
 .D XMITFLAG^SCDXFU01(SC40973,0) ;resets transmission flag to yes
 D:SCNONE BMES^XPDUTL("  ...No errors of this type found")
 Q
 ;
EXIT ;final cleanup
 IF $L($G(XPDNM)) D
 .D BMES^XPDUTL("This post-install output is saved in the INSTALL File (#9.7)")
 .D MES^XPDUTL("under 'SD*5.3*60'.")
 D BMES^XPDUTL("This post-install routine may be re-run by calling EN^SD5360PT.")
 Q
