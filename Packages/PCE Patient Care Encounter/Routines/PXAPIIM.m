PXAPIIM ;BP/LMT - PCE Immunization APIs ;04/20/16  10:00
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210,215**;Aug 12, 1996;Build 10
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
 N PXCODE,PXCVX,PXICRIEN,PXICRNAME,PXIMMB,PXNAME,PXVGIEN,PXVGNAME
 ;
 I '$G(PXIMM) Q
 ;
 S PXNAME=$P($G(^AUTTIMM(PXIMM,0)),U,1)
 ;
 S PXCVX=$P($G(^AUTTIMM(PXIMM,0)),U,3)
 I PXCVX'="" D
 . S PXIMMB=0
 . F  S PXIMMB=$O(^AUTTIMM("C",PXCVX,PXIMMB)) Q:'PXIMMB  D
 . . S PXNAME=$P($G(^AUTTIMM(PXIMMB,0)),U,1)
 . . S PXRESULT("CVX",PXCVX,PXIMMB)=PXNAME
 ;
 S PXVGIEN=0
 F  S PXVGIEN=$O(^AUTTIMM(PXIMM,7,PXVGIEN)) Q:'PXVGIEN  D
 . S PXVGNAME=$P($G(^AUTTIMM(PXIMM,7,PXVGIEN,0)),U,1)
 . I PXVGNAME="" Q
 . S PXIMMB=0
 . F  S PXIMMB=$O(^AUTTIMM("I",PXVGNAME,PXIMMB)) Q:'PXIMMB  D
 . . S PXNAME=$P($G(^AUTTIMM(PXIMMB,0)),U,1)
 . . S PXRESULT("VG",PXVGNAME,PXIMMB)=PXNAME
 ;
 S PXICRIEN=0
 F  S PXICRIEN=$O(^PXV(920.4,PXICRIEN)) Q:'PXICRIEN  D
 . S PXICRNAME=$P($G(^PXV(920.4,PXICRIEN,0)),U,1)
 . ;
 . ; If this imm is listed in the Immunizations Limited To
 . ; multiple, include it
 . I $O(^PXV(920.4,PXICRIEN,3,"B",PXIMM,0)) D  Q
 . . S PXRESULT("ICR",PXICRIEN_";PXV(920.4,")=PXICRNAME
 . ;
 . ; Include all contras that don't have the Immunizations
 . ; Limited To multiple populated, except Severe Reaction
 . ; Previous Dose
 . I '$O(^PXV(920.4,PXICRIEN,3,0)) D  Q
 . . S PXCODE=$P($G(^PXV(920.4,PXICRIEN,0)),U,2)
 . . I (PXICRNAME="SEVERE REACTION PREVIOUS DOSE")!(PXCODE="VXC20") Q
 . . S PXRESULT("ICR",PXICRIEN_";PXV(920.4,")=PXICRNAME
 ;
 Q
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
 ;   2. Any current-dated refusals for an immunization that shares the same vaccine
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
 ;                  ^ Encounter Provider IEN | Name
 ;  PXRESULT(DAS,"COMMENTS") = Comments
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
 . . . D SEARCH(.PXRESULT,.PXSUB,.PXBDT,.PXEDT)
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
 . D VICR^PXPXRM(PXDAS,.PXDATA)
 . S PXX=$G(PXDATA("VISIT"))
 . S PXX=PXX_U_$P($G(PXDATA("CONTRA/REFUSAL")),U,1)_"|"_$P($G(PXDATA("CONTRA/REFUSAL")),U,2)
 . S PXX=PXX_U_$P($G(PXDATA("IMMUN")),U,1)_"|"_$P($G(PXDATA("IMMUN")),U,2)
 . S PXX=PXX_U_$G(PXDATA("WARN UNTIL DATE"))
 . S PXX=PXX_U_$G(PXDATA("D/T RECORDED"))
 . S PXX=PXX_U_$G(PXDATA("EVENT D/T"))
 . S PXX=PXX_U_$P($G(PXDATA("ENC PROVIDER")),U,1)_"|"_$P($G(PXDATA("ENC PROVIDER")),U,2)
 . S PXRESULT(PXDAS)=PXX
 . S PXRESULT(PXDAS,"COMMENTS")=$G(PXDATA("COMMENTS"))
 ;
 Q
 ;
SEARCH(PXRESULT,PXSUB,PXBDT,PXEDT) ; Helper function for PATICR
 ;
 N PXDAS,PXSTART,PXSTOP
 ;
 S PXSTART=0
 F  S PXSTART=$O(^PXRMINDX(PXSUB(1),PXSUB(2),PXSUB(3),PXSUB(4),PXSUB(5),PXSTART)) Q:'PXSTART!(PXEDT<PXSTART)  D
 . S PXSTOP=PXBDT
 . F  S PXSTOP=$O(^PXRMINDX(PXSUB(1),PXSUB(2),PXSUB(3),PXSUB(4),PXSUB(5),PXSTART,PXSTOP)) Q:'PXSTOP  D
 . . S PXDAS=0
 . . F  S PXDAS=$O(^PXRMINDX(PXSUB(1),PXSUB(2),PXSUB(3),PXSUB(4),PXSUB(5),PXSTART,PXSTOP,PXDAS)) Q:'PXDAS  D
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
 N PXIEN,PXPRNT,PXSTA
 ;
 I '$G(PXIMM)!('$G(PXINST)) Q
 I $D(PXINST(PXINST)) Q  ; Used to prevent infinite recursion
 ;
 S PXIEN=$O(^PXV(920.05,"AC",PXINST,PXIMM,0))
 ;
 I PXIEN D  Q
 . M PXRSLT=^PXV(920.05,PXIEN,1,PXIMM)
 ;
 ; If site did not create defaults, make recursive
 ; call for parent Institution; if parent has defaults,
 ; inherit from parent.
 I 'PXIEN D  Q
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
 Q
