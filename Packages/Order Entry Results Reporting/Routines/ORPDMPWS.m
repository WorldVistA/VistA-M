ORPDMPWS ;ISP/LMT - PDMP Web Service APIs ;Nov 04, 2020@14:19:06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**519,498**;Dec 17, 1997;Build 38
 ;
 ; SAC EXEMPTION 20200131-02 : non-ANSI standard M code
 ;
 ; This routine uses the following ICRs:
 ;  #4984 - File 8932.1, Field 90002   (private)
 ;
 Q
 ;
 ; Make PDMP Web Service call
EN(ORRETURN,DFN,ORUSER,ORDELEGATEOF,ORINST) ;
 ;
 ; Returns:
 ;   @ORRETURN@(0) = Status ^ Flag if data shared (1/0) ^ VDIF Session ID
 ;          Note: Status can be one of the following values:
 ;                 1 - success
 ;                -1 - PDMP down, or other reason that didn't even attempt to connect
 ;                -2 - error connecting
 ;                -3 - connected - but error returned by PDMP
 ;   @ORRETURN@(1) = If success: Report URL; If error: error message
 ;
 ; If error: error message to display to the user
 ;   @ORRETURN@("ERR") = If errors, more details about the error
 ;
 N $ES,$ET,ORDATASHARED
 ;
 S ORRETURN=$NA(^TMP("ORPDMP",$J))
 K ^TMP("ORPDMP",$J)
 ;
 S $ET="D ERRHNDL^ORPDMPWS"
 ;
 ; Patient Request
 D REQUEST(DFN,ORUSER,ORDELEGATEOF,ORINST)
 ;
 Q
 ;
 ;
ERRHNDL ;
 ;
 ; ZEXCEPT: XOBERR,ORDATASHARED
 N %ZT
 ;
 K ^TMP("ORPDMP",$J)
 S ^TMP("ORPDMP",$J,0)="-3^"_+$G(ORDATASHARED)
 S ^TMP("ORPDMP",$J,1)="VistA (M) error encountered. Log a ticket, so support can check the error trap for more info."
 S ^TMP("ORPDMP",$J,"ERR",1)=$G(^TMP("ORPDMP",$J,1))
 ;
 I $G(XOBERR)="" S XOBERR=$$EOFAC^XOBWLIB()
 S %ZT("^TMP(""ORPDMPIN"",$J)")=""
 S %ZT("^TMP(""ORPDMP"",$J)")=""
 D ZTER^XOBWLIB(XOBERR)
 D UNWIND^%ZTER
 ;
 Q
 ;
 ; Initiate PDMP REST request
REQUEST(DFN,ORUSER,ORDELEGATEOF,ORINST) ;
 ;
 ; ZEXCEPT: ORDATASHARED
 N ORERR,ORI,OROPENTIMEOUT,ORRESOURCE,ORRESTREQ,ORRET,ORSERVER,ORXML
 ;
 S ORSERVER="PDMP SERVER"
 I '$$PROD^XUPROD S ORSERVER="PDMP TEST SERVER"
 S ORRESTREQ=$$GETREST^XOBWLIB("PDMP WEB SERVICE",ORSERVER)
 ;
 S ORRESTREQ.ContentType="application/xml"
 D REQUESTXML(.ORXML,DFN,ORUSER,ORDELEGATEOF,ORINST)
 S ORI=0
 F  S ORI=$O(ORXML(ORI)) Q:'ORI  D
 . D ORRESTREQ.EntityBody.Write($G(ORXML(ORI)))
 ;
 S ORRESOURCE="/PDMP/patient"
 S OROPENTIMEOUT=+$$GET^XPAR("ALL","OR PDMP OPEN TIMEOUT",1,"I")
 I OROPENTIMEOUT'>0 S OROPENTIMEOUT=10
 S ORRESTREQ.OpenTimeout=OROPENTIMEOUT
 S ORRET=$$POST^XOBWLIB(ORRESTREQ,ORRESOURCE,.ORERR,0)
 S ORDATASHARED=1  ; Flag so that we know we might have shared patient's data. Used by ERRHNDL in case M error encountered.
 ;
 K ^TMP("ORPDMPIN",$J)
 D PROCRESPONSE(ORRET,ORRESTREQ,.ORERR)
 K ^TMP("ORPDMPIN",$J)
 ;
 Q
 ;
 ; Process response from server
