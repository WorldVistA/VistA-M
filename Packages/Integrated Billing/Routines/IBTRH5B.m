IBTRH5B ;ALB/FA - HCSR Create 278 Request ;12-AUG-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ;    OXYTTYPE  - Dictionary Screen function for Oxygen Equipment Type Fields
 ;                (8.01,8.02,8.03)
 ;    OXYTTYPP  - Called from within the Input Template to check if subsequent
 ;                Equipment Types have values (8.01,8.02)
 ;    OXYTFIND  - Dictionary Screen function for Oxygen Test Finding Fields
 ;                9.04,9.05,9.06)
 ;    OXYTFNDP  - Called from within the Input Template to check if subsequent
 ;                Test Findings have values (9.04,9.05)
 ;    OUDREASP  - Called from within the Input Template to check if subsequent
 ;                Other UMO Denial Reasons have values
 ;    ONESL     - Used to create a new Professional, Institutional or Dental
 ;                Service Line
 ;    ORALCAV   - Dictionary Screen function for Oral Cavity Fields
 ;                2216,3.01,2216,3.02,2216,3.03,2216,3.04,2216,3.05)
 ;    ORALCAVP  - Called from within the Input Template to check if subsequent
 ;                Oral Cavity fields have values
 ;    PITSL     - Called from the Input Template.
 ;                Asks the user the type of Service Line being created:
 ;                Professional, Institutional or Dental.  Files the Service
 ;                Line Type, Service Request Category and Service Certification
 ;                Type fields
 ;    PROC      - Dictionary Screen function for Procedure fields in 356.22
 ;                (10.07, 16,1.02, 16,1.03)
 ;    PROCTYPE  - Dictionary Screen function for Proc Type (356.2216, 1.01)
 ;    PROCMOD   - Dictionary Screen function for Procedure Modifier Fields
 ;                (2216,1.04,2216,1.05,2216,1.06,2216,1.07)
 ;    PROCMODP  - Called from within the Input Template to check if subsequent
 ;                Service Line Procedure Modifiers have values
 ;    SLDXP     - Called from within the Input Template to check if subsequent
 ;                Service Line Procedure Diagnoses have values
 ;    TOOTHS    - Dictionary Screen function for Dental Service Lines Tooth Fields
 ;                (22164/.02, 22614/.03, 22614/.04, 22614/.05, 22614/.06)
 ;-----------------------------------------------------------------------------
 ;
OXYTTYPE(FIELD) ;EP
 ; Dictionary Screen function called from Home Oxygen Therapy Information fields:
 ; 8.01,8.02,8.03. Prevents the same Oxygen Equipment Type from being selected
 ; more than once.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA,8))
 S RETURN=1                                     ; Assume Valid Input
 Q:Y="" 1                                       ; No value entered
 ;
 ; Make sure there are no duplicates
 I FIELD=8.01 D  Q RETURN
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 I FIELD=8.02 D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 I FIELD=8.03 D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 Q RETURN
 ;
OXYTTYPP(IBTRIEN,FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for Oxygen Equipment Type
 ; fields. Checks to see if subsequent Oxygen Entry Equipment Type entries have
 ; values.
 ; Input:   IBTRIEN   - IEN of the 356.22 entry being edited
 ;          FIELD     - Field number of the field being checked
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE
 S NDE=$G(^IBT(356.22,IBTRIEN,8))
 I FIELD=8.01,(($P(NDE,"^",2)'="")!($P(NDE,"^",3)'="")) Q 1
 I FIELD=8.02,($P(NDE,"^",3)'="") Q 1
 Q 0
 ;
OXYTFIND(FIELD) ;EP
 ; Dictionary Screen function called from Home Oxygen Therapy Information fields:
 ; 9.04,9.05,9.06. Prevents the same Oxygen Equipment Test finding from being
 ; selected more than once.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA,9))
 S RETURN=1                                     ; Assume Valid Input
 Q:Y="" 1                                       ; No value entered
 ;
 ; Make sure there are no duplicates
 I FIELD=9.04 D  Q RETURN
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 I FIELD=9.05 D  Q RETURN
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 I FIELD=9.06 D  Q RETURN
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 Q RETURN
 ;
