IBCNES1 ;ALB/ESG/JM - eIV elig/benefit utilities ; 13-JAN-2016
 ;;2.0;INTEGRATED BILLING;**416,438,497,549,702,732,804,806**;21-MAR-94;Build 19
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
 N XX,YY,IBTW,IBTWB,IBTWL S (XX,YY,IBTW,IBTWB,IBTWL)="" S $P(IBTWL,"-",79)="-"  ;IB*806/DJW only build if data
 N IBI,IBLP,IBTWA  ;IB*806/DTG for additional items
 ; IB*804/DJW Corrected GETS below as service types are in node 14 in file 365.02 
 ;            but node 11 for file 2.322.  Original code only looked at node 11.
 ;IB*806/dtg adding #10 subscriber info
 ;I IBVF=365.02 D GETS^DIQ(IBVF,IBVIENS,".02:.13;8*;14*","IEN","EB","EBERR")
 ;I IBVF'=365.02 D GETS^DIQ(IBVF,IBVIENS,".02:.13;8*;11*","IEN","EB","EBERR")
 I IBVF=365.02 D GETS^DIQ(IBVF,IBVIENS,".02:.13;8*;10*;14*","IEN","EB","EBERR")
 I IBVF'=365.02 D GETS^DIQ(IBVF,IBVIENS,".02:.13;8*;10*;11*","IEN","EB","EBERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 ;
 S COL1=2,COL2=40
 ;
 ; IB*804/DJW remove "Eligibility/Benefit Info.." and move up "INSURANCE TYPE:"
 ;S LN=LN+1 D SET(LN,1,"Eligibility/Benefit Information",,IBVV)
 I +$G(EB(IBVF,IBVIENS,.05,"I"))'=0 S LN=LN+1 D SET(LN,1,"Insurance Type",$P($G(^IBE(365.014,+$G(EB(IBVF,IBVIENS,.05,"I")),0)),U,2))
 ;
 ;IB*806/DJW only build if data
 S XX=+$G(EB(IBVF,IBVIENS,.02,"I")),YY=+$G(EB(IBVF,IBVIENS,.03,"I"))
 I XX'=0 D
 . S IBTW=$P($G(^IBE(365.011,XX,0)),U,2)
 . S LN=LN+1 D SET(LN,COL1,"Elig/Ben Info",IBTW)
 ;I YY'=0 S LN=$S(XX="":LN+1,1:LN) D SET(.LN,$S(XX="":COL1,1:COL2),"Coverage Level",$P($G(^IBE(365.012,YY,0)),U,2))
 I YY'=0 S LN=LN+1 D SET(LN,COL1,"Coverage Level",$P($G(^IBE(365.012,YY,0)),U,2))
 ;
 ;
 ; now loop through and display all of the dates and date qualifiers
 S ZF=2.3228
 I IBVF=365.02 S ZF=365.28     ; subscriber dates subfile#
 I '$D(EB(ZF)) S EB(ZF,1)=""   ; so the fields display once
 S ZIEN="" F  S ZIEN=$O(EB(ZF,ZIEN)) Q:ZIEN=""  D
 . N HLDT,DTYP,EXDT
 . ;IB*806/DJW only build if data
 . S HLDT=$G(EB(ZF,ZIEN,.02,"E"))
 . S DTYP=$G(EB(ZF,ZIEN,.04,"E"))           ;IB*2.0*549 changed "I" to "E"
 . S EXDT=$S(DTYP="D8":$$DATE(HLDT),DTYP="RD8":($$DATE($P(HLDT,"-",1))_"-"_$$DATE($P(HLDT,"-",2))),1:HLDT)
 . I EXDT="" Q
 . S LN=LN+1 D SET(LN,COL1,"Date/Time Qual",$P($G(^IBE(365.026,+$G(EB(ZF,ZIEN,.03,"I")),0)),U,2))
 . D SET(.LN,COL2,"D/T Period",EXDT)
 ;
 ; IB*806 for service type, time period, benefit, plan cov desc, quantity qual/amt: capture only if data exists
 ; loop through service type codes
 S ZF=2.32292
 I IBVF=365.02 S ZF=365.292  ; service types subfile#
 S ZIEN="" F  S ZIEN=$O(EB(ZF,ZIEN)) Q:ZIEN=""  S LN=LN+1 D SET(LN,COL1,"Service Type",$P($G(^IBE(365.013,+$G(EB(ZF,ZIEN,.01,"I")),0)),U,2))
 ;
 S IBTW=+$G(EB(IBVF,IBVIENS,.07,"I"))
 I IBTW'=0 S LN=LN+1 D SET(LN,COL1,"Time Period",$P($G(^IBE(365.015,IBTW,0)),U,2))
 ;
 ; IB*804 moved Insurance Type higher up
 ;S LN=LN+1 D SET(LN,COL1,"Insurance Type",$P($G(^IBE(365.014,+$G(EB(IBVF,IBVIENS,.05,"I")),0)),U,2))
 ;
 S IBTW=$G(EB(IBVF,IBVIENS,.06,"E"))
 I IBTW'="" S LN=LN+1 D SET(LN,COL1,"Plan Coverage Desc",IBTW)
 ;
 S XX=$G(EB(IBVF,IBVIENS,.08,"E")),YY=$G(EB(IBVF,IBVIENS,.09,"E"))
 I XX'="" S LN=LN+1 D SET(LN,COL1,"Benefit Amount",XX)
 I YY'="" S LN=$S(XX="":LN+1,1:LN) D SET(.LN,$S(XX="":COL1,1:COL2),"Benefit %",YY)
 ;
 S XX=$G(EB(IBVF,IBVIENS,.11,"E"))
 I XX'="" D
 . S LN=LN+1 D SET(LN,COL1,"Quantity Qual",$P($G(^IBE(365.016,+$G(EB(IBVF,IBVIENS,.1,"I")),0)),U,2))
 . D SET(.LN,COL2,"Quantity Amount",XX)
 ;
 ;IB*806/DJW only build if data
 S XX=+$G(EB(IBVF,IBVIENS,.12,"I")),YY=+$G(EB(IBVF,IBVIENS,.13,"I"))
 I XX'=0 S LN=LN+1 D SET(LN,COL1,"Auth/Certification Required",$P($G(^IBE(365.033,+XX,0)),U,2))  ;IB*2*497
 I YY'=0 S LN=LN+1 D SET(LN,COL1,"In-Plan-Network",$P($G(^IBE(365.033,+YY,0)),U,2)) ;IB*2*497
 ;
 ;IB*806/DTG additional items
 ; loop through subscriber ref id
 S ZF=2.32291,IBLP=$P($G(^DPT(+$P(IBVIENS,",",3),.312,+$P(IBVIENS,",",2),6,+$P(IBVIENS,",",1),10,0)),U,3)
 I IBVF=365.02 S ZF=365.291,IBLP=$P($G(^IBCN(365,+$P(IBVIENS,",",2),2,+$P(IBVIENS,",",1),10,0)),U,3)  ;sub ref id
 I $D(EB(ZF)) D
 . S ZIEN="" F  S ZIEN=$O(EB(ZF,ZIEN)) Q:ZIEN=""  D
 .. S IBTW=$G(EB(ZF,ZIEN,.02,"E"))
 .. I IBTW'="" S LN=LN+1 D SET(LN,(COL1),"Reference",IBTW)
 .. S IBTW=$G(EB(ZF,ZIEN,.03,"I"))
 .. I IBTW'="" S LN=LN+1 D SET(LN,(COL1),"Reference ID Qualifier",$P($G(^IBE(365.028,+IBTW,0)),U,2))
 .. S IBTW=$G(EB(ZF,ZIEN,.04,"E"))
 .. I IBTW'="" D
 ... I (13+$L(IBTW)<80) S LN=LN+1 D SET(LN,(COL1),"Description",IBTW) Q
 ... F IBI=1:1 S IBTWA=$S(IBI=1:"Description",1:" "),IBTWB=$S(IBI=1:$E(IBTW,1,60),1:$E(IBTW,1,79)) D  Q:IBTW=""
 .... S LN=LN+1 D:IBI=1 SET(LN,(COL1),IBTWA,IBTWB)
 .... I IBI>1 D SET(LN,(COL1+2),IBTWB)
 .... S IBTW=$S(IBI=1:$E(IBTW,61,$L(IBTW)),1:$E(IBTW,80,$L(IBTW)))
 .. I IBLP'=+ZIEN S LN=LN+1 D SET(LN)
 ;
 S LN=LN+1 D SET(LN)
 ;
