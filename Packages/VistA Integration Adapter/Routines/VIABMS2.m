VIABMS2 ;SGU/GJW - VIA BMS RPCs ;04/15/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**11**;06-FEB-2014;Build 45
 ;The following RPC is in support of the Bed Management System (BMS). This RPC reads the parameter "Path"
 ;and determine from that parameter which data to return.  All BMS requests are handled by this one RPC.
 ;Continuation of VIABMS RPC VIAB BMS
 ;
HOSLOC ;Returns a list of hospital locations from File #44;ICR-10040;ICR-4782
 ;Input - VIA("PATH")="LISTHOSPITALLOCATIONS" [required]
 ;VIA("IENS")=Hospital IEN, (multiple IENs separated by comma) [optional]
 ;VIA("MAX")=Maximum number of records returned [optional]
 ;VIA("FROM")=starting value (IEN) [optional]
 ;Data returned
 ; .01 Name,1 Abbreviation,99 Telephone,42 WardLocation
 N VIADATA,START,I,CNT,FLAG,OFFSET
 I VIAIENS'="" D HOSLOC2(.RESULT,VIAIENS) Q
 S VIADATA=$NA(^TMP($J,"VIADATA"))
 K @VIADATA
 S START=+VIAFROM
 S FLAG=0
 S I=START,CNT=0
 F  S I=$O(^SC(I)) Q:I'>0!(CNT'<VIAMAX)  D
 .S CNT=CNT+1
 .S:CNT=VIAMAX FLAG=1
 .S @VIADATA@(CNT)=$$HOSLOC1(I)
 I FLAG D
 .S RESULT(1)="[Misc]"
 .S RESULT(2)="MORE^"_$O(^SC(I),-1)
 .S RESULT(3)="[Data]"
 .S OFFSET=3
 I 'FLAG D
 .S RESULT(1)="[Data]"
 .S OFFSET=1
 S I=0
 F  S I=$O(@VIADATA@(I)) Q:I'>0  D
 .S RESULT(I+OFFSET)=@VIADATA@(I)
 K @VIADATA
 Q
 ;
HOSLOC1(J) ;
 Q:J=0 "0^No Hospital Location (IEN=0)^^^"
 Q:'$D(^SC(J)) J_"^No Hospital Location (IEN="_J_")^^^"
 S REC=J
 S $P(REC,U,2)=$P($G(^SC(J,0)),U)
 S $P(REC,U,3)=$P($G(^SC(J,0)),U,2)
 S $P(REC,U,4)=$P($G(^SC(J,99)),U)
 S $P(REC,U,5)=$P($G(^SC(J,42)),U)
 Q REC
 ;
HOSLOC2(RESULT,IENS) ;
 N I,IEN,CNT
 S CNT=0
 S RESULT(1)="[Data]"
 F I=1:1:$L(IENS,",") D
 .S IEN=$P(IENS,",",I)
 .S CNT=CNT+1
 .S RESULT(CNT+1)=$$HOSLOC1(IEN)
 Q
 ;
