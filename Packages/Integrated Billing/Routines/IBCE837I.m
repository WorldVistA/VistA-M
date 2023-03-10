IBCE837I ;EDE/JWS - OUTPUT FOR 837 FHIR TRANSMISSION ;5/23/18 10:48am
 ;;2.0;INTEGRATED BILLING;**623,641,650,665**;23-MAY-18;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
RES(RES) ;Set resource name correctly
 ;
 ; Get Resource requested, '*' if all resources
 I RES="*" Q RES
 ;S RES=$$TITLE^XLFSTR($G(ARG("RES")))
 I RES="Valueset" S RES="ValueSet" G Q
 I RES="Explanationofbenefit" S RES="ExplanationOfBenefit" G Q
 I RES="Imagingstudy" S RES="ImagingStudy" G Q
 I RES="Careplan" S RES="CarePlan" G Q
 I RES="Episodeofcare" S RES="EpisodeOfCare" G Q
 I RES="Documentmanifest" S RES="DocumentManifest" G Q
 I RES="Claimresponse" S RES="ClaimResponse" G Q
 I RES="Eligibilityrequest" S RES="EligibilityRequest" G Q
 I RES="Chargeitem" S RES="ChargeItem" G Q
 I RES="Procedurerequest" S RES="ProcedureRequest" G Q
 I RES="Healthcareservice" S RES="HealthcareService" G Q
 I RES="Relatedperson" S RES="RelatedPerson" G Q
 I RES="Paymentnotice" S RES="PaymentNotice" G Q
 I RES="Medicationrequest" S RES="MedicationRequest" G Q
 I RES="Medicationdispense" S RES="MedicationDispense" G Q
 I RES="Practitionerrole" S RES="PractitionerRole" G Q
 I RES="Supplyrequest" S RES="SupplyRequest"
Q ;
 Q RES
 ;
FINISH ; enclose message in '[ ]' when a Bundle
 N X
 I $G(RESULT(1))=""!($G(RESULT(1))="{}") S RESULT(1)="[{}]" Q
 I $G(RES)="*" D
 . S RESULT(1)="{""Bundle"":["_RESULT(1)
 . S X=$O(RESULT("A"),-1)
 . S RESULT(X)=RESULT(X)_"]}"
 S RESULT(1)="["_RESULT(1)
 S X=$O(RESULT("A"),-1)
 S RESULT(X)=RESULT(X)_"]"
 Q
 ;
END ; enclose message in '[ ]'
 N X
 I $G(RESULT(1))="" S RESULT(1)="{}"
 S RESULT(1)="["_$G(RESULT(1))_"]"
 Q
 ;
GET(RESULT,ARG) ;RPC - EDICLAIMS; get list of claims to transmit
 ;
 ;D APPERROR^%ZTER("RPC USER") ; WCJ TEMP LINE TO SEE SOME VARIABLES
 N CT,DUZ,IBGBL,IBX,IBTEST,IBXIEN,IB0,IBTXST,IBTXTEST,IBBTYP,IBDIV,IB837R,IBNF,IBNOTX,MCNT
 K ^TMP($J,"BILL"),^TMP($J,"FHIR837")
 ;JWS;IB*2.0*650v7;3/16/21;remove setting of DUZ(0)
 D DTNOLF^DICRW
 S IBGBL="^IBA(364,""AC"",1)",CT=1
 ;JWS;IB*2.0*641v8;added MCNT for maximum count of claims IENs, >20,000 breaks FHIR
 S IBX="" F  S IBX=$O(@IBGBL@(IBX)) Q:'IBX  D  I $G(MCNT)>19999 Q
 . S IBTEST=$$GET1^DIQ(364,IBX_",",.07,"I")
 . S IBXIEN=+$G(^IBA(364,IBX,0)),IBNF=""
 . ;JWS;IB*2.0*665v17;EBILL-2241;11/2/21;found at Miami; again at Miami 12/3/21 (similar at Tongus, Orlando, West Palm) - bad entry in 364 file
 . I IBXIEN=0 D REMCLM1(IBX) Q
 . S IB0=$G(^DGCR(399,IBXIEN,0))
 . S IBTXST=$$TXMT^IBCEF4(IBXIEN,.IBNOTX,IBNF)
 . ;JWS;IB*2.0*623v25;if claim is invalid to send, remove from 'AC' index
 . I IBTXST="" D REMCLM(IBX) Q  ; no txmt
 . I IB0="" D REMCLM(IBX) Q
 . I $P(IB0,U,13)>4,'IBTEST D REMCLM(IBX) Q
 . I $F($P(IB0,U),"-") D REMCLM(IBX) Q
 . ;JWS;end IB*2.0*623v25;
 . S IBTXTEST=$S(IBTEST:2,1:+$$TEST^IBCEF4(IBXIEN))
 . S IBBTYP=$P("P^I^D",U,$S($$FT^IBCEF(IBXIEN)=7:3,1:($$FT^IBCEF(IBXIEN)=3)+1))_"-"_IBTXTEST
 . ;JWS;IB*2.0*623v25;if not sending, remove from queue
 . I $$TESTPT^IBCEU($P(IB0,U,2)),'IBTXTEST D REMCLM(IBX) Q
 . ;JWS;IB*2.0*623v25;if not sending, remove from queue
 . I $D(^TMP($J,"BILL",$P(IB0,U))) D REMCLM(IBX) Q  ; do not send duplicates
 . ;JWS;IB*2.0*641v8;added MCNT for maximum count of claims IENs, >20,000 breaks FHIR
 . S ^TMP($J,"BILL",$P(IB0,U))="",MCNT=$G(MCNT)+1
 . S IBDIV=$P($S($P(IB0,U,22):$$SITE^VASITE(DT,$P(IB0,U,22)),1:$$SITE^VASITE()),U,3)
 . S IB837R=$$RECVR^IBCEF2(IBXIEN)
 . I $L($G(RESULT(CT)))>3000 S RESULT(CT)=RESULT(CT)_",",CT=$G(CT)+1
 . ;;I IBDIV=442 S IBDIV=681 ; for eBilling_dev environment
 . S RESULT(CT)=$S($G(RESULT(CT))'="":RESULT(CT)_",",1:"")_"{""ien"":"""_IBXIEN_""",""site"":"""_IBDIV_""",""type"":"""_IB837R_""",""status"":"""_$S(IBTXTEST=0:"live",1:"test")_"""}"
 . Q
 D FINISH
 Q
 ;
TESTING ;
 ;K (ARG,U)
 N I,RESOURCE
 S ARG("IEN399")=2113336 ; 2113336 - PROF  ;2113173 - Dental (1 line)  ;2113182 - dental ;211334 - INST
 R !,"Resource Requested: ",RESOURCE:30 Q:RESOURCE=""
 S ARG("RES")=RESOURCE  ;"Basic" or "*"
 D GET^IBCE837H(.RESULT,.ARG)
 F I=1:1 Q:'$D(RESULT(I))  W:I=1 ! W RESULT(I)
 Q
 ;
REC(REC) ;check to see which records are repeating
 I $F(",63,104.8,104.91,105,107,110,112,113,114,115,120,125,130,135,170,170.5,171,172,173,176,177,178,178.1,180,",","_REC_",") Q 1
 I REC>180 Q 1
 Q 0
 ;
SETD ; update ^TMP global
 S DONE=1
 D UP
 ;S @DATA1@(CT,":")=DATA_FILE_"-"_FLD_"-"_NAME_"("_X1_")"""  ; includes record # for testing
 S @DATA1@(CT,":")=DATA_FILE_"-"_FLD_$S($$REC(X1):"."_X2,1:"")_"-"_NAME_""""
 D UP
 S @DATA1@(CT,":")="""value"":"""_TASDATA_"""}"
 Q
 ;
