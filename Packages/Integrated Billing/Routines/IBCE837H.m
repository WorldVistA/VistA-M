IBCE837H ;EDE/JWS - OUTPUT FOR 837 FHIR TRANSMISSION ;5/23/18 10:48am
 ;;2.0;INTEGRATED BILLING;**623**;23-MAY-18;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
GET(RESULT,ARG) ;get claim data for TAS Core 837
 ;
 K RESULT
 D CLEANP^IBCE837A
 N IBIEN,RES,IBSIZE,X0,X1,X2,X3,X4,X5,X9,DATA1,FIELD,FIELDS,J,I,DONE,FILE,CT,XREC,IBRECCT,IB364,IBTYPE,IBBDA,IBBNO,XX,IBRSBTST
 S DUZ(0)="@" D DTNOLF^DICRW
 K ^TMP($J,"FHIR837")
 ; Get IEN for Claim File 399
 S IBIEN=ARG("IEN399")
 ;JWS;IB*2.0*623;6/26/19 - added ability to find data from claim#
 I IBIEN'=+IBIEN S IBIEN=$O(^DGCR(399,"B",IBIEN,0))
 ; Get Resource requested, '*' if all resources
 S RES=$$TITLE^XLFSTR($G(ARG("RES"))),RES=$$RES^IBCE837I(RES)
 I IBIEN="" D FINISH^IBCE837I Q
 I '$D(^DGCR(399,IBIEN,0)) D FINISH^IBCE837I Q
 ; JWS 1/1/19 - if IEN is invalid, quit
 ; JWS;IB*2.0*623;need to set IBRSBTST if test for patch 608 compliance
 S IB364=$$LAST364^IBCEF4(IBIEN)
 S IBRSBTST=$$TEST^IBCE837I(IB364)
 ; create 837 array of data using Output Formatter for form 8
 S IBSIZE=$$EXTRACT^IBCEFG(8,IBIEN,1,.XX)
 ; do not want to include BGN record in FHIR Transaction data
 K ^TMP("IBXDATA",$J,1,1,1,1),^(2)
 S IBBNO=$P($G(^TMP("IBHDR",$J)),U)
 I IBBNO="" D FINISH^IBCE837I Q  ;JWS 1/7/19 if for some reason batch # is null
 ;;JWS 3/19/19-use function to get IB364 entry
 ;S IB364=$O(^IBA(364,"B",IBIEN,""),-1)
 S IB364=$$LAST364^IBCEF4(IBIEN)
 S IBBDA=$O(^IBA(364.1,"B",IBBNO,""))
 S DR=".02////"_IBBDA
 S DIE="^IBA(364,",DA=IB364 D ^DIE K DIE,DIC,DA,DINUM,DO,DD,DR
 ; loop thru 837 flat file data records and fields
 S X1="" F  S X1=$O(^TMP("IBXDATA",$J,1,X1)) Q:X1=""  S X2="" F  S X2=$O(^TMP("IBXDATA",$J,1,X1,X2)) Q:X2=""  D
 . ; do not include blank record data
 . I '$O(^TMP("IBXDATA",$J,1,X1,X2,1)) K ^(1) Q
 . ; build array of # of occurrences of each record
 . S XREC=$G(^(1)),XREC=$TR(XREC," ","") I XREC="" Q
 . S IBRECCT(XREC)=$G(IBRECCT(XREC))+1
 . ; for each field with data, get the Output Formatter defined field name
 . S X4="" F  S X4=$O(^TMP("IBXDATA",$J,1,X1,X2,X4)) Q:X4=""  D
 .. I $F(X4,".") Q
 .. I X4=99 Q
 .. ; field ien of file 364.6
 .. S X5=$O(^IBA(364.6,"D","8,"_X1_",1,"_X4,0)) I X5="" Q
 .. ; [10] field name defined in output formatter
 .. S FIELD=$P(^IBA(364.6,X5,0),"^",10)
 .. I FIELD["BLANK" Q
 .. I FIELD["RECORD ID" S FIELD="RECORD ID"
 .. ; get data from output formatter
 .. S X0=$G(^TMP("IBXDATA",$J,1,X1,X2,X4))
 .. I X0="" Q
 .. I X4=1 S X0=$TR(X0," ","")
 .. S X0=$$UP^XLFSTR(X0)
 .. ;JWS;IB*2.0*623;problem with embedded " in data
 .. I $F(X0,"""") S X0=$TR(X0,"""","'")  ;S X0=$$ESC^XLFJSONE(X0)
 .. I RES'="*" D  Q
 ... S DATA1="^TMP($J,""FHIR837"","""_RES_""")"
 ... D SET^IBCE837L(RES,X1,X4,FIELD,X0)
 .. F J="Basic","Organization","ValueSet","Coverage","Claim","Practitioner","Patient","Observation" S DATA1="^TMP($J,""FHIR837"","""_J_""")" D SET^IBCE837L(J,X1,X4,FIELD,X0) I DONE Q
 .. F J="Location","ExplanationOfBenefit","Condition","Encounter","Procedure","ImagingStudy","CarePlan","EpisodeOfCare" S DATA1="^TMP($J,""FHIR837"","""_J_""")" D SET^IBCE837L(J,X1,X4,FIELD,X0) I DONE Q
 .. F J="DocumentManifest","Communication","ClaimResponse","EligibilityRequest","ChargeItem","ProcedureRequest" S DATA1="^TMP($J,""FHIR837"","""_J_""")" D SET^IBCE837L(J,X1,X4,FIELD,X0) I DONE Q
 .. F J="HealthcareService","RelatedPerson","Person","PaymentNotice","MedicationRequest","Medication" S DATA1="^TMP($J,""FHIR837"","""_J_""")" D SET^IBCE837L(J,X1,X4,FIELD,X0) I DONE Q
 .. F J="MedicationDispense","PractitionerRole","SupplyRequest" S DATA1="^TMP($J,""FHIR837"","""_J_""")" D SET^IBCE837L(J,X1,X4,FIELD,X0) I DONE Q
 .. Q
 . Q
 S X9="" F  S X9=$O(IBRECCT(X9)) Q:X9=""  D
 . D UP^IBCE837I
 . S ^TMP($J,"FHIR837","RecCount",CT,":")="{""valueString"":"_""""_X9_""""
 . D UP^IBCE837I
 . S ^TMP($J,"FHIR837","RecCount",CT,":")="""value"":"_""""_IBRECCT(X9)_"""}"
 ; add claim type (live or test) to JSON message
 ;;S IB364=$O(^IBA(364,"B",IBIEN,""),-1)
 ;moved up 6/27/19;S IBTYPE=$$TEST^IBCE837I(IB364)
 D UP^IBCE837I
 S ^TMP($J,"FHIR837","RecCount",CT,":")="{""valueString"":"_"""status"""
 D UP^IBCE837I
 ;JWS;IB*2.0*623v24;reset IBRSBTST just in case it's been reused somewhere
 S IBRSBTST=$$TEST^IBCE837I(IB364)
 S ^TMP($J,"FHIR837","RecCount",CT,":")="""value"":"_""""_$S(IBRSBTST=0:"live",1:"test")_"""}"
 ;JWS;IB*2.0*623v24;add re-submission flag, if defined
 I $$GET1^DIQ(364,IB364_",",.1,"I") D
 . D UP^IBCE837I
 . S ^TMP($J,"FHIR837","RecCount",CT,":")="{""valueString"":"_"""isValidDuplicate"""
 . D UP^IBCE837I
 . S ^TMP($J,"FHIR837","RecCount",CT,":")="""value"":"_"""true""}"
 . D SETSUB^IBCE837I(IB364,0)
 ; create JSON structured message
 D ENCODE^XLFJSONE("^TMP($J,""FHIR837"")","RESULT")
 D FINISH^IBCE837I
 ; clean up
 D CLEANP^IBCE837A
 Q
 ;
