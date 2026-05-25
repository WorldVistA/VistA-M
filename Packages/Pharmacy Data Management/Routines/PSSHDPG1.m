PSSHDPG1 ;BIRM/KML -  APIs SUPPORTING REQUEST AND RETRIEVAL OF PGx DATA FROM HDR ;9/28/23
 ;;1.0;PHARMACY DATA MANAGEMENT;**262**;9/30/97;Build 66
 ;
 ; Reference to $$GETREST^XOBWLIB supported by DBIA# 5421
 ; Reference to $$GET^XOBWLIB supported by DBIA# 5421
 ;
GETPGXRESULTS(PSSDFN,PSSGENES) ; get PGx (genetic test interpretation results from HDR)
 ; INPUT  - PSSDFN   = IEN of PATIENT file (#2) (the DFN)
 ; OUTPUT - PSSGENES = local array of drug, phenotype, genotype, activity score returned from the HDR
 ;                   Passed in by reference
 ;          RETURN   = 1^SUCCESSFUL
 ;                    -1^_errorMessage
 ;                               
 N PSSICN,PSSREQST,PSSINPUTVALUES,PSSXMLJSON,OUTCOME,PSSERR,PSSRESTOBJ,PSSDTTM,RETURN
 K PSSGENES
 K ^TMP($J,"PSSHDPG1")
 S (RETURN,OUTCOME)=0
 S PSSICN=$$GETICN(PSSDFN)
 I +PSSICN<0 S RETURN=PSSICN G GETPGXEXIT
 S PSSDTTM=$$BLDDATETM($$NOW^XLFDT)
 D BLDREQSTRING(PSSICN,.PSSREQST,PSSDTTM)
 S OUTCOME=$$SENDREQUEST(.PSSRESTOBJ,.PSSREQST,.PSSERR)
 I +OUTCOME<0!($G(PSSERR)) S RETURN="-1^"_OUTCOME G GETPGXEXIT
 S RETURN="1^Successful"
 D PARSE(PSSRESTOBJ.HttpResponse.Data)
 D SETARRAY(.PSSGENES)
GETPGXEXIT ;
 K ^TMP($J,"PSSHDPG1")
 Q RETURN
 ;
GETICN(X) ;GET ICN
 ; INPUT = X (DFN)
 ; OUTPUT = X1 (ICN associated with patient DFN)
 N X1
 I +X=0 S X1="-1^INVALID DFN" G GETICNX
 S X1=$$GETICN^MPIF001(X)
GETICNX ;
 Q X1
 ;
BLDDATETM(PSSFMDT) ; format Fileman date/time to CCYY-MM-DD_"T"_HH:MM:SS_"Z"
 ; format Fileman date/time to CCYY-MM-DD_"T"_HH:MM:SS_"Z"
 N PSSDTM,PSSDTM,PSSTIME,PSSGMT,OFFSET,HH,MM
 I '$D(PSSFMDT)!('$G(PSSFMDT)) S PSSFMDT=$$NOW^XLFDT
 S PSSDTM=$$FMTHL7^XLFDT(PSSFMDT)
 I PSSDTM<0 S PSSDTM="00000000"
 S PSSGMT=$E(PSSDTM,1,4)_"-"_$E(PSSDTM,5,6)_"-"_$E(PSSDTM,7,8)
 ;extract and convert fm time to ISO 8601 external format
 S PSSTIME=$E(+PSSDTM,9,99)
 S PSSTIME=$$REMOVEOFFSET^PSSHDPG1(PSSTIME)
 I PSSTIME']"" S PSSTIME="000000"  ; MED_ORDER_CHECK request needs to have TIME along with DATE
 I $L(PSSTIME)<6 D  ; MED_ORDER_CHECK request requires seconds in TIME
 . I $E(PSSTIME,4)']"" S PSSTIME=$E(PSSTIME,1,3)_"000" Q
 . I $E(PSSTIME,5)']"" S PSSTIME=$E(PSSTIME,1,4)_"00" Q
 . I $E(PSSTIME,6)']"" S PSSTIME=$E(PSSTIME,1,5)_0
 ;append hour:min:sec
 S PSSGMT=PSSGMT_"T"_$E(PSSTIME,1,2)_":"_$E(PSSTIME,3,4)_":"_$E(PSSTIME,5,6)
 Q PSSGMT_"Z"
 ;
