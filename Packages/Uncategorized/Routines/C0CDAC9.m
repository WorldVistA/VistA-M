C0CDAC9 ; GPL - Patient Portal - CCDA Routines ;09/17/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
 ; reason for visit
 ;
RFV(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ; reason for visit
 ;
 N C0ARY,PARMS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 Q:$$REDACT^C0CDACV("uri_reasonForVisit",.PARMS)
 Q:$$REDACT^C0CDACV("URI_REASONFORVISIT",.PARMS)
 I $G(PARMS("REASONFORVISIT"))="" S C0ARY("reasonForVisit")="Unknown"
 E  S C0ARY("reasonForVisit")=PARMS("REASONFORVISIT")
 ;
 ; the Reason for Visit section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("RFVSECT"))
 D GETNMAP^C0CDACU(SSECT,"TRFVSEC^C0CDAC9","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ;
 Q
 ;
 ;
TRFVSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.12"></templateId> <code code="29299-5" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="REASON FOR VISIT"></code>
 ;;<title>Reason For Visit</title>
 ;;<text ID="uri_reasonForVisit">
 ;;<paragraph>@@reasonForVisit@@</paragraph>
 ;;</text>
 ;;</section>
 ;;</component>
 Q
 ;
 ; plan of care
 ;
PLOC(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N C0ARY,PARMS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 Q:$$REDACT^C0CDACV("uri_planOfCare",.PARMS)
 Q:$$REDACT^C0CDACV("URI_PLANOFCARE",.PARMS)
 I $G(PARMS("PLANOFCARE"))="" S C0ARY("planOfCare")="Unknown"
 E  S C0ARY("planOfCare")=PARMS("PLANOFCARE")
 ;
 ; the Plan of Care section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("PLOCSECT"))
 D GETNMAP^C0CDACU(SSECT,"TPLOCSEC^C0CDAC9","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ;
 Q
 ;
 ;
TPLOCSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.10"></templateId>
 ;;<code code="18776-5" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Treatment plan"></code>
 ;;@@text@@
 ;;</section>
 ;;</component>
 Q
 ;
 ; reason for referral
 ;
RFR(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N C0ARY,PARMS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 Q:$$REDACT^C0CDACV("uri_reasonForReferral",.PARMS)
 Q:$$REDACT^C0CDACV("URI_REASONFORREFERRAL",.PARMS)
 I $G(PARMS("REASONFORREFERRAL"))="" S C0ARY("reasonForReferral")="Unknown"
 E  S C0ARY("reasonForReferral")=PARMS("REASONFORREFERRAL")
 ;
 ; the Reason For Referral section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("RFRSECT"))
 D GETNMAP^C0CDACU(SSECT,"TRFRSEC^C0CDAC9","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ;
 Q
 ;
 ;
TRFRSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.1"></templateId>
 ;;<code code="42349-1" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="REASON FOR REFERRAL"></code>
 ;;<title>Reason For Referral</title>
 ;;<text ID="uri_reasonForReferral">
 ;;<paragraph>@@reasonForReferral@@</paragraph>
 ;;</text>
 ;;</section>
 ;;</component>
 Q
 ;
 ; functional status
 ;
FUNC(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N C0ARY,PARMS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 Q:$$REDACT^C0CDACV("uri_functionalStatus",.PARMS)
 Q:$$REDACT^C0CDACV("URI_FUNCTIONALSTATUS",.PARMS)
 I $G(PARMS("FUNCTIONALSTATUS"))="" S C0ARY("functionalStatus")="Unknown"
 E  S C0ARY("functionalStatus")=PARMS("FUNCTIONALSTATUS")
 ;
 ; the Functional Status section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("FUNCSECT"))
 D GETNMAP^C0CDACU(SSECT,"TFUNCSEC^C0CDAC9","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ;
 Q
 ;
 ;
TFUNCSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.14"></templateId>
 ;;<code code="47420-5" codeSystem="2.16.840.1.113883.6.1"></code>
 ;;@@text@@
 ;;</section>
 ;;</component>
 Q
 ;
 ; advance directives
 ;
ADVD(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N C0ARY,PARMS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 Q:$$REDACT^C0CDACV("uri_advanceDirectives",.PARMS)
 Q:$$REDACT^C0CDACV("URI_ADVANCEDIRECTIVES",.PARMS)
 I $G(PARMS("ADVANCEDIRECTIVES"))="" S C0ARY("advanceDirectives")="No advance directives exist for this patient."
 E  S C0ARY("advanceDirectives")=PARMS("ADVANCEDIRECTIVES")
 ;
 ; the Advance Directives section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("ADVDSECT"))
 D GETNMAP^C0CDACU(SSECT,"TADVDSEC^C0CDAC9","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ;
 Q
 ;
 ;
TADVDSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.21"></templateId>
 ;;<code code="42348-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Advance Directives"></code>
 ;;@@text@@
 ;;</section>
 ;;</component>
 Q
 ;
 ;
 ; instructions
 ;
INST(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N C0ARY,PARMS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 Q:$$REDACT^C0CDACV("uri_instructions",.PARMS)
 Q:$$REDACT^C0CDACV("URI_INSTRUCTIONS",.PARMS)
 I $G(PARMS("INSTRUCTIONS"))="" S C0ARY("text")="Unknown"
 E  S C0ARY("text")=PARMS("INSTRUCTIONS")
 ;
 ; the Instructions section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("INSTSECT"))
 D GETNMAP^C0CDACU(SSECT,"TINSTSEC^C0CDAC9","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ;
 Q
 ;
 ;
TINSTSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.45"></templateId>
 ;;<id root="184fdbe3-f480-4199-976d-e0bb0dd02551"></id>
 ;;<code code="69730-0" codeSystem="2.16.840.1.113883.6.1" codeSystemVersion="LOINC" displayName="Instructions"></code>
 ;;<title>Instructions</title>
 ;;<text ID="uri_instructions">
 ;;@@text@@
 ;;</text>
 ;;</section>
 ;;</component>
 Q
 ;
TNOTESEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.45"></templateId>
 ;;<id root="184fdbe3-f480-4199-976d-e0bb0dd02551"></id>
 ;;<code code="69730-0" codeSystem="2.16.840.1.113883.6.1" codeSystemVersion="LOINC" displayName="Instructions"></code>
 ;;@@text@@
 ;;</section>
 ;;</component>
 Q
 ;
 ;
 ; family history
 ;
FAMH(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N C0ARY,PARMS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 Q:$$REDACT^C0CDACV("uri_familyHistory",.PARMS)
 Q:$$REDACT^C0CDACV("URI_FAMILYHISTORY",.PARMS)
 I $G(PARMS("FAMILYHISTORY"))="" S C0ARY("familyHistory")="Non-contributory"
 E  S C0ARY("familyHistory")=PARMS("FAMILYHISTORY")
 ;
 ; the Family History section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("FAMHSECT"))
 D GETNMAP^C0CDACU(SSECT,"TFAMHSEC^C0CDAC9","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ;
 Q
 ;
 ;
TFAMHSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.15"></templateId>
 ;;<code code="10157-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Family History"></code>
 ;;<title>Family History</title>
 ;;<text ID="uri_familyHistory">
 ;;<paragraph>@@familyHistory@@</paragraph>
 ;;</text>
 ;;</section>
 ;;</component>
 Q
 ;
 ;
 ; Discharge Instructions
 ;
DIS(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ; 
 ;
 N C0ARY,PARMS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 Q:$$REDACT^C0CDACV("uri_dischargeInstructions",.PARMS)
 Q:$$REDACT^C0CDACV("URI_DISCHARGEINSTRUCTIONS",.PARMS)
 I $G(PARMS("DISCHARGE"))="" S C0ARY("dischargeText")="Unknown"
 E  S C0ARY("dischargeText")=PARMS("DISCHARGE")
 ;
 ; the Discharge Instructions section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("DISSECT"))
 D GETNMAP^C0CDACU(SSECT,"TDISSEC^C0CDAC9","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ;
 Q
 ;
 ;
TDISSEC ;
 ;;<component>
 ;; <section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.41"/>
 ;;<code code="8653-8" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Hospital Discharge Instructions"/>
 ;;@@text@@
 ;;</section>
 ;;</component>
 Q
 ;
