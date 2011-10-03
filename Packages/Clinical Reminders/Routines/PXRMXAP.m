PXRMXAP ; SLC/PJH - Reminder Reports APIs;07/29/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ; Called from PXRMSU
 ;
FACT ;Check PCMM Team ^SCTM(404.51 for facility ; DBIA #2795
 S DIC("S")=DIC("S")_",$D(PXRMFACN(+$P(^(0),U,7)))"
 Q
 ;
LOCN(ARRAY) ;Check for mixed inpatient/outpatient locations ; DBIA #10040
 N IC,IEN,MIXED,TYPE
 S IC=0,MIXED=0,TYPE=0
 F  S IC=$O(ARRAY(IC)) Q:IC=""  D  Q:MIXED
 .S IEN=$P(ARRAY(IC),U,2) Q:IEN=""
 .I TYPE=0,$D(^SC(IEN,42)) S TYPE="INPATIENT" Q
 .I TYPE=0,'$D(^SC(IEN,42)) S TYPE="OUTPATIENT" Q
 .I TYPE="INPATIENT",'$D(^SC(IEN,42)) S MIXED=1 Q
 .I TYPE="OUTPATIENT",$D(^SC(IEN,42)) S MIXED=1 Q
 Q MIXED
 ;
 ; Called from PXRMSEO
 ;
FAC(TIEN) ; Get Facility for the PCMM Team ; DBIA #2795
 Q $P($G(^SCTM(404.51,TIEN,0)),U,7)
 ;
PCASSIGN(DFN) ; Assigned to Provider as Primary Care ; DBIA #1916
 N PCVAR,PC S PC=0
 S PCVAR=$$OUTPTPR^SDUTL3(DFN)
 I PCVAR]"" S:$P(PCVAR,U)=PCM PC=1
 Q PC
 ; 
PTTM(TIEN,SCERR) ; Build list of Teams Patients ; DBIA #1916
 Q $$PTTM^SCAPMC(TIEN,"SCDT","^TMP($J,""PCM"")",.SCERR)
 ;
PTPR(PIEN,PXRMREP) ; Build list of practitioners patients ; DBIA #1916
 N SCERRD,OK
 S OK=$$PTPR^SCAPMC(PIEN,"SCDT","","","^TMP($J,""PCM"")",.SCERRD)
 ;
 ; Determine Associated Clinic from Team Position/Team Position Assign
 I PXRMREP="D" D
 .N SUB,SCTP,SCTPA,DCLN
 .S SUB=0
 .F  S SUB=$O(^TMP($J,"PCM",SUB)) Q:'SUB  D
 ..S SCTP=$P(^TMP($J,"PCM",SUB),U,3) Q:SCTP=""
 ..S SCTPA=$P($G(^SCPT(404.43,SCTP,0)),U,2) Q:SCTPA=""  ; DBIA #2811
 ..S DCLN=$P($G(^SCTM(404.57,SCTPA,0)),U,9) ; DBIA #2810
 ..S $P(^TMP($J,"PCM",SUB),U,7)=DCLN
 Q
 ;
 ; Called from PXRMXD/PXRMYD
 ;
INP(INP,PXRMLOCN) ;
 ;If selected locations check for wards ; DBIA #10040
 N LOC,WARD
 S LOC="",WARD=0
 ; All locations must be wards for the prompt to display
 F  S LOC=$O(PXRMLOCN(LOC)) Q:LOC=""  D  Q:'WARD
 .S WARD=0 I $D(^SC(LOC,42)) S WARD=1
 Q WARD
 ;
 ; Called from PXRMXSEL/PXRMYSEL
 ;
FACL(LOCIEN) ; Get locations facility ; DBIA #2804
 N DIV
 I $P($G(^SC(LOCIEN,0)),U,4)'="" Q $P($G(^SC(LOCIEN,0)),U,4)
 S DIV=$P($G(^SC(LOCIEN,0)),U,15) Q:DIV="" ""
 Q $P($G(^DG(40.8,DIV,0)),U,7)
 ;
WARD(LOCIEN,ARRAY) ;Get list of patients if location is a ward ;DBIA #10035
 N WARDIEN,WARDNAM,DFN
 S WARDIEN=$G(^SC(LOCIEN,42)) Q:WARDIEN=""
 S WARDNAM=$P($G(^DIC(42,WARDIEN,0)),U) Q:WARDNAM=""
 S DFN=""
 F  S DFN=$O(^DPT("CN",WARDNAM,DFN)) Q:DFN=""  S ARRAY(DFN)=""
 Q
 ;
ADM(LOCIEN,ARRAY,BD,ED) ;Get list of admissions to ward ; DBIA #10040,1480
 N WARDIEN,DA,DATA,DFN
 S WARDIEN=$G(^SC(LOCIEN,42)) Q:WARDIEN=""
 F  S BD=$O(^DGPM("ATT1",BD)) Q:BD>ED  Q:BD=""  D
 .S DA=""
 .F  S DA=$O(^DGPM("ATT1",BD,DA)) Q:DA=""  D
 ..S DATA=$G(^DGPM(DA,0)) Q:DATA=""
 ..I $P(DATA,U,6)'=WARDIEN Q
 ..S DFN=$P(DATA,U,3) Q:DFN=""
 ..S ARRAY(DFN)=""
 Q
 ;
LCHL(INP,ARRAY) ;Get list of all inpatient or outpatient locations ; DBIA #10040
 N HLOCIEN,NAME,IC
 S HLOCIEN=0,IC=0
 F  S HLOCIEN=$O(^SC(HLOCIEN)) Q:'HLOCIEN  D
 .;Outpatient report ignores wards - HA
 .I INP=0,$D(^SC(HLOCIEN,42)) Q
 .;Inpatient report includes only wards - HAI
 .I INP=1,'$D(^SC(HLOCIEN,42)) Q
 .S NAME=$P($G(^SC(HLOCIEN,0)),U) I NAME="" Q
 .;Build array
 .S IC=IC+1,PXRMLCHL(IC)=NAME_U_HLOCIEN,PXRMLOCN(HLOCIEN)=IC
 Q
