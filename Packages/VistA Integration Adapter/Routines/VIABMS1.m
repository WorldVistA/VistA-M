VIABMS1 ;AAC/JMC - VIA BMS RPCs ;04/15/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**8,11,13**;06-FEB-2014;Build 7
 ;
 ;The following RPC is in support of the Bed Management System (BMS). This RPC reads the parameter "Path"
 ;and determine from that parameter which data to return.  All BMS requests are handled by this one RPC.
 ;Continuation of VIABMS
 ; RPC VIAB BMS
 ; ICR 1254    DIC(45.7,   [field #1]
 ; ICR 2638    ORDER STATUS file direct access [Filed 100.01, field #.01]
 ; ICR 1359    DBIA1359 [File #45.7;field .01]
 ; ICR 433     DBIA433 [File #405.1;field .01]
 ; ICR 2438    DBIA2438 [File #40.8;field .01]
 ; ICR 2843    DBIA2843 [File #101.43;field .01] (controlled)
 ; ICR 2638    ORDER STATUS file direct access [File #100.01;field .01]
 ; ICR 6611    SCHEDULED ADMISSION [File 41.1;fields fields .01;2;3;4;5;6;8;9;11;12;13;14](private)
 ; ICR 1380    ROOM-BED [File #405.4;fields .01;.2;100](controlled)
 ; ICR 4433    NAME: DBIA4433 (API SDAPI^SDAMA301) [supported] 
 ; ICR 1865    DBIA1865 [File #405;fields .01;.02;.03;.04;.06;.07;.14;100;101]
 ; ICR 6475    LIST ORDERS [File #100; fields .02;6;5;30;31;etc]
 Q
 ;
TRTSPTY ; Returns a list of facility treating specialty from the FACILITY TREATING SPECIALTY file #45.7;ICR-1359
 ;Input - VIA("PATH")="LISTFACILITYTREATINGSPECIALTY" [required]
 ;        VIA("IENS")= Facility Treating Specialty IEN, (multiple IENs separated by comma) [optional] 
 ;Data returned
 ;    .01 Name,1 Specialty ID
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS
 S VIAFILE=45.7,VIAFIELDS="@;.01;1",VIAFLAGS="IP"
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS="",VIAMAX=""
 D LDIC^VIABMS
 I $G(TVIAIENS)'="" S VIAIENS=TVIAIENS D PIENS
 Q
 ;
PIENS ; multiple IENs; parse IENS
 N TRESULT,IEN,I,CNT,X
 I '$D(RESULT) Q
 M TRESULT=RESULT
 K RESULT
 S RESULT(1)="[Data]",CNT=1
 F I=1:1:$L(VIAIENS,",") S IEN=$P(VIAIENS,",",I) I IEN'="" S IEN(IEN)=""
 S X=0 F  S X=$O(TRESULT(X)) Q:'X  S IEN=$P(TRESULT(X),U) I IEN'="",$D(IEN(IEN)) D
 . S CNT=CNT+1,RESULT(CNT)=TRESULT(X)
 Q
 ;
MASTYP ; Returns a list of MAS movement transaction type from the MAS MOVEMENT TRANSACTION TYPE file #405.3;ICR-433
 ;Input - VIA("PATH")="LISTMASMOVEMENTTRANSACTIONTYPE" [required] 
 ;Data returned
 ;    .01 Name
 N VIAFILE,VIAFIELDS,VIAFLAGS
 S VIAFILE=405.3,VIAFIELDS="@;.01",VIAFLAGS="IP"
 D LDIC^VIABMS
 Q
 ;
MEDCTR ; Returns a list of Medical Center division from the MEDICAL CENTER DIVISION file #40.8;ICR-2438
 ;Input - VIA("PATH")="LISTMEDICALCENTERDIVISION" [required]
 ;        VIA("IENS")= Medical Center Division IEN, (multiple IENs separated by comma) [optional] 
 ;Data returned
 ;    .01 Name
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS
 S VIAFILE=40.8,VIAFIELDS="@;.01",VIAFLAGS="IP"
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS="",VIAMAX=""
 D LDIC^VIABMS
 I $G(TVIAIENS)'="" S VIAIENS=TVIAIENS D PIENS
 Q
 ;
ORDITM ; Returns a list of orderable items from the ORDERABLE ITEMS file #101.43;ICR-2843
 ;Input - VIA("PATH")="LISTORDERABLEITEM" [required]
 ;Data returned
 ;    .01 Name
 N VIAFILE,VIAFIELDS,VIAFLAGS,VIAXREF
 S VIAFILE=101.43,VIAFIELDS="@;.01",VIAFLAGS="IPQ",VIAXREF="#"
 D LDIC^VIABMS
 Q
 ;
ORDSTA ; Returns a list of Medical Center division from the ORDER STATUS file #100.01;ICR-2638
 ;Input - VIA("PATH")="LISTORDERSTATUS" [required]
 ;        VIA("IENS")= Order Status IEN, (multiple IENs separated by comma) [optional] 
 ;Data returned
 ;    .01 Name
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS
 S VIAFILE=100.01,VIAFIELDS="@;.01",VIAFLAGS="IP"
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS="",VIAMAX=""
 D LDIC^VIABMS
 I $G(TVIAIENS)'="" S VIAIENS=TVIAIENS D PIENS
 Q
 ;
BEDSWCH ; Returns a list of bed switch from the PATIENT MOVEMENT file #405;ICR-1865
 ;Input - VIA("PATH")="LISTBEDSWITCH" [required]
 ;        VIA("IENS")="Patient Movement IEN" (multiple IENs separated by a comma) [required]
 ;Data returned
 ;    .06 WardLocationId,.07 RoomBedId
 N VIAFILE,VIAFIELDS,VIAFLAGS,I,VIATIEN,VIAIEN,TRESULT,X,N,I,VAL
 I VIAIENS="" S VIAER="Missing MOVEMENT IEN" D ERR^VIABMS(VIAER) Q 
 S VIAFILE=405,VIAFIELDS=".06;.07",VIAFLAGS="IE"
 S TRESULT(1)="[Data]",CNT=1
 ; multiple IENs
 S VIATIEN=VIAIENS
 F I=1:1:$L(VIATIEN,",") S VIAIEN=$P(VIATIEN,",",I) I VIAIEN'="" D
 . S VIAIENS=VIAIEN_","
 . K RESULT
 . D GDIQ^VIABMS
 . I $G(RESULT(1))'["Data" Q
 . S VAL=$P($G(RESULT(2)),U,1,2)_U_$TR($P($G(RESULT(2)),U,4,5),"^",";")_U_$TR($P($G(RESULT(3)),U,4,5),"^",";")
 . S CNT=CNT+1,TRESULT(CNT)=VAL
 . K RESULT
 M RESULT=TRESULT
 ;
 Q
 N VIAFILE,VIAFIELDS,VIAFLAGS,I,VIATIEN,VIAIEN,TRESULT,X,N,I
 I VIAIENS="" S VIAER="Missing MOVEMENT IEN" D ERR^VIABMS(VIAER) Q 
 S VIAFILE=405,VIAFIELDS=".06;.07",VIAFLAGS="IE"
 ; multiple IENs
 S VIATIEN=VIAIENS
 F I=1:1:$L(VIATIEN,",") S VIAIEN=$P(VIATIEN,",",I) I VIAIEN'="" D
 . S VIAIENS=VIAIEN_"," D GDIQ^VIABMS
 . I '$D(TRESULT) M TRESULT=RESULT K RESULT Q
 . S X=0,N=$O(TRESULT(""),-1) F  S X=$O(RESULT(X)) Q:'X  S N=N+1 S TRESULT(N)=RESULT(X)
 . K RESULT
 M RESULT=TRESULT
 Q 
 ;
GPATMVT ; Returns a patient movement records from the PATIENT MOVEMENT file #405;ICR-1865
 ;Input - VIA("PATH")="GETPATIENTMOVEMENT" [required]
 ;        VIA("IENS")="Patient Movement IEN" [required, optional if no other parameter]
 ;        VIA("MOVDATE")=Movement Date [optional, required if no Patient Movement IEN]
 ;        VIA("MOVTYPE")=Movement Type [optional, required if no Patient Movement IEN]
 ;        VIA("PATIEN")=Patient IEN [optional, required if no Patient Movement IEN]
 ;Data returned
 ;    .01 MovementDate,101 EnteredDate,100 Entered By,.02 TransactionTypeId,.03 PatientIen,
 ;    .04 TypeOfMovementIen,.06 WardLocationId,.07 RoomBedId,.14 CurrentAdmissionIen
 N VIAFILE,VIAFIELDS,VIAFLAGS,VIASCRN,I,VIACNT
 S VIAIENS=$P(VIAIENS,",")
 S VIAFILE=405,VIAFIELDS=".01;101;100;.02;.03;.04;.06;.07;.14"
 I VIAIENS="",VIAMDT="",VIAMTYP="",VIAPIEN="" S VIAER="Missing Input parameters" D ERR^VIABMS(VIAER) Q
 I VIAPIEN'="" D PATCHK^VIABMS(VIAPIEN) I $D(RESULT) Q
 I VIAPIEN'=""&(VIAMDT'="")&(VIAIENS="") D  G GPATMVT2
 .F  S VIAIENS=$O(^DGPM("ADFN"_VIAPIEN,VIAMDT,VIAIENS)) Q:VIAIENS=""  D
 ..I '$G(VIACNT) S RESULT(1)="[Data]" S VIACNT=2
 ..S RESULT(VIACNT)=$$GMVTR^VIABMS(VIAIENS),VIACNT=VIACNT+1
 I VIAIENS'="" D  Q
 .S RESULT(1)="[Data]"
 .S RESULT(2)=$$GMVTR^VIABMS(VIAIENS)
GPATMVT2 ;
 S VIAFIELDS="@;"_VIAFIELDS,VIAFLAGS="IP"
 ;VIAMTYPE is actually TRANSACTION, not MOVEMENT TYPE.
 S VIASCRN="S X=$G(^(0)) I $P(X,U)=VIAMDT,$P(X,U,2)=VIAMTYP,$P(X,U,3)=VIAPIEN"
 D LDIC^VIABMS
 Q
 ;
LPATMVT ; Returns a list of patient movement records from the PATIENT MOVEMENT file #405;ICR-1865
 ;Input - VIA("PATH")="LISTPATIENTMOVEMENT" [required]
 ;        VIA("PATIEN")=Patient IEN [required, if no date range]
 ;        VIA("SDATE")=Start Date for search [optional]
 ;        VIA("EDATE")=End Date for search [optional]
 ;        VIA("MAX")=n [optional]
 ;Data returned
 ;    .01 MovementDate,101 EnteredDate,100 Entered By,.02 TransactionTypeId,.03 PatientIen,
 ;    .04 TypeOfMovementIen,.06 WardLocationId,.07 RoomBedId,.14 CurrentAdmissionIen
 S VIAPIEN=$TR(VIAPIEN,",")
 I VIAPIEN="",VIASDT="",VIAEDT="" S VIAER="Missing Input Parameters" D ERR^VIABMS(VIAER) Q
 N VIADATA,START,END,STARTI,STARTJ,RES,MORED,OFFSET,I
 I VIAPIEN'="" D PATCHK^VIABMS(VIAPIEN) I $D(RESULT) Q
 S VIADATA=$NA(^TMP($J,"VIADATA"))
 K @VIADATA
 ;Parse VIAFROM to get STARTI and STARTJ
 S (STARTI,STARTJ)=0
 I VIAFROM'="" D
 .S STARTI=$P(VIAFROM,"~"),STARTJ=$P(VIAFROM,"~",2)
 S START=$S(VIASDT'="":VIASDT-.000001,1:0)
 S END=$S(VIAEDT="":9999999,VIAEDT[".":VIAEDT+.000001,1:VIAEDT+.99999999)
 S RES=$$WALK^VIABMS2(STARTI,STARTJ,VIAMAX,START,END)
 S MORED=$P(RES,U,3)
 I MORED D
 .S:$G(MORED) RESULT(1)="[Misc]"
 .S:$G(MORED) RESULT(2)="MORE^"_$P(RES,U)_"~"_$P(RES,U,2)
 .S RESULT($S($G(MORED):3,1:1))="[Data]"
 .S OFFSET=$S($G(MORED):4,1:2)
 E  D
 .S RESULT(1)="[Data]"
 .S OFFSET=2
 S I=""
 F  S I=$O(@VIADATA@(I)) Q:I=""  S RESULT(I+OFFSET)=@VIADATA@(I)
 K @VIADATA
 Q
 ;
MVTR(VIAIEN) ;
 N IENS,FLDS,OUT,MOUT,VAL,I,FLD
 S IENS=VIAIEN_","
 S FLDS=".01;101;100;.02;.03;.04;.06;.07;.14"
 D GETS^DIQ(405,IENS,FLDS,"I","OUT","MOUT")
 S VAL=VIAIEN
 F I=1:1:$L(FLDS,";") S $P(VAL,U,I+1)=$G(OUT(405,IENS,$P(FLDS,";",I),"I"))
 Q VAL
 ;
 ;
APATMVT ; Returns patient movement record by admission IEN from the PATIENT MOVEMENT file #405;ICR-1865
 ;Input - VIA("PATH")="LISTPATIENTMOVEMENTSBYADMISSION" [required]
 ;        VIA("PATIEN")=Movement IEN [required]  Note:  gets parsed as variable VIAPIEN
 ;Data returned
 ;    IEN,.01 MovementDate,101 EnteredDate,100 Entered By,.02 TransactionTypeId,.03 PatientIen,
 ;    .04 TypeOfMovementIen,.06 WardLocationId,.07 RoomBedId,.14 CurrentAdmissionIen 
 N Y,N
 S N=0
 N I,J,CNT,END,FIRST,STARTI,STARTJ,VIADATA
 I VIAPIEN="" S VIAER="Missing Input Parameters" D ERR^VIABMS(VIAER) Q
 S VIADATA=$NA(^TMP($J,"VIADATA"))
 K @VIADATA
 N I,J,K,CNT,END,FIRST,STARTI,STARTJ,DONE,LASTJ
 S FIRST=1,DONE=0,LASTJ=""
 ;Parse VIAFROM to get STARTI and STARTJ
 S STARTI=$P(VIAFROM,"~"),STARTJ=$P(VIAFROM,"~",2)
 ;Traverse "CA" index, be sure to save last J
 S CNT=0
 S LASTJ=$G(J)
 S J=$S(FIRST:STARTJ,1:"")
 F  S J=$O(^DGPM("CA",VIAPIEN,J)) Q:+J'>0!(CNT'<VIAMAX)  D
 .S:J'="" LASTJ=J
 .I VIAPIEN=$P($G(^DGPM(J,0)),U,14) D
 ..S CNT=CNT+1
 ..;Store records temporarily in @VIADATA
 ..S @VIADATA@(CNT)=$$MVTR(J)
 ;[Misc] section comes first
 I CNT'<VIAMAX D
 .D SET^VIABMS("[Misc]")
 .D SET^VIABMS("MORE^"_VIAPIEN_"~"_LASTJ)
 ;Now, save [Data] section and kill temp. global
 D SET^VIABMS("[Data]")
 S K=0
 F  S K=$O(@VIADATA@(K)) Q:K=""  D SET^VIABMS(@VIADATA@(K))
 K @VIADATA
 M RESULT=Y
 Q
 ;
SCHADM ; Returns a list of scheduled admissions from the SCHEDULED ADMISSION file #41.1;ICR-6611
 ;Input - VIA("PATH")="LISTSCHEDULEDADMISSION" [required]
 ;        VIA("PATIEN")=Patient IEN [required, optional if no date parameter]
 ;        VIA("SDATE")=Start Date for search [optional]
 ;        VIA("EDATE")=End Date for search [optional]
 ;        VIA("MAX")=n [optional]
 ;Data returned
 ;    .01 PatientId,2 ReservationDateTime,3 LengthOfStayExpected,4 AdmittingDiagnosis,6 Surgery,8 WardLocation,
 ;    9 TreatingSpecialty,12 MedicalCenterDivision,13 DateTimeCancelled,14 CancelledBy,5 Provider,11 Scheduler
 N VIAFILE,VIAFIELDS,VIAFLAGS,VIASCRN
 S VIAFILE=41.1,VIAFIELDS="@;.01;2;3;4;6;8;9;12;13;14;5;11",VIAFLAGS="IP"
 I VIAPIEN'="" D PATCHK^VIABMS(VIAPIEN) I $D(RESULT) Q
 I VIAPIEN'="" S VIASCRN="S X=$G(^DGS(41.1,Y,0)) I $P(X,U)=VIAPIEN"
 I (VIASDT'="")!(VIAEDT'="") D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q 
 S VIASCRN=$S(($G(VIASCRN)'="")&(VIASDT'=""):VIASCRN_",$P(X,U,2)>VIASDT,$P(X,U,2)<VIAEDT",VIASDT'="":"S X=$P($G(^DGS(41.1,Y,0)),U,2) I X>VIASDT,X<VIAEDT",1:$G(VIASCRN))
 D LDIC^VIABMS
 Q
 ;
RMBED ; Returns a list of room/beds from the ROOM-BED file #405.4;ICR-1380
 ;Input - VIA("PATH")="LISTROOMBED" [required]
 ;        VIA("IENS")="Room Bed IEN" [required, optional if no other parameter] 
 ;        VIA("MAX")=n [optional]
 ;        VIA("FROM")=string/value to start list [optional]
 ;Data returned
 ;    .01  Name,.2 CurrentlyOutOfService,100 WardsWhichCanAssign
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS
 S VIAFILE=405.4,VIAFIELDS="@;.01;.2",VIAFLAGS="IP"
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS="",VIAMAX=""
 S VIAID="S X="""" I $D(^DG(405.4,Y,""W"",0)) S VIAA="""" F  S VIAA=$O(^DG(405.4,Y,""W"",VIAA)) S:VIAA>0 X=X_$S(X="""":"""",1:"","")_VIAA I VIAA="""" D EN^DDIOL(X) Q"
 D LDIC^VIABMS
 I $G(TVIAIENS)'="" S VIAIENS=TVIAIENS D PIENS
 Q
 ;
CLNAPPT ; Returns a list of clinic appointments from the HOSPITAL LOCATION sub-file #44.001;ICR-#4433
 ;Input - VIA("PATH")="LISTCLINICAPPOINTMENTS" [required]
 ; VIA("IENS")=Clinic IEN [required]
 ; VIA("SDATE")=Start Date for search [optional]
 ; VIA("EDATE")=End Date for search [optional]
 ; VIA("MAX")=n [optional]
 ;Data returned
 ; .01 Appointment Date/Time, 2 Patients, Clinic
 N VIARRAY,VIARY,CNT,VIARRY,VIACNT,VIADT,VIADFN,VIAPPT,I,Y,J,FL,CLNIEN,MORE,TARRAY
 I VIAIENS="" S VIAER="Missing CLINIC IEN" D ERR^VIABMS(VIAER) Q
 ;I (VIASDT'="")!(VIAEDT'="") D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 S VIAEDT=$S(VIAEDT="":DT,1:VIAEDT)
 S CLNIEN=$TR(VIAIENS,",",";")
 S RESULT(1)="[Data]",CNT=1,FL=0,MORE=""
 S VIARRAY(1)=VIASDT_";"_VIAEDT
 S VIARRAY(2)=CLNIEN
 S VIARRAY("FLDS")="1;2;4"
 S VIACNT=$$SDAPI^SDAMA301(.VIARRAY)
 I VIACNT<1 D  G CLAPX Q
 . N VIAERN
 . S VIAERN=$O(^TMP($J,"SDAMA301",0))
 . I VIAERN>0 S VIAER="("_VIAERN_") "_^TMP($J,"SDAMA301",VIAERN)_" - SDAPI call" D ERR^VIABMS(VIAER)
 S CLNIEN=0 F  S CLNIEN=$O(^TMP($J,"SDAMA301",CLNIEN)) Q:'CLNIEN  D
 . S VIADFN=0 F  S VIADFN=$O(^TMP($J,"SDAMA301",CLNIEN,VIADFN)) Q:'VIADFN  D
 . . S VIADT=0
 . . F  S VIADT=$O(^TMP($J,"SDAMA301",CLNIEN,VIADFN,VIADT)) Q:'VIADT  D
 . . . S VIAPPT=$G(^TMP($J,"SDAMA301",CLNIEN,VIADFN,VIADT)) ;appointment data
 . . . ;I (VIADT<VIASDT)!(VIADT>VIAEDT) Q
 . . . S VIARY($P($P(VIAPPT,"^",2),";"),$P(VIAPPT,"^"),$P($P(VIAPPT,"^",4),";"))=VIAPPT
 S CLNIEN=$S(VIAFROM'="":$P(VIAFROM,"~")-1,1:0)
 F  S CLNIEN=$O(VIARY(CLNIEN)) Q:'CLNIEN  D  I CNT>VIAMAX Q
 . I ($P(VIAFROM,"~")>0),($P(VIAFROM,"~")'=CLNIEN) S VIAFROM=""
 . S VIADT=$S(VIAFROM'="":$P(VIAFROM,"~",2),1:0) ;S VIAFROM=""
 . F  S VIADT=$O(VIARY(CLNIEN,VIADT)) Q:'VIADT  S CNT=CNT+1,RESULT(CNT)=VIADT D  S RESULT(CNT)=RESULT(CNT)_"^"_CLNIEN I CNT>VIAMAX S MORE="MORE^"_CLNIEN_"~"_VIADT,FL=1 Q
 . . S (VIADFN,I)=0 F  S VIADFN=$O(VIARY(CLNIEN,VIADT,VIADFN)) Q:'VIADFN  D
 . . . S RESULT(CNT)=RESULT(CNT)_$S('I:"^"_$P(VIARY(CLNIEN,VIADT,VIADFN),"^")_"^",1:"")_$S('I:"",1:"~")_VIADFN,I=1
 I FL D  ; re-structure results array
 . M TARRAY=RESULT
 . K RESULT
 . S CNT=4,I=0,RESULT(1)="[Misc]",RESULT(2)=MORE,RESULT(3)="[Data]"
 . F  S I=$O(TARRAY(I)) Q:'I  D
 . . I TARRAY(I)["Data" Q
 . . S CNT=CNT+1,RESULT(CNT)=TARRAY(I)
CLAPX K ^TMP($J,"SDAMA301")
 Q
