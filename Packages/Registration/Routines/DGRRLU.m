DGRRLU  ;alb/aas - DG Replacement and Rehosting RPC for VADPT ;12/22/05  14:53
 ;;5.3;Registration;**538**;Aug 13, 1993
 ;
 SET X="You Can't Enter DGRRLU at top of routine!"
 QUIT
 ;
SEARCH(RESULT,PARAMS) ; -- return patient data in XML format
 ; -- RPC:  DGRR PATIENT LOOKUP SEARCH
 ;
 ; -- input  PARAMS ARRAY
 ;       PARAMS("SEARCH_TYPE") = "NAME","SSN","ICN","SSN4","DFN", "PRVLUP"
 ;       PARAMS("SEARCH_VALUE") = value to search for.
 ;       PARAMS("JOB") = a unique job # used to check for cancelled jobs
 ;
 NEW I,X,Y,DGRRAPTS,DGRRIENS,DGRRPCNT,DGRRLINE,DGRRLIST,DGRRESLT,SEARCH,VALUE,FILTER,FILTERV,BDATE,EDATE,CODE,CANCEL,JOB ; ****
 NEW MAXSIZE,MAXSIZRE,LINENO,DELIM,DOMAIN,RESTRICT,ERRMSG,SITENM,SITENO,PRODSTAT,DGERR
 ; NEW MSCREEN ; references to MSCREEN removed by sgg 05/06/04 advised by babul no longer required
 IF '$D(DT) D DT^DICRW
 KILL RESULT
 SET DGRRPCNT=0
 SET DGRRLINE=0
 K ^TMP($J,"PLU-SEARCH")
 SET DGRRESLT="^TMP($J,""PLU-SEARCH"")"
 SET RESULT=$NA(@DGRRESLT)
 DO ADD($$XMLHDR^DGRRUTL)
 ;
 SET CANCEL=0 ; ****
 SET SEARCH=$$UP^XLFSTR($GET(PARAMS("SEARCH_TYPE")))
 SET VALUE=$$UP^XLFSTR($GET(PARAMS("SEARCH_VALUE")))
 SET MAXSIZE=+$GET(PARAMS("MAX_PATIENTS"),50),MAXSIZRE=0
 ;
 IF (MAXSIZE<5) SET MAXSIZE=5
 IF (MAXSIZE>100) SET MAXSIZE=100
 ;
 SET FILTER=$$UP^XLFSTR($GET(PARAMS("FILTER_TYPE")))
 SET FILTERV=$G(PARAMS("FILTER_VALUE"))
 SET BDATE=$G(PARAMS("CLINIC_STARTDATE"))
 SET EDATE=$G(PARAMS("CLINIC_ENDDATE"))
 SET JOB=$G(PARAMS("JOB")) ; ****
 I JOB="" S JOB=0 ; **** Until Job parameter is used
 ;SET MSCREEN=$$UP^XLFSTR($G(PARAMS("MSCREEN")))
 ;IF MSCREEN'="" DO
 ;. SET X=MSCREEN D ^DIM IF $D(X)=0 SET MSCREEN="" SET ERRMSG="MSCREEN is invalid M code" Q
 ;. IF $E(MSCREEN)'="I" SET MSCREEN="" SET ERRMSG="MSCREEN Deleted, must start with an If statement." Q
 ;. IF MSCREEN[" S "!(MSCREEN[" SET ")!(MSCREEN[" S:")!(MSCREEN["SET:") SET MSCREEN="" SET ERRMSG="MSCREEN Deleted, can not set values." Q
 ;. IF MSCREEN[" K "!(MSCREEN[" KILL ")!(MSCREEN[" K:")!(MSCREEN["SET:") SET MSCREEN="" SET ERRMSG="MSCREEN Deleted, can not kill values." Q
 ;. IF MSCREEN[" W "!(MSCREEN[" WRITE ")!(MSCREEN[" W:")!(MSCREEN["WRITE:") SET MSCREEN="" SET ERRMSG="MSCREEN Deleted, can not WRITE." Q
 SET DELIM=$G(PARAMS("DELIMITER"),",") ; Defaults to comma to support old way.
 ;
 SET SITENM=$$CHARCHK^DGRRUTL($$SITENAM^DGRRUTL())
 SET SITENO=$$CHARCHK^DGRRUTL($$SITENO^DGRRUTL())
 SET X=$$PRODST1^DGRRUTL()
 SET Y=$$PRODST2^DGRRUTL()
 SET PRODSTAT=$$CHARCHK^DGRRUTL(X+Y)
 SET DOMAIN=$$CHARCHK^DGRRUTL($$KSP^XUPARAM("WHERE"))
 ;SET RESTRICT=$G(^VA(200,+$G(DUZ),101))
 S DGRRIENS=$$IENS^DILF(+$G(DUZ))
 D GETS^DIQ(200,DGRRIENS,"101.01;101.02","I","DGRRLIST")
 S RESTRICT=$G(DGRRLIST(200,DGRRIENS,101.01,"I"))_U_$G(DGRRLIST(200,DGRRIENS,101.02,"I"))
 IF +RESTRICT S CODE="I $D(^OR(100.21,"_$P(RESTRICT,"^",2)_",10,""B"",+$G(DFN)_"";DPT(""))"
 ;.IF MSCREEN'="" S MSCREEN=" "_CODE Q
 ;.IF MSCREEN="" S MSCREEN=CODE
 IF (FILTER'=""),(FILTERV'="") DO BYFILTER^DGRRLU0(FILTER,FILTERV,BDATE,EDATE,SEARCH,VALUE,DELIM) GOTO DONE1
 IF (SEARCH="PRVLUP") DO PRVLUP^DGRRLU5(.RESULT,.PARAMS) GOTO DONE1
 IF (SEARCH="NAME"),($G(PARAMS("VERSION 1"))="") DO BYNAME^DGRRLU6 GOTO DONE1 ; v2 sgg 05/06/04
 DO ADD("<record count='0'>")
 SET LINENO=DGRRLINE
 IF SEARCH="DFN" D  Q:$G(DGERR)=1
 .D DFNLST(VALUE)
 .I $G(DGERR)=1 D DONE1
 IF (SEARCH="NAME")!(SEARCH="SSN")!(SEARCH="ICN")!(SEARCH="SSN4") D BYNAME I $G(DGERR)=1 G DONE1  ; ****
 IF ("|NAME|SSN|ICN|SSN4|DFN|PRVLUP|"'[SEARCH)!(SEARCH="") DO  GOTO DONE1  ; *****
 . DO ADD("<error message='Searching for patients by "_$S(SEARCH="":"Empty String",1:SEARCH)_" not yet implemented!'></error>")  ; ****
 ;
 D DONE
 IF CANCEL=1 DO CLEAN^DILF  ; ****
 QUIT
 ;
BYNAME  ;
 NEW FULLCNT,DGRR,NODE,DFN,XREF,DIERR
 ;; copied From scutbk11
 ;; DO FIND^DIC(2,,".01;.03;.363;.09","PS",VALUE,300,"B^BS^BS5^SSN")
 ;
 IF VALUE="" DO  Q
 . DO ADD("<error message='Not Enough Information Provided to Search for Patients.  Search Type = """_SEARCH_"""  Search For = """_VALUE_"""'></error>")
 . S DGERR=1
 ;
 IF SEARCH="NAME" SET XREF="B^NOP" IF VALUE[", " DO
 . SET VALUE=$P(VALUE,", ")_","_$P(VALUE,", ",2) ;REMOVE FIRST SPACE
 IF SEARCH="SSN" SET XREF="SSN",VALUE=$TR(VALUE," -","") ; REMOVE DASHES AND SPACES
 IF SEARCH="SSN4" SET XREF="BS5" DO 
 . IF $L(VALUE)>5 SET VALUE=$E(VALUE,1,5) ; can't exceed 5 characters, if P for psuedo on end take it off.
 IF SEARCH="ICN" SET XREF="AICN" DO
 . SET VALUE=$P(VALUE,"V",1)
 IF $D(^XTMP("DGRRLU",JOB,1)) S CANCEL=1 Q  ; *****
 ;DO FIND^DIC(2,,".01;.03;.09","PS",VALUE,300,XREF) ; replaced sgg 05/04/04
 ;DO FIND^DIC(2,,".01;.03;.09","PS",VALUE,MAXSIZE+3,XREF)
 ;IF $G(DIERR) DO  Q
 ;. DO ADD("<error message='Error occurred in ""Mumps"" during patient lookup'></error>")
 ;. DO CLEAN^DILF
 ;. S DGERR=1
 ;SET FULLCNT=+$G(^TMP("DILIST",$J,0))
 ;DO ADD("<record count='0'>")
 ;SET LINENO=DGRRLINE
 ;
 K ^TMP($J,"DGRRPTS")
 N DGRRARRY,DGRRLST,DGRRI,DPTPSREF
 S DGRRARRY="^TMP($J,""DGRRPTS"")"
 ; Set variable to cross references to be used by $$LIST^DPTLK1 call
 S DPTPSREF=$TR(XREF,"^",",")
 S DGRRLST=$$LIST^DPTLK1(VALUE,MAXSIZE,DGRRARRY)
 S DGRRI=0
 F  S DGRRI=$O(^TMP($J,"DGRRPTS",DGRRI)) Q:'DGRRI  D  Q:$$STOP^XOBVLIB()  Q:CANCEL=1
 .N DGRRCA
 .S NODE=$G(^TMP($J,"DGRRPTS",DGRRI))
 .S DFN=$P(NODE,"^")
 .I $P(NODE,"^",2)'=$P(NODE,"^",3) S DGRRCA=1_"^"_$P(NODE,"^",3)
 .D PTDATA^DGRRLUA(+NODE,.DGRRPCNT)
 .I $D(^XTMP("DGRRLU",JOB,1)) S CANCEL=1
 ;
 ;FOR DGRR=1:1:FULLCNT D  Q:$$STOP^XOBVLIB()  Q:CANCEL=1  ; ****
 ;. SET NODE=^TMP("DILIST",$J,DGRR,0)
 ;. SET DFN=$P(NODE,"^",1)
 ;. D PTDATA^DGRRLUA(+NODE,.DGRRPCNT)
 ;. IF $D(^XTMP("DGRRLU",JOB,1)) S CANCEL=1  ; *****
 K ^TMP($J,"DGRRPTS")
 Q
 ;
DONE IF CANCEL=1 Q  ; *****
 IF ($G(MAXSIZRE)<1) DO ADD("<maximum message=''></maximum>") ; sgg moved one line to maintain consistent order
 DO ADD("<error message=''>"_$G(ERRMSG)_"</error>")
 SET @DGRRESLT@(LINENO)="<record count='"_DGRRPCNT_"'>"
 ;
DONE1    D ADD("<institution name='"_SITENM_"' number='"_SITENO_"' productiondatabase='"_PRODSTAT_"' domain='"_DOMAIN_"' ></institution>")
 IF (SEARCH="PRVLUP") DO ADD("</persons>")
 ;IF (SEARCH="NAME")!(SEARCH="SSN")!(SEARCH="ICN")!(SEARCH="SSN4") DO ADD("</record>")
 IF (SEARCH'="PRVLUP") DO ADD("</record>")
 QUIT
 ;
ADD(STR) ; -- add string to array
 SET DGRRLINE=DGRRLINE+1
 SET @DGRRESLT@(DGRRLINE)=STR
 QUIT
 ;
CANCEL(RESULT,PARAM) ;  Cancel a patient search ; ****
 S JOB=$G(PARAM) ; ****
 I JOB="" S RESULT=0 Q
 N DGRRCDT
 S DGRRCDT=$$FMADD^XLFDT(DT,2)
 S ^XTMP("DGRRLU",JOB,0)=DGRRCDT_"^"_DT ; ****
 S ^XTMP("DGRRLU",JOB,1)=JOB ; ****
 S RESULT=1
 Q  ; ****
 ;
DFNLST(DGRRVAL) ;Loop through DFN list
 ;
 N DGRRDFN,DGRRI
 IF DGRRVAL="" DO  Q
 . DO ADD("<error message='Not Enough Information Provided to Search for Patients.  Search Type = """_SEARCH_"""  Search For = """_DGRRVAL_"""'></error>")
 . S DGERR=1
 F DGRRI=1:1 S DGRRDFN=$P(DGRRVAL,U,DGRRI) Q:DGRRDFN=""  D 
 .I $D(^DPT(+DGRRDFN,0)) D
 ..D PTDATA^DGRRLUA(+DGRRDFN,.DGRRPCNT)
 Q
 ;
