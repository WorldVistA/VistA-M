VBECRPCP ;HIOFO/BNT - Patient Medication Profile Lookup ;24 May 2004
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to OCL^PSOORRL supported by IA #2400
 ; Reference to DEM^VADPT supported by IA #10061
 ; Reference to $$FMTHL7^XLFDT supported by IA #10103
 ; Reference to $$HL7TFM^XLFDT supported by IA #10103
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ; 
 ;
 QUIT
 ;
 ; --------------------------------------------------------
 ;      Private method supports IA #4613
 ; --------------------------------------------------------
RX(RESULTS,DFN,SDATE,EDATE) ; Get Medication Profile from Pharmacy API
 N X,Y,BDT,EDT,RX0,ISDT
 S VBECCNT=0
 S RESULTS=$NA(^TMP("VBECMEDPROFILE",$J))
 ;
 S EDT=$$HL7TFM^XLFDT(EDATE)
 S BDT=$$HL7TFM^XLFDT(SDATE)
 D BEGROOT^VBECRPC("MedicationProfile")
 I DFN]"" D DEM^VADPT
 I $G(VADM(1))="" D  D ENDROOT^VBECRPC("MedicationProfile") Q
 . D ADD^VBECRPC("<PatientName>Invalid Patient ID ("_$$CHARCHK^XOBVLIB(DFN)_")</PatientName><PatientSsn></PatientSsn><PatientDob></PatientDob><BeginningSearchDate></BeginningSearchDate><EndingSearchDate></EndingSearchDate>")
 . D ADD^VBECRPC("<Order><OrderNumber></OrderNumber><DrugName></DrugName><IssueStartDate></IssueStartDate><Status></Status><InpatientOutpatientIndicator></InpatientOutpatientIndicator></Order>")
 I BDT]"" S X=BDT D ^%DT S BDT=$S(Y<0:"",1:Y)
 I BDT']"" S X1=EDT,X2=-180 D C^%DTC S BDT=X
 D OCL^PSOORRL(DFN,BDT,EDT)
 D ADD^VBECRPC("<PatientName>"_$$CHARCHK^XOBVLIB($G(VADM(1)))_"</PatientName>")
 D ADD^VBECRPC("<PatientSsn>"_$$CHARCHK^XOBVLIB($P($G(VADM(2)),U,2))_"</PatientSsn>")
 D ADD^VBECRPC("<PatientDob>"_$$CHARCHK^XOBVLIB($$FMTHL7^XLFDT($P($G(VADM(3)),U,1)))_"</PatientDob>")
 D ADD^VBECRPC("<BeginningSearchDate>"_$$CHARCHK^XOBVLIB($$FMTHL7^XLFDT(BDT))_"</BeginningSearchDate>")
 D ADD^VBECRPC("<EndingSearchDate>"_$$CHARCHK^XOBVLIB($$FMTHL7^XLFDT(EDT))_"</EndingSearchDate>")
 I $D(^TMP("PS",$J)) D
 . S I=0 F  S I=$O(^TMP("PS",$J,I)) Q:I=""  D
 . . S RX0=^TMP("PS",$J,I,0)
 . . Q:$P(RX0,U,15)<BDT
 . . D ADD^VBECRPC("<Order><OrderNumber>"_$$CHARCHK^XOBVLIB($$STRIPL3^VBECRPC($P(RX0,U)))_"</OrderNumber>")
 . . D ADD^VBECRPC("<DrugName>"_$$CHARCHK^XOBVLIB($P(^TMP("PS",$J,I,0),U,2))_"</DrugName>")
 . . D ADD^VBECRPC("<IssueStartDate>"_$$CHARCHK^XOBVLIB($$FMTHL7^XLFDT($P(RX0,U,15)))_"</IssueStartDate>")
 . . D ADD^VBECRPC("<Status>"_$$CHARCHK^XOBVLIB($P(RX0,U,9))_"</Status>")
 . . D ADD^VBECRPC("<InpatientOutpatientIndicator>"_$$CHARCHK^XOBVLIB($P($P(RX0,U,1),";",2))_"</InpatientOutpatientIndicator>")
 . . D ADD^VBECRPC("</Order>")
 I '$D(^TMP("PS",$J)) D
 . D ADD^VBECRPC("<Order><OrderNumber></OrderNumber><DrugName>No medications were found for the date range. You may repeat the query with a different date range.</DrugName>")
 . D ADD^VBECRPC("<IssueStartDate></IssueStartDate><Status></Status><InpatientOutpatientIndicator></InpatientOutpatientIndicator></Order>")
 D ENDROOT^VBECRPC("MedicationProfile")
 ;
 K VBECCNT
 Q
