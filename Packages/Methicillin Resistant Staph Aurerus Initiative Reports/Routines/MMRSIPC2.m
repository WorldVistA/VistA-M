MMRSIPC2 ;MIA/LMT - Print MRSA IPEC Report Cont. (Contains functions to collect patient movements) ;02/15/17  10:35
 ;;1.0;MRSA PROGRAM TOOLS;**1,5**;Mar 22, 2009;Build 146
 ;
 ; Reference to ^DGPM("ATT"_X supported by ICR #1865
 ; Reference to ^DGPM("APTT"_X supported by ICR #2090
 ; Reference to ^DGPM(D0,0) supported by ICR #419
 ; Reference to ^DGPM("AMV"_X supported by ICR #419
 ; Reference to ^DPT("CN", supported by ICR #5431
 ;
 ;
GETMOVE ;Collects ward movements for patients that were admitted or discharged in date range.
 ;
 ; ZEXCEPT: BYADM,MMRSLOC
 ;
 N LOC,DUPLOC,MMRSLOC2
 ;
 S LOC=0 F  S LOC=$O(MMRSLOC(LOC)) Q:'LOC  D
 . S DUPLOC=$$DUPLOC(LOC,.MMRSLOC)
 . I 'DUPLOC S MMRSLOC2(LOC)=""
 . I DUPLOC D
 . . I BYADM D GETADM(LOC)
 . . I 'BYADM D GETDIS(LOC)
 . . I 'BYADM D GETNODIS(LOC) ;For discharge\transmission report show list of patients that have not been discharged yet
 I '$D(MMRSLOC2) Q
 I BYADM D GETADM(0)
 I 'BYADM D GETDIS(0)
 I 'BYADM D GETNODIS(0) ;For discharge\transmission report show list of patients that have not been discharged yet
 ;
 Q
 ;
GETADM(LOC) ;
 ;
 ; ZEXCEPT: MMRSLOC2,STRTDT
 ;
 N TT,MOVDT,MOVIFN,DFN,TRANTYPE,INWARD,INDATE,INIFN,INTT,OUTDATE,OUTIFN,OUTTT,NEXTIEN,LOCNAME,VAIP,INLOC
 N OUTWARD,PREVWARD
 ;
 F TT=1,2 S MOVDT=STRTDT-.0000001 F  S MOVDT=$O(^DGPM("ATT"_TT,MOVDT)) Q:(MOVDT>ENDDT)!('MOVDT)  D
 . S MOVIFN="" F  S MOVIFN=$O(^DGPM("ATT"_TT,MOVDT,MOVIFN)) Q:'MOVIFN  D
 . . D KVA^VADPT S DFN=$P($G(^DGPM(MOVIFN,0)),"^",3),VAIP("E")=MOVIFN D IN5^VADPT
 . . S TRANTYPE=$$TRANTYPE(+VAIP(4),+VAIP(2),VAIP(1),DFN)
 . . S PREVWARD=$P(TRANTYPE,U,2)
 . . S TRANTYPE=$P(TRANTYPE,U,1)
 . . I TRANTYPE<1!(TRANTYPE=3) Q
 . . S INWARD=+VAIP(5)
 . . I PREVWARD="" S PREVWARD=+VAIP(15,4)
 . . I TRANTYPE=2,'$$CNGWARD(LOC,PREVWARD,INWARD) Q
 . . Q:$$EXCWARD(LOC,INWARD)
 . . ;SET GLOBAL
 . . S INDATE=+VAIP(3)
 . . S INIFN=MOVIFN
 . . S INTT=TRANTYPE
 . . ;
 . . S (OUTDATE,OUTIFN,OUTTT)=" "
 . . F  Q:(VAIP(16)="")!(OUTIFN)  D
 . . . S TRANTYPE=$$TRANTYPE(+VAIP(16,3),+VAIP(16,2),VAIP(16),DFN)
 . . . S OUTWARD=$P(TRANTYPE,U,2)
 . . . S NEXTIEN=$P(TRANTYPE,U,3)
 . . . S TRANTYPE=$P(TRANTYPE,U,1)
 . . . I OUTWARD="" S OUTWARD=+VAIP(16,4)
 . . . I TRANTYPE=3 S OUTDATE=+VAIP(16,1),OUTIFN=VAIP(16),OUTTT=3
 . . . I TRANTYPE=2,$$CNGWARD(LOC,INWARD,OUTWARD) S OUTDATE=+VAIP(16,1),OUTIFN=VAIP(16),OUTTT=2
 . . . Q:OUTIFN
 . . . I NEXTIEN="" S NEXTIEN=VAIP(16)
 . . . D KVA^VADPT
 . . . S VAIP("E")=NEXTIEN
 . . . D IN5^VADPT
 . . ;
 . . S INLOC=$G(LOC)
 . . I +INLOC=0 S INLOC=$$GETLOC(INWARD,.MMRSLOC2)
 . . S LOCNAME=$P($G(^MMRS(104.3,INLOC,0)),U)
 . . S ^TMP($J,"MMRSIPC","D",LOCNAME,INDATE,DFN,OUTDATE)=INLOC_U_DFN_U_INDATE_U_INIFN_U_INTT_U_OUTDATE_U_OUTIFN_U_OUTTT
 ;
 D KVA^VADPT
 ;
 Q
 ;
GETDIS(LOC) ;
 ;
 ; ZEXCEPT: MMRSLOC2,STRTDT
 ;
 N TT,MOVDT,MOVIFN,DFN,TRANTYPE,OUTDATE,OUTIFN,OUTTT,INWARD,INDATE,INIFN,INTT,PREVIEN,INLOC,LOCNAME,VAIP
 N NEXTWARD,PREVWARD
 ;
 F TT=2,3 S MOVDT=STRTDT-.0000001 F  S MOVDT=$O(^DGPM("ATT"_TT,MOVDT)) Q:(MOVDT>ENDDT)!('MOVDT)  D
 . S MOVIFN="" F  S MOVIFN=$O(^DGPM("ATT"_TT,MOVDT,MOVIFN)) Q:'MOVIFN  D
 . . D KVA^VADPT S DFN=$P($G(^DGPM(MOVIFN,0)),"^",3),VAIP("E")=MOVIFN D IN5^VADPT
 . . I +VAIP(2)=3,+VAIP(15,3)=2 Q  ;Ignore discharges that are immediate following an Authorized Absence
 . . S TRANTYPE=$$TRANTYPE(+VAIP(4),+VAIP(2),VAIP(1),DFN)
 . . S NEXTWARD=$P(TRANTYPE,U,2)
 . . S TRANTYPE=$P(TRANTYPE,U,1)
 . . I NEXTWARD="" S NEXTWARD=+VAIP(5)
 . . I TRANTYPE<2 Q
 . . I TRANTYPE=2,'$$CNGWARD(LOC,+VAIP(15,4),NEXTWARD) Q
 . . I $$EXCWARD(LOC,+VAIP(15,4)) Q
 . . S OUTDATE=+VAIP(3)
 . . S OUTIFN=MOVIFN
 . . S OUTTT=TRANTYPE
 . . ;
 . . S INWARD=+VAIP(15,4)
 . . S (INDATE,INIFN,INTT)=""
 . . F  Q:(VAIP(15)="")!(INIFN)  D
 . . . S TRANTYPE=$$TRANTYPE(+VAIP(15,3),+VAIP(15,2),VAIP(15),DFN)
 . . . S PREVWARD=$P(TRANTYPE,U,2)
 . . . S PREVIEN=$P(TRANTYPE,U,3)
 . . . S TRANTYPE=$P(TRANTYPE,U,1)
 . . . I PREVIEN="" S PREVIEN=VAIP(15)
 . . . I TRANTYPE=1 S INDATE=+VAIP(15,1),INIFN=VAIP(15),INTT=1 ;,INWARD=+VAIP(15,4)
 . . . I TRANTYPE=2,'PREVWARD D
 . . . . D KVA^VADPT S VAIP("E")=PREVIEN D IN5^VADPT
 . . . . I $$CNGWARD(LOC,+VAIP(5),+VAIP(15,4)) S INDATE=+VAIP(3),INIFN=VAIP(1),INTT=2 ;,INWARD=+VAIP(16,4)
 . . . I TRANTYPE=2,PREVWARD,$$CNGWARD(LOC,PREVWARD,+VAIP(15,4)) S INDATE=+VAIP(15,1),INIFN=VAIP(15),INTT=2
 . . . Q:INIFN
 . . . D KVA^VADPT
 . . . S VAIP("E")=PREVIEN
 . . . D IN5^VADPT
 . . ;
 . . I '$G(INIFN) Q
 . . S INLOC=$G(LOC)
 . . I +INLOC=0 S INLOC=$$GETLOC(INWARD,.MMRSLOC2)
 . . S LOCNAME=$P($G(^MMRS(104.3,INLOC,0)),U)
 . . S ^TMP($J,"MMRSIPC","D",LOCNAME,INDATE,DFN,OUTDATE)=INLOC_U_DFN_U_INDATE_U_INIFN_U_INTT_U_OUTDATE_U_OUTIFN_U_OUTTT
 ;
 D KVA^VADPT
 ;
 Q
 ;
GETNODIS(LOC) ;For Discharge/Transmission report, it adds patients that have not been discharged from the wards to the report
 ;
 ; ZEXCEPT: ENDDT,MMRSLOC2
 ;
 N WARD,DFN,TMP,EDT,TT,SDT,INWARD,IEN,INDATE,INTT,INIFN,INLOC,LOCNAME,VAIP
 N PREVIEN,PREVWARD
 ;
 S WARD="" F  S WARD=$O(^DPT("CN",WARD)) Q:WARD=""  D
 . S DFN=0 F  S DFN=$O(^DPT("CN",WARD,DFN)) Q:'DFN  S TMP(DFN)=""
 ;
 S EDT=$$NOW^XLFDT
 F TT=1:1:3 S SDT=ENDDT F  S SDT=$O(^DGPM("AMV"_TT,SDT)) Q:'SDT!(SDT>EDT)  D
 . S DFN=0 F  S DFN=$O(^DGPM("AMV"_TT,SDT,DFN)) Q:'DFN  S TMP(DFN)=""
 ;
 S DFN=0 F  S DFN=$O(TMP(DFN)) Q:'DFN  D
 . D KVA^VADPT
 . S VAIP("D")=ENDDT
 . D IN5^VADPT
 . I 'VAIP(1) Q
 . S INWARD=+VAIP(5)
 . Q:$$EXCWARD(LOC,INWARD)
 . ;
 . S INTT=$$TRANTYPE(+VAIP(4),+VAIP(2),VAIP(1),DFN)
 . S PREVWARD=$P(INTT,U,2)
 . S PREVIEN=$P(INTT,U,4)
 . S INTT=$P(INTT,U,1)
 . I PREVWARD="" S PREVWARD=+VAIP(15,4)
 . I PREVIEN="" S PREVIEN=VAIP(15)
 . F  Q:(INTT=1)!(INTT=2&$$CNGWARD(LOC,+VAIP(5),PREVWARD))!(PREVIEN="")  D
 . . S IEN=+PREVIEN
 . . D KVA^VADPT
 . . S VAIP("E")=IEN
 . . D IN5^VADPT
 . . S INTT=$$TRANTYPE(+VAIP(4),+VAIP(2),VAIP(1),DFN)
 . . S PREVWARD=$P(INTT,U,2)
 . . S PREVIEN=$P(INTT,U,4)
 . . S INTT=$P(INTT,U,1)
 . . I PREVWARD="" S PREVWARD=+VAIP(15,4)
 . . I PREVIEN="" S PREVIEN=VAIP(15)
 . ;
 . I INTT<1!(INTT>2) Q
 . S INDATE=+VAIP(3)
 . S INIFN=+VAIP(1)
 . I '$G(INIFN) Q
 . S INLOC=$G(LOC)
 . I +INLOC=0 S INLOC=$$GETLOC(INWARD,.MMRSLOC2)
 . S LOCNAME=$P($G(^MMRS(104.3,INLOC,0)),U)
 . S ^TMP($J,"MMRSIPC","D",LOCNAME,INDATE,DFN," ")=INLOC_U_DFN_U_INDATE_U_INIFN_U_INTT_U_" "_U_"0"_U_" "
 ;
 D KVA^VADPT
 ;
 Q
 ;
CNGWARD(LOC,WARD1,WARD2) ;Did patient change wards?
 ;
 ; ZEXCEPT: MMRSLOC2
 ;
 I +$G(LOC)=0 S LOC=$$GETLOC(WARD1,.MMRSLOC2)
 I $D(^MMRS(104.3,LOC,1,"B",WARD1)),$D(^MMRS(104.3,LOC,1,"B",WARD2)) Q 0
 Q 1
 ;
EXCWARD(LOC,WARD) ;Is this ward excluded from the reports?
 ;
 ; ZEXCEPT: MMRSLOC2
 ;
 I +$G(LOC)=0 S LOC=$$GETLOC(WARD,.MMRSLOC2)
 I LOC=0 Q 1
 I $D(^MMRS(104.3,LOC,1,"B",WARD)) Q 0
 Q 1
 ;
DUPLOC(LOC,LCTNS) ;
 ;
 N RSLT,WARD,LOC2
 ;
 S RSLT=0
 S WARD=0 F  S WARD=$O(^MMRS(104.3,LOC,1,"B",WARD)) Q:'WARD  D
 .S LOC2=0 F  S LOC2=$O(LCTNS(LOC2)) Q:'LOC2  D
 ..Q:LOC2=LOC
 ..I $D(^MMRS(104.3,LOC2,1,"B",WARD)) S RSLT=1
 Q RSLT
 ;
GETLOC(WARD,LCTNS) ;
 ;
 N RSLT,LOC
 ;
 S RSLT=0
 S LOC=0 F  S LOC=$O(LCTNS(LOC)) Q:'LOC!(RSLT)  D
 .I $D(^MMRS(104.3,LOC,1,"B",WARD)) S RSLT=LOC
 Q RSLT
 ;
TRANTYPE(MOVTYPE,TRANTYPE,MOVIEN,DFN) ;
 ;
 I MOVTYPE=46!(MOVTYPE=5)!(MOVTYPE=6)!(MOVTYPE=7)!(MOVTYPE=47)!(MOVTYPE=27)!(MOVTYPE=33)!(MOVTYPE=3)!(MOVTYPE=22) Q -1 ;MIA/LMT - Removed MOVTYPE 29 ;4/15/10
 I MOVTYPE=42!(MOVTYPE=20)!(MOVTYPE=1)!(MOVTYPE=45)!(MOVTYPE=23)!(MOVTYPE=25)!(MOVTYPE=26) Q -1
 I MOVTYPE=2!(MOVTYPE=43)!(MOVTYPE=13) Q 3
 I MOVTYPE=14!(MOVTYPE=24)!(MOVTYPE=44) Q 1
 S TRANTYPE=$$CHKOBS(DFN,MOVIEN,TRANTYPE)
 Q TRANTYPE
 ;
CHKOBS(DFN,MOVIEN,TRANTYPE) ;
 ; Check if the patient is being discharged from a mixed observation ward (colocated with acute care
 ; patients) and being immediately admitted to acute care. If yes, we want to consider this
 ; discharge/admission as an interward transfer.
 ;
 ; ZEXCEPT: ODOBS,STRTDT
 ;
 N NEXTMOV,NEXTMOVDT,PREVMOV,PREVMOVDT,SPEC,TIMETOADM,VAIP,VAIP2
 ;
 I TRANTYPE=2 Q TRANTYPE
 ;
 S TIMETOADM=7200  ; 2HRS to allow between obs discharge and acute care admission
 ;
 D KVA^VADPT
 S VAIP("E")=MOVIEN
 D IN5^VADPT
 ;
 S SPEC=$$GET1^DIQ(45.7,+VAIP(8)_",",1,"I") ;ICR 1154 supported
 I TRANTYPE=3,+$$SPEC^DGPMOBS(SPEC)=1,'$$ONLYOBS(+VAIP(5)) D   ;ICR 2664 supported
 . S NEXTMOVDT=$O(^DGPM("APTT1",DFN,+VAIP(3)))  ;ICR 2090
 . S NEXTMOV=$O(^DGPM("APTT1",DFN,+NEXTMOVDT,0))
 . I 'NEXTMOV Q
 . D CALLIN5("VAIP2",DFN,NEXTMOV)
 . I $$FMDIFF^XLFDT(+VAIP2(3),+VAIP(3),2)<TIMETOADM D
 . . S TRANTYPE=2_U_+VAIP2(5)_U_NEXTMOV_U_VAIP2(16)
 ;
 I TRANTYPE=1 D
 . S PREVMOVDT=$O(^DGPM("APTT3",DFN,+VAIP(3)),-1)
 . S PREVMOV=$O(^DGPM("APTT3",DFN,+PREVMOVDT,0))
 . I 'PREVMOV Q
 . D CALLIN5("VAIP2",DFN,PREVMOV)
 . S SPEC=$$GET1^DIQ(45.7,+VAIP2(8)_",",1,"I") ;ICR 1154 supported
 . I +$$SPEC^DGPMOBS(SPEC)=1,'$$ONLYOBS(+VAIP2(5)),$$FMDIFF^XLFDT(+VAIP(3),+VAIP2(3),2)<TIMETOADM D
 . . S TRANTYPE=2_U_+VAIP2(5)_U_PREVMOV_U_VAIP2(15)
 . . ; In order not to double count bdoc for one-day obs patients that are admitted to acute care
 . . ; keep track of these in ODOBS for later adjustment of BDOC.
 . . ; If patient admitted and discharged from mixed obs on same calendar day
 . . ; and readmitted to acute care within two hours
 . . ; and acute care admission is same calendar day as adm/dis from obs
 . . ; and date falls within reporting period
 . . I '$G(STRTDT) Q
 . . I $P(+VAIP2(13,1),".")=$P(+VAIP2(3),"."),$P(+VAIP2(3),".")=$P(+VAIP(3),"."),(STRTDT-.000001)<+VAIP2(13,1) D  Q
 . . . S ODOBS(+VAIP2(5))=$G(ODOBS(+VAIP2(5)))+1
 . . ;
 . . ; if patient admitted to obs on one calendar day and discharged on another
 . . ; and readmitted to acute care within two hours
 . . ; and acute care admission is same calendar day as adm/dis from obs
 . . ; and admitted and discharged from acute care on same calendar day
 . . ; and date falls within reporting period
 . . ; deduct one from inpatient discharge ward
 . . I $P(+VAIP2(13,1),".")'=$P(+VAIP2(3),"."),$P(+VAIP2(3),".")=$P(+VAIP(3),"."),$P(+VAIP(3),".")=$P(+VAIP(17,1),"."),(STRTDT-.000001)<+VAIP(3) D  Q
 . . . S ODOBS(+VAIP(17,4))=$G(ODOBS(+VAIP(17,4)))+1
 ;
 Q TRANTYPE
 ;
CALLIN5(RESULT,DFN,MOVIEN) ;
 ;
 N VAIP
 ;
 S VAIP("E")=MOVIEN
 S VAIP("V")=RESULT
 D IN5^VADPT
 Q
 ;
ONLYOBS(WARD) ;
 ;
 N ONLYOBS,MMRSLOC
 ;
 S ONLYOBS=1
 ;
 S MMRSLOC=0
 F  S MMRSLOC=$O(^MMRS(104.3,MMRSLOC)) Q:'MMRSLOC!('ONLYOBS)  D
 . I '$D(^MMRS(104.3,MMRSLOC,1,"B",WARD)) Q
 . I $P($G(^MMRS(104.3,MMRSLOC,0)),U,3)?1(1"AC",1"CLC") S ONLYOBS=0
 ;
 Q ONLYOBS
