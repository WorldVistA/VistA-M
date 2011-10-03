SROESNR1 ;BIR/ADM - NURSE REPORT E-SIG UTILITY ;02/20/05
 ;;3.0; Surgery ;**100,143,157**;24 Jun 93;Build 3
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
MULT ; process multiples
 N I,SRFF,SRI,SRK1,SRP,SRJ,SRFLD,SRNP,SRN,SRCAT,SRP,SRSUB,SRL,SRE,SRE1,SRW,X,Y
 S SRI="."_$P(SRK,".",2) D TR S SRK1=SRP
 F SRJ=0:1 S SRFLD=$P($T(@SRK1+SRJ),";;",2) Q:SRFLD=""  D ^SROESNRA
 Q
REV N SRP D TR S SRK1=SRP D
 .I SRCAT="Anesthesia Technique(s)" D REV^SROESNR3 Q
 .S SRFLD=$P($T(@SRK1+SRJ),";;",2)
 Q
TR S SRP=SRI,SRP=$TR(SRP,"1234567890.,","ABCDEFGHIJPK")
 Q
 ;;
PBC ;;Other Scrubbed Assistant(s)^0;30^28,0
 ;;Other Scrubbed Assistant(s)^01-Other Scrubbed Assistant-130.23,.01-2^28,0;1
 ;;Other Scrubbed Assistant(s)^02-Comments-130.23,1;W-4^28,1,0;1
 ;;
PBH ;;O.R. Circulating Nurse(s)^0;.111^19,0
 ;;O.R. Circulating Nurse(s)^01-O.R. Circulating Nurse-130.28,.01-2^19,0;1
 ;;O.R. Circulating Nurse(s)^02-Educational Status-130.28,3-4^19,0;3
PBI ;;O.R. Circulating Nurse(s)^03X-Time On-130.29,.01-4^19,1,0;1
 ;;O.R. Circulating Nurse(s)^04X-Time Off-130.29,1-6^19,1,0;2
 ;;O.R. Circulating Nurse(s)^05X-Reason for Relief-130.29,2-6^19,1,0;3
 ;;O.R. Circulating Nurse(s)^06X-Comment-130.29,3;W-6^19,1,1,0;1
 ;;
PCF ;;O.R. Scrub Nurse(s)^0;.112^23,0
 ;;O.R. Scrub Nurse(s)^01-O.R. Scrub Nurse-130.36,.01-2^23,0;1
 ;;O.R. Scrub Nurse(s)^02-Educational Status-130.36,3-4^23,0;3
 ;;O.R. Scrub Nurse(s)^03X-Time On-130.36,.01-4^19,1,0;1
 ;;O.R. Scrub Nurse(s)^04X-Time Off-130.36,1-6^19,1,0;2
 ;;O.R. Scrub Nurse(s)^05X-Reason for Relief-130.36,2-6^19,1,0;3
 ;;O.R. Scrub Nurse(s)^06X-Comment-130.36,3;W-6^19,1,1,0;1
 ;;
PBD ;;Other Persons in O.R.^0;31^32,0
 ;;Other Persons in O.R.^01-Other Person in O.R.-130.24,.01-2^32,0;1
 ;;Other Persons in O.R.^02-Title/Organization-130.24,1-4^32,0;2
 ;;
PJFE ;;Surgery Position(s)^0;65^42,0
 ;;Surgery Position(s)^01-Position-130.065,.01-2^42,0;1
 ;;Surgery Position(s)^02-Placed-130.065,1-4^42,0;2
 ;;
PCA ;;Restraints and Position Aids^0;.13^20,0
 ;;Restraints and Position Aids^01-Restraint/Position Aid-130.31,.01-2^20,0;1
 ;;Restraints and Position Aids^02-Applied By-130.31,1-4^20,0;2
 ;;Restraints and Position Aids^03-Comments-130.31,2-4^20,0;3
 ;;
PJBH ;;Principal CPT Modifier^0;28^OPMOD,0
 ;;Principal CPT Modifier^01-CPT Modifier-130.028,.01-2^OPMOD,0;1
 ;;
PAF ;;Other Procedures Performed^0;.42^13,0
 ;;Other Procedures Performed^01-Other Procedure-130.16,.01-2^13,0;1
 ;;Other Procedures Performed^02-CPT Code-130.16,3-4^13,2;1
PAFD ;;Other Procedures Performed^03-CPT Modifier-130.164,.01-4^13,MOD,0;1
 ;;Other Procedures Performed^04X-Completed-130.16,2-4^13,0;3
 ;;Other Procedures Performed^05X-Procedure Code Comments-130.16,1.5;W-4^13,1,0;1
 ;;
PJB ;;Tourniquet^0;.48^2,0
 ;;Tourniquet^01-Time Applied-130.02,.01-2^2,0;1
 ;;Tourniquet^02-Time Released-130.02,3-4^2,0;4
 ;;Tourniquet^03-Site Applied-130.02,1-4^2,0;2
 ;;Tourniquet^04-Pressure Applied (in TORR)-130.02,4-4^2,0;5
 ;;Tourniquet^05-Applied By-130.02,2-4^2,0;3
 ;;
