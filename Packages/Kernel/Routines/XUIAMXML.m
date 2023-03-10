XUIAMXML ;BHM/DLR,DRI - IAM ENTERPRISE NEW PERSON PROBABILISTIC SEARCH ; Dec 18, 2020@15:00
 ;;8.0;KERNEL;**731**;Jul 10, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;Utilizes SPML (Service Provisioning Markup Language) for IAM lookup to
 ;PSIM (Person Services Identity Management)
 ;
 ;**731, VAMPI-8214 (dri) - create api to lookup user by secid and retrieve user traits
USER(RETURN,MPIARR) ; - query PSIM for USER traits
 ; Input (one of the following):
 ;   MPIARR("samacctnm") = SECURITY ACCOUNT MANAGER/NETWORK USERNAME
 ;           or
 ;   MPIARR("VAemail") = ACTIVE DIRECTORY USER PRINCIPLE NAME/EMAIL ADDRESS
 ;           or
 ;   MPIARR("secId") = SECURITY ID
 ;
 ; Output (array of traits):
 ;   RETURN("city")=CITY
 ;   RETURN("dob")=DOB (HL7 format)
 ;   RETURN("email")=EMAIL ADDRESS
 ;   RETURN("firstName")=FIRST NAME
 ;   RETURN("gender")=SEX
 ;   RETURN("identityTheft")="N" or "Y"
 ;   RETURN("lastName")=FAMILY (LAST) NAME
 ;   RETURN("mcid")=PSIM MESSAGE CONTROL ID
 ;   RETURN("middleName")=MIDDLE NAME
 ;   RETURN("orgId")=SUBJECT ORGANIZATION
 ;   RETURN("phone")=PHONE NUMBER
 ;   RETURN("pnid")=PERSON NUMBER IDENTIFIED/SSN
 ;   RETURN("postalCode")=ZIP CODE
 ;   RETURN("samacctnm")=SECURITY ACCOUNT MANAGER/NETWORK USERNAME
 ;   RETURN("secId")=SECURITY ID
 ;   RETURN("state")=STATE
 ;   RETURN("street_1")=STREET ADDRESS 1
 ;   RETURN("subjectOrg")=SUBJECT ORGANIZATION
 ;   RETURN("vauid")=VA ACTIVE DIRECTORY UNIQUE ID (for 200AD)
 ;   RETURN("vistaid")=STATION NUMBER|USERID or DUZ^SOURCE ID TYPE^STATION NUMBER^ASSIGNING AUTHORITY| (repeating)
 ;
 ; Example calling api:
 ;   S MPIARR("VAemail")="first.lastname@domain.ext"
 ;             or
 ;   S MPIARR("samacctnm")="VHAMOCLASTNAMEF"
 ;             or
 ;   S MPIARR("secId")=##########
 ;
 ;   D USER^XUIAMXML(.RETURN,.MPIARR)
 ;   ZW RETURN ;returns array of traits
 ;
 ;
 N MPIXML,MPIXMLR,MPID,MPIPAT
 K RETURN
 S MPIXML=$$SXMLBLD(.MPIARR) ;build spml search request
 D POST(MPIXML,.MPIXMLR) ;send spml to psim
 I '$D(MPIXMLR) S RETURN="-1^Unable to communicate with the Enterprise Database." Q
 D SPARSE(.RETURN,.MPIXMLR) ;parse psim response of returned spml
 ;
 ;I $D(RETURN("dob")) S RETURN("dob")=$$HL7TFM^XLFDT(RETURN("dob")) ;leave dob in hl7 format
 ;
 Q
 ;
SNDUSER(RETURN,MPIARR) ; - update PSIM with USER traits
 ; Input
 ;   MPIARR - Array of trait(s) to update
 ; Output
 ;   RETURN - Array of traits psim has
 ;
 N MPIXML,MPIXMLR,MPID,MPIPAT
 K RETURN
 S MPIXML=$$AXMLBLD(.MPIARR) ;build spml for psim
 D POST(MPIXML,.MPIXMLR) ;send spml to psim
 I '$D(MPIXMLR) S RETURN="-1^Unable to communicate with the Enterprise Database." Q
 D SPARSE(.RETURN,.MPIXMLR) ;parse psim response of returned spml
 ;
 ;I $D(RETURN("dob")) S RETURN("dob")=$$HL7TFM^XLFDT(RETURN("dob")) ;leave dob in hl7 format
 ;I $D(RETURN("subjectOrg")) S RETURN("subjectOrg")=$$TITLE^XLFSTR($E(RETURN("subjectOrg"),1,50)) ;subject organization sometimes coming from adr improperly formatted
 ;
 Q
 ;
