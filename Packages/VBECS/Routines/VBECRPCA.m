VBECRPCA ;DALOI/RLM - VBECS Lab Services Lookups ;10 April 2003
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to $$FIND^DIC supported by IA #2051
 ; Reference to $$GET1^DIQ supported by IA #2056
 ; Reference to GETS^DIQ supported by IA #2056
 ; Reference to $$CPT^ICPTCOD supported by IA #1995
 ; Reference to Laboratory Test file #60 supported by IA #10054
 ; Reference to RR^LR7OR1 supported by IA #2503
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ; Reference to $$FMTHL7^XLFDT supported by IA #10103
 ; Reference to $$HL7TFM^XLFDT supported by IA #10103
 ; Reference to ^DIR supported by IA #10026
 ; Reference to ^LAM supported by IA #4779
 ;
 QUIT
 ;
LOOK60 ;
 S VBECCNT=0
 D BEGROOT^VBECRPC("Root")
 I DATA="" F  S DATA=$O(^LAB(60,"B",DATA)) Q:DATA=""  D L60
 I DATA]"" D L60
 D ENDROOT^VBECRPC("Root")
 Q
L60 D KILL
 ;Test names may contain leading and/or trailing spaces.
 I $$WSTEST(DATA) D ADD^VBECRPC("<Labtest>*Invalid Test Name*"_$$CHARCHK^XOBVLIB(DATA)_"*</Labtest>") Q
 D FIND^DIC(60,,".01",,DATA,,,,,"VBOUT","ERROR")
 S VBA=0 F  S VBA=$O(VBOUT("DILIST",2,VBA)) Q:'VBA  S VBB=VBOUT("DILIST",2,VBA) D
  . ;NAME - .01, NATIONAL VA LAB CODE - 64, RESULT NLT CODE - 64.1
  . D GETS^DIQ(60,VBB,".01;64;64.1","EI","VBOUT2","ERROR2")
  . I $O(^LAB(60,VBB,2,0)) Q  ;It's a panel
  . S VBC=0 F  S VBC=$O(^LAB(60,VBB,1,VBC)) Q:'VBC  D
  . . ;SITE/SPECIMEN - .01, UNITS - 6, LOINC CODE - 95.3
  . . D GETS^DIQ(60.01,VBC_","_VBB_",",".01;6;95.3","E","VBOUT3","ERROR3")
 ;CONVERT
 K VBOUT
 S VBA=0 F  S VBA=$O(VBOUT3(60.01,VBA)) Q:VBA=""  D
  . S VBB=$P(VBA,","),VBAC=$P(VBA,",",2),VBOUT4(VBAC,VBB)=VBOUT3(60.01,VBA,.01,"E")_"^"_VBOUT3(60.01,VBA,6,"E")_"^"_VBOUT3(60.01,VBA,95.3,"E")
 K VBOUT3
 S VBA=0 F  S VBA=$O(VBOUT2(60,VBA)) Q:VBA=""  D
  . S NLT1=$$GET1^DIQ(64,VBOUT2(60,VBA,64,"I"),1)
  . S NLT2=$$GET1^DIQ(64,VBOUT2(60,VBA,64.1,"I"),1)
  . ;Convert name and nlt codes to smaller local array
  . S VBOUT5(+VBA,.01)=VBOUT2(60,VBA,.01,"E")_"^"_NLT1_"^"_NLT2
  . ;Retrieve CPT codes from file 64
  . I VBOUT2(60,VBA,64,"I")]"" S CPTA=0 F  S CPTA=$O(^LAM(VBOUT2(60,VBA,64,"I"),4,CPTA)) Q:'CPTA  D
  . . D GETS^DIQ(64.018,CPTA_","_VBOUT2(60,VBA,64,"I")_",",.01,"I","VBOUT6("_+VBA_")","CPTERR")
  . I VBOUT2(60,VBA,64.1,"I")]"" S CPTA=0 F  S CPTA=$O(^LAM(VBOUT2(60,VBA,64.1,"I"),4,CPTA)) Q:'CPTA  D
  . . D GETS^DIQ(64.018,CPTA_","_VBOUT2(60,VBA,64.1,"I")_",",.01,"I","VBOUT7("_+VBA_")","CPTERR")
 K VBOUT2
 ;Convert internal CPT reference to external
 S CPTA=0 F  S CPTA=$O(VBOUT6(CPTA)) Q:'CPTA  S CPTB="" F  S CPTB=$O(VBOUT6(CPTA,64.018,CPTB)) Q:CPTB=""  D
  . S CPT=VBOUT6(CPTA,64.018,CPTB,.01,"I")
  . ;Only active CPT's
  . Q:'$P($$CPT^ICPTCOD(+CPT),"^",7)
  . Q:CPT'["ICPT"
  . S VBOUT8(CPTA,+CPTB)=$$GET1^DIQ(81,+CPT,.01)
 S CPTA=0 F  S CPTA=$O(VBOUT7(CPTA)) Q:'CPTA  S CPTB="" F  S CPTB=$O(VBOUT7(CPTA,64.018,CPTB)) Q:CPTB=""  D
  . S CPT=VBOUT7(CPTA,64.018,CPTB,.01,"I")
  . ;Only active CPT's
  . Q:'$P($$CPT^ICPTCOD(+CPT),"^",7)
  . Q:CPT'["ICPT"
  . S VBOUT9(CPTA,+CPTB)=$$GET1^DIQ(81,+CPT,.01)
 K VBOUT6,VBOUT7
 ;                         Build XML
 S VBXA=0
 D ADD^VBECRPC("<Labtest>"_$$CHARCHK^XOBVLIB(DATA))
 F  S VBXA=$O(VBOUT5(VBXA)) Q:'VBXA  I '$$WSTEST($P(VBOUT5(VBXA,.01),"^")) D  D ADD^VBECRPC("</Testname>")
  . D ADD^VBECRPC("<Testname>"_$$CHARCHK^XOBVLIB($P(VBOUT5(VBXA,.01),"^")))
  . I $D(VBOUT4(VBXA)) S VBXI="" F  S VBXI=$O(VBOUT4(VBXA,VBXI)) Q:VBXI=""  D
  . . ;Specimen names may contain leading and/or trailing spaces.
  . . I $P($G(VBOUT4(VBXA,VBXI)),"^",1)]"",$$WSTEST($P(VBOUT4(VBXA,VBXI),"^",1)) D ADD^VBECRPC("<Specimen>*Invalid Specimen*"_$$CHARCHK^XOBVLIB($P(VBOUT4(VBXA,VBXI),"^",1))_"*</Specimen>") Q
  . . I $P($G(VBOUT4(VBXA,VBXI)),"^",1)]"" D ADD^VBECRPC("<Specimen>"_$$CHARCHK^XOBVLIB($P(VBOUT4(VBXA,VBXI),"^",1)))
  . . ;Units are free text and may contain spaces
  . . I $P($G(VBOUT4(VBXA,VBXI)),"^",2)]"" D ADD^VBECRPC("<Units>"_$$WSTRIP($$CHARCHK^XOBVLIB($P(VBOUT4(VBXA,VBXI),"^",2)))_"</Units>")
  . . I $P($G(VBOUT4(VBXA,VBXI)),"^",3)]"" D ADD^VBECRPC("<LOINC>"_$$CHARCHK^XOBVLIB($P(VBOUT4(VBXA,VBXI),"^",3)))
  . . I $P($G(VBOUT5(VBXA,.01)),"^",2)]"" D ADD^VBECRPC("<NLT>"_$$CHARCHK^XOBVLIB($P(VBOUT5(VBXA,.01),"^",2)))
  . . I $D(VBOUT8(VBXA)) S VBXJ=0 F  S VBXJ=$O(VBOUT8(VBXA,VBXJ)) Q:'VBXJ  D ADD^VBECRPC("<CPT>"_$$CHARCHK^XOBVLIB(VBOUT8(VBXA,VBXJ))_"</CPT>")
  . . I $P($G(VBOUT5(VBXA,.01)),"^",2)]"" D ADD^VBECRPC("</NLT>")
  . . I $P($G(VBOUT5(VBXA,.01)),"^",3)]"" D ADD^VBECRPC("<ResNLT>"_$$CHARCHK^XOBVLIB($P(VBOUT5(VBXA,.01),"^",3)))
  . . I $D(VBOUT9(VBXA)) S VBXJ=0 F  S VBXJ=$O(VBOUT9(VBXA,VBXJ)) Q:'VBXJ  D ADD^VBECRPC("<RnCPT>"_$$CHARCHK^XOBVLIB(VBOUT9(VBXA,VBXJ))_"</RnCPT>")
  . . I $P($G(VBOUT5(VBXA,.01)),"^",3)]"" D ADD^VBECRPC("</ResNLT>")
  . . I $P($G(VBOUT4(VBXA,VBXI)),"^",3)]"" D ADD^VBECRPC("</LOINC>")
  . . I $P($G(VBOUT4(VBXA,VBXI)),"^",1)]"" D ADD^VBECRPC("</Specimen>")
 D ADD^VBECRPC("</Labtest>")
