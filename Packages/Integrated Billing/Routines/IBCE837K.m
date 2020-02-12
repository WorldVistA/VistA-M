IBCE837K ;EDE/JWS - ACK FOR 837 FHIR TRANSMISSION ;8/6/18 10:48am
 ;;2.0;INTEGRATED BILLING;**623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
GET(RESULT,ARG) ;RPC - EDIACKCLAIMS; ack queue posting
 ;
 N IBIEN,IBRES,IB364,IBTEST,IBBILL,IBTXTEST,IBBTYP,IBDESC,IBBATCH,RES,DUZ
 K RESULT
 S DUZ(0)="@" D DTNOLF^DICRW
 ; Get IEN for Claim File 399
 S IBIEN=$G(ARG("IEN399")) ;$G not necessary for VistaLink provides the parameters defined
 ; Get IBRES which is the statusCode value of the write to Rabbit MQ 837Transactions queue
 ;   837 Business service will not attempt to execute this RPC unless this value = 200, so value will always
 ;   be = 200
 S IBRES=$G(ARG("RES"))  ;$G not necessary for VistaLink provides the parameters defined
 ; execute code to set claim status as received at FSC
 I IBRES'=200 S RES=0 G R
 ;;S IB364=$O(^IBA(364,"B",IBIEN,""),-1)
 S IB364=$$LAST364^IBCEF4(IBIEN)
 ;JWS;IB*2.0*623v24;in case there is a newer entry in file 364... seen once @ IOC vegas 7/22/19
 I IB364 D
 . I '$D(^IBA(364,"AC",1,IB364)) D
 .. N X1 S X1="A" F  S X1=$O(^IBA(364,"B",IBIEN,X1),-1) Q:X1=""  I $D(^IBA(364,"AC",1,X1)) Q
 .. I X1 S IB364=X1
 . ;JWS;IB*2.0*623;7/24/19 make sure non-prod systems are reported posted to test queue
 . S IBTEST=$G(^IBA(364,"AC",1,IB364)),IBBILL(IB364)="",IBTXTEST=$S(IBTEST:2,'$$PROD^XUPROD(1):1,1:+$$TEST^IBCEF4(IBIEN)),IBBTYP=$P("P^I^D",U,$S($$FT^IBCEF(IBIEN)=7:3,1:($$FT^IBCEF(IBIEN)=3)+1))_"-"_IBTXTEST
 . S IBDESC=$S('IBTXTEST:"",1:"TEST ")_$S($E(IBBTYP)="P":"PROF",$E(IBBTYP)="D":"DENT",1:"INST")_" CLAIM-"_$$HTE^XLFDT($H,2)
 . S IBBATCH=$$GET1^DIQ(364,IB364_",",.02,"E")
 . D UPD^IBCE837A("",IBBATCH,1,.IBBILL,IBDESC,IBBTYP,"")
 . K DIE
 . D EMAIL(IBIEN,IBTXTEST,IBBATCH)
 . Q
 S RES=1
 ;
R ; setup return JSON
 ; create JSON structured message
 S RES("ien")=IBIEN
 S RES("status")=RES  ;result of update
 D ENCODE^XLFJSONE("RES","RESULT")
 D FINISH^IBCE837I
 Q
 ;
EMAIL(IBIEN,IBTXTEST,IBBATCH) ; Send an email message to MCT mail group - to emulate existing functionality
 N ODUZ,IBCLAIM,IBTQ,IBLQ,IBEQ,SUBJ,MSG,XMTO,XMINSTR,IBBATCHN,X
 S ODUZ=DUZ,DUZ=.5
 S IBCLAIM=$$GET1^DIQ(399,IBIEN_",",.01)
 S IBTQ=$$GET1^DIQ(350.9,"1,",8.09)
 S IBLQ=$$GET1^DIQ(350.9,"1,",8.01)
 ;JWS;IB*2.0*623;6/5/19 - display claim IEN to force uniqueness
 ;S X=$P($H,",",2)
 S IBEQ=$S(IBTXTEST:IBTQ,1:IBLQ)
 S SUBJ="AEG"_IBIEN_" "_IBEQ_" Confirmation"
 S IBBATCHN=$O(^IBA(364.1,"B",IBBATCH,""))
 S MSG(1)="Ref:  Your "_IBEQ_" claim ("_IBCLAIM_" #"_IBBATCHN_")"_" ("_IBBATCH_")"
 S MSG(2)="was placed successfully onto the 837Transactions"_$S(IBEQ="MCT":"Test",1:"")
 S MSG(3)="queue for Austin to process."
 ; ***testing email vs live*** must change back to live before putting in build ***
 ;S XMTO("john.smith5@domain.ext")=""
 ;S XMTO("william.jutzi@domain.ext")=""
 ;S XMTO("VHAeBillingRR@domain.ext")=""
 ;;S XMTO("SMITH.JOHN@TAS-EBIL-DEV.AAC.DOMAIN.EXT")=""
 S XMTO("G.CLAIMS4US")=""
 S XMTO("G."_IBEQ)=""
 S XMINSTR("FROM")="VistA-eBilling 837 FHIR Submission Process"
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 ;
EMAILX ;
 ;
 D CLEAN^DILF
 S DUZ=ODUZ
 Q
 ;
