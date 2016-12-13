IBCNES3 ;DALOI/KML/JNM - eIV elig/Benefit screen, con't ;01-05-2016
 ;;2.0;INTEGRATED BILLING;**497,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; called by IBCNES
RPDM(IBVF,IBVDA,IBVV,IBVSUB) ; Eligibility/Group Information procedure
 ; --- Called by IBCNES
 ;          input
 ;              IBVF = file file# 2.322 or 365.02
 ;              IBVDA - ien of 365 OR 2.312
 S IBVV=+$G(IBVV)
 N IBL,IBY,IBLINE,LN,DSP,COL1,COL2,GLO
 ;^DPT(D0,.312,D1,9,0)
 I IBVF=2.312 S GLO=$NA(^DPT(+$G(IBVDA(1)),.312,+$G(IBVDA)))   ; pt. insurance
 I IBVF=365 S GLO=$NA(^IBCN(365,+$G(IBVDA)))                ; response file
 S DSP=$NA(^TMP(IBVSUB,$J,"DISP"))       ; scratch global display array
 S LN=+$O(@DSP@(""),-1)                  ; last line# used in scratch global
 S COL1=2,COL2=47
 ;
 S LN=LN+1
 D SET^IBCNES1(LN,1,"Eligibility/Group Plan Information",,IBVV)
 S LN=LN+1
 D SET^IBCNES1(LN)
 D REF(GLO,IBVF,.IBVDA)
 D PROV(GLO,IBVF,.IBVDA)
 D DIAG(GLO,IBVF,.IBVDA)
 D MIL(GLO,IBVF,.IBVDA)
 Q
 ;
REF(GLO,IBVF,IBVDA) ;  policy level reference ID display
 ; 
 ;    input - 
 N REF,SIEN,IENS,REFLST
 S IBVF=$S(IBVF=365:365.09,1:2.3129)
 S SIEN=0 F  S SIEN=$O(@GLO@(9,SIEN)) Q:'SIEN  S REFLST(SIEN)=""
 I '$D(REFLST) S REFLST(1)=""  ; field labels need to display once even if no values exist
 S SIEN=0 F  S SIEN=$O(REFLST(SIEN)) Q:'SIEN  D
 . S IENS=$S(IBVF=365.09:SIEN_","_IBVDA_",",1:SIEN_","_IBVDA_","_IBVDA(1)_",")
 . D GETS^DIQ(IBVF,IENS,"*","IEN","REF")
 . D SET^IBCNES1(LN,COL1,"Reference ID Qualifier",$P($G(^IBE(365.028,+$G(REF(IBVF,IENS,.03,"I")),0)),U,2))
 . D SET^IBCNES1(.LN,COL2,"Reference ID",$G(REF(IBVF,IENS,.02,"E")))
 . S LN=LN+1
 . D SET^IBCNES1(LN,COL1,"Reference ID description",$G(REF(IBVF,IENS,.04,"E")))
 . S LN=LN+1
 . D SET^IBCNES1(LN)
 S LN=LN+1
 D SET^IBCNES1(LN)
 Q
 ;
PROV(GLO,IBVF,IBVDA) ; GROUP level provider info
 ;          input
 ;              RIEN - ien of 365
 N PVLIST,SIEN,IENS,PV
 S IBVF=$S(IBVF=365:365.04,1:2.332)
 S SIEN=0 F  S SIEN=$O(@GLO@(10,SIEN)) Q:'SIEN  S PVLIST(SIEN)=""
 I '$D(PVLIST) S PVLIST(1)=""  ; field labels need to display once even if no values exist
 S SIEN=0 F  S SIEN=$O(PVLIST(SIEN)) Q:'SIEN  D
 . S IENS=$S(IBVF=365.04:SIEN_","_IBVDA_",",1:SIEN_","_IBVDA_","_IBVDA(1)_",")
 . D GETS^DIQ(IBVF,IENS,"*","IEN","PV")
 . D SET^IBCNES1(LN,COL1,"Provider Code",$P($G(^IBE(365.024,+$G(PV(IBVF,IENS,.02,"I")),0)),U,2))
 . S LN=LN+1
 . D SET^IBCNES1(LN,COL1,"Reference ID",$G(PV(IBVF,IENS,.03,"E")))
 . S LN=LN+1
 . D SET^IBCNES1(LN)
 S LN=LN+1
 D SET^IBCNES1(LN)
 Q
 ;
