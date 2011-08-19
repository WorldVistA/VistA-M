ORWPFSS2 ;SLC-GDU CPRS HL7 PROCESSING FOR RAD PRE-CERT;[04/15/05 09:19]; 4/28/05 15:34
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**228**;Dec 17, 1997
 ;Routine to process the HL7 message from the Ancillary Radiology 
 ;package for the Pre-Certification Account Reference to be associated
 ;with the radiology order record in the Order File, file # 100.
 ;External Variables, set by the HL7 processing
 ; ORIFN   - 1st piece of 3rd piece of ORC message segment, Order IEN
 ; ORMSG   - The HL7 message being processed
 ; PV1     - PV1 segment number in the HL7 message
 ;Internal Variables
 ; ORAR    - Order PFSS Account Reference
 ; ORFDA   - Fileman Data Array
 ; OREM    - Error Message
 ; ORIEN   - Order Internal Entry Number
 ; ORRPAR  - Order Radiology Pre-Certification Account Reference
 ; ORUPDT  - Order Update Indicator
 ; ORPFSS  - PFSS Active Indicator
 ;DBIA References
 ; $$GET1^DIQ         - DBIA 2056
 ; PFSSACTV^ORWPFSS   - Internal to CPRS PFSS
 ; $$ACCTREF^ORWPFSS1 - Internal to CPRS PFSS
PRECERT ;Process Radiology HL7 message for precertification PFSS Account
 ;Reference.
 N ORAR,ORFDA,OREM,ORIEN,ORRPAR,ORUPDT,ORPFSS
 ;If PFSS inactive quit
 D PFSSACTV^ORWPFSS(.ORPFSS) I ORPFSS=0 Q
 ;If PV1 is null quit
 I PV1="" Q
 ;If pre-cert not present in HL7 PV1 seg quit
 S ORRPAR=$P(@ORMSG@(PV1),"|",51)
 I ORRPAR="" Q
 ;If PFSS AR already on file with order quit
 S ORIEN=+ORIFN
 S ORAR=$$GET1^DIQ(100,ORIEN,97)
 I ORAR'="" Q
 ;Update order with pre-cert PFSS AR
 S ORUPDT=$$ACCTREF^ORWPFSS1(ORIEN,ORRPAR)
 I ORUPDT=1 Q
 ;Return error message is error happens during update
 S ORERR=$P(ORUPDT,U,2)
 Q
