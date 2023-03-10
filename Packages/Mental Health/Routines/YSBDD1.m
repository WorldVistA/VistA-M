YSBDD1 ;SLC/DSB - MHA DASHBOARD Drilldown ; Apr 01, 2021@16:30
 ;;5.01;MENTAL HEALTH;**202**;Dec 30, 1994;Build 47
 ;
 ; Reference to DEM^VADPT in ICR #7109
 ; Reference to ^DGPF(26.15,"B") in ICR #5991
 ; Reference to SDAPI^SDAMA301 in ICR #4433
 ; Reference to GETINF^DGPFAPIH in ICR #4903
 ; Reference to TIUSRVL in ICR #2812
 Q
PATIENT(DFN,DATAOUT) ;
 N VADM,VAPA
 D DEM^VADPT
 D ADD^VADPT
 S DATAOUT("patient_information","name")=VADM(1)
 S DATAOUT("patient_information","sex")=$P(VADM(5),U,2)
 S DATAOUT("patient_information","dob")=$P(VADM(3),U,2)
 S DATAOUT("patient_information","age")=VADM(4)
 S DATAOUT("patient_information","social")=$P(VADM(2),U,2)
 S DATAOUT("patient_information","address1")=VAPA(1)
 S DATAOUT("patient_information","address2")=VAPA(2)
 S DATAOUT("patient_information","address3")=VAPA(3)
 S DATAOUT("patient_information","city")=VAPA(4)
 S DATAOUT("patient_information","state")=$P(VAPA(5),U,2)
 S DATAOUT("patient_information","zipcode")=VAPA(6)
 S DATAOUT("patient_information","phone_number")=VAPA(8)
 S DATAOUT("patient_information","cell_phone")=$P($G(^DPT(DFN,.13)),U,4)
 Q
 ;