BLDREQSTRING(ICN,PSSX,PSSDTM) ;
 ;format request XML
 ;Input - ICN = Integration Control Number associated with patient
 ;        PSSX = passed in by reference; name of variable to hold the request string
 ;        PSSDTM - date/time passed in ccyy-mm-ddThh:mm:ssZ format 
 ; Output - PSSX = request string in XML format to be sent to HDR for patient genomic results
 K PSSX
 S PSSX="/readClinicalData1?&templateId=MedOrderCheckRead&filterRequest=<?xml version=""1.0"" encoding=""UTF-8""?>"
 S PSSX=PSSX_"<filter:filter xmlns:filter=""Filter"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" vhimVersion=""Vhim_4_00"">"
 S PSSX=PSSX_"<filterId>MOCHA_READ_FILTER</filterId><clientName>HDR-14142</clientName><payloadType>xml</payloadType><clientRequestInitiationTime>"_PSSDTM_"</clientRequestInitiationTime>"
 S PSSX=PSSX_"<patients><NationalId>"_ICN_"</NationalId></patients><entryPointFilter queryName=""ID1""><domainEntryPoint>Pharmacogenetic</domainEntryPoint><queryTimeoutSeconds>10000</queryTimeoutSeconds>"
 S PSSX=PSSX_"  </entryPointFilter> </filter:filter>&filterId=MOCHA_READ_FILTER&requestId="_$P($$SITE^VASITE,U,3)_"MOCHA PGx"_$$NOW^XLFDT_";"_$H
 Q
 ;
SENDREQUEST(PSSROBJ,PSSX,PSSERR) ; post MED_ORDER_CHECK request to HDR web service to return patient genetic test results
 ; Input -  PSSROBJ = rest service request object (passed in by reference)
 ;          PSSX = request string to HDR 
 ; Output - PSSRET = returned (XML) string as a result of HDR processing of the request
 ;        - PSSERR = error object (passed in by reference)
 N $ETRAP,PSSRET
  ; Set error trap
 S $ETRAP="DO ERROR^PSSHDPG1"
 S PSSROBJ=$$GETREST^XOBWLIB("PSS PGX-HDR SERVICE","PSS PGX-HDR SERVER") ;Return REST Service Request Object using the HWSC supported API.
 I $D(^TMP($J,"PSSHDPG1","EXCEPTION"))>0 S PSSRET="-1^"_^TMP($J,"PSSHDPG1","EXCEPTION") G SENDREQUESTX
 S PSSRET=$$GET^XOBWLIB(PSSROBJ,PSSX,.PSSERR,1)  ;Make HTTP GET Call and Force Error if Problem Encountered
 I $D(^TMP($J,"PSSHDPG1","EXCEPTION"))>0 S PSSRET="-1^"_^TMP($J,"PSSHDPG1","EXCEPTION")
SENDREQUESTX ;
 Q PSSRET
 ;
