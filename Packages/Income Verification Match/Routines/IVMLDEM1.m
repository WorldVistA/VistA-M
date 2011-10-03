IVMLDEM1 ;ALB/KCL - IVM DEMOGRAPHIC UPLOAD ACTIONS ; 11-APR-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
UD ; - (action) select patient for (demographic upload)
 ;
 ;  Input - ^TMP("IVMLST",$J,"IDX",ctr,ctr)=dfn^pat name^ivm ien^ivm sub ien
 ;          VALMY(n)=array of selections
 ;
 ; - generic seletor used within list manager action call
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S IVMENT1=0 F  S IVMENT1=$O(VALMY(IVMENT1)) Q:'IVMENT1  D
 .;
 .; - get index record used for processing
 .S IVMIDX=$G(^TMP("IVMLST",$J,"IDX",IVMENT1,IVMENT1)) I IVMIDX']"" Q
 .;
 .; - call list manager application to display demo fields
 .S DFN=+IVMIDX,IVMDA2=$P(IVMIDX,"^",3),IVMDA1=$P(IVMIDX,"^",4)
 .S IVMNAME=$P(IVMIDX,"^",2)
 .D ^IVMLDEM2
 ;
UDQ ; clean-up variables
 D QACTION
 Q
 ;
 ;
ND ; - (action) select patient for (non-uploadable demographic)
 ;
 ;  Input - ^TMP("IVMLST",$J,"IDX",ctr,ctr)=dfn^pat name^ivm ien^ivm sub ien
 ;          VALMY(n)=array of selections
 ;
 ; - generic seletor used within list manager action
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S IVMENT1=0 F  S IVMENT1=$O(VALMY(IVMENT1)) Q:'IVMENT1  D
 .;
 .; - get index record used for processing
 .S IVMIDX=$G(^TMP("IVMLST",$J,"IDX",IVMENT1,IVMENT1)) I IVMIDX']"" Q
 .;
 .; - call list manager application to display non-uploadable fields
 .S DFN=+IVMIDX,IVMDA2=$P(IVMIDX,"^",3),IVMDA1=$P(IVMIDX,"^",4)
 .S IVMNAME=$P(IVMIDX,"^",2)
 .D ^IVMLDEM3
 ;
NDQ ; - clean up variables
 D QACTION
 Q
 ;
 ;
QACTION ; - kill variables used from all protocols
 D INIT^IVMLDEM ; reset array for list manager display
 S VALMBCK="R"
 K DFN,IVMDA1,IVMDA2,IVMDND,IVMENT1,IVMIDX,IVMNAME,IVMSSN,IVMWHERE
 Q
