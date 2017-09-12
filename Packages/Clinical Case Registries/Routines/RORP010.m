RORP010 ;BP/ACS CCR POST-INIT PATCH 10 ;08/31/09
 ;;1.5;CLINICAL CASE REGISTRIES;**10**;Feb 17, 2006;Build 32
 ;
 ; This routine uses the following IAs:
 ;
 ; #2263    EN^XPAR,ADD^XPAR,DEL^XPAR (supported)
 ; #2053    UPDATE^DIE (supported)
 ; #2053    FILE^DIE (supported)
 ; #2056    GETS^DIQ (supported)
 ; #2054    CLEAN^DILF (supported)
 ; #10013   ^DIK (supported)
 ;
 N DA,DIK
 ;******************************************************************************
 ;Change DON'T SEND field in ROR REGISTRY RECORD file to null if not a
 ;test patient in file 2
 ;******************************************************************************
 N RORI,RORDFN
 S RORI=0 F  S RORI=$O(^RORDATA(798,RORI)) Q:(RORI'>0)  D
 . I $P($G(^RORDATA(798,RORI,2)),U,4) D
 .. S RORDFN=+$G(^RORDATA(798,RORI,0)) I $G(RORDFN) D
 ... ;change DON'T SEND to null if not a test patient
 ... I '$$TESTPAT^RORUTL01(RORDFN) S $P(^RORDATA(798,RORI,2),U,4)=""
 ;
 ;******************************************************************************
 ;Add 3 new entries to the ROR REPORT PARAMETERS file (#799.34) for the new reports
 ;New Reports: BMI, MELD, Renal Function by Range
 ;******************************************************************************
 N RORRPT,RORFDA,RORIEN,RORERR,RORARY1,RORARY2
 ;*** BMI report ***
 S RORRPT="BMI by Range" D
 . ;delete first
 . S DIK="^ROR(799.34,",DA=18 D ^DIK
 . K RORFDA
 . S RORIEN(1)=18 ;BMI is report #18
 . S RORFDA(799.34,"+1,",.01)=RORRPT ;name
 . S RORFDA(799.34,"+1,",.02)=1 ;background processing? = yes
 . S RORFDA(799.34,"+1,",.03)=1 ;shared templates = yes
 . S RORFDA(799.34,"+1,",.04)="18" ;code
 . S RORFDA(799.34,"+1,",.09)=1 ;national = yes
 . S RORFDA(799.34,"+1,",1)="14,22,62,201,47,12,180,70,100" ;parameter panels
 . S RORFDA(799.34,"+1,",10.01)="$$BMIRANGE^RORX018" ;report builder
 . K RORARY1
 . S RORARY1(1)="<DATE_RANGE_3 TYPE=""YEAR""/>" ;default parameters
 . S RORARY1(2)="<PATIENTS DE_BEFORE=""1"" DE_DURING=""1"" DE_AFTER=""1""/>" ;default parameters
 . S RORARY1(3)="<OPTIONS MOST_RECENT=""1"" COMPLETE=""1""/>" ;default parameters
 . S RORFDA(799.34,"+1,",11)="RORARY1"
 . K RORARY2
 . S RORARY2(1)="<SM TABLE=""PATIENTS"" FIELD=""NAME""/>" ;default sorting
 . S RORFDA(799.34,"+1,",12)="RORARY2"
 . D UPDATE^DIE(,"RORFDA","RORIEN","RORERR")
 ;***MELD report ***
 S RORRPT="MELD Score by Range" D
 . ;delete first
 . S DIK="^ROR(799.34,",DA=19 D ^DIK
 . K RORFDA
 . S RORIEN(1)=19 ;MELD is report #19
 . S RORFDA(799.34,"+1,",.01)=RORRPT ;name
 . S RORFDA(799.34,"+1,",.02)=1 ;background processing? = yes
 . S RORFDA(799.34,"+1,",.03)=1 ;shared templates = yes
 . S RORFDA(799.34,"+1,",.04)="19" ;code
 . S RORFDA(799.34,"+1,",.09)=1 ;national = yes
 . S RORFDA(799.34,"+1,",1)="14,22,201,47,12,180,70,100" ;parameter panels
 . S RORFDA(799.34,"+1,",10.01)="$$MLDRANGE^RORX019" ;report builder
 . K RORARY1
 . S RORARY1(1)="<DATE_RANGE_3 TYPE=""YEAR""/>" ;default parameters
 . S RORARY1(2)="<PATIENTS DE_BEFORE=""1"" DE_DURING=""1"" DE_AFTER=""1""/>" ;default parameters
 . S RORARY1(3)="<OPTIONS MOST_RECENT=""1"" COMPLETE=""1""/>" ;default parameters
 . S RORFDA(799.34,"+1,",11)="RORARY1"
 . K RORARY2
 . S RORARY2(1)="<SM TABLE=""PATIENTS"" FIELD=""NAME""/>" ;default sorting
 . S RORFDA(799.34,"+1,",12)="RORARY2"
 . D UPDATE^DIE(,"RORFDA","RORIEN","RORERR")
 ;*** Renal report ***
 S RORRPT="Renal Function by Range" D
 . ;delete first 
 . S DIK="^ROR(799.34,",DA=20 D ^DIK
 . K RORFDA
 . S RORIEN(1)=20 ;Renal is report #20
 . S RORFDA(799.34,"+1,",.01)=RORRPT ;name
 . S RORFDA(799.34,"+1,",.02)=1 ;background processing? = yes
 . S RORFDA(799.34,"+1,",.03)=1 ;shared templates = yes
 . S RORFDA(799.34,"+1,",.04)="20" ;code
 . S RORFDA(799.34,"+1,",.09)=1 ;national = yes
 . S RORFDA(799.34,"+1,",1)="14,22,62,201,47,12,180,70,100" ;parameter panels
 . S RORFDA(799.34,"+1,",10.01)="$$RFRANGE^RORX020" ;report builder
 . K RORARY1
 . S RORARY1(1)="<DATE_RANGE_3 TYPE=""YEAR""/>" ;default parameters
 . S RORARY1(2)="<PATIENTS DE_BEFORE=""1"" DE_DURING=""1"" DE_AFTER=""1""/>" ;default parameters
 . S RORARY1(3)="<OPTIONS MOST_RECENT=""1"" COMPLETE=""1""/>" ;default parameters
 . S RORFDA(799.34,"+1,",11)="RORARY1"
 . K RORARY2
 . S RORARY2(1)="<SM TABLE=""PATIENTS"" FIELD=""NAME""/>" ;default sorting
 . S RORFDA(799.34,"+1,",12)="RORARY2"
 . D UPDATE^DIE(,"RORFDA","RORIEN","RORERR")
 K RORFDA,RORIEN,RORERR
 ;
 ;******************************************************************************
 ;Add new entries to the ROR LIST ITEM file (#799.1) for the 3 new reports
 ;New TYPEs are 5=BMI, 6=MELD, and 7=Renal
 ;******************************************************************************
 N RORDATA,RORTAG,RORFDA,I,TEXT,TYPE,REGISTRY,CODE
 F I=1:1:10  S RORTAG="LI"_I D
 . S RORDATA=$P($T(@RORTAG),";;",2)
 . S TEXT=$P(RORDATA,"^",1) ;TEXT to add
 . S TYPE=$P(RORDATA,"^",2) ;TYPE to add
 . S REGISTRY=$P(RORDATA,"^",3) ;REGISTRY to add
 . S CODE=$P(RORDATA,"^",4) ;CODE to add
 . ;don't add if it's already in the global
 . Q:$D(^ROR(799.1,"KEY",TYPE,REGISTRY,CODE))
 . S RORFDA(799.1,"+1,",.01)=TEXT
 . S RORFDA(799.1,"+1,",.02)=TYPE
 . S RORFDA(799.1,"+1,",.03)=REGISTRY
 . S RORFDA(799.1,"+1,",.04)=CODE
 . D UPDATE^DIE(,"RORFDA",,"RORERR")
 K RORFDA,RORERR
 ;
 ;******************************************************************************
 ;Add new ICD9 entry/group "HCC" to the PARAMETERS file #8989.5
 ;ADD^XPAR(entity,parameter[,instance],value[,.error])
 ;DBIA 2263
 ;*****************************************************************************
 N RORPARAMETER,RORENTITY,RORINSTANCE,RORVALUE,RORERR
 S RORENTITY="PKG.CLINICAL CASE REGISTRIES"
 S RORPARAMETER="ROR REPORT PARAMS TEMPLATE"
 S RORINSTANCE="13::HCC"
 ;delete it first (in case it already exists)
 D DEL^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORERR)
 S RORVALUE="CCR Predefined Report Template"
 S RORVALUE(1,0)="<?xml version="_"""1.0"""_" encoding="_"""UTF-8"""_"?>"
 S RORVALUE(2,0)="<PARAMS>"
 S RORVALUE(3,0)="<ICD9LST>"
 S RORVALUE(4,0)="<GROUP ID="_"""HCC"""_">"
 S RORVALUE(5,0)="<ICD9 ID="_"""155.0"""_">MAL NEO LIVER, PRIMARY</ICD9>"
 S RORVALUE(6,0)="</GROUP>"
 S RORVALUE(7,0)="</ICD9LST>"
 S RORVALUE(8,0)="<PANELS>"
 S RORVALUE(9,0)="<PANEL ID="_"""160"""_"/>"
 S RORVALUE(10,0)="</PANELS>"
 S RORVALUE(11,0)="</PARAMS>"
 ;add it
 D ADD^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORVALUE,.RORERR)
 ;
 ;******************************************************************************
 ;Add new ICD9 entry/group "Esophageal Varices" to the PARAMETERS file #8989.5
 ;ADD^XPAR(entity,parameter[,instance],value[,.error])
 ;DBIA 2263
 ;******************************************************************************
 N RORVALUE,RORERR,RORENTITY,RORPARAMETER,RORINSTANCE
 S RORENTITY="PKG.CLINICAL CASE REGISTRIES"
 S RORPARAMETER="ROR REPORT PARAMS TEMPLATE"
 S RORINSTANCE="13::Esophageal Varices"
 ;delete it first (in case it already exists)
 D DEL^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORERR)
 S RORVALUE="CCR Predefined Report Template"
 S RORVALUE(1,0)="<?xml version="_"""1.0"""_" encoding="_"""UTF-8"""_"?>"
 S RORVALUE(2,0)="<PARAMS>"
 S RORVALUE(3,0)="<ICD9LST>"
 S RORVALUE(4,0)="<GROUP ID="_"""Esophageal Varices"""_">"
 S RORVALUE(5,0)="<ICD9 ID="_"""456.0"""_">ESOPHAG VARICES W BLEED</ICD9>"
 S RORVALUE(6,0)="<ICD9 ID="_"""456.1"""_">ESOPH VARICES W/O BLEED</ICD9>"
 S RORVALUE(7,0)="<ICD9 ID="_"""456.20"""_">BLEED ESOPH VAR OTH DIS</ICD9>"
 S RORVALUE(8,0)="<ICD9 ID="_"""456.21"""_">ESOPH VARICE OTH DIS NOS</ICD9>"
 S RORVALUE(9,0)="</GROUP>"
 S RORVALUE(10,0)="</ICD9LST>"
 S RORVALUE(11,0)="<PANELS>"
 S RORVALUE(12,0)="<PANEL ID="_"""160"""_"/>"
 S RORVALUE(13,0)="</PANELS>"
 S RORVALUE(14,0)="</PARAMS>"
 ;add it
 D ADD^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORVALUE,.RORERR)
 ;
 ;******************************************************************************
 ;Add new entries to the ROR DATA AREA file (#799.33) for the 2 new data areas
 ;New Data Areas: V Immunization, V Skin Test
 ;******************************************************************************
 ;remove old entries if they exist
 S DIK="^ROR(799.33,",DA=$O(^ROR(799.33,"B","Immunization",0)) I $G(DA)>0 D ^DIK
 S DIK="^ROR(799.33,",DA=$O(^ROR(799.33,"B","Skin Test",0)) I $G(DA)>0 D ^DIK
 N RORDA F RORDA="V Immunization","V Skin Test" D
 . Q:$D(^ROR(799.33,"B",RORDA))  ;don't add if it's already in the global
 . N RORFDA,RORERR,RORIEN
 . S RORFDA(799.33,"+1,",.01)=RORDA
 . S RORIEN(1)=$S(RORDA="V Immunization":17,1:18)
 . D UPDATE^DIE(,"RORFDA","RORIEN","RORERR")
 . K RORFDA,RORERR,RORIEN
 ;
 ;******************************************************************************
 ;Add new entries to the ROR XML ITEM file (#799.31)
 ;******************************************************************************
 N RORXML,RORTAG,RORFDA,RORERR
 ;--- add codes
 F I=1:1:20  S RORTAG="XML"_I D 
 . S RORXML=$P($T(@RORTAG),";;",2)
 . ;don't add if it's already in the global
 . Q:$D(^ROR(799.31,"B",RORXML))
 . S RORFDA(799.31,"+1,",.01)=RORXML
 . D UPDATE^DIE(,"RORFDA",,"RORERR")
 K RORFDA,RORERR
 ;
 ;******************************************************************************
 ;Add reports 18-20 to the list of available reports in ROR REGISTRY PARAMETERS
 ;file.  Field #27: AVAILABLE REPORTS
 ;******************************************************************************
 N REGNAME,REGIEN,RORERR,RORDATA,OLDLIST,NEWLIST S (REGNAME,REGIEN)=0
 F  S REGNAME=$O(^ROR(798.1,"B",REGNAME)) Q:$G(REGNAME)=""  D
 . S REGIEN=$O(^ROR(798.1,"B",REGNAME,0))
 . Q:$G(REGIEN)=""
 . K RORDATA,RORERR D GETS^DIQ(798.1,REGIEN_",",27,"I","RORDATA","RORERR")
 . Q:$D(RORERR("DIERR"))
 . S OLDLIST=$G(RORDATA(798.1,REGIEN_",",27,"I"))
 . Q:$G(OLDLIST)=""
 . I OLDLIST[",18,19,20" Q
 . ;update AVAILABLE REPORTS with the 3 additional reports
 . S NEWLIST=OLDLIST_",18,19,20"
 . N FLAG,FDA,IENS,FIELD S IENS=REGIEN_",",FIELD=27,FLAG="E"
 . S FDA(798.1,IENS,FIELD)=NEWLIST
 . K RORERR D FILE^DIE(FLAG,"FDA","RORERR")
 D CLEAN^DILF
 ;
 ;******************************************************************************
 ;Add new LOINC codes to the VA HEPC and VA HIV lab search criterion in the
 ;ROR LAB SEARCH file #798.9.  Don't add them if they already exist.  Do not
 ;add the 'dash' or the number following it
 ;******************************************************************************
 N I,HEPCIEN,HIVIEN,RORDATA,RORLOINC,RORTAG K RORMSG1,RORMSG2
 N HEPCNT,HIVCNT S HEPCNT=0,HIVCNT=0
 S HIVIEN=$O(^ROR(798.9,"B","VA HIV",0)) ;HIV top level IEN
 S HEPCIEN=$O(^ROR(798.9,"B","VA HEPC",0)) ;HEPC top level IEN
 ;--- add LOINC codes to the VA HIV search criteria
 F I=1:1:14  S RORTAG="HIV"_I D 
 . S RORLOINC=$P($P($T(@RORTAG),";;",2),"-",1)
 . ;don't add if it's already in the global
 . Q:($D(^ROR(798.9,HIVIEN,1,"B",RORLOINC)))
 . S RORDATA(1,798.92,"+2,"_HIVIEN_",",.01)=$G(RORLOINC)
 . S RORDATA(1,798.92,"+2,"_HIVIEN_",",1)=6
 . D UPDATE^DIE("","RORDATA(1)",,"RORMSG1")
 . S HIVCNT=HIVCNT+1
 K RORDATA(1)
 ;--- add LOINC codes to the VA HEPC search criteria
 F I=1:1:5  S RORTAG="HEP"_I D
 . S RORLOINC=$P($P($T(@RORTAG),";;",2),"-",1)
 . ;don't add if it's already in the global
 . Q:($D(^ROR(798.9,HEPCIEN,1,"B",RORLOINC)))
 . S RORDATA(1,798.92,"+2,"_HEPCIEN_",",.01)=$G(RORLOINC)
 . S RORDATA(1,798.92,"+2,"_HEPCIEN_",",1)=6
 . D UPDATE^DIE("","RORDATA(1)",,"RORMSG2")
 . S HEPCNT=HEPCNT+1
 K RORDATA,RORMSG1,RORMSG2
 ;
 Q
 ;
 ;******************************************************************************
 ;New LOINC codes
 ;******************************************************************************
 ;HIV LOINC codes
HIV1 ;;34591-8
HIV2 ;;34592-6
HIV3 ;;43009-0
HIV4 ;;43010-8
HIV5 ;;43185-8
HIV6 ;;43599-0
HIV7 ;;44533-8
HIV8 ;;44607-0
HIV9 ;;44873-8
HIV10 ;;49580-4
HIV11 ;;49905-3
HIV12 ;;5221-7
HIV13 ;;53379-4
HIV14 ;;54086-4
 ;HEPC LOINC codes 
HEP1 ;;47365-2
HEP2 ;;47441-1
HEP3 ;;48576-3
HEP4 ;;51655-9
HEP5 ;;51657-5
 ;
 ;******************************************************************************
 ; Data to be added to ROR LIST ITEM file (#799.1)
 ; TEXT^TYPE^REGIEN^CODE
 ;******************************************************************************
LI1 ;;BMI^5^1^1
LI2 ;;BMI^5^2^1
LI3 ;;MELD^6^1^1
LI4 ;;MELD-Na^6^1^2
LI5 ;;MELD^6^2^1
LI6 ;;MELD-Na^6^2^2
LI7 ;;Creatinine clearance by Cockcroft-Gault^7^1^1
LI8 ;;eGFR by MDRD^7^1^2
LI9 ;;Creatinine clearance by Cockcroft-Gault^7^2^1
LI10 ;;eGFR by MDRD^7^2^2
 ;
 ;******************************************************************************
 ;new XML tags to be added to ROR XML ITEM file (#799.31)
 ;******************************************************************************
XML1 ;;PENDCOMM
XML2 ;;ICD9FILT
XML3 ;;FILTER
XML4 ;;DESC
XML5 ;;VALUES
XML6 ;;BMI
XML7 ;;HEIGHT
XML8 ;;WEIGHT
XML9 ;;DATA
XML10 ;;MOST_RECENT
XML11 ;;MAX_DATE
XML12 ;;BMIDATA
XML13 ;;MELDDATA
XML14 ;;MELD
XML15 ;;MELDNA
XML16 ;;TNAME
XML17 ;;RNLDATA
XML18 ;;CRCL
XML19 ;;EGFR
XML20 ;;TEST
