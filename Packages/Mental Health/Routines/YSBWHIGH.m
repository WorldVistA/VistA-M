YSBWHIGH ;SLC/DJE - MHA DASHBOARD ; Apr 01, 2021@16:33
 ;;5.01;MENTAL HEALTH;**202,208**;Dec 30, 1994;Build 23
 ;
 ; Routine retrieves high risk widget data
 ;
 ; Reference to ^AUPNVHF in ICR #3084
 ; Reference to ^AUTTHF in ICR #4295
 ; Reference to ^DGPM("ATID1") in ICR #1378
 ; Reference to ^DGPM in ICR #2090
 ; Reference to ^PXRMINDX in ICR #4229
 ; Reference to SDAMA301 in ICR #4433
 ; Reference to DGPFAPIH in ICR #4903
 ; Reference to DGPFAPI in ICR #3860
 Q
HIGHRISK(DATAOUT) ;
 N HRPATS,HRCOUNT,HRIDX,DFN,PRFFOUND,CRITERIA,YSDT,DONE7,NOW,DCDT,INSTDATA,PRFDATA,PATDATA
 N SAFHEAD,SAFDCL,SAFREV,SAFSCNO,SAFSCYES,CSREHEAD,CSRENEW,CSREUPD,SITES
 N HRFND
 N LSTSAF,DONE7,LSTCSRE,SUBS,CSRETITL,CSRENEW,CSREUPD
 N $ES,$ET S $ET="D ERRHND^YSBWHIGH"   ; quit from ERRHND if error
 S NOW=$$NOW^XLFDT()
 S YSDT=$P(NOW,".",1)
 D HRINIT^YSBRPC(.SAFHEAD,.SAFDCL,.SAFREV,.SAFSCNO,.SAFSCYES,.CSREHEAD,.CSRENEW,.CSREUPD,.SITES)
 S HRCOUNT=$$GETLST^DGPFAPIH("2;DGPF(26.15,","","","HRPATS")
 I 'HRCOUNT Q
 S HRIDX=+$O(DATAOUT("data",""),-1)
 S HRFND=0
 S SUBS="YSB-DASH-"_YSDT
 S DFN=0 F  S DFN=$O(HRPATS(DFN)) Q:'DFN  D
 .S DCDT=""
 .K PRFDATA,PATDATA,INSTDATA
 .S PRFFOUND=$$PRFDATA(DFN,.SITES,.PRFDATA)
 .Q:'PRFFOUND  ;not a at user's site
 .S HRFND=1
 .S HRIDX=HRIDX+1
 .S DATAOUT("data",HRIDX,"widget")="HIGH RISK"
 .S DATAOUT("data",HRIDX,"dfn")=DFN
 .S DCDT=$$MHDCDT^YSBWHIG2(DFN)
 .S DATAOUT("data",HRIDX,"patient_name")=$P(HRPATS(DFN,0),U)
 .S DATAOUT("data",HRIDX,"patient_prf")="YES" ;All HIGH RISK PRFs
 .S DATAOUT("data",HRIDX,"division")=$P(PRFDATA("OWNER"),U,2) ;all HIGH RISK PRFs
 .S DATAOUT("data",HRIDX,"prf_review")=$$FMTE^XLFDT(+PRFDATA("REVIEWDT"),5)
 .S DATAOUT("data",HRIDX,"due_overdue")=$$GETDUE(+PRFDATA("REVIEWDT"),YSDT)
 .S DATAOUT("data",HRIDX,"last_discharge_date")=$S(+DCDT:$$FMTE^XLFDT(DCDT,5),1:DCDT)
 .S DATAOUT("data",HRIDX,"last_mh_visit")=$$MHLSTVST^YSBWHIG2(DFN,NOW)
 .S DATAOUT("data",HRIDX,"next_mh_appt_date")=$$MHNXTAPP(DFN,YSDT)
 .S DATAOUT("data",HRIDX,"on_track")=$$ONTRK(DFN,DCDT,YSDT)
 .S LSTSAF=$$MHLSTSAF(DFN,.SAFHEAD,.SAFDCL,.SAFREV,.SAFSCNO,.SAFSCYES)
 .S DONE7=$$DONE7(DFN,YSDT,.SAFHEAD,.SAFDCL,.SAFREV,.SAFSCNO,.SAFSCYES)
 .S LSTCSRE=$$LASTCSRE(DFN,.CSRENEW,.CSREUPD,.CSREHEAD)
 .S DATAOUT("data",HRIDX,"last_mh_safety_plan")=LSTSAF
 .S DATAOUT("data",HRIDX,"done_in_7")=DONE7
 .S DATAOUT("data",HRIDX,"last_csra")=LSTCSRE
 .D BLDINST^YSBWHIG2(.INSTDATA,DFN,42,YSDT,"phq9") ;PHQ9
 .D BLDRSL^YSBWHIG2(.INSTDATA,DFN,42,YSDT,"phq9_i9",3382) ;PHQ9 q9
 .D CSSRS(.INSTDATA,DFN,YSDT) ;C-SSRS
 .M DATAOUT("data",HRIDX)=INSTDATA
 .;send px information in loaddb call
 .D PATIENT^YSBDD1(DFN,.PATDATA)
 .M DATAOUT("data",HRIDX)=PATDATA
 Q
 ;