SXMLBLD(MPIARR) ; setup xml to search for user
 ; Input:
 ;   MPIARR - Array of traits for search
 ;
 ; Output:
 ;   XML for the search
 ;
 ; $$SITE^VASITE - IA #10112
 ;
 N MPIXML,MPISITE,QUOTE,MPITHRES,MPIDT,MPIDUZ,MPIPRID
 S QUOTE=""""
 S MPISITE=$P($$SITE^VASITE,"^",3)
 S MPIPRID=$P($$PARAM^HLCS2,"^",3)
 S MPIDT=$$FMTHL7^XLFDT($$NOW^XLFDT)
 I $G(DUZ)>0 S MPIDUZ=$P(^VA(200,DUZ,0),"^") D STDNAME^XLFNAME(.MPIDUZ,"C")
 S MPITHRES=80
 ;
 ; heading
 S MPIXML="<spml:lookupRequest requestID="_QUOTE_516.2018053111223344_QUOTE_" returnData="_QUOTE_"data"_QUOTE_" xmlns:spml="_QUOTE_"urn:oasis:names:tc:SPML:2:0"_QUOTE_">"
 I $G(MPIARR("secId"))'="" S MPIXML=MPIXML_"<spml:psoID ID="_QUOTE_MPIARR("secId")_"^PN^200PROV^USDVA"_QUOTE_" targetID="_QUOTE_"not_used"_QUOTE_"/>" ;lookup secid
 I $G(MPIARR("secId"))="" S MPIXML=MPIXML_"<spml:psoID ID="_QUOTE_$S($G(MPIARR("VAemail"))'="":MPIARR("VAemail"),1:$G(MPIARR("samacctnm")))_"^PN^200AD^USDVA"_QUOTE_" targetID="_QUOTE_"not_used"_QUOTE_"/>" ;or lookup by vaemail or samacctnm
 S MPIXML=MPIXML_"</spml:lookupRequest>"
 ;
 K MPIARR("MPIVar")
 Q MPIXML
 ;
MSGID() ;
 N XUNOW
 S XUNOW=$$NOW^XLFDT
 Q $P($$SITE^VASITE,"^",3)_"."_$P(XUNOW,".",1)_$P(XUNOW,".",2)_$J_$R(999999)
 ;
AXMLBLD(MPIARR) ; setup xml to add or modify a user
 ; Input:
 ;   MPIARR - Array of traits for IAM search
 ;
 ; Output:
 ;   XML for the add or modify
 ;
 ; $$SITE^VASITE - IA #10112
 ;
 N MPIPRID,MPISITE,MPIXML,QUOTE
 S QUOTE=""""
 S MPISITE=$P($$SITE^VASITE,"^",3) ;station number
 S MPIPRID=$P($$PARAM^HLCS2,"^",3) ;'p'roduction or 't'est
 ;
 ; heading
 S MPIXML="<spml:"_$S(MPIARR("REQTYPE")="ADD":"addRequest",1:"modifyRequest")_" xmlns:spml="_QUOTE_"urn:oasis:names:tc:SPML:2:0"_QUOTE_" requestID="_QUOTE_$$MSGID()_QUOTE_">"
 S MPIXML=MPIXML_"<spml:psoID ID="_QUOTE_MPIARR("vistaid")_QUOTE_"></spml:psoID>"
 I MPIARR("REQTYPE")="MODIFY" S MPIXML=MPIXML_"<spml:modification modificationMode="_QUOTE_"replace"_QUOTE_">"
 S MPIXML=MPIXML_"<spml:data>"
 S MPIXML=MPIXML_"<spml:user>"
 S MPIXML=MPIXML_"<spml:environment>"_MPIPRID_"</spml:environment>"
 ;don't default in subjectOrg or orgId, should be returned by psim
 D IFADD("subjectOrg",.MPIARR,.MPIXML,"spml:subjectOrg") ;S MPIXML=MPIXML_"<spml:subjectOrg>Department Of Veterans Affairs</spml:subjectOrg>"
 D IFADD("orgId",.MPIARR,.MPIXML,"spml:orgId") ;S MPIXML=MPIXML_"<spml:orgId>urn:oid:2.16.840.1.113883.4.349</spml:orgId>"
 ;
 ; user data
 D IFADD("firstName",.MPIARR,.MPIXML,"spml:firstName")
 D IFADD("middleName",.MPIARR,.MPIXML,"spml:middleName")
 D IFADD("lastName",.MPIARR,.MPIXML,"spml:lastName")
 ;
 D IFADD("gender",.MPIARR,.MPIXML,"spml:gender")
 D IFADD("dob",.MPIARR,.MPIXML,"spml:dob")
 D IFADD("adUPN",.MPIARR,.MPIXML,"spml:adUPN")
 D IFADD("email",.MPIARR,.MPIXML,"spml:email")
 D IFADD("disabled",.MPIARR,.MPIXML,"spml:disabled") ;disuser
 D IFADD("termDate",.MPIARR,.MPIXML,"spml:termDate") ;termination date
 D IFADD("pnid",.MPIARR,.MPIXML,"spml:ssn") ;ssn
 D IFADD("secId",.MPIARR,.MPIXML,"spml:secId")
 D IFADD("uid",.MPIARR,.MPIXML,"spml:uid")
 D IFADD("npi",.MPIARR,.MPIXML,"spml:npi")
 D IFADD("samAccountName",.MPIARR,.MPIXML,"spml:samAccountName")
 D IFADD("lastAccess",.MPIARR,.MPIXML,"spml:lastAccess")
 ;
 S MPIXML=MPIXML_"</spml:user>"
 S MPIXML=MPIXML_"</spml:data>"
 ;
 S MPIXML=MPIXML_"<spml:capabilityData>"
 S MPIXML=MPIXML_"<spml:operationData requestor="_QUOTE_MPIARR("WHO")_QUOTE_">"
 S MPIXML=MPIXML_"</spml:operationData>"
 S MPIXML=MPIXML_"</spml:capabilityData>"
 I MPIARR("REQTYPE")="MODIFY" S MPIXML=MPIXML_"</spml:modification>"
 S MPIXML=MPIXML_"</spml:"_$S(MPIARR("REQTYPE")="ADD":"addRequest",1:"modifyRequest")_">"
 ;
 Q MPIXML
 ;
