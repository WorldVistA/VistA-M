PXBGPRV ;ISL/JVS,ESW - GATHER PROVIDERS ; 12/5/02 11:35am
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**7,11,108,186**;Aug 12, 1996;Build 3
 ;
PRV(VISIT,PXBSKY,PXBKY,PXBSAM,PXBCNT,PRVDR,FPRI) ;--Gather the entries in the V PROVIDER file
 ;
 ;Output:
 ;       PXBSKY(PXBC,IEN)=PRVI
 ;       PXBKY(NAME,PXBC)=NAME^P^TYPE^PRVI
 ;       PXBSAM(PXBC)=NAME^P^TYPE^PRVI
 ;       PRVDR("PRIMARY")=NAME^IEN^PRVI
 ;       PXBCNT
 ;       FPRI
 ;where:
 ;       PXBC - sequence in an order of providers name
 ;       IEN  - of ^AUPNVPRV(
 ;       NAME - provider's name (LAST,FIRST...)
 ;       P    - PRIMARY or SECONDARY
 ;       PRVI - IEN of ^VA(200,
 ;       PXBCNT - provider count
 ;       FPRI:
 ;             0 - Primary not selected
 ;             1 - Primary selected
 ;
 N IEN,QUANTITY,PROVIDER,PRIMARY,PRV,GROUP,PXBC
 N DIC,DR,DA,DIQ,PRVI,TYPE
 ;
 K ^TMP("PXBU",$J),PRV,PXBKY,VAUGHN,PXBSAM,PXBSKY,PXBCNT,PXBPRV,FPRI
 K PRVDR
 S FPRI=""
 ; create an array of current providers without duplicates, with their
 ; ^(0) node as a value
 I $D(^AUPNVPRV("AD",VISIT)) D
 .D GETPRV^PXAPIOE(VISIT,"^TMP(""PXBU"",$J,""PRV"")")
 ;
A ;--Set array with PROVIDERS
 ;
 I $G(^TMP("PXBU",$J,"PRV")) D
 .S IEN=0 F  S IEN=$O(^TMP("PXBU",$J,"PRV",IEN)) Q:IEN'>0  D
 ..S PRIMARY=$S($P(^(IEN),U,4)="P":"PRIMARY",1:"SECONDARY")
 ..S PRVI=+^(IEN),TYPEI=$P(^(IEN),U,6)
 ..S DIC=200,DIC1=DIC,DR=.01,DA=PRVI,DIQ="PRVN" D EN^DIQ1 D
 ...S PRV=PRVN(DIC1,DA,DR)
 ..S FPRI=FPRI_$E(PRIMARY,1,3) ;-Creating Flag for Primary prompt
 ..S TYPE=$$OCCUP("","","",2,TYPEI) D
 ...N Y,DATE
 ...S Y=+$P($G(^AUPNVSIT(VISIT,0)),U) X ^DD("DD") S DATE=$P(Y,"@",1)
 ...I TYPEI="" S TYPE=$$GET^XUA4A72(PRVI,+$P($P($G(^AUPNVSIT(VISIT,0)),U),"."))
 ...I +TYPE=-2 S TYPE="*** CLASS not 'ACTIVE' on "_DATE_"***"
 ...I +TYPE=-1 S TYPE=""
 ...;I +TYPE>0 S TYPE="**** DELETE and RE-ENTER PROVIDER****"
 ...I +TYPE>0 S TYPE=""
 ..S GROUP=PRV_U_PRIMARY_U_TYPE_U_PRVI
 ..I PRIMARY["PRI" S PRVDR("PRIMARY")=PRV_U_IEN_U_PRVI
 ..S PRV(PRV,IEN)=GROUP
 K ^TMP("PXBU",$J,"PRV")
 ;
B ;--Add line numbers
 ;create local arrays with data from existing providers
 I $D(PRV) D
 .S PXBC=0,PRV="" F  S PRV=$O(PRV(PRV)) Q:PRV=""  D
 ..S IEN=0 F  S IEN=$O(PRV(PRV,IEN)) Q:IEN=""  S PXBC=PXBC+1 D
 ...S PXBKY(PRV,PXBC)=$G(PRV(PRV,IEN)),PXBSAM(PXBC)=$G(PRV(PRV,IEN))
 ...S PXBSKY(PXBC,IEN)=$P(PRV(PRV,IEN),U,4)
 ...K PRV(PRV,IEN)
FINISH ;--Finish up some variables
 S:FPRI'["PRI" FPRI=0 S:FPRI["PRI" FPRI=1
 ;FPRI=0 Then there is no Primary Selected yet
EXIT ;--set a providers count
 S PXBCNT=+$G(PXBC)
 Q
 ;
OCCUP(IEN,DATE,CODE,RETURN,CLASSIEN) ;--FORMAT PERSON CLASS TO DISPLAY
 ; IEN      = Provider pointer to file# 200
 ; DATE     = Date of occurrence of service
 ; CODE     = Person class Code (if already known)
 ;          **(Required step) If you use code leave IEN and DATE Blank
 ; RETURN   = (Required) Flag to decide what format you want the
 ;          return value.
 ; CLASSIEN = Ien of entry in the PERSON CLASS file#8932.1 If the Ien
 ;            was saved this parameter could be sent in instead of CODE.
 ; 
 ;   1    = IEN^OCCUPATION^SPECIALITY^SUBSPECIALITY^STATUS^DATE INACTIVATED^VA CODE
 ;   2    = Short Description
 ;   3    = Short Description^VA CODE
 ;        *** If only CODE and RETURN = 1 There is no value or other
 ;            value in the STATUS and DATE INACTIVATED fields.
 ;
 ; Output:
 ;        -1 "no comment" function call to person class couldn't find
 ;            a class for that person.
 ;        -1^COMMENT This function is called incorrectly
 ;        -2 "no comment" There is no ACTIVE person class for provider
 ;            based on the date provided.
 ;
 N OCC,SPE,SUB,ENTRY,DIS,OCCL,TYPE,VACODE,ANS
 ;--VALIDATE
 I (+$G(IEN)'>0)&($L(IEN)>0) Q -1_"^INVALID PERSON IEN"
 I '$G(IEN),'$G(DATE),$G(CODE)="",'$G(RETURN),'$G(CLASSIEN) Q -1_"^NO PARAMETERS"
 I '$G(IEN),'$G(DATE),$G(CODE)="",$G(RETURN),'$G(CLASSIEN) Q -1_"^NO PARAMETERS"
 I '$G(RETURN) Q -1_"^NO RETURN PARAMETER (Required)"
 I $G(RETURN)]"",(RETURN'<4!(RETURN'>0)) Q -1_"^RETURN MUST BE 1,2,or 3"
 I DATE]"",+DATE'>0 Q -1_"^INVALID FILEMAN DATE"
 I $G(IEN) Q:'$D(^VA(200,$G(IEN))) -1_"^NO SUCH IEN IN FILE# 200"
 I $G(IEN),$G(DATE) D  I $G(RETURN)=1 Q TYPE
 .S TYPE=$$GET^XUA4A72(IEN,$P(DATE,".")),VACODE=$P(TYPE,U,7)
 I $G(IEN),$G(DATE),+TYPE<0 Q TYPE
 ;
 ;---CONVERT IEN TO CODE
 I $G(CLASSIEN) S CODE=$$IEN2CODE^XUA4A72(CLASSIEN)
 ;
 I $G(CODE)]"",'$G(IEN),'$G(DATE) S TYPE=$O(^USC(8932.1,"F",$G(CODE),0)),VACODE=CODE I $G(RETURN)=1 S ANS=TYPE_U_$G(^USC(8932.1,TYPE,0)) Q ANS
 S ENTRY=$G(^USC(8932.1,+TYPE,0))
