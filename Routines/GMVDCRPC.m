GMVDCRPC ;HOIFO/DAD-VITALS COMPONENT: RPCs ;8/24/99  08:28
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN1(RESULT,GMVFMT,GMVITTYP) ;
 ; RPC: GMVDC GET VITAL CATEGORIES
 ; Get list of the categories
 ; Input:
 ;  GMVFMT   = Format of returned data (Optional)
 ;             1 - IENs (default), 2 - Abbreviations, 3 - Full Names
 ;  GMVITTYP = A pointer to GMRV Vital Type file (#120.51) (Optional)
 ; Output:
 ;  RESULT() = CategoryIEN ^ CategoryName ^
 ;             VitalTypeIEN ^ DefaultQualifier
 N GMVCNT,GMVD0,GMVD1,GMVDATA,GMVDEFQ
 S GMVCNT=0
 S GMVFMT=$S("^1^2^3^"[(U_$G(GMVFMT)_U):GMVFMT,1:1)
 I $G(GMVITTYP)="" D
 . S GMVITTYP=0
 . F  S GMVITTYP=$O(^GMRD(120.53,"C",GMVITTYP)) Q:GMVITTYP'>0  D EN1A
 . Q
 E  D
 . S GMVITTYP=$$VITIEN^GMVDCUTL(GMVITTYP)
 . D EN1A
 . Q
 S RESULT(0)="OK"
 Q
EN1A S GMVD0=0
 F  S GMVD0=$O(^GMRD(120.53,"C",GMVITTYP,GMVD0)) Q:GMVD0'>0  D
 . S GMVD1=0
 . F  S GMVD1=$O(^GMRD(120.53,"C",GMVITTYP,GMVD0,GMVD1)) Q:GMVD1'>0  D
 .. S GMVDATA=$P($G(^GMRD(120.53,GMVD0,0)),U)
 .. I GMVDATA]"" D
 ... S GMVITTYP(0)=$G(^GMRD(120.51,+GMVITTYP,0))
 ... S GMVITTYP(1)=GMVITTYP,GMVITTYP(2)=$P(GMVITTYP(0),U,2)
 ... S GMVITTYP(3)=$P(GMVITTYP(0),U)
 ... S GMVDEFQ=$P($G(^GMRD(120.53,GMVD0,1,GMVD1,0)),U,7)
 ... S GMVDEFQ(0)=$G(^GMRD(120.52,+GMVDEFQ,0))
 ... S GMVDEFQ(1)=GMVDEFQ,GMVDEFQ(2)=$P(GMVDEFQ(0),U,2)
 ... S GMVDEFQ(3)=$P(GMVDEFQ(0),U)
 ... S GMVCNT=GMVCNT+1
 ... S RESULT(GMVCNT)=GMVD0_U_GMVDATA_U_GMVITTYP(GMVFMT)_U_GMVDEFQ(GMVFMT)
 ... Q
 .. Q
 . Q
 Q
 ;
EN2(RESULT) ;
 ; RPC: GMVDC GET VITAL ERROR REASONS
 ; Get list of the entered in error reasons
 ; Input:
 ;  None
 ; Output:
 ;  RESULT() = ErrorReasonInternal ^ ErrorReasonExternal
 N GMVD0,GMVDATA
 S GMVDATA=$$GET1^DID(120.506,.01,"","POINTER")
 F GMVD0=1:1 S GMVDATA(0)=$P(GMVDATA,";",GMVD0) Q:GMVDATA(0)=""  D
 . S RESULT(GMVD0)=$TR(GMVDATA(0),":","^")
 . Q
 S RESULT(0)="OK"
 Q
 ;
EN3(RESULT,GMVFMT,GMVITTYP,GMVITCAT) ;
 ; RPC: GMVDC GET VITAL QUALIFIERS
 ; Get list of the qualifiers
 ; Input:
 ;  GMVFMT   = Format of returned data (Optional)
 ;             1 - IENs (default), 2 - Abbreviations, 3 - Full Names
 ;  GMVITTYP = A pointer to GMRV Vital Type file (#120.51) (Optional)
 ;  GMVITCAT = A pointer to GMRV Vital Category file (#120.53) (Optional)
 ; Output:
 ;  RESULT() = QualifierIEN ^ QualifierName ^ QualifierSynonym ^
 ;             VitalTypeIEN ^ CategoryIEN
 N GMVCATD0,GMVCNT,GMVD0,GMVD1,GMVDATA
 S GMVCNT=0
 S GMVFMT=$S("^1^2^3^"[(U_$G(GMVFMT)_U):GMVFMT,1:1)
 S GMVITCAT=$$CATIEN^GMVDCUTL($G(GMVITCAT))
 I $G(GMVITTYP)="" D
 . S GMVITTYP=0
 . F  S GMVITTYP=$O(^GMRD(120.52,"C",GMVITTYP)) Q:GMVITTYP'>0  D EN3A
 . Q
 E  D
 . S GMVITTYP=$$VITIEN^GMVDCUTL(GMVITTYP)
 . D EN3A
 . Q
 S RESULT(0)="OK"
 Q
EN3A S GMVD0=0
 F  S GMVD0=$O(^GMRD(120.52,"C",GMVITTYP,GMVD0)) Q:GMVD0'>0  D
 . S GMVD1=0
 . F  S GMVD1=$O(^GMRD(120.52,"C",GMVITTYP,GMVD0,GMVD1)) Q:GMVD1'>0  D
 .. S GMVCATD0=$P($G(^GMRD(120.52,GMVD0,1,GMVD1,0)),U,2)
 .. I $G(GMVITCAT)>0,GMVITCAT'=GMVCATD0 Q
 .. S GMVDATA=$G(^GMRD(120.52,GMVD0,0))
 .. I GMVDATA]"" D
 ... S GMVITTYP(0)=$G(^GMRD(120.51,+GMVITTYP,0))
 ... S GMVITTYP(1)=GMVITTYP,GMVITTYP(2)=$P(GMVITTYP(0),U,2)
 ... S GMVITTYP(3)=$P(GMVITTYP(0),U)
 ... S GMVITCAT(0)=$G(^GMRD(120.53,+GMVCATD0,0))
 ... S GMVITCAT(1)=GMVCATD0,(GMVITCAT(2),GMVITCAT(3))=$P(GMVITCAT(0),U)
 ... S GMVCNT=GMVCNT+1
 ... S RESULT(GMVCNT)=GMVD0_U_$P(GMVDATA,U)_U_$P(GMVDATA,U,2)_U_GMVITTYP(GMVFMT)_U_GMVITCAT(GMVFMT)
 ... Q
 .. Q
 . Q
 Q
 ;
EN4(RESULT) ;
 ; RPC: GMVDC GET VITAL TYPES
 ; Get list of the vital types
 ; Input:
 ;  None
 ; Output:
 ;  RESULT() = VitalTypeIEN ^ VitalTypeName ^
 ;             VitalTypeAbbr ^ VitalTypePCE_Abbreviation
 N GMVD0,GMVDATA
 S GMVD0=0
 F  S GMVD0=$O(^GMRD(120.51,GMVD0)) Q:GMVD0'>0  D
 . S GMVDATA=$G(^GMRD(120.51,GMVD0,0))
 . I GMVDATA]"" S RESULT(GMVD0)=GMVD0_U_$P(GMVDATA,U)_U_$P(GMVDATA,U,2)_U_$P(GMVDATA,U,7)
 . Q
 S RESULT(0)="OK"
 Q
 ;
EN5(RESULT,GMVDFN,GMVFMT,GMVABR,GMVMSYS) ;
 ; RPC: GMVDC GET LATEST VITALS
 ; Returns the latest vitals for a selected patient
 ; Input:
 ;  GMVDFN  = A pointer to the Patient file (#2) (Required)
 ;  GMVFMT  = Format of returned data (Optional)
 ;            1 - IENs (default), 2 - Abbreviations, 3 - Full Names
 ;  GMVABR  = Abbreviations of vital types to return (Optional)
 ;            "^T^P^R^PO2^BP^HT^WT^CVP^CG^PN^" (Default)
 ;            "~ALL~" to return all vital types
 ;  GMVMSYS = Measurement system (Optional)
 ;            M = Metric, C - US Customary (Default)
 ; Output:
 ;  RESULT() = VitalMeasurementIEN ^ DateTimeTaken ^ PatientDFN ^   
 ;             VitalType ^ DateTimeEntered ^ HospitalLocation ^     
 ;             EnteredBy ^ Measurement ^ EnteredInError ^           
 ;             EnteredInErrorBy ^                                   
 ;             Qualifier1 ; Qualifier2 ; ... ^                      
 ;             EnteredInErrorReason1 ; EnteredInErrorReason2 ; ... ^
 D EN1^GMVDCEXT("^TMP(""GMV"",$J)",GMVDFN,$G(GMVFMT),$G(GMVABR),0,"","",$G(GMVMSYS),0)
 S RESULT=$NA(^TMP("GMV",$J))
 Q
 ;
EN6(RESULT,GMVDFN,GMVFMT,GMVABR,GMVBEG,GMVEND,GMVMSYS,GMVEE) ;
 ; RPC: GMVDC GET VITALS
 ; Returns vitals for a selected patient and date/time range
 ; Input:
 ;  GMVDFN  = A pointer to the Patient file (#2) (Required)
 ;  GMVFMT  = Format of returned data (Optional)
 ;            1 - IENs (default), 2 - Abbreviations, 3 - Full Names
 ;  GMVABR  = Abbreviations of vital types to return (Optional)
 ;            "^T^P^R^PO2^BP^HT^WT^CVP^CG^PN^" (Default)
 ;            "~ALL~" to return all vital types
 ;  GMVBEG  = Beginning date for all vitals (Not used for GMVALL = 0)
 ;  GMVEND  = Ending    date for all vitals (Not used for GMVALL = 0)
 ;  GMVMSYS = Measurement system (Optional)
 ;            M = Metric, C - US Customary (Default)
 ;  GMVEE   = Include entered in error records (Optional)
 ;            (0 - No (Default), 1 - Yes)
 ;
 ; Output:
 ;  RESULT() = VitalMeasurementIEN ^ DateTimeTaken ^ PatientDFN ^   
 ;             VitalType ^ DateTimeEntered ^ HospitalLocation ^     
 ;             EnteredBy ^ Measurement ^ EnteredInError ^           
 ;             EnteredInErrorBy ^                                   
 ;             Qualifier1 ; Qualifier2 ; ... ^                      
 ;             EnteredInErrorReason1 ; EnteredInErrorReason2 ; ... ^
 D EN1^GMVDCEXT("^TMP(""GMV"",$J)",GMVDFN,$G(GMVFMT),$G(GMVABR),1,$G(GMVBEG),$G(GMVEND),$G(GMVMSYS),$G(GMVEE))
 S RESULT=$NA(^TMP("GMV",$J))
 Q
 ;
EN7(RESULT,GMVITTYP) ;
 ; RPC: GMVDC GET VITALS HELP
 ; Get help text for a selected vital type
 ; Input:
 ;  GMVITTYP = A pointer to GMRV Vital Type file (#120.51) (Optional)
 ; Output:
 ;  RESULT() = Help text
 S GMVITTYP=$$VITIEN^GMVDCUTL(GMVITTYP)
 S GMVITTYP=$P($G(^GMRD(120.51,+GMVITTYP,0)),U,2)
 I GMVITTYP]"" D
 . D HELP^GMVDCHLP(.RESULT,GMVITTYP)
 . S RESULT(0)="OK"
 . I $O(RESULT(0))'>0 S RESULT(1)="No help text available."
 . Q
 E  D
 . S RESULT(0)="ERROR"
 . S RESULT(1)="ERROR: Missing or invalid Vital Type parameter"
 . Q
 Q
 ;
EN8(RESULT,GMVPARAM) ;
 ; RPC: GMVDC SAVE VITALS
 ; Saves vitals data
 N GMVDFN,GMVDTDUN,GMVDTENT,GMVENTBY,GMVERRBY,GMVHOSPL,GMVMSYS K RESULT
 S RESULT(0)="OK"
 S GMVDATA="^TMP(""GMV"",$J)"
 D FMTPARAM^GMVDCUTL(.GMVPARAM,GMVDATA)
 D EN1^GMVDCVAL(.RESULT,GMVDATA)
 I $G(RESULT(0))="OK" D EN1^GMVDCSAV(.RESULT,GMVDATA)
 K RESULT(-1)
 Q
 ;
EN9(RESULT,GMVPARAM) ;
 ; RPC: GMVDC VALIDATE VITALS
 ; Validates vitals data
 N GMVDFN,GMVDTDUN,GMVDTENT,GMVENTBY,GMVERRBY,GMVHOSPL,GMVMSYS K RESULT
 S RESULT(0)="OK"
 S GMVDATA="^TMP(""GMV"",$J)"
 D FMTPARAM^GMVDCUTL(.GMVPARAM,GMVDATA)
 D EN1^GMVDCVAL(.RESULT,GMVDATA)
 K RESULT(-1)
 Q
 ;
EN10(RESULT,GMVMSYS) ;
 ; RPC: GMVDC GET ABNORMAL RANGES
 ; Returns the abnormal ranges for the vital types
 ; Input:
 ;  GMVMSYS = Measurement system (Optional)
 ;            M = Metric, C - US Customary (Default)
 ; Output:
 ;  RESULT(1) = TEMP-HIGH ^ TEMP-LOW ^ PULSE-HIGH ^ PULSE-LOW ^
 ;              RESP-HIGH ^ RESP-LOW ^ SYSTOLIC-HIGH ^ DIASTOLIC-HIGH ^
 ;              SYSTOLIC-LOW ^ DIASTOLIC-LOW ^ CVP-HIGH ^ CVP-LOW ^
 ;              O2SAT-LOW
 N GMVABBR,GMVALUE,GMVPIECE K RESULT
 S GMVMSYS=$$MEASYS^GMVDCUTL($G(GMVMSYS))
 S RESULT(0)="OK"
 S RESULT(1)=$P($G(^GMRD(120.57,1,1)),U,1,13)
 F GMVPIECE=1,2,11,12 D
 . S GMVABBR=$P("T^T^^^^^^^^^CVP^CVP",U,GMVPIECE)
 . S GMVALUE=$P(RESULT(1),U,GMVPIECE)
 . S GMVALUE=$$CNV^GMVDCCNV(GMVALUE,GMVMSYS,"G",GMVABBR)
 . S $P(RESULT(1),U,GMVPIECE)=GMVALUE
 . Q
 Q
