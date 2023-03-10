PXAPIIM ;ISP/LMT - PCE Immunization APIs ;Aug 05, 2021@07:18:12
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210,215,217**;Aug 12, 1996;Build 134
 ;
 ; Reference to NAME in file .85 is supported by ICR #6062
 ;
 Q
 ;
VIS(PXRESULT,PXVIS,PXDATE) ;Called from VIS^PXAPI
 ;
 ;Input:
 ;  PXRESULT  (required) Return value (passed by reference)
 ;     PXVIS  (required) Pointer to #920
 ;    PXDATE  (optional; defaults to NOW) The date in FileMan format.
 ;                       Used to check the status of the VIS on that date.
 ;Returns:
 ;  PXRESULT("NAME") = VIS Name
 ;  PXRESULT("EDITION DATE") = FileManager Internal Format for date/time
 ;  PXRESULT("EDITION STATUS") = code^value (C^CURRENT or H^HISTORIC)
 ;  PXRESULT("LANGUAGE") = IEN ^ Language (e.g., 1^ENGLISH)
 ;  PXRESULT("2D BAR CODE") = Barcode from the CDC VIS barcode lookup table
 ;  PXRESULT("VIS URL") = Internet URL for this VIS
 ;  PXRESULT("STATUS") = Status based on PXDATE (1^ACTIVE or 0^INACTIVE)
 ;
 N PXDATA,PXFILE,PXIENS,PXLANG,PXSTATUS
 ;
 S PXFILE=920
 S PXIENS=PXVIS_","
 D GETS^DIQ(PXFILE,PXIENS,"*","EI","PXDATA")
 ;
 S PXRESULT("NAME")=$G(PXDATA(PXFILE,PXIENS,.01,"E"))
 S PXRESULT("EDITION DATE")=$G(PXDATA(PXFILE,PXIENS,.02,"I"))
 S PXRESULT("EDITION STATUS")=$G(PXDATA(PXFILE,PXIENS,.03,"I"))_U_$G(PXDATA(PXFILE,PXIENS,.03,"E"))
 S PXRESULT("2D BAR CODE")=$G(PXDATA(PXFILE,PXIENS,100,"E"))
 S PXRESULT("VIS URL")=$G(PXDATA(PXFILE,PXIENS,101,"E"))
 ;
 S PXLANG=$G(PXDATA(PXFILE,PXIENS,.04,"I"))
 I PXLANG D
 . S PXLANG=PXLANG_U_$$GET1^DIQ(.85,PXLANG_",","NAME")  ;ICR 6062
 S PXRESULT("LANGUAGE")=PXLANG
 ;
 S PXSTATUS=$$GETSTAT^XTID(PXFILE,.01,PXIENS,$G(PXDATE))
 S PXRESULT("STATUS")=$P(PXSTATUS,U,1)_U_$P(PXSTATUS,U,3)
 ;
 Q
 ;
IMMGRP(PXRESULT,PXIMM) ;
 ;
 ; Returns a list of immunizations that share the same CVX code and Vaccine Group
 ; Name(s) as PXIMM, as well as Contraindications that are limited to PXIMM.
 ;
 ;Input:
 ;  PXRESULT  (required) Return value (passed by reference)
 ;     PXIMM  (required) Pointer to #9999999.14
 ;
 ;Returns:
 ;  PXRESULT("CVX",CVX_CODE,IMM_IEN) = Immunization Name
 ;  PXRESULT("VG",GROUP_NAME,IMM_IEN) = Immunization Name
 ;  PXRESULT("ICR",CONTRA_VIEN) = Contraindication Name
 ;
 I '$G(PXIMM) Q
 D IMMGRP^PXAPIIM2(.PXRESULT,.PXIMM)
 ;
 Q
 ;
SKSTAT(PXSK) ;
 ;
 ;Returns Skin Test status
 ;
 ;Input:
 ;  PXSK - (required) Pointer to #9999999.14
 ;
 ;Returns:
 ;  1: Active
 ;  0: Inactive
 ;
 I '$G(PXSK) Q ""
 Q $$GETSTAT^PXVRPC8(PXSK,DT,1,0)
 ;
