LREPIRP9 ;DALOI/CKA-EMERGING PATHOGENS VERIFICATION REPORT ;9/30/03
 ;;5.2;LAB SERVICE;**281**;Sep 27, 1994
 ; This routine contains documentation of the ^XTMP global created
 ;for the verification report.
 Q
REPORT ;
 ;^XTMP("LREPIREP"_DATE,0)="CREATION DATE^PURGE DATE(creation date+260)^description^creator"
 ;HEADINGS
 ;^XTMP("LREPIREP"_DATE,LRPATH,"HDG",#)
 ;Pathogen OF 1,3,4,5,6,8,10,18,19,20,21,22,23
 ;NTE~1 Vancomycin-resistan Enterococcus
 ;NTE~3 Penicillin-resistant Steptococcus pneumoniae
 ;NTE~4 Report of Clostidium difficile
 ;NTE~5 Report of Tuberculosis
 ;NTE~6 Report of Group A Streptococcus
 ;NTE~8 Report of Candida Bloodstream Infections
 ;NTE~10 Report of Escherichia coli 0157
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PID")
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",#)
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",LRPV1,"OBR",#)
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",LRPV1,"OBR",LROBR,"OBX",#)
 ;NTES OF 11,12,13,14
 ;NTE~11 Report of Malaria
 ;NTE~12 Report of Dengue
 ;NTE~13 Report of Creutzfeldt-Jakob Disease
 ;NTE~14 Report of Leishmaniasis
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PID")
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",#)
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",LRPV1,"DG1",#)
 ;NTES OF 7 AND 9
 ;NTE~7 Report of Legionella/Legionaire's
 ;NTE~9 Report of Cryptosporidium
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PID")
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",#)
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",LRPV1,"DG1",#)
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",LRPV1,"OBR",#)
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,"PV1",LRPV1,"OBR",LROBR,"OBX",#)
 ;NTES OF 2,15,16,17
 ;NTE~2 Report of Hepatitis C antibody positive
 ;NTE~15 Report of Hepatitis C antibody negative
 ;NTE~16 Report of Hepatitis A antibody positive
 ;NTE~17 Report of Hepatitis B positive
 ;^XTMP("LREPIREP"_DATE,LRPATH,DFN,#)
 ;="Name  SSN  Date of Test  Name of Test  Result of Test"
 ;UPDATES
 ;^XTMP("LREPIREP"_DATE,"UPDATES",#)
 ;  ="Name  SSN  EPI/Pathogen  Admission Date   Discharge Date"
 ;
 ;PHARMACY DATA
 ;^XTMP("LREPIREP"_DATE,"ZXE",DRUG NAME,#)
 ;  ="SSN  Name  Status(Inpatient/Outpatient) Date"
 ;RISK ASSESSMENT DATA
 ;^XTMP("LREPIREP"_DATE,"DSP",RISK ASSESSMENT NAME,#)
 ;  ="SSN  NAME  Status  Date"
 Q
