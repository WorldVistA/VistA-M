VBECA6 ;DALOI/RLM - ORDER LOOKUP BY UID ;05/14/2003
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to $$FIND^DIC supported by IA #2051
 ; Reference to $$GET1^DIQ supported by IA #2052
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ; Reference to CHKNAME^XQ5 supported by IA #????
 ;
ORDER(RESULTS,VBUID) ;
 ;Bring in UID and RESULTS parameters.
 ;UID will be the Universal Identifier for this order.
 ;RESULTS will be the array where the data will be stored.
 N TEST,ERROR
 S VBECCNT=0
 S RESULTS=$NA(^TMP("VBECS_UIDLOOKUP",$J))
 K @RESULTS
 D BEGROOT^VBECRPC("UIDLookup")
 I VBUID']"" D  Q
  . D ERROR^VBECRPC("No Specimen UID provided")
  . D ENDROOT^VBECRPC("UIDLookup")
 ;
 D FIND^DIC(68,,.01,,"BLOOD BANK",,,,,"TEST","ERROR")
 S VBACC=TEST("DILIST",2,1)
 I '$D(^LRO(68,"C",VBUID,VBACC)) D  Q
  . D ERROR^VBECRPC("No Blood Bank accession associated with UID '"_VBUID_"'")
  . D ENDROOT^VBECRPC("UIDLookup")
 ;
 S VBA=0 F  S VBA=$O(^LRO(68,"C",VBUID,VBACC,VBA)) Q:'VBA  D
  . S VBB=0 F  S VBB=$O(^LRO(68,"C",VBUID,VBACC,VBA,VBB)) Q:'VBB  D
  . . Q:$P($G(^LRO(68,VBACC,1,VBA,1,VBB,0)),"^",2)'=2  ;Add parameter for 67 if necessary
  . . S LRDFN=$P($G(^LRO(68,VBACC,1,VBA,1,VBB,0)),"^"),DFN=$P($G(^LR(LRDFN,0)),"^",3)
  . . S VBNAME=$$GET1^DIQ(2,DFN,.01)
  . . ;Add DFN and Name
  . . D ADD^VBECRPC("<PatientName>"_$$CHARCHK^XOBVLIB(VBNAME)_"</PatientName>")
  . . D ADD^VBECRPC("<VistaPatientId>"_$$CHARCHK^XOBVLIB(DFN)_"</VistaPatientId>")
  . . ;Add Accession number
  . . S VBACCN=$P($G(^LRO(68,VBACC,1,VBA,1,VBB,.2)),"^")
  . . D ADD^VBECRPC("<SpecimenAccessionNumber>"_$$CHARCHK^XOBVLIB(VBACCN)_"</SpecimenAccessionNumber>")
  . . S VBORDN=+$P($G(^LRO(68,VBACC,1,VBA,1,VBB,.1)),"^")
  . . ;Add Order Number
  . . D ADD^VBECRPC("<LabOrderNumber>"_$$CHARCHK^XOBVLIB(VBORDN)_"</LabOrderNumber>")
  . . ;Add UID from file 68
  . . S VBUID68=$P($G(^LRO(68,VBACC,1,VBA,1,VBB,.3)),"^")
  . . D ADD^VBECRPC("<SpecimenUID>"_$$CHARCHK^XOBVLIB(VBUID68)_"</SpecimenUID>")
  . . ;Add Tests
  . . D BEGROOT^VBECRPC("LabTests")
  . . S VBC=0 F  S VBC=$O(^LRO(68,VBACC,1,VBA,1,VBB,4,VBC)) Q:'VBC  D
  . . . S VBTEST=+$P($G(^LRO(68,VBACC,1,VBA,1,VBB,4,VBC,0)),"^")
  . . . S VBTNM=$$GET1^DIQ(60,VBTEST,.01)
  . . . ;Add Test Name
  . . . D BEGROOT^VBECRPC("LabTest")
  . . . D ADD^VBECRPC("<LabTestID>"_$$CHARCHK^XOBVLIB(VBTEST)_"</LabTestID>")
  . . . D ADD^VBECRPC("<LabTestName>"_$$CHARCHK^XOBVLIB(VBTNM)_"</LabTestName>")
  . . . D ENDROOT^VBECRPC("LabTest")
  . . ;Close Tests
  . . D ENDROOT^VBECRPC("LabTests")
  D ENDROOT^VBECRPC("UIDLookup")
 K DFN,LRDFN,TEST,VBA,VBACC,VBB,VBC,VBECCNT,VBNAME,VBORDN,VBTEST,VBTNM,VBUID,VBUID68,VBACCN
 Q
