HMPROS8 ;SLC/AGP,ASMR/RRB - Get CPRS User Default Roster List ; 6/11/14 8:38pm
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;AUG 17, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
BLDSORT(NODE,SRC,SORT,SEQ) ; emulate TStringList Sort found in CPRS
 ; append separator to ensure string sort (rather than numeric)
 ; append SEQ to avoid dropping node where SORTKEY is duplicated
 ; SORT:  A:Alphabetic;R:Room/Bed;P:Appointment Date;T:Terminal Digit;S:Source
 I $E(NODE)=U QUIT  ; i.e., "^No patients found"
 N SORTKEY,S
 S NODE=$G(NODE),S=" "
 S SORTKEY=$P(NODE,U,2)_S_SEQ ; default alphabetic by name
 I SRC="C",(SORT="P") S SORTKEY=$P(NODE,U,4)_S_SEQ
 I SRC="M" D
 .I SORT="S" S SORTKEY=$P(NODE,U,3)_S_$P(NODE,U,8)_S_$P(NODE,U,2)_S_SEQ
 .I SORT="P" S SORTKEY=$P(NODE,U,8)_S_$P(NODE,U,2)_S_SEQ
 .I SORT="T" S SORTKEY=$P(NODE,U,5)_S_SEQ
 I SRC="W",(SORT="R") S SORTKEY=$P(NODE,U,3)_S_$P(NODE,U,2)_S_SEQ
 I '$L(SORTKEY) S SORTKEY=S_SEQ
 S ^TMP("HMPSORT",$J,$P(SRC,U,2)_":"_SORT,SORTKEY)=NODE
 Q
 ;
CHKPAT(PATIENTS,SERVER) ;
 N ARGS,OUT,PAT,STATUS
 S ARGS("command")="putPtSubscription"
 S ARGS("server")=SERVER
 S PAT="" F  S PAT=$O(PATIENTS(PAT)) Q:PAT'>0  D
 .S STATUS=$G(^HMP(800000,"AITEM",PAT,SERVER))
 .I STATUS'="",STATUS>0 Q
 .S ARGS("localId")=PAT
 .D API^HMPDJFS(.OUT,.ARGS)
 Q
 ;
GETDLIST(RESULT,SERVER) ;
 N APPT,ARRAY,DFN,CNT,ERROR,GBL,GSOURCE,ISOUT,LISTIEN,LROOT,NAME,NODE,PATIENTS
 N PATTYPE,PATUID,PID,ROOM,ROOT,SOURCE,SOURCETYPE,TYPE,TYPEI,HMPSRC,HMPSORT,HMPOUT
 N XOBDATA S XOBDATA(0)=1
 N XWBOS S XWBOS(0)=1
 K ^TMP("OR",$J)
 S HMPSRC=$$LSTSRC(DUZ)
 S LISTIEN=$P(HMPSRC,U,2),HMPSRC=$P(HMPSRC,U)
 D DEFSORT^ORQPTQ11(.HMPSORT)
 D DEFLIST^ORQPTQ11(.HMPOUT)
 S GSOURCE=$S(LISTIEN>0:$$STGSRCE(HMPSRC,LISTIEN),1:"")
 K ^TMP("HMPRESULT",$J),^TMP("HMPTEMP",$J),^TMP("HMPSORT",$J)
 S CNT=0 F  S CNT=$O(^TMP("OR",$J,"PATIENTS",CNT)) Q:CNT'>0  D
 .S NODE=$G(^TMP("OR",$J,"PATIENTS",CNT,0))
 .D BLDSORT(NODE,HMPSRC,HMPSORT,CNT)
 K ^TMP("OR",$J)
 D SRTSRC(HMPSORT,HMPSRC,$P($$FDEFSRC^ORQPTQ11(DUZ),U,2))
 S GBL=$NA(^TMP("HMPSORT",$J)),CNT=0,LROOT=$L(GBL)-1,ROOT=$E(GBL,1,LROOT)
 F  S GBL=$Q(@GBL) Q:$E(GBL,1,LROOT)'=ROOT  D
 .S NODE=@GBL
 .S CNT=CNT+1
 .S DFN=$P(NODE,U),ROOM=$G(^DPT(DFN,.101)) ;ICR 10035 DE2818 ASF 11/12/15
 .S PATIENTS(DFN)=""
 .S PID=$$PID^HMPDJFS(DFN)
 .S PATTYPE=$P(NODE,U,9)
 .S APPT=$S(HMPSRC="M":$P(NODE,U,8),1:$P(NODE,U,4)),TYPE=$P(NODE,U,3),TYPEI=$P(NODE,U,7)
 .S SOURCE=$S($G(GSOURCE)'="":GSOURCE,1:$$GTSOURCE(TYPE,TYPEI))
 .S ISOUT=$S(PATTYPE="OPT":1,1:0)
 .I $P(NODE,U,3)'="" S ^TMP("HMPTEMP",$J,"data","patients",CNT,"sourceDisplayName")=$P(NODE,U,3)
 .S ^TMP("HMPTEMP",$J,"data","patients",CNT,"pid")=PID
 .S ^TMP("HMPTEMP",$J,"data","patients",CNT,"patientType")=$S(PATTYPE="OPT":"Outpatient",1:"Inpatient")
 .I $G(APPT)'="" D SETAPPT(SOURCE,APPT,DFN,CNT)
 .;S ^TMP("HMPTEMP",$J,"data","patients",CNT,"appointment")=$$JSONDT^HMPUTILS(APPT)
 .I $G(ROOM)'=""!(PATTYPE'="OPT") D STINP(DFN,CNT,ROOM)
 .;S ^TMP("HMPTEMP",$J,"data","patients",CNT,"roomBed")=ROOM
 .D STPTSRC(SOURCE,CNT)
 ;