WALK(STARTI,STARTJ,MAX,START,END,ROOT) ;
 N I,J,CNT,STOP,PREVI,PREVJ,VAL,DGPAT,MORE,JJ,II
 S (STOP,CNT,J,PREVI,PREVJ,MORE)=0
 S I=$G(STARTI,0)
 S J=$G(STARTJ,0)
 S PATIEN=VIAPIEN
 S START=$G(START,0)
 S I=$S(START>I:START,1:I)
 S END=$G(END,9999999)
 S MAX=$G(MAX,5000)
 S ROOT=$G(ROOT,$NA(^TMP($J,"VIADATA")))
 I PATIEN="" D
 .F  S I=$O(^DGPM("AD",I)) Q:I=""!(CNT=MAX)!(I>END)  D  Q:(CNT=MAX)
 ..F  S J=$O(^DGPM("AD",I,J)) Q:J=""!(CNT=MAX)  D  Q:(CNT=MAX)
 ...S VAL=$$MVTR^VIABMS1(J)
 ...S @ROOT@(CNT)=VAL,CNT=CNT+1
 ...S:CNT'>MAX PREVJ=J,PREVI=I
 .S MORE=$S(CNT=MAX&(J'=""):1,1:0)
 I PATIEN'="" D
 .F  S J=$O(^DGPM("C",PATIEN,J)) Q:J=""!(CNT=MAX)  D  Q:CNT=MAX
 ..S I=$$GET1^DIQ(405,J,101,"I")
 ..I I'<START,I'>END D
 ...S VAL=$$MVTR^VIABMS1(J)
 ...S @ROOT@(CNT)=VAL,CNT=CNT+1
 ...S:CNT'>MAX PREVJ=J,PREVI=I
 .;if no dates
 .I START=0,(END=9999999) D  Q
 ..S JJ=PREVJ,JJ=$O(^DGPM("C",PATIEN,PREVJ))
 ..S:JJ'="" MORE=1,PREVI=$$GET1^DIQ(405,PREVJ,101,"I")
 ..S:PREVI="" PREVI=$$GET1^DIQ(405,PREVJ,.01,"I")
 .;if dates
 .S JJ=PREVJ F  S JJ=$O(^DGPM("C",PATIEN,JJ)) Q:JJ=""!(MORE)  D  Q:MORE
 ..S II=$$GET1^DIQ(405,JJ,101,"I")
 ..I II'<START,II'>END S MORE=1
 ;
DONE ;
 Q PREVI_U_PREVJ_U_MORE
 ;
LPATMVT2 ;This is the original code that is not used, but left here for reference as it uses the default LDIC logic.
 ;Returns a list of patient movement records from the PATIENT MOVEMENT file #405;ICR-1865
 ;Input - VIA("PATH")="LISTPATIENTMOVEMENT" [required]
 ;        VIA("PATIEN")=Patient IEN [required, if no date range]
 ;        VIA("SDATE")=Start Date for search [optional]
 ;        VIA("EDATE")=End Date for search [optional]
 ;        VIA("MAX")=n [optional]
 ;Data returned
 ;    .01 MovementDate,101 EnteredDate,100 Entered By,.02 TransactionTypeId,.03 PatientIen,
 ;    .04 TypeOfMovementIen,.06 WardLocationId,.07 RoomBedId,.14 CurrentAdmissionIen
 N VIAFILE,VIAFIELDS,VIAXREF,VIALAGS,VIASCRN,I
 S VIAFILE=405
 S VIAFIELDS=".01;100;101;.02;.03;.04;.06;.07;.14"
 S VIAFLAGS="IP"
 D:(VIASDT'=""!(VIAEDT'="")) DTCHK^VIABMS(.RESULT,VIASDT,VIAEDT) I $D(RESULT) Q
 I VIAPIEN="" D
 .S VIAXREF="AD"
 .S VIASCRN="S VIAXX=$P($G(^DGPM(Y,""USR"")),U,2) I VIAXX'<VIASDT,VIAXX'>VIAEDT"
 I VIAPIEN'=""&(VIASDT'=""!(VIAEDT'="")) D
 .S VIAXREF="C"
 .S VIASCRN="S VIAXX=$P($G(^DGPM(Y,""USR"")),U,2) I VIAXX'<VIASDT,VIAXX'>VIAEDT,$P(^DGPM(Y,0),U,3)=VIAPIEN"
 I VIAPIEN'="",VIASDT="",VIAEDT="" D
 .S VIAXREF="C"
 .S VIASCRN="I $P(^DGPM(Y,0),U,3)=VIAPIEN"
 D LDIC^VIABMS
 ;Trim the last two pieces off the right
 S I=""
 F  S I=$O(RESULT(I)) Q:I=""  D
 .I RESULT(I)'?1"[".A1"]" S RESULT(I)=$P(RESULT(I),U,1,10)
 Q
 ;
LSTPAT2 ;Returns a list of patients from File #2;ICR-10035, ICR-6607
 ;Input - VIA("PATH")="LISTPATIENT" [required]
 ; VIA("IENS")=Patient DFN, (multiple IENs separated by comma) [required, optional if date range provided]
 ; VIA("SDATE")=Start Date for search [optional if patient DFN provided]
 ; VIA("EDATE")=End Date for search [optional if patient DFN provided]
 ; VIA("FROM")=Starting Index record for search (DATE[,DFN]) [optional]
 ; VIA("MAX")=n [optional]
 ;Data returned
 ;.01 Name, .02 Sex, .03 DateofBirth, .09 SSN, .097 DateEnteredintoFile, .103 TreatingSpecialty, 
  ;.109 ExcludefromFacilityDir, .1041 AttendingPhysician, .105 Admission + ShortDx, .302 SCPercentage
 N I,X,ROOT,STARTI,STARTJ,ENDI,ENDJ,MORED,RES,VAL
 I VIASDT="",VIAEDT="",VIAIENS="" S VIAER="Missing DATE parameters" D ERR^VIABMS(VIAER) Q
 I VIAEDT<VIASDT S VIAER="END date cannot be before START date" D ERR^VIABMS(VIAER) Q
 ;Only retain the date portion
 S VIASDT=$P(VIASDT,".")
 S VIAEDT=$P(VIAEDT,".")
 ;Check to see if any data remains
 I VIASDT="",VIAIENS'="" G CONTX
 I '$D(^DPT("BMS",VIASDT))&$O(^DPT("BMS",VIASDT))="" D  Q
 .S RESULT(1)="[Data]"
CONTX ;
 S MORED=0
 S ROOT=$NA(^TMP("VIADATA",$J))
 I VIAIENS'="" D  Q
 .S RESULT(1)="[Data]"
 .F I=1:1:$L(VIAIENS,",") D
 ..S X=$P(VIAIENS,",",I)
 ..S:X'="" RESULT(I+1)=$$PTR2(X)
 I VIAIENS="" D
 .S VAL=$$SEEK(+VIASDT)
 .S STARTI=$P(VAL,U),STARTJ=$P(VAL,U,2)
 .I VIAFROM'="" S STARTI=$P(VIAFROM,"~"),STARTJ=$P(VIAFROM,"~",2)
 .S RES=""
 .S:STARTI="" RESULT(1)="[Data]"
 .S:STARTI'="" RES=$$WALK3(ROOT,VIAMAX,STARTI,STARTJ)
 .S ENDI=$P(RES,U),ENDJ=$P(RES,U,2),MORED=$P(RES,U,3)
 I MORED=0 D
 .S RESULT(1)="[Data]"
 .S I=""
 .F  S I=$O(@ROOT@(I)) Q:I'>0  S RESULT(I+1)=@ROOT@(I)
 I MORED=1 D
 .S RESULT(1)="[Misc]"
 .S RESULT(2)="MORE^"_ENDI_"~"_ENDJ
 .S RESULT(3)="[Data]"
 .S I=""
 .F  S I=$O(@ROOT@(I)) Q:I'>0  S RESULT(I+3)=@ROOT@(I)
 K @ROOT
 Q
 ;
SEEK(SDATE) ;
 N I,J
 Q:SDATE="" U
 I $D(^DPT("BMS",SDATE)) S I=SDATE
 E  S I=$O(^DPT("BMS",SDATE))
 Q:I="" U
 S J=$O(^DPT("BMS",I,""))
 Q $G(I)_U_$G(J)
 ;
WALK3(ROOT,MAX,STARTI,STARTJ) ;
 S ROOT=$G(ROOT,$NA(^TMP("VIADATA",$J))) ;data root
 S MAX=$G(MAX,5000)
 S STARTI=$G(STARTI)
 S STARTJ=$G(STARTJ)
 N I,J,CNT,FIRST,MORE,IROOT
 S I=STARTI,J=STARTJ
 S IROOT=$NA(^DPT("BMS")) ;index root
 K @ROOT
 S CNT=0,ENDI=0,ENDJ=0
 F  D  Q:I=""!(CNT'<MAX)
 .F  D  Q:J=""!(CNT'<MAX)
 ..I VIASDT'="",$$ENTERED(J)'<VIASDT,$$ENTERED(J)'>VIAEDT D
 ...D VISIT(I,J,ROOT,.CNT)
 ..S:(CNT<MAX) J=$O(@IROOT@(I,J))
 .S:(CNT<MAX) I=$O(@IROOT@(I))
 S MORE=$S(CNT=MAX:1,1:0)
 Q $$NEXT(I,J)_U_MORE
 ;
VISIT(I,J,ROOT,CNT) ;
 S CNT=CNT+1
 S @ROOT@(CNT)=$$PTR2(J)
 Q 
 ;
ENTERED(VIAIEN) ;
 Q:VIAIEN="" ""
 Q $P($G(^DPT(VIAIEN,0)),U,16)
 ;
NEXT(I,J) ;
 N VAL,K,L
 ;first, some sanity checking
 I I="" S VAL=U G NXTQ
 S K=$O(^DPT("BMS",I,J))
 I K'="" S VAL=I_U_K G NXTQ
 S K=$O(^DPT("BMS",I))
 S L=$O(^DPT("BMS",K,""))
 S VAL=K_U_L
NXTQ ;
 Q VAL
 ;
PTR2(VIAIEN) ;
 Q:'$D(^DPT(VIAIEN,0)) ""
 N REC,ADM,DX,NODE0,NODE103,NODE109,NODE1041,NODE105,NODE3
 S NODE0=^DPT(VIAIEN,0)
 S NODE103=$G(^DPT(VIAIEN,.103))
 S NODE109=$G(^DPT(VIAIEN,.109))
 S NODE1041=$G(^DPT(VIAIEN,.1041))
 S NODE105=$G(^DPT(VIAIEN,.105))
 S NODE3=$G(^DPT(VIAIEN,.3))
 S REC=VIAIEN_U_$P(NODE0,U) ;.01
 S REC=REC_U_$P(NODE0,U,2)  ;.02
 S REC=REC_U_$P(NODE0,U,3)  ;.03
 S REC=REC_U_$P(NODE0,U,9)  ;.09
 S REC=REC_U_$P(NODE0,U,16) ;.097
 S REC=REC_U_$P(NODE103,U)  ;.103
 S REC=REC_U_$P(NODE1041,U) ;.1041
 S ADM=$P(NODE105,U)
 S REC=REC_U_ADM
 I ADM'="",$D(^DGPM(ADM,0)) S REC=REC_"~"_$P(^(0),U,10) ;.105
 S REC=REC_U_$P(NODE109,U)  ;.109
 S REC=REC_U_$P(NODE3,U,2)  ;.302
 Q REC
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
 I VIAIENS="",VIAMDT="",VIAMTYP="",VIAPIEN="" S VIAER="Missing Input parameters" D ERR^VIABMS(VIAER) Q
 I VIAIENS'="" D  Q  ;Note that other parameters are ignored
 .N I,IEN,CNT
 .S CNT=0
 .S RESULT(1)="[Data]"
 .F I=1:1:$L(VIAIENS) D
 ..S IEN=$P(VIAIENS,",",I)
 ..I IEN>0,$D(^DGPM(IEN,0)) D
 ...S CNT=CNT+1
 ...S RESULT(CNT+1)=$$GMVTR^VIABMS(IEN)
 I VIAIENS="",VIAMDT'="",VIAMTYP'="",VIAPIEN'="" D  Q
 .S RESULT(1)="[Data]"
 .I $D(^DGPM("AC",VIAMDT,VIAMTYP,VIAPIEN)) D  Q
 ..S IEN=$O(^DGPM("AC",VIAMDT,VIAMTYP,VIAPIEN,""))
 ..S RESULT(2)=$$GMVTR^VIABMS(IEN)
 S VIAER="Movement date, movement type, and patient IEN are required."
 D ERR^VIABMS(VIAER)
 Q