UP ;increment CT
 S CT=$G(CT)+1
 Q
 ;
SETCLM(IBIEN,IBQ,RSUB) ; set the FHIR 837 claim for submission
 N DA,D0,DR,DIE,DIC
 S DA=IBIEN I DA="" Q
 ;JWS;IB*2.0*665v17;EBILL-2241;11/2/21;found at Miami; again at Miami 12/3/21 (similar at Tongus, Orlando, West Palm) - bad entry in 364 file
 I $P($G(^IBA(364,DA,0)),"^")="" Q
 I '$$PROD^XUPROD(1) S IBQ="MCT"  ; if on a non-production server, send to test queue.
 ;JWS;IB*2.0*623v24;added field .10 to 364 file entry if a resubmission
 S DR=".09////1"_$S(IBQ="MCT":";.07////1",1:";.07////0")_$S($G(RSUB)=1:";.1////1",1:""),DIE="^IBA(364,"
 D ^DIE
 Q
 ;JWS;IB*2.0*623v24
 ;JWS;IB*2.0*650v5 - add set/clear of field .11, file 364 FHIR Bundle Validation flag [11]
SETSUB(IBIEN,IBVAL,IBFLD) ; clear the resubmission flag
 N DA,D0,DR,DIE,DIC
 S DA=IBIEN I DA="" Q
 I $G(IBFLD)=".11" S DR=".11////"_IBVAL
 E  S DR=".1////"_IBVAL
 S DIE="^IBA(364,"
 D ^DIE
 Q
 ;
TEST(IBIEN364) ; return test flag
 N IBTEST,IBXIEN,IBTXTEST
 S IBTEST=$$GET1^DIQ(364,IBIEN364_",",.07,"I")
 S IBXIEN=+$G(^IBA(364,IBIEN364,0)),IBNF=""
 ;JWS;IB*2.0*623v24;7/19/19 - make sure non-prod claims are sent to test queue
 S IBTXTEST=$S(IBTEST:2,'$$PROD^XUPROD(1):1,1:+$$TEST^IBCEF4(IBXIEN))
 ;S IBTXTEST=$S(IBTEST:2,1:+$$TEST^IBCEF4(IBXIEN))
 Q $S(IBTXTEST=0:0,1:1)
 ;
 ;JWS;IB*2.0*623;v25
REMCLM(IB364) ; clear the FHIR 837 claim for submission
 N DA,D0,DR,DIE,DIC
 S DA=IB364 I DA="" Q
 S DR=".03////Z;.09////2",DIE="^IBA(364,"
 D ^DIE
 Q
 ;
REMCLM1(IB364) ;;JWS;IB*2.0*665v17;EBILL-2241;11/2/21;found at Miami; again at Miami 12/3/21 (similar at Tongus, Orlando, West Palm) - bad entry in 364 file 
 ;remove bad 364 entry
 N DA,D0,DR,DIE,DIC,DIK
 I +IB364=0 Q
 S DA=IB364
 S DIK="^IBA(364," D ^DIK
 Q
 ;
 ;JWS;IB*2.0*641v13
TEST608(IBIEN364) ;return claim test flag;flag only for conditional inclusion of COB info on claim data
 N IBTEST,IBXIEN,IBTXTEST
 S IBTEST=$$GET1^DIQ(364,IBIEN364_",",.07,"I")
 S IBXIEN=+$G(^IBA(364,IBIEN364,0)),IBNF=""
 S IBTXTEST=$S(IBTEST:2,1:+$$TEST^IBCEF4(IBXIEN))
 Q $S(IBTXTEST=0:0,1:1)
 ;
