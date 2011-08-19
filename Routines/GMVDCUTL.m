GMVDCUTL ;HOIFO/DAD,FT-VITALS COMPONENT: UTILITIES ;9/29/00  09:18
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls          (supported)
 ;
VITIEN(GMVITTYP) ;
 ; Convert a vital type abbr / PCE abbr / name to an IEN
 ; Input:
 ;  A vital type IEN or abbr or PCE abbr or name
 ; Output:
 ;  A pointer to the GMRV Vital Type file (#120.51)
 N GMVABR,GMVNAM,GMVPCE
 S GMVABR=$S($G(GMVITTYP)]"":+$O(^GMRD(120.51,"C",GMVITTYP,0)),1:0)
 S GMVPCE=$S($G(GMVITTYP)]"":+$O(^GMRD(120.51,"APCE",GMVITTYP,0)),1:0)
 S GMVNAM=$S($G(GMVITTYP)]"":+$O(^GMRD(120.51,"B",GMVITTYP,0)),1:0)
 S GMVD0=$S(GMVITTYP=+GMVITTYP:GMVITTYP,GMVABR:GMVABR,GMVPCE:GMVPCE,GMVNAM:GMVNAM,1:-1)
 S GMVD0=$S($D(^GMRD(120.51,GMVD0,0))#2:GMVD0,1:-1)
 Q GMVD0
 ;
QUAIEN(GMVITQUA) ;
 ; Convert a vital qualifier name to an IEN
 ; Input:
 ;  A vital qualifier IEN or name or synonym
 ; Output:
 ;  A pointer to the GMRV Vital Qualifier file (#120.52)
 N GMVD0,GMVIEN,GMVNAM
 S GMVNAM=$S($G(GMVITQUA)]"":+$O(^GMRD(120.52,"B",GMVITQUA,0)),1:-1)
 S GMVD0=$S(GMVITQUA=+GMVITQUA:GMVITQUA,GMVNAM>0:GMVNAM,1:-1)
 S GMVD0=$S($D(^GMRD(120.52,GMVD0,0))#2:GMVD0,1:-1)
 I GMVD0'>0,$G(GMVITQUA)]"" D
 . S GMVIEN=0
 . F  S GMVIEN=$O(^GMRD(120.52,GMVIEN)) Q:GMVIEN'>0  D  Q:GMVD0>0
 .. I $P($G(^GMRD(120.52,GMVIEN,0)),U,2)=GMVITQUA S GMVD0=GMVIEN
 .. Q
 . Q
 Q GMVD0
 ;
CATIEN(GMVITCAT) ;
 ; Convert a vital category name to an IEN
 ; Input:
 ;  A vital category IEN or name
 ; Output:
 ;  A pointer to the GMRV Vital Category file (#120.53)
 N GMVCAT,GMVD0
 S GMVCAT=$S($G(GMVITCAT)]"":+$O(^GMRD(120.53,"B",GMVITCAT,0)),1:0)
 S GMVD0=$S(GMVITCAT=+GMVITCAT:GMVITCAT,GMVCAT:GMVCAT,1:-1)
 S GMVD0=$S($D(^GMRD(120.53,GMVD0,0))#2:GMVD0,1:-1)
 Q GMVD0
 ;
REAIEN(GMVITREA) ;
 ; Convert an entered in error reason external form to an internal form
 ; Input:
 ;  A vital entered in error reason in internal/external form
 ; Output:
 ;  A vital entered in error reason in internal form
 N GMVD0,GMVDATA
 S GMVDATA=$$GET1^DID(120.506,.01,"","POINTER")
 S GMVITREA(0)=$P(GMVDATA,":"_GMVITREA_";")
 S GMVITREA(0)=$P(GMVITREA(0),";",$L(GMVITREA(0),";"))
 S GMVD0=$S(GMVITREA=+GMVITREA:GMVITREA,GMVITREA(0):GMVITREA(0),1:-1)
 S GMVD0=$S(";"_GMVDATA[(";"_GMVD0_":"):GMVD0,1:-1)
 Q GMVD0
 ;
MEASYS(GMVMSYS) ;
 ; Validates and returns the measurement system
 ; Input:
 ;  GMVMSYS = Measurement system (Optional)
 ;            M = Metric, C - US Customary (Default)
 ; Output:
 ;  M = Metric, C - US Customary (Default)
 S GMVMSYS=$$UP^XLFSTR($G(GMVMSYS))
 Q $S("^C^M^"[(U_GMVMSYS_U):GMVMSYS,1:"C")
 ;
FMTPARAM(GMVIN,GMVOUT) ;
 ; Reformat the validate/save list parameter
 ; Input:
 ;  GMVIN  = The list parameter data as it comes from the RPC broker
 ;           See remote procedure GMV SAVE VITALS or GMV VALIDATE VITALS
 ;           for a description of the format of the data
 ;  GMVOUT = A closed array reference used to store the reformatted data
 ; Output:
 ;  @GMVOUT@("V",##)    = Measurements
 ;  @GMVOUT@("I",##)    = Entered in error IENS
 ;  @GMVOUT@("Q",##,##) = Qualifiers
 ;  @GMVOUT@("R",##,##) = Entered in error reasons
 ;  GMVDFN              = PatientDFN
 ;  GMVDTDUN            = DateTimeTaken
 ;  GMVHOSPL            = HospitalLocation
 ;  GMVDTENT            = DateTimeEntered
 ;  GMVENTBY            = EnteredBy
 ;  GMVERRBY            = EnteredInErrorBy
 ;  GMVMSYS             = MeasurementSystem
 ;
 N GMV,GMVDATA,GMVMAJOR,GMVMINOR,GMVRET,GMVS2V,GMVTYPE,GMVVAR,GMVVARTY
 K @GMVOUT
 F GMV=1:1 S GMVDATA=$P($T(SUBVAR+GMV),";;",2) Q:GMVDATA=""  D
 . S GMVVAR=$P(GMVDATA,U,2),GMVVARTY=$P(GMVDATA,U,3)
 . S GMVS2V($P(GMVDATA,U))=GMVVAR_U_GMVVARTY
 . S @(GMVVAR_"=-1")
 . Q
 S GMV=""
 F  S GMV=$O(GMVIN(GMV)) Q:GMV=""  D
 . I (GMV?1U1"^"1.N)!(GMV?1U1"^"1.N1"^"1.N) D
 .. S GMVTYPE=$P(GMV,U),GMVMAJOR=$P(GMV,U,2),GMVMINOR=$P(GMV,U,3)
 .. I "^I^V^"[(U_GMVTYPE_U) D  ; Entered in Error IENS & Measurements
 ... S @GMVOUT@(GMVTYPE,GMVMAJOR)=GMVIN(GMV)
 ... Q
 .. I "^Q^R^"[(U_GMVTYPE_U) D  ; Qualifiers & Reasons entered in error
 ... S @GMVOUT@(GMVTYPE,GMVMAJOR,GMVMINOR)=GMVIN(GMV)
 ... Q
 .. Q
 . E  D
 .. S GMVDATA=$G(GMVS2V(GMV))
 .. S GMVVAR=$P(GMVDATA,U),GMVVARTY=$P(GMVDATA,U,2)
 .. I GMVVARTY="D" D
 ... K GMVRET
 ... D DT^DILF("RSTX",GMVIN(GMV),.GMVRET)
 ... S GMVIN(GMV)=$G(GMVRET)
 ... Q
 .. I GMVVARTY="U",$$UP^XLFSTR(GMVIN(GMV))="DUZ" D
 ... S GMVIN(GMV)=DUZ
 ... Q
 .. I GMVVAR]"",GMVIN(GMV)]"" S @(GMVVAR_"="""_GMVIN(GMV)_"""")
 .. Q
 . Q
 Q
SUBVAR ;;Subscript ^ Variable ^ DataType (D-Date/Time, L-Literal, U-User)
 ;;PatientDFN^GMVDFN^L
 ;;DateTimeTaken^GMVDTDUN^D
 ;;HospitalLocation^GMVHOSPL^L
 ;;DateTimeEntered^GMVDTENT^D
 ;;EnteredBy^GMVENTBY^U
 ;;EnteredInErrorBy^GMVERRBY^U
 ;;MeasurementSystem^GMVMSYS^L
 ;;