OXYTFNDP(IBTRIEN,FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for Oxygen Test Finding
 ; fields. Checks to see if subsequent Oxygen Test Findings entries have
 ; values.
 ; Input:   IBTRIEN   - IEN of the 356.22 entry being edited
 ;          FIELD     - Field number of the field being checked
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE
 S NDE=$G(^IBT(356.22,IBTRIEN,9))
 I FIELD=9.04,(($P(NDE,"^",5)'="")!($P(NDE,"^",6)'="")) Q 1
 I FIELD=9.05,($P(NDE,"^",6)'="") Q 1
 Q 0
 ;
OUDREASP(FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for Other UMO Denial Reasons
 ; fields. Checks to see if subsequent Denial Reasons have values.
 ; Input:   FIELD   - Field number of the field being checked
 ;          DA      - IEN of the 356.2215 multiple entry being edited
 ;          DA(1)   - IEN of the Patient Event Entry
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA(1),15,DA,0))           ; Other UMO Info node
 I FIELD=.03 D  Q RETURN
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=.04 D  Q RETURN
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=.05,($P(NDE,"^",6)'="") Q 1
 Q 0
 ;
ONESL(IBTRIEN,REQCAT,CERTCD,SLTYPE,IBSLCTR) ;EP
 ; Called from Input Template: IB CREATE 278 REQUEST
 ; Auto Files a new Profession, Institutional or Dental Service Line multiple
 ; into 356.22. Only auto files the .02, .03 and 1.12 field. Other specified 
 ; fields are asked within the Input Template according to the Service Line
 ; Type. 
 ; Input:   IBTRIEN - IEN of the selected entry
 ;          REQCAT  - IEN of the Request Category to file in .01
 ;          CERTCD  - IEN of the Certification Code to file in .02
 ;          SLTYPE  - 'P' - Professional Service Line
 ;                    'I' - Institutional Service Line
 ;                    'D' - Dental Service Line
 ;          IBSLCTR - Current number of Service Line multiples
 ; Output:  Service Line multiple is filed into 356.2216
 ;          IBSLCTR - Updated number of Service Line multiples
 ; Returns: 1 if a Provider Data multiple was filed, 0 otherwise
 N FDA
 S IBSLCTR=IBSLCTR+1
 ;
 ; File Service Line Multiple
 S FDA(356.2216,"+1,"_IBTRIEN_",",.01)=REQCAT   ; Request Category
 S FDA(356.2216,"+1,"_IBTRIEN_",",.02)=CERTCD   ; Certification Code
 S FDA(356.2216,"+1,"_IBTRIEN_",",1.12)=SLTYPE  ; Service Line Type
 D UPDATE^DIE("","FDA")
 Q 1
 ;
PITSL(IBREQCAT) ;EP
 ; Called from Input Template: IB CREATE 278 REQUEST
 ; Called when creating a new Service Line to determine the type of Service
 ; Line to be created
 ; Input:   IBREQCAT    - IEN of the Patient Event Request Category
 ;          DA(1)       - IEN of the selected entry
 ;          DA          - IEN of the Service Line Multiple
 ; Output:  IBEXIT      - 1 if user entered ^, timed out or answered E
 ;                        0 otherwise. 
 ;                        if 1 NO service line multiple is filed
 ;          Service Line multiple is filed into 356.2216
 ; Returns: Label to jump to based upon the type of line selected
 ;          Returns '0' to exit multiple if not entered
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ERROR,FDA,SLTYPE,X,XX,Y
 ;
 ; Get the Service Line Type of the first line. If present, all other Service
 ; Lines for this entry must be of the same type. If not present AND the 
 ; Request Category is 'AR' it's an Institutional line. If not present and
 ; the Request Category is not 'AR', then ask for service line type as we
 ; are creating the first service line
 S SLTYPE=$$GET1^DIQ(356.2216,DA_","_DA(1)_",",1.12,"I")
 Q:SLTYPE'="" $S(SLTYPE="P":"@1500",SLTYPE="I":"@1600",1:"@1700")
 S DIR(0)="SA^I:Institutional;P:Professional;D:Dental;E:Exit"
 S XX="Enter the type of Service line you wish to create. Select E if you don't"
 S XX=XX_" want to create a new service line."
 S DIR("?")=XX
 S DIR("A")="Service Line Type: "
PITSL1 ; Looping Tag
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="E") S IBEXIT=1 Q 0
 S SLTYPE=Y
 ;
 ; File Service Line Type
 S FDA(356.2216,DA_","_DA(1)_",",1.12)=SLTYPE ; Service Line Type
 D FILE^DIE("","FDA","ERROR")
 Q $S(SLTYPE="P":"@1500",SLTYPE="I":"@1600",1:"@1700")
 ;
PROC(FIELD) ;EP
 ; Dictionary Screen function called from the following fields in file 356.22:
 ; 10.07, 16,1.02, 16,1.03
 ; Prevents dictionary lookup into the wrong dictionary of the variable pointer
 ; field.
 ; Input:   FIELD   - Field # of the field being screened
 ;          DA      - IEN of the 356.22 entry if FIELD=10.07. Otherwise, IEN of
 ;                    the service line multiple
 ;          DA(1)   - IEN of the 356.22 entry being edited if FIELD'=10.07
 ;          DIC     - Contains the global ref of dictionary being checked
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 ; NOTE: Dental search disabled for now
 N DENTAL,PXTYPE
 Q:Y="" 1
 S DENTAL=""
 I FIELD=10.07 S PXTYPE=$$GET1^DIQ(356.22,DA_",",10.06,"I")
 E  D
 . S PXTYPE=$$GET1^DIQ(356.2216,DA_","_DA(1)_",",1.01,"I")
 . S DENTAL=$S($$GET1^DIQ(356.2216,DA_","_DA(1)_",",1.12,"I")="D":1,1:0)
 Q:PXTYPE="" 1
 ;
 ; Dental Procedure Code must be from file 81 and have right CPT CATEGORY
 I DENTAL,($P(DIC,"^",2)'="ICPT(")!($P($$CPT^ICPTCOD(Y),"^",4)'=185) Q 0  ;DBIA1995
 ;
 ; Procedure Code must be from file 81 for a Type of 'HC'
 I PXTYPE="HC",$P(DIC,"^",2)'="ICPT(" Q 0
 ;
 ; Procedure Code must be from file 80.1 for a Type of 'ID' or 'ZZ'
 ; for fields 10.07, 1.02 and 1.03.
 ; NOTE: 'ZZ' not valid for 10.07
 I ((PXTYPE="ID")!(PXTYPE="ZZ")),$P(DIC,"^",2)'="ICD0(" Q 0
 Q 1
 ;
PROCTYPE() ;EP
 ; Dictionary Screen function called from field in file 356.2216, 1.01
 ; Prevents selection of 'ID' or 'ZZ' if entry is not for an inpatient
 ; Input:   DA      - IEN of the 356.22 entry if FIELD=10.07. Otherwise, IEN of
 ;                    the service line multiple
 ;          DA(1)   - IEN of the 356.22 entry being edited if FIELD'=10.07
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N DENTAL,IBPSTAT,SLTYPE
 Q:Y="" 1
 S DENTAL=$S($P($G(^IBT(356.22,DA(1),16,DA,1)),"^",12)="D":1,1:0)
 S SLTYPE=$$GET1^DIQ(356.2216,DA_","_DA(1)_",",1.12,"I")
 I DENTAL,Y'="AD" Q 0
 I 'DENTAL,Y="AD" Q 0
 S IBPSTAT=$P($G(^IBT(356.22,DA(1),0)),"^",4)
 I SLTYPE'="I",((Y="ID")!(Y="ZZ")) Q 0
 I SLTYPE="I",IBPSTAT="O",((Y="ID")!(Y="ZZ")) Q 0
 Q 1
 ;
PROCMOD(FIELD) ;EP
 ; Dictionary Screen function called from Service Line Procedure Modifier Fields:
 ; 32216,1.04, 32216,1.05, 32216,1.06, 32216,1.07. 
 ; Prevents the same Procedure Modifier from being selected more than once.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the Service Line Multiple being edited
 ;          DA(1)   - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA(1),16,DA,1))
 S RETURN=1                                     ; Assume Valid Input
 Q:Y="" 1                                       ; No value entered
 ;
 ; Make sure there are no duplicates
 I FIELD=1.04 D  Q RETURN
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 . I $P(NDE,"^",7)=Y S RETURN=0 Q
 I FIELD=1.05 D  Q RETURN
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 . I $P(NDE,"^",7)=Y S RETURN=0 Q
 I FIELD=1.06 D  Q RETURN
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 . I $P(NDE,"^",7)=Y S RETURN=0 Q
 I FIELD=1.07 D  Q RETURN
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 Q RETURN
 ;