KILL ;
 K CPT,CPTA,CPTB,NLT1,NLT2,VBA,VBAC,VBB,VBC,VBOUT,VBOUT2,VBOUT3,VBOUT4,VBOUT5,VBOUT6,VBOUT7,VBOUT8,VBOUT9,VBXA,VBXI,VBXJ
 Q
WSTEST(VBWST) ;White space test
 I $E(VBWST,1)=" "!($E(VBWST,$L(VBWST))=" ") Q 1
 Q 0
WSTRIP(VBDATA) ;Strip White Space
 F  Q:$E(VBDATA,$L(VBDATA))'=" "  S VBDATA=$E(VBDATA,1,$L(VBDATA)-1)
 F  Q:$E(VBDATA,1)'=" "  S VBDATA=$E(VBDATA,2,$L(VBDATA))
 Q VBDATA
WSCONV(VBDATA) ;Convert White Space
 F  Q:$E(VBDATA,$L(VBDATA))'=" "  S VBDATA=$E(VBDATA,1,$L(VBDATA)-1)_"%20"
 F  Q:$E(VBDATA,1)'=" "  S VBDATA="%20"_$E(VBDATA,2,$L(VBDATA))
 Q VBDATA
 ;
 ; ----------------------------------------------------------------
 ;     Private Method supports IA #4611
 ; ----------------------------------------------------------------
