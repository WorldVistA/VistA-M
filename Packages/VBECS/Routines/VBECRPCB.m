VBECRPCB ;HOIFO/BNT - ORDER LOOKUP BY UID ;03/24/2004
 ;;2.0;VBECS;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to $$FIND^DIC supported by IA #2051
 ; Reference to $$GET1^DIQ supported by IA #2052
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ; Reference to CHECKUID^LRWU4 supported by IA #4636
 ; Reference to LABORATORY TEST file 60 supported by IA #10054
 ; Reference to LAB ORDER ENTRY file 69 supported by IA #4774
 ; Reference to ACCESSION file 68 supported by IA #4773
 ; Reference to PATIENT file 2 supported by IA #10035
 ; Reference to $$FMTHL7^XLFDT supported by IA #10103
 ;
 QUIT
 ;
 ; -----------------------------------------------------------------------
 ;     Private Method supports IA #4633
 ; -----------------------------------------------------------------------
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
 ;D FIND^DIC(68,,.01,,"BLOOD BANK",,,,,"TEST","ERROR")
 S VB68=$$CHECKUID^LRWU4(VBUID)
 I '+VB68!('$L($P(VB68,"^",2))) D  Q
 . D ERROR^VBECRPC("No accession associated with UID '"_VBUID_"'")
 . D ENDROOT^VBECRPC("UIDLookup")
 ;
 I $P($G(^LRO(68,$P(VB68,"^",2),0)),"^",2)'="BB" D  Q
 . D ERROR^VBECRPC("No Blood Bank accession area associated with UID '"_VBUID_"'")
 . D ENDROOT^VBECRPC("UIDLookup")
 ;
 S VBACC=$P(VB68,"^",2)
 S VBA=$P(VB68,"^",3)
 S VBB=$P(VB68,"^",4)
 ;
 Q:$P($G(^LRO(68,VBACC,1,VBA,1,VBB,0)),"^",2)'=2  ;Add parameter for 67 if necessary
 S LRDFN=$P($G(^LRO(68,VBACC,1,VBA,1,VBB,0)),"^"),DFN=$P($G(^LR(LRDFN,0)),"^",3)
 ;Add Collection Date/Time
 S VBCOLDT=$P($G(^LRO(68,VBACC,1,VBA,1,VBB,3)),"^")
 S VBNAME=$$GET1^DIQ(2,DFN,.01)
 ;Add DFN and Name
 D ADD^VBECRPC("<PatientName>"_$$CHARCHK^XOBVLIB(VBNAME)_"</PatientName>")
 D ADD^VBECRPC("<VistaPatientId>"_$$CHARCHK^XOBVLIB(DFN)_"</VistaPatientId>")
 ;Add Accession number
 S VBACCN=$P($G(^LRO(68,VBACC,1,VBA,1,VBB,.2)),"^")
 D ADD^VBECRPC("<SpecimenAccessionNumber>"_$$CHARCHK^XOBVLIB(VBACCN)_"</SpecimenAccessionNumber>")
 S VBORDN=+$P($G(^LRO(68,VBACC,1,VBA,1,VBB,.1)),"^")
 ;Add Order Number
 D ADD^VBECRPC("<LabOrderNumber>"_$$CHARCHK^XOBVLIB(VBORDN)_"</LabOrderNumber>")
 ;Add UID from file 68
 S VBUID68=$P($G(^LRO(68,VBACC,1,VBA,1,VBB,.3)),"^")
 D ADD^VBECRPC("<SpecimenUID>"_$$CHARCHK^XOBVLIB(VBUID68)_"</SpecimenUID>")
 ;Add collection date/time
 D ADD^VBECRPC("<CollectionDateTime>"_$$CHARCHK^XOBVLIB($$FMTHL7^XLFDT(VBCOLDT))_"</CollectionDateTime>")
 ;Add Tests
 D BEGROOT^VBECRPC("LabTests")
 S VBC=0 F  S VBC=$O(^LRO(68,VBACC,1,VBA,1,VBB,4,VBC)) Q:'VBC  D
 . S VBTEST=+$P($G(^LRO(68,VBACC,1,VBA,1,VBB,4,VBC,0)),"^")
 . S VBTNM=$$GET1^DIQ(60,VBTEST,.01)
 . ;Add Test Name
 . D BEGROOT^VBECRPC("LabTest")
 . D ADD^VBECRPC("<LabTestID>"_$$CHARCHK^XOBVLIB(VBTEST)_"</LabTestID>")
 . D ADD^VBECRPC("<LabTestName>"_$$CHARCHK^XOBVLIB(VBTNM)_"</LabTestName>")
 . D ENDROOT^VBECRPC("LabTest")
 ;Close Tests
 D ENDROOT^VBECRPC("LabTests")
 D ENDROOT^VBECRPC("UIDLookup")
 K DFN,LRDFN,TEST,VBA,VBACC,VBB,VBC,VBECCNT,VBNAME,VBORDN,VBTEST,VBTNM,VBUID,VBUID68,VBACCN
 Q
 ;
 ; -----------------------------------------------------------------------
 ;     Private Method supports IA #4614
 ; -----------------------------------------------------------------------
