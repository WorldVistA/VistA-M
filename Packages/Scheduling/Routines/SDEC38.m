SDEC38 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
APPTEVLG(SDECY,DFN) ;GET appointment data for given patient
 ;APPTEVLG(SDECY,DFN)  external parameter tag is in SDEC
 ;INPUT:
 ;   DFN = patient code - pointer to ^DPT(DFN)
 ;RETURN:
 ;Global Array with a single entry containing appointment data for the given patient:
 ;  1. PATIENT_IEN
 ;  2. PATIENT_NAME
 ;  3. CLINIC_IEN
 ;  4. WARD_IEN
 ;  5. APPT_TIME
 ;  6. APPT_NUMBER
 ;  7. APPT_MADE_TIME
 ;  8. APPT_MADE_USER
 ;  9. APPT_MADE_USER_NAME
 ; 10. ROUT_SLIP_DATE
 ; 11. CHECKIN_TIME
 ; 12. CHECKIN_USER
 ; 13. CHECKIN_USER_NAME
 ; 14. CHECKOUT_TIME
 ; 15. CHECKOUT_USER
 ; 16. CHECKOUT_USER_NAME
 ; 17. CHECKOUT_FILED_TIME
 ; 18. NO_SHO_CANCEL_TIME
 ; 19. NO_SHO_CANCEL_USER
 ; 20. NO_SHO_CANCEL_USER_NAME
 ; 21. CHECKED_OUT
 ; 22. REBOOK_DATE
 ; 23. CANCEL_REASON
 ; 24. CANCEL_REMARK
 ;
 N AMN,AMT,AMU,APN,APT,SDECI,SDECTMP,CIN,CIT,CIU,COE,COF,CON,COT,COU,CRM,CRS
 N DPTS,DPTSR,NSN,NST,NSU,PAT,PN,RBD,RSD,S,SC,SDCL,SDCLS,SDCLSC,SDW
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 ;check for valid Patient
 I '+DFN D ERR^SDECERR("Invalid Patient ID.") Q
 I '$D(^DPT(DFN,0)) D ERR^SDECERR("Invalid Patient ID.") Q
 ; data header
 S SDECTMP="T00020PATIENT_IEN^T00020PATIENT_NAME^T00020CLINIC_IEN^T00020WARD_IEN^T00020APPT_TIME^T00020APPT_NUMBER"
 S SDECTMP=SDECTMP_"^T00020APPT_MADE_TIME^T00020APPT_MADE_USER^T00020APPT_MADE_USER_NAME^T00020ROUT_SLIP_DATE"
 S SDECTMP=SDECTMP_"^T00020CHECKIN_TIME^T00020CHECKIN_USER^T00020CHECKIN_USER_NAME"
 S SDECTMP=SDECTMP_"^T00020CHECKOUT_TIME^T00020CHECKOUT_USER^T00020CHECKOUT_USER_NAME^T00020CHECKOUT_FILED_TIME"
 S SDECTMP=SDECTMP_"^T00020NO_SHO_CANCEL_TIME^T00020NO_SHO_CANCEL_USER^T00020NO_SHO_CANCEL_USER_NAME^T00020CHECKED_OUT"
 S SDECTMP=SDECTMP_"^T00020REBOOK_DATE^T00100CANCEL_REASON^T00100CANCEL_REMARK"_$C(30)
 S ^TMP("SDEC",$J,0)=SDECTMP
 S PN=$$GET1^DIQ(2,DFN_",",.01)
 S APN=0
 S SDCLS=""
 S SDCLSC=""
 ;loop thru patient appointments
 S S=0 F  S S=$O(^DPT(DFN,"S",S)) Q:S'>0  D
 . S DPTS=$G(^DPT(DFN,"S",S,0))
 . S DPTSR=$G(^DPT(DFN,"S",S,"R"))
 . S SDCL=$P(DPTS,U)        ;get clinic
 . S PAT="",SC=0 F  S SC=$O(^SC(SDCL,"S",S,1,SC)) Q:SC'>0  D  Q:PAT=DFN  ;get appt record from clinic
 . . S SDCLS=$G(^SC(SDCL,"S",S,1,SC,0))
 . . S SDCLSC=$G(^SC(SDCL,"S",S,1,SC,"C"))
 . . S PAT=$P(SDCLS,U)
 . . I PAT=DFN Q
 . S SDECTMP=DFN_U                                 ;01 PATIENT_IEN
 . S SDECTMP=SDECTMP_PN_U                          ;02 PATIENT_NAME
 . S SDECTMP=SDECTMP_SDCL_U                        ;03 CLINIC_IEN
 . S SDW=$S($D(^DPT(DFN,.1)):^(.1),1:"Outpatient") ;04 WARD_IEN
 . S SDECTMP=SDECTMP_SDW_U
 . S APT=$TR($$FMTE^XLFDT(S),"@"," ")              ;05 APPT_TIME
 . S SDECTMP=SDECTMP_APT_U
 . S APN=APN+1                                     ;06 APPT_NUMBER
 . S SDECTMP=SDECTMP_APN_U
 . S AMT=$P(DPTS,U,19)                             ;07 APPT_MADE_TIME
 . S:AMT'="" AMT=$TR($$FMTE^XLFDT(AMT),"@"," ")
 . S SDECTMP=SDECTMP_AMT_U
 . S AMU=$P(DPTS,U,18)                             ;08 APPT_MADE_USER
 . S SDECTMP=SDECTMP_AMU_U
 . S AMN=$$GET1^DIQ(200,AMU_",",.01)               ;09 APPT_MADE_USER_NAME
 . S SDECTMP=SDECTMP_AMN_U
 . S RSD=$P(DPTS,U,13)                             ;10 ROUT_SLIP_DATE
 . S:RSD'="" RSD=$TR($$FMTE^XLFDT(RSD),"@"," ")
 . S SDECTMP=SDECTMP_RSD_U
 . S CIT=$P(SDCLSC,U)                              ;11 CHECKIN_TIME
 . S:CIT'="" CIT=$TR($$FMTE^XLFDT(CIT),"@"," ")
 . S SDECTMP=SDECTMP_CIT_U
 . S CIU=$P(SDCLSC,U,2)                            ;12 CHECKIN_USER
 . S SDECTMP=SDECTMP_CIU_U
 . S CIN=$$GET1^DIQ(200,CIU_",",.01)               ;13 CHECKIN_USER_NAME
 . S SDECTMP=SDECTMP_CIN_U
 . S COT=$P(SDCLSC,U,3)                            ;14 CHECKOUT_TIME
 . S:COT'="" COT=$TR($$FMTE^XLFDT(COT),"@"," ")
 . S SDECTMP=SDECTMP_COT_U
 . S COU=$P(SDCLSC,U,4)                            ;15 CHECKOUT_USER
 . S SDECTMP=SDECTMP_COU_U
 . S CON=$$GET1^DIQ(200,COU_",",.01)               ;16 CHECKOUT_USER_NAME
 . S SDECTMP=SDECTMP_CON_U
 . S COE=$P(SDCLSC,U,6)                            ;17 CHECKOUT_FILED_TIME
 . S:COE'="" COE=$TR($$FMTE^XLFDT(COE),"@"," ")
 . S SDECTMP=SDECTMP_COE_U
 . S NST=$P(DPTS,U,14)                             ;18 NO_SHO_CANCEL_TIME
 . S:NST'="" NST=$TR($$FMTE^XLFDT(NST),"@"," ")
 . S SDECTMP=SDECTMP_NST_U
 . S NSU=$P(DPTS,U,12)                             ;19 NO_SHO_CANCEL_USER
 . S SDECTMP=SDECTMP_NSU_U
 . S NSN=$$GET1^DIQ(200,NSU_",",.01)               ;20 NO_SHO_CANCEL_USER_NAME
 . S SDECTMP=SDECTMP_NSN_U
 . S COF=$S($P(SDCLSC,U,3)'="":"YES",SDCLSC'="":"NO",1:"") ;21 CHECKED_OUT
 . S SDECTMP=SDECTMP_COF_U
 . S RBD=$P(DPTS,U,10)                             ;22 REBOOK_DATE
 . S:RBD'="" RBD=$TR($$FMTE^XLFDT(RBD),"@"," ")
 . S SDECTMP=SDECTMP_RBD_U
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)=SDECTMP
 . S CRS=$P(DPTS,U,15)                             ;23 CANCEL_REASON
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)=CRS_U
 . S CRM=$P(DPTSR,U)                               ;24 CANCEL_REMARK
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)=CRM
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)=$C(30)
 ;
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
 ;return boolean to represent that a clinic allows variable appointment length - RPC
VAL(SDECY,SDCL) ;return boolean to represent that a clinic allows variable appointment length - RPC
 ; SDEC CLINIC VAR APPT
 N SDECI,VAL
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 ;check for valid clinic ID
 I '+SDCL D ERR^SDECERR("Invalid Clinic ID.") Q
 I '$D(^SC(SDCL,0)) D ERR^SDECERR("Invalid Clinic ID.") Q
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
