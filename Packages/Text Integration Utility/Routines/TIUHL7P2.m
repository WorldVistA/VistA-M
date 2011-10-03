TIUHL7P2 ; SLC/AJB - TIUHL7 Msg Processing; March 23, 2005
 ;;1.0;TEXT INTEGRATION UTILITIES;**200,228**;Jun 20, 1997
 Q
CONTINUE ; data verification
 ;
 ; DOCUMENT TEXT
 D
 . N TIUI S TIUTMP=0 F  S TIUTMP=$O(TIUZ("TEXT",TIUTMP)) Q:'TIUTMP  I +$L(TIUZ("TEXT",TIUTMP,0)) S TIUI=1
 . I '+$G(TIUI) D ERR^TIUHL7U1("OBX",1,"0000.00","Missing DOCUMENT TEXT.")
 ;
 ; DOCUMENT TITLE
 I +TIU("TDA")'>0 D ERR^TIUHL7U1("TXA",16,"0000.00","Could not resolve the document title "_TIU("TITLE")_".")
 I +$$GET1^DIQ(8925.1,TIU("TDA"),.07,"I")'=11 D ERR^TIUHL7U1("TXA",16,"0000.00","The document title "_TIU("TITLE")_" must be ACTIVE before use.")
 ;
 ; AUTHOR/DICTATOR
 D
 . I '+$L(TIU("AUNAME")) D ERR^TIUHL7U1("TXA",9,"0000.00","Missing AUTHOR/DICTATOR name from HL7 message.") Q
 . I '+$G(TIU("AUDA")),'+$G(TIU("AUSSN")) S TIU("AUDA")=$$LU^TIUHL7U1(200,TIU("AUNAME"),"X") I '+TIU("AUDA") D ERR^TIUHL7U1("TXA",9,"0000.00","AUTHOR/DICTATOR name lookup failed for ["_TIU("AUNAME")_"].") Q
 . I '+$G(TIU("AUDA")),+$G(TIU("AUSSN")) S TIU("AUDA")=+$$FIND1^DIC(200,"","X",+$G(TIU("AUSSN")),"SSN") I '+TIU("AUDA") D ERR^TIUHL7U1("TXA",9,"0000.00","SSN ["_TIU("AUSSN")_"] lookup failed for AUTHOR/DICTATOR.") Q
 . I '$$COMPARE^TIUHL7U1($$GET1^DIQ(200,TIU("AUDA"),.01),TIU("AUNAME")) D
 . . D ERR^TIUHL7U1("TXA",9,"0000.00","AUTHOR/DICTATOR name discrepancy between HL7 message IEN/SSN ["_$$GET1^DIQ(200,TIU("AUDA"),.01)_"]"_" & the HL7 message name ["_TIU("AUNAME")_"].")
 ;
 ; EXPECTED CO-SIGNER [ignored if AUTHOR/DICTATOR does not require]
 I $$REQCOSIG^TIULP($G(TIU("TDA")),,$G(TIU("AUDA")),$G(TIU("RFDT"))) D
 . N TIUTMP
 . S TIUZ(1506)=1
 . I +$L($G(TIU("CSNAME")))!(+$G(TIU("CSDA")))!(+$G(TIU("CSSSN"))) D
 . . I '+$L($G(TIU("CSNAME"))) D ERR^TIUHL7U1("TXA",10,"0000.00","Missing EXPECTED COSIGNER name from HL7 message.") Q
 . . I '+$G(TIU("CSDA")),'+$G(TIU("CSSSN")) S TIU("CSDA")=$$LU^TIUHL7U1(200,TIU("CSNAME"),"X") I '+TIU("CSDA") D ERR^TIUHL7U1("TXA",10,"0000.000","EXPECTED COSIGNER name lookup failed for ["_TIU("CSNAME")_"].") Q
 . . I '+$G(TIU("CSDA")),+$G(TIU("CSSSN")) S TIU("CSDA")=+$$FIND1^DIC(200,"","X",+$G(TIU("CSSSN")),"SSN") I '+TIU("CSDA") D ERR^TIUHL7U1("TXA",10,"0000.00","SSN ["_TIU("CSSSN")_"] lookup failed for EXPECTED COSIGNER.") Q
 . . I '$$COMPARE^TIUHL7U1($$GET1^DIQ(200,TIU("CSDA"),.01),TIU("CSNAME")) D
 . . . D ERR^TIUHL7U1("TXA",10,"0000.00","EXPECTED COSIGNER name discrepancy between HL7 message IEN/SSN ["_$$GET1^DIQ(200,TIU("CSDA"),.01)_"]"_" & HL7 message name ["_TIU("CSNAME")_"].")
 . I '+$G(TIU("CSDA")) D ERR^TIUHL7U1("TXA",10,"0000.000","Unable to resolve EXPECTED COSIGNER; the AUTHOR/DICTATOR ["_TIU("AUNAME")_"] requires COSIGNATURE.")
 ;
 ; ENTERED BY [optional]
 I +$L($G(TIU("EBNAME")))!(+$G(TIU("EBDA")))!(+$G(TIU("EBSSN"))) D
 . I '+$L($G(TIU("EBNAME"))) D ERR^TIUHL7U1("TXA",11,"0000.00","Missing ENTERED BY name from HL7 message.") Q
 . I '+$G(TIU("EBDA")),'+$G(TIU("EBSSN")) S TIU("EBDA")=$$LU^TIUHL7U1(200,TIU("EBNAME"),"X") I '+TIU("EBDA") D ERR^TIUHL7U1("TXA",11,"0000.000","ENTERED BY name lookup failed for ["_TIU("EBNAME")_"].") Q
 . I '+$G(TIU("EBDA")),+$G(TIU("EBSSN")) S TIU("EBDA")=+$$FIND1^DIC(200,"","X",+$G(TIU("EBSSN")),"SSN") I '+TIU("EBDA") D ERR^TIUHL7U1("TXA",11,"0000.00","SSN ["_TIU("EBSSN")_"] lookup failed for ENTERED BY.") Q
 . I '$$COMPARE^TIUHL7U1($$GET1^DIQ(200,TIU("EBDA"),.01),TIU("EBNAME")) D
 . . D ERR^TIUHL7U1("TXA",11,"0000.00","ENTERED BY name discrepancy between HL7 message IEN/SSN ["_$$GET1^DIQ(200,TIU("EBDA"),.01)_"]"_" & HL7 message name ["_TIU("EBNAME")_"].")
 ;
 ; EPISODE BEGIN DATE/TIME for DISCHARGE SUMMARIES
 I $$MEMBEROF^TIUHL7U1(TIU("TITLE"),"DISCHARGE SUMMARIES") D
 . I '+$G(TIU("CSDA")) D ERR^TIUHL7U1("TXA",10,"0000.000","DISCHARGE SUMMARIES require an ATTENDING PHYSICIAN (EXPECTED COSIGNER).")
 . S TIUZ(1209)=$G(TIU("CSDA"))
 . I +TIU("VNUM") D  Q
 . . I '$$COMPARE^TIUHL7U1($$GET1^DIQ(9000010,TIU("VNUM"),.05),$S(+$G(DFN):$$GET1^DIQ(2,DFN,.01),1:TIU("PTNAME"))) D
 . . . D ERR^TIUHL7U1("PV1",19,"0000.00","HL7 message PATIENT NAME ["_TIU("PTNAME")_"] does not match VISIT PATIENT NAME ["_$$GET1^DIQ(9000010,TIU("VNUM"),.05)_"].") Q
 . . S TIU("EPDT")=$$GET1^DIQ(9000010,TIU("VNUM"),.01,"I"),TIU("VSTR")=$$VSTRBLD^TIUSRVP(TIU("VNUM"))
 . I '+TIU("EPDT") D ERR^TIUHL7U1("PV1",44,"0000.000",TIU("TITLE")_" requires an EPISODE BEGIN DATE/TIME.") Q
 . I '+$$GETADMIT^TIUHL7U1(+$G(DFN),TIU("EPDT")) D ERR^TIUHL7U1("PV1","44","0000.00","Could not resolve ADMISSION DT[TIME] for "_$$FMTE^XLFDT(TIUDT)_".")
 ;
 ; VISIT information for PROGRESS NOTES
 I $$MEMBEROF^TIUHL7U1(TIU("TITLE"),"PROGRESS NOTES") D
 . I TIU("VNUM")="NEW" D  Q
 . . N TYP
 . . I '+TIU("HLOC"),TIU("AVAIL")'="AV" D ERR^TIUHL7U1("PV1",4,"0000.00","Missing/Invalid HOSPITAL LOCATION ('AV' not set); required for NEW visits.") Q
 . . I +TIU("EPDT")'>0 S TIU("EPDT")=$$NOW^XLFDT
 . . I $L(TIU("EPDT"),".")=1 S TIU("EPDT")=TIU("EPDT")_"."_$P($$NOW^XLFDT,".",2)
 . . I +TIU("HLOC") I $$GET1^DIQ(44,TIU("HLOC"),2,"I")="W" S TYP="I"
 . . I +TIU("HLOC")'>0 S TIU("HLOC")=""
 . . S TIU("VSTR")=TIU("HLOC")_";"_TIU("EPDT")_";"_$S($G(TYP)="I":"I",TIU("AVAIL")="AV":"E",1:"A")
 . I +TIU("VNUM") D  Q
 . . I '$$COMPARE^TIUHL7U1($$GET1^DIQ(9000010,TIU("VNUM"),.05),$S(+$G(DFN):$$GET1^DIQ(2,DFN,.01),1:TIU("PTNAME"))) D  Q
 . . . D ERR^TIUHL7U1("PV1",19,"0000.00","HL7 message PATIENT NAME ["_TIU("PTNAME")_"] does not match VISIT PATIENT NAME ["_$$GET1^DIQ(9000010,TIU("VNUM"),.05)_"].")
 . . S TIU("EPDT")=$$GET1^DIQ(9000010,TIU("VNUM"),.01,"I"),TIU("VSTR")=$$VSTRBLD^TIUSRVP(TIU("VNUM"))
 . I '+TIU("VNUM") D
 . . I +TIU("EPDT") I '+$$GETADMIT^TIUHL7U1(+$G(DFN),TIU("EPDT")),TIU("AVAIL")'="AV" D ERR^TIUHL7U1("PV1","44","0000.00","Could not find a visit for "_$$FMTE^XLFDT(TIU("EPDT"))_".") Q
 . . I '+$$GETVISIT^TIUHL7U1(+$G(DFN),TIU("RFDT")),TIU("AVAIL")'="AV" D ERR^TIUHL7U1("PV1","44","0000.00","Could not find a visit for "_$$FMTE^XLFDT(TIU("RFDT"))_".") Q
 . . S TIU("VSTR")=TIU("HLOC")_";"_$$NOW^XLFDT_";E"
 ;
 D CONTINUE^TIUHL7P3
 Q
