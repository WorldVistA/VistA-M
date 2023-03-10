TIUCCRHL7P4 ; CCRA/PB - TIU CCRA HL7 Msg Processing; January 6, 2006
 ;;1.0;TEXT INTEGRATION UTILITIES;**344**;Jun 20, 1997;Build 11
 ;
 ;PB - Patch 344 to modify how the note and addendum text is formatted
 ;
 Q
WORD ;
 K I1,CNT,LCNT,LEN,I,LINES,T2,LASTWORDS,TEST1,WORDS,WORDSLEN,XX
 S WORDS=$G(TIUZ("TEXT",1,0)),WORDSLEN=$L(TIUZ("TEXT",1,0))
 I $G(ADDENDUM)'="" D
 .S NOTEDATE=$$GETDATE
 .S NOTENUM=$$NOTENUM
 .S TIUIEN=$$TIULKUP^TIUCCHL7UT(VNUM,TIU("TITLE"),$G(NOTEDATE),$G(NOTENUM)) ;Patch 344 lookup the note in the consult to file the addendum with
 .;S:$G(NOTENUM)'="" TIUIEN=$$TIULKUP^TIUCCHL7UT(VNUM,TIU("TITLE"),NOTEDATE,NOTENUM) ;Patch 344 lookup the note in the consult to file the addendum with
 .;S T2("VETERAN'S"_$C(160)_"CAREGIVER"_$C(160)_"CONTACT")="VETERAN'S CAREGIVER CONTACT",WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 F TEST1=1:1:WORDSLEN S LASTWORDS=$E(TIUZ("TEXT",1,0),WORDSLEN,(WORDSLEN-25))
 ;K T2 S T2("PROVIDER"_$C(160)_"CONTACT ADDENDUM")="PROVIDER CONTACT ADDENDUM"
 ;S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 I $G(ADDENDUM)["ADDENDUM" D
 .I ADDENDUM["APPOINTMENT MANAGEMENT ADDENDUM" D AMA^TIUCCRHL7P5,FORMAT  ;done
 .I ADDENDUM["CARE COORDINATION FOLLOW UP ADDENDUM" D CCFUA^TIUCCRHL7P6,FORMAT  ;done
 .I ADDENDUM["CASE MANAGEMENT ADDENDUM" D CMA^TIUCCRHL7P6,FORMAT  ;done
 .I ADDENDUM["CONTINUED STAY REVIEW ADDENDUM" D CSRA,FORMAT  ;done
 .I ADDENDUM["DISCHARGE PLANNING ADDENDUM" D DPA^TIUCCRHL7P5,FORMAT  ;done
 .I ADDENDUM["DISCHARGE DISPOSITION ADDENDUM" D DISP^TIUCCRHL7P5,FORMAT  ;done
 .I ADDENDUM["DISEASE MANAGEMENT ADDENDUM" D DMA^TIUCCRHL7P5,FORMAT  ;done
 .I ADDENDUM["PROVIDER CONTACT ADDENDUM" D PCA^TIUCCRHL7P7,FORMAT  ;done
 .I ADDENDUM["TRANSFER ADDENDUM" D TA^TIUCCRHL7P7,FORMAT  ;done
 .I ADDENDUM["VETERAN CONTACT ADDENDUM" D VCA^TIUCCRHL7P7,FORMAT  ;done
 .I ADDENDUM["VETERAN HANDOFF ADDENDUM" D VHA^TIUCCRHL7P7,FORMAT
 ;need to take a look at the code int he CCPN code and update it with the code from WORD^TIUCCRHL7P1
 ;I $G(ADDENDUM)="" D CCPN^TIUCCRHL7P6,FORMAT
 Q
FORMAT ;
 S LEN=$L(WORDS),I1=1,XX=1,CNT=0,LCNT=0
 F I=1:1:LEN D
 .S LCNT=LCNT+1
 .;I LCNT>100&($E(WORDS,I)=" ")!($E(WORDS,I)=$C(160))!($E(WORDS,I)=$C(10))!($E(WORDS,I)=" "&($E(WORDS,I+1)=" ")&($E(WORDS,I+2)'=" ")) D
 .I LCNT>100&($E(WORDS,I)=" ")!($E(WORDS,I)=$C(160))!($E(WORDS,I)=$C(10)) D
 ..S:XX=1 LINES("TEXT",XX,0)=$$TRIM^XLFSTR($E(WORDS,1,63),"LR"),XX=XX+1,I=64,LCNT=0,I1=I
 ..Q:XX=1
 ..S LINES("TEXT",XX,0)=$TR($E(WORDS,I1,I-1),$C(160)," "),LINES("TEXT",XX,0)=$$TRIM^XLFSTR(LINES("TEXT",XX,0),"LR"),XX=XX+1,LCNT=0  ;,I1=I
 ..W !,$G(LINES("TEXT",XX-1,0)),"  ",XX-1_"^"_I1_"^"_I_"^"_LCNT
 ..S I1=I
 I I1'=LEN N LASTLINES S LASTLINES=$E(WORDS,I1,I) K T2 S T2($C(160)_" ")="" S LINES("TEXT",XX,0)=$$REPLACE^XLFSTR(LASTLINES,.T2)
 M TIUZ("TEXT")=LINES("TEXT")
 K LINES("TEXT")
 Q
GETDATE() ; parse date/time of original note. Patch 344 mods to parse out the date of the original note
 N D1,D2
 S D2=""
 S D1=$P(WORDS,"Original CCP Note Date (mm/dd/yyyy):",2),D2=$P(D1,"CCPN Number:",1)
 K T2 S T2($C(160))="" S D2=$$REPLACE^XLFSTR(D2,.T2),D2=$TR(D2," ","")
 S D2=$P(D2,"/",3)_$P(D2,"/",1)_$P(D2,"/",2),D2=$$HL7TFM^XLFDT(D2)
 Q $G(D2)
NOTENUM() ;
 N N1,N2
 S N2=""
 ;CCPN Number:?2 ?  CONSULT AND REFERRAL INFORMATION
 S N1=$P(WORDS,"CCPN Number:",2),N2=$P(N1,"CONSULT AND REFERRAL INFORMATION",1)
 S N2=$TR(N2,$C(10),""),N2=$TR(N2," ",""),N2=$TR(N2,$C(160),"")
 S:N2'?.N N2=+$P(N2,":",2)
 Q $G(N2)
CSRA ;
 D COMMON
 ;K T2,T4 S T4=" "_$C(160)_"  VETERAN'S"_$C(160)_"CAREGIVER"_$C(160)_"CONTACT INFO",T2(T4)=$C(160)_$C(160)_"VETERAN'S CAREGIVER CONTACT INFOMATION"_$C(160)
 K T2,T4 S T4=$C(60)_"************ CONTINUED STAY REVIEW ADDENDUM"_$C(160)_"************ ",T2(T4)=$C(10)_"************ CONTINUED STAY REVIEW ADDENDUM ************" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 ;K T2,T4 S T4=" "_$C(160)_" VETERAN'S"_$C(160)_"CAREGIVER"_$C(160)_"CONTACT INFO",T2(T4)=$C(160)_$C(160)_"VETERAN'S CAREGIVER CONTACT INFOMATION"_$C(160)
 K T2,T4 S T4="Initial  Contact",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Date:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Date of Admission:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Date of Procedure:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Not applicable (Y/N) ",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Facility Name:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Point of Contact",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Name:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Point of Contact Dept:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Point of Contact Phone:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Point of Contact Fax Number:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Method of Contact:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Impatient level of care required:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Behavioral Health ICU ICU Stepdown Medicine Observation Surgical Telemetry Follow Up ",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit (Include Veteran's status, procedures, admitting diagnosis, etc.)",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="(Include Veteran's status, procedures, admitting diagnosis, etc.):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Provider contact information",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Provider contacted information (Enter provider contact information):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Level of Care Required",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Impatient level of care required:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Behavior Health ICU ICU Stepdown Medicine Observation Surgical Telemetry ",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Anticipated LOS ",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Anticipated Length of Stay: (Days/Weeks/Months)",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit LST Information  No  Yes",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="(Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Isolation",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Contact Precaution (Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Droplet Precautions (Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Airborne Precautions (Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Neutropenic Precautions (Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Radiation Precautions (Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Standard Precautions (Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Contact Enteric Precautions (Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="AFB Precautions (Comment):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Unknown  Enter/Edit Plan",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Plan:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="CC Plan may include specialty and associated appt information, date of surgery post op needs, post d/c appointment and any other care coordination plan Plan: ",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Handoff Information ",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="The Veteran's assigned lead coordinator is",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
COMMON ;
 K T2 S T2("Veteran Last Name: ")=$C(160)_"Veteran Last Name: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran First Name: ")=$C(160)_"Veteran First Name: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Social:")=$C(10)_"Veteran Social:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Date: ")=$C(10)_"Date: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2($C(160)_" Original CCP Note Date (mm/dd/yyyy): ")=$C(160)_"Original CCP Note Date (mm/dd/yyyy): " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("CCPN Number:"_$C(160))=$C(160)_"CCPN Number: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("CONSULT AND REFERRAL INFORMATION")=$C(160)_$C(160)_"CONSULT AND REFERRAL INFORMATION"_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Name of Referring VA Provider: ")=$C(160)_"Name of Referring VA Provider: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Selected SEOC: ")=$C(160)_"Selected SEOC: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Referral Number: ")=$C(160)_"Referral Number: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Unique Consult ID: ")=$C(160)_"Unique Consult ID: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Patient Admitted (Yes/No): If yes, then please complete the Discharge Planning Addendum.",T2($G(T4))=$C(160)_$C(160)_$G(T4) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4=$C(160)_" Please review all notes, this note may have one or more of the following addenda associated: ",T2($G(T4))=$C(10)_$G(T4) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Care Coordination Follow Up:"_$C(160))=$C(10)_"Care Coordination Follow Up: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Appointment Management: ")=$C(10)_"Appointment Management: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Case Management: ")=$C(160)_"Case Management: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Continued Stay Review: ")=$C(160)_"Continued Stay Review: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Disease Management: ")=$C(160)_"Disease Management: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Discharge Planning: ")=$C(160)_"Discharge Planning: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Discharge Disposition: ")=$C(160)_"Discharge Disposition: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Contact: ")=$C(160)_"Veteran Contact: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Provider Contact: ")=$C(160)_"Provider Contact: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Transfer: ")=$C(160)_"Transfer: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Handoff:"_$C(160))=$C(160)_"Veteran Handoff: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("FACILITY COMMUNITY CARE OFFICE CONTACT")=$C(160)_$C(160)_"FACILITY COMMUNITY CARE OFFICE CONTACT"_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Care Coordination Point of Contact:"_$C(160))=$C(160)_"Care Coordination Point of Contact:  " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Phone Number: "_$C(160))=$C(160)_"Phone Number: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 ;K T2,T4 S T4=" "_$C(160)_"  VETERAN'S"_$C(160)_"CAREGIVER"_$C(160)_"CONTACT INFO",T2(T4)=$C(160)_$C(160)_"X VETERAN'S CAREGIVER CONTACT INFOMATION"_$C(160)
 K T2,T4 S T4="VETERAN'S CAREGIVER CONTACT INFO",T2(T4)=$C(10)_T4_$C(10) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Is Veteran's caregiver same as next of kin listed in the demographic section of CPRS (Yes/No)?:  If no, provide the following: ",T2($G(T4))=$C(160)_$G(T4) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran's Caregiver Point of Contact: ")=$C(160)_"Veteran's Caregiver Point of Contact: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Caregiver's Relationship to Veteran: ")=$C(10)_"Caregiver's Relationship to Veteran: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Caregiver's Primary Phone Number: ")=$C(10)_"Caregiver's Primary Phone Number: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("PLAN:")=$C(10)_$C(10)_"PLAN: "_$C(10) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="*** CC Plan may include specialty and associated appointment information, date of surgery, post-op needs, post d/c appointment, and any other care coordination plan ***" D
 . S T2=$G(T4)=$C(160)_$G(T4)_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("ADDITIONAL NOTES:")=$C(160)_$C(160)_"ADDITIONAL NOTES: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