EBX ;
 Q
 ;
CMPI(IBVF,IBVIENS,IBVV,IBVSUB) ; Composite Medical Procedure Information
 ; IB*806 Rewrote tag to only build/print when values exist
 ;
 ;    IBVF = file# 2.322 or 365.02
 ; IBVIENS = std IENS list of internal entry numbers
 ;    IBVV = video attributes flag
 ;  IBVSUB = display scratch global subscript
 ;
 N CMPI,CMPIERR,DSP,LN,COL1,COL2,PCTYP,PCODE,PCIEN,PCDESC,MODLST,FCZ,PM,ZF,ZIEN,POS,POSD,DX,DXD
 N IBTW,IBTWA,IBTWB S (IBTW,IBTWA,IBTWB)=""  ;IB*806/DTG
 D GETS^DIQ(IBVF,IBVIENS,"1.01:1.06;9*","IEN","CMPI","CMPIERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 ;
 S COL1=2,COL2=40
 ;
 S LN=LN+1
 I '$D(CMPI) G CMPIX
 D SET(LN,1,"Composite Medical Procedure Information",,IBVV)
 S LN=LN+1 D SET(LN,1,"---------------------------------------",,IBVV)
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
 ;
 I PCTYP="ID" D         ; icd-9-cm procedure codes
 . Q:PCODE=""
 . S PCIEN=+$O(^ICD0("BA",PCODE_" ",0))
 . Q:'PCIEN
 . S PCDESC=$P($$ICD0^IBACSV(PCIEN),U,4)
 . S PCDESC=$$TITLE^XLFSTR(PCDESC)
 ;
 ;IB*806/DTG only if data exists
 I $G(PCTYP)'=""!($G(PCODE)'="") D
 . S LN=LN+1 D SET(LN,COL1,"Prod/Serv ID Qual",$G(CMPI(IBVF,IBVIENS,1.01,"E")))
 . S LN=LN+1 D SET(LN,COL1,"Procedure Code",PCODE_" "_PCDESC)
 ;
 S MODLST=""
 F FCZ=1.03:.01:1.06 S PM=$G(CMPI(IBVF,IBVIENS,FCZ,"E")) I PM'="" S MODLST=$S(MODLST="":PM,1:(MODLST_", "_PM))
 I MODLST'="" S LN=LN+1 D SET(LN,COL1,"Procedure Modifier(s)",MODLST)
 ;
 ; loop through and display all additional info (POS and DX)
 S ZF=2.3229
 I IBVF=365.02 S ZF=365.29   ; additional info subfile#
 ;
 S ZIEN="" F  S ZIEN=$O(CMPI(ZF,ZIEN)) Q:ZIEN=""  D
 . ;
 . ; check to see if we have a valid POS pointer
 . S POS=+$G(CMPI(ZF,ZIEN,.02,"I")),POSD=""
 . I POS S POSD=$P($G(^IBE(353.1,POS,0)),U,2)
 . I POSD'="" D
 . . S POSD=$$TITLE^XLFSTR(POSD)
 . . S LN=LN+1 D SET(LN,COL1,"DX/Facility Qual","POS")
 . . S LN=LN+1 D SET(LN,COL1,"  DX/Facility",$G(CMPI(ZF,ZIEN,.02,"E"))_" "_POSD)
 . ;
 . ;
 . ; check for a DX
 . S DX=+$G(CMPI(ZF,ZIEN,.03,"I")),DXD=""
 . I DX S DXD=$P($$ICD9^IBACSV(DX),U,3)
 . I DXD'="" D
 . . S DXD=$$TITLE^XLFSTR(DXD)
 . . S LN=LN+1 D SET(LN,COL1,"DX/Facility Qual","DX")
 . . S LN=LN+1 D SET(LN,COL1,"  DX/Facility",$G(CMPI(ZF,ZIEN,.03,"E"))_" "_DXD)
 . ;
 . ;
 . ; nature of injury code
 . S IBTW=$G(CMPI(ZF,ZIEN,.05,"E"))
 . S IBTWA=$G(CMPI(ZF,ZIEN,.06,"E"))
 . S IBTWB=$G(CMPI(ZF,ZIEN,.07,"E"))
 . I IBTW'="" S LN=LN+1 D SET(LN,COL1,"Nature of Injury Code",IBTW)
 . I IBTWA'="" S LN=LN+1 D SET(LN,COL1,"Injury Category",IBTWA)
 . I IBTWB'="" S LN=LN+1 D SET(LN,COL1,"Nature of Injury Description",IBTWB)
 ;
 S LN=LN+1 D SET(LN)
 ;