PCB ;;Thermal Unit^0;.757^21,0
 ;;Thermal Unit^01-Thermal Unit-130.32,.01-2^21,0;1
 ;;Thermal Unit^02-Temperature-130.32,2-4^21,0;3
 ;;Thermal Unit^03-Time On-130.32,1-4^21,0;2
 ;;Thermal Unit^04-Time Off-130.32,3-4^21,0;4
 ;;
PJA ;;Prosthesis Installed^0;.47^1,0
 ;;Prosthesis Installed^01-Item-130.01,.01-2^1,0;1
 ;;Prosthesis Installed^02-Sterility Checked-130.01,8-4^1,2;1
 ;;Prosthesis Installed^03-Sterility Expiration Date-130.01,9-4^1,2;2
 ;;Prosthesis Installed^04-RN Verifier-130.01,10-4^1,2;3
 ;;Prosthesis Installed^05-Vendor-130.01,1-4^1,0;2
 ;;Prosthesis Installed^06-Model-130.01,2-4^1,0;3
 ;;Prosthesis Installed^07-Lot/Serial Number-130.01,2.5-4^1,0;5
 ;;Prosthesis Installed^08-Sterile Resp-130.01,5-4^1,0;7
 ;;Prosthesis Installed^09-Size-130.01,6-4^1,1;1
 ;;Prosthesis Installed^10-Quantity-130.01,7-4^1,1;2
 ;;
PCC ;;Medications^0;.375^22,0
 ;;Medications^01-Medication-130.33,.01-2^22,0;1
PCD ;;Medications^02-Time Administered-130.34,.01-4^22,1,0;1
 ;;Medications^03-Route-130.34,4-6^22,1,0;5
 ;;Medications^04-Dose-130.34,1-6^22,1,0;2
 ;;Medications^05-Ordered By-130.34,2-6^22,1,0;3
 ;;Medications^06-Administered By-130.34,3-6^22,1,0;4
 ;;Medications^07-Comments-130.34,5-6^22,1,0;6
 ;;
PJH ;;Irrigation Solution(s)^0;.39^26,0
 ;;Irrigation Solution(s)^01-Irrigation Solution-130.08,.01-2^26,0;1
PCI ;;Irrigation Solution(s)^02-Time Utilized-130.39,.01-4^26,1,0;1
 ;;Irrigation Solution(s)^03-Amount-130.39,1-6^26,1,0;2
 ;;Irrigation Solution(s)^04-Provider-130.39,2-6^26,1,0;3
 ;;
PJD ;;Blood Replacement Fluids^0;.27^4,0
 ;;Blood Replacement Fluids^01-Replacement Fluid Type-130.04,.01-2^4,0;1
 ;;Blood Replacement Fluids^02-Quantity (ml)-130.04,1-4^4,0;2
 ;;Blood Replacement Fluids^03-Source Identification-130.04,3-4^4,0;4
 ;;Blood Replacement Fluids^04-VA Identification-130.04,4-4^4,0;5
 ;;Blood Replacement Fluids^05-Comments-130.04,5;W-4^4,1,0;1
 ;;
PJABI ;;Laser Unit(s)^0;129^44,0
 ;;Laser Unit(s)^01-Laser Unit/ID-130.0129,.01-2^44,0;1
 ;;Laser Unit(s)^02-Duration-130.0129,1-4^44,0;2
 ;;Laser Unit(s)^03-Wattage-130.0129,2-4^44,0;3
 ;;Laser Unit(s)^04-Operator-130.0129,3-4^44,0;4
 ;;Laser Unit(s)^05-Plume Evacuator-130.0129,4-4^44,0;5
 ;;Laser Unit(s)^06-Comments-130.0129,5;W-4^44,1,0;1
 ;;
PJAC ;;Cell Saver(s)^0;130^45,0
 ;;Cell Saver(s)^01-Cell Saver ID-130.013,.01-2^45,0;1
 ;;Cell Saver(s)^02-Operator-130.013,1-4^45,0;2
 ;;Cell Saver(s)^03-Amount Salvaged (ml)-130.013,2-4^45,0;3
 ;;Cell Saver(s)^04-Amount Reinfused (ml)-130.013,3-4^45,0;4
 ;;Cell Saver(s)^05-Comments-130.013,5;W-4^45,2,0;1
PJACD ;;Cell Saver(s)^06-Disposables Name-130.0134,.01-4^45,1,0;1
 ;;Cell Saver(s)^07-Lot Number-130.0134,1-6^45,1,0;2
 ;;Cell Saver(s)^08-Quantity-130.0134,2-6^45,1,0;3
 ;;
PAH ;;Other Diagnosis^0;.74^15,0
 ;;Other Diagnosis^01X-Other Diagnosis-130.18,.01-2^15,0;1
 ;;Other Diagnosis^02-ICD Diagnosis Code-130.18,3-2^15,0;3
 ;;Other Diagnosis^03X-Diagnosis Comments-130.18,2;W-4^15,1,0;1