IMMSTAT(PXIMM) ;
 ;
 ;Returns Immunization status
 ;
 ;Input:
 ;  PXIMM - (required) Pointer to #9999999.14
 ;
 ;Returns:
 ;  A: Active
 ;  H: Inactive, but Selectable for Historic
 ;  I: Inactive
 ;
 I '$G(PXIMM) Q ""
 I '$D(^AUTTIMM(PXIMM)) Q ""
 I $P($G(^AUTTIMM(PXIMM,0)),U,7)="" Q "A"
 I $P($G(^AUTTIMM(PXIMM,6)),U,1)="Y" Q "H"
 Q "I"
 ;
IMMNODEF() ; Returns "IMMUNIZATION, NO DEFAULT SELECTED" entry
 N PXIMM
 S PXIMM=$O(^AUTTIMM("AVUID",5237389,0))
 I 'PXIMM S PXIMM=$O(^AUTTIMM("B","IMMUNIZATION, NO DEFAULT SELECTED",0))
 Q PXIMM
 ;
IMMBYNM(PXNAME) ; Finds Immunization that matches on PXNAME and returns IEN
 N PXIMM
 I $G(PXNAME)="" Q 0
 S PXIMM=$O(^AUTTIMM("B",PXNAME,0))
 I PXIMM Q PXIMM
 S PXIMM=$O(^AUTTIMM("G",PXNAME,0))
 I PXIMM Q PXIMM
 S PXIMM=$O(^AUTTIMM("H",PXNAME,0))
 I PXIMM Q PXIMM
 Q 0
 ;