PROCMODP(FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for Service Line Procedure
 ; Modifier fields. Checks to see if subsequent Procedure Modifier entries have
 ; values.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the Service Line Multiple being edited
 ;          DA(1)   - IEN of the 356.22 entry being edited
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA(1),16,DA,1))
 I FIELD=1.04 D  Q RETURN
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . I $P(NDE,"^",7)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=1.05 D  Q RETURN
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . I $P(NDE,"^",7)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=1.06,$P(NDE,"^",7)'="" Q 1
 Q 0
 ;
SLDXP(FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for Service Line Procedure
 ; Diagnosis fields. Checks to see if subsequent Procedure Diagnosis entries
 ; have values.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the Service Line Multiple being edited
 ;          DA(1)   - IEN of the 356.22 entry being edited
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA(1),16,DA,2))
 I FIELD=2.01 D  Q RETURN
 . I $P(NDE,"^",2)'="" S RETURN=1 Q
 . I $P(NDE,"^",3)'="" S RETURN=1 Q
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=2.02 D  Q RETURN
 . I $P(NDE,"^",3)'="" S RETURN=1 Q
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=2.03,$P(NDE,"^",4)'="" Q 1
 Q 0
 ;
ORALCAV(FIELD) ;EP
 ; Dictionary Screen function called from Service Line Oral Cavity Fields:
 ; 32216,3.01, 32216,3.02, 32216,3.03, 32216,3.04, 32216,3.05. 
 ; Prevents the same Oral Cavity from being selected more than once.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the Service Line Multiple being edited
 ;          DA(1)   - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA(1),16,DA,3))
 S RETURN=1                                     ; Assume Valid Input
 Q:Y="" 1                                       ; No value entered
 ;
 ; Make sure there are no duplicates
 I FIELD=3.01 D  Q RETURN
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 I FIELD=3.02 D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 I FIELD=3.03 D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 I FIELD=3.04 D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 I FIELD=3.05 D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 Q RETURN
 ;