GETDLSTX ;
 D ENCODE^HMPJSON($NA(^TMP("HMPTEMP",$J)),"RESULT","ERROR")
 I SERVER'="" D CHKPAT(.PATIENTS,SERVER)
 K ^TMP("HMPSORT",$J)
 K ^TMP("HMPTEMP",$J)
 Q
 ;
SETAPPT(SOURCE,APPT,DFN,CNT) ;
 N LOC,UID,X
 S ^TMP("HMPTEMP",$J,"data","patients",CNT,"appointment")=$$JSONDT^HMPUTILS(APPT)
 S UID=$P(SOURCE,U,2),LOC=$P($G(UID),":",5) I LOC'>0 Q
 S X="A;"_APPT_";"_+LOC
 S ^TMP("HMPTEMP",$J,"data","patients",CNT,"appointmentUid")=$$SETUID^HMPUTILS("appointment",DFN,X)
 Q
 ;
STINP(DFN,CNT,ROOM) ;
 N LOC,NODE,UID,VAIN,WIEN
 I ROOM'="" S ^TMP("HMPTEMP",$J,"data","patients",CNT,"roomBed")=ROOM
 D INP^VADPT I $G(VAIN(1))="" D KVA^VADPT Q
 S ^TMP("HMPTEMP",$J,"data","patients",CNT,"admissionUid")=$$SETUID^HMPUTILS("visit",DFN,"H"_VAIN(1))
 S WIEN=+$G(VAIN(4)) I WIEN'>0 D KVA^VADPT Q
 S LOC=+$G(^DIC(42,WIEN,44)) ;ICR 10040 DE2818 ASF 11/12/15
 S NODE=$P($G(^SC(+LOC,0)),U,1,2) ;ICR 10040 DE2818 ASF 11/12/15
 S ^TMP("HMPTEMP",$J,"data","patients",CNT,"locationUid")=$$SETUID^HMPUTILS("location","",LOC,"")
 I $P(NODE,U)'="" S ^TMP("HMPTEMP",$J,"data","patients",CNT,"locationName")=$P(NODE,U)
 I $P(NODE,U,2)'="" S ^TMP("HMPTEMP",$J,"data","patients",CNT,"locationShortName")=$P(NODE,U,2)
 D KVA^VADPT
 Q
 ;
STPTSRC(SOURCE,CNT) ;
 N UID,VAIN
 S UID=$P(SOURCE,U,2)
 S ^TMP("HMPTEMP",$J,"data","patients",CNT,"sourceUid")=UID
 I UID'["location" Q
 S ^TMP("HMPTEMP",$J,"data","patients",CNT,"locationUid")=UID
 I $P(SOURCE,U,3)'="" S ^TMP("HMPTEMP",$J,"data","patients",CNT,"sourceName")=$P(SOURCE,U,3),^TMP("HMPTEMP",$J,"data","patients",CNT,"locationName")=$P(SOURCE,U,3)
 I $P(SOURCE,U,4)'="" S ^TMP("HMPTEMP",$J,"data","patients",CNT,"sourceShortName")=$P(SOURCE,U,4),^TMP("HMPTEMP",$J,"data","patients",CNT,"locationShortName")=$P(SOURCE,U,4)
 Q
 ;