CMPIX ;
 Q
 ;
HCSD(IBVF,IBVIENS,IBVV,IBVSUB) ; Healthcare Services Delivery multiple display
 ; IB*806 Rewrote tag to only build/print when values exist
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
 N IBTW,IBTWA,IBTWB,IBTWL
 S (IBTW,IBTWA,IBTWB,IBTWL)="",$P(IBTWL,"-",79)="-"
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
 . S IBTWB=28
 . I HCTOT>1 D  ;IB*806/DTG change for underline
 .. S LN=LN+1 D SET(LN,1,"Health Care Service Delivery ("_HCNT_" of "_HCTOT_")",,IBVV)
 .. S IBTWB=IBTWB+$L(HCNT)+$L(HCTOT)+6
 . I HCTOT'>1 S LN=LN+1 D SET(LN,1,"Health Care Service Delivery",,IBVV)
 . S LN=LN+1 D SET(LN,1,$E(IBTWL,1,IBTWB),,IBVV)
 . ;
 . ;IB*806/DTG only build if data
 . S IBTW=$P($G(^IBE(365.016,+$G(HCSD(ZF,ZIEN,.03,"I")),0)),U,2)
 . S IBTWA=$G(HCSD(ZF,ZIEN,.02,"E"))
 . I IBTW'=""!(IBTWA'="") D
 .. S LN=LN+1 D SET(LN,COL1,"Quantity Qualifier",IBTW)
 .. S LN=LN+1 D SET(LN,COL1,"  Benefit Quantity",IBTWA)
 . ;
 . S IBTW=$P($G(^IBE(365.029,+$G(HCSD(ZF,ZIEN,.05,"I")),0)),U,2)
 . S IBTWA=$G(HCSD(ZF,ZIEN,.04,"E"))
 . I IBTW'="" S LN=LN+1 D SET(LN,COL1,"Unit/Basis for Measurement",IBTW)  ;IB*2*497
 . I IBTWA'="" S LN=LN+1 D SET(LN,COL1,"Sampling Frequency",IBTWA)
 . ;
 . S IBTW=$P($G(^IBE(365.015,+$G(HCSD(ZF,ZIEN,.07,"I")),0)),U,2)
 . S IBTWA=$G(HCSD(ZF,ZIEN,.06,"E"))
 . I IBTW'=""!(IBTWA'="") D
 .. S LN=LN+1 D SET(LN,COL1,"Period Count Qual",IBTW)
 .. S LN=LN+1 D SET(LN,COL1,"  Period Count",IBTWA)
 . ;
 . S IBTW=$P($G(^IBE(365.025,+$G(HCSD(ZF,ZIEN,.08,"I")),0)),U,2)
 . I IBTW'="" S LN=LN+1 D SET(LN,COL1,"Delivery Freq. Code",IBTW)
 . ;
 . S IBTW=$P($G(^IBE(365.036,+$G(HCSD(ZF,ZIEN,.09,"I")),0)),U,2)
 . I IBTW'="" S LN=LN+1 D SET(LN,COL1,"Delivery Pattern Time Code",IBTW) ;IB*2*497
 . ;
 . S LN=LN+1 D SET(LN)
 ;