ORDNUM(RESULTS,LROIEN) ;
 ;
 N TEST,QUIT,VBA,VBB
 S (VBECCNT,QUIT)=0
 S RESULTS=$NA(^TMP("VBECS_ORDLOOKUP",$J))
 K @RESULTS
 D BEGROOT^VBECRPC("UIDLookup")
 I LROIEN']"" D  Q
 . D ERROR^VBECRPC("No Lab Order Number provided")
 . D ENDROOT^VBECRPC("UIDLookup")
 ;
 I '$D(^LRO(69,"C",LROIEN)) D  Q
 . D ERROR^VBECRPC("Lab Order Number "_LROIEN_" not found in file 69")
 . D ENDROOT^VBECRPC("UIDLookup")
 S VBA=0 F  S VBA=$O(^LRO(69,"C",LROIEN,VBA)) Q:'VBA  D  Q:QUIT
 . S VBB=0 F  S VBB=$O(^LRO(69,"C",LROIEN,VBA,VBB)) Q:'VBB  D
 . . i $p($g(^LRO(69,VBA,1,VBB,1)),"^",4)'="C" s QUIT=1 q  ;Collection status
 . . ; Order has been merged.
 . . IF $P($G(^LRO(69,VBA,1,VBB,1)),"^",7)]"" S QUIT=1 Q
 . . D BEGROOT^VBECRPC("LabTests")
 . . S VBC=0 F  S VBC=$O(^LRO(69,VBA,1,VBB,2,VBC)) Q:'VBC  D
 . . . D BEGROOT^VBECRPC("LabTest")
 . . . S VBLR0=^LRO(69,VBA,1,VBB,2,VBC,0)
 . . . S LRDFN=$P(^LRO(69,VBA,1,VBB,0),"^",1),DFN=$P($G(^LR(LRDFN,0)),"^",3)
 . . . S VBNAME=$$GET1^DIQ(2,DFN,.01)
 . . . S VBTEST=$P($G(VBLR0),"^")
 . . . S VBTNM=$$GET1^DIQ(60,VBTEST,.01)
 . . . I $P($G(^LRO(69,VBA,1,VBB,2,VBC,0)),"^",3)']"" D  Q
 . . . . S QUIT=1
 . . . . D ERROR^VBECRPC("Lab Test "_VBTNM_" on order number "_LROIEN_" has not been accessioned")
 . . . . D ENDROOT^VBECRPC("LabTest")
 . . . S VBUID=$G(^LRO(69,VBA,1,VBB,2,VBC,.3))
 . . . S VBCOLDT=$P($G(^LRO(68,$P($G(VBLR0),"^",4),1,$P($G(VBLR0),"^",3),1,$P($G(VBLR0),"^",5),3)),"^")
 . . . S VBACCN=$G(^LRO(68,$P($G(VBLR0),"^",4),1,$P($G(VBLR0),"^",3),1,$P($G(VBLR0),"^",5),.2))
 . . .;Add DFN and Name
 . . . D ADD^VBECRPC("<PatientName>"_$$CHARCHK^XOBVLIB(VBNAME)_"</PatientName>")
 . . . D ADD^VBECRPC("<VistaPatientId>"_$$CHARCHK^XOBVLIB(DFN)_"</VistaPatientId>")
 . . . D ADD^VBECRPC("<LabOrderNumber>"_$$CHARCHK^XOBVLIB(LROIEN)_"</LabOrderNumber>")
 . . . D ADD^VBECRPC("<LabTestID>"_$$CHARCHK^XOBVLIB(VBTEST)_"</LabTestID>")
 . . . D ADD^VBECRPC("<LabTestName>"_$$CHARCHK^XOBVLIB(VBTNM)_"</LabTestName>")
 . . . D ADD^VBECRPC("<SpecimenAccessionNumber>"_$$CHARCHK^XOBVLIB(VBACCN)_"</SpecimenAccessionNumber>")
 . . . D ADD^VBECRPC("<SpecimenUID>"_$$CHARCHK^XOBVLIB(VBUID)_"</SpecimenUID>")
 . . . ;Add collection date/time
 . . . D ADD^VBECRPC("<CollectionDateTime>"_$$CHARCHK^XOBVLIB($$FMTHL7^XLFDT(VBCOLDT))_"</CollectionDateTime>")
 . . . D ENDROOT^VBECRPC("LabTest")
 . . . Q
 . . D ENDROOT^VBECRPC("LabTests")
 . . Q
 . Q
 D ENDROOT^VBECRPC("UIDLookup")
 K DFN,LRDFN,VBA,VBACC,VBB,VBECCNT,VBNAME,VBORDN,VBTEST,VBTNM,VBUID,VBUID68,VBACCN
 Q
