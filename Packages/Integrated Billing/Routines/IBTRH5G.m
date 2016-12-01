IBTRH5G ;ALB/FA - HCSR Create 278 Request ;01-OCT-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; CERTDATA     - Determines which (if any) Certification Condition Categories
 ;                contain data
 ; CONTINFO     - Checks for contact number data for subsequent numbers
 ; SECTDATA     - Determines if a specified section contains any fields with
 ;                values and (optionally) displays the all the section's fields
 ;                and their values
 ;-----------------------------------------------------------------------------
 ;
CONTINFO(IBTRIEN,FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for fields: 20, 21
 ; Checks to see if subsequent Contact number entries have values.
 ; Input:   IBTRIEN - IEN of entry being processed
 ;          FIELD   - Field # of the field being checked
 ;                    Set to 'ALL' to see if any of the 3 have a value
 ;          DA      - IEN of the 356.22 entry being edited
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N RETURN,XX,ZZ
 S RETURN=0
 ;
 I FIELD=20 D  Q RETURN
 . S XX=$$GET1^DIQ(356.22,IBTRIEN_",",21,"I")
 . S ZZ=$$GET1^DIQ(356.22,IBTRIEN_",",22,"I")
 . I (XX'="")!(ZZ'="") S RETURN=1 Q
 I FIELD=21 D  Q RETURN
 . I $$GET1^DIQ(356.22,IBTRIEN_",",22,"I")'="" S RETURN=1 Q
 Q RETURN
 ;
CERTDATA(IBTRIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Determines which Certification Condition Categories contains any fields with
 ; values and then displays a list of Categories that Contain data.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being examined
 ; Output:  Displays a list of Certification Condition Categories that have at 
 ;          least one field with a value. If no Certification Condition
 ;          Categories have a value then nothing is displayed.
 N CATS,CTR,IX,LEN,DISP,FIRST,XX
 S CATS="",CTR=1
 I $$CHKFLDS(356.22,IBTRIEN_",","4.09^4.1^4.11^4.12^4.13^4.14") D
 . S CATS(CTR)="Ambulance"
 . I $$CHKFLDS(356.22,IBTRIEN_",","18.01^18.02^18.03^18.04^18.05^18.06^18.09^18.1") D
 . . S CATS(CTR)=CATS(CTR)_" W/Amb Trans Info"
 . I $$CHKFLDSM(356.22,IBTRIEN,14,".01^.02^.03^.04^.05^.07") D
 . . S XX="Pat Trans Info"
 . . S CATS(CTR)=CATS(CTR)_$S(CATS(CTR)["Amb Trans Info":",",1:"")_" "_XX
 . S CTR=CTR+1
 I $$CHKFLDS(356.22,IBTRIEN_",","5.01^5.02^5.03^5.04^5.05^5.06") D
 . S CATS(CTR)="Chiropractic"
 . I $$CHKFLDS(356.22,IBTRIEN_",","7.05^7.06^7.07^7.08^7.09^7.1^7.11^7.12^7.13") D
 . . S CATS(CTR)=CATS(CTR)_" W/Spinal Service Info"
 . S CTR=CTR+1
 I $$CHKFLDS(356.22,IBTRIEN_",","5.07^5.08^5.09^5.1^5.11^5.12") D
 . S CATS(CTR)="DME",CTR=CTR+1
 I $$CHKFLDS(356.22,IBTRIEN_",","5.13^5.14^5.15^5.16^5.17^5.18") D
 . S CATS(CTR)="Oxygen"
 . S XX="8.01^8.02^8.03^8.04^8.05^8.06^8.07^8.08^9.01^9.02^9.03^9.04^9.05^9.06^9.07^9.08"
 . I $$CHKFLDS(356.22,IBTRIEN_",",XX) D
 . . S CATS(CTR)=CATS(CTR)_" W/Home Oxygen Therapy Info"
 . S CTR=CTR+1
 I $$CHKFLDS(356.22,IBTRIEN_",","6.01^6.02^6.03^6.04^6.05^6.06") D
 . S CATS(CTR)="Functional Limits",CTR=CTR+1
 I $$CHKFLDS(356.22,IBTRIEN_",","6.07^6.08^6.09^6.1^6.11^6.12") D
 . S CATS(CTR)="Activities",CTR=CTR+1
 I $$CHKFLDS(356.22,IBTRIEN_",","6.13^6.14^6.15^6.16^6.17^6.18") D
 . S CATS(CTR)="Mental Status",CTR=CTR+1
 ;
 ; No Certification Condition Categories contain data
 Q:CTR=1
 ;
 W !!,"The following Certification Condition Categories contain data:"
 S IX="",DISP="   ",FIRST=1
 F  D  Q:IX=""
 . S IX=$O(CATS(IX))
 . Q:IX=""
 . I 'FIRST,($L(DISP)+$L(CATS(IX))+2)>79 D  Q
 . . W !,DISP,","
 . . S DISP="   "_CATS(IX)
 . I FIRST S DISP=DISP_CATS(IX),FIRST=0 Q
 . S DISP=DISP_", "_CATS(IX)
 W:$TR(DISP," ","")'="" !,DISP
 W !
 Q
 ;
CHKFLDSM(FILE,IBTRIEN,NDE,FIELDS) ; Checks all multiples for a specified node to see if
 ; any of the specified fields are non-null
 ; Input:   FILE    - # of file being checked
 ;          IBTRIEN - IEN of the entry being checked
 ;          NDE     - Multiple node to check for data
 ;          FIELDS  - '^' delimited list of fields to be examined
 ; Returns: 1 - At least one field of one multiple is non-null, 0 otherwise
 N FOUND,IEN,IENS,SFILE
 S (FOUND,IEN)=0,SFILE=FILE_NDE
 F  D  Q:+IEN=0!FOUND
 . S IEN=$O(^IBT(FILE,IBTRIEN,NDE,IEN))
 . Q:+IEN=0
 . S IENS=IEN_","_IBTRIEN_","
 . S:$$CHKFLDS(SFILE,IENS,FIELDS) FOUND=1
 Q FOUND
 ;
CHKFLDS(FILE,IENS,FIELDS) ; Checks to see if any of the specified pieces of the
 ; specified node are non-null
 ; Input:   FILE    - # of file being checked
 ;          IENS    - IEN list of the 356.22 entry being examined
 ;          FIELDS  - '^' delimited list of fields to be examined
 ; Returns: 1 - At least one field is non-null, 0 otherwise
 N FIELD,FOUND,IX
 S FOUND=0
 F IX=1:1:$L(FIELDS,"^") D  Q:FOUND
 . S FIELD=$P(FIELDS,"^",IX)
 . S:$$GET1^DIQ(FILE,IENS_",",FIELD,"I")'="" FOUND=1
 Q:FOUND 1
 Q 0
 ;
SECTDATA(IBTRIEN,SIEN,SECTION,HEADER,DISPLAY) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Determines if the specified section contains any fields with values and
 ; (optionally) displays all of the section's fields and their values.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the service line multiple being examined
 ;                    NOTE: Only passed if examinng a service line section.
 ;          SECTION - Identifier for the section to be examined
 ;                      HCSD   -  Health Care Services Delivery Section
 ;                      AMBTI  -  Ambulance Transport Information Section
 ;                      SPMSI  -  Spinal Manipulation Service Info Section
 ;                      HOTI   -  Home Oxygen Therapy Info Section
 ;                      HHCI   -  Home Health Care Info Section
 ;                      SHCRSI -  Service Line HCRS Information Section
 ;                      CMPI   -  Service Line Composite Medical Procedure Info
 ;                                Section
 ;                      OCDI   -  Service Line Oral Cavity Designation Info
 ;                                Section
 ;                      SHCSD  -  Service Line Health Care Services Delivery
 ;          HEADER  - Header text to show when displaying a section's field
 ;          DISPLAY - 1 to display all of the section's field if at least one
 ;                      field has a value.  0 otherwise
 ; Output:  Displays a section's fields and their values if DISPLAY=1 and the
 ;          specified section has at least one field with a value
 ; Returns: '*' - At least one field in the section contains a value
 ;          ""  - Otherwise
 N DATA,FIELD,FILE,FLDS,FNUM,FPROMPT,IX,LINE,MAXL,NDE,NODE,PCE,VAL
 S:'$D(SIEN) SIEN=""
 S MAXL=0
 ;
 ; First get and array of the fields in the section
 F IX=1:1 D  Q:$P(LINE,";",3)="%END%"
 . S LINE=SECTION_"+"_IX_"^IBTRH5G"
 . S LINE=$T(@LINE)
 . Q:$P(LINE,";",3)="%END%"
 . S FNUM=$P(LINE,";",3),FPROMPT=$P(LINE,";",4)
 . S:$L(FPROMPT)>MAXL MAXL=$L(FPROMPT)
 . S FLDS(IX)=FNUM_"^"_FPROMPT
 ;
 ; Next determine if any of the section's fields contain data
 S DATA="",IX=""
 F  D  Q:(DATA="*")!(IX="")
 . S IX=$O(FLDS(IX))
 . Q:IX=""
 . S FIELD=$P(FLDS(IX),"^",1),NDE=+$P(FIELD,".",1),PCE=$P(FIELD,".",2)
 . S PCE=$S(PCE="1":10,PCE="2":20,PCE="3":30,1:+PCE)
 . I SIEN="" S:$P($G(^IBT(356.22,IBTRIEN,NDE)),"^",PCE)'="" DATA="*"
 . I SIEN'="" S:$P($G(^IBT(356.22,IBTRIEN,16,SIEN,NDE)),"^",PCE)'="" DATA="*"
 Q:DATA="" ""
 I 'DISPLAY Q "*"
 ;
 ; Next display the section and it's values
 W !!,HEADER," contains the following values:",!
 S FILE=$S(SIEN="":356.22,1:356.2216),MAXL=MAXL+3
 S IX=""
 F  D  Q:IX=""
 . S IX=$O(FLDS(IX))
 . Q:IX=""
 . S FIELD=$P(FLDS(IX),"^",1),NDE=+$P(FIELD,".",1)
 . S PCE=$P(FIELD,".",2),PCE=$S(PCE="1":10,PCE="2":20,PCE="3":30,1:+PCE)
 . W !,$P(FLDS(IX),"^",2),": "
 . I SIEN="" S VAL=$P($G(^IBT(356.22,IBTRIEN,NDE)),"^",PCE)
 . I SIEN'="" S VAL=$P($G(^IBT(356.22,IBTRIEN,16,SIEN,NDE)),"^",PCE)
 . W ?MAXL,$$EXTERNAL^DILFD(FILE,FIELD,"",VAL)
 W !
 I (SECTION="SHCRSI")!(SECTION="CMPI")!(SECTION="OCDI")!(SECTION="SHCSD") W !
 Q "*"
 ;
 ; --------------------------   IB CREATE 278 REQUEST Fields   ----------------
 ; Below is a listing of all of the fields in the template that are in 
 ; 'skipable' sections. The comment line of each section = ;;A1;A2;A3;A4 Where:
 ;    A1 - Field number of the section field (1st '.' piece is the storage node
 ;                                            2nd '.' piece is stoarge piece)
 ;    A2 - Prompt used in the Input Template
 ;         NOTE: If this prompt is changed in the Input Template, it must be
 ;               updated here
 ;    A3 - REQ - If field is unconditionally required. "" otherwise
 ;    A4 - Default value (if any)
 ;-----------------------------------------------------------------------------
 ;
HCSD ; Health Care Services Delivery Section fields
 ;;4.01;Service Quantity Qualifier
 ;;4.02;Service Unit Count
 ;;4.03;Sample Selection Units of Measurement
 ;;4.04;Sample Selection Modulus
 ;;4.05;Time Period Qualifier
 ;;4.06;Period Count
 ;;4.07;Delivery Frequency Code
 ;;4.08;Delivery Pattern Time
 ;;%END%
AMBTI ; Ambulance Transport Information fields
 ;;18.02;Patient Weight
 ;;18.01;Patient Weight Units
 ;;18.03;Transport Code;REQ
 ;;18.04;Transport Reason Code
 ;;18.06;Transport Distance
 ;;18.09;Round Trip Purpose Description
 ;;18.1;Stretcher Purpose Description
 ;;%END%
SPMSI ; Spinal Manipulation Service Information
 ;;7.05;Treatment Series #
 ;;7.06;Treatment Count
 ;;7.07;Subluxation Level #1
 ;;7.08;Subluxation Level #2
 ;;7.09;Patient Condition;REQ
 ;;7.1;Complication Indicator;REQ;N
 ;;7.11;Patient Condition Description Line 1
 ;;7.12;Patient Condition Description Line 2
 ;;7.13;X-Ray Availability Indicator;;N
 ;;%END%
HOTI ; Home Oxygen Therapy Information
 ;;8.01;Oxygen Equipment Type #1;REQ
 ;;8.02;Oxygen Equipment Type #2
 ;;8.03;Oxygen Equipment Type #3
 ;;8.04;Equipment Reason Description
 ;;8.05;Oxygen Flow Rate;REQ
 ;;8.06;Daily Oxygen Use Count
 ;;8.07;Oxygen User Period Hour Count
 ;;8.08;Repiratory Therapist Order Text
 ;;9.01;Arterial Blood Gas Quantity
 ;;9.02;Oxygen Saturation Quantity
 ;;9.03;Oxygen Test Condition
 ;;9.04;Oxygen Test Findings #1
 ;;9.05;Oxygen Test Findings #2
 ;;9.06;Oxygen Test Findings #3
 ;;9.07;Portable Oxygen System Flow Rate
 ;;9.08;Oxygen Delivery System;REQ
 ;;%END%
HHCI ; Home Health Care Information
 ;;2.15;Prognosis
 ;;10.01;Home Health Start Date;REQ
 ;;10.02;Home Health Cert. Start Date
 ;;10.03;Home Health Cert. End Date;REQ
 ;;10.05;Surgery Date
 ;;10.06;Procedure Coding Method
 ;;10.07;Surgical Procedure
 ;;10.08;Physician Verbal Order Date
 ;;10.09;Last Visit Date
 ;;10.1;Physician/Home Health Contact Date
 ;;10.11;Start Date of Last Admission
 ;;10.12;End Date of Last Admission
 ;;10.13;Last Admission Facility
 ;;%END%
SHCRSI ; Service HCRS Information
 ;;.15;  Request Category
 ;;.02;  Service Certification Type
 ;;.03;  Service Type
 ;;.06;  Service Location of Care
 ;;.07;  Service Bill Classification;REQ
 ;;.05;  Place of Service
 ;;%END%
CMPI ; Composite Medical Procedure Information
 ;;1.01;  Procedure Coding Method;REQ
 ;;1.02;  Procedure Code;REQ
 ;;1.03;  Ending Procedure Code
 ;;1.04;  Procedure Modifier #1
 ;;1.05;  Procedure Modifier #2
 ;;1.06;  Procedure Modifier #3
 ;;1.07;  Procedure Modifier #4
 ;;1.08;  Procedure Description
 ;;%END%
OCDI ; Oral Cavity Designation Information
 ;;3.01;  Oral Cavity Designation #1;REQ
 ;;3.02;  Oral Cavity Designation #2
 ;;3.03;  Oral Cavity Designation #3
 ;;3.04;  Oral Cavity Designation #4
 ;;3.05;  Oral Cavity Designation #5
 ;;%END%
SHCSD ; Service Line Health Care Services Delivery
 ;;5.01;  Service Quantity Qualifier
 ;;5.02;  Service Unit Count
 ;;5.03;  Sample Selection Units of Measurement
 ;;5.04;  Sample Selection Modulus
 ;;5.05;  Time Period Qualifier
 ;;5.06;  Period Count
 ;;5.07;  Delivery Frequency Code
 ;;5.08;  Delivery Pattern Time
 ;;%END%
AEREL  ; Accident Relation Information
 ;;2.08;Related Causes #1
 ;;2.09;Related Causes #2
 ;;2.1;Related Causes #3
 ;;2.11;Auto Accident State
 ;;2.12;Auto Accident Country
 ;;2.18;Accident Date
 ;;%END%
