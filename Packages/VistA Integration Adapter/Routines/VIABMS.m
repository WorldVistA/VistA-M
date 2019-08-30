VIABMS ;AAC/JMC,AFS/PB - VIA BMS RPCs ;10/31/17  14:34
 ;;1.0;VISTA INTEGRATION ADAPTER;**8,10,11,15**;06-FEB-2014;Build 5
 ;
 ;The routine is in support of the Bed Management System (BMS) and is linked to VIAB BMS RPC. The RPC 
 ;determines what data is returned from what is passed in the input parameter VIA("PATH"). All BMS requests
 ;are handled by this one RPC.
 ;
 ; RPC VIAB BMS
 ; ICR 10035 PATIENT FILE
 ; ICR 10040 HOSPITAL LOCATION FILE [File #44;fields .01,1,42]
 ; ICR 10060 NEW PERSON FILE [File 200;fields .01,30] (supported)
 ; ICR 6609 WARD [Access to File #42;fields .01,.017,.2] (private)
 ; ICR 4782 CLINIC PHONE [File #44;field 99]
 ; ICR 2652 DBIA2652 [File #42.4;field .01] (controlled)
 ; ICR 4433 NAME: DBIA4433 [API SDAPI^SDAMA301] (supported)
 ; ICR 5771 ORDERS FILE DATA [File #100;field #5] (controlled)
 ; ICR 6610 FACILITY MOVEMENT File #405.1;fields .01,.04] (private)
 ; ICR 6607 SC PERCENTAGE [File #2;field .302] (private)
 ; ICR 10090 INSTITUTION FILE (supported)
 Q
 ;
EN(RESULT,VIA) ; entry point for RPC
 N VIATAG,VIAER
 S VIATAG=""
 I $O(VIA(""))="" S VIAER="Missing Parameters" D ERR(VIAER) Q
 I $G(VIA("PATH"))="" S VIAER="Missing PATH Parameters" D ERR(VIAER) Q
 ; -- parse array to parameters
 D PARSE(.VIA)
 D PATH(.VIATAG)
 I VIATAG'="" D @VIATAG
 D KVAR
 Q
 ;
PARSE(VIA) ; -- array parsing to parameters
 S VIAIENS=$G(VIA("IENS"))
 S VIAFLAGS=$G(VIA("FLAGS"))
 S VIAMAX=$G(VIA("MAX")) I VIAMAX>5000 S VIAMAX=5000
 ;I $G(VIAMAX)="" S VIAMAX=1000
 I $G(VIAMAX)="" S VIAMAX=5000
 S VIAFROM=$G(VIA("FROM"))
 S VIATO=$G(VIA("TO")) ;search returns data up to a certain value for I.
 S VIAPART=$G(VIA("PART"))
 S VIAXREF=$G(VIA("XREF"))
 S VIASCRN=$G(VIA("SCREEN"))
 S VIAID=$G(VIA("ID"))
 S VIASDT=$G(VIA("SDATE"))
 S VIAEDT=$G(VIA("EDATE"))
 S VIALEDT=$G(VIA("LASTEDT"))
 S VIAMDT=$G(VIA("MOVDATE"))
 S VIAMTYP=$G(VIA("MOVTYPE"))
 S VIAPIEN=$G(VIA("PATIEN"))
 S VIACIEN=$G(VIA("CLNIEN"))
 S VIAOIEN=$G(VIA("ORDIEN"))
 S VIASSN=$G(VIA("SSN"))
 S VIAVAL=$G(VIA("VALUE"))
 Q 
 ;
PATH(VIATAG) ;The PATH parameter determines the line tag executed and data returned by the RPC.
 N X,I
 S X=""
 F I=1:1 S X=$P($T(HNDL+I),";;",2) Q:(X="END")!(X="")  I $$UP^XLFSTR(VIA("PATH"))=$P(X,";") S VIATAG=$P(X,";",2) Q
 Q
 ;
GETACT ;returns activity from the ED LOG (#230) file
 ;Input - VIA("PATH")="GETACTIVITY" [required]
 ;        VIA("FROM")=start date/time (exclusive) [required]
 ;        VIA("TO")=end date/time (inclusive) [required]
 ;Data returned
 ;
 ;DISPOSITION TIME (#1.3)
 ;PATIENT ID  (#.06)
 ;FACILITY ID  (#.02)
 ;COMPLAINT  (#1.1)
 ;DIAGNOSIS TIME (#1.4)
 ;
 ;N I,Y,NODE0,NODE1,NODE3,VAL,N,DFN,INST,DISP,LOC,ERDOC,IEN,CNT
 N I,Y,NODE0,NODE1,VAL,DISP,DFN,INST,IEN
 S:VIASDT="" VIASDT=VIAFROM ;alias
 S:VIAEDT="" VIAEDT=VIATO ;alias
 ;D DTCHK(.RESULT,VIASDT,VIAEDT) I $D(RESULT) Q
 S N=0
 D SET("[Data]")
 S I=VIASDT-.0000000001
 ;S I=VIASDT
 S CNT=0
 F  S I=$O(^EDP(230,"ADST",I)) Q:((I="")!('$$BETWEEN(I,VIASDT,VIAEDT)))  D
 .S CNT=CNT+1
 .S IEN=$O(^EDP(230,"ADST",I,""))
 .S DISP=$$GET1^DIQ(230,IEN_",",1.2,"E")
 .Q:DISP'["admitva"
 .S VAL=""
 .S NODE0=$G(^EDP(230,IEN,0))
 .S NODE1=$G(^EDP(230,IEN,1))
 .S VAL=VAL_$P(NODE1,U,3) ;DISPOSITION TIME (#1.3)
 .S DFN=$P(NODE0,U,6) ;PATIENT ID (#.06)
 .S VAL=VAL_U_DFN
 .S INST=$P(NODE0,U,2) ;INSTITUTION (#.02)
 .S VAL=VAL_U_$$GET1^DIQ(4,INST_",",99) ;station number
 .S VAL=VAL_U_$P(NODE1,U) ;COMPLAINT (#1.1)
 .S VAL=VAL_U_$P(NODE1,U,4) ;DIAGNOSIS TIME (#1.4)
 .D SET(VAL)
 M RESULT=Y
 Q
 ;
 ;If VIAA (resp. VIAB) is an exact date only match it against the date part of VIAX.
BETWEEN(VIAX,VIAA,VIAB) ;
 N LEX,REX,X1,X2
 S LEX=$S(VIAA[".":1,1:0)
 S REX=$S(VIAB[".":1,1:0)
 S X1=$S(LEX:VIAX,1:$P(VIAX,"."))
 S X2=$S(REX:VIAX,1:$P(VIAX,"."))
 Q ((X1'<VIAA)&(X2'>VIAB))
 ;
PRIMDX(VIADA) ;return primary diagnosis
 N I,PRIM,RES,IENS,DX
 S I=0,RES=""
 F  S I=$O(^EDP(230,VIADA,4,I)) Q:I'>0  D
 . S PRIM=$P($G(^EDP(230,VIADA,4,I,0)),U,3)
 .I PRIM D  Q
 . . S IENS=I_","_VIADA_","
 . . S DX=$$GET1^DIQ(230.04,IENS,.02,"E")
 Q DX
 ;
GETPAT ;Returns patient information based on DFN from File #2;ICR-10035, ICR-6607
 ;Input - VIA("PATH")="GETPATIENT" [required]
 ; VIA("IENS")=Patient DFN, [required]
 ;Data returned
 ; .01 Name,.02 Sex,.03 DateOfBirth,.09 SocialSecurityNumber,.097 DateEnteredIntoFile,
 ; .103 TreatingSpecialty,, .1041 AttendingPhysician,.302 ServiceConnectedPercentage,.105 CurrentAdmission,.1 Diagnosis [Short] from File #405
 N VIAFILE,VIAFIELDS,VIAFLAGS,X,VAL
 I VIAIENS="" S VIAER="Missing IENS Parameters" D ERR(VIAER) Q
 S VIAFILE=2,VIAFIELDS=".01;.02;.03;.09;.097;.103;.1041;.105;.109;.302",VIAFLAGS="IE"
 D GDIQ
 ; add Field .1 DIAGNOSIS [SHORT] from File #405 to result of .105 field in File #2.
 S X=1 F  S X=$O(RESULT(X)) Q:'X  I RESULT(X)["^.105^" S VAL=$P(RESULT(X),U,4) I VAL'="" S VAL=$$GET1^DIQ(405,VAL,.1,"E"),$P(RESULT(X),U,4)=$P(RESULT(X),U,4)_"~"_VAL Q
 Q
 ;
PATSSN ;Returns patient information based on SSN from File #2
 ;Input - VIA("PATH")="LISTPATIENTBYSSN" [required]
 ; VIA("SSN")=SSN [required]
 N DFN
 S DFN=$O(^DPT("SSN",VIASSN,""))
 I DFN="" S VIAER="Invalid SSN" D ERR(VIAER) Q
 S VIAIENS=DFN_","
 D GETPAT
 Q
 ;
LADMPAT ;Returns a list of admitted patients from File #2
 ;Input - VIA("PATH")="LISTADMITTEDPATIENTSFORUPDATE" [required]
 ; VIA("MAX")=n [optional]
 N VIAXREF,VIASCRN,X,VAL
 S VIAXREF="ACA",VIASCRN="I $D(^DPT(Y,.105))"
 D GPAT
 ; add Field .1 DIAGNOSIS [SHORT] from File #405 to result of .105 field in File #2.
 S X=1 F  S X=$O(RESULT(X)) Q:'X  S VAL=$P(RESULT(X),U,9) I VAL'="" S VAL=$$GET1^DIQ(405,VAL,.1,"E"),$P(RESULT(X),U,9)=$P(RESULT(X),U,9)_"~"_VAL
 Q
 ;
 ;This is the ORIGINAL implementation of LISTPATIENT
LSTPAT ;Returns a list of patients from File #2;ICR-10035, ICR-6607
 ;Input - VIA("PATH")="LISTPATIENT" [required]
 ; VIA("IENS")=Patient DFN, (multiple IENs separated by comma) [required, optional if date range provided]
 ; VIA("SDATE")=Start Date for search [optional if patient DFN provided]
 ; VIA("EDATE")=End Date for search [optional if patient DFN provided]
 ; VIA("FROM")=Starting Index record for search (DATE[,DFN]) [optional]
 ; VIA("MAX")=n [optional]
 ;
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS,TRESULT,Y,Z,I,VALUE,FLDS,CNT,VALX,VIATSDT
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS=""
 I $G(TVIAIENS)'="" D  Q
 . S VIAFILE=2,VIAFIELDS=".01;.02;.03;.09;.097;.103;.109;.1041;.105;.302;",VIAFLAGS="I"
 . ;S FLDS=".1-2;.02-3;.03-4;.09-5;.097-6;.103-7;.1041-9;.105-9;.109-8;.302-11"
 . S FLDS="0.1-2;.02-3;.03-4;.09-5;.097-6;.103-7;.109-8;.1041-9;.105-10;.302-11"
 . S TRESULT(1)="[Data]",CNT=1,VIA("MAX")=""
 . F I=1:1:$L(TVIAIENS,",") S VIAIENS=$P(TVIAIENS,",",I) I VIAIENS'="" D  M RESULT=TRESULT
 . . S $P(VALUE,U)=VIAIENS
 . . S VIAIENS=VIAIENS_","
 . . K RESULT
 . . D GDIQ
 . . I ($G(RESULT(1))'["Data")!($G(RESULT(2))="[ERROR]") K RESULT Q
 . . F Y=2:1:11 S J=$P($P(FLDS,";",Y-1),"-",2),$P(VALUE,U,J)=$P($G(RESULT(Y)),U,4) I $G(RESULT(Y))["^.105^" D
 . . . S VAL=$P($G(RESULT(Y)),U,4) I VAL'="" S VAL=$$GET1^DIQ(405,VAL,.1,"E"),$P(VALUE,U,J)=$P(VALUE,U,J)_"~"_VAL
 . . S CNT=CNT+1,TRESULT(CNT)=VALUE
 . . K RESULT
 E  D  ; If VIA("IENS") is not provided
 . S VIATSDT=(VIASDT\1)
 . D DTCHK(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 . S VIAXREF="BMS"
 . S VIASCRN="S X=$P($G(^DPT(Y,0)),U,9) I X?.N S X=$P($G(^DPT(Y,0)),U,16) I X'<VIATSDT,X<VIAEDT"
 . D GPAT
 . ; add Field .1 DIAGNOSIS [SHORT] from File #405 to result of .105 field in File #2.
 . S X=1 F  S X=$O(RESULT(X)) Q:'X  S VAL=$P(RESULT(X),U,9) I VAL'="" S VAL=$$GET1^DIQ(405,VAL,.1,"E"),$P(RESULT(X),U,9)=$P(RESULT(X),U,9)_"~"_VAL
 Q
 ;
GPAT ;Get patient data from File #2;ICR-10035,ICR-6607
 ;Data returned
 ; .01 Name,.02 Sex,.03 DateOfBirth,.09 SocialSecurityNumber,.097 DateEnteredIntoFile,.103 TreatingSpecialty
 ; .1041 AttendingPhysician,.302 ServiceConnectedPercentage,.105 CurrentAdmission, .109 ExcludeFromFacilityDir
 N VIAFILE,VIAFIELDS,VIAFLAGS
 S VIAFILE=2,VIAFIELDS="@;.01;.02;.03;.09;.097;.103;.1041;.105;.109;.302",VIAFLAGS="IP"
 D LDIC
 Q
 ;
ADMTPAT ;Returns a list of admitted patients from File #2 up to the Admitted IEN;ICR-10035
 ;Input - VIA("PATH")="LISTADMITTEDPATIENTS" [required]
 ; VIA("TO")=Admission IEN [required]
 ; VIA("MAX")=n [optional]
 ;Data returned
 ; .01 Name,.09 Social Security Number,.101 Bed Name,.102 Movement IEN,.105 Admitting Diagnosis,.1 Ward Name
 N VIAFILE,VIAFIELDS,VIASCRN,VIAFLAGS
 I VIATO="" S VIAER="Missing Admission IEN Parameter" D ERR(VIAER) Q
 S VIAFILE=2,VIAFIELDS="@;.01;.09;.101;.102;.105;.1;",VIATO=VIATO+.01,VIAXREF="ACA"
 S VIASCRN="I $D(^DPT(Y,.105)),$P(^DPT(Y,.105),U,1)<"_VIATO,VIAFLAGS="IP"
 D LDIC
 Q
 ;
WRDLOC ;Returns information for a ward from File #42;ICR-6609
 ;Input - VIA("PATH")="GETWARDLOCATIONS" [required]
 ; VIA("IENS")=Ward IEN, [required]
 ;Data returned
 ; .01 Name, .017 Specialty, .2 IsCurrentlyOutOfService
 N VIAFILE,VIAFIELDS
 I VIAIENS="" S VIAER="Missing Ward IEN" D ERR(VIAER) Q
 S VIAFILE=42,VIAFIELDS=".01;.017;.2;",VIAFLAGS="IE"
 D GDIQ
 Q
 ;
NEWPER ;Returns a list of people from the NEW PERSON file #200 for a date range on DATE ENTERED Field (#30)
 ;Input - VIA("PATH")="LISTNEWPERSON" [required]
 ; VIA("IENS")=New Person IEN, (multiple IENs separated by comma) [optional]
 ; VIA("SDATE")=Start Date for search [required, if VIA(IENS) not present]
 ; VIA("EDATE")=End Date for search [required, if VIA(IENS) not present 
 ;Data returned;ICR #10060
 ; .01 Name, 30 Date Entered
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS,TRESULT
 S VIAFILE=200,VIAFIELDS="@;.01;30;",VIAFLAGS="IP",VIAXREF="B"
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS=""
 I $G(TVIAIENS)'="" S VIAFIELDS=".01;30;",VIAFLAGS="I" D  Q
 . S TRESULT(1)="[Data]",CNT=1
 . F I=1:1:$L(TVIAIENS,",") S VIAIENS=$P(TVIAIENS,",",I) I VIAIENS'="" D  M RESULT=TRESULT
 . . S VIAIENS=VIAIENS_","
 . . K RESULT
 . . D GDIQ
 . . I $G(RESULT(1))'["Data" Q
 . . S CNT=CNT+1,TRESULT(CNT)=$TR(VIAIENS,",")_"^"_$P($G(RESULT(2)),U,4)
 . . K RESULT
 E  D  ; If VIA("IENS") is not provided
 . D DTCHK(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q
 . S VIASCRN="S X=$P($G(^(1)),U,7) I X>VIASDT,X<VIAEDT"
 . D LDIC
 Q
 ;
SPLTY ;Returns a list of specialties from the SPECIALTY file #42.4;ICR-2652
 ;Input - VIA("PATH")="LISTSPECIALTY" [required]
 ; VIA("IENS")= Specialty IEN, (multiple IENs separated by comma) [optional]
 ;Data returned
 ; .01 Name
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS
 S VIAFILE=42.4,VIAFIELDS="@;.01;",VIAFLAGS="IP"
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS="",VIAMAX=""
 D LDIC
 I $G(TVIAIENS)'="" S VIAIENS=TVIAIENS D PIENS^VIABMS1
 Q
 ;
PATAPPT ; Returns a list of patient appointments using API SDAPI^SDAMA301;ICR-4433
 ;Input - VIA("PATH")="LISTPATIENTAPPOINTMENT" [required]
 ; VIA("IENS")=Patient IEN [required]
 ; VIA("CLNIEN")=Hospital Location IEN [optional]
 ; VIA("SDATE")=Start Date for search [optional]
 ; VIA("EDATE")=End Date for search [optional]
 ;Data returned
 ; .01 HospitalLocation, 20 DateAppointmentMade, 100 CurrentStatus
 N VIARRAY,CNT,VIADT,VIADFNS,VIAPPT,VIACNT,CLNIEN,RCNT,QFLG,I
 I VIAIENS="" S VIAER="Missing PATIENT IEN" D ERR(VIAER) Q
 ;I (VIASDT'="")!(VIAEDT'="") D DTCHK(.RESULT,.VIASDT,.VIAEDT) I $D(RESULT) Q ;$$SDAPI^SDAMA301 handles dates differently
 S VIADFN=$TR(VIAIENS,",",";"),VIACIEN=$TR(VIACIEN,",",";")
 S VIAEDT=$S(VIAEDT="":DT,1:VIAEDT)
 S RESULT(1)="[Data]",CNT=1,RCNT=1,QFLG=0,MORE=""
 S VIARRAY(1)=VIASDT_";"_VIAEDT
 I VIACIEN'="" S VIARRAY(2)=VIACIEN
 S VIARRAY(4)=VIADFN
 S VIARRAY("FLDS")="1;2;4;16;22"
 S VIACNT=$$SDAPI^SDAMA301(.VIARRAY)
 I VIACNT<1 G PATAPPTQ
 I VIACNT<1 Q
 S VIADFN=$S(VIAFROM'="":$P(VIAFROM,"~")-1,1:0)
 F  S VIADFN=$O(^TMP($J,"SDAMA301",VIADFN)) Q:'VIADFN  D  Q:$G(QFLG)
 . I ($P(VIAFROM,"~")>0),$P(VIAFROM,"~")'=VIADFN S VIAFROM=""
 . S CLNIEN=$S(VIAFROM'="":$P(VIAFROM,"~",2)-1,1:0)
 . F  S CLNIEN=$O(^TMP($J,"SDAMA301",VIADFN,CLNIEN)) Q:'CLNIEN  D  Q:$G(QFLG)
 . . I ($P(VIAFROM,"~",2)>0),$P(VIAFROM,"~",2)'=CLNIEN S VIAFROM=""
 . . S VIADT=$S((VIAFROM'="")&(RCNT=1):$P(VIAFROM,"~",3),1:0)
 . . F  S VIADT=$O(^TMP($J,"SDAMA301",VIADFN,CLNIEN,VIADT)) Q:'VIADT  D  I RCNT>VIAMAX Q
 . . . S VIAPPT=$G(^TMP($J,"SDAMA301",VIADFN,CLNIEN,VIADT)) ;appointment data
 . . . S CNT=CNT+1,RCNT=RCNT+1,RESULT(CNT)=VIADT_"^"_CLNIEN_"^"_$P(VIAPPT,"^",16)_"^"_$P($P(VIAPPT,"^",22),";",3)_"^"_$P($P(VIAPPT,"^",4),";")
 . . . I RCNT>VIAMAX D
 . . . . S MORE="MORE^"_VIADFN_"~"_CLNIEN_"~"_VIADT S QFLG=1
 I QFLG D
 . M TARRAY=RESULT
 . K RESULT
 . S CNT=3,I=0,RESULT(1)="[Misc]",RESULT(2)=MORE,RESULT(3)="[Data]"
 . F  S I=$O(TARRAY(I)) Q:'I  D
 . . I TARRAY(I)["[Data" Q
 . . S CNT=CNT+1,RESULT(CNT)=TARRAY(I)
PATAPPTQ K ^TMP($J,"SDAMA301")
 Q
 ;
CANORDS ; Returns a list of cancelled orders from the ORDER file #100;ICR-5771
 ;Input - VIA("PATH")="LISTCANCELORDERS" [required]
 ; VIA("IENS")=list of Order IENs [required]
 ;Data returned:
 ;Order file IEN
 ;Date of 1st ORDER ACTION
 ;Status
 ;Object of order
 ;Hospital location
 I VIAIENS="" S VIAER="Missing ORDER IEN" D ERR(VIAER) Q
 N I,IEN,IENS,NMBR,PAT,ACTDT,STATUS,HLOC,DATE,REC,CNT
 S RESULT(1)="[Data]"
 S CNT=0
 F I=1:1:$L(VIAIENS,",") D
 .S IEN=$P(VIAIENS,",",I)
 .D:$S(+IEN'=IEN:0,'$D(^OR(100,IEN,0)):0,1:1)
 ..S IENS=IEN_","
 ..S CNT=CNT+1
 ..S PAT=$$GET1^DIQ(100,IENS,.02,"I") ;really OBJECT OF ORDER
 ..S ACTDT=$$ACTDATE(VIAIENS)
 ..S STATUS=$$GET1^DIQ(100,IENS,5,"E")
 ..S HLOC=$$GET1^DIQ(100,IENS,6,"I")
 ..S REC=IEN_U_ACTDT_U_STATUS_U_PAT_U_HLOC
 ..S RESULT(CNT+1)=REC
 Q
 ;
ACTDATE(IEN) ;Returns the date of the first ORDER ACTION found
 N VAL,SIEN
 S SIEN=$O(^OR(100,+IEN,8,0))
 Q:SIEN="" "" ;in case there are no order actions
 S VAL=$P(^OR(100,+IEN,8,SIEN,0),U)
 Q VAL
 ;
LWRDLOC ; Returns a list of ward locations from the WARD LOCATION file #42;ICR-6609
 ;Input - VIA("PATH")="LISTWARDLOCATION" [required]
 ; VIA("IENS")= Ward Location IEN, (multiple IENs separated by comma) [optional] 
 ;Data returned
 ; .01 Name,.017 Specialty,.2 IsCurrentlyOutOfService
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS
 S VIAFILE=42,VIAFIELDS="@;.01;.017;.2",VIAFLAGS="IP"
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS="",VIAMAX=""
 D LDIC
 I $G(TVIAIENS)'="" S VIAIENS=TVIAIENS D PIENS^VIABMS1
 Q
 ;
MOVTYP ; Returns a list of facility movement type from the FACILITY MOVEMENT TYPE file #405.1;ICR-6610
 ;Input - VIA("PATH")="LISTFACILITYMOVEMENTTYPE" [required]
 ; VIA("IENS")= Facility Movement Type IEN, (multiple IENs separated by comma) [optional]
 ;Data returned
 ; .01 Name,.04 Active
 N VIAFILE,VIAFIELDS,VIAFLAGS,TVIAIENS
 S VIAFILE=405.1,VIAFIELDS="@;.01;.04",VIAFLAGS="IP"
 I VIAIENS'="" S TVIAIENS=VIAIENS S VIAIENS="",VIAMAX=""
 D LDIC
 I $G(TVIAIENS)'="" S VIAIENS=TVIAIENS D PIENS^VIABMS1
 Q
 ;
DTCHK(RESULT,VIASDT,VIAEDT) ;check/set date
 I (VIASDT="")!(VIAEDT="") S VIAER="Missing Date Parameters" D ERR(VIAER) Q
 S VIASDT=VIASDT-.000001,VIAEDT=$S(VIAEDT[".":VIAEDT+.000001,1:VIAEDT+.999999)
 ;S VIASDT=$S(VIASDT[VIASDT[".":VIASDT,1:VIASDT-.000001),VIAEDT=$S(VIAEDT[".":VIAEDT+.000001,1:VIAEDT+.999999)
 Q
 ;
PATCHK(DFN) ;check if patient is valid in File #2
 D PID^VADPT
 I $G(VAERR) S VIAER="Invalid Patient IEN" D ERR(VIAER)
 K VA,VAERR
 Q
 ;
GDIQ ;Runs GETS^DIQ
 N VIADATA,VIAERR,Y,VIAFLD,N,X,J,C
 D GETS^DIQ(VIAFILE,VIAIENS,VIAFIELDS,VIAFLAGS,"VIADATA","VIAERR")
 S N=0
 D SET("[Data]")
 S VIAFLD=0 F  S VIAFLD=$O(VIADATA(VIAFILE,VIAIENS,VIAFLD)) Q:'VIAFLD  D
 . S X=VIAFILE_"^"_$E(VIAIENS,1,$L(VIAIENS)-1)_"^"_VIAFLD_"^"
 . ; -- below call to $$GET1 is too slow...working w/FM team for speed
 . ;IF $$GET1^DID(VIAFILE,VIAFLD,"","TYPE")="WORD-PROCESSING" D
 . IF $P($G(^DD(VIAFILE,VIAFLD,0)),U,4)[";0" D
 . . D SET(X_"[WORD PROCESSING]")
 . . S J=0 F  S J=$O(VIADATA(VIAFILE,VIAIENS,VIAFLD,J)) Q:'J  D
 . . . D SET(VIADATA(VIAFILE,VIAIENS,VIAFLD,J))
 . . D SET("$$END$$")
 . E  D
 . . D SET(X_$G(VIADATA(VIAFILE,VIAIENS,VIAFLD,"I"))_"^"_$G(VIADATA(VIAFILE,VIAIENS,VIAFLD,"E")))
 ;
 IF $D(VIAERR) D
 . D SET("[ERROR]")
 ;
 M RESULT=Y
 Q
 ; 
LDIC ;Runs LIST^DIC
 N VIAERR,X,Y,I,N,VAL
 I $G(VIAFROM)["~" S X=VIAFROM,VIAFROM=$P(X,"~"),VIAFROM("IEN")=$P(X,"~",2)
 D LIST^DIC(VIAFILE,VIAIENS,VIAFIELDS,VIAFLAGS,VIAMAX,.VIAFROM,VIAPART,VIAXREF,VIASCRN,VIAID,"^TMP(""VIARSLT"",$J)","VIAERR")
 I $D(VIAOK),VIAOK=0 K ^TMP("VIARSLT",$J),VIAOK Q
 K VIAOK
 S N=0
 IF $G(VIAFROM)]"" D
 . D SET("[Misc]")
 . S X="MORE"_U_VIAFROM
 . I $G(VIAFROM("IEN"))'="" S X=X_"~"_VIAFROM("IEN")
 . D SET(X)
 ;
 D SET("[Data]")
 S I=0 F  S I=$O(^TMP("VIARSLT",$J,"DILIST",I)) Q:'I  D
 .S VAL=$G(^TMP("VIARSLT",$J,"DILIST",I,0))
 .D SET(VAL)
 ;
 IF $D(VIAERR) D
 . D SET("[Errors]")
 . D SET($G(VIAERR("DIERR",1,"TEXT",1)))
 ;
 M RESULT=Y
 K ^TMP("VIARSLT",$J)
 Q
 ;
SET(X) ;
 S N=N+1
 S Y(N)=X
 Q
 ;
ERR(X) ;Error processing
 N N
 S N=0
 D SET("[Errors]")
 D SET(X)
 M RESULT=Y
 Q
 ;
KVAR ;Clean-up
 K VIAFILE,VIAFIELDS,VIAIENS,VIAEDT,VIAFLAGS,VIAID,VIAMAX,VIAPART,VIASCRN,VIASDT,VIAVAL,VIAXREF,VIAFROM
 K VIAPIEN,VIACIEN,VIAMDT,VIAMTYP,VIATO,VIALEDT,VIASSN,VIAA,VIAB,VIAC,VIAD,VIAR,VIAV,VIAX,VIAOIEN,VIA3,X,Y,VIAOI
 Q
 ;
GMVTR(IENS) ;
 N FLDS,OUT,MOUT,I,J,IEN,REC
 S FLDS=".01;101;100;.02;.03;.04;.06;.07;.14"
 D GETS^DIQ(405,IENS,"@;"_FLDS,"IE","OUT","MOUT")
 S REC=$P(IENS,",")
 S $P(REC,U,2)=$G(OUT(405,IENS_",",.01,"I"))
 S $P(REC,U,3)=$G(OUT(405,IENS_",",101,"I"))
 S $P(REC,U,4)=$G(OUT(405,IENS_",",100,"I"))
 S $P(REC,U,5)=$G(OUT(405,IENS_",",.02,"I"))
 S $P(REC,U,6)=$G(OUT(405,IENS_",",.03,"I"))
 S $P(REC,U,7)=$G(OUT(405,IENS_",",.04,"I"))
 S $P(REC,U,8)=$G(OUT(405,IENS_",",.06,"I"))
 S $P(REC,U,9)=$G(OUT(405,IENS_",",.07,"I"))
 S $P(REC,U,10)=$G(OUT(405,IENS_",",.14,"I"))
 Q REC
 ;
HNDL ;Finds PATH and linetag that needs to be executed for results
 ;;GETACTIVITY;GETACT
 ;;GETPATIENT;GETPAT
 ;;LISTPATIENTBYSSN;PATSSN
 ;;LISTADMITTEDPATIENTSFORUPDATE;LADMPAT
 ;;LISTADMITTEDPATIENTS;ADMTPAT
 ;;GETWARDLOCATIONS;WRDLOC
 ;;LISTHOSPITALLOCATIONS;HOSLOC^VIABMS2
 ;;LISTNEWPERSON;NEWPER
 ;;LISTSPECIALTY;SPLTY
 ;;LISTPATIENTAPPOINTMENT;PATAPPT
 ;;LISTCANCELORDERS;CANORDS
 ;;LISTWARDLOCATION;LWRDLOC
 ;;LISTFACILITYMOVEMENTTYPE;MOVTYP
 ;;LISTFACILITYTREATINGSPECIALTY;TRTSPTY^VIABMS1
 ;;LISTMASMOVEMENTTRANSACTIONTYPE;MASTYP^VIABMS1
 ;;LISTMEDICALCENTERDIVISION;MEDCTR^VIABMS1
 ;;LISTORDERABLEITEM;ORDITM^VIABMS1
 ;;LISTORDERSTATUS;ORDSTA^VIABMS1
 ;;LISTBEDSWITCH;BEDSWCH^VIABMS1
 ;;GETPATIENTMOVEMENT;GPATMVT^VIABMS2
 ;;LISTPATIENTMOVEMENT;LPATMVT^VIABMS1
 ;;LISTPATIENTMOVEMENTSBYADMISSION;APATMVT^VIABMS1
 ;;LISTSCHEDULEDADMISSION;SCHADM^VIABMS1
 ;;LISTROOMBED;RMBED^VIABMS1
 ;;LISTCLINICAPPOINTMENTS;CLNAPPT^VIABMS1
 ;;LISTPATIENT;LSTPAT2^VIABMS2
 ;;LISTORDERS;LSTORD^VIABMS4
 ;;LISTORDERACTIONS;ORDACT^VIABMS4
 ;;LISTORDERSOLD;LSTORD^VIABMS3
 ;;LISTORDERACTIONSOLD;ORDACT^VIABMS3
 ;;END