PATICR(PXRESULT,DFN,PXIMM,PXBDT,PXEDT) ;
 ;
 ; Finds all of a patient's contraindications/refusals using the following criteria:
 ;   1. Any current-dated contraindication/refusal for PXIMM AND any immunization
 ;      that shares the same CVX code.
 ;   2. If the Refused Vaccine Group (#1205) is set to Yes, then include any
 ;      current-dated refusals for an immunization that shares the same vaccine
 ;      group as PXIMM.
 ;   3. Any current-dated contraindications where the contraindication has PXIMM
 ;      listed in the "Immunization Limited To" multiple.
 ;   4. Any current-dated contraindications where the contraindication does not have
 ;      anything listed in the "Immunization Limited To" multiple, excluding Severe
 ;      Reaction Previous Dose.
 ;
 ;   * If PXBDT and PXEDT are null, then "current-dated" means where STOP >= TODAY.
 ;   * If PXBDT and PXEDT are defined, then "current-dated" means where START
 ;     <= PXEDT, and STOP is >= PXBDT.
 ;
 ;Input:
 ;  PXRESULT - (required) Return value (passed by reference)
 ;       DFN - (required) Pointer to #2
 ;     PXIMM - (required) Pointer to #9999999.14
 ;     PXBDT - (optional; defaults to TODAY) Begin Search Date
 ;     PXEDT - (optional; defaults to 9999999) End Search Date
 ;
 ;Returns:
 ;  PXRESULT(DAS) = Visit IEN ^ Contra/Refusal variable pointer | Contra/Refusal Name
 ;                  ^ Immunization IEN | Name ^ Warn Until Date ^ D/T Recorded ^ Event D/T
 ;                  ^ Encounter Provider IEN | Name ^ Refused Vaccine Group (1/0)
 ;  PXRESULT(DAS,"COMMENTS") = Comments
 ; When the entry is from IMM CONTRAINDICATION REASONS this is defined:
 ;  PXRESULT(DAS,"CONTRAINDICATION/PRECAUTION")=CONTRAINDICATION/PRECAUTION
 ;
 ;  * DAS = Pointer to #9000010.707
 ;
 N PXCVX,PXDAS,PXDATA,PXFILE,PXICR,PXIMMB,PXIMMGRP,PXSEARCH,PXSEARCHBY,PXSUB,PXVGN,PXX
 ;
 I '$G(DFN)!('$G(PXIMM)) Q
 ;
 S PXFILE=9000010.707
 ;
 I $G(PXEDT)="" S PXEDT=9999999
 I $G(PXBDT)="" S PXBDT=DT
 I PXBDT S PXBDT=PXBDT-.0000001
 ;
 D IMMGRP(.PXIMMGRP,PXIMM)
 ;
 ; >> Search based off criteria #1 & #2:
 ;
 ; PXSEARCH("ALL") - assists in searching based off criteria #1
 S PXSEARCH("ALL",PXIMM)=""
 S PXCVX=$O(PXIMMGRP("CVX",""))
 I PXCVX'="" D
 . S PXIMMB=0
 . F  S PXIMMB=$O(PXIMMGRP("CVX",PXCVX,PXIMMB)) Q:'PXIMMB  D
 . . S PXSEARCH("ALL",PXIMMB)=""
 ;
 ; PXSEARCH("REFUSALS") - assists in searching based off criteria #2
 S PXVGN=""
 F  S PXVGN=$O(PXIMMGRP("VG",PXVGN)) Q:PXVGN=""  D
 . S PXIMMB=0
 . F  S PXIMMB=$O(PXIMMGRP("VG",PXVGN,PXIMMB)) Q:'PXIMMB  D
 . . I '$D(PXSEARCH("ALL",PXIMMB)) S PXSEARCH("REFUSALS",PXIMMB)=""
 ;
 F PXSEARCHBY="ALL","REFUSALS" D
 . S PXIMMB=0
 . F  S PXIMMB=$O(PXSEARCH(PXSEARCHBY,PXIMMB)) Q:'PXIMMB  D
 . . S PXICR=""
 . . F  S PXICR=$O(^PXRMINDX(PXFILE,"PIC",DFN,PXIMMB,PXICR)) Q:'PXICR  D
 . . . I PXSEARCHBY="REFUSALS",PXICR'[920.5 Q
 . . . S PXSUB(1)=PXFILE,PXSUB(2)="PIC",PXSUB(3)=DFN,PXSUB(4)=PXIMMB,PXSUB(5)=PXICR
 . . . D SEARCH(.PXRESULT,.PXSUB,.PXBDT,.PXEDT,PXSEARCHBY)
 ;
 ; >> Search based off criteria #3 & #4:
 ;
 S PXICR=""
 F  S PXICR=$O(PXIMMGRP("ICR",PXICR)) Q:'PXICR  D
 . S PXIMMB=0
 . F  S PXIMMB=$O(^PXRMINDX(PXFILE,"PCI",DFN,PXICR,PXIMMB)) Q:'PXIMMB  D
 . . S PXSUB(1)=PXFILE,PXSUB(2)="PCI",PXSUB(3)=DFN,PXSUB(4)=PXICR,PXSUB(5)=PXIMMB
 . . D SEARCH(.PXRESULT,.PXSUB,.PXBDT,.PXEDT)
 ;
 ; >> Setup return array fields:
 S PXDAS=0
 F  S PXDAS=$O(PXRESULT(PXDAS)) Q:'PXDAS  D
 . K PXDATA
 . D VICR^PXPXRM(PXDAS,.PXDATA)
 . S PXX=$G(PXDATA("VISIT"))
 . S PXX=PXX_U_$P($G(PXDATA("CONTRA/REFUSAL")),U,1)_"|"_$P($G(PXDATA("CONTRA/REFUSAL")),U,2)
 . S PXX=PXX_U_$P($G(PXDATA("IMMUN")),U,1)_"|"_$P($G(PXDATA("IMMUN")),U,2)
 . S PXX=PXX_U_$G(PXDATA("WARN UNTIL DATE"))
 . S PXX=PXX_U_$G(PXDATA("D/T RECORDED"))
 . S PXX=PXX_U_$G(PXDATA("EVENT D/T"))
 . S PXX=PXX_U_$P($G(PXDATA("ENC PROVIDER")),U,1)_"|"_$P($G(PXDATA("ENC PROVIDER")),U,2)
 . S PXX=PXX_U_$G(PXDATA("REFUSED VACCINE GROUP"))
 . S PXRESULT(PXDAS)=PXX
 . I $G(PXDATA("CONTRAINDICATION/PRECAUTION"))'="" S PXRESULT(PXDAS,"CONTRAINDICATION/PRECAUTION")=PXDATA("CONTRAINDICATION/PRECAUTION")
 . S PXRESULT(PXDAS,"COMMENTS")=$G(PXDATA("COMMENTS"))
 Q
 ;