HRPTPROF(JSONOUT,DFN) ;
 N PRFNAME,IDX,YSDARRAY,SDCOUNT,NOW,YSDT,SDTIME,HRRVWDT,DHRR,TIUIDX,DATAOUT,ERRARY,PIDX,FIDX,TIUINVDT,DATEFOUND,SAFHEAD,SAFDCL,CSREHEAD
 N APPTLIST,NODE,OUTPXENC,IEN,PRV,PRVLIST,FTRLIST,DATE,ENCOUNTER,I,YSVISIT,NIDX,STATUS,PREFS,OPCUT
 N PATTYP
 N SAFSCNO,SAFSCYES,CSRENEW,CSREUPD,SITES,HFCLIST,SAFREV
 S NOW=$$NOW^XLFDT
 S YSDT=$P(NOW,".",1)
 D HRINIT^YSBRPC(.SAFHEAD,.SAFDCL,.SAFREV,.SAFSCNO,.SAFSCYES,.CSREHEAD,.CSRENEW,.CSREUPD,.SITES)
 ;D GETLST^XPAR(.SAFHFC,"SYS","YSB SAFETY PLAN HF CATEGORY")
 ;D GETLST^XPAR(.SAFHEAD,"SYS","YSB SAFETY PLAN HEADER TEXT")
 ;D GETLST^XPAR(.SAFDCL,"SYS","YSB SAFETY PLAN DECLINE")
 ;D GETLST^XPAR(.CSREHFC,"SYS","YSB CSRE HF CATEGORY")
 ;D GETLST^XPAR(.CSREHEAD,"SYS","YSB CSRE HEADER TEXT")
 S DATAOUT("high_risk_patient_profile","patient_record_flag",1,"flag_name")=""
 S DATAOUT("high_risk_patient_profile","patient_record_flag",1,"review_date")=""
 S DATAOUT("high_risk_patient_profile","patient_record_flag",1,"due/overdue")=""
 S DATAOUT("high_risk_patient_profile","patient_record_flag",1,"prf_actions")=""
 S DATAOUT("high_risk_patient_profile","patient_record_flag",1,"action_date")=""
 S (HRRVWDT,DHRR)=0
 S (PRFNAME,PRFIEN,IDX)=0 F  S PRFNAME=$O(^DGPF(26.15,"B",PRFNAME)) Q:PRFNAME']""  D
 .N PRFIEN,RSLT,PRFDATA,HISTIDX,LSTHIST,PRFACT,NXTHIDX,NXTHDT
 .S PRFIEN=$O(^DGPF(26.15,"B",PRFNAME,""))
 .S RSLT=$$GETINF^DGPFAPIH(DFN,PRFIEN_";DGPF(26.15,","","","PRFDATA")
 .I RSLT=0 Q
 .S LSTHIST=$O(PRFDATA("HIST",""),-1)
 .S HISTIDX="A" F  S HISTIDX=$O(PRFDATA("HIST",HISTIDX),-1) Q:'HISTIDX  D
 ..S IDX=IDX+1
 ..S PRFACT=$P(PRFDATA("HIST",HISTIDX,"ACTION"),U,2)
 ..S NXTHIDX=$O(PRFDATA("HIST",HISTIDX))
 ..S NXTHDT="UNK"  ;I NXTHIDX]"" S NXTHDT=$P($P($G(PRFDATA("HIST",NXTHIDX,"DATETIME")),U,2),"@")
 ..S DATAOUT("high_risk_patient_profile","patient_record_flag",IDX,"flag_name")=PRFNAME
 ..I $P(PRFDATA("REVIEWDT"),U,2)="" S $P(PRFDATA("REVIEWDT"),U,2)="N/A"
 ..S DATAOUT("high_risk_patient_profile","patient_record_flag",IDX,"review_date")=$S(HISTIDX=LSTHIST:$P(PRFDATA("REVIEWDT"),U,2),PRFACT="INACTIVATE":"N/A",1:NXTHDT)  ;Need to review this later
 ..I PRFIEN=2 D  ;save the High Risk dates for later use
 ...I $$FMTH^XLFDT($P(PRFDATA("REVIEWDT"),U,1),1)'>DHRR Q
 ...S HRRVWDT=$P(PRFDATA("REVIEWDT"),U,1),DHRR=$$FMTH^XLFDT($P(PRFDATA("REVIEWDT"),U,1),1)
 ..S DATAOUT("high_risk_patient_profile","patient_record_flag",IDX,"due/overdue")=$S(HISTIDX=LSTHIST:$$GETDUE^YSBWHIGH($P(PRFDATA("REVIEWDT"),U),YSDT),PRFACT="INACTIVATE":"N/A",1:"UNK")
 ..S DATAOUT("high_risk_patient_profile","patient_record_flag",IDX,"prf_actions")=PRFACT
 ..S DATAOUT("high_risk_patient_profile","patient_record_flag",IDX,"action_date")=$P($P(PRFDATA("HIST",HISTIDX,"DATETIME"),U,2),"@")
 ; scheduled appointments
 K ^TMP($J,"SDAMA301")
 N FROMTO
 ;S FROMTO=91
 S FROMTO=365
 S YSDARRAY(1)=$$FMADD^XLFDT(YSDT,-FROMTO)_";"_$$FMADD^XLFDT(YSDT,FROMTO)
 S YSDARRAY(3)="R;I;NS;NSR;CC;CCR;CP;CPR;NT;"
 S YSDARRAY(4)=DFN
 S YSDARRAY("FLDS")="1;2;12;13;18;22"
 S YSDARRAY("SORT")="P"
 S SDCOUNT=$$SDAPI^SDAMA301(.YSDARRAY)
 M APPTLIST=^TMP($J,"SDAMA301",DFN)
 ;add ^SCE("ADFN" loop to detect Outpatient Encounters with no visit. These will be marked as unscheduled
 S (PIDX,FIDX)=0
 S SDTIME=$$FMADD^XLFDT(YSDT,-FROMTO-1),OPCUT=$$FMADD^XLFDT(YSDT,FROMTO)
 F  S SDTIME=$O(^SCE("ADFN",DFN,SDTIME)) Q:'SDTIME!(SDTIME>OPCUT)  D
 .I $D(APPTLIST(SDTIME)) Q  ;already got this visit, must be scheduled
 .S OUTPXENC=$O(^SCE("ADFN",DFN,SDTIME,0))
 .S NODE=^SCE(OUTPXENC,0)
 .S APPTLIST(SDTIME)=SDTIME_U_$P(NODE,U,4)_";"_$$GET1^DIQ(44,$P(NODE,U,4),.01)_"^^^^^^^^^^"_OUTPXENC_U_$P(NODE,U,3)_";"_$$GET1^DIQ(40.7,$P(NODE,U,3),1)_"^^^^^4;UV^^^^;;WALK-IN"
 ; split appointments into past and previous
 ;sort previous appointments by reverse date
 S SDTIME=NOW-.000001
 F  S SDTIME=$O(APPTLIST(SDTIME),-1) Q:'SDTIME  D
 .I '$$CHKCLIN(APPTLIST(SDTIME)) K APPTLIST(SDTIME) Q  ;not ED or MH clinic - delete
 .I $P(APPTLIST(SDTIME),U,22)="11;FUTURE;FUTURE" Q  ;in the future, possible for an appt later today 
 .S PIDX=PIDX+1
 .S PRVLIST(PIDX)=APPTLIST(SDTIME)
 .K APPTLIST(SDTIME)
 ;sort future appointments - all previous appts are deleted
 S SDTIME=0 F  S SDTIME=$O(APPTLIST(SDTIME)) Q:'SDTIME  D
 .I '$$CHKCLIN(APPTLIST(SDTIME)) Q
 .S FIDX=FIDX+1
 .S FTRLIST(FIDX)=APPTLIST(SDTIME)
 ; handle previous appointments 
 N PSTAT
 S PIDX=0 F  S PIDX=$O(PRVLIST(PIDX)) Q:'PIDX  D
 .S NIDX=0
 .S NODE=PRVLIST(PIDX)
 .S STATUS=$P(NODE,U,22),PSTAT=$P(STATUS,";",3)
 .S STATUS=$P($P($P(NODE,U,22),";",3)," &")  ; also removes " & AUTO-REBOOK"
 .I STATUS["NO ACTION TAKEN",(PSTAT'["CHECKED") Q  ;No positive state of this encounter.
 .I STATUS["NO ACT TAKN",(PSTAT'["CHECKED") Q  ;Inpatient No action taken
 .I PSTAT["CHECKED" S STATUS=PSTAT  ;For Checked In/Checked Out replace NO ACTION TAKEN status
 .S SDTIME=+NODE
 .S ENCOUNTER=$P(NODE,U,12)
 .S YSVISIT="" I ENCOUNTER S YSVISIT=$P(^SCE(ENCOUNTER,0),U,5)
 .S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"location")=$P($P(NODE,U,2),";",2)
 .S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"date")=$$FMTE^XLFDT(SDTIME,5)
 .S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"provider")="N/A"
 .S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"status")=$P($P(NODE,U,22),";",3)
 .I YSVISIT D
 ..S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"status")="COMPLETED"
 ..I $P(NODE,U,18)="4;UV" S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"status")="WALK-IN"
 ..S (IEN,PRV)="" F  S IEN=$O(^AUPNVPRV("AD",YSVISIT,IEN)) Q:'IEN  D  Q:PRV  ;DBIA 2316
 ...S NODE=^AUPNVPRV(IEN,0)
 ...I $P(NODE,U,4)="P" S PRV=+NODE
 ...Q
 ..I PRV D
 ...S PRV=$$GET1^DIQ(200,PRV_",",.01)
 ...S $P(PRV,",",2)=" "_$P(PRV,",",2) ;add a space between last and first name so GUI column can wrap
 ...S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"provider")=PRV
 ..K ^TMP("TIULIST",$J)
 ..D NOTES^TIUSRVLV("",YSVISIT)
 ..;loop through ^TMP("TIULIST",$J) and set TIUDA to each value
 ..S DATE="" F  S DATE=$O(^TMP("TIULIST",$J,DATE)) Q:'DATE  D
 ...S I="" F  S I=$O(^TMP("TIULIST",$J,DATE,I)) Q:'I  D
 ....I $P(^TMP("TIULIST",$J,DATE,I),U,7)'="completed" Q  ;only completed (signed) notes.
 ....S NIDX=NIDX+1
 ....S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"notes",NIDX,"docID")=+^TMP("TIULIST",$J,DATE,I)
 ....S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"notes",NIDX,"docName")=$P(^TMP("TIULIST",$J,DATE,I),U,2)
 .I 'NIDX S DATAOUT("high_risk_patient_profile","previous_activity",PIDX,"notes")=""
 ; handle future appointments 
 S FIDX=0 F  S FIDX=$O(FTRLIST(FIDX)) Q:'FIDX  D
 .S NODE=FTRLIST(FIDX)
 .S SDTIME=+NODE
 .S DATAOUT("high_risk_patient_profile","future_appointments",FIDX,"location")=$P($P(NODE,U,2),";",2)
 .S DATAOUT("high_risk_patient_profile","future_appointments",FIDX,"date")=$$FMTE^XLFDT(SDTIME,5)
 K ^TMP($J,"SDAMA301")
 I '$D(DATAOUT("high_risk_patient_profile","previous_activity")) S DATAOUT("high_risk_patient_profile","previous_activity",1)=""
 I '$D(DATAOUT("high_risk_patient_profile","future_appointments")) S DATAOUT("high_risk_patient_profile","future_appointments",1)=""
 ; review status
 N DSTAT
 S PATTYP=$$MHDCDT^YSBWHIG2(DFN) S:PATTYP'="INPT" PATTYP="" ;Will return INPT if still an inpatient.
 S DSTAT=$$DONE7^YSBWHIGH(DFN,YSDT,.SAFHEAD,.SAFDCL,.SAFREV,.SAFSCNO,.SAFSCYES)
 S DATAOUT("high_risk_patient_profile","review_status","review_due")=$$GETDUE^YSBWHIGH(HRRVWDT,YSDT)
 S DATAOUT("high_risk_patient_profile","review_status","on_track")=$$ONTRK^YSBWHIGH(DFN,"")
 S DATAOUT("high_risk_patient_profile","review_status","done_in_7")=DSTAT
 S DATAOUT("high_risk_patient_profile","review_status","done_in_7_number")=$$DONENUM(NOW)
 S DATAOUT("high_risk_patient_profile","review_status","inpatient")=PATTYP
 ; safety plan
 N TIUFND
 S TIUINVDT=0,IDX=0,TIUFND=1
 D SAFLST^YSBWHIGH(.SAFDCL,.SAFREV,.SAFSCNO,.SAFSCYES,.HFCLIST)
 F  S DATEFOUND=$$FINDDOC^YSBWHIGH(DFN,.TIUINVDT,.HFCLIST,.SAFHEAD,.TIUIDX,TIUFND) Q:'TIUINVDT  D
 .S IDX=IDX+1
 .S DATAOUT("high_risk_patient_profile","safety_plan",IDX,"docID")=TIUIDX
 .I $$SAFDECL^YSBWHIGH(DFN,TIUINVDT) S DATAOUT("high_risk_patient_profile","safety_plan",IDX,"date")="Declined" Q
 .S DATAOUT("high_risk_patient_profile","safety_plan",IDX,"date")=$$FMTE^XLFDT($P(DATEFOUND,"."),5)
 I 'IDX S DATAOUT("high_risk_patient_profile","safety_plan",1,"date")="Not Done"
 ;CSRE
 K HFCLIST
 D CSRELST^YSBWHIGH(.CSRENEW,.CSREUPD,.HFCLIST)
 S TIUINVDT=0,IDX=0 F  S DATEFOUND=$$FINDDOC^YSBWHIGH(DFN,.TIUINVDT,.HFCLIST,.CSREHEAD,.TIUIDX,TIUFND) Q:'TIUINVDT  D
 .S IDX=IDX+1
 .S DATAOUT("high_risk_patient_profile","CSRE",IDX,"date")=$$FMTE^XLFDT($P(DATEFOUND,"."),5)
 .S DATAOUT("high_risk_patient_profile","CSRE",IDX,"docID")=TIUIDX
 I 'IDX S DATAOUT("high_risk_patient_profile","CSRE",1,"date")="Not Done"
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 K ^TMP($J,"SDAMA301")
 K ^TMP("TIULIST",$J)
 Q
