SDECALVR ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ; Add entries to VISIT related files.  from APCDALVAR
 ;
VPROV(SDEC) ;add provider to V PROVIDER file
 ;INPUT:
 ; SDEC("PRO") -  provider pointer to NEW PERSON file
 ; SDEC("PAT")  -  DFN pointer to PATIENT file
 ; SDEC("VST") -  visit ien pointer to VISIT file
 ; SDEC("TMP") -  (not used) input template "[SDECALVR 9000010.06 (ADD)]"
 ; SDEC("TPS")  -  "P"
 ; SDEC("TOA")  -  OPERATING/ATTENDING
 ; SDEC("CDT")  -  event date and time
 ;
 N SDFDA,SDIEN,SDIENS,SDMSG
 N SDCDT,SDCHK,SDPRO,SDTOA,SDTPS,SDVST
 N DFN
 ;validate provider (required)
 S SDPRO=$G(SDEC("PRO"))
 Q:'+SDPRO
 Q:'$D(^VA(200,SDPRO,0))
 ;validate patient (required)
 S DFN=$G(SDEC("PAT"))
 Q:'+DFN
 Q:'$D(^DPT(DFN,0))
 ;validate visit (required)
 S SDVST=$G(SDEC("VST"))
 Q:'+SDVST
 Q:'$D(^AUPNVSIT(SDVST,0))
 ;validate primary/secondary (required)
 S SDTPS=$G(SDEC("TPS"))
 Q:$S(SDTPS="P":0,SDTPS="S":0,1:1)
 ;validate operating attending (optional)
 S SDTOA=$G(SDEC("TOA"))
 S SDTOA=$S(SDTOA="A":"A",SDTOA="ATTENDING":"A",SDTOA="O":"O",SDTOA="OPERATING":"O",1:"")
 ;validate event date and time
 S SDCDT=$G(SDEC("CDT"))
 ;check for existing entry
 S SDCHK=$$VPROVFND(DFN,SDVST,SDPRO)
 S SDIENS=$S(+SDCHK:""""_SDCHK_",""",1:"""+1,""")
 ;
 S SDFDA="SDFDA(9000010.06,"_SDIENS_")"
 S @SDFDA@(.01)=SDPRO
 S @SDFDA@(.02)=DFN
 S @SDFDA@(.03)=SDVST
 S @SDFDA@(.04)=SDTPS
 S:SDTOA'="" @SDFDA@(.05)=SDTOA
 S:SDCDT'="" @SDFDA@(1201)=SDCDT
 ;D UPDATE^DIE("","SDFDA","SDIEN","SDMSG")
 D UPDATE^DIE("","SDFDA","SDIEN")
 ;
 ;I $D(SDMSG) S SDAFLG=2,SDAFLG("ERR")=".01^"_SDPRO_"^V PROVIDER ENTRY FAILED" Q
 Q
 ;
VPROVFND(DFN,SDVST,SDPRO)  ;find existing V PROVIDER entry
 N SDH1,SDH2,SDH3,SDRET
 S SDRET=0
 S SDH1="" F  S SDH1=$O(^AUPNVPRV("AD",SDVST,SDH1)) Q:SDH1=""  D
 .S SDH1(SDH1)=""
 Q:'$D(SDH1) SDRET
 S SDH2="" F  S SDH2=$O(^AUPNVPRV("C",DFN,SDH2)) Q:SDH2=""  D
 .S:$D(SDH1(SDH2)) SDH2(SDH2)=""  ;only matching entries will be in SDH2 array
 Q:'$D(SDH2) SDRET
 S SDH3="" F  S SDH3=$O(^AUPNVPRV("B",SDPRO,SDH3)) Q:SDH3=""  D
 .S:$D(SDH2(SDH3)) SDH3(SDH3)=""  ;only matching entries will be in SDH3 array
 Q:'$D(SDH3) SDRET
 S SDRET=$O(SDH3(9999999),-1)
 Q +SDRET
