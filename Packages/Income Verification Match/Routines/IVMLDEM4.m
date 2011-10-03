IVMLDEM4 ;ALB/KCL,PJR - IVM DEMOGRAPHIC UPLOAD/DELETE FIELDS ; 11/22/04 2:27pm
 ;;2.0;INCOME VERIFICATION MATCH;**5,10,56,102**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
UF ; - (action) select uploadable demographic fields for filing
 ;
 ;  Input:  IVMWHERE  --  as where the action is coming from 
 ;
 ;                    --  If action from UPLOADABLE list:
 ;                          array of uploadable fields as
 ;                          ^TMP("IVMUPLOAD",$J,"IDX",CTR,CTR)=dfn^da(2)^da(1)^da^ivm field value^pointer to file (#1)^dhcp field number^dhcp field name
 ;
 ;
 ; - generic seletor used within list manager action
 N VALMY,IVMDOD S IVMDOD=0
 D EN^VALM2($G(XQORNOD(0)))
 Q:'$D(VALMY)
 ;
 N IVMPKDOD D CHECKS,CHECKDOD
 ;
 S IVMENT4=0 F  S IVMENT4=$O(VALMY(IVMENT4)) Q:'IVMENT4  D
 .;
 .S IVMINDEX=$G(^TMP("IVMUPLOAD",$J,"IDX",IVMENT4,IVMENT4)) I IVMINDEX']"" Q
 .;
 .; - check to see if selection is an address field
 .S IVMADDR=$$ADDR^IVMLDEM6(+IVMINDEX,$P(IVMINDEX,"^",2),$P(IVMINDEX,"^",3),$P(IVMINDEX,"^",4),IVMPPICK)
 .;
 .Q:IVMADDR
 .;
 .; - check to see if selection is a Date of Death field
 .I IVMPKDOD S IVMDOD=$$DOD^IVMLDEMD(+IVMINDEX,$P(IVMINDEX,"^",2),$P(IVMINDEX,"^",3),$P(IVMINDEX,"^",4))
 .;
 .Q:IVMDOD
 .;
 .; - ask user if they are sure they want to update field
 .D RUSURE^IVMLDEMU($P(IVMINDEX,"^",8),"update") I IVMOUT!'IVMSURE Q
 .;
 .W !,"Updating "_$P(IVMINDEX,"^",8)_" field... "
 .;
 .; - upload value received from IVM into DHCP field
 .D UPLOAD^IVMLDEMU(DFN,$P(IVMINDEX,"^",6),$P(IVMINDEX,"^",7),$P(IVMINDEX,"^",5))
 .;
 .; - remove entry from file (#301.5)
 .D DELENT^IVMLDEMU($P(IVMINDEX,"^",2),$P(IVMINDEX,"^",3),$P(IVMINDEX,"^",4)) W "completed."
 .;
 ;
 ; - hold display before building list
 D PAUSE^VALM1
 ;
 ; - init the list and re-display to the user
 D INIT^IVMLDEM2
 ;
DEQ ; clean-up variables
 D QACTION
 Q
 ;
 ;
DF ; - (action) select uploadable/non-uploadable demographic fields for deletion
 ;
 ;  Input:  IVMWHERE  --  as where the action is coming from 
 ;
 ;                    --  If action from UPLOADABLE list:
 ;                          array of uploadable fields as
 ;                          ^TMP("IVMUPLOAD",$J,"IDX",CTR,CTR)=dfn^da(2)^da(1)^da^ivm field value^pointer to file (#1)^dhcp field number^dhcp field name
 ;
 ;                        OR
 ;
 ;                    --  If action from NON-UPLOADABLE list:
 ;                          array of non-uploadable fields as
 ;                          ^TMP("IVMNONUP",$J,"IDX",CTR,CTR)=dfn^da(2)^da(1)^da^ivm field value^pointer to file (#1)^dhcp field number^dhcp field name
 ;
 ;
 ; Output:  None
 ;
 ; - generic seletor used within list manager action
 N VALMY
 D EN^VALM2($G(XQORNOD(0)))
 Q:'$D(VALMY)
 ;
 ; - determine array depending on variable IVMWHERE
 S IVMARRAY=$S(IVMWHERE="UP":"IVMUPLOAD",1:"IVMNONUP")
 ;
 N IVMPKDOD D CHECKS,CHECKDOD
 ;
 S IVMENT4=0 F  S IVMENT4=$O(VALMY(IVMENT4)) Q:'IVMENT4  D
 .;
 .I IVMWHERE="NON" D DF^IVMLDEM8 Q  ; non-uploadable fields
 .;
 .; - get selected entry for uploadable fields
 .S IVMINDEX=$G(^TMP(IVMARRAY,$J,"IDX",IVMENT4,IVMENT4)) Q:IVMINDEX']""
 .;
 .; - check to see if selection is an address field
 .S IVMADDR=$$ADDR^IVMLDEM7(+IVMINDEX,$P(IVMINDEX,"^",2),$P(IVMINDEX,"^",3),$P(IVMINDEX,"^",4),IVMPPICK)
 .;
 .Q:IVMADDR
 .;
 .; - ask user if they are sure they want to delete field
 .D RUSURE^IVMLDEMU($P(IVMINDEX,"^",8),"delete") I IVMOUT!'IVMSURE Q
 .;
 .W !,"Deleting "_$P(IVMINDEX,"^",8)_" field from the list... "
 .;
 .;if Date of Death is Deleted, send bulletin
 .I IVMPKDOD D BULLETIN S IVMPKDOD=0
 .;- remove entry from file (#301.5)
 .D DELENT^IVMLDEMU($P(IVMINDEX,"^",2),$P(IVMINDEX,"^",3),$P(IVMINDEX,"^",4)) W "completed."
 ;
 ; - hold display before re-building list
 D PAUSE^VALM1
 ;
 ; - init the list and re-display to the user
 D @$S(IVMWHERE="UP":"INIT^IVMLDEM2",1:"INIT^IVMLDEM3")
 ;
DFQ ; clean-up variables
 D QACTION
 Q
 ;
 ;
CHECKS ; check if residence phone number selected
 ; check if another address field selected
 ; IVMPPICK=0 phone or an address field not selected
 ;          1 address field(s) selected
 ;          2 phone selected
 ;          3 both address field(s) and phone selected
 ;
 N IVMPPIC1,IVMPPIC2
 S (IVMPPICK,IVMPPIC2)=0
 Q:IVMWHERE'="UP"
 S IVMENT4=0 F  S IVMENT4=$O(VALMY(IVMENT4)) Q:'IVMENT4  D
 .I $G(^TMP("IVMUPLOAD",$J,"IDX",IVMENT4,IVMENT4))["PHONE NUMBER [RESIDENCE]" S IVMPPICK=2 Q
 .S IVMINDEX=$G(^TMP("IVMUPLOAD",$J,"IDX",IVMENT4,IVMENT4)) I IVMINDEX']"" Q
 .S IVMPPIC1=+$G(^IVM(301.5,+$P(IVMINDEX,"^",2),"IN",+$P(IVMINDEX,"^",3),"DEM",+$P(IVMINDEX,"^",4),0)) Q:'IVMPPIC1
 .S:$D(^IVM(301.92,"AD",+IVMPPIC1)) IVMPPIC2=1
 .Q
 S IVMPPICK=IVMPPICK+IVMPPIC2
 Q
 ;
CHECKDOD ; check if date of death was selected
 ; IVMPKDOD=0 date of death not selected
 ;          1 date of death selected
 ;
 N IVMPPIC1,IVMPPIC2,CKST
 S (IVMPKDOD,IVMPPIC2)=0
 Q:IVMWHERE'="UP"
 S IVMENT4=0 F  S IVMENT4=$O(VALMY(IVMENT4)) Q:'IVMENT4  D
 .S CKST=$G(^TMP("IVMUPLOAD",$J,"IDX",IVMENT4,IVMENT4))
 .I CKST["DATE OF DEATH"!(CKST["SOURCE OF NOTIFICATION")!(CKST["DATE OF DEATH LAST UPDATED") S IVMPKDOD=1 Q
 Q
BULLETIN ; Non-Acceptance of Date of Death Data Bulletin
 N DGBULL,DGLINE,DGMGRP,DGNAME,DIFROM,VA,VAERR,XMTEXT,XMSUB,XMDUZ
 S DGMGRP=$O(^XMB(3.8,"B","DGEN ELIGIBILITY ALERT",""))
 Q:'DGMGRP
 D XMY^DGMTUTL(DGMGRP,0,1)
 S DGNAME=$P($G(^DPT(DFN,0)),"^"),DGSSN=$P($G(^DPT(DFN,0)),"^",9)
 S XMTEXT="DGBULL("
 S XMSUB="NON-ACCEPTANCE OF DATE OF DEATH DATA"
 S DGLINE=0
 D LINE^DGEN("Patient: "_DGNAME,.DGLINE)
 D LINE^DGEN("SSN: "_DGSSN,.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D LINE^DGEN("This Veteran's Enrollment Record contains a Date of Death,",.DGLINE)
 D LINE^DGEN("however, you did not upload this information into VistA.",.DGLINE)
 D LINE^DGEN("Contact the HEC by phone or by fax with the reason for",.DGLINE)
 D LINE^DGEN("non-acceptance.  The HEC will delete erroneous Date of Death",.DGLINE)
 D LINE^DGEN("information and update the veteran's enrollment record.",.DGLINE)
 D ^XMD
 Q
QACTION ; - kill variables used from all protocols
 S VALMBCK="R"
 K IVMADDR,IVMARRAY,IVMENT4,IVMINDEX,IVMOUT,IVMPPICK,IVMSURE
 Q