HCSDX ;
 Q
 ;
NTE(IBVF,IBVIENS,IBVV,IBVSUB) ; Notes display
 ; IB*806 Rewrote tag to only build/print when values exist
 ;
 ;    IBVF = file# 2.322 or 365.02
 ; IBVIENS = std IENS list of internal entry numbers
 ;    IBVV = video attributes flag
 ;  IBVSUB = display scratch global subscript
 ;
 ;IB*2*702/ckb - Added NOTE
 N COL,DSP,LN,NOTE,NTED,NTEDERR,ZIEN
 D GETS^DIQ(IBVF,IBVIENS,2,"N","NTED","NTEDERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 I '$D(NTED) G NTEX
 S COL=2
 S LN=LN+1 D SET(LN,1,"Notes and Comments",,IBVV)
 S LN=LN+1 D SET(LN,1,"------------------",,IBVV)  ;IB*806/DTG display underline offset
 ;IB*2*702/ckb - Modified to display the entire Note/Comment, not just the first 80 char's.
 ;S ZIEN=0 F  S ZIEN=$O(NTED(IBVF,IBVIENS,2,ZIEN)) Q:'ZIEN  S LN=LN+1 D SET(LN,COL,$G(NTED(IBVF,IBVIENS,2,ZIEN)))
 S ZIEN=0 F  S ZIEN=$O(NTED(IBVF,IBVIENS,2,ZIEN)) Q:'ZIEN  D
 . S NOTE=$G(NTED(IBVF,IBVIENS,2,ZIEN))
 . ;
 . I $L(NOTE)<80 S LN=LN+1 D SET(LN,COL,NOTE)
 . I $L(NOTE)>79 S LN=LN+1 S LN=$$SETC(NOTE,LN)
 S LN=LN+1 D SET(LN)
 ;
NTEX ;
 Q
 ;
BRE(IBVF,IBVIENS,IBVV,IBVSUB) ; Benefit Related Entity data extract/display
 ; IB*806 Rewrote tag to only build/print when values exist
 ;
 ;    IBVF = file# 2.322 or 365.02
 ; IBVIENS = std IENS list of internal entry numbers
 ;    IBVV = video attributes flag
 ;  IBVSUB = display scratch global subscript
 ;
 N BRE,BREERR,DSP,LN,ADDR,ADDR1,ADDR2,CITY,ST,ZIP,ZF,ZIEN,COL1,COL2
 N BRE1  ;IB*806/DTG for seperation of provider info
 ;D GETS^DIQ(IBVF,IBVIENS,"3.01:5.03;6*","IEN","BRE","BREERR")
 D GETS^DIQ(IBVF,IBVIENS,"3.01:4.09;6*","IEN","BRE","BREERR")
 D GETS^DIQ(IBVF,IBVIENS,"5.01:5.03","IEN","BRE1","BREERR")
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 ;
 N IBTW,IBTWA,IBTWB,IBTWC S (IBTW,IBTWA,IBTWB,IBTWC)=""  ;IB*806/DTG new Variables
 S COL1=2,COL2=40
 ;
 ;I '$D(BRE) G BREX
 I '$D(BRE) G BRE1
 S LN=LN+1 D SET(LN,1,"Benefit Related Entity",,IBVV)
 S LN=LN+1 D SET(LN,1,"----------------------",,IBVV)
 ;
 S IBTW=$P($G(^IBE(365.022,+$G(BRE(IBVF,IBVIENS,3.01,"I")),0)),U,2)
 S IBTWA=$P($G(^IBE(365.043,+$G(BRE(IBVF,IBVIENS,3.02,"I")),0)),U,2)
 S IBTWB=$G(BRE(IBVF,IBVIENS,3.03,"E"))
 I IBTW'=""!(IBTWA'="")!(IBTWB'="") D
 . S LN=LN+1 D SET(LN,COL1,"Entity ID Code",IBTW)
 . S LN=LN+1 D SET(LN,COL1,"  Entity Type Qual",IBTWA)  ; IB*2*497
 . S LN=LN+1 D SET(LN,COL1,"  Entity ID Name",IBTWB)
 ;
 S IBTW=$P($G(^IBE(365.023,+$G(BRE(IBVF,IBVIENS,3.05,"I")),0)),U,2)
 S IBTWA=$G(BRE(IBVF,IBVIENS,3.04,"E"))
 S IBTWB=$P($G(^IBE(365.031,+$G(BRE(IBVF,IBVIENS,3.06,"I")),0)),U,2)
 I IBTW'=""!(IBTWA'="")!(IBTWB'="")  D
 . S LN=LN+1 D SET(LN,COL1,"ID Qualifier",IBTW)
 . S LN=LN+1 D SET(LN,COL1,"  Entity ID Number",IBTWA)
 . S LN=LN+1 D SET(LN,COL1,"  Entity Relationship",IBTWB)  ;IB*2*497
 ;
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
 ;IB*806/DTG only build if data.    added do to set
 I ADDR'="" S IBTW=$TR(ADDR," ","") I IBTW'="" D
 . S LN=LN+1 D SET(LN,COL1,"Entity Address",ADDR)
 ;
 ;
 S IBTW=$G(BRE(IBVF,IBVIENS,4.06,"E"))
 S IBTWA=$G(BRE(IBVF,IBVIENS,4.09,"E"))
 I IBTW'=""!(IBTWA'="") D
 . S LN=LN+1 D SET(LN,COL1,"Country Code",IBTW)
 . S LN=LN+1 D SET(LN,COL1,"Country Subdivision",IBTWA)
 ;
 S IBTW=$P($G(^IBE(365.034,+$G(BRE(IBVF,IBVIENS,4.08,"I")),0)),U,2)
 S IBTWA=$G(BRE(IBVF,IBVIENS,4.07,"E"))
 I IBTW'="" S LN=LN+1 D SET(LN,COL1,"Location Qual",IBTW)
 I IBTWA'="" S LN=LN+1 D SET(LN,COL1,"DOD Health Service Region Code",IBTWA)
 ;
 ; now loop through and display all of the benefit related entity contact information
 S ZF=2.3226
 I IBVF=365.02 S ZF=365.26       ; contact information subfile#
 S ZIEN="" F  S ZIEN=$O(BRE(ZF,ZIEN)) Q:ZIEN=""  D
 . N IBDATA,IBLABEL,IBLEN
 . ;
 . S IBTW=$G(BRE(ZF,ZIEN,.02,"E")),IBTWC=0 I IBTW'="" S LN=LN+1,IBTWC=2 D SET(LN,COL1,"Comm. Name",IBTW)  ;IB*806/DTG additional items
 . S IBTW=$P($G(^IBE(365.021,+$G(BRE(ZF,ZIEN,.04,"I")),0)),U,2)
 . I IBTW'="" S LN=LN+1 D SET(LN,COL1+IBTWC,"Comm. Number Qual",IBTW)
 . S IBDATA=$G(BRE(ZF,ZIEN,1,"E")),IBLABEL="Entity Comm. Number"
 . I IBDATA="" Q  ;IB*806/DTG only build if data
 . ;I $L(IBLABEL)+2+$L(IBDATA)<40 D  Q
 . ;. D SET(.LN,COL2,IBLABEL,IBDATA)
 . ;I $L(IBLABEL)+2+$L(IBDATA)<80 D  Q
 . ;. S LN=LN+1
 . ;. D SET(LN,COL1,IBLABEL,IBDATA)
 . F  D  I '$L(IBDATA) Q
 .. S IBLEN=80-$L(IBLABEL),LN=LN+1
 .. D SET(LN,(COL1+IBTWC),IBLABEL,$E(IBDATA,1,IBLEN))
 .. S IBDATA=$E(IBDATA,IBLEN+1,$L(IBDATA)),IBLABEL=""
 ;
 S LN=LN+1 D SET(LN)
 ;