SETARRAY(PSSGENES) ; ;move from temp global into LOCAL array
 ;PSSGENES - Patient lab result from HDR
 ; PSSGENES(GENE,CNT,"ACTIVITY_SCORE")
 ; PSSGENES(GENE,CNT,"GENOTYPE")
 ; PSSGENES(GENE,CNT,"NPP_SharePointURL")
 ; PSSGENES(GENE,CNT,"PHENOTYPE")
 ; PSSGENES(GENE,CNT,"RESULT_DATE")
 ;PSSXZY - format uses to check for GENE and PHENOTYPE FDB maaping
 ; PSSXYZ(CNT,LABEL) where labels are "GENE", "ACTIVITY_SCORE", GENOTYPE, PHENOTYPE, RESULT_DATA, NPP_SharePointURL,FULL_ICN, PSSXSID.
 N INDX,PSSGENE,PSSPHEN,PSSFDBG,PSSFDBP,PSSCNT,PSSXZY,PSSGMAP,PSSPMAP,PSSFDBG,PSSFDBP,PSSMAP
 S INDX=-1,PSSCNT=0
 F  S INDX=$O(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"pgxDatas",0,"pgxData",INDX)) Q:INDX']""  D
 . S PSSCNT=PSSCNT+1
 . S PSSXZY(PSSCNT,"GENE")=$G(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"pgxDatas",0,"pgxData",INDX,"gene",0))
 . S PSSXZY(PSSCNT,"ACTIVITY_SCORE")=$G(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"pgxDatas",0,"pgxData",INDX,"vinciActivityScore",0))
 . S PSSXZY(PSSCNT,"GENOTYPE")=$G(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"pgxDatas",0,"pgxData",INDX,"vinciGenotype",0))
 . S PSSXZY(PSSCNT,"PHENOTYPE")=$G(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"pgxDatas",0,"pgxData",INDX,"vinciPhenotype",0))
 . S PSSXZY(PSSCNT,"RESULT_DATE")=$G(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"pgxDatas",0,"pgxData",INDX,"resultDate",0))
 . S PSSXZY(PSSCNT,"NPP_SharePointURL")=$P($G(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"nppSharepointURL",0,"url",0)),"? ",2)
 . S PSSXZY(PSSCNT,"FULL_ICN")=$G(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"pgxDatas",0,"pgxData",INDX,"patientFullICN",0))
 . S PSSXZY(PSSCNT,"PGXSID")=$G(^TMP($J,"PSSHDPG1","ClinicalData",0,"patient",0,"medOrderCheckRead",0,"pgxDatas",0,"pgxData",INDX,"pgxSID",0))
 K PSSPERR
 I '$G(PSSOPTFG) D DATA^PSSPGXUT(.PSSXZY,.PSSMAP)
 F PSSCNT=0:0 S PSSCNT=$O(PSSXZY(PSSCNT)) Q:'PSSCNT  D
 . S PSSGMAP=$G(PSSMAP(PSSCNT,"GENE")),PSSFDBG=$P(PSSGMAP,U,2)
 . S PSSPMAP=$G(PSSMAP(PSSCNT,"PHENOTYPE")),PSSFDBP=$P(PSSPMAP,U,2) I +$P(PSSPMAP,U,3),PSSFDBG'="" S PSSPERR(PSSFDBG)=PSSFDBP
 . Q:PSSFDBG="NULL"
 . S PSSGENES(PSSFDBG,PSSCNT,"ACTIVITY_SCORE")=PSSXZY(PSSCNT,"ACTIVITY_SCORE")
 . S PSSGENES(PSSFDBG,PSSCNT,"GENOTYPE")=PSSXZY(PSSCNT,"GENOTYPE")
 . S PSSGENES(PSSFDBG,PSSCNT,"PHENOTYPE")=$S($D(PSSMAP(PSSCNT,"NOFDB")):"",PSSFDBP'="NULL":PSSFDBP,1:"")
 . S PSSGENES(PSSFDBG,PSSCNT,"RESULT_DATE")=PSSXZY(PSSCNT,"RESULT_DATE")
 . S PSSGENES(PSSFDBG,PSSCNT,"NPP_SharePointURL")=PSSXZY(PSSCNT,"NPP_SharePointURL")
 Q
  ;
PARSE(STREAM) ;parse out xml into temp global  (copied from PARSE^ORRDI1)
 N %XML,GL,BREAK,X
 S GL=$NA(^TMP($J,"PSSHDPG1"))
 K @GL
 N STATUS,READER,XOBERR,S
 S STATUS=##class(%XML.TextReader).ParseStream(STREAM,.READER,,,,,1)
 I $$STATCHK^XOBWLIB(STATUS,.XOBERR,1) D
 .S BREAK=0 F  Q:BREAK!READER.EOF!'READER.Read()  D
 ..I READER.NodeType="element" D SPUSH(.S,READER.LocalName)
 ..I READER.NodeType="endelement" D SPOP(.S,.X)
 ..I READER.NodeType="chars" D SPUT(.S,READER.Value)
 Q
 ;
SPUSH(S,X) ;places X on the stack S and returns the current level of the stack  (copied from PARSE^ORRDI1)
 N I S I=$O(S(""),-1)+1,S(I)=X
 Q I
 ;
SPOP(S,X) ;removes the top item from the stack S and put it into the variable X and returns the level that X was at  (copied from PARSE^ORRDI1)
 N I S I=$O(S(""),-1)
 I I S X=S(I) K S(I)
 N J S J=$O(S(I),-1) I J S S(J,X)=$G(S(J,X))+1
 Q I
 ;
SPEEK(S,X) ;same as SPOP except the top item is not removed  (copied from PARSE^ORRDI1)
 N I S I=$O(S(""),-1)
 I I S X=S(I)
 Q I
 ;
SPUT(S,X) ;implementation specific, uses the stack to form a global node  (copied from PARSE^ORRDI1)
 N I,STR
 S STR=$P(GL,")")
 S I=0 F  S I=$O(S(I)) Q:'I  D
 .S STR=STR_","_""""_S(I)_""""_","
 .N NUM S NUM=0
 .I $D(S(I-1,S(I))) S NUM=+$G(S(I-1,S(I)))
 .S STR=STR_NUM
 S STR=STR_")"
 I $D(@STR) S @STR=@STR_X
 I '$D(@STR) S @STR=X
 Q STR
 ;
REMOVEOFFSET(TIME) ;
 S TIME=$P(TIME,"-")
 S TIME=$P(TIME,"+")
 S TIME=$P(TIME,"Z")
 Q TIME
 ;
ERROR  ;
 ; @DESC Handles error during request to HDR via webservice.
 ;
 ; Depends on GLOBAL variable PSSERR to be set in previous call.
 ;
 ; @RETURNS Nothing. Value store in global.
 ;
 N ERRARRAY
 ;
 ; Get error object from Error Object Factory
 I $G(PSSERR)="" S PSSERR=$$EOFAC^XOBWLIB()
 ; Store the error object in the error array
 D ERR2ARR^XOBWLIB(PSSERR,.ERRARRAY)
 ;
 ; Parse out the error text and store in global
 S ^TMP($J,"PSSHDPG1","EXCEPTION")=$$GETTEXT(.ERRARRAY)
 ; Set ecode to empty to return to calling function
 SET $ECODE=""
 ;
 Q
 ;
GETTEXT(ERRARRAY) ;
 ; @DESC Gets the error text from the array
 ;
 ; @ERRARRAY Error array stores error in format defined by web service product.
 ;
 ; @RETURNS Error info as a single string
 ;
 N PSS
 ;
 ; Loop through the text subscript of error array and concatenate
 S PSS("errorText")=""
 S PSS("I")=""
 F  S PSS("I")=$O(ERRARRAY("text",PSS("I"))) Q:PSS("I")=""  D
 . S PSS("errorText")=PSS("errorText")_ERRARRAY("text",PSS("I"))
 ;
 Q PSS("errorText")
 ;;
