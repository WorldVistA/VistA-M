MDPCE1 ; HOIFO/NCA - Updated Routine For Data Extract ;Sep 24, 2021@12:35
 ;;1.0;CLINICAL PROCEDURES;**6,80**;Apr 01, 2004;Build 3
 ; Integration Agreements:
 ; IA# 1889 [Subscription] Create New Visit
 ; IA# 10048 [Supported] FILE 9.4 references
 ;
EN1(MDINST,MDPDTE,MDPR,MDTYP,MDETYP,MDCLOC) ; [Function] PCE Visit Creation
 ; Input parameters
 ;  1. MDINST [Literal/Required] Transaction IEN
 ;  2. MDPDT [Literal/Optional] Procedure Date/Time
 ;  3. MDPR [Literal/Required] CP Definition
 ;  4. MDTYP [Literal/Required] Type of Visit (Ambulatory or Hospitalization or Event (Historical))
 ;  5. MDETYP [Literal/Required] Encounter Type (Primary or Ancillary)
 ;  6. MDCLOC [Literal/Required] Workload Reporting hospital location
 ;
 N DATA,MDPERR,MDJ,MDPKG,MDRES,MDSTR,MDVISIT,MDDRES K ^TMP("MDPXAPI",$J)
 S MDOUT=""
 S MDPKG=$$FIND1^DIC(9.4,"","MX","CLINICAL PROCEDURES")
 I 'MDPKG Q "-1^CLINICAL PROCEDURES does not exist in Package File."
 I '$D(^MDD(702,MDINST,0)) Q "-1^No Study Record."
 S MDSTR=$G(^MDD(702,MDINST,0))
 S MDJ=0,MDJ=MDJ+1
 I '$G(MDCLOC) S:MDPR["^" MDCLOC=$P(MDPR,"^",2)
 I '$G(MDCLOC) S MDCLOC=$$GET1^DIQ(702.01,+MDPR_",",.05,"I") I 'MDCLOC Q "-1^No Hospital Location for CP Definition."
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"ENC D/T")=MDPDTE
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"PATIENT")=$P(MDSTR,"^",1)
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"HOS LOC")=MDCLOC
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"SERVICE CATEGORY")=MDTYP
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"ENCOUNTER TYPE")=MDETYP
 ;MD*1.0*80: If DUZ not defined, zero, not numeric, or null,
 ;           send DUZ for proxy service. (Considered also validating
 ;           whether a numeric DUZ sent in by upstream logic exists
 ;           in file 200. If a numeric DUZ is not in file 200, PCE
 ;           will send back a processing error of "not a valid pointer
 ;           to the New Person file #200". This might indicate a
 ;           configuration issue which the site needs to be aware of.
 ;           Since PCE performs this validation, there shouldn't be a
 ;           need for MDPCE* routines to.)
 S MDRES=$$DATA2PCE^PXAPI("^TMP(""MDPXAPI"",$J)",MDPKG,"CLINICAL PROCEDURES",.MDVISIT,$S('$G(DUZ):$$FINDD^MDPCE(),1:""),"",1,"",.MDPERR)
 I MDRES S MDOUT=MDVISIT_"^"_MDCLOC_";"_MDPDTE_";"_MDTYP S MDFDA(702,MDINST_",",.07)=MDTYP_";"_MDPDTE_";"_MDCLOC D FILE^DIE("K","MDFDA") K ^TMP("MDPXAPI",$J) Q MDOUT
 K ^TMP("MDPXAPI",$J)
 S MDOUT="-1^PCE Visit Creation Error."
 Q MDOUT
 ;
