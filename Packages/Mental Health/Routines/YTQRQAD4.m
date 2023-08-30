YTQRQAD4 ;ISP/MJB - RESTful Calls to handle MHA lists ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**158,178,182,181,187,199,202,204**;Dec 30, 1994;Build 18
 ;
 ; Reference to PXRMINDX in ICR #4290
 ;
GETLIST(ARGS,RESULTS) ; GET LIST OF INSTRUMENTS FOR PATIENT
 N LST,TST,I,NM,TEST,DFN,SRISK
 N ADMINDT,ADMINID,CMPL,CNT,HIT,PAT,G,YSIENS,YSDATA,N,STR,ERRLST,ERRSTR
 N ADMINAR,XDT,SAVEDT
 S NM="",N=0
 K ^TMP("YTQ-JSON",$J) S CNT=0
 D SETRES("{""instruments"":[")
 S HIT=""
 S DFN=+$G(ARGS("dfn"))
 D UPDTSRFL  ; Get list of instruments for patient and update Suicide Risk Flag
 I DFN'?1N.NP D SETERROR^YTQRUTL(404,"Bad Patient ID: "_DFN) QUIT
 I '$D(^DPT(DFN,0)) D SETERROR^YTQRUTL(404,"Patient Not Found: "_DFN) QUIT
 F  S NM=$O(^YTT(601.84,"C",DFN,NM)) Q:'NM  D
 .S G=$G(^YTT(601.84,NM,0))
 .I G="" S ERRLST(NM)="" Q  ;-->out
 .S CMPL=$P(G,U,9) I CMPL="Y" D
 ..S ADMINDT=$P(G,U,4) Q:ADMINDT=""
 ..S ADMINAR(-ADMINDT,NM)=""
 S XDT="" F  S XDT=$O(ADMINAR(XDT)) Q:XDT=""  D
 .S NM="" F  S NM=$O(ADMINAR(XDT,NM)) Q:NM=""  D
 ..S STR=""
 ..S G=$G(^YTT(601.84,NM,0))
 ..S TST=$P(G,U,3)
 ..I $P($G(^YTT(601.71,TST,2)),U,2)="C" QUIT
 ..S CMPL=$P(G,U,9) I CMPL="Y" D 
 ...S NAME=$P($G(^YTT(601.71,TST,0)),U,1)
 ...S ADMINID=$P(G,U,1),ADMINDT=$P(G,U,4),PAT=$P(G,U,2)
 ...S SAVEDT=$P(G,U,5)
 ...S SRISK=$P(G,U,14) I SRISK="" S SRISK=0
 ...S STR="{""adminId"":"""_ADMINID_""", ""instrumentName"":"""_NAME_""" , ""instrumentIen"":"""_TST_""" , ""administrationDate"":"""_$$FMTE^XLFDT(ADMINDT)_""" , ""saveDate"":"""_$$FMTE^XLFDT(SAVEDT)_""" , ""suicideRisk"":"""_SRISK_""" },"
 ..I STR]"" S HIT=1 D SETRES(STR)
 I $D(ERRLST) D  Q
 . S (ERRSTR,NM)="" F  S NM=$O(ERRLST(NM)) Q:NM=""  D
 .. S ERRSTR=ERRSTR_NM_", "
 . S ERRSTR=$E(ERRSTR,1,$L(ERRSTR)-2)
 . D SETERROR^YTQRUTL(404,"Instrument not found: "_ERRSTR)
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
SETRES(STR) ;
 S CNT=CNT+1,^TMP("YTQ-JSON",$J,CNT,0)=STR
 Q
 ;
GETLOCS(ARGS,RESULTS) ; get list of hospital locations
 ; C=Clinics, Z=Other, screened by $$ACTLOC
 ; .Y=returned list, ORFROM=text to $O from, DIR=$O direction.
 N I,IEN,CNT,LCNT,STR,LOC,HIT,DIR,ORFROM
 N ROOT,LROOT
 N STRT,EXCT
 S HIT=0,CNT=0,DIR=1,ORFROM=""
 S ROOT=$$UP^XLFSTR($G(ARGS("locmatch"))),LROOT=$L(ROOT)
 D SETRES("{""locations"":[")
 ;Handle Exact match first
 I $D(^SC("B",ROOT)) D
 . S IEN="" F  S IEN=$O(^SC("B",ROOT,IEN)) Q:'IEN  D
 ..Q:("CW"'[$P($G(^SC(IEN,0)),U,3)!('$$ACTLOC(IEN)))
 ..S STR="{""locId"": """_IEN_""", ""locName"": """_ROOT_"""},",HIT=IEN
 ..D SETRES(STR)
 S ORFROM=$S(+ROOT=ROOT:ROOT_" ",1:ROOT)
 S I=0,LCNT=99999  ;Return all locs for now
 ;F  Q:I'<LCNT  S ORFROM=$O(^SC("B",ORFROM),DIR) Q:ORFROM=""  D  ; IA# 10040.
 F  Q:I'<LCNT  S ORFROM=$O(^SC("B",ORFROM),DIR) Q:ORFROM=""  Q:$E(ORFROM,1,LROOT)'=ROOT  D  ; IA# 10040.
 .S IEN="" F  S IEN=$O(^SC("B",ORFROM,IEN),DIR) Q:'IEN  D
 ..Q:("CW"'[$P($G(^SC(IEN,0)),U,3)!('$$ACTLOC(IEN)))
 ..S STR="{""locId"": """_IEN_""", ""locName"": """_ORFROM_"""},",HIT=IEN
 ..D SETRES(STR)
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last ","
 I HIT=0 D SETRES("{}")  ;Empty set, should not happen
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
ACTLOC(LOC) ; Function: returns TRUE if active hospital location
 ; IA# 10040.
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
GETCATA(DOCNAME,RESULTS) ; set ^TMP with contents of the document named and categories
 N CNT,HIT,NMB,NAME,IENI,IENC,CATN,XSTR,STAFF,OP,ALWN,DARR
 K ^TMP("YTQ-JSON",$J)
 S CNT=0,NMB="",NAME="",HIT=""
 D SETRES("{""Instruments"":[")
 S (IENI,NAME)=""
 F  S NAME=$O(^YTT(601.71,"B",NAME)) Q:NAME=""  D
 . S HIT=1
 . S IENI="" S IENI=$O(^YTT(601.71,"B",NAME,IENI))
 . S OP=$P($G(^YTT(601.71,IENI,2)),"^",2)
 . I OP'="Y" Q
 . I $E(NAME,1,7)="CAT-CAD" Q  ;only used for interview
 . I $$GET^XPAR("ALL","YSCAT DISABLED",1,"Q") Q:$E(NAME,1,4)="CAT-"  Q:$E(NAME,1,4)="CAD-"
 . S STAFF=$P($G(^YTT(601.71,IENI,9)),U,4)
 . S STAFF=$S(STAFF="Y":"true",1:"false")
 . S ALWN=$$ALWN2^YTQRQAD3(IENI)  ;Added ALLOWNOTE function call
 . S STR="{""instrumentName"":"""_NAME_""", ""staffOnly"":"""_STAFF_""" , ""allowNote"":"""_ALWN_""" ,"
 . D SETRES(STR)
 . D GETDES(NAME,.DARR)
 . I $D(DARR) D
 .. N DI S DI="" F  S DI=$O(DARR(DI)) Q:DI=""  D
 ... D SETRES(DARR(DI))
 . S STR="""instrumentCategory"": ["
 . S IENC=""
 . I '$D(^YTT(601.71,IENI,10,"B")) D
 .. S CATN=""
 .. S XSTR="{""categoryName"":"""_CATN_"""}"
 .. D SETRES(STR)
 . I $D(^YTT(601.71,IENI,10,"B")) D
 .. F  S IENC=$O(^YTT(601.71,IENI,10,"B",IENC)) Q:'IENC  D
 ... S CATN=""
 ... S CATN=^YTT(601.97,IENC,0)
 ... S XSTR="{""categoryName"":"""_CATN_"""},"
 ... S STR=STR_XSTR
 .. S STR=$E(STR,1,$L(STR)-1)
 .. D SETRES(STR)
 . ;I CATN'="" S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 . D SETRES("]},")  ;Close of the multiple Category, and Close off the Instrument - add comma for next Instrument
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
GETDES(NAME,DARR) ;Get Instrument Description
 N DARG,YSDOUT,YSDARR,YSER,NDX,STR
 M YSDARR=DARR
 S DARG("instrumentName")=NAME
 D GINSTD^YTQRQAD(.DARG,.YSDOUT)
 D ENCODE^XLFJSON("YSDOUT","YSDARR","YSER")
 I $D(YSER) K YSDARR Q
 M DARR=YSDARR
 S NDX=$O(DARR("")) S DARR(NDX)=$E(DARR(NDX),2,$L(DARR(NDX)))  ;Strip off leading {
 S NDX=$O(DARR(""),-1) S DARR(NDX)=$E(DARR(NDX),1,$L(DARR(NDX))-1)_", "  ;Strip off trailing } add , for next property
 Q
 ;
GETINTRP(ARGS,RESULTS) ;Get Interpretive Description for all instruments
 ;Manually build JSON because text can be too long and cause XLFJSON arrays to break on the front end.
 N NAME,IEN,IARR,I,ERR,YSARR,DARR,ICNT,CRLF,OP,LN
 N IEN,IARR,I,ERR,CRLF,CRL,OP,LN,STR,INTERP
 K ^TMP("YTQ-JSON",$J)
 S ICNT=0,CRLF="\n",CRL=$L(CRLF)
 S LN=1,^TMP("YTQ-JSON",$J,LN,0)="{""Instruments"":["
 S NAME="" F  S NAME=$O(^YTT(601.71,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^YTT(601.71,"B",NAME,""))
 . S OP=$P($G(^YTT(601.71,IEN,2)),U,2) Q:OP'="Y"
 . K IARR D GET1^DIQ(601.71,IEN_",",110,"","IARR","ERR")
 . Q:'$D(IARR)
 . S INTERP=""
 . S I=0 F  S I=$O(IARR(I)) Q:I=""  D
 .. S INTERP=INTERP_IARR(I)_CRLF
 . S INTERP=$E(INTERP,1,$L(INTERP)-CRL)
 . S LN=LN+1,^TMP("YTQ-JSON",$J,LN,0)="{""instrumentId"":"_IEN_",""name"":"""_NAME_""",""interpText"":"""_INTERP_"""},"
 S STR=^TMP("YTQ-JSON",$J,LN,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,LN,0)=STR
 S LN=LN+1,^TMP("YTQ-JSON",$J,LN,0)="]}"
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
ASMTLST(ARGS,RESULTS) ; get assignments identified by patient id with list of instruments and last complete date
 N ASMT,ORDBY,I,DATA,ENTRY,PROG,ASGNDT,IN
 N ADMINID,YSIENS,YSDATA,N,ASMTID,NOD,LSTDG
 N ASTR,PROG,NWA,IADM
 N MHADLST,IHIT,PATLST,DTGIVE,ADMLST
 N LSTINST,MHCMPLT,MHTST,APPSRC
 S NM="",N=0
 S ASMT="",ORDBY=""
 K ^TMP("YTQ-JSON",$J) S CNT=0
 S DFN=+$G(ARGS("dfn"))
 D ASMTIDA(DFN,.LSTINST)  ;Get Last MH ADMIN for all instruments
 D INCMPLT(DFN,DUZ,.INCMPL)  ;Get list of partially complete ADMINS
 D SETRES("{""patientAssignments"":[")
 S ORDBY=0 F  S ORDBY=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY)) Q:'ORDBY  D
 .S ASMT=0 F  S ASMT=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)) Q:'ASMT  D
 ..Q:'$D(^XTMP("YTQASMT-SET-"_ASMT))
 ..S NOD="YTQASMT-SET-"_ASMT
 ..S ENTRY=$G(^XTMP(NOD,1,"entryMode"))
 ..S DTGIVE=$G(^XTMP(NOD,1,"date"))
 ..S IN=0 F  S IN=$O(^XTMP(NOD,1,"instruments",IN)) Q:+IN=0  D
 ...S ADMINID=+$G(^XTMP(NOD,1,"instruments",IN,"adminId"))
 ...Q:ADMINID=0
 ...S MHCMPLT(ADMINID)=$$GET1^DIQ(601.84,ADMINID_",",8,"I")
 ...S LSTDG=$G(MHADLST(ENTRY,ADMINID))
 ...I $$FMDIFF^XLFDT(DTGIVE,LSTDG,2)>0 S MHADLST(ENTRY,ADMINID)=DTGIVE,ADMLST(ADMINID)=ASMT Q
 S HIT=""
 F  S ORDBY=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY)) Q:'ORDBY  D
 .F  S ASMT=$O(^XTMP("YTQASMT-INDEX","AD",DFN,ORDBY,ASMT)) Q:'ASMT  D
 ..Q:'$D(^XTMP("YTQASMT-SET-"_ASMT))
 ..S NOD="YTQASMT-SET-"_ASMT
 ..S ENTRY=$G(^XTMP(NOD,1,"entryMode"))
 ..S APPSRC=$G(^XTMP(NOD,1,"appSrc"))
 ..I ENTRY="patient" D  Q
 ... S (IHIT,I)=0 F  S I=$O(^XTMP(NOD,1,"instruments",I)) Q:+I=0  D
 .... S ADMINID=+$G(^XTMP(NOD,1,"instruments",I,"adminId")) Q:$D(PATLST(ADMINID))!(ADMINID=0)
 .... S IHIT=1,PATLST(ADMINID)=ENTRY_U_$G(^XTMP(NOD,1,"date"))
 ... ;Q:IHIT=0
 ... S HIT=1 D SETASGN(ASMT) Q  ;Always include Patient Assignment for possible Staff completion
 ..S ASGNDT=$P(^XTMP(NOD,1,"date"),".")
 ..S (I,IHIT)=0 F  S I=$O(^XTMP(NOD,1,"instruments",I)) Q:+I=0  D
 ...S ADMINID=+$G(^XTMP(NOD,1,"instruments",I,"adminId"))
 ...I ADMINID'=0 D
 ....Q:$D(MHADLST("patient",ADMINID))  ;If ADMINID part of a PE Assignment, PE trumps SE because of Legacy MHA flow.
 ....I $G(MHCMPLT(ADMINID))="Y" D  Q
 .....;S MHTST=^XTMP(NOD,1,"instruments",I,"name")
 .....;D RMVTEST^YTQRQAD1(ASMT,MHTST,"","Y")
 ....I $G(ADMLST(ADMINID))=ASMT S IHIT=1 K INCMPL(ADMINID)  ;This Assignment has a valid MH ADMINISTRATIONS
 ..I APPSRC="mhaweb",(IHIT=0) D SETASGN(ASMT) Q  ;If an MHAWeb Assignment, always show no matter Instrument Admin status
 ..I IHIT=1 S HIT=1 D SETASGN(ASMT)
 ; Handle any remaining incomplete MH ADMINISTRATIONS
 I $D(INCMPL) S IADM="" F  S IADM=$O(INCMPL(IADM)) Q:IADM=""  D
 . Q:$D(MHADLST("patient",IADM))
 . S ASTR=INCMPL(IADM)
 . S PROG=$$PROGRESS^YTQRQAD1(IADM,$P(ASTR,U,4))
 . K DATA
 . S DATA("adminDate")=$P($P(ASTR,U,2),"@")
 . S DATA("date")=$P(ASTR,U,3)
 . S DATA("entryMode")="staff"
 . S DATA("catInfo")="null"
 . S DATA("interview")=$P(ASTR,U,9)
 . S DATA("location")=$P(ASTR,U,8)
 . S DATA("orderedBy")=DUZ
 . ;S DATA("appSrc")="mhaweb"
 . S DATA("patient","dfn")=DFN
 . I $P(ASTR,U,7)]"" S DATA("consult")=$P(ASTR,U,7)
 . S DATA("instruments",1,"adminId")=IADM
 . S DATA("instruments",1,"complete")="false"
 . S DATA("instruments",1,"name")=$P(ASTR,U,5)
 . S DATA("instruments",1,"progress")=+PROG
 . S NWA=$$NEWASMT^YTQRQAD1(.ARGS,.DATA),NWA=$P(NWA,"/",$L(NWA,"/"))
 . I +NWA D SETASGN(NWA) S HIT=1
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETASGN(ASMT) ;Set up the Assignment JSON
 N DATA,ENTRY,ASSGNDT,CATHIT,STR,NAME,TSTIEN,CMPL,PROG,EXPDT,XSTR,XADMIN
 N LSTADMIN,LSTDT,STAFF
 S ASSGNDT=$P(^XTMP("YTQASMT-SET-"_ASMT,0),U,2)  ;Add Assign dt
 S ENTRY=$G(^XTMP("YTQASMT-SET-"_ASMT,1,"entryMode"))
 S STR="{""assignmentId"":"""_ASMT_""" , ""entryMode"":"""_ENTRY_""",""assignDt"":"""_$$FMTE^XLFDT($P(ASSGNDT,"."))_""", ""instruments"": ["
 S I="",CATHIT=0 F  S I=$O(^XTMP("YTQASMT-SET-"_ASMT,1,"instruments",I)) Q:'I  D
 .K DATA
 .M DATA=^XTMP("YTQASMT-SET-"_ASMT,1,"instruments",I)
 .S NAME=$G(DATA("name"))
 .S TSTIEN=$G(DATA("id"))
 .S CMPL=$G(DATA("complete"))
 .S XADMIN=$G(DATA("adminId"))
 .I XADMIN,'$D(^YTT(601.84,XADMIN)) D RMVTEST^YTQRQAD1(ASMT,NAME) Q
 .I XADMIN,'$$CHKADM(XADMIN,NAME,DFN) D RMVTEST^YTQRQAD1(ASMT,NAME) Q  ;MH ADMIN exists but was reused by diff Patient/Instrument
 .S PROG=$$PROGRESS^YTQRQAD1(XADMIN,TSTIEN,ASMT)
 .I PROG="" S PROG=0
 .S EXPDT=$P(^XTMP("YTQASMT-SET-"_ASMT,0),U) ; Add Expiration dt
 .S (LSTADMIN,LSTDT)="",STAFF="false"  ;LSTINST set up from call to ASMTIDA2
 .S LSTDT=$O(LSTINST(TSTIEN,""),-1) I LSTDT'="" S LSTADMIN=$O(LSTINST(TSTIEN,LSTDT,""),-1),STAFF=LSTINST(TSTIEN,LSTDT,LSTADMIN)
 .S XSTR="{""instrumentName"":"""_NAME_""",""lastDone"":"""_$$FMTE^XLFDT($P(LSTDT,"."))_""",""adminId"":"""_XADMIN_""",""instrumentComplete"":"""_CMPL_""",""staffOnly"":"_STAFF
 .S XSTR=XSTR_", ""progress"": """_PROG_""",""expDt"":"""_$$FMTE^XLFDT($P(EXPDT,"."))_"""},"
 .S STR=STR_XSTR,CATHIT=1
 I '$D(^XTMP("YTQASMT-SET-"_ASMT)) Q  ;Assignment could have been deleted if RMVTEST was last/only test in assignment
 I $D(^XTMP("YTQASMT-SET-"_ASMT,1,"instruments")) S HIT=1
 D SETRES(STR)
 I CATHIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]},")  ;Close of the multiple Category, and Close off the Instrument - add comma for next Instrument
 Q
INCMPLT(DFN,ORDBY,INCMPL) ; add list of incomplete instruments for DFN and ORDBY
 ; expects RSP,YSIDX,PTADMIN
 Q:'ORDBY  Q:'DFN
 N I,X,YS,YSDATA,YSNOW,YSDOW,OFFSET,YSDTSAV,YSRSTRT,YSDG,YSINAM,YSADMIN,YSORD,YSCONS,PID,PTNAM,YSARR
 N YSIN,YSINIEN,YSINTTL,YSLOC,YSINTRV,YSSRC
 N VA,VADM,VAERR
 D DEM^VADPT I $G(VAERR) D SETERROR^YTQRUTL(400,"Missing Pt Info") Q
 S PID=VA("BID"),PTNAM=VADM(1)
 S YSNOW=$$NOW^XLFDT
 S YSDOW=$$DOW^XLFDT(YSNOW)
 S OFFSET=$S(YSDOW=5:2,YSDOW=6:1,1:0)
 S YS("DFN")=DFN,YS("COMPLETE")="N"
 D ADMINS^YTQAPI5(.YSDATA,.YS)
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . ;I $E($P(YSDATA(I),U,2),1,7)="CAT-CAD" QUIT         ; web only
 . ;I $D(PTADMIN(+YSDATA(I))) QUIT                     ; skip pt assigned
 . I $P(YSDATA(I),U,5)'=ORDBY QUIT                    ; not same orderedBy
 . S YSDTSAV=$P(YSDATA(I),U,4) I 'YSDTSAV QUIT        ; no date, bad entry
 . S YSRSTRT=$P(YSDATA(I),U,15) S:'YSRSTRT YSRSTRT=2  ; account for weekends
 . ; always restartable is -1, comparing full 24 hour periods so use seconds
 . I (YSRSTRT'=-1),$$FMDIFF^XLFDT(YSNOW,YSDTSAV,2)>((YSRSTRT+OFFSET)*86400) Q
 . S YSADMIN=$P(YSDATA(I),U)                          ; admin ien
 . S YSINAM=$P(YSDATA(I),U,2)                         ; instrument name
 . S YSINIEN=$P(YSDATA(I),U,11)                       ; instrument ien
 . S YSDG=$P(YSDATA(I),U,3)                           ; date given
 . S YSDG=$P($$FMTE^XLFDT(YSDG,5),".")                        ; mm/dd/yyyy
 . S YSLOC=$P(YSDATA(I),U,14)
 . S YSINTRV=$P(YSDATA(I),U,6)
 . D GETS^DIQ(601.84,YSADMIN_",","2;15;17","IE","YSARR")
 . S YSCONS=$G(YSARR(601.84,YSADMIN_",",17,"I"))
 . S YSSRC=$G(YSARR(601.84,YSADMIN_",",15,"E")) Q:YSSRC="web"  ;Don't include Incomplete MHA Web generated admins
 . S INCMPL(YSADMIN)=YSADMIN_U_YSDG_U_YSDTSAV_U_YSINIEN_U_YSINAM_U_YSRSTRT_U_YSCONS_U_YSLOC_U_YSINTRV_U_YSSRC
 Q
CHKADM(YSADMIN,YSNAM,YSDFN) ;Check if Instrument Admin is the same as what is in XTMP
 N STAT,YSIENS,YSARR,YSERR
 I $G(YSNAM)="" S STAT=0 Q STAT
 I +$G(YSDFN)=0 S STAT=0 Q STAT
 I +$G(YSADMIN)=0 S STAT=0 Q STAT
 S STAT=1  ;OK
 S YSIENS=YSADMIN_","
 D GETS^DIQ(601.84,YSIENS,"1;2","EI","YSARR","YSERR")
 I $D(YSERR) S STAT=0 Q STAT
 I $G(YSARR(601.84,YSIENS,2,"E"))'=$G(YSNAM) S STAT=0
 I $G(YSARR(601.84,YSIENS,1,"I"))'=YSDFN S STAT=0
 Q STAT
 ;
ASMTIDA(DFN,LSTINST) ; get administrations identified by DFN and TSTIEN
 ; Used to find last completed instrument admin
 N ADMINDT,ADMINID,CMPL,PAT,NM
 K ARRAY
 S NM="",N=0
 I DFN'?1N.NP S YSDATA(1)="[ERROR]",YSDATA(2)="bad DFN" Q  ;-->out asf 2/22/08
 I '$D(^DPT(DFN,0)) S YSDATA(1)="[ERROR]",YSDATA(2)="no pt" Q  ;-->out
 F  S NM=$O(^YTT(601.84,"C",DFN,NM))  Q:'NM  D
 .S G=$G(^YTT(601.84,NM,0))
 .I G="" S YSDATA(1)="[ERROR]",YSDATA(2)=YSIENS_" bad ien in 84" Q  ;-->out
 .S PAT=$P(G,U,2) Q:PAT'=DFN
 .S TST=$P(G,U,3)
 .S CMPL=$P(G,U,9) I CMPL="Y" D 
 ..S NAME=$P($G(^YTT(601.71,TST,0)),U,1)
 ..S STAFF=$P($G(^YTT(601.71,TST,9)),U,4) S:STAFF="" STAFF="N"
 ..S STAFF=$S(STAFF="Y":"true",1:"false")
 ..S ADMINID=$P(G,U,1),ADMINDT=$P(G,U,4)
 ..S LSTINST(TST,ADMINDT,ADMINID)=STAFF
 Q
 ;
UPDTSRFL ;
 ; ICR #4290 READ OF CLINICAL REMINDER INDEX (PXRMINDX) 
 ;   Set index for 601.84 MH ADMINISTRATIONS
 ;      X(1)=Patient X(2)=Instrument X(3)=Date Given
 ;      ^PXRMINDX(601.84,"IP",X(2),X(1),X(3),DA)=""
 ;      ^PXRMINDX(601.84,"PI",X(1),X(2),X(3),DA)=""
 ;
 ; Loop through ^PXRMINDX(601.84,"PI",X(1),X(2) to get list of completed instruments
 ; that are associated with the patient
 ;
 N INSTIEN,TEMP,SRCALL
 S INSTIEN=""
 F  S INSTIEN=$O(^PXRMINDX(601.84,"PI",DFN,INSTIEN)) Q:INSTIEN=""  D  ;Get list of instrument IENs for patient
 . S TEMP=$G(^YTT(601.71,INSTIEN,9))
 . S TEMP(1)=$P(TEMP,U,5),TEMP(2)=$P(TEMP,U,6) ;Get Suicide Tag & routine
 . I TEMP(1)'="",(TEMP(2)'="") D
 . . S SRCALL="D "_TEMP(2)_U_TEMP(1)
 . . X SRCALL
 Q
 ;