DIAG(GLO,IBVF,IBVDA) ; DIAGNOSIS INFO
 N IENS,SIEN,HDLIST,DIAG,ICDSTR,PRIMSEC
 S IBVF=$S(IBVF=365:365.01,1:2.31211)
 S SIEN=0 F  S SIEN=$O(@GLO@(11,SIEN)) Q:'SIEN  S HDLIST(SIEN)=""
 I '$D(HDLIST) S HDLIST(1)=""  ; field labels need to display once even if no values exist
 S SIEN=0 F  S SIEN=$O(HDLIST(SIEN)) Q:'SIEN  D
 . S IENS=$S(IBVF=365.01:SIEN_","_IBVDA_",",1:SIEN_","_IBVDA_","_IBVDA(1)_",")
 . D GETS^DIQ(IBVF,IENS,"*","IEN","DIAG")
 . S ICDSTR=$G(^ICD9(+$G(DIAG(IBVF,IENS,.02,"I")),0))  ; IA# 5388 (Supported agreement)
 . S PRIMSEC=$G(DIAG(IBVF,IENS,.04,"I"))
 . D SET^IBCNES1(LN,COL1,$S(PRIMSEC="P":"Primary ",PRIMSEC="":"Primary ",1:"Secondary ")_"Diagnosis Code",$P(ICDSTR,U)_" "_$P(ICDSTR,U,3))
 . S LN=LN+1
 . D SET^IBCNES1(LN)
 S LN=LN+1
 D SET^IBCNES1(LN)
 Q
 ;
MIL(GLO,IBVF,IBVDA) ; military personnel information display
 ; 
 ;    input - 
 N IENS
 S IENS=IBVDA_","
 S IENS=$S(IBVF=365:IBVDA_",",1:IBVDA_","_IBVDA(1)_",")
 S IBVF=$S(IBVF=365:365,1:2.312)
 D GETS^DIQ(IBVF,IENS,"12.01:12.07","IEN","MIL")
 D SET^IBCNES1(LN,COL1,"Military Info Status",$P($G(^IBE(365.039,+$G(MIL(IBVF,IENS,12.01,"I")),0)),U,2))
 D SET^IBCNES1(.LN,COL2,"Employment Status",$P($G(^IBE(365.046,+$G(MIL(IBVF,IENS,12.02,"I")),0)),U,2))
 S LN=LN+1
 D SET^IBCNES1(LN,COL1,"Government Affiliation",$P($G(^IBE(365.041,+$G(MIL(IBVF,IENS,12.03,"I")),0)),U,2))
 D SET^IBCNES1(.LN,COL2,"Date Time Period",$$DFMT(.MIL,IBVF,IENS))
 S LN=LN+1
 D SET^IBCNES1(LN,COL1,"Service Rank",$P($G(^IBE(365.042,+$G(MIL(IBVF,IENS,12.05,"I")),0)),U,2))
 S LN=LN+1
 D SET^IBCNES1(LN,COL1,"Desc",$G(MIL(IBVF,IENS,12.04,"E")))
 S LN=LN+1
 D SET^IBCNES1(LN)
 Q
 ;
DFMT(MIL,IBVF,IENS) ;  return proper date format string
 ; 
 ;    input - MIL = data array containing the data extracted from the military information fields (365, 12.01-12.07)
 ;            IENS = ien of 365 entry or 2.312 entry
 ;    output - RES = formatted date string
 N TODT,FROMDT,RES
 ; date range  
 I $G(MIL(IBVF,IENS,12.06,"E"))="RD8" S FROMDT=$P($G(MIL(IBVF,IENS,12.07,"E")),"-"),TODT=$P($G(MIL(IBVF,IENS,12.07,"E")),"-",2),RES=$$FMTE^XLFDT($$HL7TFM^XLFDT(FROMDT),2)_" - "_$$FMTE^XLFDT($$HL7TFM^XLFDT(TODT),2)
 E  S RES=$$FMTE^XLFDT($$HL7TFM^XLFDT($G(MIL(IBVF,IENS,12.07,"E"))),2)  ; single date
 Q RES
 ;
SET(LN,DATA,COL) ;set display data in scratch global
 N STR
 S STR=""
 S STR=$$SETSTR^VALM1(DATA,STR,+COL,(81-COL))   ; insert new data
 S @DSP@(LN,0)=STR ; set the new data back into the scratch global
 Q
 ;