LABTEST(RESULTS,DATA) ; Main entry for VBECS LABORATORY TEST LOOKUP RPC
 ;
 N X,IEN,SITE,NAME,SPEC,CNT,ARR60,ERR,LIST
 S VBECCNT=0
 S RESULTS=$NA(^TMP("VBEC_LABTEST_LOOKUP",$J))
 K @RESULTS
 D BEGROOT^VBECRPC("LabTests")
 I '$D(DATA) D  Q
 . D ADD^VBECRPC("<LabTest><Name>No search criteria provided</Name><IEN></IEN><Specimen></Specimen></LabTest>")
 . D ENDROOT^VBECRPC("LabTests")
 ;
 D FIND^DIC(60,,"@;.01","BP",DATA,"","","","","ARR60","ERR")
 I '$D(ARR60("DILIST",1,0))!($D(ERR)) D  Q
 . D ADD^VBECRPC("<LabTest><Name>No Lab test found for ("_$$CHARCHK^XOBVLIB(DATA)_")</Name><IEN></IEN><Specimen></Specimen></LabTest>")
 . D ENDROOT^VBECRPC("LabTests")
 ;
 S X=0
 F  S X=$O(ARR60("DILIST",X)) Q:X=""  D
 . S IEN=$P(ARR60("DILIST",X,0),"^")
 . S NAME=$P(ARR60("DILIST",X,0),"^",2)
 . S (SITE,CNT,LIST,SPEC)=0
 . F  S SITE=$O(^LAB(60,IEN,1,"B",SITE)) Q:SITE=""  D
 . . S CNT=CNT+1,SPEC=1
 . . S SPEC(CNT)=$P(^LAB(61,SITE,0),"^")
 . I 'SPEC D  Q
 . . D ADD^VBECRPC("<LabTest><Name>"_$$CHARCHK^XOBVLIB(NAME)_"</Name><IEN>"_$$CHARCHK^XOBVLIB(IEN)_"</IEN><Specimen></Specimen></LabTest>")
 . F  S LIST=$O(SPEC(LIST)) Q:LIST=""  D
 . . D ADD^VBECRPC("<LabTest><Name>"_$$CHARCHK^XOBVLIB(NAME)_"</Name><IEN>"_$$CHARCHK^XOBVLIB(IEN)_"</IEN>")
 . . D ADD^VBECRPC("<Specimen>"_$$CHARCHK^XOBVLIB(SPEC(LIST))_"</Specimen></LabTest>")
 . . I (SPEC(LIST)="BLOOD")!(SPEC(LIST)="SERUM")!(SPEC(LIST)="PLASMA") D
 . . . I $G(VBECTST) W !,NAME_"^"_IEN_"^"_SPEC(LIST)
 . Q
 D ENDROOT^VBECRPC("LabTests")
 K VBECCNT
 Q
 ;
 ; --------------------------------------------------------------
 ;     Private Method supports IA #4612
 ; --------------------------------------------------------------
