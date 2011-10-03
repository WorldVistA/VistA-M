SROESAR1 ;BIR/ADM - ANESTHESIA REPORT E-SIG UTILITY ; [ 02/14/04  9:08 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
MULT ; process multiples
 N I,SRFF,SRI,SRK1,SRP,SRJ,SRFF,SRFLD,SRNP,SRN,SRCAT,SRP,SRSUB,SRL,SRE,SRE1,SRW,X,Y
 S SRI="."_$P(SRK,".",2) D TR S SRK1=SRP
 F SRJ=0:1 S SRFLD=$P($T(@SRK1+SRJ),";;",2) Q:SRFLD=""  D ^SROESARA
 Q
REV N SRP D TR S SRK1=SRP,SRFLD=$P($T(@SRK1+SRJ),";;",2)
 Q
TR S SRP=SRI,SRP=$TR(SRP,"1234567890.,","ABCDEFGHIJPK")
 Q
FIELD ; list of fields
PAF ;;Other Procedures Performed^0;.42^13,0
 ;;Other Procedures Performed^01-Other Procedure-130.16,.01-2^13,0;1
 ;;Other Procedures Performed^02X-CPT Code-130.16,3-4^13,2;1
PAFD ;;Other Procedures Performed^03X-CPT Modifier-130.164,.01-4^13,MOD,0;1
 ;;Other Procedures Performed^04X-Completed-130.16,2-4^13,0;3
 ;;Other Procedures Performed^05X-Procedure Code Comments-130.16,1.5;W-4^13,1,0;1
 ;;
PJF ;;Anesthesia Technique(s)^0;.37^6,0
 ;;Anesthesia Technique(s)^01-Anesthesia Technique-130.06,.01-2^6,0;1
 ;;Anesthesia Technique(s)^02-Principal Technique-130.06,.05-4^6,0;3
PDG ;;Anesthesia Technique(s)^03-Anesthesia Agent-130.47,.01-4^6,1,0;1
 ;;Anesthesia Technique(s)^04-Dose (mg)-130.47,1-6^6,1,0;2
 ;;Anesthesia Technique(s)^05-Monitored Anesthesia Care ? (Y/N)-130.06,41-4^6,8;1
 ;;Anesthesia Technique(s)^06-Intubated ? (Y/N)-130.06,42-4^6,8;2
 ;;Anesthesia Technique(s)^07-Approach-130.06,3-4^6,0;5
 ;;Anesthesia Technique(s)^08-Route-130.06,4-4^6,0;6
 ;;Anesthesia Technique(s)^09-Laryngoscope Type-130.06,5-4^6,0;7
 ;;Anesthesia Technique(s)^10-Laryngoscope Size-130.06,6-4^6,0;8
 ;;Anesthesia Technique(s)^11-Stylet Used (Y/N)-130.06,7-4^6,0;9
 ;;Anesthesia Technique(s)^12-Lidocaine Topical-130.06,8-4^6,0;10
 ;;Anesthesia Technique(s)^13-Lidocaine IV-130.06,9-4^6,0;11
 ;;Anesthesia Technique(s)^14-Tube Type-130.06,10-4^6,0;12
 ;;Anesthesia Technique(s)^15-Tube Size-130.06,11-4^6,0;13
 ;;Anesthesia Technique(s)^16-Trauma-130.06,12-4^6,0;14
 ;;Anesthesia Technique(s)^17-Extubated In-130.06,21-4^6,0;23
 ;;Anesthesia Technique(s)^18-Extubated By-130.06,39-4^6,6;1
 ;;Anesthesia Technique(s)^19-Reintubated Within 8 Hours-130.06,22-4^6,0;24
 ;;Anesthesia Technique(s)^20-Heat, Moisture Exchanger-130.06,17-4^6,0;19
 ;;Anesthesia Technique(s)^21-Bacterial Filter in Circuit-130.06,18-4^6,0;20
 ;;Anesthesia Technique(s)^22-Continuous Administration ? (Y/N)-130.06,25-4^6,2;1
 ;;Anesthesia Technique(s)^23-Baricity-130.06,26-4^6,2;2
 ;;Anesthesia Technique(s)^24-Puncture Site-130.06,27-4^6,2;3
 ;;Anesthesia Technique(s)^25-Needle Size-130.06,29-4^6,2;5
 ;;Anesthesia Technique(s)^26-Neurodermatone Anesthesia Sensory Level-130.06,43-4^6,8;3
 ;;Anesthesia Technique(s)^27-Dural Puncture ? (Y/N)-130.06,34-4^6,3;4
 ;;Anesthesia Technique(s)^28-Catheter Removed By-130.06,35-4^6,3;5
 ;;Anesthesia Technique(s)^29-Date/Time Catheter Removed-130.06,44-4^6,8;4
PDI ;;Anesthesia Technique(s)^30-Regional Block Site-130.49,.01-4^6,5,0;1
 ;;Anesthesia Technique(s)^31-Needle Length (cm)-130.49,1-4^6,5,0;2
 ;;Anesthesia Technique(s)^32-Needle Guage-130.49,2-4^6,5,0;3
 ;;Anesthesia Technique(s)^33X-Patient Status-130.06,2-4^6,0;4
 ;;Anesthesia Technique(s)^34X-Bite Block (Y/N)-130.06,13-4^6,0;15
 ;;Anesthesia Technique(s)^35X-Tube Lubrication-130.06,14-4^6,0;16
 ;;Anesthesia Technique(s)^36X-Taped at Length-130.06,15-4^6,0;17
 ;;Anesthesia Technique(s)^37X-Breath Sounds OK Bilaterally-130.06,16-4^6,0;18
 ;;Anesthesia Technique(s)^38X-Anesthesia Ventilator Tidal Volume-130.06,19-4^6,0;21
 ;;Anesthesia Technique(s)^39X-Anesthesia Ventilator Rate-130.06,20-4^6,0;22
 ;;Anesthesia Technique(s)^40X-Preoxygenation-130.06,23-4^6,0;25
 ;;Anesthesia Technique(s)^41X-Spinal Approach-130.06,28-4^6,2;4
 ;;Anesthesia Technique(s)^42X-Epidural Method-130.06,30-4^6,3;1
 ;;Anesthesia Technique(s)^43X-Multiple Attempts-130.06,31-4^6,3;2
PDH ;;Anesthesia Technique(s)^44X-Test Dose-130.48,.01-4^6,4,0;1
 ;;Anesthesia Technique(s)^45X-Dose-130.48,1-4^6,4,0;2
 ;;Anesthesia Technique(s)^46X-Test Dose Volume-130.06,33-4^6,3;3
 ;;Anesthesia Technique(s)^47X-Method of Administration-130.06,36-4^6,3;6
 ;;Anesthesia Technique(s)^48X-Purpose-130.06,37-4^6,3;7
 ;;Anesthesia Technique(s)^49X-Anesthesia Comments-130.06,40;W-4^6,7,0;1
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
PJD ;;Blood Replacement Fluids^0;.27^4,0
 ;;Blood Replacement Fluids^01-Replacement Fluid Type-130.04,.01-2^4,0;1
 ;;Blood Replacement Fluids^02-Quantity (ml)-130.04,1-4^4,0;2
 ;;Blood Replacement Fluids^03-Source Identification-130.04,3-4^4,0;4
 ;;Blood Replacement Fluids^04-VA Identification-130.04,4-4^4,0;5
 ;;Blood Replacement Fluids^05X-Comments-130.04,5;W-4^4,1,0;1
 ;;
PDA ;;Monitor(s)^0;.293^27,0
 ;;Monitor(s)^01-Monitor-130.41,.01-2^27,0;1
 ;;Monitor(s)^02-Time Applied-130.41,1-4^27,0;2
 ;;Monitor(s)^03-Time Removed-130.41,2-4^27,0;3
 ;;Monitor(s)^04-Applied By-130.41,3-4^27,0;4
 ;;