IFADD(MPIVAR,MPIARR,MPIXML,MPIXMLN) ;check if there, if so add it to the XML
 ; MPIVAR is the MPIARR variable name
 ; MPIXMLN is the name of the XML to encase
 ; modifies MPIXML to add if it is there
 I $G(MPIARR(MPIVAR))'="" D
 . S MPIXML=MPIXML_"<"_MPIXMLN_">"_MPIARR(MPIVAR)_"</"_MPIXMLN_">"
 Q
 ;
CONV(FIELD) ;check for &, ', > and <
 I FIELD["&" S FIELD=$P(FIELD,"&")_"&amp;"_$P(FIELD,"&",2)
 I FIELD["'" S FIELD=$P(FIELD,"'")_"&apos;"_$P(FIELD,"'",2)
 S:(FIELD["<") FIELD=$$CONVA(FIELD,"<")
 S:(FIELD[">") FIELD=$$CONVA(FIELD,">")
 Q FIELD
 ;
CONVA(FIELD,ENCHAR) ;handle <<pob city>>
 N I,X,VAL
 S VAL="",I=$L(FIELD,ENCHAR) F X=1:1:I S VAL=VAL_$P(FIELD,ENCHAR,X)
 Q VAL
 ;
SPARSE(MPIDATA,MPIXML) ; - parse the data
 ;
 ; EN^MXMLPRSE - IA #4149
 ;
 K ^TMP($J,"XUIAMXML_PARSE")
 N MPICB,MPIUSE,MPIVAR,MPIPAT,MPIALIAS,MPILOC,MPIIDS
 S (MPIPAT,MPIIDS)=0
 S MPICB("STARTELEMENT")="SE^XUIAMXML"
 S MPICB("CHARACTERS")="VALUE^XUIAMXML"
 S ^TMP($J,"XUIAMXML_PARSE",1)=MPIXML
 D EN^MXMLPRSE($NA(^TMP($J,"XUIAMXML_PARSE")),.MPICB)
 K ^TMP($J,"XUIAMXML_PARSE")
 Q
 ;
SE(MPIN,MPIA) ; - used for the parser to call back with STARTELEMENT
 ;
 ; just to protect the process
 S MPIN=$G(MPIN)
 S MPIVAR=""""_MPIN_""""
 S MPILOC="MPIDATA("
 S MPIA("error")=$G(MPIA("error"))
 S MPIA("lastName")=$G(MPIA("lastName"))
 S MPIA("middleName")=$G(MPIA("middleName"))
 S MPIA("firstName")=$G(MPIA("firstName"))
 S MPIA("dob")=$G(MPIA("dob"))
 S MPIA("pnid")=$G(MPIA("pnid"))
 S MPIA("secId")=$G(MPIA("secId"))
 S MPIA("dob")=$G(MPIA("dob"))
 S MPIA("vistaid")=$G(MPIA("vistaid"))
 S MPIA("gender")=$G(MPIA("gender"))
 ; my variable to protect
 ;I MPIN="user" S MPIPAT=MPIPAT+1,MPIALIAS=0,MPILOC="MPIDATA("_MPIPAT Q
 S MPIUSE=$G(MPIUSE)
 ;
 ; got a business rule error
 ;I MPIN="RESULT",MPIA("type")="AA",MPIA("subtype")="QE" S MPIDATA("Result")="QE" Q
 ; don't use these
 ;
 Q
 ;
VALUE(MPIT) ; - used by the parser to call back with CHARACTERS
 S:$D(MPIVAR) @(MPILOC_MPIVAR_")")=MPIT K MPIVAR Q
 Q
 ;
POST(MPIXML,MPIXMLR) ; - post XML to the execute server
 ; $$GETPROXY^XOBWLIB - IA #5421
 N $ETRAP,$ESTACK,SVC
 ; set error trap
 S $ETRAP="DO ERROR^XUIAMXML"
 ; test mode (outgoing)?
 I $D(^XTMP("XUIAMXML_EDIT")) D TEST("OUTGOING",.MPIXML)
 ; make the call
 ;**63 STORY 317469 HTTPS OR HTTP
 S SVC=$$GETPROXY^XOBWLIB("MPI_PSIM_NEW EXECUTE","MPI_PSIM_NEW EXECUTE")
 S MPIXMLR=SVC.execute(MPIXML)
 ; in case debugging needed, save both out and return
 I $D(^XTMP("XUIAMXML_DEBUG")) D
 .N XUIAMSAVE
 .S XUIAMSAVE=$O(^XTMP("XUIAMXML_DEBUG",":"),-1)+1
 .S ^XTMP("XUIAMXML_DEBUG",XUIAMSAVE,0)=$$NOW^XLFDT
 .S ^XTMP("XUIAMXML_DEBUG",XUIAMSAVE,"OUT")=MPIXML
 .S ^XTMP("XUIAMXML_DEBUG",XUIAMSAVE,"RETURN")=MPIXMLR
 ; test mode (return)?
 I $D(^XTMP("XUIAMXML_EDIT")) D TEST("RETURN",.MPIXMLR)
 Q
 ;
ERROR ; - catch errors
 ; Set ecode to empty to return to calling function
 ;
 ; $$EOFAC^XOBWLIB, ZTER^XOBWLIB - IA #5421
 ; UNWIND^%ZTER - IA #1621
 N MPIERR
 S MPIERR=$$EOFAC^XOBWLIB()
 D ZTER^XOBWLIB(MPIERR)
 S $ECODE=""
 D UNWIND^%ZTER
 Q
 ;
TEST(TYPE,MPIXML) ; - call to possibly edit the xml string
 ; used for testing purposes only.
 ; production NOT allowed
 I $$PROD^XUPROD Q
 I $E($G(IOST),1,2)'="C-" Q
 ;
 N DIC,X,L,T,C,%,%Y
 W !!,"Do you want to edit the "_TYPE_" XML"
 S %=2 D YN^DICN I %'=1 Q
 K ^TMP("XUIAMXML_TEST",$J)
 S L=0,T=""
 F X=1:1 S C=$E(MPIXML,X) Q:C=""  D
 . I C="<",T'="" S L=L+1,^TMP("XUIAMXML_TEST",$J,L,0)=T,T=C Q
 . S T=T_C
 S DIC="^TMP(""XUIAMXML_TEST"",$J,"
 D EN^DIWE
 S MPIXML=""
 S X=0 F  S X=$O(^TMP("XUIAMXML_TEST",$J,X)) Q:'X  S MPIXML=MPIXML_^TMP("XUIAMXML_TEST",$J,X,0)
 Q
 ;
