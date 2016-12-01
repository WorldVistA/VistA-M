IBTRH5A ;ALB/FA - HCSR Create 278 Request ;12-AUG-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ;    CERTCAT   - Function called from within Input Template: IB CREATE 278 REQUEST
 ;                to allow the user to enter Certification information for a
 ;                selected Certification Code Category.
 ;    CERTCOND  - Dictionary Screen function for Certification Conditions. 
 ;                Prevents duplicate Certification Conditions from being entered.
 ;    CERTCNDP  - Function to check for subsequent Certification Conditions 
 ;                values for the specified field
 ;    DXCODE    - Dictionary Screen function for Diagnosis Code field 356.22,3.02
 ;    RCAUSEP   - Function to check for subsequent Related Causes values for
 ;                the specified field
 ;    RCAUSE    - Dictionary Screen function for Related Causes fields.
 ;                (356.22,2.8,356.22,2.9,356.22,2.1)
 ;-----------------------------------------------------------------------------
 ;
RCAUSE(FIELD) ;EP
 ; Dictionary Screen function called from the following fields: 2.08,2.09,2.1
 ; Prevents the same Related Cause from being entered in more than one field.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N NDE,RETURN
 S RETURN=1                                     ; Assume Valid Input
 Q:Y="" 1                                       ; No value entered
 S NDE=$G(^IBT(356.22,DA,2))
 ;
 ; Make sure there are no duplicates
 I FIELD=2.08 D  Q RETURN
 . I $P(NDE,"^",9)=Y S RETURN=0 Q
 . I $P(NDE,"^",10)=Y S RETURN=0 Q
 I FIELD=2.09 D  Q RETURN
 . I $P(NDE,"^",8)=Y S RETURN=0 Q
 . I $P(NDE,"^",10)=Y S RETURN=0 Q
 . I Y'="AP",Y'="EM" S RETURN=0 Q
 I FIELD=2.1 D  Q RETURN
 . I Y'="AP" S RETURN=0 Q
 Q RETURN
 ;
RCAUSEP(FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for fields: 2.08, 2.09
 ; Checks to see if subsequent Related Causes entries have values.
 ; Input:   FIELD   - Field # of the field being checked
 ;                    Set to 'ALL' to see if any of the 3 have a value
 ;          DA      - IEN of the 356.22 entry being edited
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA,2))
 S RETURN=0
 ;
 I FIELD="ALL" D  Q RETURN
 . I $P(NDE,"^",8)'="" S RETURN=1 Q
 . I $P(NDE,"^",9)'="" S RETURN=1 Q
 . I $P(NDE,"^",10)'="" S RETURN=1 Q
 I FIELD=2.08 D  Q RETURN
 . I $P(NDE,"^",9)'="" S RETURN=1 Q
 . I $P(NDE,"^",10)'="" S RETURN=1 Q
 I FIELD=2.09 D  Q RETURN
 . I ($P(NDE,"^",8)="AP")!($P(NDE,"^",9)="AP") S RETURN=0 Q
 . I $P(NDE,"^",10)="AP" S RETURN=1 Q
 . I $P(NDE,"^",9)="",$P(NDE,"^",10)="" S RETURN=0 Q
 . S RETURN=1
 Q RETURN
 ;