ERRHND ; Handle errors & clear stack
 N ERROR S ERROR=$$EC^%ZOSV           ; get error
 I ERROR["ZTER" D UNWIND^%ZTER        ; ignore errors clearing stack
 N $ET S $ET="D ^%ZTER,UNWIND^%ZTER"  ; avoid loop on add'l error
 D ^%ZTER                             ; rec fail in error trap
 S DATAOUT("data",1)=""               ; set to null for JSON
 D UNWIND^%ZTER                       ; clear stack
 Q
PRFDATA(DFN,SITES,PRFDATA) ;
 N PRFFULL,I,DONE,PRFSTAT
 S PRFSTAT=$$GETACT^DGPFAPI(DFN,"PRFFULL")
 S DONE=0
 S I=0 F  S I=$O(PRFFULL(I)) Q:'I  D  Q:DONE
 .Q:$P(PRFFULL(I,"FLAG"),U)'="2;DGPF(26.15,"
 .Q:'$D(SITES(+PRFFULL(I,"OWNER")))  ;only high risk flags from user's site
 .S DONE=1
 .M PRFDATA=PRFFULL(I)
 Q DONE
 ;
GETDUE(RVDT,YSDT) ;calculate if review is due
 I 'RVDT Q "N/A"
 Q $$FMDIFF^XLFDT(RVDT,YSDT)
 ;
MHNXTAPP(DFN,YSDT) ;Get next MH APPT up to a year from today.
 N YSDARRAY,APPTLIST,APPTDT,SDCOUNT,SDTIME,DONE,NOW,NODE,PSTAT,STATUS
 S NOW=$$NOW^XLFDT()
 K ^TMP($J,"SDAMA301")
 S YSDARRAY(1)=NOW_";"_$$FMADD^XLFDT(YSDT,365)
 S YSDARRAY(3)="R;I;NS;NSR;CC;CCR;CP;CPR;NT;"
 S YSDARRAY(4)=DFN
 S YSDARRAY("FLDS")="1;2;12;13;18;22"
 S YSDARRAY("SORT")="P"
 S SDCOUNT=$$SDAPI^SDAMA301(.YSDARRAY)
 M APPTLIST=^TMP($J,"SDAMA301",DFN)
 K ^TMP($J,"SDAMA301",DFN)
 S DONE=0,APPTDT=""
 S SDTIME=0 F  S SDTIME=$O(APPTLIST(SDTIME)) Q:'SDTIME!DONE  D
 .I '$$CHKCLIN^YSBDD1(APPTLIST(SDTIME)) Q
 .S NODE=APPTLIST(SDTIME)
 .S STATUS=$P(NODE,U,22),PSTAT=$P(STATUS,";",3)
 .S STATUS=$P($P($P(NODE,U,22),";",3)," &")  ; also removes " & AUTO-REBOOK"
 .I STATUS="11;FUTURE;FUTURE" Q  ;in the future, possible for an appt later today
 .I STATUS["CANCELLED" Q  ;Cancelled by Clinic or Cancelled by Patient
 .I STATUS["NO-SHOW" Q  ;No show
 .S DONE=1,APPTDT=SDTIME
 I 'APPTDT Q "Not Scheduled"
 Q $$FMTE^XLFDT($P(APPTDT,"."),5)
 ;
MHLSTSAF(DFN,SAFHEAD,SAFDCL,SAFREV,SAFSCNO,SAFSCYES)  ;get mh last safety plan date
 N DATEFOUND,DECLINE,TIUINVDT,TIUFND
 N HFCLIST
 S TIUINVDT=0,TIUFND=3  ;=3 means look through the TIU DOCUMENTS to check STATUS but don't get the contents
 D SAFLST(.SAFDCL,.SAFREV,.SAFSCNO,.SAFSCYES,.HFCLIST)
 S DATEFOUND=$$FINDDOC(DFN,.TIUINVDT,.HFCLIST,.SAFHEAD,"",TIUFND)
 I DATEFOUND="" Q "NOT DONE"
 I $$SAFDECL(DFN,TIUINVDT,.SAFDCL) Q "DECLINED"  ;12/5/19 added "D"
 I DATEFOUND Q $$FMTE^XLFDT($P(DATEFOUND,"."),5)
 Q "ERROR"
 ;
FINDDOC(DFN,TIUINVDT,HFCLIST,HDRLIST,TIURET,TIUFND) ;TIUINVDT is updated and returned by reference to permit recursion or use in V HF indexes
 N IDX,DATEFOUND,YSCLASS,HEADTXT,VSTFOUND,YSTIUDAT,TIU,HF,HFCNT
 N LOWER,UPPER,DSCR,DOCFND
 S LOWER="abcdefghijklmnopqrstuvwxyz"
 S UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S TIUFND=$G(TIUFND)
 ;Set up Document Class to find TIU Note below
 S DSCR="I $P(^(0),U,4)=""CL"""  ;Screen on CLASS type TIU DOCUMENT DEFs
 S YSCLASS=$$FIND1^DIC(8925.1,"","B","CLINICAL DOCUMENTS",,,.DSCR)
 ; the note that created the HFs might not be signed and we'll need to search again
 F  D  Q:TIURET  Q:'DATEFOUND
 .;DBIA #4295 loop through HFs of HF categories
 .S (VSTFOUND,TIURET)=""
 .S DATEFOUND=9999999,DOCFND=0
 . S IDX=0 F  S IDX=$O(HFCLIST(IDX)) Q:IDX=""  D
 ..S HFCNT="" F  S HFCNT=$O(HFCLIST(IDX,HFCNT)) Q:'HFCNT  D
 ...S HF=HFCLIST(IDX,HFCNT)
 ...N HFDT
 ...S HFDT=$O(^AUPNVHF("AA",DFN,HF,TIUINVDT)) ;find last date since input date ;DBIA #3084
 ...I HFDT="" Q
 ...I HFDT<DATEFOUND S DATEFOUND=HFDT,VSTFOUND=$O(^AUPNVHF("AA",DFN,HF,HFDT,""))
 .I DATEFOUND=9999999 S (DATEFOUND,TIUINVDT)="" Q  ;nothing found
 .S YSTIUDAT=DATEFOUND ;outpatient visits are like this
 .;inpatient visits are like this
 .S VSTFOUND=$P(^AUPNVHF(VSTFOUND,0),U,3) ;go from v health factors file to visit file  DBIA 2316
 .N VSTDTM S VSTDTM=$P(^AUPNVSIT(VSTFOUND,0),U)  ;Save Visit Date/Time for TIU Match
 .S VSTFOUND=$P(^AUPNVSIT(VSTFOUND,0),U,12) ;does the visit have a parent visit? The TIU will be filed against that date. DBIA 2028
 .I VSTFOUND S YSTIUDAT=9999999-$P((+^AUPNVSIT(VSTFOUND,0)),".") ;get the visit date
 .;return inversed date in reference variable, function return is regular date
 .S TIUINVDT=DATEFOUND,DATEFOUND=9999999-DATEFOUND
 .I TIUFND=0 S TIURET=999999999 Q  ;Don't find TIU DOCUMENT
 .K ^TMP("TIU",$J) ;Now find TIU note
 .D VISIT^TIULAPIC(DFN,YSCLASS,YSTIUDAT-0.1,YSTIUDAT,"",1) ;DBIA #3519
 .N REFDT,TVDT
 .S TIU="" F  S TIU=$O(^TMP("TIU",$J,YSTIUDAT,TIU),-1) Q:'TIU  D  Q:$G(TIURET)
 ..I ^TMP("TIU",$J,YSTIUDAT,TIU,.05,"I")'=7 Q  ;Quit if not a completed (signed) note
 ..;I TIUFND=3 S DOCFND=1,TIURET=999999999 Q  ;For TIUFND=3, just need to know if signed TIU DOC;Keep flag for now but still have to find exact note
 ..S REFDT=$P($G(^TMP("TIU",$J,YSTIUDAT,TIU,1301,"I")),".")
 ..S TVDT=$P($G(^TMP("TIU",$J,YSTIUDAT,TIU,.07,"I")),".")
 ..Q:(REFDT'=$P(VSTDTM,"."))&(TVDT'=$P(VSTDTM,"."))
 ..N HEADER
 ..S HEADER=$G(^TMP("TIU",$J,YSTIUDAT,TIU,"TEXT",1,0))_$G(^TMP("TIU",$J,YSTIUDAT,TIU,"TEXT",2,0))_$G(^TMP("TIU",$J,YSTIUDAT,TIU,"TEXT",3,0))
 ..F IDX=1:1:HDRLIST S HEADTXT=$P(HDRLIST(IDX),U,2) D  Q:$G(TIURET)
 ...I (HEADER[HEADTXT)!($TR(HEADER,LOWER,UPPER)[HEADTXT) S TIURET=TIU I TIUFND=3 S DOCFND=1,TIURET=999999999
 I TIUFND=3 I DOCFND=0 S DATEFOUND=""  ;Did not find Signed TIU DOC
 I TIURET=999999999 K TIURET  ;Document not needed
 K ^TMP("TIU",$J)
 Q DATEFOUND
 ;
SAFDECL(DFN,TIUINVDT,SAFDCL) ;was safety plan declined?
 N DCLHF
 I '$D(SAFDCL) Q 0  ;Must get the SAFDCL Parameter first.
 I '$G(DFN) Q 0
 I '$G(TIUINVDT) Q 0
 S DCLHF=$P($G(SAFDCL(1)),U,2) I +DCLHF=0 Q 0
 Q $D(^AUPNVHF("AA",DFN,DCLHF,TIUINVDT))
 ;
HRACTIVE(DFN) ;get activation details of high risk flag
 N IDX,STOP,PRFDATA
 I '$$GETINF^DGPFAPIH(DFN,"2;DGPF(26.15,","","","PRFDATA") Q "N/A"  ;Get high risk data, if none quit
 S IDX="",STOP=0 F  S IDX=$O(PRFDATA("HIST",IDX),-1)  Q:'IDX  D  Q:STOP
 .I "1,3,4"[(+PRFDATA("HIST",IDX,"ACTION")) S STOP=1 ;if new assignment, reactivated, or inactivated then stop
 I 'STOP Q "N/A" ;catch all
 I (+PRFDATA("HIST",IDX,"ACTION"))=3 Q "N/A" ;inactive flag
 Q +PRFDATA("HIST",IDX,"DATETIME") ;assigned or reactivated
 ;
DONE7(DFN,YSDT,SAFHEAD,SAFDCL,SAFREV,SAFSCNO,SAFSCYES)  ;calculate done in 7 
 N DATEFOUND,DECLINE,TIUIDX,ACTIVATION,TIUINVDT,LASTDATE,FIRSTDATE,ADMISSION,DSCHGDT,INPT
 N MVMT,DONE,TIUFND,INVDT
 N ENDADMISS,DSCHGM,TRNSFRDT
 N HFCLIST
 S ACTIVATION=$$HRACTIVE(DFN),INPT=0
 I ACTIVATION="N/A" Q "N/A"
 S ACTIVATION=$P(ACTIVATION,".")
 S LASTDATE=$$FMADD^XLFDT(ACTIVATION,8)
 S FIRSTDATE=$$FMADD^XLFDT(ACTIVATION,-7)
 ;check to see if patient was inpatient at some point during 7 day period
 S ADMISSION=9999999-LASTDATE
 S ENDADMISS=9999999-FIRSTDATE
 S DONE=0,MVMT="",DSCHGDT=""
 F  S ADMISSION=$O(^DGPM("ATID1",DFN,ADMISSION)) Q:ADMISSION=""!DONE!(ADMISSION>ENDADMISS)  D
 . S MVMT="" F  S MVMT=$O(^DGPM("ATID1",DFN,ADMISSION,MVMT)) Q:MVMT=""  D  Q:DONE  ;Find the last MH Admission
 .. I $$ISMHMV(MVMT)=1 S DONE=1
 I MVMT'="" D
 . S DSCHGM=$P($G(^DGPM(MVMT,0)),U,17)  ;make it the DC movement
 . I DSCHGM="" S INPT=$$GET1^DIQ(405,MVMT,.01,"I") Q  ;S INPT=1 Q  ;Still an inpatient admitted before the 7 day cutoff
 . S DSCHGDT=+^DGPM(DSCHGM,0) I DSCHGDT>LASTDATE S LASTDATE=$P(DSCHGDT,".")  ;update lastdate to dc date if later
 . I $P(DSCHGDT,".")=YSDT S INPT=DSCHGDT  ;Allow Safety Plan to still be completed today
 ;Check transfers also but only if later than last MH discharge date
 S (DONE,INVDT)=0,INVDT=(9999999-($G(LASTDATE)-.01))
 F  S INVDT=$O(^DGPM("ATID2",DFN,INVDT)) Q:(INVDT="")!(INVDT>ENDADMISS)  D  Q:(DONE=1)  ;DBIA #1378
 .N MVMT
 .S MVMT="" F  S MVMT=$O(^DGPM("ATID2",DFN,INVDT,MVMT)) Q:(MVMT="")  D  Q:(DONE=1)  ;DBIA #1378
 ..N LOC,ADMMVMT,DCMVMT,XMVMT,TRNSCTN
 ..S LOC=$$GET1^DIQ(405,MVMT,.06,"I") ;DBIA #1378
 ..S TRNSCTN=$$GET1^DIQ(405,MVMT,.02,"I")  ;find the transaction type, 2=TRANSFER ;DBIA #1378
 ..I $$GET1^DIQ(42,LOC,.03)'="PSYCHIATRY",TRNSCTN'=2 Q  ;not a psychiatry service ward and not a TRANSFER ;DBIA #31
 ..S ADMMVMT=$$GET1^DIQ(405,MVMT,.14,"I")  ;find admission to find discharge ;DBIA #1378
 ..S DCMVMT=$$GET1^DIQ(405,ADMMVMT,.17,"I")  ;DBIA #2090
 .. S XMVMT=DCMVMT
 .. Q:DCMVMT=""&(TRNSCTN'=2)  ;Don't let a null DCMVMT set the TRNSFRDT
 .. S:TRNSCTN=2 XMVMT=MVMT  ;If this is a TRANFER, set the Transfer date 
 ..S TRNSFRDT=$$GET1^DIQ(405,XMVMT,.01,"I"),DONE=1  ;DBIA #1378
 ..I $$ISMHMV^YSBWHIGH(XMVMT)=1 D  ;The Transfer was to an MH Location, need to Evaluate dates
 ... N XDSCHGM,XINPT,XDSCHGDT
 ... S XDSCHGM=$P($G(^DGPM(XMVMT,0)),U,17)  ;See if there was a discharge
 ... I XDSCHGM="" S XINPT=$$GET1^DIQ(405,XMVMT,.01,"I") I XINPT>INPT S INPT=XINPT Q  ;No Discharge, is this XFER later than any ADMISSIONS?
 ... S XDSCHGDT=$$GET1^DIQ(405,XDSCHGM,.01,"I") I XDSCHGDT>TRNSFRDT S TRNSFRDT=$P(XDSCHGDT,".")  ;If the Discharge movement is after Transfer then update
 I ($G(TRNSFRDT)>$G(DSCHGDT)),($G(TRNSFRDT)>INPT) S DSCHGDT=TRNSFRDT,INPT=0
 I (DSCHGDT'=""),(DSCHGDT>LASTDATE) S DSCHGDT=$P(DSCHGDT,".",1),LASTDATE=$P(DSCHGDT,".")
 ;invert last date and search for safety plan
 S DECLINE=""
 I INPT'=0 S LASTDATE=YSDT  ;If still an inpatient, look for all current Safety Plans
 S TIUINVDT=9999999-LASTDATE,TIUINVDT=$P(TIUINVDT,".")-1,TIUINVDT=TIUINVDT_.9999999  ;Updated to be inclusive of Last Date.
 K HFCLIST S TIUFND=3
 D SAFLST(.SAFDCL,.SAFREV,.SAFSCNO,.SAFSCYES,.HFCLIST)
 S DATEFOUND=$$FINDDOC(DFN,.TIUINVDT,.HFCLIST,.SAFHEAD,.TIUIDX,TIUFND)  ; find safety plan seven days from assignment
 I DATEFOUND>=FIRSTDATE,$$SAFDECL(DFN,TIUINVDT,.SAFDCL) Q "DECLINED"  ; Declined Safety plan in 7; 12/5/19 added "D"
 I (DATEFOUND>=FIRSTDATE),(DATEFOUND<=INPT) Q "COMPLETED"  ; Completed Safety plan in 7 for Inpatients
 I DSCHGDT'="" I (DATEFOUND>=FIRSTDATE),(DATEFOUND<=DSCHGDT) Q "COMPLETED"  ;Was an Inpatient but discharged
 I (DATEFOUND>=FIRSTDATE),(DATEFOUND<LASTDATE) Q "COMPLETED"  ; Completed Safety plan in 7
 I INPT Q "PENDING"                                     ; Still an inpatient, have until discharge
 I YSDT<LASTDATE Q "PENDING"                              ; Still time to complete
 S TIUINVDT=0,DATEFOUND=0
 S DATEFOUND=$$FINDDOC(DFN,.TIUINVDT,.HFCLIST,.SAFHEAD,"",TIUFND) ; find any safety plan
 I DATEFOUND<FIRSTDATE S DATEFOUND=0
 I DATEFOUND'=0 I $$SAFDECL(DFN,TIUINVDT,.SAFDCL) Q "DECLINED" ; Declined Safety plan
 I DATEFOUND>=LASTDATE Q "DONE LATE"
 Q "OVERDUE"
ISMHMV(MVMT) ;
 N LOC,ADMMVMT,DCMVMT,ISMH
 I MVMT="" Q 0
 S ISMH=1
 S LOC=$$GET1^DIQ(405,MVMT,.06,"I") ;DBIA #1378
 S TRNSCTN=$$GET1^DIQ(405,MVMT,.02,"I")  ;find the transaction type, 2=TRANSFER ;DBIA #1378
 I $$GET1^DIQ(42,LOC,.03)'="PSYCHIATRY" S ISMH=0  ;,TRNSCTN'=2 Q  ;not a psychiatry service ward and not a TRANSFER ;DBIA #31
 Q ISMH
 ;
ONTRK(DFN,DCDT,YSDT) ;
 N ONTRK,BEGDT,ENDDT,I,LOCATIONS,APPTCNT,LIST,IDX,STS
 I 'DCDT S DCDT=$$MHDCDT^YSBWHIG2(DFN)
 I 'DCDT Q "N/A"
 I '$G(YSDT) S YSDT=$P($$NOW^XLFDT,".")
 S ONTRK="NO",BEGDT=DCDT,ENDDT=$$FMADD^XLFDT(BEGDT,30),APPTCNT=0
 D VST^ORWCV(.LIST,DFN,BEGDT,ENDDT_".2359",1)
 I '$D(LIST(4)) Q "NO" ;not enough results
 S (APPTCNT,IDX)=0 F  S IDX=$O(LIST(IDX)) Q:('IDX)!(APPTCNT>=4)  D
 .N APPTDT
 .I '$$CHKCLIN^YSBRPC($P($P(LIST(IDX),U),";",3)) Q
 .;if appointment in the past, then only count if we have outpx encounter
 .S APPTDT=$P($P(LIST(IDX),U),";",2)
 .I ($P($P(LIST(IDX),U),";",1)="A"),(APPTDT<YSDT) Q:'$P($G(^DPT(DFN,"S",APPTDT,0)),U,20)
 .S STS=$P(LIST(IDX),U,4) Q:STS["CANCEL"
 .S APPTCNT=APPTCNT+1
 I APPTCNT>=4 Q "YES"
 Q "NO"
 ;
LASTCSRE(DFN,CSRENEW,CSREUPD,CSREHEAD) ;
 N DATEFOUND,HFCLIST,TIUFND
 S TIUFND=3
 D CSRELST(.CSRENEW,.CSREUPD,.HFCLIST)
 S DATEFOUND=$$FINDDOC(DFN,0,.HFCLIST,.CSREHEAD,"",TIUFND)
 I DATEFOUND="" Q "NOT DONE"
 Q $$FMTE^XLFDT(DATEFOUND,5)
 ;
CSSRS(INSTDATA,DFN,YSDT) ;
 N ADMDT,CUTOFF,COUNT,RESULTS
 S CUTOFF=$$FMADD^XLFDT(YSDT,-90),COUNT=0
 ;Get the latest ten results from the last 90 days
 ;Need to loop from latest to last
 ;S ADMDT="" F  S ADMDT=$O(^PXRMINDX(601.84,"PI",DFN,228,ADMDT),-1) Q:'ADMDT  Q:(ADMDT<CUTOFF)  Q:COUNT=10  D
 S ADMDT="" F  S ADMDT=$O(^PXRMINDX(601.84,"PI",DFN,228,ADMDT),-1) Q:'ADMDT  Q:COUNT=10  D  ;Remove 90 day cutoff
 .N ADMIN
 .S ADMIN=0 F  S ADMIN=$O(^PXRMINDX(601.84,"PI",DFN,228,ADMDT,ADMIN)) Q:'ADMIN  D
 ..N RESULT,STOP,SCORE
 ..S SCORE="Negative"
 ..S (STOP,RESULT)=0 F  S RESULT=$O(^YTT(601.92,"AC",ADMIN,RESULT)) Q:'RESULT  Q:STOP  D
 ...N N0
 ...S N0=^YTT(601.92,RESULT,0)
 ...I ("Ques3,Ques4,Ques5,Ques8"[$P(N0,U,3)),($P(N0,U,4)=1) S SCORE="Positive",STOP=1 ;if questions 3,4,5 or 8 are 1 then positive.
 ..S COUNT=COUNT+1
 ..S RESULTS(ADMDT,ADMIN)=SCORE
 I COUNT=0 D  Q
 .S INSTDATA("c_ssrs",1,"count")=1
 .S INSTDATA("c_ssrs",1,"date")="N/A"
 .S INSTDATA("c_ssrs",1,"score")="N/A"
 ;Now need to loop from last to latest
 S COUNT=0 ;reuse count to index the JSON global
 S ADMDT="" F  S ADMDT=$O(RESULTS(ADMDT)) Q:'ADMDT  D
 .S ADMIN=0 F  S ADMIN=$O(RESULTS(ADMDT,ADMIN)) Q:'ADMIN  D
 ..S COUNT=COUNT+1
 ..S INSTDATA("c_ssrs",COUNT,"count")=COUNT
 ..S INSTDATA("c_ssrs",COUNT,"admid")=+ADMIN
 ..S INSTDATA("c_ssrs",COUNT,"date")=$$FMTE^XLFDT(ADMDT,5)
 ..S INSTDATA("c_ssrs",COUNT,"score")=RESULTS(ADMDT,ADMIN)
 Q
 ;
SAFLST(SAFDCL,SAFREV,SAFSCNO,SAFSCYES,HFCLIST) ;Take individual healthfactors and create HFCLIST
 N HF,CNT
 S CNT=0,HFCLIST=1
 S HF=$P($G(SAFDCL(1)),U,2) I HF S CNT=CNT+1,HFCLIST(1,CNT)=HF  ;Use reduced list of Health Factors for Safety Plan
 S HF=$P($G(SAFREV(1)),U,2) I HF S CNT=CNT+1,HFCLIST(1,CNT)=HF
 S HF=$P($G(SAFSCNO(1)),U,2) I HF S CNT=CNT+1,HFCLIST(1,CNT)=HF
 S HF=$P($G(SAFSCYES(1)),U,2) I HF S CNT=CNT+1,HFCLIST(1,CNT)=HF
 Q
CSRELST(CSRENEW,CSREUPD,HFCLIST)  ;Take individual health factors and create HFCLIST
 N HF,CNT
 S HFCLIST=1,CNT=0
 S HF=$P($G(CSRENEW(1)),U,2) I HF S CNT=CNT+1,HFCLIST(1,CNT)=HF  ;Use reduced list of Health Factors for CSRE
 S HF=$P($G(CSREUPD(1)),U,2) I HF S CNT=CNT+1,HFCLIST(1,CNT)=HF
 Q
