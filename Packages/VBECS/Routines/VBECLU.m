VBECLU ;HIOFO/bnt-VBECS Patient Lookup Utility ; 9/8/05 12:43pm
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Call to GETICN^MPIF001 is supported by IA: 2701
 ; Reference to $$FMTHL7^XLFDT supported by IA #10103
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ; Reference to DT^DICRW supported by IA #10005
 ; Call to $$UP^XLFSTR is supported by IA: 10104
 ; Call to ^DIM is supported by IA: 10016
 ; Call to ^VA(200 is supported by IA: 10060
 ; Reference to FIND^DIC supported by IA #2051
 ; 
 ;
 SET X="You Can't Enter VBECLU at top of routine!"
 QUIT
 ;
SEARCH(RESULT,PARAMS) ; -- return patient data in XML format
 ; -- RPC:  VBEC PATIENT LOOKUP SEARCH
 ; -- 
 ; -- input  PARAMS ARRAY
 ;           PARAMS("SEARCH_TYPE") = "NAME", "SSN", ICN, SSN4
 ;           PARAMS("SEARCH_VALUE") = value to search for.
 ; 
 NEW I,X,Y,VBECPCNT,VBECLINE,VBECRSLT,SEARCH,VALUE,FILTER,FILTERV,BDATE,EDATE
 NEW MAXSIZE,MAXSIZRE,LINENO,DELIM,MSCREEN,RESTRICT,ERRMSG
 IF '$D(DT) D DT^DICRW
 ;KILL RESULT
 SET VBECPCNT=0
 SET VBECLINE=0
 SET VBECRSLT="^TMP(""VBEC-PLU-SEARCH"",$J)"
 SET RESULT=$NA(@VBECRSLT)
 K @RESULT
 ;
 SET SEARCH=$$UP^XLFSTR($GET(PARAMS("SEARCH_TYPE")))
 SET VALUE=$$UP^XLFSTR($GET(PARAMS("SEARCH_VALUE")))
 SET MAXSIZE=+$GET(PARAMS("MAX_PATIENTS"),50),MAXSIZRE=0
 IF (MAXSIZE<5) SET MAXSIZE=5
 IF (MAXSIZE>100) SET MAXSIZE=100
 ;
 SET FILTER=$$UP^XLFSTR($GET(PARAMS("FILTER_TYPE")))
 SET FILTERV=$G(PARAMS("FILTER_VALUE"))
 SET BDATE=$G(PARAMS("CLINIC_STARTDATE"))
 SET EDATE=$G(PARAMS("CLINIC_ENDDATE"))
 SET MSCREEN=$$UP^XLFSTR($G(PARAMS("MSCREEN")))
 IF MSCREEN'="" DO
 . SET X=MSCREEN D ^DIM IF $D(X)=0 SET MSCREEN="" SET ERRMSG="MSCREEN is invalid M code" Q
 . IF $E(MSCREEN)'="I" SET MSCREEN="" SET ERRMSG="MSCREEN Deleted, must start with an If statement." Q
 . IF MSCREEN[" S "!(MSCREEN[" SET ")!(MSCREEN[" S:")!(MSCREEN["SET:") SET MSCREEN="" SET ERRMSG="MSCREEN Deleted, can not set values." Q
 . IF MSCREEN[" K "!(MSCREEN[" KILL ")!(MSCREEN[" K:")!(MSCREEN["SET:") SET MSCREEN="" SET ERRMSG="MSCREEN Deleted, can not kill values." Q
 . IF MSCREEN[" W "!(MSCREEN[" WRITE ")!(MSCREEN[" W:")!(MSCREEN["WRITE:") SET MSCREEN="" SET ERRMSG="MSCREEN Deleted, can not WRITE." Q
 SET DELIM=$G(PARAMS("DELIMITER"),",") ; Defaults to comma to support old way.
 ; 
 SET RESTRICT=$G(^VA(200,+$G(DUZ),101))
 IF +RESTRICT DO
 . S CODE="I $D(^OR(100.21,"_$P(RESTRICT,"^",2)_",10,""B"",+$G(DFN)_"";DPT(""))"
 . IF MSCREEN'="" S MSCREEN=" "_CODE Q
 . IF MSCREEN="" S MSCREEN=CODE
 ;
 IF (FILTER'=""),(FILTERV'="") DO BYFILTER^VBECLU0(FILTER,FILTERV,BDATE,EDATE,SEARCH,VALUE,DELIM) GOTO DONE
 ;
 IF (SEARCH="NAME")!(SEARCH="SSN")!(SEARCH="ICN")!(SEARCH="SSN4") D BYNAME
 ELSE  DO  GOTO DONE
 . DO ADD("<record count='0'>")
 . DO ADD("<error message='Searching for patients by "_SEARCH_" not yet implemented!'></error>")
 QUIT
 ;
BYNAME ;
 NEW FULLCNT,VBECPCNT,VBEC,NODE,DFN,XREF
 ;; copied From scutbk11
 ;; DO FIND^DIC(2,,".01;.03;.363;.09","PS",VALUE,300,"B^BS^BS5^SSN")
 ;
 IF VALUE="" DO  GOTO DONE
 . DO ADD("<record count='0'>")
 . DO ADD("<error message='Not Enough Information Provided to Search for Patients for Search Type = """_SEARCH_"""'></error>")
 ;
 IF SEARCH="NAME" SET XREF="B",VALUE=$TR(VALUE," ","") ;REMOVE SPACES
 IF SEARCH="SSN" SET XREF="BS^SSN^CN^RM",VALUE=$TR(VALUE," -","") ; REMOVE DASHES AND SPACES
 IF SEARCH="SSN4" SET XREF="BS5" DO 
 . IF $L(VALUE)>5 SET VALUE=$E(VALUE,1,5) ; can't exceed 5 characters, if P for psuedo on end take it off.
 IF SEARCH="ICN" SET XREF="AICN"
 DO FIND^DIC(2,,".01;.03;.09","MPS",VALUE,,XREF)
 IF $G(DIERR) DO  GOTO DONE
 . DO ADD("<record count='0'>")
 . DO ADD("<error message='Error occured in VistA during patient lookup'></error>")
 . DO CLEAN^DILF
 SET FULLCNT=+$G(^TMP("DILIST",$J,0))
 DO ADD("<record count='0'>")
 SET LINENO=VBECLINE
 ;
 SET VBECPCNT=0
 FOR VBEC=1:1:FULLCNT D  ;Q:$$STOP^XOBVLIB()
 . SET NODE=^TMP("DILIST",$J,VBEC,0)
 . SET DFN=$P(NODE,"^",1)
 . D PTDATA(+NODE,.VBECPCNT)
 I $G(ERRMSG)]"" D
 . DO ADD("<error message=''>"_$G(ERRMSG)_"</error>")
 ;IF ($G(MAXSIZRE)<1) DO ADD("<maximum message=''></maximum>")
 SET @VBECRSLT@(LINENO)="<record count='"_VBECPCNT_"'>"
 ;
DONE ;
 DO ADD("</record>")
 IF 1
 QUIT
 ;
EXIT ;
 QUIT
 ;
PTDATA(DFN,VBECPCNT) ;
 NEW I,DONE,LINE,ALIAS,NAME,PTNAME,DOB,DOD,SSN,TYPE,GENDER,ICN,PRIM,SC,SCPER,VET,WARD,ROOMBED,SENSITIV,DOBCODE,FNAME,LNAME,MI,X1,X2
 ;IF VBECPCNT>(MAXSIZE-1) DO MAXOUT QUIT
 IF (MSCREEN'="") X MSCREEN I '$T Q
 SET VBECPCNT=VBECPCNT+1
 ;SET LINE="<patient number='"_VBECPCNT_"' dfn='"_DFN_"'"
 DO ADD("<Patient><Number>"_VBECPCNT_"</Number><VistaPatientID>"_DFN_"</VistaPatientID>")
 ;
 SET PTNAME=$P(^DPT(DFN,0),"^",1)
 SET X1=$P(PTNAME,",",2),X2=$L(X1," "),MI=""
 IF X2 SET MI=$P(X1," ",2),X1=$P(X1," ")
 SET FNAME=$$CHARCHK^XOBVLIB(X1),MI=$$CHARCHK^XOBVLIB(MI)
 SET LNAME=$$CHARCHK^XOBVLIB($P(PTNAME,","))
 ;
 ; -- REQUIRED COMPONENTS
 SET SENSITIV=$S($P($G(^DGSL(38.1,DFN,0)),"^",2)=1:"true",1:"false")
 ; Get DOB and determine if month or day is zero and add DOB Code.
 SET DOB=$$FMTHL7^XLFDT($P($G(^DPT(DFN,0)),"^",3)),DOBCODE="V"
 ; Get Date Of Death
 SET DOD=$$CHARCHK^XOBVLIB($$FMTHL7^XLFDT($P($G(^DPT(DFN,.35)),"^")))
 IF $E(DOB,5,8)["00" DO
 . SET:$E(DOB,5,8)="0000" $E(DOB,5,8)="0101",DOBCODE="B" Q  ; Both zero
 . SET:$E(DOB,5,6)="00" $E(DOB,5,6)="01",DOBCODE="M" Q  ; Month zero
 . SET:$E(DOB,6,8)="00" $E(DOB,6,8)="01",DOBCODE="D" Q  ; day zero
 S DOB=$$CHARCHK^XOBVLIB(DOB)
 SET SSN=$$CHARCHK^XOBVLIB($P($G(^DPT(DFN,0)),"^",9))
 ;SET LINE=LINE_" sensitive='"_SENSITIV_"' name='"_NAME_"' dob='"_DOB_"' ssn='"_SSN_"' "
 DO ADD("<PatientLastName>"_LNAME_"</PatientLastName><PatientFirstName>"_FNAME_"</PatientFirstName><PatientMiddleName>"_MI_"</PatientMiddleName>")
 DO ADD("<Sensitive>"_SENSITIV_"</Sensitive><PatientDOB>"_DOB_"</PatientDOB><PatientDOBCode>"_DOBCODE_"</PatientDOBCode><PatientSSN>"_SSN_"</PatientSSN>")
 DO ADD("<PatientDeathDate>"_DOD_"</PatientDeathDate>")
 ;
 ; -- OPTIONAL COMPONENTS
 ;Patient Type (391)
 SET TYPE=$$CHARCHK^XOBVLIB($P($G(^DG(391,+$G(^DPT(DFN,"TYPE")),0)),"^",1))
 ;
 ;gender
 SET GENDER=$$CHARCHK^XOBVLIB($P($G(^DPT(DFN,0)),"^",2))
 ;
 ;icn
 SET ICN=$P($G(^DPT(DFN,"MPI")),"^",1)
 ; This API sets the ICN checksum.  
 SET ICN=$$GETICN^MPIF001(DFN)
 IF +ICN<0 SET ICN=$$ICNLC^MPIF001(DFN)
 ;
 ;Primary Eligibility(.361)
 SET PRIM=$$PRIM(DFN)
 ;
 SET SC=$P($G(^DPT(DFN,.3)),"^",1,2) ;Is Service Connected (.301) %=.302
 SET SCPER=$P(SC,"^",2)
 IF $P(SC,"^",1)="Y" SET SC="true"
 IF $P(SC,"^",1)="N" SET SC="false"
 ;
 SET VET=$P($G(^DPT(DFN,"VET")),"^",1) ;Veteran Status (1901)
 IF VET="Y" SET VET="true"
 IF VET="N" SET VET="false"
 ;
 SET WARD=$$CHARCHK^XOBVLIB($E($G(^DPT(DFN,.1)),1,30))
 SET ROOMBED=$$CHARCHK^XOBVLIB($P($G(^DPT(DFN,.101)),"^",1))
 ;
 ;SET LINE=LINE_" type='"_TYPE_"' primaryeligibility='"_PRIM_"' serviceconnected='"_SC_"' scpercent='"_SCPER_"'"
 DO ADD("<Type>"_TYPE_"</Type><PrimaryEligibility>"_PRIM_"</PrimaryEligibility><ServiceConnected>"_SC_"</ServiceConnected><ScPercent>"_SCPER_"</ScPercent>")
 ;SET LINE=LINE_" gender='"_GENDER_"' icn='"_ICN_"' veteran='"_VET_"' ward='"_WARD_"' roombed='"_ROOMBED_"'></patient>"
 DO ADD("<PatientSexCode>"_GENDER_"</PatientSexCode><PatientICN>"_ICN_"</PatientICN><Veteran>"_VET_"</Veteran><PatientLocation>"_WARD_"</PatientLocation><PatientRoomBed>"_ROOMBED_"</PatientRoomBed></Patient>")
 ;
 ;DO ADD(LINE)
 ;DO NAMECOMP^VBECLU0(DFN,VBECPCNT)
 ;
 QUIT
 ;
MAXOUT ;
 IF $G(MAXSIZRE)<1 DO ADD("<maximum message='Too many patients found (more than "_MAXSIZE_").  Please Limit Search.'></maximum>")
 SET MAXSIZRE=1
 QUIT
 ;
PRIM(DFN) ; -- returns print name from file 8.1
 NEW PRIM1
 SET PRIM1=$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),"^",9) ; station entry
 Q $$CHARCHK^XOBVLIB($P($G(^DIC(8.1,+PRIM1,0)),"^",6)) ; mas entry
 ;
ADD(STR) ; -- add string to array
 SET VBECLINE=VBECLINE+1
 SET @VBECRSLT@(VBECLINE)=STR
 QUIT
