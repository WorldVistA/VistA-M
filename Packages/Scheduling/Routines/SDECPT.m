SDECPT ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
PTINQ(SDECY,DFN) ; Return output from ORWPT PTINQ in DataTable format
 ;PTINQ(SDECY,DFN)  external parameter tag is in SDEC
 ;Return detailed patient information for display in GUI form
 ;INPUT:
 ;  DFN       - (required) Patient ID - pointer to the PATIENT file 2
 ;RETURN:
 ;  DataTable with one column: PATIENT_INFO
 ;
 N II,SDECI,SDECARR
 S SDECY=$NA(^TMP("SDEC",$J))
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00250PATIENT_INFO"_$C(30)
 S DFN=$G(DFN)
 I DFN="" D ERR1^SDECERR(-1,"Patient ID required.",SDECI,SDECY)
 I '$D(DFN) D ERR1^SDECERR(-1,"Invalid patient ID "_DFN_".",SDECI,SDECY)
 D PTINQ^ORWPT(.SDECARR,DFN)
 F II=1:1:$O(@SDECARR@(""),-1) D
 . S SDECI=SDECI+1
 . S @SDECY@(SDECI)=@SDECARR@(II)_$C(30)
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$C(31)
 K @SDECARR
 Q
 ;
FACLIST ; Return list of remote facilities for patient
 ;FACLIST(SDECY,DFN)
 ;INPUT:
 ;  DFN       - (required) Patient ID - pointer to the PATIENT file 2
 ;RETURN:
 ;  DataTable with one column: PATIENT_INFO
 ;
 N II,SDECI,SDECARR
 S SDECY=$NA(^TMP("SDECPT",$J))
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00030R1^T00030R2^T00030R3^T00030R4^T00030R5"_$C(30)
 D FACLIST^ORWCIRN(.SDECARR,DFN)
 S II="" F  S II=$O(SDECARR(II)) Q:II=""  D
 . S SDECI=SDECI+1
 . S @SDECY@(SDECI)=@SDECARR@(II)_$C(30)
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$C(31)
 K @SDECARR
 Q
