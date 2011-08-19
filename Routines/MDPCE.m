MDPCE ; HIRMFO/NCA - Routine For Data Extract ;6/9/08  13:29
 ;;1.0;CLINICAL PROCEDURES;**5,21**;Apr 01, 2004;Build 30
 ; Integration Agreements:
 ; IA# 1889 [Subscription] Create New Visit
 ;
EN1(MDINST,MDPDTE,MDPR,MDTYP,MDETYP) ; [Function] PCE Visit Creation
 ; Input parameters
 ;  1. MDINST [Literal/Required] Transaction IEN
 ;  2. MDPDT [Literal/Optional] Procedure Date/Time
 ;  3. MDPR [Literal/Required] CP Definition
 ;  4. MDTYP [Literal/Required] Type of Visit (Ambulatory or Hospitalization or Event (Historical))
 ;  5. MDETYP [Literal/Required] Encounter Type (Primary or Ancillary)
 ;
 N DATA,MDCLOC,MDPERR,MDJ,MDPKG,MDRES,MDSTR,MDVISIT,MDDRES K ^TMP("MDPXAPI",$J)
 S MDOUT=""
 S MDPKG=$$FIND1^DIC(9.4,"","MX","CLINICAL PROCEDURES")
 I 'MDPKG Q "-1^CLINICAL PROCEDURES does not exist in Package File."
 I '$D(^MDD(702,MDINST,0)) Q "-1^No Study Record."
 S MDSTR=$G(^MDD(702,MDINST,0))
 S MDJ=0,MDJ=MDJ+1
 S MDCLOC=$$GET1^DIQ(702.01,+MDPR_",",.05,"I")
 I 'MDCLOC S:MDPR["^" MDCLOC=$P(MDPR,"^",2)
 I 'MDCLOC Q "-1^No Hospital Location for CP Definition."
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"ENC D/T")=MDPDTE
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"PATIENT")=$P(MDSTR,"^",1)
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"HOS LOC")=MDCLOC
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"SERVICE CATEGORY")=MDTYP
 S ^TMP("MDPXAPI",$J,"ENCOUNTER",MDJ,"ENCOUNTER TYPE")=MDETYP
 S MDRES=$$DATA2PCE^PXAPI("^TMP(""MDPXAPI"",$J)",MDPKG,"CLINICAL PROCEDURES",.MDVISIT,"","",1,"",.MDPERR)
 I MDRES D  Q MDOUT
 .S MDOUT=MDVISIT_"^"_MDCLOC_";"_MDPDTE_";"_MDTYP
 .S MDFDA(702,MDINST_",",.07)=MDTYP_";"_MDPDTE_";"_MDCLOC
 .S:MDVISIT>0 MDFDA(702,MDINST_",",.13)=MDVISIT
 .D FILE^DIE("K","MDFDA") K ^TMP("MDPXAPI",$J)
 K ^TMP("MDPXAPI",$J)
 S MDOUT="-1^PCE Visit Creation Error."
 Q MDOUT
