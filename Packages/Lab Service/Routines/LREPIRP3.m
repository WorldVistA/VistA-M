LREPIRP3 ;DALOI/CKA-EMERGING PATHOGENS HL7 REPORT CONVERSION ;5/14/2003
 ;;5.2;LAB SERVICE;**281**;Sep 27, 1994
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to ^DIC(21 supported by IA #2504
 Q
 ;NTE findings of 11, 12, 13, or 14.
 ;SAVE PID, PV1, and DG1 data.
 Q
PID ;
 D PID^LREPIRP2
PV1 ;
 D PV1^LREPIRP2
DG1 ;Save DG1 data
 ;^XTMP("LREPIREP"_date,PATHOGEN,dfn,"PV1",#,"DG1",#)
 Q
HDG ;Save title heading in ^XTMP("LREPIREP"_date,"HDG",linecount)
 S SITE=$$SITE^VASITE
 S LRDTHDG=^TMP("LREPIREP",$J,1)
 S MSG=$E(LRSP,1,15)_"DETAILED VERIFICATION REPORT OF EPI EXTRACTED DATA"
 S ^XTMP("LREPIREP"_LRDATE,"HDG",1)=MSG
 S MSG=$E(LRSP,1,80-$L(" FROM STATION "_$P(SITE,U,3)_" "_$P(SITE,U,2))/2)_" FROM STATION "_$P(SITE,U,3)_" "_$P(SITE,U,2)
 S ^XTMP("LREPIREP"_LRDATE,"HDG",2)=MSG
 S MSG="PROCESSING PERIOD: "
 S Y=$$CDT^LREPIRP2($P($P($P(LRDTHDG,HLFS,3),LRCS,2)," ",4))
 S MSG=MSG_Y
 S Y=$$CDT^LREPIRP2($P($P($P(LRDTHDG,HLFS,3),LRCS,2)," ",6))
 S LRHDGL2=MSG_"  through "_Y
 S ^XTMP("LREPIREP"_LRDATE,"HDG",3)=$E(LRSP,1,80-$L(LRHDGL2)/2)_LRHDGL2
 ;Save Heading info in ^XTMP("LREPIREP"_date,nte,"HDG",linecount)
NTE11 ;NTE~11 Report of Malaria heading
 S ^XTMP("LREPIREP"_LRDATE,11,"HDG",1)="NTE~11-Report of Malaria"
 S MSG="These data note persons at your facility during the month who had an ICD-9"
 S ^XTMP("LREPIREP"_LRDATE,11,"HDG",2)=MSG
 S MSG="coded diagnosis for malaria.  Identifying information has been provided."
 S ^XTMP("LREPIREP"_LRDATE,11,"HDG",3)=MSG
NTE12 ;NTE~12 Report of Dengue heading
 S MSG="NTE~12-Report of Dengue"
 S ^XTMP("LREPIREP"_LRDATE,12,"HDG",1)=MSG
 S MSG="These data note persons at your facility during the month who had an ICD-9"
 S ^XTMP("LREPIREP"_LRDATE,12,"HDG",2)=MSG
 S MSG="coded diagnosis for dengue.  Identifying information has been provided."
 S ^XTMP("LREPIREP"_LRDATE,12,"HDG",3)=MSG
NTE13 ;NTE~13 Report of Creutzfeldt-Jakob Disease heading
 S MSG="NTE~13-Report of Creutzfeldt-Jakob Disease"
 S ^XTMP("LREPIREP"_LRDATE,13,"HDG",1)=MSG
 S MSG="These data note persons at your facility during the month who had an ICD-9"
 S ^XTMP("LREPIREP"_LRDATE,13,"HDG",2)=MSG
 S MSG="coded diagnosis for Creutzfeldt-Jakob disease.  Identifying information has been provided."
 S ^XTMP("LREPIREP"_LRDATE,13,"HDG",3)=MSG
NTE14 ;NTE~14 Report of Leishmaniasis heading
 S MSG="NTE~14-Report of Leishmaniasis"
 S ^XTMP("LREPIREP"_LRDATE,14,"HDG",1)=MSG
 S MSG="These data note persons at your facility during the month who had an ICD-9"
 S ^XTMP("LREPIREP"_LRDATE,14,"HDG",2)=MSG
 S MSG="coded diagnosis for Leishmania.  Identifying information has been provided."
 S ^XTMP("LREPIREP"_LRDATE,14,"HDG",3)=MSG
FOOT ;FOOTER FOR NTE 11,12,13,14
 S MSG="Initally, only inpatient cases will be captured; however, eventually it is"
 S ^XTMP("LREPIREP"_LRDATE,"FOOTNOTE",1)=MSG
 S MSG="anticiapted that this will include outpatient cases also."
 S ^XTMP("LREPIREP"_LRDATE,"FOOTNOTE",2)=MSG
NTE7 ;NTE~7 Report of Legionella/Legionaire's heading
 S MSG="NTE~7- Report of Legionella/Legionaire's"
 S ^XTMP("LREPIREP"_LRDATE,7,"HDG",1)=MSG
 S MSG="These data note persons at your facility during the month who had an EITHER an"
 S ^XTMP("LREPIREP"_LRDATE,7,"HDG",2)=MSG
 S MSG="ICD-9 coded diagnosis for Legionella/Legionaire's disease OR a positive"
 S ^XTMP("LREPIREP"_LRDATE,7,"HDG",3)=MSG
 S MSG="culture result.  Identifying information, along with specimen and culture"
 S ^XTMP("LREPIREP"_LRDATE,7,"HDG",4)=MSG
 S ^XTMP("LREPIREP"_LRDATE,7,"HDG",5)="results have been provided."
NTE9 ;NTE~9 Report of Cryptosporidium heading
 S MSG="NTE~9-Report of Cryptosporidium"
 S ^XTMP("LREPIREP"_LRDATE,9,"HDG",1)=MSG
 S MSG="These data note persons at your facility during the month who had EITHER an"
 S ^XTMP("LREPIREP"_LRDATE,9,"HDG",2)=MSG
 S MSG="ICD-9 coded diagnosis for Cryptosporidium OR a positive culture result."
 S ^XTMP("LREPIREP"_LRDATE,9,"HDG",3)=MSG
 S ^XTMP("LREPIREP"_LRDATE,9,"HDG",4)="Identifying information, along with specimen and culture results have been"
 S ^XTMP("LREPIREP"_LRDATE,9,"HDG",5)="provided."
 ;
NTE2 ;NTE 2 HEP C ANTIBODY POSITIVE HEADING
 S ^XTMP("LREPIREP"_LRDATE,2,"HDG",1)="NTE~2 Report of Hepatitis C antibody positive"
 S ^XTMP("LREPIREP"_LRDATE,2,"HDG",2)="This represents a line listing of persons reported during the month who had a"
 S ^XTMP("LREPIREP"_LRDATE,2,"HDG",3)="positive test for hepatitis C antibody (based on accession date and not"
 S ^XTMP("LREPIREP"_LRDATE,2,"HDG",4)="results reported date).  Definitions for data to be extracted are provided"
 S ^XTMP("LREPIREP"_LRDATE,2,"HDG",5)="in Technical and User Guide documentation for Laboratory EPI LR*5.2*281."
NTE15 ;NTE 15 HEP C ANTIBODY NEGATIVE HEADING
 S ^XTMP("LREPIREP"_LRDATE,15,"HDG",1)="NTE~15 Report of Hepatitis C antibody negative"
 S ^XTMP("LREPIREP"_LRDATE,15,"HDG",2)="This represents a line listing of persons reported during the month who had a"
 S ^XTMP("LREPIREP"_LRDATE,15,"HDG",3)="negative test for hepatitis C antibody (based on accession date and not"
 S ^XTMP("LREPIREP"_LRDATE,15,"HDG",4)="results reported date).  Definitions for data to be extracted are provided"
 S ^XTMP("LREPIREP"_LRDATE,15,"HDG",5)="in Technical and User Guide documentation for Laboratory EPI LR*5.2*281."
NTE16 ;NTE~16 HEP A ANTIBODY POSITIVE HEADINGS
 S ^XTMP("LREPIREP"_LRDATE,16,"HDG",1)="NTE~16 Report of Hepatitis A antibody positive"
 S ^XTMP("LREPIREP"_LRDATE,16,"HDG",2)="This represents a line listing of persons reported during the month who had a"
 S ^XTMP("LREPIREP"_LRDATE,16,"HDG",3)="positive test for hepatitis A antibody (based on accession date and not"
 S ^XTMP("LREPIREP"_LRDATE,16,"HDG",4)="results reported date).  Definitions for data to be extracted are provided"
 S ^XTMP("LREPIREP"_LRDATE,16,"HDG",5)="in Technical and User Guide documentation for Laboratory EPI LR*5.2*281."
NTE17 ;NTE~17 HEP B POSITIVE HEADING
 S ^XTMP("LREPIREP"_LRDATE,17,"HDG",1)="NTE~17 Report of Hepatitis B positive"
 S ^XTMP("LREPIREP"_LRDATE,17,"HDG",2)="This represents a line listing of persons reported during the month who had a"
 S ^XTMP("LREPIREP"_LRDATE,17,"HDG",3)="positive test for hepatitis B (based on accession date and not results"
 S ^XTMP("LREPIREP"_LRDATE,17,"HDG",4)="reported date).  Definitions for data to be extracted are provided in"
 S ^XTMP("LREPIREP"_LRDATE,17,"HDG",5)="Technical and User Guide documentation for Laboratory EPI LR*5.2*281."
UPD ;UPDATES HEADING
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",1)="UPDATES"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",2)="This section presents patients who had a transmission of information during a"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",3)="month on an EPI defined topic that was incomplete.  These patients have"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",4)="information that has been transmitted during the current processing month in"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",5)="order to complete the EPI files.  This information usually contains inpatient"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",6)="information about discharge date, ICD-9 coded diagnoses and occasionally will"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",7)="contain laboratory based testing.  This line listing of patient, SSN, and"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",8)="admission date and discharge date is provided to assist with analysis should"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",9)="an processing/error report occur with your monthly automated transmission of"
 S ^XTMP("LREPIREP"_LRDATE,"UPDHDG",10)="this data."
PHARM ;PHARMACY DATA HEADINGS
 S ^XTMP("LREPIREP"_LRDATE,"PHHDG",1)="Pharmacy-based data extracted for EPI data base."
HEPC ;HEP C RISK ASSESSMENT HEADING
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",1)="Detailed Listing of Hepatitis C Risk Assessment"
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",2)="These Health factors/Resolved terms for hepatitis C risk assessment are the"
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",3)="national Health factors used for roll-up of risk assessment data.  They may not"
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",4)="reflect the terms actually utilized (seen) in the Clinical Reminder package at"
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",5)="this facility.  To determine which local/facility Clinical Reminder health"
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",6)="factor(s) correspond(s) to the national term, please contact your facility"
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",7)="Clinical Reminder application coordinator.  Note that hepatitis C infection"
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",8)="is based on a previously ICD-9 coded diagnosis of hepatitis C at your site/"
 S ^XTMP("LREPIREP"_LRDATE,"HEPCHDG",9)="facility."
 Q