SEARCH(PXRESULT,PXSUB,PXBDT,PXEDT,PXSEARCHBY) ; Helper function for PATICR
 ;
 N PXDAS,PXSTART,PXSTOP
 ;
 S PXSTART=0
 F  S PXSTART=$O(^PXRMINDX(PXSUB(1),PXSUB(2),PXSUB(3),PXSUB(4),PXSUB(5),PXSTART)) Q:'PXSTART!(PXEDT<PXSTART)  D
 . S PXSTOP=PXBDT
 . F  S PXSTOP=$O(^PXRMINDX(PXSUB(1),PXSUB(2),PXSUB(3),PXSUB(4),PXSUB(5),PXSTART,PXSTOP)) Q:'PXSTOP  D
 . . S PXDAS=0
 . . F  S PXDAS=$O(^PXRMINDX(PXSUB(1),PXSUB(2),PXSUB(3),PXSUB(4),PXSUB(5),PXSTART,PXSTOP,PXDAS)) Q:'PXDAS  D
 . . . ; If refusal is only for this vaccine, quit
 . . . I $G(PXSEARCHBY)="REFUSALS",$P($G(^AUPNVICR(PXDAS,12)),U,5)=0 Q
 . . . S PXRESULT(PXDAS)=""
 ;
 Q
 ;
SITES(PXRSLT,PXROUTE,PXSORTBY) ;
 ;
 ;Returns list of selectable Sites for a given Route
 ;
 ;Input:
 ;   PXROUTE - (required) Pointer to #920.2
 ;  PXSORTBY - (optional; defaults to "N")
 ;                 "N" - Sort by Name
 ;                 "R" - Sort by IEN
 ;
 ;Returns:
 ; - If only a subset of sites are selectable for this route,
 ;   that list will be returned in PXRSLT.
 ;    o If PXSORTBY="N" - PXRSLT(Site_Name)=920_3_IEN ^ HL7 Code
 ;    o If PXSORTBY="R" - PXRSLT(920_3_IEN)=Site_Name ^ HL7 Code
 ; - If all sites are selectable for this route, the API will return:
 ;   PXRSLT("ALL")=""
 ; - If no sites are selectable for this route, the API will return:
 ;   PXRSLT("NONE")=""
 ;
 N PXI,PXSITE,PXSITEHL,PXSITENM
 ;
 I '$G(PXROUTE) Q
 I '$D(^PXV(920.2,PXROUTE,0)) Q
 I $G(PXSORTBY)'?1(1"N",1"R") S PXSORTBY="N"
 ;
 I $D(^PXV(920.6,PXROUTE)) D
 . S PXI=0
 . F  S PXI=$O(^PXV(920.6,PXROUTE,1,PXI)) Q:'PXI  D
 . . S PXSITE=$P($G(^PXV(920.6,PXROUTE,1,PXI,0)),U,1)
 . . S PXSITENM=$P($G(^PXV(920.3,+PXSITE,0)),U,1)
 . . S PXSITEHL=$P($G(^PXV(920.3,PXSITE,0)),U,2)
 . . I PXSITENM="" Q
 . . I PXSORTBY="N" S PXRSLT(PXSITENM)=PXSITE_U_PXSITEHL
 . . I PXSORTBY="R" S PXRSLT(PXSITE)=PXSITENM_U_PXSITEHL
 . ;
 . ; if this route exists in 920.6, but is not mapped to any sites
 . ; then no sites should be selectable for this route (e.g., Oral)
 . I '$D(PXRSLT) S PXRSLT("NONE")=""
 ;
 ; If no mapping exists, all entries are selectable
 I '$D(^PXV(920.6,PXROUTE)) D
 . S PXRSLT("ALL")=""
 ;
 Q
 ;