DXCODE() ;EP
 ; Dictionary Screen function called from field: 3.02
 ; Prevents a duplicate ICD-9/ICD-10 or DRG Diagnosis from being entered
 ; Input:   DA      - IEN of Diagnosis multiple being entered/edited 95.3
 ;          DA(1)   - IEN of the 356.22 entry being edited
 ;          DIC     - Contains the global ref of dictionary being checked
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N CTYPE,DXCD,DXCDS,DXTYPE,IX,XX
 Q:Y="" 1
 S DXTYPE=$P($G(^IBT(356.22,DA(1),3,DA,0)),"^",1)
 Q:DXTYPE="" 1
 ;
 ; Diagnosis Code must be from file 80.2 for a Diagnosis Type of
 ; Diagnosis Related Group (DRG)
 I DXTYPE=9,$P(DIC,"^",2)'="ICD(" Q 0
 ;
 ; Check for LOI - Logical Observation Identifier Codes
 I DXTYPE=10,$P(DIC,"^",2)'="LAB(95.3," Q 0
 ;
 ; Diagnosis Code must be from file 80 for all other Diagnosis Types
 I DXTYPE'=9,$P(DIC,"^",2)'="ICD9(" Q 0
 ;
 S CTYPE=$$GET1^DIQ(80,Y_",",1.1)                      ; Coding System
 I CTYPE'="",DXTYPE'<1,DXTYPE'>4,CTYPE'["ICD-10-" Q 0  ; Not an ICD-10 Code
 I CTYPE'="",DXTYPE'<5,DXTYPE'>8,CTYPE'["ICD-9-" Q 0   ; Not an ICD-9 Code
 ;
 S IX=0,DXCDS=""
 F  D  Q:+IX=0
 . S IX=$O(^IBT(356.22,DA(1),3,IX))
 . Q:+IX=0
 . Q:IX=DA                                      ; Skip Diagnosis being edited
 . S DXCD=$P(^IBT(356.22,DA(1),3,IX,0),"^",2)
 . S DXCDS=$S(DXCDS="":DXCD,1:DXCDS_"^"_DXCD)
 ;
 ; Diagnosis already exists in a different multiple
 S XX=$S(DXTYPE=10:Y_";LAB(95.3,",DXTYPE=9:Y_";ICD(",1:Y_";ICD9(")
 I ("^"_DXCDS_"^")[("^"_XX_"^") Q 0
 Q 1
 ;
CERTCAT(IBPSTAT)    ;EP
 ; Called from Input Template: IB CREATE 278 REQUEST
 ; Used to ask the user if they want to add/edit information for a specified 
 ; Certification Code Category.  Prompts for a category and then returns the
 ; 'Branch To' Label for the specified category to be added edited
 ; Input:   IBPSTAT - 'I' - Entry is for an In-Patient
 ;                    'O' - Entry is for an Out-Patient
 ; Output:  IHUPOUT - Defined and set to 1 if user entered '^'
 ; Returns: 'Branch To' Label in the input template
 ;          0 if User pressed ^ to exit the template
 ; NOTE: if 0 is returned, IBUPOUT=1 is also returned
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,SEL,XX
 S SEL="07:Ambulance Certification;08:Chiropractic Certification"
 S SEL=SEL_";09:Durable Medical Equipment Certification;11:Oxygen Therapy Certification"
 S SEL=SEL_";75:Functional Limitations;76:Activities Permitted"
 S SEL=SEL_";77:Mental Status"
 S XX="Select a Certification Condition Code Category for which you want to "
 S XX=XX_"additional certification information."
 S DIR("?")=XX
 S DIR(0)="SAO^"_SEL
 S DIR("A")="Additional Certification Information: "
 D ^DIR K DIR
 I $D(DUOUT) S IBUPOUT=1 Q 0                    ; User pressed ^
 I $D(DTOUT) Q "@1300"                          ; User timed out
 Q:Y="" "@1300"
 Q:+Y=7 "@370"
 Q:+Y=8 "@600"
 Q:+Y=9 "@700"
 Q:+Y=11 "@800"
 Q:+Y=75 "@900"
 Q:+Y=76 "@1000"
 Q:+Y=77 "@1100"
 ;
CERTCOND(FIELD) ;EP
 ; Dictionary Screen function called from the following Certification Condition
 ; fields in file 356.22: 4.1,4.11,4.12,4.13,4.14  (Ambulance Cert Conditions)
 ;                        5.02,5.03,5.04,5.05,5.06 (Chiropractic Cert Conds)
 ;                        5.08,5.09,5.1,5.11,5.12  (DME Cert Conditions)
 ;                        5.14,5.15,5.16,5.17,5.18 (Oxygen Cert Conditions)
 ;                        6.02,6.03,6.04,6.05,6.06 (Functional Limit Cert Cond)
 ;                        6.08,6.09,6.1,6.11,6.12  (Activities Cert Conditions)
 ;                        6.14,6.15,6.16,6.17,6.18 (Mental Health Cert Conds)
 ; Prevents the same Certification Condition from being answered in the 
 ; specified Certification Condition Category (e.g. Ambulance, Chiropractic, 
 ; etc.). Also restricts user selection to a specified list by Certification
 ; Condition Category. Finally, also prevents the user from deleting any EXCEPT
 ; the last entered Certification Condition in any category.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 Q:Y="" 1                                       ; No value entered
 ;
 ; Otherwise, make sure there are no duplicate entries in a specified Condition
 ; Category and that only specified entries in 356.008 are selected for a 
 ; specified Condition Category
 I FIELD>4.09,FIELD<4.15 Q $$CONDAMB(DA,FIELD,Y)
 I FIELD>5.01,FIELD<5.07 Q $$CONDCHR(DA,FIELD,Y)
 I FIELD>5.07,FIELD<5.13 Q $$CONDDME(DA,FIELD,Y)
 I FIELD>5.13,FIELD<5.19 Q $$CONDOXY(DA,FIELD,Y)
 I FIELD>6.01,FIELD<6.07 Q $$CONDFL(DA,FIELD,Y)
 I FIELD>6.07,FIELD<6.13 Q $$CONDA(DA,FIELD,Y)
 I FIELD>6.13,FIELD<6.19 Q $$CONDMS(DA,FIELD,Y)
 Q 1
 ;
CERTCNDP(IBTRIEN,FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for Certification Condition
 ; fields. Checks to see if subsequent Certification Condition entries have
 ; values.
 ; Input:   IBTRIEN   - IEN of the 356.22 entry being edited
 ;          FIELD     - Field number of the field the being checked
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE,RETURN
 S RETURN=0
 ;
 ; Ambulance Cert Conditions
 S NDE=$G(^IBT(356.22,IBTRIEN,4))
 I FIELD=4.1 D  Q RETURN
 . I $P(NDE,"^",11)'="" S RETURN=1 Q
 . I $P(NDE,"^",12)'="" S RETURN=1 Q
 . I $P(NDE,"^",13)'="" S RETURN=1 Q
 . I $P(NDE,"^",14)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=4.11 D  Q RETURN
 . I $P(NDE,"^",12)'="" S RETURN=1 Q
 . I $P(NDE,"^",13)'="" S RETURN=1 Q
 . I $P(NDE,"^",14)'="" S RETURN=1 Q
 I FIELD=4.12 D  Q RETURN
 . I $P(NDE,"^",13)'="" S RETURN=1 Q
 . I $P(NDE,"^",14)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=4.13,($P(NDE,"^",14)'="") Q 1
 ;
 ; Chiropractic Cert Conditions
 S NDE=$G(^IBT(356.22,IBTRIEN,5))
 I FIELD=5.02 D  Q RETURN
 . I $P(NDE,"^",3)'="" S RETURN=1 Q
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=5.03 D  Q RETURN
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=5.04 D  Q RETURN
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 I FIELD=5.05,($P(NDE,"^",6)'="") Q 1
 ;
 ; DME Cert Conditions
 I FIELD=5.08 D  Q RETURN
 . I $P(NDE,"^",9)'="" S RETURN=1 Q
 . I $P(NDE,"^",10)'="" S RETURN=1 Q
 . I $P(NDE,"^",11)'="" S RETURN=1 Q
 . I $P(NDE,"^",12)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=5.09 D  Q RETURN
 . I $P(NDE,"^",10)'="" S RETURN=1 Q
 . I $P(NDE,"^",11)'="" S RETURN=1 Q
 . I $P(NDE,"^",12)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=5.1 D  Q RETURN
 . I $P(NDE,"^",11)'="" S RETURN=1 Q
 . I $P(NDE,"^",12)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=5.11,($P(NDE,"^",12)'="") Q 1
 ;
 ; Oxygen Cert Conditions
 I FIELD=5.14 D  Q RETURN
 . I $P(NDE,"^",15)'="" S RETURN=1 Q
 . I $P(NDE,"^",16)'="" S RETURN=1 Q
 . I $P(NDE,"^",17)'="" S RETURN=1 Q
 . I $P(NDE,"^",18)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=5.15 D  Q RETURN
 . I $P(NDE,"^",16)'="" S RETURN=1 Q
 . I $P(NDE,"^",17)'="" S RETURN=1 Q
 . I $P(NDE,"^",18)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=5.16 D  Q RETURN
 . I $P(NDE,"^",17)'="" S RETURN=1 Q
 . I $P(NDE,"^",18)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=5.17,($P(NDE,"^",18)'="") Q 1
 ;
 ; Functional Limits Cert Conditions
 S NDE=$G(^IBT(356.22,IBTRIEN,6))
 I FIELD=6.02 D  Q RETURN
 . I $P(NDE,"^",3)'="" S RETURN=1 Q
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.03 D  Q RETURN
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.04 D  Q RETURN
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.05,($P(NDE,"^",6)'="") Q 1
 ;
 ; Activities Cert Conditions
 I FIELD=6.08 D  Q RETURN
 . I $P(NDE,"^",9)'="" S RETURN=1 Q
 . I $P(NDE,"^",10)'="" S RETURN=1 Q
 . I $P(NDE,"^",11)'="" S RETURN=1 Q
 . I $P(NDE,"^",12)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.09 D  Q RETURN
 . I $P(NDE,"^",10)'="" S RETURN=1 Q
 . I $P(NDE,"^",11)'="" S RETURN=1 Q
 . I $P(NDE,"^",12)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.1 D  Q RETURN
 . I $P(NDE,"^",11)'="" S RETURN=1 Q
 . I $P(NDE,"^",12)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.11,($P(NDE,"^",12)'="") Q 1
 ;
 ; Mental Status Cert Conditions
 I FIELD=6.14 D  Q RETURN
 . I $P(NDE,"^",15)'="" S RETURN=1 Q
 . I $P(NDE,"^",16)'="" S RETURN=1 Q
 . I $P(NDE,"^",17)'="" S RETURN=1 Q
 . I $P(NDE,"^",18)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.15 D  Q RETURN
 . I $P(NDE,"^",16)'="" S RETURN=1 Q
 . I $P(NDE,"^",17)'="" S RETURN=1 Q
 . I $P(NDE,"^",18)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.16 D  Q RETURN
 . I $P(NDE,"^",17)'="" S RETURN=1 Q
 . I $P(NDE,"^",18)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=6.17,($P(NDE,"^",18)'="") Q 1
 Q 0
 ;
CONDAMB(IBTRIEN,FIELD,VALUE) ; Makes sure the user entry for a Certification
 ; Condition is valid for Ambulance Certification Conditions and it's not a
 ; duplicate
 ; Input:   IBTRIEN     - IEN of the 356.22 entry being edited
 ;          FIELD       - Field number of the field value being checked
 ;          VALUE       - Internal value being validated
 ; Returns: 1 if the field value is valid, 0 otherwise
 N CCONDS,NDE,PCE,PCES,XX
 S CCONDS="",NDE=$G(^IBT(356.22,IBTRIEN,4))
 ;
 ; First, set an array of valid entries of valid Ambulance Conditions
 F XX=1:1:9,40,42,48,49,52 S CCONDS(XX)=""
 ;
 ; Value is not valid for Ambulance Certification Conditions
 I '$D(CCONDS(VALUE)) Q 0
 ;
 ; Next, check for duplicate values
 S PCES="10^11^12^13^14"
 S PCE=$S(FIELD=4.1:10,FIELD=4.11:11,FIELD=4.12:12,FIELD=4.13:13,1:14)
 Q $$CHKDUPS(PCE,VALUE,NDE,PCES)
 ;
CONDCHR(IBTRIEN,FIELD,VALUE) ; Makes sure the user entry for a Certification
 ; Condition is valid for Chiropractic Certification Conditions and it's not a
 ; duplicate
 ; Input:   IBTRIEN     - IEN of the 356.22 entry being edited
 ;          FIELD       - Field number of the field value being checked
 ;          VALUE       - Internal value being validated
 ; Returns: 1 if the field value is valid, 0 otherwise
 N CCONDS,NDE,PCE,PCES,XX
 S CCONDS="",NDE=$G(^IBT(356.22,IBTRIEN,5))
 ;
 ; First, set an array of valid entries of valid Chiropractic Conditions
 F XX=11,12,14,24,25,27,30 S CCONDS(XX)=""
 ;
 ; Value is not valid for Chiropractic Certification Conditions
 I '$D(CCONDS(VALUE)) Q 0
 ;
 ; Next, check for duplicate values
 S PCES="2^3^4^5^6"
 S PCE=$S(FIELD=5.02:2,FIELD=5.03:3,FIELD=5.04:4,FIELD=5.05:5,1:6)
 Q $$CHKDUPS(PCE,VALUE,NDE,PCES)
 ;
CONDDME(IBTRIEN,FIELD,VALUE) ; Makes sure the user entry for a Certification
 ; Condition is valid for DME Certification Conditions and it's not a
 ; duplicate
 ; Input:   IBTRIEN     - IEN of the 356.22 entry being edited
 ;          FIELD       - Field number of the field value being checked
 ;          VALUE       - Internal value being validated
 ; Returns: 1 if the field value is valid, 0 otherwise
 N CCONDS,NDE,PCE,PCES,XX
 S CCONDS="",NDE=$G(^IBT(356.22,IBTRIEN,5))
 ;
 ; First, set an array of valid entries of valid DME Conditions
 F XX=1:1:27,29:1:33,35,36,37,39:1:47,49,52,55,56,57,79,80,88 D
 . S CCONDS(XX)=""
 ;
 ; Value is not valid for DME Certification Conditions
 I '$D(CCONDS(VALUE)) Q 0
 ;
 ; Next, check for duplicate values
 S PCES="8^9^10^11^12"
 S PCE=$S(FIELD=5.08:8,FIELD=5.09:9,FIELD=5.1:10,FIELD=5.11:11,1:12)
 Q $$CHKDUPS(PCE,VALUE,NDE,PCES)
 ;
CONDOXY(IBTRIEN,FIELD,VALUE) ; Makes sure the user entry for a Certification
 ; Condition is valid for Oxygen Certification Conditions and it's not a
 ; duplicate
 ; Input:   IBTRIEN     - IEN of the 356.22 entry being edited
 ;          FIELD       - Field number of the field value being checked
 ;          VALUE       - Internal value being validated
 ; Returns: 1 if the field value is valid, 0 otherwise
 N CCONDS,NDE,PCE,PCES,XX
 S CCONDS="",NDE=$G(^IBT(356.22,IBTRIEN,5))
 ;
 ; First, set an array of valid entries of valid Oxygen Conditions
 F XX=6,16,17,25,33,36,38,48,56,57,73 S CCONDS(XX)=""
 ;
 ; Value is not valid for Oxygen Certification Conditions
 I '$D(CCONDS(VALUE)) Q 0
 ;
 ; Next, check for duplicate values
 S PCES="14^15^16^17^18"
 S PCE=$S(FIELD=5.14:14,FIELD=5.15:15,FIELD=5.16:16,FIELD=5.17:17,1:18)
 Q $$CHKDUPS(PCE,VALUE,NDE,PCES)
 ;
CONDFL(IBTRIEN,FIELD,VALUE) ; Makes sure the user entry for a Certification
 ; Condition is valid for Functional Limitations Certification Conditions and
 ; it's not a duplicate
 ; Input:   IBTRIEN     - IEN of the 356.22 entry being edited
 ;          FIELD       - Field number of the field value being checked
 ;          VALUE       - Internal value being validated
 ; Returns: 1 if the field value is valid, 0 otherwise
 N CCONDS,NDE,PCE,PCES,XX
 S CCONDS="",NDE=$G(^IBT(356.22,IBTRIEN,6))
 ;
 ; First, set an array of valid entries of valid Functional Limitations
 ; Conditions
 F XX=2:1:6,11,12,14:1:28,30,31,32,35,36,38:1:45,48 D
 . S CCONDS(XX)=""
 F XX=50,51,53,54,55,58,60,61,62,64,65,66,68,69,73,74,75,78,80,81,84,86:1:89,93,94 D
 . S CCONDS(XX)=""
 ;
 ; Value is not valid for Functional Limitations Certification Conditions
 I '$D(CCONDS(VALUE)) Q 0
 ;
 ; Next, check for duplicate values
 S PCES="2^3^4^5^6"
 S PCE=$S(FIELD=6.02:2,FIELD=6.03:3,FIELD=6.04:4,FIELD=6.05:5,1:6)
 Q $$CHKDUPS(PCE,VALUE,NDE,PCES)
 ;
CONDA(IBTRIEN,FIELD,VALUE) ; Makes sure the user entry for a Certification
 ; Condition is valid for Activities Certification Conditions and
 ; it's not a duplicate
 ; Input:   IBTRIEN     - IEN of the 356.22 entry being edited
 ;          FIELD       - Field number of the field value being checked
 ;          VALUE       - Internal value being validated
 ; Returns: 1 if the field value is valid, 0 otherwise
 N CCONDS,NDE,PCE,PCES,XX
 S CCONDS="",NDE=$G(^IBT(356.22,IBTRIEN,6))
 ;
 ; First, set an array of valid entries of valid Activities Conditions
 F XX=10,13,19,21,22,27,31,39,63,65,66,70,74,75,79,83,86,87,90,92,93,94 D
 . S CCONDS(XX)=""
 ;
 ; Value is not valid for Activities Certification Conditions
 I '$D(CCONDS(VALUE)) Q 0
 ;
 ; Next, check for duplicate values
 S PCES="8^9^10^11^12"
 S PCE=$S(FIELD=6.08:8,FIELD=6.09:9,FIELD=6.1:10,FIELD=6.11:11,1:12)
 Q $$CHKDUPS(PCE,VALUE,NDE,PCES)
 ;
CONDMS(IBTRIEN,FIELD,VALUE) ; Makes sure the user entry for a Certification
 ; Condition is valid for Mental Status Certification Conditions and
 ; it's not a duplicate
 ; Input:   IBTRIEN     - IEN of the 356.22 entry being edited
 ;          FIELD       - Field number of the field value being checked
 ;          VALUE       - Internal value being validated
 ; Returns: 1 if the field value is valid, 0 otherwise
 N CCONDS,NDE,PCE,PCES,XX
 S CCONDS="",NDE=$G(^IBT(356.22,IBTRIEN,6))
 ;
 ; First, set an array of valid entries of valid Mental Status Conditions
 F XX=1,5,7,13,20,22,23,26,33,34,48,50,51,53,54,56,57,59,62,64,66,67,71,72,76,77,81,82,85,91  D
 . S CCONDS(XX)=""
 ;
 ; Value is not valid for Functional Limitations Certification Conditions
 I '$D(CCONDS(VALUE)) Q 0
 ;
 ; Next, check for duplicate values
 S PCES="14^15^16^17^18"
 S PCE=$S(FIELD=6.14:14,FIELD=6.15:15,FIELD=6.16:16,FIELD=6.17:17,1:18)
 Q $$CHKDUPS(PCE,VALUE,NDE,PCES)
 ;
CHKDUPS(FPCE,VALUE,NDE,PCES) ;EP
 ; Generic duplicate field checker.  Checks for a duplicate value in a list of
 ; fields to prevent the same value from being entered in more than field in
 ; the list
 ; Input:   FPCE    - Piece # of the field being checked
 ;          VALUE   - Internal Value of the user response
 ;          NDE     - HCSR Transmission file node that contains the fields
 ;          PCES    - '^' delimited list of storage locations for above fields
 ; Returns: 1 - No duplicates found, 0 otherwise
 N IX,PCE,RETURN
 S RETURN=1                                     ; Assume Valid Input
 Q:VALUE="" 1                                   ; No value entered
 ;
 ; Make sure there are no duplicates
 F IX=1:1:$L(PCES,"^") D  Q:RETURN=0
 . S PCE=$P(PCES,"^",IX)
 . Q:PCE=FPCE
 . I $P(NDE,"^",PCE)=VALUE S RETURN=0 Q
 Q RETURN
 ;
