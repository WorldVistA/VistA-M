SDEC37 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;  NS  = RETURN NO-SHOW DATA FOR GIVEN PATIENT - RPC
 ;  VAL = return boolean to represent that a clinic allows variable appointment length - RPC
 ;
 ;RETURN NO-SHOW DATA FOR GIVEN PATIENT - RPC
NOSHOPAT(SDECY,DFN,SDCL) ;COLLECT NO-SHOW DATA for Patient
 ;NOSHOPAT(SDECY,DFN,SDCL)  external parameter tag is in SDEC
 ;  .SDECY   = returned pointer to NO SHOW data
 ;   DFN = patient code - pointer to ^DPT(DFN)
 ;   SDCL = clinic code - pointer to Hospital Location file ^SC
 N SDECI,SDBEG,SDEND,NSC,SD2,SDCLN,SDT,SDTN
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 ;check for valid patient
 I '+DFN D ERR("Invalid Patient ID.") Q
 I '$D(^DPT(DFN,0)) D ERR("Invalid Patient ID.") Q
 ; data header
 ; TOO_MANY = flag  0=OK; 1=too many no shows
 S ^TMP("SDEC",$J,0)="I00020PATIENT_IEN^I00020CLINIC_IEN^I00020TOO_MANY^I00020ALLOWED_NO_SHOWS^I00020TOTAL_NO_SHOWS"_$C(30)
 ;get allowed number of no shows for clinic
 S SDCLN=$G(^SC(SDCL,"SDP"))
 ;loop thru schedule
 S SDEND=DT   ;$P($$NOW^XLFDT,".",1)
 S SDBEG=$$FMADD^XLFDT(SDEND,-365)
 S NSC=0  ;no show counter
 S SDT=SDBEG
 F  S SDT=$O(^DPT(DFN,"S",SDT)) Q:SDT'>0  Q:$P(SDT,".",1)>SDEND  D
 . S SDTN=^DPT(DFN,"S",SDT,0)
 . I ($P(SDTN,U)=SDCL) D
 . . S SD2=$P(SDTN,U,2)
 . . I SD2["N",$$NOSHOW(DFN,SDT,$P(SDTN,U),SDTN) S NSC=NSC+1
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=DFN_U_SDCL_U_($P(SDCLN,U,1)'>NSC)_U_$P(SDCLN,U)_U_NSC
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
NOSHOW(DFN,SDT,CIFN,PAT) ;Input:  DFN=Patient IFN, SDT=Appointment D/T
 ;  CIFN=Clinic IFN, PAT=Zero node of pat. appt., DA=Clinic appt. IFN
 ;                        Output:  1 or 0 for noshow yes/no
 N NSQUERY,NS S NS=1,NSQUERY=$$STATUS^SDAM1(DFN,SDT,CIFN,PAT)
 I $P(NSQUERY,";",3)["ACTION REQ" S NS=0
NOSHOWQ Q NS
 ;
CVARAPPT(SDECY,SDCL) ;IS Clinic Variable Appointment Length
 ;CVARAPPT(SDECY,SDCL)  external parameter tag is in SDEC
 ;return boolean to represent that a clinic allows variable appointment length - RPC
 N SDECI,VAL
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 ;check for valid clinic ID
 I '+SDCL D ERR("Invalid Clinic ID.") Q
 I '$D(^SC(SDCL,0)) D ERR("Invalid Clinic ID.") Q
 ; data header
 ; VAR_APPT_FLAG = flag  0=Clinic does not Allow Variable Appointment; 1=Clinic Allows Variable Appointment
 S ^TMP("SDEC",$J,0)="I00020VAR_APPT_FLAG"_$C(30)
 ;get VARIABLE APPOINTMENT FLAG for clinic
 S VAL=$$GET1^DIQ(44,SDCL_",",1913) ;Variable Appointment Length
 S VAL=$S(VAL["YES":1,1:0)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=VAL
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
ERROR ;
 D ERR("VISTA Error")
 Q
 ;
ERR(SDECERR) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