OCC ;---OCCUPATION
 S OCCL=$P(ENTRY,U)
 S OCC=$P($P(ENTRY,U)," ",1)
 I OCCL["Physicians (M.D" S OCC="Physician"
 I OCCL["Physician Assistant" S OCC=OCCL
 I OCCL["Speech, Language" S OCC="Language"
 I OCCL["Technologists" S OCC="Technical"
 I OCCL["Eye and Vision" S OCC="Ophthalmic"
 I OCCL["Respiratory, Rehab" S OCC="Therapist"
 I OCCL["Podiatric" S OCC="Podiatry"
 ;
SPE ;--SPECIALITY
 S SPEL=$P(ENTRY,U,2)
 S SPE=$P(ENTRY,U,2)
 I SPEL["Registered Nurse" S SPE="R.N."
 I SPEL["Dentist" S SPE="Dentist"
 I SPEL["Clinical Services" S SPE="Clinical"
 I SPEL["Non-R.N.s" S SPE="Non R.N."
 I SPEL["Radiologic Sciences" S SPE="Radiology"
 I SPEL["Clinical Path" S SPE=""
 I SPEL["Physical Therap" S SPE="P.T."
 I SPEL["Obstetrics and Gynecology" S SPE="Ob. & Gyn."
 I SPEL["iatry and Neur" S SPE="Psyc & Neuro"
 I SPEL["Clinical Specialist" S SPE="Clinical"
 I SPEL["Registered Dietitian" S SPE="R. Dietitian"
 I SPEL["Rehabilitation Prac" S SPE="Rehabilitation"
 I OCC["Physician"&(SPE["Internal Medicine") S SPE="Internist"
 ;
SUB ;--SUBSPECIALITY
 S SUBL=$P(ENTRY,U,3)
 S SUB=$P(ENTRY,U,3)
 I SUB["Counselor"&(SPE["Counselor") S SPE=""
 I SUB["Therapist"&(SPE["Therapist") S SPE=""
 I SUB["Nurse"&(SPE["Nurse") S SPE=""
 I SUB["Pediatric"&(SPE["Pediatric") S SPE=""
 I SUB["Psychiatry"&(SPE["Psychiatry") S SPE=""
 I SUB["Podiatri"&(SPE["Podiatri") S SPE=""
 I SUB["Clinical and Laboratory Immunology" S SUB="Clin & Lab Immunology"
 I SUB["Clinical & Laboratory Immunology" S SUB="Clin & Lab Immunology"
 I SUB["cine-Envir" S SUB="Occ & Environmental"
 I SUB["Child and Adolescent Psyc" S SUB="Pediatric Mental Health"
 I SUB["ist in Meta" S SUB="Metabolic"
 I SUB["ist in Pedia" S SUB="Pediatric"
 I SUB["ist in Renal" S SUB="Renal"
 I SUB["tion Intern" S SUB="Intern"
 I SUB["tion Coordin" S SUB="Coordinator"
 I SUB["tion Counselor" S SUB="Counselor"
 I SUB["for the Blind" S SUB="Orientation for Blind"
 I SUB["Dosimetrist" S SUB="Planning, Dosimetrist"
 I SPEL["Respiratory Care Pr"&(SUB'="") S SPE=""
 ;
 ;--CALCULATE THE BEST DISPLAY
 S DISL=OCCL_"-"_SPEL_"-"_SUBL
 S DIS=OCC_"/"_SPE_"/"_SUB
 I SUB[SPE S DIS=OCC_"/"_SUB
 I SPE="" S DIS=OCC_"/"_SUB
 I SUB="" S DIS=OCC_"/"_SPE
AND I $L(DIS," and ")>1 D
 .N I F I=1:1:$L(DIS," ") I $P(DIS," ",I)="and" S $P(DIS," ",I)="&"
 I $L(DIS," and ")>1 G AND
 ;Q $E(DIS,1,40)_"   "_$L(DIS)
 ;Q $E(DIS,1,40)_"***"_OCCL
 ;Q SPE_"  ***  "_SPEL
 ;Q SUB_"  ***  "_SUBL
 ;Q DISL_"~"_DIS
 ;Q ""_"~"_DIS
 I $G(RETURN)=2 Q DIS
 I $G(RETURN)=3 Q DIS_U_VACODE
 Q -1_"^SOMETHING BAD WRONG_SHOULDN'T BE HERE"