PROCRESPONSE(ORRET,ORRESTREQ,ORERR) ;
 ;
 N ORERRARR,ORERRCODE,ORERRDETAILS,ORERRMSG,ORERRORIGIN,ORHTTPSTAT,ORI,ORJ,ORLENGTH,ORLN
 N ORREPORT,ORRESPONSE,ORRESULTS,ORSHARED,ORSESSION,ORTXT
 ;
 S ORRESPONSE=ORRESTREQ.HttpResponse
 S ORHTTPSTAT=""
 I $G(ORRESPONSE)'="" S ORHTTPSTAT=ORRESPONSE.StatusCode
 ;
 ; Error occurred making web service call
 I 'ORRET!(ORHTTPSTAT'=200) D  Q
 . D ERR2ARR^XOBWLIB(.ORERR,.ORERRARR)
 . S ORERRMSG=""
 . S ORSHARED=0
 . S ORERRCODE=-2
 . ;
 . ;code: 6059 - Unable to open TCP/IP socket to server
 . I $G(ORERRARR("code"))=6059 D
 . . S ORERRMSG="Error connecting to PDMP server."
 . ;code: 6085 - Unable to write to socket with SSL/TLS configuration (when conf doesn't exist or is not supported by server)
 . I $G(ORERRARR("code"))=6085 D
 . . S ORERRMSG="Error connecting to PDMP server. Problem with SSL/TLS configuration."
 . ;code: 5922 - Timed out waiting for response
 . I $G(ORERRARR("code"))=5922 D
 . . S ORSHARED=1
 . . S ORERRMSG="Timed out waiting for response from PDMP server."
 . ;HTTP Status Code = 404 - if couldn't authenticate (Normally 401 is used for this; but this is what they return)
 . I ORHTTPSTAT=404 D
 . . S ORERRMSG="Error connecting to PDMP server. Problem authenticating."
 . ;HTTP Status Code = 500 - or other errors
 . I ORERRMSG="" D
 . . S ORERRCODE=-3
 . . S ORERRMSG="Unexpected error returned by PDMP middleware when processing the PDMP request."
 . ;
 . S ^TMP("ORPDMP",$J,0)=ORERRCODE_U_ORSHARED
 . S ^TMP("ORPDMP",$J,1)=ORERRMSG
 . ; Return more error info in ERR node
 . S ^TMP("ORPDMP",$J,"ERR",1)=$G(^TMP("ORPDMP",$J,1))
 . S ORLN=1
 . S ORI=""
 . F  S ORI=$O(ORERRARR(ORI)) Q:ORI=""  D
 . . S ORTXT=$G(ORERRARR(ORI))
 . . I ORTXT'="" D
 . . . S ORLN=ORLN+1
 . . . S ^TMP("ORPDMP",$J,"ERR",ORLN)=ORI_": "_ORTXT
 . . S ORJ=""
 . . F  S ORJ=$O(ORERRARR(ORI,ORJ)) Q:ORJ=""  D
 . . . S ORTXT=$G(ORERRARR(ORI,ORJ))
 . . . I ORTXT'="" D
 . . . . S ORLN=ORLN+1
 . . . . S ^TMP("ORPDMP",$J,"ERR",ORLN)=ORI_": "_ORTXT
 . S ORLN=ORLN+1
 . S ^TMP("ORPDMP",$J,"ERR",ORLN)="HTTP Status Code: "_ORHTTPSTAT
 ;
 ; Success (200) - read in response
 S ORI=0
 S ORLENGTH=245
 F  Q:ORRESPONSE.Data.AtEnd  D
 . S ORI=ORI+1
 . S ^TMP("ORPDMPIN",$J,ORI)=ORRESPONSE.Data.Read(ORLENGTH)
 ;
 D PARSEXML(.ORRESULTS,$NA(^TMP("ORPDMPIN",$J)))
 S ORSHARED=$G(ORRESULTS("DataDisclosed"))
 S ORSHARED=$S(ORSHARED="yes":1,1:0)
 S ORREPORT=$G(ORRESULTS("ReportLink"))
 S ORERRCODE=$G(ORRESULTS("Code"))
 S ORERRMSG=$G(ORRESULTS("Message"))
 S ORERRDETAILS=$G(ORRESULTS("Details"))
 S ORERRORIGIN=$G(ORRESULTS("Origin"))
 S ORSESSION=$G(ORRESULTS("Session"))
 ;
 ; Report URL returned - Success
 I ORREPORT'="" D  Q
 . S ^TMP("ORPDMP",$J,0)=1_U_ORSHARED_U_ORSESSION
 . S ^TMP("ORPDMP",$J,1)=ORREPORT
 ;
 ; Error returned by server in response XML message
 I ORERRMSG'="" D  Q
 . S ^TMP("ORPDMP",$J,0)=-3_U_ORSHARED_U_ORSESSION
 . S ^TMP("ORPDMP",$J,1)=ORERRMSG
 . S ^TMP("ORPDMP",$J,"ERR",1)="Code: "_ORERRCODE
 . S ^TMP("ORPDMP",$J,"ERR",2)="Message: "_ORERRMSG
 . S ^TMP("ORPDMP",$J,"ERR",3)="Origin: "_ORERRORIGIN
 . S ^TMP("ORPDMP",$J,"ERR",4)="Details: "_ORERRDETAILS
 ;
 ; If Report URL is null and ErrorMsg is null, then something is wrong. Perhaps error parsing xml
 I $G(ORRESULTS("DataDisclosed"))="" S ORSHARED=1
 S ^TMP("ORPDMP",$J,0)=-3_U_ORSHARED_U_ORSESSION
 S ^TMP("ORPDMP",$J,1)="Error processing PDMP results."
 S ^TMP("ORPDMP",$J,"ERR",1)=$G(^TMP("ORPDMP",$J,1))
 S ^TMP("ORPDMP",$J,"ERR",2)="XML:"
 S ORI=2
 S ORJ=0
 F  S ORJ=$O(^TMP("ORPDMPIN",$J,ORJ)) Q:'ORJ  D
 . S ORI=ORI+1
 . S ^TMP("ORPDMP",$J,"ERR",ORI)=$G(^TMP("ORPDMPIN",$J,ORJ))
 ;
 Q
 ;
 ; Return XML to send in REST query
REQUESTXML(ORXML,DFN,ORUSER,ORDELEGATEOF,ORINST) ;
 ;
 N ORADDRESS,ORCELL,OREMAIL,ORICN,ORINSTINFO,ORLINE,ORNAME,ORPERSCLASS,ORPROV,ORTEMPADD,ORTEMPPHONE
 N VADM,VAPA,VAPTYP,VAROOT,VATEST,VAHOW
 ;
 S ORUSER=$G(ORUSER,DUZ)
 S ORDELEGATEOF=$G(ORDELEGATEOF)
 S ORINST=$G(ORINST,DUZ(2))
 I ORINST="" S ORINST=$$KSP^XUPARAM("INST")
 ;
 S ORLINE=0
 ;
 S ORXML($$INCLINE)="<PatientReportRequest>"
 ;
 S ORXML($$INCLINE)="<Provider>"
 S ORPROV=ORUSER
 I $G(ORDELEGATEOF) S ORPROV=ORDELEGATEOF
 S ORPERSCLASS=$$PERSCLASS(ORPROV)
 S ORXML($$INCLINE)="<X12Code>"_$$SYMENC^MXMLUTL($P(ORPERSCLASS,U,2))_"</X12Code>"
 S ORXML($$INCLINE)="<VACode>"_$$SYMENC^MXMLUTL($P(ORPERSCLASS,U,1))_"</VACode>"
 S ORNAME=$$GET1^DIQ(200,ORPROV_",",.01)  ; ICR 10060 (supported)
 D NAMECOMP^XLFNAME(.ORNAME)
 S ORXML($$INCLINE)="<FirstName>"_$$SYMENC^MXMLUTL(ORNAME("GIVEN"))_"</FirstName>"
 S ORXML($$INCLINE)="<LastName>"_$$SYMENC^MXMLUTL(ORNAME("FAMILY"))_"</LastName>"
 S ORXML($$INCLINE)="<DEANumber>"_$$SYMENC^MXMLUTL($$USERDEA^ORPDMP(ORPROV))_"</DEANumber>"
 S ORXML($$INCLINE)="<NPINumber>"_$$SYMENC^MXMLUTL($$USERNPI^ORPDMP(ORPROV))_"</NPINumber>"
 S ORXML($$INCLINE)="</Provider>"
 ;
 I ORDELEGATEOF D
 . S ORPERSCLASS=$$PERSCLASS(ORUSER)
 . S ORXML($$INCLINE)="<Delegate>"
 . S ORXML($$INCLINE)="<X12Code>"_$$SYMENC^MXMLUTL($P(ORPERSCLASS,U,2))_"</X12Code>"
 . S ORXML($$INCLINE)="<VACode>"_$$SYMENC^MXMLUTL($P(ORPERSCLASS,U,1))_"</VACode>"
 . K ORNAME
 . S ORNAME=$$GET1^DIQ(200,ORUSER_",",.01)  ; ICR 10060 (supported)
 . D NAMECOMP^XLFNAME(.ORNAME)
 . S ORXML($$INCLINE)="<FirstName>"_$$SYMENC^MXMLUTL(ORNAME("GIVEN"))_"</FirstName>"
 . S ORXML($$INCLINE)="<LastName>"_$$SYMENC^MXMLUTL(ORNAME("FAMILY"))_"</LastName>"
 . D GETEMAIL^ORPDMP(.OREMAIL,ORUSER)
 . S ORXML($$INCLINE)="<SystemID>"_$$SYMENC^MXMLUTL(OREMAIL)_"</SystemID>"
 . S ORXML($$INCLINE)="</Delegate>"
 ;
 S ORXML($$INCLINE)="<UserLocation>"
 S ORXML($$INCLINE)="<Name>"_$$SYMENC^MXMLUTL($$NAME^XUAF4(ORINST))_"</Name>"
 S ORINSTINFO=$$INSTINFO(ORINST)
 S ORXML($$INCLINE)="<DEANumber>"_$$SYMENC^MXMLUTL($P(ORINSTINFO,U,1))_"</DEANumber>"
 S ORXML($$INCLINE)="<NPINumber>"_$$SYMENC^MXMLUTL($P(ORINSTINFO,U,2))_"</NPINumber>"
 S ORXML($$INCLINE)="<StateCode>"_$$SYMENC^MXMLUTL($P($$PADD^XUAF4(ORINST),U,3))_"</StateCode>"
 S ORXML($$INCLINE)="</UserLocation>"
 ;
 S ORXML($$INCLINE)="<Patient>"
 D DEM^VADPT
 K ORNAME
 S ORNAME=$G(VADM(1))
 D NAMECOMP^XLFNAME(.ORNAME)
 S ORXML($$INCLINE)="<FirstName>"_$$SYMENC^MXMLUTL(ORNAME("GIVEN"))_"</FirstName>"
 S ORXML($$INCLINE)="<LastName>"_$$SYMENC^MXMLUTL(ORNAME("FAMILY"))_"</LastName>"
 S ORXML($$INCLINE)="<MiddleName>"_$$SYMENC^MXMLUTL(ORNAME("MIDDLE"))_"</MiddleName>"
 S ORXML($$INCLINE)="<DOB>"_$$SYMENC^MXMLUTL($TR($$FMTE^XLFDT(+$G(VADM(3)),"7DZ"),"/","-"))_"</DOB>"
 S ORXML($$INCLINE)="<GenderCode>"_$$SYMENC^MXMLUTL($P($G(VADM(5)),U,1))_"</GenderCode>"
 S ORXML($$INCLINE)="<DFN>"_DFN_"</DFN>"
 S ORXML($$INCLINE)="<StationCode>"_$$SYMENC^MXMLUTL($$STA^XUAF4($$KSP^XUPARAM("INST")))_"</StationCode>"
 S ORICN=$$GETICN^MPIF001(DFN)
 I ORICN<0 S ORICN=""
 S ORXML($$INCLINE)="<ICN>"_$$SYMENC^MXMLUTL(ORICN)_"</ICN>"
 ;
 S ORXML($$INCLINE)="<Addresses>"
 ;
 D ADD^VADPT
 S ORTEMPADD=$S($G(VAPA(9))'="":1,1:0)
 ;
 S ORXML($$INCLINE)="<Address>"
 S ORXML($$INCLINE)="<Street>"_$$SYMENC^MXMLUTL($G(VAPA(1)))_"</Street>"
 S ORXML($$INCLINE)="<City>"_$$SYMENC^MXMLUTL($G(VAPA(4)))_"</City>"
 S ORXML($$INCLINE)="<StateCode>"_$$SYMENC^MXMLUTL($$GET1^DIQ(5,+$G(VAPA(5))_",",1,"I"))_"</StateCode>"
 S ORXML($$INCLINE)="<ZipCode>"_$$SYMENC^MXMLUTL($G(VAPA(6)))_"</ZipCode>"
 S ORXML($$INCLINE)="<TypeCode>"_$S(ORTEMPADD:"Temporary",1:"Permanent")_"</TypeCode>"
 S ORXML($$INCLINE)="</Address>"
 ;
 ; Residential
 I $G(VAPA(30))'=""!($G(VAPA(33))'="")!($G(VAPA(34))'="")!($G(VAPA(35))'="") D
 . S ORXML($$INCLINE)="<Address>"
 . S ORXML($$INCLINE)="<Street>"_$$SYMENC^MXMLUTL($G(VAPA(30)))_"</Street>"
 . S ORXML($$INCLINE)="<City>"_$$SYMENC^MXMLUTL($G(VAPA(33)))_"</City>"
 . S ORXML($$INCLINE)="<StateCode>"_$$SYMENC^MXMLUTL($$GET1^DIQ(5,+$G(VAPA(34))_",",1,"I"))_"</StateCode>"
 . S ORXML($$INCLINE)="<ZipCode>"_$$SYMENC^MXMLUTL($G(VAPA(35)))_"</ZipCode>"
 . S ORXML($$INCLINE)="<TypeCode>Residential</TypeCode>"
 . S ORXML($$INCLINE)="</Address>"
 ;
 ; when temp is active, also return permanent address
 I ORTEMPADD D
 . S ORTEMPPHONE=$G(VAPA(8))
 . K VAPA
 . S VAPA("P")=1
 . D ADD^VADPT
 . S ORXML($$INCLINE)="<Address>"
 . S ORXML($$INCLINE)="<Street>"_$$SYMENC^MXMLUTL($G(VAPA(1)))_"</Street>"
 . S ORXML($$INCLINE)="<City>"_$$SYMENC^MXMLUTL($G(VAPA(4)))_"</City>"
 . S ORXML($$INCLINE)="<StateCode>"_$$SYMENC^MXMLUTL($$GET1^DIQ(5,+$G(VAPA(5))_",",1,"I"))_"</StateCode>"
 . S ORXML($$INCLINE)="<ZipCode>"_$$SYMENC^MXMLUTL($G(VAPA(6)))_"</ZipCode>"
 . S ORXML($$INCLINE)="<TypeCode>Permanent</TypeCode>"
 . S ORXML($$INCLINE)="</Address>"
 ;
 S ORXML($$INCLINE)="</Addresses>"
 ;
 S ORXML($$INCLINE)="<Phones>"
 ;
 S ORXML($$INCLINE)="<Phone>"
 S ORXML($$INCLINE)="<Number>"_$$SYMENC^MXMLUTL($G(VAPA(8)))_"</Number>"
 S ORXML($$INCLINE)="<TypeCode>Residence</TypeCode>"
 S ORXML($$INCLINE)="</Phone>"
 ;
 I $G(ORTEMPPHONE)'="" D
 . S ORXML($$INCLINE)="<Phone>"
 . S ORXML($$INCLINE)="<Number>"_$$SYMENC^MXMLUTL(ORTEMPPHONE)_"</Number>"
 . S ORXML($$INCLINE)="<TypeCode>Temporary</TypeCode>"
 . S ORXML($$INCLINE)="</Phone>"
 ;
 S ORCELL=$$GET1^DIQ(2,DFN_",",.134)
 I ORCELL'="" D
 . S ORXML($$INCLINE)="<Phone>"
 . S ORXML($$INCLINE)="<Number>"_$$SYMENC^MXMLUTL(ORCELL)_"</Number>"
 . S ORXML($$INCLINE)="<TypeCode>Cellular</TypeCode>"
 . S ORXML($$INCLINE)="</Phone>"
 ;
 S ORXML($$INCLINE)="</Phones>"
 S ORXML($$INCLINE)="</Patient>"
 S ORXML($$INCLINE)="</PatientReportRequest>"
 ;
 Q
 ;
 ;
INCLINE() ;
 ; ZEXCEPT: ORLINE
 S ORLINE=ORLINE+1
 Q ORLINE
 ;
 ; Get user's Person Class Info
PERSCLASS(ORUSER) ;
 ;
 N ORPERSCLASS,ORPERSCLASS0,ORRET
 ;
 S ORRET=""
 S ORPERSCLASS=$$GET^XUA4A72(ORUSER)
 S ORPERSCLASS0=""
 I ORPERSCLASS>0 D
 . S ORPERSCLASS0=$$IEN2DATA^XUA4A72(ORPERSCLASS)
 . I $P(ORPERSCLASS0,U,4)="i" S ORPERSCLASS0="" Q  ; Inactive
 . I $$GET1^DIQ(8932.1,+ORPERSCLASS_",",90002,"I")="N" S ORPERSCLASS0=""  ; Non-Individual - ICR 4984
 Q $P(ORPERSCLASS0,U,6,7)
 ;
 ; Return Intitution DEA # and NPI #
INSTINFO(ORINST) ;
 ;
 N ORARR,ORDEA,ORNPI
 ;
 S ORDEA=$$INSTDEA^ORPDMP(ORINST)
 I ORDEA'="" Q ORDEA
 S ORNPI=$$NPI^XUSNPI("Organization_ID",ORINST)
 I $P(ORNPI,U,1)=""!($P(ORNPI,U,3)'="Active") S ORNPI=""
 ;
 I ORDEA'=""!(ORNPI'="") Q ORDEA_U_$P(ORNPI,U,1)
 ;
 ; if child does not have DEA and NPI set, look at parent
 D PARENT^XUAF4("ORARR","`"_ORINST,"PARENT FACILITY")
 S ORINST=$O(ORARR("P",""))
 I 'ORINST Q ""
 ;
 S ORDEA=$$INSTDEA^ORPDMP(ORINST)
 I ORDEA'="" Q ORDEA
 S ORNPI=$$NPI^XUSNPI("Organization_ID",ORINST)
 I $P(ORNPI,U,1)=""!($P(ORNPI,U,3)'="Active") S ORNPI=""
 ;
 Q ORDEA_U_$P(ORNPI,U,1)
 ;
 ; Parse XML to array
PARSEXML(ORRESULT,ORXML) ;
 N ORCALLBACK,ORELEMENT
 S ORCALLBACK("STARTELEMENT")="STARTEL^ORPDMPWS"
 S ORCALLBACK("CHARACTERS")="CHARS^ORPDMPWS"
 D EN^MXMLPRSE(ORXML,.ORCALLBACK,"W")
 Q
 ;
 ;
STARTEL(ORNAME,ORATTRLIST) ;
 ; ZEXCEPT: ORELEMENT
 S ORELEMENT=ORNAME
 Q
 ;
 ;
CHARS(ORTEXT) ;
 ; ZEXCEPT: ORRESULT,ORELEMENT
 I ORTEXT?.C Q
 I ORTEXT?." " Q
 I $G(ORELEMENT)="" Q
 S ORRESULT(ORELEMENT)=$G(ORRESULT(ORELEMENT))_ORTEXT
 Q
 ;