LSTSRC(ADUZ) ; Return type of list source
 ; T:TeamList, W:Ward List, P:Provider List, S:Specialty List, C:Clinic List, M:Combination
 N FROM,IEN,SRV
 S:'$G(ADUZ) ADUZ=DUZ
 S SRV=$G(^VA(200,ADUZ,5)) I +SRV>0 S SRV=$P(SRV,U) ;ICR 10060 DE2818 ASF 11/12/15
 S FROM=$$GET^XPAR("USR.`"_ADUZ_"^SRV.`"_+$G(SRV),"ORLP DEFAULT LIST SOURCE",1,"Q")
 I FROM="M" Q FROM
 I FROM="T" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(SRV),"ORLP DEFAULT TEAM",1,"Q") Q FROM_U_+$G(IEN)
 I FROM="W" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(SRV),"ORLP DEFAULT WARD",1,"Q") Q FROM_U_+$G(IEN)
 I FROM="P" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(SRV),"ORLP DEFAULT PROVIDER",1,"Q") Q FROM_U_+$G(IEN)
 I FROM="S" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(SRV),"ORLP DEFAULT SPECIALTY",1,"Q") Q FROM_U_+$G(IEN)
 I FROM="C" S API="ORLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT)),IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),API,1,"Q") Q FROM_U_+$G(IEN)
 Q FROM
 ;
GETCLIST(RESULT,SERVER,ID,START,END) ;
 N APPT,CNT,DFN,ITR,NODE,PATIENTS,PID,SOURCE,TEMP,ERROR,HMPARRAY,HMPSORT,S
 K ^TMP("HMPTEMP",$J)
 D DEFSORT^ORQPTQ11(.HMPSORT)
 D CLINPTS2^ORQPTQ2(.HMPARRAY,ID,START,END)
 S SOURCE=$$GTSOURCE("Cl",ID)
 S S=" " ; separator for sort
 S CNT=0 F  S CNT=$O(HMPARRAY(CNT)) Q:CNT'>0  D
 . S NODE=$G(HMPARRAY(CNT))
 . Q:$E(NODE)=U  ; i.e., "^No appointments"
 . I HMPSORT="P" S TEMP($P(NODE,U,4)_S_CNT)=NODE Q
 . S TEMP($P(NODE,U,2)_S_$P(NODE,U,4)_S_CNT)=NODE
 S CNT=0,ITR="" F  S ITR=$O(TEMP(ITR)) Q:ITR=""  D
 . S NODE=TEMP(ITR),CNT=CNT+1
 . S DFN=$P(NODE,U),APPT=$P(NODE,U,4)
 . S PATIENTS(DFN)="",PID=$$PID^HMPDJFS(DFN)
 . S ^TMP("HMPTEMP",$J,"data","patients",CNT,"pid")=PID
 . S ^TMP("HMPTEMP",$J,"data","patients",CNT,"patientType")=$S($P(NODE,U,9)="OPT":"Outpatient",1:"Inpatient")
 . I $G(APPT)'="" D SETAPPT(SOURCE,APPT,DFN,CNT)
 . ;S ^TMP("HMPTEMP",$J,"data","patients",CNT,"appointment")=$$JSONDT^HMPUTILS(APPT)
 D SRTSRC(HMPSORT,"C",$P($G(^SC(ID,0)),U)) ;ICR 10040 DE2818 ASF 11/12/15
 D ENCODE^HMPJSON($NA(^TMP("HMPTEMP",$J)),"RESULT","ERROR")
 ;I SERVER'="" D CHKPAT(.PATIENTS,SERVER)    ;    *S68-JCH*
 Q
 ;
