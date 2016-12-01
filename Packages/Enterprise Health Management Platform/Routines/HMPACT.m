HMPACT ;ASMR/EJK/PB/JD - Patient Appointment Broker Call;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; 2/16/16 - JD - Removed the check in line tag ADMIT to allow processing of all patients
 ;                regardless of their subscription. DE3375
 ;
 ; Feb 24, 2016 - PB removed the check in linetag SCHED that quit
 ; processing if the patient was registered in HMP(800000 as requested in DE2991
 Q
ACT(ROOT,DFN,ID,ALPHA,OMEGA,DTRANGE,REMOTE,MAX,ORFHIE) ;
 N ERR,ERRMSG,DFN,IEN,DIE,HMSTOP
 S ERR=0,ERRMSG="",DFN="",IEN="",HMSTOP=0
 S ROOT="XWBY"
 K ^TMP("ORDATA",$J)
 Q:'$D(^HMP(800001.5,"PTAPPT","HMP"))
 S DIE="^HMP(800001.5,""PTAPPT"","
 D FETCH
 D CLEAN
 Q
 ;
FETCH ;GET PENDING JSON MESSAGES AND UPDATE DATE RECORD RETRIEVED
 S X="[" D SETITEM(.ROOT,X)
 F  S IEN=$O(^HMP(800001.5,"PTAPPT","HMP",IEN)) Q:IEN=""!(HMSTOP)  D
 . S X=$G(^HMP(800001.5,"PTAPPT",IEN,"JSON"))
 . I $O(^HMP(800001.5,"PTAPPT","HMP",IEN))="" S $E(X,$L(X))="",HMSTOP=1
 . D SETITEM(.ROOT,X)
 . S DA=IEN,DR="6///1" D ^DIE
 . Q
 S X="]" D SETITEM(.ROOT,X)
 Q
 ;
CLEAN ;CLEAN UP STRAY VARIABLES
 K DA,DR,X
 Q
 ;
SETITEM(ROOT,X) ; -- set item in list - RRB US5872 
 S @ROOT@($O(@ROOT@(9999),-1)+1)=X
 Q
 ;
APPT(HMPOUT,BEG,END,LOCIEN) ; Lookup appointments by date and location
 ;
 ;Associated ICRs:
 ;  ICR#
 ;      2051:  Database Server API: Lookup Utilities
 ;             FIND1^DIC
 ;      10103: XLFDT Date functions
 ;             HTFM^XLFDT
 ;  SUPPORTED: VADPT
 ;             SDA^VADPT
 ;             KVA^VADPT
 ;             KVAR^VADPT
 ;             SDAPI^SDAMA301
 ;
 ; BEG - FileMan date for starting the search - If not defined, defaults to current date
 ; END - FileMan date to end the search - if not defined, defaults to the current date
 ; LOCIEN - The IEN for the clinic entry in the Hospital Location file (#44) If not defined, it will get a list of clinics and return the appointments for all clinics for the date range
 ; Returns data in the TMP($J,"HMPAPPT" global. Returns : DFN ^ APPOINTMENT DATE/TIME ^ CLINIC NAME ^ CLINIC IEN 
 ;
 N DFN,LOC,OVER,PAT,REQ,SD,SCX
 I '$G(BEG) S BEG=$$HTFM^XLFDT(+$H)  ; Default current day
 S BEG=$P(BEG,".",1)
 I BEG'?7N Q -1
 I '$G(END) S END=$$HTFM^XLFDT(+$H)  ; Default current day
 S END=$P(END,".",1)
 I END'?7N Q -1
 I END<BEG Q -1
 K ^TMP($J,"HMPAPPT")
 S HMPOUT=$NA(^TMP($J,"HMPAPPT"))
 I $G(LOCIEN) D SCHED(LOCIEN,BEG,END) G ENDAPPT
 K LOC
 ;DE2818, changed location check routine to HMPXGSD
 D CLINLOC^HMPXGSD(.LOC,"",1)  ; Lookup VistA Clinic Locations
 ;
 ; The clinic locations will be returned in the HMPOUT array:
 ;     LOC(D1)=LOCIEN^LOCNAME
 ;
LOCLKUP ; Gets all appointments for all clinics in the LOC(D1) array
 N LOCNAME
 S SCX=""
 F  S SCX=$O(LOC(SCX)) Q:SCX=""  D
 . S LOCIEN=$P(LOC(SCX),U,1),LOCNAME=$P(LOC(SCX),U,2)
 . D SCHED(LOCIEN,BEG,END)
 G ENDAPPT
 ;
SCHED(LOCIEN,BEG,END) ;
 ; Get list of patients and appointment dates from the
 ; using $$SDAPI^SDAMA301 api.
 ; Inputs are SDARRAY(1)=BEG;END - Beginning and ending dates for the search. 
 ; BEG must be defined.
 ; END ending date for the search. If END is undefined, the API returns all appointments starting with the BEG date.
 ; BEG and END are FileMan Date/Time. Both BEG and END are validated in the calling linetag APPT^HMPACT
 ; LOCIEN = IEN for the location in the Hospital Location file (#44). LOCIEN is validated in the calling linetag APPT^HMPACT
 ; 
 ; Feb 24, 2016 - PB - DE2991 requested that all patients be returned. Prior to DE2991, if a patient was in the HMP Subscription file (#800000)
 ; they were excluded from the return data.
 K ^TMP($J,"SDAMA301") ; Kill the TMP global that stores the results from SDAPI^SDAMA301
 K SDARRAY,SDCNT ; kill the SDARRAY that stores the input variables for the SDAPI^SDAMA301 call, SDCNT returns the number of appointments found. If SDCNT > 0 data is returned in the ^TMP($J,"SDAMA301" temp global
 S SDARRAY(1)=BEG_";"_END,SDARRAY(2)=LOCIEN,SDARRAY("FLDS")="1;2;4"  ;input variables for $$SDAPI^SDAMA301
 S SDCNT=$$SDAPI^SDAMA301(.SDARRAY) I $G(SDCNT)>0 D
 . K XDFN S XDFN=0
 . F  S XDFN=$O(^TMP($J,"SDAMA301",LOCIEN,XDFN)) Q:XDFN=""  S APTDATE=0 F  S APTDATE=$O(^TMP($J,"SDAMA301",LOCIEN,XDFN,APTDATE)) Q:APTDATE=""  D
 . . K LOCALE S LOCALE=$P(^TMP($J,"SDAMA301",LOCIEN,XDFN,APTDATE),"^",2),LOCNAME=$P(LOCALE,";",2)
 . . S ^TMP($J,"HMPAPPT",XDFN,APTDATE,LOCIEN)=XDFN_U_APTDATE_U_LOCNAME_U_LOCIEN  ;^TMP("HMPAPPT" is killed in APPT^HMPACT before calling this linetag (SCHED)
 K SDFN,APTDATE,LOCNAME,SDCNT,SDARRAY,^TMP($J,"SDAMA301")  ; clean up variables
 Q
 ;
ENDAPPT ;
 ;
 M @HMPOUT=^TMP($J,"HMPAPPT")
 K @HMPOUT@(0)
 Q
 ;
ADMIT(HMPOUT,LOCIEN) ; Lookup admissions by location
 ;
 ;Associated ICRs:
 ;  ICR#
 ;      2051:  Database Server API: Lookup Utilities
 ;             FIND1^DIC
 ;             LIST^DIC
 ;      10103: XLFDT Date functions
 ;             HTFM^XLFDT
 ;  SUPPORTED: VADPT
 ;             INP^VADPT
 ;             KVA^VADPT
 ;             KVAR^VADPT
 ;
 N DFROM,DIEN,DOUT,DPART,DRID,FILE,FLDS,FLG,MAX,PIDX,SCRN,SUBSCRP,WARD,XREF
 K ^TMP("HMPADMIT",$J)
 S HMPOUT=$NA(^TMP("HMPADMIT",$J))
 ; Get Patient list by Ward
 S FILE=2,DIEN="",FLDS="@;.1",FLG="P",MAX="",DFROM="",DPART="",XREF="ACN"
 S SCRN="I $P($G(^DPT(+Y,.102)),""^"")>0",DRID="",DOUT=""
 ; The SCRN parameter is set to insure the patient record has a current movement file entry.
 K ^TMP("DILIST",$J)
 D LIST^DIC(FILE,DIEN,FLDS,FLG,MAX,.DFROM,DPART,XREF,SCRN,DRID,DOUT)  ; ICR #2051
 ; The list of patients and associated wards are returned via the ^TMP("DILIST",$J,PIDX,0) global in the following format:
 ;      ^TMP("DILIST",$J,PIDX,0)=DFN^WARD
 ;      Note:  The WARD is the ward name, not an internal (IEN) entry
 S PIDX=0
 F  S PIDX=$O(^TMP("DILIST",$J,PIDX)) Q:PIDX=""  D
 . S DFN=$P(^TMP("DILIST",$J,PIDX,0),U,1),WARD=$P(^TMP("DILIST",$J,PIDX,0),U,2)
 . ; If the calling application passes a ward LOCIEN, Use the WARD LOCATION File (#42) to lookup
 . ; the ward (location) IEN for comparison to the requested LOCIEN to screen out any entries that don't match the request.
 . ; 
 . I LOCIEN'="",LOCIEN'=$$FIND1^DIC(42,"","BX",WARD,"B","","") Q
 . ; Check patients for HMP subscription, File (#800000) and setup patient data
 . ; Removed the subscription check.  JD - 2/16/16. DE3375
 . D GETADMIT(DFN)
 ;
ENDADMIT ;
 ;
 M @HMPOUT=^TMP("HMPADMIT",$J)
 K @HMPOUT@(0)
 Q
 ;
GETADMIT(DFN) ;
 N ADMIT,PDATA,LOC,LOCNAME,LRMBD,VAERR,VAIN
 ; Lookup patient admissions data
 ; Use supported INP^VADPT call to get the admissions data from the Patient File (#2)
 D INP^VADPT
 ; LOC = Ward (Location) IEN, LOCNAME = Ward (Location) Name, LRMBD = Room-Bed Name (Optional depending upon inpatient
 ; location setup), ADMIT = Admission date.time in VA format
 S LOC=$P(VAIN(4),U),LOCNAME=$P(VAIN(4),U,2),LRMBD=VAIN(5),ADMIT=$P(VAIN(7),U)
 K PDATA
 S PDATA=DFN_U_ADMIT_U_LOCNAME_U_LRMBD_U_LOC
 S ^TMP("HMPADMIT",$J,DFN,LOC)=PDATA
 ; Supported calls to Kill VADPT variables
 D KVAR^VADPT,KVA^VADPT
 ;
 Q
 ;
