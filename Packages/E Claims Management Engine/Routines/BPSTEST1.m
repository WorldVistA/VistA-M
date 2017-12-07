BPSTEST1 ;OAK/ELZ - ECME TESTING TOOL ;11/15/07  09:55
 ;;1.0;E CLAIMS MGMT ENGINE;**6,7,8,10,11,15,19,20,22**;JUN 2004;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; Overview
 ; ========
 ;
 ; When a production instance of VistA sends a claim, the claim is
 ; sent to FSC and then to the clearinghouse, which sends the claim to
 ; the appropriate payer.  The payer's response is returned to the
 ; clearinghouse and then to FSC, who returns the response to the site
 ; which sent the claim.
 ;
 ; When a non-production instance of VistA sends a claim, it goes to FSC
 ; and then to the clearinghouse test bed.  Because the claim is flagged
 ; as being a test claim, the clearinghouse does not send the claim to a
 ; payer.  The clearinghouse returns to FSC a boiler-plate response,
 ; indicating the claim was accepted and paid.  FSC returns the response
 ; to the non-production instance of VistA which sent the claim. A non-production
 ; instance of VistA includes any account used by a development team for
 ; development and testing of new enhancements.
 ;
 ; The ECME Testing Tool (^BPSTEST) allows users in a non-production
 ; VistA to override some of the fields on the default response returned
 ; by the clearinghouse.  The Testing Tool does not affect the outgoing
 ; claim data.  The purpose of the Testing Tool is to facilitate testing
 ; by allowing the user to manipulate the default response returned by
 ; the clearinghouse when sending test claims.
 ;
 ; The Testing Tool does not ever run on production VistAs, only on non-
 ; production instances of VistA.
 ;
 ; Invoking the Testing Tool
 ; =========================
 ;
 ; Two things must be true in order for the Testing Tool to be invoked:
 ; The system must not be a production system (i.e.  $$PROD^XUPROD must
 ; be false); and the field PAYER RESPONSE TEST MODE on the file BPS
 ; SETUP must be set to 1/On.  The Testing Tool may not be invoked from a
 ; production system, and on non-production accounts, the PAYER RESPONSE
 ; TEST MODE fields must be set to 1/On to make use of the Testing Tool.
 ;
 ; While test/mirror accounts at production sites are non-production
 ; systems, the Testing Tool will never be used in these systems since
 ; the field PAYER RESPONSE TEST MODE will never be set to 1/On.  These
 ; accounts generally do not have ePharmacy communication set up with
 ; FSC, so they will never send test claims.
 ;
 ; Using the Testing Tool
 ; ======================
 ;
 ; There are several VistA menu options and actions that can initiate the
 ; submission of a claim.  If the process is a foreground process, then
 ; just before the building and sending of the claim, the user is given
 ; the option of entering response overrides (if the system is a non-
 ; production system, and the PAYER RESPONSE TEST MODE field is set to
 ; 1/On).  The user may also enter response overrides for an Eligibility
 ; transaction or a Reversal.
 ;
 ; The Testing Tool does allow for overrides to be entered for a claim
 ; which will be submitted in the background.  The menu option BPS SELECT
 ; OVERRIDES allows the user to enter overrides which will then be
 ; applied to the incoming claim response when the claim is submitted in
 ; the background (such as CMOP or auto-reversal).  This menu option does
 ; not exist in production systems.
 ;
 ; The claim submission code will call the subroutine GETOVER^BPSTEST,
 ; which will indicate to the user that payer overrides are enabled at
 ; that site.  The system will prompt the user "Do you want to enter
 ; overrides for this request?".  If the user enters "No", then they will
 ; not receive any further prompts related to the Testing Tool.  No
 ; values on the incoming response will be overridden with any user-
 ; entered values.  If the user enters "Yes", then the system will allow
 ; the user to enter override values for a variety of fields, for
 ; example:  Response (rejected, paid, duplicate, stranded), Total Amount
 ; Paid, Copay Amount, Ingredient Cost Paid, Next Available Fill Date,
 ; Payer ID Qualifier, etc.
 ;
 ; When the incoming claim response comes in, the system parses the
 ; values and stores them in the file BPS RESPONSES.  (Data fields may
 ; also be stored on the REJECT INFO sub-file of the PRESCRIPTIONS file.)
 ; If the system is a non-production system, and the PAYER RESPONSE TEST
 ; MODE field is set to 1/On, then the subroutine PARSE^BPSECMPS will
 ; call SETOVER^BPSTEST.  If any overrides had been entered for the claim
 ; response, those values will override the values received from the
 ; clearinghouse on the claim response.
 ;