IMMDEF(PXRSLT,PXIMM,PXINST) ;
 ;
 N PXIEN,PXPRNT,PXSTA,PXUNITS,PXNUNITS,PXUCUM
 ;
 I '$G(PXIMM)!('$G(PXINST)) Q
 I $D(PXINST(PXINST)) Q  ; Used to prevent infinite recursion
 ;
 S PXIEN=$O(^PXV(920.05,"AC",PXINST,PXIMM,0))
 ;
 I PXIEN D
 . M PXRSLT=^PXV(920.05,PXIEN,1,PXIMM)
 ;
 ; If site did not create defaults, make recursive
 ; call for parent Institution; if parent has defaults,
 ; inherit from parent.
 I 'PXIEN D
 . S PXSTA=$$STA^XUAF4(PXINST)
 . I PXSTA="" Q
 . S PXPRNT=$$PRNT^XUAF4(PXSTA)
 . ;
 . ; If parent = self, we reached the top of the chain
 . I $P(PXPRNT,U,2)=PXSTA Q
 . I (+PXPRNT)=PXINST Q
 . I 'PXPRNT Q
 . ;
 . ; Used to prevent infinite recursion
 . S PXINST(PXINST)=""
 . ;
 . S PXINST=+PXPRNT
 . D IMMDEF(.PXRSLT,PXIMM,.PXINST)
 ;
 S PXUNITS=$P($G(PXRSLT(13)),U,13)
 S PXNUNITS=$P($G(PXRSLT(13)),U,14)
 I PXUNITS="",PXNUNITS="" D  ; default to mL unless overriden by imm default response
 . K PXUCUM
 . D UCUMDATA^LEXMUCUM("mL",.PXUCUM)
 . S PXUNITS=$O(PXUCUM(0))
 . I PXUNITS S $P(PXRSLT(13),U,13)=PXUNITS
 ;
 Q
 ;
 ;