BRE1 ; sub section for BRE
 ;
 I '$D(BRE1) G BREX
 ;IB*806/DTG only build if data
 S IBTW=$P($G(^IBE(365.024,+$G(BRE1(IBVF,IBVIENS,5.01,"I")),0)),U,2)
 S IBTWA=$P($G(^IBE(365.028,+$G(BRE1(IBVF,IBVIENS,5.03,"I")),0)),U,2)
 S IBTWB=$G(BRE1(IBVF,IBVIENS,5.02,"E"))
 ;
 S LN=LN+1 D SET(LN,1,"Benefit Related Provider Information",,IBVV)
 S LN=LN+1 D SET(LN,1,"------------------------------------",,IBVV)
 ;
 I IBTW'=""!(IBTWA'="")!(IBTWB'="") D
 . S LN=LN+1 D SET(LN,COL1,"Provider Code",IBTW)
 . S LN=LN+1 D SET(LN,COL1,"  Provider ID Qual",IBTWA)
 . S LN=LN+1 D SET(LN,COL1,"  Provider ID",IBTWB)
 ;
 S LN=LN+1 D SET(LN)
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
 ;
SETX ;
 Q
 ;
 ;IB*2*702/ckb - Added to handle Notes/Comments that need more than 1 line to display.
SETC(DATA,LINE) ; Sets Note text
 ;Input:
 ; DATA - Note Text to set into more than 1 line
 ; LINE - Current Line text is being set into
 ;
 ;Returns:
 ; LINE - Updated Line text is being set into
 ;
 N CLNEND,CPOS,CWLPOS,CWPOS,CWEPOS,SPOS,STLEN,XX
 ;
 ; Display the comment text 1 line at a time. The line begins with a
 ; space and then the text therefore the text is limited to 79 char's.
 S (CPOS,SPOS)=0,CLNEND=75
 S (CWLPOS,CWPOS)=1,CWEPOS=$L(DATA)
 F  D  Q:(CWPOS>CWEPOS)
 . ; Display the text from position CWPOS-CLNEND
 . I 'SPOS!(SPOS>CLNEND) D  Q
 . . S XX=$E(DATA,CWPOS,CLNEND)
 . . I $E(XX,1)=" " S XX=$E(XX,2,$L(XX)) ; removing leading spaces
 . . D SET(LINE,2,XX)
 . . S LINE=LINE+1,CWLPOS=1
 . . S CWPOS=CLNEND+1,CLNEND=CLNEND+75
 ;
 Q (LINE-1)  ;IB*732/CKB correct line quit
 ;
DATE(Z) ; convert date in Z in format CCYYMMDD to MM/DD/CCYY format for display
 I Z?8N S Z=$E(Z,5,6)_"/"_$E(Z,7,8)_"/"_$E(Z,1,4)
 Q Z
 ;
