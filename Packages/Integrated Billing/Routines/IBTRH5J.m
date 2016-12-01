IBTRH5J ;ALB/JWS - HCSR Create 278 Request ;11-DEC-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; REQMISS      - Checks for missing required fields in a request 
 ;-----------------------------------------------------------------------------
 Q
 ;
REQMISS ; Additional required field checking for 278 transaction
 ; Input:   CTC         - Certification Type Code IEN
 ;          IENS        - IEN_"," of the entry being checked
 ;          IBTRIEN     - IEN of the entry being checked
 ;          MISSING()   - Current array of missing fields
 ; Output:  MISSING()   - Updated array of missing fields
 N ACERT,ACOND,ADMIT,AMBCERT,AMBCOND,CHCERT,CHCOND
 N DIR,DIROUT,DIRUT,DMECERT,DMECOND,DTOUT,DUOUT,ED,FLCERT,FLCOND,HCSDQ,HCSDCT
 N I,MCERT,MCOND,OE1,OE2,OE3,OXYCERT,OXYCOND,PL,PW,SD,SPC,SPCT,TC,TD,TSN,TUM
 N WU,X,XX,Y,YY
 ;
 I $$GET1^DIQ(356.22,IENS,2.08)="",$$GET1^DIQ(356.22,IENS,2.09)'="" D  ; Related Causes Code #1 is required if #2 has value
 . D MISSING(2.08,"Related Causes #1 is required if Related Causes #2 has a value.")
 ;
 I $$GET1^DIQ(356.22,IENS,2.09)="",$$GET1^DIQ(356.22,IENS,2.1)'="" D  ; Related Causes Code #2 is required if #3 has value
 . D MISSING(2.09,"Related Causes #2 is required if Related Causes #3 has a value.")
 ;
 I CTC=1,$$GET1^DIQ(356.22,IENS,2.13)="" D  ; Level of Service is required if Cert Type Code = 1 Immediate Appeal
 . D MISSING(2.13,"Level of Service is required if Certification Type Code is Appeal - Immediate.")
 ;
 S HCSDQ=$$GET1^DIQ(356.22,IENS,4.01),HCSDCT=$$GET1^DIQ(356.22,IENS,4.02)
 I HCSDQ="",HCSDCT'="" D  ; HCSD Quantity Qualifier is required if HCSD Service Unit Count
 . D MISSING(4.01,"HCSD Quantity Qualifier is required if HCSD Service Unit Count has a value.")
 I HCSDQ'="",HCSDCT="" D  ; HCSD Service Unit Count is required if Qualifer exists
 . D MISSING(4.02,"HCSD Service Unit Count is required if the HCSD Quantity Qualifier has a value.")
 ;
 I $$GET1^DIQ(356.22,IENS,4.03)="",$$GET1^DIQ(356.22,IENS,4.04)'="" D  ;HCSD Units of Measure is required if Modulus has value
 . D MISSING(4.03,"HCSD Units of Measurement Code is required if the HCSD Sample Selection Modulus has a value.")
 ;
 I $$GET1^DIQ(356.22,IENS,4.05)="",$$GET1^DIQ(356.22,IENS,4.06)'="" D  ;HCSD Time Period Qual is required if Period Count exists
 . D MISSING(4.05,"HCSD Time Period Qualifier is required of HCSD Period Count has a value.")
 ;
 S AMBCERT=$$GET1^DIQ(356.22,IENS,4.09),AMBCOND=$$GET1^DIQ(356.22,IENS,4.1)
 I (AMBCERT=""&(AMBCOND'=""))!(AMBCERT'=""&(AMBCOND="")) D  ;if either AMBULANCE CERT COND or Cond #1 are present, both are required
 . I AMBCERT="" D MISSING(4.09,"Ambulance Certification Condition Indicator is required if Ambulance Condition Indicator has a value.") Q
 . D MISSING(4.1,"Ambulance Condition Indicator is required if the Ambulance Certification Condition Indicator has a value.")
 ;
 S CHCERT=$$GET1^DIQ(356.22,IENS,5.01),CHCOND=$$GET1^DIQ(356.22,IENS,5.02)
 I (CHCERT=""&(CHCOND'=""))!(CHCERT'=""&(CHCOND="")) D  ;if either Chiropractic cert or Cond #1 are present, both are required
 . I CHCERT="" D MISSING(5.01,"Chiropractic Certification Condition is required if the Condition Indicator has a value.") Q
 . D MISSING(5.02,"Chiropractic Condition #1 is required if the Chiropractic Certification Condition indicator has a value.")
 ;
 S DMECERT=$$GET1^DIQ(356.22,IENS,5.07),DMECOND=$$GET1^DIQ(356.22,IENS,5.08)
 I (DMECERT=""&(DMECOND'=""))!(DMECERT'=""&(DMECOND="")) D  ;if either DME Cert or DME Cond are present, both are required
 . I DMECERT="" D MISSING(5.07,"DME Certification Condition Indicator is required if DME Condition Indicator has a value.") Q
 . D MISSING(5.08,"DME Condition #1 is required if DME Certification Condition Indicator has a value.")
 ;
 S OXYCERT=$$GET1^DIQ(356.22,IENS,5.13),OXYCOND=$$GET1^DIQ(356.22,IENS,5.14)
 I (OXYCERT=""&(OXYCOND'=""))!(OXYCERT'=""&(OXYCOND="")) D  ;if either Oxygen Cert or Oxygen Cond are present, both are required
 . I OXYCERT="" D MISSING(5.13,"Oxygen Certification Condition Indicator is required if Oxygen Condition #1 has a value.") Q
 . D MISSING(5.14,"Oxygen Condition #1 is required if Oxygen Certification Indicator has a value.")
 ;
 S FLCERT=$$GET1^DIQ(356.22,IENS,6.01),FLCOND=$$GET1^DIQ(356.22,IENS,6.02)
 I (FLCERT=""&(FLCOND'=""))!(FLCERT'=""&(FLCOND="")) D  ;if either Funct. Limit Cert or Condition #1 are present, both are required
 . I FLCERT="" D MISSING(6.01,"Functional Limitations Certification Indicator is required if Functional Limitations Condition #1 has a value.") Q
 . D MISSING(6.02,"Function Limitations Condition #1 is required if Functional Limitations Certification Indicator has a value.")
 ;
 S ACERT=$$GET1^DIQ(356.22,IENS,6.07),ACOND=$$GET1^DIQ(356.22,IENS,6.08)
 I (ACERT=""&(ACOND'=""))!(ACERT'=""&(ACOND="")) D  ;if either Activities Cert or Condition #1 are present, both are required
 . I ACERT="" D MISSING(6.07,"Activities Certification Condition is required if Activities Condition #1 has a value.") Q
 . D MISSING(6.08,"Activities Condition #1 is required if Activities Certification Condition Indicator has a value.")
 ;
 S MCERT=$$GET1^DIQ(356.22,IENS,6.13),MCOND=$$GET1^DIQ(356.22,IENS,6.14)
 I (MCERT=""&(MCOND'=""))!(MCERT'=""&(MCOND="")) D  ;if either Mental Cert of Mental Condition #1 are present, both are required
 . I MCERT="" D MISSING(6.13,"Mental Status Certification Condition is required if Mental Status Condition #1 has a value.") Q
 . D MISSING(6.14,"Mental Status Condition #1 is required if Mental Status Certification Condition has a value.")
 ;
 S ADMIT=$$GET1^DIQ(356.22,IENS,2.01,"I") I ADMIT S ADMIT=$P($G(^IBT(356.001,ADMIT,0)),"^")
 I ADMIT="AR",$$GET1^DIQ(356.22,IENS,7.01)="" D  ;Admission Type is required if Request Category = 'AR'
 . D MISSING(7.01,"Admission Type is required if the Request Category is 'AR' for Admission Review.")
 ;
 S WU=$$GET1^DIQ(356.22,IENS,18.01),PW=$$GET1^DIQ(356.22,IENS,18.02)
 I (WU=""&(PW'=""))!(WU'=""&(PW="")) D  ;if either Unit of Measurement or Patient Weight have value, then both are required
 . I WU="" D MISSING(18.01,"The Unit or Basis of Measurement Code for Patient Weight is required if a Patient Weight exists.") Q
 . D MISSING(18.02,"If a Unit or Basis of Measurement Code exists for Patient Weight, then a Patient Weight amount is required.")
 ;
 I $$GET1^DIQ(356.22,IENS,18.03)="" D
 . S XX=$G(^IBT(356.22,IBTRIEN,18)) F I=1,2,4:1:10 I $P(XX,"^",I)'="" S XX="BAD" Q
 . I $G(XX)'="BAD" Q
 . D MISSING(18.03,"The Ambulance Transport Code is required if any Ambulance Transport information is to be sent via this 278 Request.")
 ;
 S TUM=$$GET1^DIQ(356.22,IENS,18.05),TD=$$GET1^DIQ(356.22,IENS,18.06)
 I (TUM=""&(TD'=""))!(TUM'=""&(TD="")) D  ;If either Ambulance Distance Unit of Measure or Transport Distance exists, both are required
 . I TUM="" D MISSING(18.05,"Ambulance Distance Unit of Measurement Code is required if a Transport Distance has been entered.") Q
 . D MISSING(18.06,"Ambulance Transport Distance is required if an Ambulance Distance Unit of Measure has been entered.")
 ;
 S TSN=$$GET1^DIQ(356.22,IENS,7.05),TC=$$GET1^DIQ(356.22,IENS,7.06)
 I (TSN=""&(TC'=""))!(TSN'=""&(TC="")) D  ;if either Treatment Series Number or Treatment Count have value, both are required
 . I TSN="" D MISSING(7.05,"Treatment Series Number is required if Treatment Count has a value.") Q
 . D MISSING(7.06,"Treatment Count is required if Treatment Series Number has a value.")
 ;
 I $$GET1^DIQ(356.22,IENS,7.08)'="",$$GET1^DIQ(356.22,IENS,7.07)="" D  ;subluxation level code#1 must have value if code#2 exists
 . D MISSING(7.07,"Subluxation Level Code #1 is required if Subluxation Level Code #2 has a value.")
 ;
 I $$GET1^DIQ(356.22,IENS,7.09)="" D
 . S XX=$G(^IBT(356.22,IBTRIEN,7)) F I=5:1:8,11:1:13 I $P(XX,"^",I)'="" S XX="BAD" Q
 . I XX'="BAD" Q
 . D MISSING(7.09,"Patient Condition Code is required if any Spinal Manipulation Service Information is to be sent via this 278 Request.")
 ;
 I $$GET1^DIQ(356.22,IENS,7.1)="" D
 . S XX=$G(^IBT(356.22,IBTRIEN,7)) F I=5:1:8,11:1:13 I $P(XX,"^",I)'="" S XX="BAD" Q
 . I XX'="BAD" Q
 . D MISSING(7.1,"Complication Indicator is required if any Spinal Manipulation Service Information is to be sent via this 278 Request.")
 ;
 S OE1=$$GET1^DIQ(356.22,IENS,8.01),OE2=$$GET1^DIQ(356.22,IENS,8.02),OE3=$$GET1^DIQ(356.22,IENS,8.03)
 I OE1="",($$GET1^DIQ(356.22,IENS,8.05)'=""!($$GET1^DIQ(356.22,IENS,9.08)'="")!(OE2'="")) D
 . D MISSING(8.01,"Oxygen Equipment Type Code #1 is required if Home Oxygen Therapy information is included in this 278 Request.")
 ;
 I OE2="",OE3'="" D
 . D MISSING(8.02,"Oxygen Equipment Type Code #2 is required if Oxygen Equipment Type Code #3 has a value.")
 ;
 I $$GET1^DIQ(356.22,IENS,8.05)="",(OE1'=""!($$GET1^DIQ(356.22,IENS,9.08)'="")) D
 . D MISSING(8.05,"Oxygen Flow Rate is required if Home Oxygen Therapy information is included in this 278 Request.")
 ;
 I OE1'="",$$GET1^DIQ(356.22,IENS,9.01)="",$$GET1^DIQ(356.22,IENS,9.02)="" D
 . D MISSING(8.01,"If Home Oxygen Therapy information is included in this 278 Request, then either Arterial Blood Gas Quantity or Oxygen Saturation Quantity is required.")
 ;
 I $$GET1^DIQ(356.22,IENS,9.08)="",(OE1'=""!($$GET1^DIQ(356.22,IENS,8.05)'="")) D
 . D MISSING(9.08,"If Home Oxygen Therapy information is included in this 278 Request, then the Oxygen Delivery System Code is required.")
 ;
 I $$GET1^DIQ(356.22,IENS,9.07)="" D
 . I OE1=4!(OE2=4)!(OE3=4)!(OE1=5)!(OE2=5)!(OE3=5) D MISSING(9.07,"Portable Oxygen System Flow is required if Oxygen Equipment Code used is either Liquid Portable or Gaseous Portable.")
 ;
 S ED=$$GET1^DIQ(356.22,IENS,10.03),SD=$$GET1^DIQ(356.22,IENS,10.02)
 I ED'="",SD="" D
 . D MISSING(10.02,"Home Health Certification Period Start Date is required if a Home Health Certification Period End Data is entered.")
 I ED="",SD'="" D
 . D MISSING(10.03,"Home Health Certification Period End Date is required if a Home Health Certification Period Start Date is entered.")
 ;
 S SD=$$GET1^DIQ(356.22,IENS,10.05),SPCT=$$GET1^DIQ(356.22,IENS,10.06),SPC=$$GET1^DIQ(356.22,IENS,10.07)
 I SD="",(SPCT'=""!(SPC'="")) D
 . D MISSING(10.05,"Surgery Date is required if a Surgical Procedure Code or Code Type have a value.")
 I SPCT="",(SD'=""!(SPC'="")) D
 . D MISSING(10.06,"Surgery Procedure Code Type is required if a Surgery Date or Surgery Procedure Code have a value.")
 I SPC="",(SD'=""!(SPCT'="")) D
 . D MISSING(10.07,"Surgery Procedure Code is required if a Surgery Date or Surgery Procedure Code Type have a value.")
 ;
 S SD=$$GET1^DIQ(356.22,IENS,10.11),ED=$$GET1^DIQ(356.22,IENS,10.12),PL=$$GET1^DIQ(356.22,IENS,10.13)
 I SD="",(ED'=""!(PL'="")) D
 . D MISSING(10.11,"Last Admission Start Date is required if the Last Admission End Date is specified or the Patient Location Code has a value.")
 I ED="",SD'="" D
 . D MISSING(10.12,"Last Admission End Date is required if the Last Admission Start Date is specified.")
 I PL="",(ED'=""!(SD'="")) D
 . D MISSING(10.13,"Patient Location Code is required if the Last Admission Start or End Dates are entered.")
 ;
 D REQMISS^IBTRH5K ; Checking Multiples, new routine due to routine size 01/06/15 FA
 Q
 ;
 ;
MISSING(SUB,DESC) ; Function to generate MISSING array
 ; Input: SUB - subscript of MISSING array
 ;        DESC - description of error condition
 ; Returns: MISSING  array
 ;
 S MISSING=MISSING+1
 S MISSING(SUB)=DESC
 Q