HIST(PXRESULTS,PXTYPE,PXIENLST,DFN,PXDIR) ;
 ;
 ; Return patient's immunization or skin test history for a given
 ; list of immunizations or skin tests.
 ;
 ; Inputs:
 ;     PXTYPE = "SK": for Skin Tests
 ;              "IM": For Immunizations
 ;   PXIENLST = List of IENs from the Immunization/Skin Test file (passed by reference).
 ;              PXIENLST(IEN)=""
 ;        DFN = Patient (#2) IEN
 ;      PXDIR = Sort order.
 ;              1: Most recent first
 ;              0: Oldest first
 ;
 ; Returns:
 ;    For Immunizations:
 ;       PXRESULTS(n)=Immunization Name ^ Date Administered ^ Series ^ Facility
 ;    For Skin Tests:
 ;       PXRESULTS(n)=Skin Test Name ^ Date Admin ^ Date Read ^ Reading ^ Result ^ Facility
 ;
 N PXCNT,PXDAS,PXDATE,PXFILE,PXIEN,PXSUB,PXTMP
 ;
 S PXFILE=$S($G(PXTYPE)="SK":9000010.12,1:9000010.11)
 ;
 S PXIEN=0
 F  S PXIEN=$O(PXIENLST(PXIEN)) Q:'PXIEN  D
 . S PXDATE=0
 . F  S PXDATE=$O(^PXRMINDX(PXFILE,"PI",DFN,PXIEN,PXDATE)) Q:'PXDATE  D
 . . S PXDAS=0
 . . F  S PXDAS=$O(^PXRMINDX(PXFILE,"PI",DFN,PXIEN,PXDATE,PXDAS)) Q:'PXDAS  D
 . . . S PXSUB=PXDATE
 . . . I $G(PXDIR) S PXSUB=9999999-PXDATE
 . . . S PXTMP(PXSUB,PXDAS)=PXDATE
 ;
 S PXCNT=0
 S PXSUB=""
 F  S PXSUB=$O(PXTMP(PXSUB)) Q:PXSUB=""  D
 . S PXDAS=0
 . F  S PXDAS=$O(PXTMP(PXSUB,PXDAS)) Q:'PXDAS  D
 . . S PXDATE=$G(PXTMP(PXSUB,PXDAS))
 . . I PXFILE=9000010.11 D ADDIMM(.PXRESULTS,.PXCNT,PXDAS,PXDATE)
 . . I PXFILE=9000010.12 D ADDSK(.PXRESULTS,.PXCNT,PXDAS)
 ;
 Q
 ;
ADDIMM(PXRESULT,PXCNT,PXDAS,PXDATE) ;
 N PXIMM,PXFAC,PXVISIT
 D VIMM^PXPXRM(PXDAS,.PXIMM)
 S PXCNT=PXCNT+1
 S PXFAC=$P(PXIMM("FACILITY"),U,2)
 I PXFAC="" D
 . S PXVISIT=$P($G(^AUPNVIMM(+PXDAS,0)),U,3)
 . I 'PXVISIT Q
 . S PXFAC=$P($G(^AUPNVSIT(PXVISIT,21)),U,1)
 S PXRESULT(PXCNT)=$P(PXIMM("IMMUNIZATION"),U,2)_U_PXDATE_U_PXIMM("SERIES")_U_PXFAC
 Q
 ;
ADDSK(PXRESULT,PXCNT,PXDAS) ;
 N PXDATE,PXSK
 D VSKIN^PXPXRM(PXDAS,.PXSK)
 S PXDATE=$G(PXSK("EVENT DATE AND TIME"))
 I 'PXDATE S PXDATE=PXSK("PLACEMENT VISIT DATE TIME")
 I 'PXDATE S PXDATE=PXSK("VISIT DATE TIME")
 S PXCNT=PXCNT+1
 S PXRESULT(PXCNT)=$P(PXSK("SKIN TEST"),U,2)_U_PXDATE_U_PXSK("DATE READ")_U_PXSK("READING")_U_PXSK("RESULTS")_U_$P(PXSK("FACILITY"),U,2)
 Q
 ;
READVALS(PXRESULT) ;return data type for reading fields
 N PXCODE,PXCODES,PXI
 ;
 S PXRESULT("RANGE")="0:40:0" ;Minimum:Maximum:Maximum decimals
 ;
 S PXCODES=$$GET1^DID(9000010.11,1401,"","SET OF CODES")
 F PXI=1:1 S PXCODE=$P(PXCODES,";",PXI) Q:PXCODE=""  D
 . S PXRESULT("CODES",PXCODE)=""
 ;
 Q
 ;
READENT(PXRESULT,DFN) ;
 ; Find most recent immunization admin for vaccine that requires reading.
 ; Only return if there is no reading entered previously.
 ;
 N PXDATE,PXIMM,PXNAME,PXTEMP,PXVIMM,PXVIMM14
 ;
 S PXRESULT(1)=""
 ;
 ; Get all V Imm entries for immunizations that require reading (currently only Smallpox)
 S PXIMM=0
 F  S PXIMM=$O(^AUTTIMM(PXIMM)) Q:'PXIMM  D
 . I '$P($G(^AUTTIMM(PXIMM,.5)),U,1) Q
 . S PXDATE=$O(^PXRMINDX(9000010.11,"PI",DFN,PXIMM,""),-1)
 . I 'PXDATE Q
 . S PXVIMM=$O(^PXRMINDX(9000010.11,"PI",DFN,PXIMM,PXDATE,0))
 . I 'PXVIMM Q
 . S PXTEMP(PXDATE,PXVIMM)=PXIMM
 ;
 ; find most recent admin
 S PXDATE=$O(PXTEMP(""),-1)
 I 'PXDATE Q
 S PXVIMM=$O(PXTEMP(PXDATE,0))
 I 'PXVIMM Q
 ;
 S PXIMM=PXTEMP(PXDATE,PXVIMM)
 S PXVIMM14=$G(^AUPNVIMM(PXVIMM,14))
 ; if both Reading and Results are populated, quit
 I $P(PXVIMM14,U,1)'="",$P(PXVIMM14,U,2)'="" Q
 ;
 S PXNAME=$P($G(^AUTTIMM(PXIMM,0)),U,1)
 S PXRESULT(1)=PXVIMM_U_PXNAME_U_PXDATE
 ;
 Q
 ;
GETLOT(PXRTRN,PXIMM,PXDATE,PXLOC) ;
 ;
 ; Get active lots for a given immunization
 ;
 ;  PXIMM - Immunization IEN or C:CVX Code
 ; PXDATE - Date (Optional; Defaults to NOW)
 ;  PXLOC - Used to determine Institution (Optional)
 ;           Possible values are:
 ;             "I:X": Institution (#4) IEN #X
 ;             "V:X": Visit (#9000010) IEN #X
 ;             "L:X": Hopital Location (#44) IEN #X
 ;           If PXLOC is not passed in OR could not make determination based off
 ;           input, then default to DUZ(2), and if DUZ(2) is not defined,
 ;           default to Default Institution.
 ;
 ;
 N PXCNT,PXCVX,PXINST,PXSUB
 ;
 S PXIMM=$G(PXIMM)
 I $E(PXIMM,1)="C" D
 . S PXCVX=$P(PXIMM,":",2)
 . I PXCVX="" Q
 . D CVXTOIEN(.PXIMM,PXCVX)
 . S PXIMM=$P(PXIMM,U,1)
 ;
 I ('PXIMM)!('$D(^AUTTIMM(+PXIMM,0))) D  Q
 . S PXRTRN(0)="-1^Immunization entry not found."
 ;
 I '$G(PXDATE) S PXDATE=$$NOW^XLFDT()
 S PXINST=$$INST^PXVUTIL($G(PXLOC))
 ;
 S PXSUB="PXVIMM"
 K ^TMP(PXSUB,$J)
 D GETLOT^PXVRPC4(PXSUB,PXIMM,PXDATE,PXINST)
 M PXRTRN=^TMP(PXSUB,$J,"LOT")
 K ^TMP(PXSUB,$J)
 ;
 S PXCNT=+$O(PXRTRN(""),-1)
 S PXRTRN(0)=PXCNT
 ;
 Q
 ;
CVXTOIEN(PXRSLT,PXCVX) ;
 ;
 ; Return an Immunization IEN for a given CVX code.
 ;
 ;Input:
 ;    PXCVX - A CVX code
 ;
 ;Returns:
 ; If a match is found:
 ;   PXRSLT=Immunization IEN ^ Name ^ Status  (1: Active; 0: Inactive) ^ Selectable for Historic
 ; Else:
 ;   PXRSLT=""
 ;
 N PXCLASS,PXIMM,PXNAME,PXSELHIST,PXSTATUS
 ;
 S PXRSLT=""
 I $G(PXCVX)="" Q
 S PXIMM=0
 F  S PXIMM=$O(^AUTTIMM("C",PXCVX,PXIMM)) Q:'PXIMM  D
 . S PXCLASS=$P($G(^AUTTIMM(PXIMM,100)),U,1)
 . I PXCLASS'="N" Q
 . S PXSELHIST=$P($G(^AUTTIMM(PXIMM,6)),U,1)
 . I PXSELHIST="Y"!(PXRSLT="") S PXRSLT=PXIMM
 ;
 I PXRSLT D
 . S PXNAME=$P($G(^AUTTIMM(PXRSLT,0)),U,1)
 . S PXSELHIST=$P($G(^AUTTIMM(PXRSLT,6)),U,1)
 . S PXSTATUS='$P($G(^AUTTIMM(PXRSLT,0)),U,7)
 . S PXRSLT=PXRSLT_U_PXNAME_U_PXSTATUS_U_PXSELHIST
 ;
 Q
 ;
 ;
ISIMMSEL(PXRSLT,PXIMM,PXDATE,PXLOC,PXHIST) ;
 ;
 ; Is this immunization selectable for the given encounter?
 ;
 ;  PXIMM - Immunization IEN or C:CVX Code
 ; PXDATE - Date (Optional; Defaults to NOW)
 ;  PXLOC - Used to determine Institution (Optional)
 ;           Possible values are:
 ;             "I:X": Institution (#4) IEN #X
 ;             "V:X": Visit (#9000010) IEN #X
 ;             "L:X": Hopital Location (#44) IEN #X
 ;           If PXLOC is not passed in OR could not make determination based off
 ;           input, then default to DUZ(2), and if DUZ(2) is not defined,
 ;           default to Default Institution.
 ;  PXHIST - Is this a historical encounter (1:Yes; 0: No) (Optional; Defaults to No)
 ;
 ;Returns:
 ;   PXRSLT= 1:If Immunization is selectable; 0: otherwise
 ;           For non-historical: Immunization must be active and have selectable lots,
 ;           for it to be selectable;
 ;           For historical: As long as immunization is Active or Inactive, but Selectable for Historic,
 ;           it is selectable.
 ;
 N PXCVX,PXLOTS,PXSTATUS
 ;
 S PXRSLT=0
 ;
 I '$G(PXDATE) S PXDATE=$$NOW^XLFDT()
 I '$G(PXHIST) S PXHIST=0
 S PXIMM=$G(PXIMM)
 I $E(PXIMM,1)="C" D
 . S PXCVX=$P(PXIMM,":",2)
 . I PXCVX="" Q
 . D CVXTOIEN(.PXIMM,PXCVX)
 . S PXIMM=$P(PXIMM,U,1)
 ;
 I ('PXIMM)!('$D(^AUTTIMM(+PXIMM,0))) Q
 ;
 S PXSTATUS=$$IMMSTADT(PXIMM,PXDATE)
 ;
 ; If historical, Quit
 ; Return 1 if imm is active or sel for historical
 I PXHIST D  Q
 . I PXSTATUS?1(1"A",1"H") S PXRSLT=1
 ;
 ; for non-historical, return 0 if imm is inactive
 I PXSTATUS'="A" Q
 ;
 ; return 1, if there are lots; 0 otherwise
 D GETLOT(.PXLOTS,PXIMM,PXDATE,$G(PXLOC))
 I $O(PXLOTS(0)) S PXRSLT=1
 ;
 Q
 ;
 ;
 ;
IMMSTADT(PXIMM,PXDATE) ;
 ;
 ;Returns Immunization status for a given date
 ;
 ;Input:
 ;  PXIMM - (required) Pointer to #9999999.14
 ; PXDATE - Date (Optional; Defaults to NOW)
 ;
 ;Returns:
 ;  A: Active
 ;  H: Inactive, but Selectable for Historic
 ;  I: Inactive
 ;
 N PXAUDIT,PXSTATUS
 ;
 I '$G(PXIMM) Q ""
 I '$D(^AUTTIMM(PXIMM)) Q ""
 ;
 I '$G(PXDATE) S PXDATE=$$NOW^XLFDT()
 S PXAUDIT=0
 I $$GET1^DID(9999999.14,.07,"","AUDIT")="YES, ALWAYS" S PXAUDIT=1
 S PXSTATUS=$$GETSTAT^PXVRPC4(PXIMM,PXDATE,$$GETCSTAT^PXVRPC4(PXDATE,PXAUDIT),PXAUDIT)
 ;
 I PXSTATUS Q "A"
 I $P($G(^AUTTIMM(PXIMM,6)),U,1)="Y" Q "H"
 Q "I"
 ;
