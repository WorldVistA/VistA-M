IBCNES1 ;ALB/ESG/JM - eIV elig/benefit utilities ;01/13/2016
 ;;2.0;INTEGRATED BILLING;**416,438,497,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EB(IBVF,IBVIENS,IBVV,IBVSUB) ; Main Eligibility/Benefit Information
 ;
 ;    IBVF = file# 2.322 or 365.02
 ; IBVIENS = std IENS list of internal entry numbers
 ;    IBVV = video attributes flag
 ;  IBVSUB = display scratch global subscript
 ;
 N EB,EBERR,DSP,LN,COL1,COL2,ZF,ZIEN
 D GETS^DIQ(IBVF,IBVIENS,".02:.13;8*;11*","IEN","EB","EBERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 ;
 S COL1=2,COL2=40
 ;
 S LN=LN+1
 D SET(LN,1,"Eligibility/Benefit Information",,IBVV)
 ;
 S LN=LN+1
 D SET(LN,COL1,"Elig/Ben Info",$P($G(^IBE(365.011,+$G(EB(IBVF,IBVIENS,.02,"I")),0)),U,2))
 D SET(.LN,COL2,"Coverage Level",$P($G(^IBE(365.012,+$G(EB(IBVF,IBVIENS,.03,"I")),0)),U,2))
 ;
 ; now loop through and display all of the dates and date qualifiers
 S ZF=2.3228
 I IBVF=365.02 S ZF=365.28     ; subscriber dates subfile#
 I '$D(EB(ZF)) S EB(ZF,1)=""   ; so the fields display once
 S ZIEN="" F  S ZIEN=$O(EB(ZF,ZIEN)) Q:ZIEN=""  D
 . N HLDT,DTYP,EXDT
 . S LN=LN+1
 . D SET(LN,COL1,"Date/Time Qual",$P($G(^IBE(365.026,+$G(EB(ZF,ZIEN,.03,"I")),0)),U,2))
 . S HLDT=$G(EB(ZF,ZIEN,.02,"E"))
 . S DTYP=$G(EB(ZF,ZIEN,.04,"E"))           ;IB*2.0*549 changed "I" to "E"
 . S EXDT=$S(DTYP="D8":$$DATE(HLDT),DTYP="RD8":($$DATE($P(HLDT,"-",1))_"-"_$$DATE($P(HLDT,"-",2))),1:HLDT)
 . D SET(.LN,COL2,"D/T Period",EXDT)
 . Q
 ; loop through service type codes
 S ZF=2.32292
 I IBVF=365.02 S ZF=365.292  ; service types subfile#
 I '$D(EB(ZF)) S EB(ZF,1)=""   ; so the fields display once
 S ZIEN="" F  S ZIEN=$O(EB(ZF,ZIEN)) Q:ZIEN=""  S LN=LN+1 D SET(LN,COL1,"Service Type",$P($G(^IBE(365.013,+$G(EB(ZF,ZIEN,.01,"I")),0)),U,2))
 ;
 S LN=LN+1
 D SET(LN,COL1,"Time Period",$P($G(^IBE(365.015,+$G(EB(IBVF,IBVIENS,.07,"I")),0)),U,2))
 ;
 S LN=LN+1
 D SET(LN,COL1,"Insurance Type",$P($G(^IBE(365.014,+$G(EB(IBVF,IBVIENS,.05,"I")),0)),U,2))
 ;
 S LN=LN+1
 D SET(LN,COL1,"Plan Coverage Desc",$G(EB(IBVF,IBVIENS,.06,"E")))
 ;
 S LN=LN+1
 D SET(LN,COL1,"Benefit Amount",$G(EB(IBVF,IBVIENS,.08,"E")))
 D SET(.LN,COL2,"Benefit %",$G(EB(IBVF,IBVIENS,.09,"E")))
 ;
 S LN=LN+1
 D SET(LN,COL1,"Quantity Qual",$P($G(^IBE(365.016,+$G(EB(IBVF,IBVIENS,.1,"I")),0)),U,2))
 D SET(.LN,COL2,"Quantity Amount",$G(EB(IBVF,IBVIENS,.11,"E")))
 ;
 S LN=LN+1
 D SET(LN,COL1,"Auth/Certification Required",$P($G(^IBE(365.033,+$G(EB(IBVF,IBVIENS,.12,"I")),0)),U,2))  ;IB*2*497
 D SET(.LN,COL2,"In-Plan-Network",$P($G(^IBE(365.033,+$G(EB(IBVF,IBVIENS,.13,"I")),0)),U,2)) ;IB*2*497
 ;
 S LN=LN+1
 D SET(LN)
 ;
EBX ;
 Q
 ;
CMPI(IBVF,IBVIENS,IBVV,IBVSUB) ; Composite Medical Procedure Information
 ;
 ;    IBVF = file# 2.322 or 365.02
 ; IBVIENS = std IENS list of internal entry numbers
 ;    IBVV = video attributes flag
 ;  IBVSUB = display scratch global subscript
 ;
 N CMPI,CMPIERR,DSP,LN,COL1,COL2,PCTYP,PCODE,PCIEN,PCDESC,MODLST,FCZ,PM,ZF,ZIEN,POS,POSD,DX,DXD
 D GETS^DIQ(IBVF,IBVIENS,"1.01:1.06;9*","IEN","CMPI","CMPIERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 ;
 S COL1=2,COL2=40
 ;
 S LN=LN+1
 I '$D(CMPI) G CMPIX
 D SET(LN,1,"Composite Medical Procedure Information",,IBVV)
 ;
 ; get procedure code, desc, and type information
 S PCTYP=$G(CMPI(IBVF,IBVIENS,1.01,"E"))  ;IB*2*497
 S PCODE=$G(CMPI(IBVF,IBVIENS,1.02,"E"))
 S PCIEN=0,PCDESC=""
 I PCTYP="CJ"!(PCTYP="HC") D     ; cpt or hcpcs procedure codes
 . Q:PCODE=""
 . S PCIEN=+$O(^ICPT("BA",PCODE_" ",0))
 . Q:'PCIEN
 . S PCDESC=$P($$CPT^IBACSV(PCIEN),U,2)
 . S PCDESC=$$TITLE^XLFSTR(PCDESC)
 . Q
 ;
 I PCTYP="ID" D         ; icd-9-cm procedure codes
 . Q:PCODE=""
 . S PCIEN=+$O(^ICD0("BA",PCODE_" ",0))
 . Q:'PCIEN
 . S PCDESC=$P($$ICD0^IBACSV(PCIEN),U,4)
 . S PCDESC=$$TITLE^XLFSTR(PCDESC)
 . Q
 ;
 S LN=LN+1
 D SET(LN,COL1,"Prod/Serv ID Qual",$G(CMPI(IBVF,IBVIENS,1.01,"E")))
 D SET(.LN,COL2,"Procedure Code",PCODE_" "_PCDESC)
 ;
 S LN=LN+1
 S MODLST=""
 F FCZ=1.03:.01:1.06 S PM=$G(CMPI(IBVF,IBVIENS,FCZ,"E")) I PM'="" S MODLST=$S(MODLST="":PM,1:(MODLST_", "_PM))
 D SET(LN,COL1,"Procedure Modifier(s)",MODLST)
 ;
 ; now loop through and display all of the additional info (POS and DX)
 S ZF=2.3229
 I IBVF=365.02 S ZF=365.29   ; additional info subfile#
 ;
 ; if no additional info (POS and DX), then display the prompts here once
 I '$D(CMPI(ZF)) D
 . S LN=LN+1
 . D SET(LN,COL1,"DX/Facility Qual","")
 . D SET(.LN,COL2,"DX/Facility","")
 . S LN=LN+1
 . D SET(LN,COL1,"Nature of Injury Code","")
 . D SET(.LN,COL2,"Injury Category","")
 . S LN=LN+1
 . D SET(LN,COL1,"Nature of Injury Description","")
 . Q
 ;
 S ZIEN="" F  S ZIEN=$O(CMPI(ZF,ZIEN)) Q:ZIEN=""  D
 . ;
 . ; check to see if we have a valid POS pointer
 . S POS=+$G(CMPI(ZF,ZIEN,.02,"I")),POSD=""
 . I POS S POSD=$P($G(^IBE(353.1,POS,0)),U,2)
 . I POSD'="" D
 .. S POSD=$$TITLE^XLFSTR(POSD)
 .. S LN=LN+1
 .. D SET(LN,COL1,"DX/Facility Qual","POS")
 .. D SET(.LN,COL2,"DX/Facility",$G(CMPI(ZF,ZIEN,.02,"E"))_" "_POSD)
 .. Q
 . ;
 . ; now check for a DX
 . S DX=+$G(CMPI(ZF,ZIEN,.03,"I")),DXD=""
 . I DX S DXD=$P($$ICD9^IBACSV(DX),U,3)
 . I DXD'="" D
 .. S DXD=$$TITLE^XLFSTR(DXD)
 .. S LN=LN+1
 .. D SET(LN,COL1,"DX/Facility Qual","DX")
 .. D SET(.LN,COL2,"DX/Facility",$G(CMPI(ZF,ZIEN,.03,"E"))_" "_DXD)
 .. Q
 . ;
 . ; nature of injury code
 . S LN=LN+1
 . D SET(LN,COL1,"Nature of Injury Code",$G(CMPI(ZF,ZIEN,.05,"E")))
 . D SET(.LN,COL2,"Injury Category",$G(CMPI(ZF,ZIEN,.06,"E")))
 . S LN=LN+1
 . D SET(LN,COL1,"Nature of Injury Description",$G(CMPI(ZF,ZIEN,.07,"E")))
 . Q
 ;
 S LN=LN+1
 D SET(LN)
 ;
CMPIX ;
 Q
 ;
HCSD(IBVF,IBVIENS,IBVV,IBVSUB) ; Healthcare Services Delivery multiple display
 ;
 ;    IBVF = file# 2.322 or 365.02
 ; IBVIENS = std IENS list of internal entry numbers
 ;    IBVV = video attributes flag
 ;  IBVSUB = display scratch global subscript
 ;
 N HCSD,HCSDERR,DSP,LN,ZF,HCNT,ZIEN,HCTOT,COL1,COL2
 D GETS^DIQ(IBVF,IBVIENS,"7*","IEN","HCSD","HCSDERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 ;
 ; loop through and count the # of hcsd multiples
 S ZF=2.3227,HCNT=0
 I IBVF=365.02 S ZF=365.27   ; healthcare services delivery subfile#
 S ZIEN="" F  S ZIEN=$O(HCSD(ZF,ZIEN)) Q:ZIEN=""  S HCNT=HCNT+1
 S HCTOT=HCNT
 ;
 I 'HCTOT G HCSDX
 ;
 S COL1=2,COL2=40
 ;
 ; loop again to display
 S HCNT=0
 S ZIEN="" F  S ZIEN=$O(HCSD(ZF,ZIEN)) Q:ZIEN=""  D
 . S HCNT=HCNT+1
 . ;
 . S LN=LN+1
 . I HCTOT>1 D SET(LN,1,"Health Care Service Delivery ("_HCNT_" of "_HCTOT_")",,IBVV)
 . I HCTOT'>1 D SET(LN,1,"Health Care Service Delivery",,IBVV)
 . ;
 . S LN=LN+1
 . D SET(LN,COL1,"Quantity Qualifier",$P($G(^IBE(365.016,+$G(HCSD(ZF,ZIEN,.03,"I")),0)),U,2))
 . D SET(.LN,COL2,"Benefit Quantity",$G(HCSD(ZF,ZIEN,.02,"E")))
 . ;
 . S LN=LN+1
  .D SET(LN,COL1,"Unit/Basis for Measurement",$P($G(^IBE(365.029,+$G(HCSD(ZF,ZIEN,.05,"I")),0)),U,2))  ;IB*2*497
 . D SET(.LN,COL2,"Sampling Frequency",$G(HCSD(ZF,ZIEN,.04,"E")))
 . ;
 . S LN=LN+1
 . D SET(LN,COL1,"Period Count Qual",$P($G(^IBE(365.015,+$G(HCSD(ZF,ZIEN,.07,"I")),0)),U,2))
 . D SET(.LN,COL2,"Period Count",$G(HCSD(ZF,ZIEN,.06,"E")))
 . ;
 . S LN=LN+1
 . D SET(LN,COL1,"Delivery Freq. Code",$P($G(^IBE(365.025,+$G(HCSD(ZF,ZIEN,.08,"I")),0)),U,2))
 . ;
 . S LN=LN+1
 . D SET(LN,COL1,"Delivery Pattern Time Code",$P($G(^IBE(365.036,+$G(HCSD(ZF,ZIEN,.09,"I")),0)),U,2)) ;IB*2*497
 . ;
 . S LN=LN+1
 . D SET(LN)
 . Q
 ;
HCSDX ;
 Q
 ;
NTE(IBVF,IBVIENS,IBVV,IBVSUB) ; Notes display
 ;
 ;    IBVF = file# 2.322 or 365.02
 ; IBVIENS = std IENS list of internal entry numbers
 ;    IBVV = video attributes flag
 ;  IBVSUB = display scratch global subscript
 ;
 N COL,DSP,LN,NTED,NTEDERR,ZIEN
 D GETS^DIQ(IBVF,IBVIENS,2,"N","NTED","NTEDERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 I '$D(NTED) G NTEX
 S COL=2
 S LN=LN+1 D SET(LN,1,"Notes and Comments",,IBVV)
 S ZIEN=0 F  S ZIEN=$O(NTED(IBVF,IBVIENS,2,ZIEN)) Q:'ZIEN  S LN=LN+1 D SET(LN,COL,$G(NTED(IBVF,IBVIENS,2,ZIEN)))
 S LN=LN+1
 D SET(LN)
 ;
NTEX ;
 Q
 ;
BRE(IBVF,IBVIENS,IBVV,IBVSUB) ; Benefit Related Entity data extract/display
 ;
 ;    IBVF = file# 2.322 or 365.02
 ; IBVIENS = std IENS list of internal entry numbers
 ;    IBVV = video attributes flag
 ;  IBVSUB = display scratch global subscript
 ;
 N BRE,BREERR,DSP,LN,ADDR,ADDR1,ADDR2,CITY,ST,ZIP,ZF,ZIEN,COL1,COL2
 D GETS^DIQ(IBVF,IBVIENS,"3.01:5.03;6*","IEN","BRE","BREERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 ;
 S COL1=2,COL2=40
 ;
 S LN=LN+1
 I '$D(BRE) G BREX
 D SET(LN,1,"Benefit Related Entity",,IBVV)
 ;
 S LN=LN+1
 D SET(LN,COL1,"Entity ID Code",$P($G(^IBE(365.022,+$G(BRE(IBVF,IBVIENS,3.01,"I")),0)),U,2))
 D SET(.LN,COL2,"Entity Type Qual",$P($G(^IBE(365.043,+$G(BRE(IBVF,IBVIENS,3.02,"I")),0)),U,2))  ; IB*2*497
 ;
 S LN=LN+1
 D SET(LN,COL1,"Entity ID Name",$G(BRE(IBVF,IBVIENS,3.03,"E")))
 ;
 S LN=LN+1
 D SET(LN,COL1,"ID Qualifier",$P($G(^IBE(365.023,+$G(BRE(IBVF,IBVIENS,3.05,"I")),0)),U,2))
 D SET(.LN,COL2,"Entity ID Number",$G(BRE(IBVF,IBVIENS,3.04,"E")))
 ;
 S LN=LN+1  ;IB*2*497
 D SET(LN,COL1,"Entity Relationship",$P($G(^IBE(365.031,+$G(BRE(IBVF,IBVIENS,3.06,"I")),0)),U,2))  ;IB*2*497
 ;
 S ADDR1=$G(BRE(IBVF,IBVIENS,4.01,"E"))
 S ADDR2=$G(BRE(IBVF,IBVIENS,4.02,"E"))
 S CITY=$G(BRE(IBVF,IBVIENS,4.03,"E"))
 S ST=+$G(BRE(IBVF,IBVIENS,4.04,"I"))
 S ST=$S(ST:$P($G(^DIC(5,ST,0)),U,2),1:"")
 S ZIP=$G(BRE(IBVF,IBVIENS,4.05,"E"))
 S ADDR=ADDR1
 I ADDR2'="" S ADDR=ADDR_" "_ADDR2
 ;I CITY'="" S ADDR=ADDR_", "_CITY  
 ;I ST'="" S ADDR=ADDR_","_ST
 ;I ZIP'="" S ADDR=ADDR_" "_ZIP
 S ADDR=ADDR_" "_CITY_" "_ST_" "_ZIP   ;IB*2*497  prevent orphan commas being displayed
 S LN=LN+1
 D SET(LN,COL1,"Entity Address",ADDR)
 ;
 S LN=LN+1
 D SET(LN,COL1,"Country Code",$G(BRE(IBVF,IBVIENS,4.06,"E")))
 D SET(.LN,COL2,"Country Subdivision",$G(BRE(IBVF,IBVIENS,4.09,"E")))
 ;
 S LN=LN+1
 D SET(LN,COL1,"Location Qual",$P($G(^IBE(365.034,+$G(BRE(IBVF,IBVIENS,4.08,"I")),0)),U,2))  ;IB*2*497
 D SET(.LN,COL2,"DOD Health Service Region Code",$G(BRE(IBVF,IBVIENS,4.07,"E")))
 ;
 ; now loop through and display all of the benefit related entity contact information
 S ZF=2.3226
 I IBVF=365.02 S ZF=365.26       ; contact information subfile#
 I '$D(BRE(ZF)) S BRE(ZF,1)=""   ; so the fields display once
 S ZIEN="" F  S ZIEN=$O(BRE(ZF,ZIEN)) Q:ZIEN=""  D
 . N IBDATA,IBLABEL,IBLEN
 . S LN=LN+1
 . D SET(LN,COL1,"Comm. Number Qual",$P($G(^IBE(365.021,+$G(BRE(ZF,ZIEN,.04,"I")),0)),U,2))
 . S IBDATA=$G(BRE(ZF,ZIEN,1,"E")),IBLABEL="Entity Comm. Number"
 . I $L(IBLABEL)+2+$L(IBDATA)<40 D  Q
 .. D SET(.LN,COL2,IBLABEL,IBDATA)
 . I $L(IBLABEL)+2+$L(IBDATA)<80 D  Q
 .. S LN=LN+1
 .. D SET(LN,COL1,IBLABEL,IBDATA)
 . F  D  I '$L(IBDATA) Q
 .. S IBLEN=80-$L(IBLABEL),LN=LN+1
 .. D SET(LN,COL1,IBLABEL,$E(IBDATA,1,IBLEN))
 .. S IBDATA=$E(IBDATA,IBLEN+1,$L(IBDATA)),IBLABEL=""
 . Q
 ;
 S LN=LN+1
 D SET(LN)
 ;
 S LN=LN+1
 D SET(LN,1,"Benefit Related Provider Information",,IBVV)
 ;
 S LN=LN+1
 D SET(LN,COL1,"Provider Code",$P($G(^IBE(365.024,+$G(BRE(IBVF,IBVIENS,5.01,"I")),0)),U,2))
 D SET(.LN,COL2,"Provider ID Qual",$P($G(^IBE(365.028,+$G(BRE(IBVF,IBVIENS,5.03,"I")),0)),U,2))  ;IB*2*497
 ;
 S LN=LN+1
 D SET(LN,COL1,"Provider ID",$G(BRE(IBVF,IBVIENS,5.02,"E")))
 ;
 S LN=LN+1
 D SET(LN)
BREX ;
 Q
 ;
SET(LN,COL,LABEL,DATA,IBVV) ; set data into display scratch global
 ;
 ; LN must be passed by reference when COL>20 because of the special variable IBVEBCOL flag to produce a single column
 ;
 ; IBVV - video attributes flag
 ;        1 = reverse video
 ;        2 = bold
 ;        3 = underline
 ;
 N STR,D1
 S COL=$G(COL,1)
 I $G(IBVEBCOL),COL>20 S LN=LN+1,COL=2   ; single column flag
 I $G(LABEL)'="",COL>1 S LABEL=" "_LABEL,COL=COL-1
 S STR=$G(@DSP@(LN,0))    ; get the current string
 S D1=""
 I $G(LABEL)'="" S D1=LABEL
 I $D(DATA) S D1=D1_": "_$G(DATA)   ; build the new display
 ;
 S STR=$$SETSTR^VALM1(D1,STR,+COL,(81-COL))   ; insert new data
 ;
 S @DSP@(LN,0)=STR    ; set the new data back into the scratch global
 ;
 ; Add the video attributes if requested
 I $G(IBVV) D
 . I IBVV=1 D CNTRL^VALM10(LN,COL,$L(LABEL),IORVON,IORVOFF)  ; reverse video
 . I IBVV=2 D CNTRL^VALM10(LN,COL,$L(LABEL),IOINHI,IOINORM)  ; bold
 . I IBVV=3 D CNTRL^VALM10(LN,COL,$L(LABEL),IOUON,IOUOFF)    ; underline
 . Q
 ;
SETX ;
 Q
 ;
DATE(Z) ; convert date in Z in format CCYYMMDD to MM/DD/CCYY format for display
 I Z?8N S Z=$E(Z,5,6)_"/"_$E(Z,7,8)_"/"_$E(Z,1,4)
 Q Z
 ;
