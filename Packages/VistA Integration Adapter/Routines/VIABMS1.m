VIABMS1 ;AAC/JMC - VIA BMS RPCs ;04/15/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**8**;06-FEB-2014;Build 8
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
 N VIAFILE,VIAFIELDS,VIAFLAGS,VIASCRN
 S VIAFILE=405,VIAFIELDS=".01;101;100;.02;.03;.04;.06;.07;.14"
 I VIAIENS="",VIAMDT="",VIAMTYP="",VIAPIEN="" S VIAER="Missing Input parameters" D ERR^VIABMS(VIAER) Q
 I VIAPIEN'="" D PATCHK^VIABMS(VIAPIEN) I $D(RESULT) Q
 I VIAIENS'="" S VIAFLAGS="IE" D GDIQ^VIABMS Q
 S VIAFIELDS="@;"_VIAFIELDS,VIAFLAGS="IP",VIASCRN="S X=$G(^(0)) I $P(X,U)=VIAMDT,$P(X,U,2)=VIAMTYP,$P(X,U,3)=VIAPIEN"
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
 N VIAFILE,VIAFIELDS,VIAFLAGS,VIASCRN
 S VIAFILE=405,VIAFIELDS="@;.01;101;100;.02;.03;.04;.06;.07;.14",VIAFLAGS="IP"
 I VIAPIEN="",VIASDT="",VIAEDT="" S VIAER="Missing Input Parameters" D ERR^VIABMS(VIAER) Q
 I VIAPIEN'="" D PATCHK^VIABMS(VIAPIEN) I $D(RESULT) Q
 I (VIASDT'="")!(VIAEDT'="") D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q 
 S VIASCRN=$S((VIAPIEN'="")&(VIASDT'=""):"I $P($G(^DGPM(Y,0)),U,3)=VIAPIEN S X=$P($G(^DGPM(Y,""USR"")),U,2) I X>VIASDT,X<VIAEDT",VIASDT'="":"S X=$P($G(^(""USR"")),U,2) I X>VIASDT,X<VIAEDT",1:"I $P($G(^DGPM(Y,0)),U,3)=VIAPIEN")
 D LDIC^VIABMS
 Q
 ;
APATMVT ; Returns patient movement record by admission IEN from the PATIENT MOVEMENT file #405;ICR-1865
 ;Input - VIA("PATH")="LISTPATIENTMOVEMENTSBYADMISSION" [required]
 ;        VIA("PATIEN")=Patient IEN [required]
 ;Data returned
 ;    .01 MovementDate,101 EnteredDate,100 Entered By,.02 TransactionTypeId,.03 PatientIen,
 ;    .04 TypeOfMovementIen,.06 WardLocationId,.07 RoomBedId,.14 CurrentAdmissionIen
 N VIAFILE,VIAFIELDS,VIAFLAGS,VIASCRN
 S VIAFILE=405,VIAFIELDS="@;.01;101;100;.02;.03;.04;.06;.07;.14",VIAFLAGS="IP"
 I VIAPIEN="" S VIAER="Missing ADMISSION IEN" D ERR^VIABMS(VIAER) Q
 S VIASCRN="I $P($G(^(0)),U,14)=VIAPIEN",VIAXREF="CA"
 D LDIC^VIABMS
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
 ;        VIA("IENS")=Client IEN [required]
 ;        VIA("SDATE")=Start Date for search [optional]
 ;        VIA("EDATE")=End Date for search [optional]
 ;        VIA("MAX")=n [optional]
 ;Data returned
 ;    .01 Appointment Date/Time, 2 Patients
 N VIARRAY,VIARY,CNT,VIARRY,VIACNT,VIADT,VIADFN,VIAPPT,I,Y,J,FL,CLNIEN,MORE,TARRAY
 I VIAIENS="" S VIAER="Missing CLINIC IEN" D ERR^VIABMS(VIAER) Q
 I (VIASDT'="")!(VIAEDT'="") D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 S CLNIEN=$TR(VIAIENS,","),VIAEDT=$S(VIAEDT="":DT,1:VIAEDT)
 S RESULT(1)="[Data]",CNT=1,FL=0,MORE=""
 S VIARRAY(1)=$P(VIASDT,".")_";"_$P(VIAEDT,".")
 S VIARRAY(2)=CLNIEN
 S VIARRAY("FLDS")="1;4"
 S VIACNT=$$SDAPI^SDAMA301(.VIARRAY)
 I VIACNT<1 G CLAPX Q
 S VIADFN=0 F  S VIADFN=$O(^TMP($J,"SDAMA301",CLNIEN,VIADFN)) Q:'VIADFN  D
 . S VIADT=0
 . F  S VIADT=$O(^TMP($J,"SDAMA301",CLNIEN,VIADFN,VIADT)) Q:'VIADT  D
 . . S VIAPPT=$G(^TMP($J,"SDAMA301",CLNIEN,VIADFN,VIADT)) ;appointment data
 . . I (VIADT<VIASDT)!(VIADT>VIAEDT) Q
 . . S VIARY(VIADT,VIADFN)=VIAPPT
 S VIADT=$S(VIAFROM'="":VIAFROM,1:0)
 F  S VIADT=$O(VIARY(VIADT)) Q:'VIADT  S CNT=CNT+1,RESULT(CNT)=VIADT D  I CNT>VIAMAX S MORE="MORE^"_VIADT,FL=1 Q
 . S (VIADFN,I)=0 F  S VIADFN=$O(VIARY(VIADT,VIADFN)) Q:'VIADFN  D
 . . S RESULT(CNT)=RESULT(CNT)_$S('I:"^"_$P(VIARY(VIADT,VIADFN),"^")_"^",1:"")_$S('I:"",1:"~")_VIADFN,I=1
 I FL D  ; re-structure results array
 . M TARRAY=RESULT
 . K RESULT
 . S CNT=4,I=0,RESULT(1)="[Misc]",RESULT(2)=MORE,RESULT(3)="[Data]"
 . F  S I=$O(TARRAY(I)) Q:'I  D
 . . I TARRAY(I)["Data" Q
 . . S CNT=CNT+1,RESULT(CNT)=TARRAY(I)
CLAPX K ^TMP($J,"SDAMA301")
 Q
 ;
LSTORD ; Returns a list of orders from the ORDER file #100;ICR-6475
 ;Input - VIA("PATH")="LISTORDERS" [required]
 ;        VIA("ORDIEN")=list of orderable IEN separated by a comma (,") [required]. For example, VIA("ORDIEN")="73,75,76,360,740"
 ;        VIA("SDATE")=Start Date for search [optional]. Defaults to today's date, if no date is passed in
 ;        VIA("EDATE")=End Date for search [optional]. Defaults to today's date, if no date is passed in
 ;        VIA("PATIEN")=Patient IEN; multiple IENS separated by a comma [optional]
 ;        VIA("VALUE")=1 or 2 required]. 1 to filter by orderable item(s), 2 to filter by orderable action 
 ;        VIA("FROM")=string/value to start list [optional]
 ;        VIA("MAX")=n [optional]
 ;Data returned
 ;    .01 Order #, 5 Status, .02  Object of Order, 6 Patient Location
 N VIAOI,VIACNT,OITM,I,X,Y,Z
 S:VIASDT="" VIASDT=DT S:VIAEDT="" VIAEDT=DT
 D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 I $G(VIAOIEN)'="" F I=1:1:$L(VIAOIEN,",") S OITM=$P(VIAOIEN,",",I) I OITM'="" S VIAOI(OITM)=""
 I $G(VIAPIEN)'="" F I=1:1:$L(VIAPIEN,",") S OITM=$P(VIAPIEN,",",I) I OITM'="" S VIAPIEN(OITM)=""
 I VIAVAL=1,$O(VIAOI(""))="" S VIAER="Missing Orderable Items IEN" D ERR^VIABMS(VIAER) Q 
 S RESULT(1)="[Data]",VIACNT=2,X=$S($P(VIAFROM,",")'="":$P(VIAFROM,","),1:VIASDT)
 F  S X=$O(^OR(100,"AF",X)) Q:'X  Q:X>VIAEDT  I X>=VIASDT,X<VIAEDT D  I VIACNT>VIAMAX Q
 . S Y=$S($P(VIAFROM,",",2)'="":$P(VIAFROM,",",2),1:0),$P(VIAFROM,",",2)=""
 . F  S Y=$O(^OR(100,"AF",X,Y)) Q:'Y  D  I VIACNT>VIAMAX  S RESULT(VIACNT)="[Misc]",VIACNT=VIACNT+1,RESULT(VIACNT)="MORE"_U_X_","_Y Q
 . . I VIAVAL=1 S Z=$$ORDACT1^VIABMS1()
 . . I VIAVAL=2 S Z=$$ORDACT2^VIABMS1()
 Q
 ;
ORDACT ; Returns a list of order actions from the ORDER file #100.008
 ;Input - VIA("PATH")="LISTORDERACTIONS" [required]
 ;        VIA("ORDIEN")=list of orderable IEN separated by a comma (,") [required],if VIA("VALUE")=1
 ;        VIA("SDATE")=Start Date for search [optional]. Defaults to today's date, if no date is passed in
 ;        VIA("EDATE")=End Date for search [optional]. Defaults to today's date, if no date is passed in
 ;        VIA("IENS")=Order IEN [required]
 ;        VIA("VALUE")=1 or 2 required]. 1 to filter by orderable item(s), 2 to filter by orderable action 
 ;Data returned
 ;    .01 Date/Time Ordered,6 Date/Time Signed,16 Release Date/Time,5 Signed By,3 Provider,.1 Order Text
 N VIAFILE,VIAFIELDS,VIAFLAGS,OITM,I,TRESULT,I,X,N,IEN,VIATIEN
 S VIAFILE=100.008,VIAFIELDS="@;.01;6;16;5;3",VIAFLAGS="IP"
 S:VIASDT="" VIASDT=DT S:VIAEDT="" VIAEDT=DT
 D DTCHK^VIABMS(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 I $G(VIAOIEN)'="" F I=1:1:$L(VIAOIEN,",") S OITM=$P(VIAOIEN,",",I) I OITM'="" S VIAOI(OITM)=""
 I VIAVAL=1,$O(VIAOI(""))="" S VIAER="Missing Orderable Items IEN" D ERR^VIABMS(VIAER) Q
 S VIAID="I $D(^OR(100,DA(1),8,Y,.1)) S I=0 F  S I=$O(^OR(100,DA(1),8,Y,.1,I)) Q:'I  S J=$P(^(I,0),U) D EN^DDIOL(J)"
 I VIAVAL=1 D
 . S VIASCRN="S VIAX=0 F  S VIAX=$O(^OR(100,Y(1),.1,VIAX)) Q:'VIAX  I VIAX>0 S VIAV=$P(^OR(100,Y(1),.1,VIAX,0),U,1) I $D(VIAOI(VIAV)) Q"
 I VIAVAL=2 D
 . S VIASCRN="S VIAA=Y(1),(VIAB,VIAC,VIAD,VIAX)=0 F  S VIAX=$O(^OR(100,VIAA,8,Y,.1,VIAX)) Q:'VIAX  I VIAX>0 S VIAR=$$UP^XLFSTR(^OR(100,VIAA,8,Y,.1,VIAX,0)) "
 . S VIASCRN=VIASCRN_"S VIAB=VIAB!(VIAR[""ANTICIPATE""),VIAC=VIAC!(VIAR[""PLANNED""),VIAD=VIAD!(VIAR[""DISCHARGE"") I VIAB!VIAC&VIAD Q"
 ; multiple IENs
 S VIATIEN=VIAIENS,N=0
 F I=1:1:$L(VIATIEN,",") S IEN=$P(VIATIEN,",",I) I IEN'="" D
 . S VIAIENS=","_IEN_","
 . K RESULT
 . D LDIC^VIABMS
 . S X=0 F  S X=$O(RESULT(X)) Q:'X   S:RESULT(X)["[Data]" RESULT(X)=RESULT(X)_" - "_IEN S N=N+1,TRESULT(N)=RESULT(X)
 . K RESULT
 M RESULT=TRESULT
 Q
ORDACT1() ; filters by status, date and orderable items
 N FND,VIA3,VIAV,VIAA,VIA8,VIA0,VIAPT
 S FND=0
 I '$D(^OR(100,Y,.1,0)) Q FND
 S VIA0=$G(^OR(100,Y,0)),VIA3=$G(^OR(100,Y,3)),VIAPT=$P(VIA0,U,2)
 I $P(VIA3,U,3)'=6 Q FND
 I VIAPIEN'="",(VIAPT'["DPT")!('$D(VIAPIEN(+VIAPT))) Q FND
 S VIAA=$P(VIA3,U,7),VIAV=$P(VIA3,U)
 I VIAA>0,VIAV>=VIASDT,VIAV<VIAEDT S VIA8=$P(^OR(100,Y,8,VIAA,0),U) I VIA8>=VIASDT,VIA8<VIAEDT S VIAX=0 D  Q FND
 . F  S VIAX=$O(^OR(100,Y,.1,VIAX)) Q:'VIAX  I VIAX>0 S VIAV=$P(^OR(100,Y,.1,VIAX,0),U,1) I $D(VIAOI(VIAV)) D  Q
 . . S FND=1,RESULT(VIACNT)=Y_U_VIA8_U_$P(VIA3,U,3)_U_$P(VIA0,U,2)_U_$P(VIA0,U,10),VIACNT=VIACNT+1
 Q FND
 ;
ORDACT2() ; filters by status, date and orderable actions
 N FND,VIA0,VIAA,VIAB,VIAC,VIAD,VIA3,VIAV,VIA8
 S FND=0
 S VIA0=$G(^OR(100,Y,0))
 I $P(^OR(100,Y,3),U,3)'=6 Q FND
 S (VIAA,VIAB,VIAC,VIAD)=0
 S VIA0=$G(^OR(100,Y,0)),VIA3=$G(^OR(100,Y,3))
 I $D(^OR(100,Y,8)) F  S VIAA=$O(^OR(100,Y,8,VIAA)) Q:'VIAA  S VIA8=$P(^OR(100,Y,8,VIAA,0),U,1) I VIA8>=VIASDT,VIA8<VIAEDT,$D(^OR(100,Y,8,VIAA,.1)) S VIAX=0 D  I FND Q
 . F  S VIAX=$O(^OR(100,Y,8,VIAA,.1,VIAX)) Q:'VIAX  S VIAR=$G(^OR(100,Y,8,VIAA,.1,VIAX,0)),VIAR=$$UP^XLFSTR(VIAR) S VIAB=VIAB!(VIAR["ANTICIPATE"),VIAC=VIAC!(VIAR["PLANNED"),VIAD=VIAD!(VIAR["DISCHARGE") I VIAB!VIAC&VIAD D  Q
 . . S FND=1,RESULT(VIACNT)=Y_U_VIA8_U_$P(VIA3,U,3)_U_$P(VIA0,U,2)_U_$P(VIA0,U,10),VIACNT=VIACNT+1
 Q FND
 ;