ORALCAVP(FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for Service Line Oral Cavity
 ; fields. Checks to see if subsequent Oral Cavity entries have values.
 ; Input:   DA      - IEN of the Service Line Multiple being edited
 ;          DA(1)   - IEN of the 356.22 entry being edited
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA(1),16,DA,3))
 I FIELD=3.01 D  Q RETURN
 . I $P(NDE,"^",2)'="" S RETURN=1 Q
 . I $P(NDE,"^",3)'="" S RETURN=1 Q
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=3.02 D  Q RETURN
 . I $P(NDE,"^",3)'="" S RETURN=1 Q
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=3.03 D  Q RETURN
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=3.04,$P(NDE,"^",5)'="" Q 1
 Q 0
 ;
TOOTHS(FIELD) ;EP
 ; Dictionary Screen function called from Dental Service Line Tooth fields:
 ; 22164,.02, 22614,.03, 22614,.04, 22614,.05, 22614,.06. Prevents the 
 ; same Tooth Surface from being selected
 ; more than once.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - Tooth Surface multiple IEN
 ;          DA(1)   - Service Line multiple IEN
 ;          DA(2)   - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA(2),16,DA(1),4,DA,0))
 S RETURN=1                                     ; Assume Valid Input
 Q:Y="" 1                                       ; No value entered
 ;
 ; Make sure there are no duplicates
 I FIELD=.02 D  Q RETURN
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 I FIELD=.03 D  Q RETURN
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 I FIELD=.04 D  Q RETURN
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 I FIELD=.05 D  Q RETURN
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",6)=Y S RETURN=0 Q
 I FIELD=.06 D  Q RETURN
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 . I $P(NDE,"^",5)=Y S RETURN=0 Q
 Q RETURN
 ;
