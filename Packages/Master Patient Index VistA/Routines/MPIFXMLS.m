MPIFXMLS ;OAK/ELZ - MPIF HEALTHEVET XML BUILDING - SEARCH ID (PATIENT) ;19 APR 2012
 ;;1.0;MASTER PATIENT INDEX VISTA;**56**;30 Apr 99;Build 2
 ;
PATIENT(RETURN,MPIID) ; - look up and return PV data from fully qualified id
 ;  such as 1000323423^PI^500^USVHA
 ;
 ; RETURN is in MPI array format if not found RETURN=-1
 ;
 ; $$HL7TFM^XLFDT - #10103
 ;
 N MPIXML,MPIXMLR,MPID
 S RETURN=1
 S MPIXML=$$XMLS(MPIID)
 D POST^MPIFHWSC(MPIXML,.MPIXMLR)
 D PARSE(.RETURN,.MPIXMLR)
 ;
 ; must have name, dob and ssn
 I '$L($G(RETURN("Surname","NAME")))!('$L($G(RETURN("DOB"))))!('$L($G(RETURN("SSN")))) K RETURN S RETURN=-1 Q
 ;
 ; convert dob to fm format
 S RETURN("DOB")=$$HL7TFM^XLFDT($G(RETURN("DOB")))
 ;
 Q
 ;
CARDPV(RETURN,MPICARD,EDIPI) ; - look up PV data from a VIC card number
 ;  pass in the VIC card number or EDIPI in MPICARD,
 ;       EDIPI if set to 1 to indicate EDIPI lookup
 ;  this will return the array:
 ;          RETURN(.01)= patient name
 ;          RETURN(.02)= patient sex
 ;          RETURN(.03)= patient dob
 ;          RETURN(.09)= patient ssn
 ;          RETURN(.092)= patient place of birth (city)
 ;          RETURN(.093)= patient place of birth (state)
 ;          RETURN(.2403)= mother's maiden name
 ;          RETURN(991.01)= patient icn
 ;          RETURN(991.02)= patient icn checksum
 ;  or if not found RETURN=-1
 ;
 N MPIXML,MPIDATA,MPIXMLR
 S MPICARD=MPICARD_$S(EDIPI:"^NI^200DOD^USDOD",1:"^PI^742V1^USVHA")
 D PATIENT(.MPIDATA,MPICARD)
 S RETURN=MPIDATA I RETURN=-1 Q
 D DPTLK(.RETURN,.MPIDATA)
 Q
 ;
DPTLK(RETURN,MPIDATA) ; - sets up return data for DPTLK needs
 N MPISTATE
 S MPISTATE=$G(MPIDATA("POBState"))
 S:$L(MPISTATE) MPISTATE=$O(^DIC(5,"C",MPISTATE,0))
 ;
 S RETURN(.01)=$G(MPIDATA("Surname","NAME"))_","_$G(MPIDATA("FirstName","NAME"))
 S RETURN(.02)=$G(MPIDATA("Gender"))
 S RETURN(.03)=$G(MPIDATA("DOB"))
 S RETURN(.09)=$G(MPIDATA("SSN"))
 S RETURN(.092)=$G(MPIDATA("POBCity"))
 ; setting up state to auto stuff (additional slash) with internal value
 S RETURN(.093)=$S(MPISTATE:"/"_MPISTATE,1:"")
 S RETURN(.2403)=$G(MPIDATA("Surname","MMN"))
 S RETURN(991.01)=$P($G(MPIDATA("MPIID")),"V")
 S RETURN(991.02)=$P($P($G(MPIDATA("MPIID")),"^"),"V",2)
 ;
 Q
 ;
XMLS(MPIID) ; setup xml to search
 ; MPIID =fully qualified ID to search for a patient delaminated with "^"
 ;    Returns XML for the search
 ;
 ; $$SITE^VASITE - #10112
 ; $$PARAM^HLCS2 - #3552 (need)
 ;
 N MPIXML,MPISITE,MPIPCODE
 S MPISITE=$P($$SITE^VASITE,"^",3)
 S MPIPCODE=$P($$PARAM^HLCS2,"^",3)
 S MPIXML="<PRPA_IN201305UV02 xmlns=""urn:hl7-org:v3"" "
 S MPIXML=MPIXML_"xmlns:ps=""http://vaww.oed.oit.domain.ext"" "
 S MPIXML=MPIXML_"xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"
 S MPIXML=MPIXML_""" xsi:schemaLocation=""urn:hl7-org:v3 ../../schema/"
 S MPIXML=MPIXML_"HL7V3/NE2008/multicacheschemas/PRPA_IN201305UV02.xsd"
 S MPIXML=MPIXML_""" ITSVersion=""XML_1.0"">"
 S MPIXML=MPIXML_"<id root=""1.2.840.114350.1.13.0.1.7.1.1"" "
 S MPIXML=MPIXML_"extension=""MCID-"_$J_"""/>"
 S MPIXML=MPIXML_"<creationTime value="""_$$FMTHL7^XLFDT($$NOW^XLFDT)_"""/>"
 S MPIXML=MPIXML_"<interactionId root=""2.16.840.1.113883.1.6"" "
 S MPIXML=MPIXML_"extension=""PRPA_IN201305UV02""/>"
 S MPIXML=MPIXML_"<processingCode code="""_MPIPCODE_"""/>"
 S MPIXML=MPIXML_"<processingModeCode code=""T""/>"
 S MPIXML=MPIXML_"<acceptAckCode code=""AL""/>"
 S MPIXML=MPIXML_"<receiver typeCode=""RCV"">"
 S MPIXML=MPIXML_"<device classCode=""DEV"" "
 S MPIXML=MPIXML_"determinerCode=""INSTANCE"">"
 S MPIXML=MPIXML_"<id root=""2.16.840.1.113883.4.349""/>"
 S MPIXML=MPIXML_"<telecom value=""http://servicelocation/PDQuery""/>"
 S MPIXML=MPIXML_"</device></receiver><sender typeCode=""SND"">"
 S MPIXML=MPIXML_"<device classCode=""DEV"" determinerCode=""INSTANCE"">"
 S MPIXML=MPIXML_"<id extension="""_MPISITE_""""
 S MPIXML=MPIXML_" root=""2.16.840.1.113883.4.349""/>"
 S MPIXML=MPIXML_"</device></sender><controlActProcess "
 S MPIXML=MPIXML_"classCode=""CACT"" moodCode=""EVN"">"
 S MPIXML=MPIXML_"<code code=""PRPA_TE201305UV02"" "
 S MPIXML=MPIXML_"codeSystem=""2.16.840.1.113883.1.6""/>"
 S MPIXML=MPIXML_"<queryByParameter><queryId extension="""_$J_""""
 S MPIXML=MPIXML_" root=""1.2.840.114350.1.13.28.1.18.5.999""/>"
 S MPIXML=MPIXML_"<statusCode code=""new""/>"
 S MPIXML=MPIXML_"<initialQuantity value=""1""/>"
 S MPIXML=MPIXML_"<parameterList><id extension="""_MPIID
 S MPIXML=MPIXML_""" root=""2.16.840.1.113883.4.349""/></parameterList>"
 S MPIXML=MPIXML_"</queryByParameter></controlActProcess>"
 S MPIXML=MPIXML_"</PRPA_IN201305UV02>"
 Q MPIXML
 ;
PARSE(MPIDATA,MPIXML) ; - parse the data
 ;
 ; EN^MXMLPRSE - #4149
 ;
 K ^TMP($J,"MPIFXMLS")
 N MPICB,MPIUSE,MPIVAR,MPIALIAS
 S MPIALIAS=0
 S MPICB("STARTELEMENT")="SE^MPIFXMLS"
 S MPICB("CHARACTERS")="VALUE^MPIFXMLS"
 S ^TMP($J,"MPIFXMLS",1)=MPIXML
 D EN^MXMLPRSE($NA(^TMP($J,"MPIFXMLS")),.MPICB)
 K ^TMP($J,"MPIFXMLS")
 Q
 ;
SE(MPIN,MPIA) ; - used for the parser to call back with STARTELEMENT
 ;
 ; just to protect the process
 S MPIN=$G(MPIN)
 S MPIA("extension")=$G(MPIA("extension"))
 S MPIA("code")=$G(MPIA("code"))
 ;
 ; now look for the data I need
 I MPIN="id",$E(MPIA("extension"),1,4)="MCID" Q
 I MPIN="id",MPIA("extension")?3N.NA Q
 I MPIN="id",MPIA("extension")="" Q
 I MPIN="statusCode",'$D(MPIDATA("SSNStatus")) D  Q
 . S MPIDATA("SSNStatus")=$G(MPIA("code"))
 I MPIN="id",MPIA("extension")["NI^200M^USVHA^P" D  Q
 . S MPIDATA("MPIID")=MPIA("extension")
 I MPIN="id",MPIA("extension")["^SS" D  Q
 . S MPIDATA("SSN")=$P(MPIA("extension"),"^")
 I MPIN="name" D  Q
 . S MPIUSE=$G(MPIA("use"),0)
 . S MPIUSE=$S(MPIUSE="L":"NAME",MPIUSE="C":"MMN",MPIUSE="P":"ALIAS",1:MPIUSE)
 . S MPIVAR="MPIDATA(""FirstName"","""_MPIUSE_""")"
 . ; P = alias name, need additional subscript
 . I MPIUSE="ALIAS" D
 .. S MPIALIAS=MPIALIAS+1
 .. S MPIVAR="MPIDATA(""FirstName"","""_MPIUSE_","_MPIALIAS_""")"
 . S @MPIVAR=""
 I MPIN="family" D  Q
 . S MPIVAR="MPIDATA(""Surname"","""_$G(MPIUSE,0)_$S($G(MPIUSE)="ALIAS":","_MPIALIAS,1:"")_""")"
 . S @MPIVAR=""
 I MPIN="administrativeGenderCode" S MPIDATA("Gender")=MPIA("code") Q
 I MPIN="birthTime" S MPIDATA("DOB")=$G(MPIA("value")) Q
 I MPIN="city" S MPIVAR="MPIDATA(""POBCity"")",@MPIVAR="" Q
 I MPIN="state" S MPIVAR="MPIDATA(""POBState"")",@MPIVAR="" Q
 I MPIN="country" S MPIVAR="MPIDATA(""POBCountry"")",@MPIVAR="" Q
 I MPIN="multipleBirthInd" S MPIDATA("MBI")=MPIA("value") Q
 Q
 ;
VALUE(MPIT) ; - used by the parser to call back with CHARACTERS
 S:$D(MPIVAR) @MPIVAR=@MPIVAR_$S($L(@MPIVAR):" ",1:"")_MPIT
 Q