WEBPROF(ARGS,RESULTS) ; MHA Web call for HRPTPROF
 N DFN,JSONOUT
 S DFN=$G(ARGS("dfn"))
 I DFN="" D SETERROR^YTQRUTL(404,"Patient ID not sent.") QUIT
 D HRPTPROF(.JSONOUT,DFN)
 D TOTMP^YSBRPC(.JSONOUT)
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
DONENUM(TDT) ; Calculate the number of days for Done in 7
 N ACTDT,II,LST,RCNT,DIFF
 N NMSTR,NMARR,ACTSTR,ACTARR,LSTNM
 S NMARR("HIGH RISK FOR SUICIDE")=""
 S NMARR("BEHAVIORAL")=""
 S NMARR("MISSING PATIENT")=""
 S ACTARR("REACTIVATE")=""
 S ACTARR("CONTINUE")=""
 S ACTARR("NEW ASSIGNMENT")=""
 S RCNT=0,LST=0,LSTNM=""
 S II=0 F  S II=$O(DATAOUT("high_risk_patient_profile","patient_record_flag",II)) Q:II=""  D
 . S NMSTR=$G(DATAOUT("high_risk_patient_profile","patient_record_flag",II,"flag_name"))
 . I NMSTR]"" S LSTNM=NMSTR
 . I LSTNM]"" Q:'$D(NMARR(LSTNM))  ;Quit if we are not in a sequence of NEW/REACTIVATE/CONTINUE the Patient Record flags of interest
 . S ACTSTR=$G(DATAOUT("high_risk_patient_profile","patient_record_flag",II,"prf_actions"))
 . I ACTSTR]"" Q:'$D(ACTARR(ACTSTR))
 . S RCNT=$G(DATAOUT("high_risk_patient_profile","patient_record_flag",II,"action_date"))
 . S RCNT=$$ETF(RCNT)
 . I RCNT>LST S LST=RCNT
 S LST=$$FMTH^XLFDT(LST,1),LST=LST+7,LST=$$HTFM^XLFDT(LST,1)
 S DIFF=$$FMDIFF^XLFDT(LST,TDT,1)
 Q DIFF