TSTRSLT(RESULTS,SDATE,EDATE,DIV,TESTS,PATS) ;
 ; Main entry for VBECS LAB TEST RESULTS LOOKUP RPC
 ;
 N VBRSX,X,Y,DFN,TEST,BDT,EDT,TESTNAME,TSTRES
 S VBECCNT=0,EDT="",BDT=""
 S RESULTS=$NA(^TMP("VBEC_LABRES",$J))
 K @RESULTS
 IF $D(SDATE) S BDT=$$HL7TFM^XLFDT(SDATE)
 IF $D(EDATE) S EDT=$$HL7TFM^XLFDT(EDATE)
 D BEGROOT^VBECRPC("LabTests")
 S VBRSX=0
 F  S VBRSX=$O(PATS(VBRSX)) Q:VBRSX=""  D
 . S DFN=PATS(VBRSX) Q:DFN=""
 . ; No tests passed in, get all test result available
 . IF '$D(TESTS) D  Q
 . . D RR^LR7OR1(DFN,,BDT,EDT,,,,,,)
 . . IF $D(^TMP("LRRR",$J,DFN)) D RESXML(DFN)
 . . Q
 . S Y=0 F  S Y=$O(TESTS(Y)) Q:Y=""  D
 . . S TEST=TESTS(Y) Q:TEST=""
 . . D RR^LR7OR1(DFN,,BDT,EDT,,TEST,,,,)
 . . I $D(^TMP("LRRR",$J,DFN)) D RESXML(DFN)
 . . Q
 D ENDROOT^VBECRPC("LabTests")
 ;M ^XTMP("VBECLABRES",$J)=^TMP("VBEC_LABRES",$J)
 Q
 ;
RESXML(DFN) ; Subroutine to extract Lab Test result and build return XML
 Q:'$D(^TMP("LRRR",$J,DFN))
 N TESTCODE,RES,TESTNAME,SUB,INVDT,SEQ,OUTPUT
 S SUB=0
 F  S SUB=$O(^TMP("LRRR",$J,DFN,SUB)) Q:SUB']""  D
 . S INVDT=0
 . F  S INVDT=$O(^TMP("LRRR",$J,DFN,SUB,INVDT)) Q:INVDT']""  D
 . . S SEQ=0
 . . F  S SEQ=$O(^TMP("LRRR",$J,DFN,SUB,INVDT,SEQ)) Q:SEQ']""  D
 . . . S OUTPUT=$G(^TMP("LRRR",$J,DFN,SUB,INVDT,SEQ))
 . . . Q:OUTPUT']""
 . . . ; Lab Test code
 . . . S TESTCODE=$P(OUTPUT,"^")
 . . . ; Lab Test result
 . . . S RES=$P(OUTPUT,"^",2)
 . . . ; Lab Test name
 . . . S TESTNAME=$P(OUTPUT,"^",15)
 . . . ; Date result completed converted to HL7 date/time format
 . . . S COMPDATE=$$FMTHL7^XLFDT($P(^LR($$LRDFN^LR7OR1(DFN),SUB,INVDT,0),"^",3))
 . . . D BEGROOT^VBECRPC("LabTest")
 . . . D ADD^VBECRPC("<VistaPatientId>"_$$CHARCHK^XOBVLIB(DFN)_"</VistaPatientId>")
 . . . D ADD^VBECRPC("<LabTestId>"_$$CHARCHK^XOBVLIB(TESTCODE)_"</LabTestId>")
 . . . D ADD^VBECRPC("<TestPrintName>"_$$CHARCHK^XOBVLIB(TESTNAME)_"</TestPrintName>")
 . . . D ADD^VBECRPC("<TestResult>"_$$CHARCHK^XOBVLIB(RES)_"</TestResult>")
 . . . D ADD^VBECRPC("<TestDate>"_$$CHARCHK^XOBVLIB(COMPDATE)_"</TestDate>")
 . . . D ENDROOT^VBECRPC("LabTest")
 . . . Q
 Q
