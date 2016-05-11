SDECRPT ;ALB/BNT - SCHEDULING ENHANCEMENTS CLINIC REPORTS ;11/03/14 10:59am
 ;;5.3;Scheduling;**628**;Aug 13, 1993;Build 371
 ;
 ;
 Q
 ;
RPT(DAYS,SDSTPAR) ; Get all clinic appointments for each report type category
 ; Input:  DAYS = The number of days to go back and search for appointments
 ;                The default is 365, one year.
 ;      SDSTPAR = Array of clinics
 ; 
 N SDECARR,SDECLNM,SDECTOT,SDLAST
 I $G(DAYS)="" S DAYS=365
 ; Update date node of report data to today
 S SDLAST=$O(^XTMP("SDVSE","DT",""),-1)
 I SDLAST,SDLAST'=$P($$NOW^XLFDT,".") M ^XTMP("SDVSE","DT",DT)=^XTMP("SDVSE","DT",SDLAST) K ^XTMP("SDVSE","DT",SDLAST)
 S SDECARR(1)=$$HTFM^XLFDT($H-DAYS)_";"_DT,SDECARR("FLDS")="1;2;3;4;5;7;11;12;22"
 S (SDECARR(2),SDECLNM)="",SDECARR(4)="^DPT("
 ; Get appointment data for all clinics by report type
 F SDRT="P","S","M" D
 . F  S SDECLNM=$O(SDSTPAR(SDRT,SDECLNM)) Q:SDECLNM=""  S SDECARR(2)=SDECARR(2)_$P(SDSTPAR(SDRT,SDECLNM),U)_";"
 . D GETDATA(.SDECARR,SDRT)
 . S SDECARR(2)=""
 Q
 ;
GETDATA(SDECARR,SDRT) ;
 N SDECCNT,CLN,DFN,SDT,SDOB,SDLEN,CNT,SDENC,SDECPRV,SDECSTS,PROV
 S CNT=0
 K ^TMP($J,"SDAMA301")
 S SDECCNT=$$SDAPI^SDAMA301(.SDECARR)
 I SDECCNT S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",DFN)) Q:DFN=""  D
 . S CLN=0 F  S CLN=$O(^TMP($J,"SDAMA301",DFN,CLN)) Q:CLN=""  D
 . . S SDT=0 F  S SDT=$O(^TMP($J,"SDAMA301",DFN,CLN,SDT)) Q:SDT=""  D
 . . . S SDENC=$P(^TMP($J,"SDAMA301",DFN,CLN,SDT),U,12) ; Encounter IEN
 . . . S SDECPRV=0 I +SDENC D
 . . . . N SDENCPR,SDVISIT,DIC,DA,DR,DIQ,ENCARAY
 . . . . S DIQ(0)="I",DIC=409.68,DA=SDENC,DR=".01;.04;.05;.08;.11"
 . . . . D GETS^DIQ(DIC,DA,DR,"I","ENCARAY")
 . . . . S SDVISIT=ENCARAY("409.68",DA_",",".05","I")
 . . . . Q:'SDVISIT
 . . . . S SDENCPR=$$VPRV(SDVISIT) ; Get visit provider
 . . . . Q:'$G(SDENCPR)  Q:'$D(^VA(200,SDENCPR))
 . . . . S SDECPRV=SDENCPR
 . . . S SDECSTS=$P(^TMP($J,"SDAMA301",DFN,CLN,SDT),U,3) ; Appointment Status
 . . . S SDOB=$P(^TMP($J,"SDAMA301",DFN,CLN,SDT),U,7) ; Overbook indicator
 . . . S SDLEN=$P(^TMP($J,"SDAMA301",DFN,CLN,SDT),U,5) ; Lenth of Appointment
 . . . S ^XTMP("SDVSE","DT",DT,SDRT,CLN,SDT,DFN,"APPT",SDECPRV)=$S(SDOB="Y":1,1:0)_U_$$PATSTAT(DFN,SDT)_U_SDLEN_U_SDECSTS
 . . . S CNT=CNT+1
 . . . S ^XTMP("SDVSE","DT",DT,"APPT",SDRT)=CNT
 . . . K ^TMP($J,"SDAMA301",DFN,CLN,SDT)
 K ^TMP($J,"SDAMA301")
 Q
 ;
PATSTAT(DFN,SDT) ; Return Patient Appointment status of New and Established
 ; Input: DFN = Patient IEN
 ;        SDT = Current appointment
 ; Return: New Patient(1/0)^Established Patient(1/0)
 ; 
 ; This API will return an indicator for New and Established patients
 ; New patient is determined if the patient has not had an appointment in a
 ; clinic in the last 2 years.
 ;
 N SDLST,SDIFF
 I '$D(^DPT(DFN,0)) Q -1
 S SDLST=$O(^DPT(DFN,"S",SDT),-1)
 S SDIFF=$$FMDIFF^XLFDT(DT,SDLST)
 Q $S(SDIFF<720:"0^1",1:"1^0")
 ;
MERGE(SDECARR) ; Merge Report data into ^TMP global
 ; Input: Array passed by ref
 ;        Appointment Data:
 ; SDECARR(Report Type,Hospital Location IEN,FileMan Date/Time,Patient IEN,"APPT",Provider IEN (Or zero if appt not checked out))
 ;  Overbook(1/0)^New Patient(1/0)^Established Patient(1/0)^Length of Appt(min)^Appt Status
 ;  Encounter Data:
 ; SDECARR(Report Type,Hospital Location IEN,FileMan Date/Time,Patient IEN,"ENC",Provider IEN)=Telephone(1/0)
 Q:'$D(SDECARR)
 M ^XTMP("SDVSE","DT",DT)=SDECARR
 Q
 ;
VPRV(VISIT) ; Find encounter provider
 Q:'$G(VISIT)
 N VPRV,ENCARAY,VARAY,DIC,DA,DR,DIQ
 S VPRV=$O(^AUPNVPRV("AD",+VISIT,0))
 Q:'VPRV ""
 S DIQ(0)="I",DIC=9000010.06,DA=+VPRV,DR=.01
 D GETS^DIQ(DIC,DA,DR,"I","VARAY")
 S PROV=$G(VARAY("9000010.06",DA_",",".01","I"))
 Q PROV
