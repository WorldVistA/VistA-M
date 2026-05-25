TIUCCRHL7P7 ; CCRA/PB - TIU CCRA HL7 Msg Processing; January 6, 2006
 ;;1.0;TEXT INTEGRATION UTILITIES;**344,371**;Jun 20, 1997;Build 4
 ;
 ;PB - Patch 344 to modify how the note and addendum text is formatted
 ;PB - Patch 371 removes unused code
 ;
 Q
PCA ;
 D COMMON^TIUCCRHL7P4
 K T2 S T2("************ PROVIDER CONTACT ADDENDUM"_$C(160)_"************")=$C(10)_"************ PROVIDER CONTACT ADDENDUM************"_$C(10) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Date:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Original CCP Note Date (mm/dd/yyyy):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="CCPN Number:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="VETERAN'S"_$C(160)_"CAREGIVER"_$C(160)_"CONTACT INFO",T2(T4)=$C(10)_$C(10)_"VETERAN'S CAREGIVER CONTACT INFOMATION"_$C(10)
 K T2,T4 S T4="Caregiver's Alternate "_$c(160)_"Phone Number:",T2(T4)=$C(10)_"Caregiver's Alternate Phone Number: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
TA ;
 D COMMON^TIUCCRHL7P4
 K T2 S T2("************ TRANSFER ADDENDUM"_$C(160)_"************ Transfer")=$C(10)_"************ TRANSFER ADDENDUM ************"_$C(10) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Veteran Social:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Date:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Original CCP Note Date (mm/dd/yyyy):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="CCPN Number:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Transfer to other Community Medical Facility",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Reason for Transfer (Select One)",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Higher level of care",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Specialty care not available",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Facility Name:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Street Address:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="City:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="State:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Facility POC:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="POC Phone:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Transfer to VA",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Is the Veteran stable for transfer?",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Is Veteran requesting transfer to VA?",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Is Veteran refusing to transfer to VA?",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Reason(s) for refusal to transfer include:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Refusal to Transfer document signed and received by VA?",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="VA Transfer Coordinator notified?",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="VA Transfer Coordinator POC (Enter transfer coordinator name):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
VCA ;
 D COMMON^TIUCCRHL7P4
 K T2,T4 S T4="************ VETERAN CONTACT ADDENDUM"_$C(160)_"************",T2(T4)=$C(10)_"************ VETERAN CONTACT ADDENDUM ************" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Veteran Social:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Date:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Original CCP Note Date (mm/dd/yyyy):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="CCPN Number:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
VHA ;
 D COMMON^TIUCCRHL7P4
 K T2,T4 S T4="************ VETERAN HANDOFF ADDENDUM"_$C(160)_"************",T2(T4)=$C(10)_"************ VETERAN HANDOFF ADDENDUM ************" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Veteran Social:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Date:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Original CCP Note Date (mm/dd/yyyy):",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="CCPN Number:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Veteran Handoff:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
