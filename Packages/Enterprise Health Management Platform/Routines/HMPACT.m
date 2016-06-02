HMPACT ;ASMR/EJK - Patient Appointment Broker Call;8/4/14  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Oct 10, 2014;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
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
 ;
 N DFN,LOC,OVER,PAT,REQ,SD,SCX
 I '$G(BEG) S BEG=$$HTFM^XLFDT(+$H)  ; Default current day
 S BEG=$P(BEG,".",1)
 I BEG'?7N Q -1
 I '$G(END) S END=$$HTFM^XLFDT(+$H)  ; Default current day
 S END=$P(END,".",1)
 I END'?7N Q -1
 I END<BEG Q -1
 K ^TMP("HMPAPPT",$J)
 S HMPOUT=$NA(^TMP("HMPAPPT",$J))
 I $G(LOCIEN) D SCHED(LOCIEN,BEG,END) G ENDAPPT
 K LOC
 ;DE2818, changed location check routine to HMPXGSD
 D CLINLOC^HMPXGSD(.LOC,"",1)  ; Lookup VistA Clinic Locations
 ;
 ; The clinic locations will be returned in the HMPOUT array:
 ;     LOC(D1)=LOCIEN^LOCNAME
 ;
LOCLKUP ;
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
 ;S SD=BEG
 ;F  S SD=$O(^SC(LOCIEN,"S",SD)) Q:SD=""!(SD>END)  D  ; Quit if null or date > END
 ;. S PAT=0
 ;. F  S PAT=$O(^SC(LOCIEN,"S",SD,1,PAT)) Q:PAT=""  D
 ;.. Q:'$D(^SC(LOCIEN,"S",SD,1,1))
 ;..S DFN=$P(^SC(LOCIEN,"S",SD,1,PAT,0),U,1)
 ;.. I DFN=$P($G(^HMP(800000,1,1,DFN,0)),U,1) Q  ; Check for subscription and skip if subscribed
 ;.. ; Use supported SDA^VADPT call to get the appt data from the Patient File (#2)
 ;.. ; VASD("F")= "From" Appointment Date without timestamp.
 ;.. ; VASD("T")= "To" Appointment Date without timestamp.  This is set to the "From" date so only
 ;.. ;            one day is evaluated since we're examining each date entry in ^SC(LOCIEN,"S",SD)
 ;.. ; VASD("C")= Array of clinic location IENs. This is set to the current location only.
 ;.. ;
 ;.. S VASD("F")=$P(SD,".",1),VASD("T")=VASD("F"),VASD("C",LOCIEN)=""
 ;.. D SDA^VADPT
 ;.. Q:'$D(^UTILITY("VASD",$J,1))
 ;.. ; ^UTILITY("VASD",$J) is killed by VADPT0
 K ^TMP($J,"SDAMA301")  ; kill the TMP global that stores the return data from the $$SDAPI^SDAMA301 call
 K SDARRAY,SDCNT  ; kill the SDARRAY that stores the input variables to the $$SDAPI^SDAMA301 call, SDCNT flag for data returned, if SDCNT > 0 data is returned in the ^TMP($J,"SDAMA301" temp global
 S SDARRAY(1)=BEG_";"_$G(END),SDARRAY(2)=$G(LOCIEN),SDARRAY("FLDS")="1;2;4"  ;input variables for $$SDAPI^SDAMA301
 S SDCNT=$$SDAPI^SDAMA301 I $G(SDCNT)>0 K XDFN,APTDATE F  S XDFN=$O(^TMP($J,"SDAMA301",LOCIEN,XDFN)) Q:XDFN'>0  S APTDATE=0 F  S APTDATE=$O(^TMP($J,"SDAMA301",XDFN,APTDATE)) Q:APTDATE'>0  D
 . I XDFN=$P($G(^HMP(800000,1,1,XDFN,0)),U,1) Q  ; Check for subscription and skip if subscribed
 . S LOCNAME=$P(^TMP($J,"SDAMA301",XDFN,APTDATE),";",2)
 . S ^TMP("HMPAPPT",$J,XDFN,APTDATE,LOCIEN)=XDFN_U_APTDATE_U_LOCNAME_U_LOCIEN  ;^TMP("HMPAPPT" is killed in APPT^HMPACT before calling this linetag (SCHED)
 K SDFN,APTDATE,LOCNAME,SDCNT,SDARRAY,^TMP($J,"SDAMA301")  ; clean up variables
 Q
 ;
ENDAPPT ;
 ;
 M @HMPOUT=^TMP("HMPAPPT",$J)
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
 . I DFN=$P($G(^HMP(800000,1,1,DFN,0)),U,1) Q  ; Check for subscription and skip if subscribed
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