GTSOURCE(TYPE,INT) ;
 N REC,RESULT,SPEC,SPECTYPE,UID
 S SPEC=$P(TYPE," ")
 S SPECTYPE=$S(SPEC="Cl":"Clinic",SPEC="Wd":"Ward",SPEC="Sp":"Treating Specality",SPEC="Pr":"Provider",SPEC="Tm":"OR Team",1:SPEC)
 I SPECTYPE=SPEC Q SPEC_U_""
 I SPECTYPE="Ward" S REC=+$G(^DIC(42,INT,44)) I REC'=INT S INT=REC ;ICR 10039 DE2818 ASF 11/12/15
 S UID=$$SETUID^HMPUTILS($S(SPEC="Cl":"location",SPEC="Wd":"location",SPEC="Sp":"treatingSpecialty",SPEC="Pr":"provider",SPEC="Tm":"orTeam",1:SPEC),"",INT,"")
 S RESULT=SPECTYPE_U_UID
 I UID["location" S RESULT=RESULT_U_$P($G(^SC(+INT,0)),U,1,2)
 Q RESULT
 ;
STGSRCE(SPEC,INT) ;
 N REC,RESULT,SPECTYPE,UID
 ;T:TeamList, W:Ward List, P:Provider List, S:Specialty List, C:Clinic List, M:Combination
 S RESULT=""
 I "TWPSC"'[SPEC Q RESULT
 S SPECTYPE=$S(SPEC="C":"Clinic",SPEC="W":"Ward",SPEC="S":"Treating Specality",SPEC="P":"Provider",SPEC="T":"OR Team",1:SPEC) I SPECTYPE=SPEC Q RESULT
 I SPECTYPE="Ward" S REC=+$G(^DIC(42,INT,44)) I REC'=INT S INT=REC ;ICR 10039 DE2818 ASF 11/12/15
 S UID=$$SETUID^HMPUTILS($S(SPEC="C":"location",SPEC="W":"location",SPEC="S":"treatingSpecialty",SPEC="P":"provider",SPEC="T":"orTeam",1:SPEC),"",INT,"")
 S RESULT=SPECTYPE_U_UID
 I UID["location" S RESULT=RESULT_U_$P($G(^SC(+INT,0)),U,1,2) ;ICR 10060 DE2818 ASF 11/12/15
 Q RESULT
 ;        
GETWLIST(RESULT,SERVER,ID) ;
 N CNT,DFN,ITR,NODE,PATIENTS,PID,ROOM,TEMP,WARD,ERROR,HMPARRAY,HMPSORT
 K ^TMP("HMPTEMP",$J)
 D DEFSORT^ORQPTQ11(.HMPSORT)
 D BYWARD^ORWPT(.HMPARRAY,ID)
 S CNT=0 F  S CNT=$O(HMPARRAY(CNT)) Q:CNT'>0  D
 . S NODE=$G(HMPARRAY(CNT))
 . Q:$E(NODE)=U  ; i.e., "^No patients found"
 . I HMPSORT="R" S TEMP($P(NODE,U,3)_" "_CNT)=NODE Q
 . S TEMP($P(NODE,U,2)_" "_CNT)=NODE
 S ITR="",CNT=0 F  S ITR=$O(TEMP(ITR)) Q:ITR=""  D
 .S NODE=TEMP(ITR),CNT=CNT+1
 .S DFN=$P(NODE,U),ROOM=$P(NODE,U,3)
 .S PATIENTS(DFN)="",PID=$$PID^HMPDJFS(DFN)
 .S ^TMP("HMPTEMP",$J,"data","patients",CNT,"pid")=PID
 .D STINP(DFN,CNT,ROOM)
 .;S ^TMP("HMPTEMP",$J,"data","patients",CNT,"roomBed")=ROOM
 D SRTSRC(HMPSORT,"W",$P($G(^DIC(42,ID,0)),U)) ;ICR 10039 DE2818 ASF 11/12/15
 D ENCODE^HMPJSON($NA(^TMP("HMPTEMP",$J)),"RESULT","ERROR")
 ;I SERVER'="" D CHKPAT(.PATIENTS,SERVER)    ;    *S68-JCH*
 Q
SRTSRC(SORT,SRCTYPE,SRCNAME) ; Set sort type, source type, source name
 S ^TMP("HMPTEMP",$J,"data","defaultPatientListSourceType")=SRCTYPE
 S ^TMP("HMPTEMP",$J,"data","defaultPatientListSourceName")=SRCNAME
 S ^TMP("HMPTEMP",$J,"data","defaultPatientListSourceSort")=SORT
 Q
