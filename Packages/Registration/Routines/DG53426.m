DG53426 ;ALB/AEG - DG*5.3*426 POST-INSTALLATION ;2-13-02
 ;;5.3;Registration;**426**;2-13-02
 ;
 ; The cleanup consists of 2 issues, they are as follows:
 ; 1.  The patient file will be searched for patients that are not
 ;     expired and have a means test status of required. If the tests
 ;     are after 10/5/99, all of the patient's primary tests on record
 ;     will be evaluated to determine if they would have met the 
 ;     criteria outlined in patch DG*5.3*326 had the functionality been
 ;     in place at the time the REQUIRED status test was "stubbed" in 
 ;     the system.  If this is found to be the case, the 'REQUIRED' 
 ;     tests will be purged from the system and the veteran will revert
 ;     to the Category C, Agreed to Pay status.
 ; 2.  The next issue to be evaluated during the search is those 
 ;     those patients who declined to provide income information but
 ;     did Agree to Pay the deductible if they have a 'REQUIRED' status
 ;      test on file.  If they meet these criteria, regardless of the 
 ;     10/5/99 restriction from #1, the 'REQUIRED' status tests will be 
 ;     purged from the system and the veteran will revert to the
 ;     the previous Category C, Agreed to Pay status.  A 
 ;     change of functionality will be required in order to preclude
 ;     system from re-stubbing 'REQUIRED' status records. 
 ;
EN ; MAIN ENTRY POINT
 D INIT
 Q
INIT ; Initialize tracking globals and associated checkpoints.
 K ^TMP($J),^XTMP("DG-DFN"),^XTMP("DG-REQIEN")
 N %,I,X,X1,X2
 ; Create Checkpoints
 I $D(XPDNM) D
 .I $$VERCP^XPDUTL("DFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DFN","",0)
 .I $$VERCP^XPDUTL("REQIEN")'>0 D
 ..S %=$$NEWCP^XPDUTL("REQIEN","",0)
 ;
 ; init tracking globals
 F I="DFN","REQIEN" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT,X2=30 D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_U_$$DT^XLFDT_"^DG*5.3*426 POST INSTALL "
 .S ^XTMP("DG-"_I,0)=^XTMP("DG-"_I,0)_$S(I="DFN":"Records Matching Search Criteria",I="REQIEN":"Required status tests purged",1:"errors")
 I '$D(XPDNM) S (^XTMP("DG-DFN",1),^XTMP("DG-REQIEN",1))=0
 ;
 ; Check status and if root checkpoint has not completed start the
 ; cleanup.
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DFN")  D
 .I '$D(^XTMP("DG-DFN",1)) S ^XTMP("DG-DFN",1)=0
 .I '$D(^XTMP("DG-REQIEN",1)) S ^XTMP("DG-REQIEN",1)=0
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
EN1 ; control the logic from this point.
 D PSI
 I '$D(^TMP($J,"MTD")) D BMES^XPDUTL("No data found requiring cleanup.  Installation completed on"),MES^XPDUTL($$FMTE^XLFDT($$NOW^XLFDT)) Q
 D PSII,CAT1A,CAT1B
 D CAT2,CAT3,CAT4
 Q
