PSSMIGRP ;AJF - Process Synch XML message from PEPS;  6/28/2012 0941
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;;Build 36
 ;;
 ; Called from ^PSSMIGRC
 ;;
 Q
 ;
 ;
VAP ;VAPRODUCT ;
 I PSS("bodyName")="vaProductSyncRequest" N RCNT D
 . S PSS("child")=1,PSS("FILE")=50.68,(PSSTITLE,PST)="syncResponse",RCNT=0
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vaProductName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vaProductIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. ; 
 .. ; Get vaGenericNameRecord
 .. I PSS("ELE")="vaGenericNameRecord" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="vaGenericNameName" S PSS("GENNAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="vaGenericIen" S PSS("GENIEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. ; 
 .. ; Get dosageFormRecord
 .. I PSS("ELE")="dosageFormRecord" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="dosageFormName" S PSS("DFNAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="dosageFormIen" S PSS("DFIEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. I PSS("ELE")="strength" S PSS("STRGEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="units" S PSS("UNITS")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="nationalFormularyName" S PSS("NFNAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vaPrintName" S PSS("PRINTNAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vaProductIdentifier" S PSS("PRODID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="transmitToCmop" S PSS("TRANSTC")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. ;
 .. ; Get vaDispenseUnitRecord
 .. I PSS("ELE")="vaDispenseUnitRecord" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="vaDispenseUnitName" S PSS("DUNAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="vaDispenseUnitIen" S PSS("DUIEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. ;
 .. ; Get activeIngredientsRecord
 .. I PSS("ELE")="activeIngredientsRecord" S RCNT=$G(RCNT)+1 D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="activeIngredientsName" S PSS("AINAME"_RCNT)=$G(^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1))
 .... I PSS("ELE1")="activeIngredientsIen" S PSS("AIIEN"_RCNT)=$G(^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1))
 .... I PSS("ELE1")="activeIngredientsStrength" S PSS("AISTRG"_RCNT)=$G(^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1))
 .... I PSS("ELE1")="activeIngredientsUnitsName" S PSS("AIUNAME"_RCNT)=$G(^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1))
 .... S PSS("ACTID")=RCNT
 .. ;
 .. I PSS("ELE")="gcnSeqNo" S PSS("GCNSEQNO")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. ;
 .. ; Get primaryVaDrugClassRecord
 .. I PSS("ELE")="primaryVaDrugClassRecord" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="primaryVaDrugClassCode" S PSS("PVADCCODE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="primaryVaDrugClassClassification" S PSS("PVADCCLASS")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="primaryVaDrugClassIen" S PSS("PVADCIEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. I PSS("ELE")="nationalFormularyIndicator" S PSS("NFINDICATOR")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="csFederalSchedule" S PSS("CSFSCHED")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="singleMultiSourceProduct" S PSS("SMSPROD")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="excludeDrugDrugInteraction" S PSS("EDDINTER")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="overrideDfDoseChkExclusion" S PSS("ODFDCHKX")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="createPossibleDosage" S PSS("CPDOSAGE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="masterEntryForVuid" S PSS("MVUID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vuid" S PSS("VUID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="productPackage" S PSS("PACK")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. ;
 .. ; Get effectiveDateTimeRecord
 .. I PSS("ELE")="effectiveDateTimeRecord" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="effectiveDateTime" S PSS("EFFDT")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="effectiveDateTimeStatus" S PSS("EDTS")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. I PSS("ELE")="possibleDosagesToCreate" S PSS("PDTCREATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("INACTDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="fdaMedGuide" S PSS("FDAMEDGUIDE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="serviceCode" S PSS("SCODE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 Q
 ;
DRUC ;DRUGCLASS 
 I PSS("bodyName")="drugClassSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.605,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="drugClassCode" S PSS("CLASSCODE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="drugClassIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="drugClassClassification" S PSS("CLASSCLASS")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ParentClass" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="drugClassIen" S PSS("PCIEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="code" S PSS("PCODE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="classification" S PSS("PCLASS")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. I PSS("ELE")="type" S PSS("TYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="masterEntryForVuid" S PSS("MASTERVUID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vuid" S PSS("VUID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="description" S PSS("DESC")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="effectiveDateTimeRecord" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="effectiveDateTime" S PSS("EFFDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="status" S PSS("STATUS")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 Q
 ;
DOF ;DOSAGEFORM ;
 I PSS("bodyName")="dosageFormSyncRequest" N UNCT,DCNT D
 . S (UCNT,DCNT)=0,PSS("child")=1,PSS("FILE")=50.606,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="dosageFormName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="excludeFromDosageChecks" S PSS("EXCLUDE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="dosageFormIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("INACTDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="unitsRecord" S UCNT=UCNT+1 D  Q
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="units" S PSS("UNITS"_UCNT)=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="unitsIen" S PSS("UNITSIEN"_UCNT)=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="package" S PSS("PACKAGE"_UCNT)=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... S PSS("UNITS")=UCNT
 .. I PSS("ELE")="dispenseUnitsPerDose" S DCNT=DCNT+1 D  Q
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="dispenseUnitsPerDoseNumber" S PSS("PDDOSE"_DCNT)=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="package" S PSS("PDPACKAGE"_DCNT)=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... S PSS("PERDOSE")=DCNT
 Q
