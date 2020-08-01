SYNDHP91 ;DHP/fjf - HealthConcourse - Write care plans to VistA ;11/07/2018
 ;;0.1;VISTA SYNTHETIC DATA LOADER;;Aug 17, 2018;Build 10
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;*//Input:
 ; a. Classification
 ; b. Activities SNOMED CT
 ; c. Goals - text and ptr to PL
 ; Status - fhir CODE
 ; Date
 ;
 ;
 ; 1.   Use data2pce to ingest careplans, activities & goals
 ; a.   Encounter
 ; b.   CarePlan points to encounter and the goals
 ; i.   V standard codes (SNOMED CT) - classification 
 ; c.   Goals - has text goal - points to condition/problems (reason for goal)
 ; i.   Use Healthfactors 
 ; ii.  Create goals HF category - config - add to configuration utility this will be for problem
 ; iii. For each goal create a health factor if doesn't already exist (laygo) (text from c above)
 ; iv.  Code which references the problem list
 ; v.   Entire text of goal goes in comment and say that goal addresses this problem  -> add SCT + desc code in there too
 ;
 ; d.
 ;
 ; Signature:
 ;Visit IEN
 ;Goals (array) text & code <- problem list code (SNOMED CT & or ICD)
 ;Activities (array) SNOMED code^status
 ;Classification SNOMED CT code
 ;CarePlan Status from FHIR set
 ;
 ;
 ;Generate TIU note for careplan and associate with encounter.
 ;//*
 ;
 ; HF for cat for careplan
 ; HF for careplan (use healthfactor manager
 ; HF for activity 
 ; pass to DATA2PCE
 ; 
 ;
 ; -------- Create Care Plan for Patient
 ;
CPLUPDT(RETSTA,DHPPAT,DHPVST,DHPCAT,DHPACT,DHPGOL,DHPSCT,DHPSDT,DHPEDT) ;  update
 ;
 ; Input:
 ;   DHPPAT   - Patient ICN
 ;   DHPVST   - Visit ID
 ;   DHPCAT   - Category ID (SCT code. text, and FHIR status - active, completed, etc)
 ;   DHPACT   - List of Activities (SCT code, text, and FHIR status - in-progress, etc)
 ;   DHPGOL   - List of Goals
 ;   DHPSCT   - Reason for CarePlan (SCT code) - Care Plan Addresses
 ;   DHPSDT   - CarePlan Period start
 ;   DHPEDT   - CarePlan period end
 ;
 ;
 ; Output:   RETSTA
 ;  1 - success
 ; -1 - failure -1^message
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised" Q
 ;
 ;I $G(DHPSCT)="" S RETSTA="-1^SNOMED CT code is required" Q
 I $G(DHPVST)="" S RETSTA="-1^Visit IEN is required" Q
 I '$D(^AUPNVSIT(DHPVST)) S RETSTA="-1^Visit not found" Q
 ;
 ;
 ;
 S U="^",T="~"
 ;
 S DHPGOL=$G(DHPGOL)
 S DHPSCT=$G(DHPSCT)
 S DHPSDT=$P($$HL7TFM^XLFDT(DHPSDT),".",1)
 S DHPEDT=$P($$HL7TFM^XLFDT(DHPEDT),".",1)
 ;
 S VISIT=DHPVST
 S PATIEN=$O(^DPT("AFICN",DHPPAT,""),-1)
 S PACKAGE=$$FIND1^DIC(9.4,,"","?")
 S SOURCE="DHP DATA INGEST"
 S USER=$$DUZ^SYNDHP69
 S ERRDISP=""
 I $G(DEBUG)=1 S ERRDISP=1
 S CATCD=$P(DHPCAT,T)
 S CATTX=$P(DHPCAT,T,2)
 S CATST=$P(DHPCAT,T,3)
 ;S CONC=$$CODE^LEXTRAN(DHPSCT,"SCT",,,,,1)
 S ADDCD=$P(DHPSCT,U)
 S ADDTX=$P(DHPSCT,U,2)
 S ADDST=$P(DHPSCT,U,3)
 ;
 ; Call HF manager and retrieve HF for careplan category data or
 ;   add category HF and return data if it doesn't already exist 
 S CATDAT=$$HFCPCAT^SYNFHF(CATCD,CATTX)
 ;
 ; Call HF manager and retrieve HF for careplan
 ;   add careplan HF if it doesn't already exist
 S HFCAP=$$HFCP^SYNFHF(CATCD,CATTX,CATDAT)
 ;
 ; Call HF manager and retrieve HF for careplan addresses data or
 ;   add addresses HF and return data if it doesn't already exist 
 S ADDDAT=$$HFADDR^SYNFHF(ADDCD,ADDTX,CATDAT)
 ;
 ; create encounter array
 ;
 K ENCDATA
 ; 
 ;
 ; Careplan health factor
 ;
 S ENCDATA("HEALTH FACTOR",1,"HEALTH FACTOR")=+HFCAP
 S ENCDATA("HEALTH FACTOR",1,"EVENT D/T")=DHPSDT
 S ENCDATA("HEALTH FACTOR",1,"COMMENT")="Start: "_DHPSDT_" End: "_DHPEDT_" Status: "_CATST
 ;
 ; what health factor addresses
 ;
 S ENCDATA("HEALTH FACTOR",2,"HEALTH FACTOR")=+ADDDAT
 S ENCDATA("HEALTH FACTOR",2,"EVENT D/T")=DHPSDT
 S ENCDATA("HEALTH FACTOR",2,"COMMENT")="Start: "_DHPSDT_" End: "_DHPEDT ; _" Status: "_ADDST
 ;
 ; careplan activities
 ;
 I +CATDAT'=0 D
 .F I=1:1:$L(DHPACT,U) D
 ..S ACTS=$P(DHPACT,U,I)
 ..S ACTSCT=$P(ACTS,T)
 ..S ACTTXT=$P(ACTS,T,2)
 ..S ACTSTA=$P(ACTS,T,3)
 ..S HFACT=$$HFACT^SYNFHF(ACTSCT,ACTTXT,+CATDAT)
 ..S ENCDATA("HEALTH FACTOR",I+2,"HEALTH FACTOR")=+HFACT
 ..S ENCDATA("HEALTH FACTOR",I+2,"EVENT D/T")=DHPSDT
 ..S ENCDATA("HEALTH FACTOR",I+2,"COMMENT")="Start: "_DHPSDT_" End: "_DHPEDT_" Status: "_ACTSTA
 ; 
GOLS ; careplan goals
 ;
 F J=1:1:$L(DHPGOL,U) D
 .S GOLS=$P(DHPGOL,U,J)
 .S GOLSCT=$P(GOLS,T)
 .S GOLTXT=$P(GOLS,T,2)
 .S GOLSTA=$P(GOLS,T,3)
 .S HFACT=$$HFGOAL^SYNFHF(GOLSCT,+CATDAT,GOLTXT)
 .S ENCDATA("HEALTH FACTOR",J+I+2,"HEALTH FACTOR")=+HFACT
 .S ENCDATA("HEALTH FACTOR",J+I+2,"EVENT D/T")=DHPSDT
 .S ENCDATA("HEALTH FACTOR",J+I+2,"COMMENT")="Start: "_DHPSDT_" End: "_DHPEDT_" Status: "_GOLSTA
 ;
 ;
 S RETSTA=$$DATA2PCE^PXAI("ENCDATA",PACKAGE,SOURCE,.VISIT,USER,$G(ERRDISP),.ZZERR,$G(PPEDIT),.ZZERDESC,.ACCOUNT)
 D EVARS
 M RETSTA=ENCDATA
 Q
 ;
 ;
T1 ;
 ;
 D VARS
 D CPLUPDT(.ZXC,DHPPAT,DHPVST,DHPCAT,DHPACT,DHPGOL,DHPSCT,DHPSDT,DHPEDT)
 Q
 ; 
 ;s q=""""
 ;
 ;w q
 ;
 ;F I=1:1:7 s @$p(a(I),q,8)=$p(a(I),"=",2)
 ;
 ;a(1)="^XTMP("SYNGRAPH",1,1227,"load","careplan",12,"parms","DHPACT")=409002~Food allergy diet~in-progress^58332002~Allergy education~in-progress"
 ;a(2)="^XTMP("SYNGRAPH",1,1227,"load","careplan",12,"parms","DHPCAT")=326051000000105~Self care~active"
 ;a(3)="^XTMP("SYNGRAPH",1,1227,"load","careplan",12,"parms","DHPEDT")="
 ;a(4)="^XTMP("SYNGRAPH",1,1227,"load","careplan",12,"parms","DHPPAT")=1435855215V947437"
 ;a(5)="^XTMP("SYNGRAPH",1,1227,"load","careplan",12,"parms","DHPSCT")="
 ;a(6)="^XTMP("SYNGRAPH",1,1227,"load","careplan",12,"parms","DHPSDT")=2760829"
 ;a(7)="^XTMP("SYNGRAPH",1,1227,"load","careplan",12,"parms","DHPVST")=34818"
 ;
VARS ;
 S DHPACT="409002~Food allergy diet~in-progress^58332002~Allergy education~in-progress"
 S DHPCAT="326051000000105~Self care~active"
 S DHPEDT=""
 S DHPPAT="1345112108V472042"
 S DHPSCT="230690007^Cerebrovascular accident^passive"
 S DHPSDT="19760829"
 S DHPVST="34885"
 S DHPGOL="15777000~Address patient knowledge deficit on diabetic self-care~in-progress^15777000"
 S DHPGOL=DHPGOL_"~Improve and maintenance of optimal foot health: aim at early detection of peripheral"
 S DHPGOL=DHPGOL_" vascular problems and neuropathy presumed due to diabetes; and prevention of diabetic"
 S DHPGOL=DHPGOL_" foot ulcer, gangrene~in-progress^15777000~Maintain blood pressure below 140/90 mmHg"
 S DHPGOL=DHPGOL_"~in-progress^15777000~Glucose [Mass/volume] in Blood < 108~in-progress^15777000"
 S DHPGOL=DHPGOL_"~Hemoglobin A1c total in Blood < 7.0~in-progress"
 Q
 ; 
EVARS ;
 S ENCDATA("IVARS","DHPACT")=DHPACT
 S ENCDATA("IVARS","DHPCAT")=DHPCAT
 S ENCDATA("IVARS","DHPEDT")=DHPEDT
 S ENCDATA("IVARS","DHPPAT")=DHPPAT
 S ENCDATA("IVARS","DHPSCT")=DHPSCT
 S ENCDATA("IVARS","DHPSDT")=DHPSDT
 S ENCDATA("IVARS","DHPVST")=DHPVST
 S ENCDATA("IVARS","DHPGOL")=DHPGOL
 Q