PSI ; MAIN SEARCH ENGINE
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D MES^XPDUTL("----------------------------")
 D BMES^XPDUTL("Phase I - Search engine started on "_$$FMTE^XLFDT($$NOW^XLFDT))
 D BMES^XPDUTL("Each '.' represents 200 records reviewed ...")
 N DFN,MTIEN,DGMTDT,DGCNT,DGDOA
 S (DFN,MTIEN,DGMTDT)=""
 S DFN=0 F DGCNT=1:1 S DFN=$O(^DPT(DFN)) Q:'+DFN  D
 .I '$D(ZTQUEUED) W:'(DGCNT#200) "."
 .S DGDOA=$P($G(^DPT(DFN,.35)),U)
 .; Don't look at records of deceased patients.
 .D:'+DGDOA
 ..N DGMTSTAT,DGMTLST
 ..S DGMTLST=$$LST^DGMTU(DFN,"",1),DGMTSTAT=$P($G(DGMTLST),U,4)
 ..; Only look at those patients whose latest primary test is in
 ..; a required status.
 ..I $G(DGMTSTAT)="R" D
 ...; Check Last valid test to make sure it is not Cat A or NLR
 ...N DGMTLVT,DGMTLVTS
 ...S DGMTLVT=$$LVMT^DGMTU(DFN),DGMTLVTS=$P($G(DGMTLVT),U,4)
 ...Q:((DGMTLVTS="N")!(DGMTLVTS="A"))
 ...; call API to setup a tmp global of a given patient's primary tests.
 ...; only if the test is Cat C or Pending Adj.
 ...D MTDA^DG53426U(DFN)
 ...Q
 ..Q
 .Q
 D BMES^XPDUTL("Phase I search completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
PSII ; Phase II - Process data from Phase I search.  Parse the data
 ; according to which group it belongs to, the groups are:
 ;
 ; 1. Cat C or Pend. Adj./Agreed to Pay/Income info provided/ 
 ;    after 10/5/99
 ; 2. Cat C or Pend. Adj./ Declined to provide income info but did
 ;    agree to pay deductible.
 ; 3. Cat C or Pending Adj / Declined to provide income info & did
 ;    NOT provide income info. (Ineligible)
 ; 4. Cat C or Pending adj. / Provided income info but did NOT
 ;    AGREE to pay deductible.
 I $D(^TMP($J,"MTD")) D
 .D BMES^XPDUTL("Phase II - Parsing data ...")
 .N DFN,DGCNT,DGMTI,CAT
 .S (DFN,DGMTI)=""
 .F DGCNT=1:1 S DFN=$O(^TMP($J,"MTD",DFN)) Q:'DFN  D
 ..I '$D(ZTQUEUED) W:'(DGCNT#200) "."
 ..S DGMTI=+$G(^TMP($J,"MTD",DFN)),CAT=$$AGTP^DG53426U(DGMTI)
 ..S ^TMP($J,"CAT "_CAT,DFN)=$G(^TMP($J,"MTD",DFN))
 ..S ^XTMP("DG-DFN",1)=$G(^XTMP("DG-DFN",1))+1
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("DFN",+DFN)
 ..K ^TMP($J,"MTD",DFN)
 ..Q
 .D BMES^XPDUTL("Phase II completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 Q
CAT1A ; This tag will process those veterans who are in Category 1
 ; - Subcategory 1a - Vets who are in a REQUIRED status but have
 ;                    a previous test after 10/5/99 of Cat C or 
 ;                    pending Adjudication & have agreed to Pay.
 ;                    REQUIRED test will be purged (Event driver is
 ;                    invoked).
 ; - Subcategory 1b - Vets who are in a REQUIRED status but have
 ;                    a previous test before 10/6/99 or Cat C or
 ;                    Pending Adjudication & have agreed to pay.
 ;                    (No action taken on these folks other than to
 ;                    report them to site for further action -- remain
 ;                    in a REQUIRED status.)
 D BMES^XPDUTL("Phase III processing began on "_$$FMTE^XLFDT($$NOW^XLFDT))
 I '$D(^TMP($J,"CAT 1a")) D
 .D CAT1A^DG53426M
 .D BMES^XPDUTL("Phase III processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 I $D(^TMP($J,"CAT 1a")) D
 .N DFN,DGCDAT,DGMTDT,IEN
 .S DFN="" F  S DFN=$O(^TMP($J,"CAT 1a",DFN)) Q:'DFN  D
 ..S DGCDAT=$P($P($G(^TMP($J,"CAT 1a",DFN)),"~~",2),U,1)
 ..S DGMTDT="" F  S DGMTDT=$O(^DGMT(408.31,"AD",1,DFN,DGMTDT)) Q:'DGMTDT  I DGMTDT>DGCDAT D
 ...S IEN="" F  S IEN=$O(^DGMT(408.31,"AD",1,DFN,DGMTDT,IEN)) Q:'IEN  D
 ....I $G(IEN),$P($G(^DGMT(408.31,IEN,0)),U,3)=1 D
 .....S ^TMP("P-REQ",$J,DFN_"~~"_IEN)=$G(^DGMT(408.31,IEN,0))
 .....I $$EN^DG53426D(IEN)
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 I $D(^TMP("P-REQ",$J)) D CAT1AP^DG53426M,BMES^XPDUTL("Phase III processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
CAT1B ; Process Cat 1b tests - See DG53426U for info on classification.
 D BMES^XPDUTL("Phase IV processing began on "_$$FMTE^XLFDT($$NOW^XLFDT))
 I '$D(^TMP($J,"CAT 1b")) D
 .D CAT1B^DG53426M
 .D BMES^XPDUTL("Phase IV processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 I $D(^TMP($J,"CAT 1b")) D
 .D CAT1BR^DG53426M
 .D BMES^XPDUTL("Phase IV completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 Q
CAT2 ; Process Cat 2 vets - See DG53426U for info on classification.
 ;
 D BMES^XPDUTL("Phase V processing began on "_$$FMTE^XLFDT($$NOW^XLFDT))
 I '$D(^TMP($J,"CAT 2")) D
 .D NOCAT2^DG53426M
 .D BMES^XPDUTL("Phase V processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 I $D(^TMP($J,"CAT 2")) D
 .N DFN,DGCDAT,DGMTDT,IEN
 .S DFN="" F  S DFN=$O(^TMP($J,"CAT 2",DFN)) Q:'DFN  D
 ..S DGCDAT=$P($P($G(^TMP($J,"CAT 2",DFN)),"~~",2),U,1)
 ..S DGMTDT="" F  S DGMTDT=$O(^DGMT(408.31,"AD",1,DFN,DGMTDT)) Q:'DGMTDT  I DGMTDT>DGCDAT  D
 ...S IEN="" F  S IEN=$O(^DGMT(408.31,"AD",1,DFN,DGMTDT,IEN)) Q:'IEN  D
 ....I $D(IEN),$P($G(^DGMT(408.31,IEN,0)),U,3)=1 D
 .....S ^TMP("P-REQ",$J,DFN_"~~"_IEN)=$G(^DGMT(408.31,IEN,0))
 .....I $$EN^DG53426D(IEN)
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 I $D(^TMP("P-REQ",$J)) D CAT2P^DG53426N,BMES^XPDUTL("Phase V processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
CAT3 ; Process Cat 3 vets - See DG53426U for info on classification.
 ;
 D BMES^XPDUTL("Phase VI processing began on "_$$FMTE^XLFDT($$NOW^XLFDT))
 I '$D(^TMP($J,"CAT 3")) D
 .D NOCAT3^DG53426N
 .D BMES^XPDUTL("Phase VI processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 I $D(^TMP($J,"CAT 3")) D
 .D CAT3^DG53426N
 .D BMES^XPDUTL("Phase VI processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 Q
CAT4 ; Process Cat 4 vets - See DG53426U for info on classification.
 ;
 D BMES^XPDUTL("Phase VII processing began on "_$$FMTE^XLFDT($$NOW^XLFDT))
 I '$D(^TMP($J,"CAT 4")) D
 .D NOCAT4^DG53426N
 .D BMES^XPDUTL("Phase VII processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 I $D(^TMP($J,"CAT 4")) D
 .D CAT4^DG53426N
 .D BMES^XPDUTL("Phase VII processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .Q
 Q