ETF(X) ; External to Fileman format
 N %DT,Y S X=$G(X),%DT="PST" D ^%DT S X=Y S:+X'>0 X="" Q X
 Q
CHKCLIN(NODE) ;
 N STOPCODE
 S STOPCODE=$P($P(NODE,U,13),";",2)
 I STOPCODE=130 Q 1 ;ED clinic
 I (STOPCODE>499),(STOPCODE<600) Q 1 ;MH clinic
 Q 0 ;not ED or MH clinic
 ;
GETNOTE(JSONOUT,YSTIUDA) ;
 N DATAOUT,YSTEXT
 ;note text
 D TGET^TIUSRVR1(.YSTEXT,YSTIUDA) ;TEXT just contains the string "^TMP("TIUVIEW",TIUDA)"
 S IDX=0 F  S IDX=$O(@YSTEXT@(IDX)) Q:'IDX  S DATAOUT("note_text",IDX,"line")=@YSTEXT@(IDX)
 I IDX=0 S DATAOUT("note_text",1)=""
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 Q
WEBNOTE(ARGS,RESULTS)  ;MHA Web call for GETNOTE
 N YSTIUDA,JSONOUT
 S YSTIUDA=$G(ARGS("noteId"))
 I YSTIUDA="" D SETERROR^YTQRUTL(404,"Note ID not sent") QUIT
 D GETNOTE(.JSONOUT,YSTIUDA)
 D TOTMP^YSBRPC(.JSONOUT)
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
GETRPRT(JSONOUT,ADMIN) ;
 N REPORT,DATAOUT,ERRARY
 K ^TMP("YTQRERRS",$J)
 D BLDRPT^YTQRRPT(.REPORT,ADMIN)
 I $D(REPORT) D
 .N IDX
 .S IDX=0 F  S IDX=$O(REPORT(IDX)) Q:'IDX  D
 ..S DATAOUT("report",IDX,"line")=REPORT(IDX)
 I '$D(REPORT) S DATAOUT("report",1,"line")="<no text>"
 I $D(^TMP("YTQRERRS",$J,1,"error")) D
 .S DATAOUT("report",1,"line")=^TMP("YTQRERRS",$J,1,"error","code")
 .S DATAOUT("report",2,"line")=^TMP("YTQRERRS",$J,1,"error","message")
 .S DATAOUT("report",3,"line")=^TMP("YTQRERRS",$J,1,"error","errors",1,"message")
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 K ^TMP("YTQRERRS",$J)
 Q
WEBRPRT(ARGS,RESULTS) ;
 N REPORT,DATAOUT,ERRARY,ADMIN,JSONOUT
 S ADMIN=$G(ARGS("adminId"))
 I ADMIN="" D SETERROR^YTQRUTL(404,"Admin ID not sent.") QUIT
 D GETRPRT(.JSONOUT,ADMIN)
 D TOTMP^YSBRPC(.JSONOUT)
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
