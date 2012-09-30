DGENPTA ;ALB/CJM,ERC,CKN,TDM,PWC - Patient API - Retrieve Data ; 5/25/11 4:25pm
 ;;5.3;Registration;**121,122,147,688,754,838,841,842**;Aug 13,1993;Build 33
 ;
VET(DFN) ;returns 1 if the patient is an eligible veteran
 ;returns 0 if not a veteran or not eligible
 ;
 N VET S VET=0
 I $G(DFN),$D(^DPT(DFN,0)) D
 .S VET=1
 .I $P($G(^DPT(DFN,"VET")),"^")="N" S VET=0
 .I $P($G(^DPT(DFN,.15)),"^",2) S VET=0
 Q VET
 ;
VET1(DFN) ;returns 1 if the patient is a veteran
 ;returns 0 if not a veteran
 ;
 N VET S VET=0
 I $G(DFN),$D(^DPT(DFN,0)) D
 .I $P($G(^DPT(DFN,"VET")),"^")="Y" S VET=1
 Q VET
 ;
ACTIVE(DFN,DGDT) ;
 ;Description - Used to determine whether or not the patient has had a
 ;  recent epiosode of inpatient or outpatient care.
 ;Input:
 ;  DFN - ien of record in Patient file
 ;  DGDT - date used to specify how far back to go looking for episode
 ;      of care
 ;Output -
 ;  returns 1 if recent episode of care, 0 otherwise
 ;
 ;!!!!!!! NOTE: This routine is not complete. !!!!!!!!!!!!!!!
 ; Still need to define how user wants to define an 'active' patient.
 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 ;
 Q 1
 ;
PREF(DFN,FACNAME) ;
 ;Description: Used to determine the patient's preferred facility.
 ;Input:
 ;  DFN - an ien of a record in the PATIENT file
 ;Output:     
 ;  Function Value - Returns a pointer to the INSTITUTION file entry that
 ;    is the patient's preferred facility, NULL if the preferred facility
 ;    can not be determined.
 ;  FACNAME - optional parm, pass by reference - returns institution name
 ;
 N FAC
 S (FACNAME,FAC)=""
 I $D(DFN),$D(^DPT(DFN,0)) S FAC=$P($G(^DPT(DFN,"ENR")),"^",2)
 S:FAC FACNAME=$P($G(^DIC(4,FAC,0)),"^")
 Q FAC
 ;
DEATH(DFN) ;
 ;Description: Used to determine whether or not the patient is alive.
 ;Input:
 ;  DFN - an ien of a record in the PATIENT file
 ;Output:     
 ;  Function Value - Returns 0 if there is no record of the patient's
 ;    death, otherwise returns the patients date of death
 ;
 N DATE S DATE=0
 I $D(DFN),$D(^DPT(DFN,0)) S DATE=$P($G(^DPT(DFN,.35)),"^")
 I DATE S DATE=(DATE\1) ;get rid of the time portion
 Q +DATE
 ;
GET(DFN,DGPAT) ;
 ;Description: Returns DGPAT() array with identifying info for patient
 ;  Input:
 ;    DFN - ien, PATIENT file
 ;  Output:
 ;    Function Value - 1 on success, 0 on failure
 ;    DGPAT() array (pass by reference)
 ;      "DEATH" - date of death
 ;      "DFN" - ien, PATIENT file
 ;      "DOB" - date of birth
 ;      "INELDATE" - INELIGIBLE DATE
 ;      "INELREA" - INELIGIBLE REASON
 ;      "INELDEC" - INELIGIBLE VARO DECISION
 ;      "NAME" - patient name
 ;      "PATYPE" - patient type
 ;      "PID" - Primary Long ID
 ;      "PREFAC" - preferred facility
 ;      "PFSRC" - preferred facility source designation
 ;      "SSN" - Social Security Number
 ;      "SEX" - M=male, F=female
 ;      "VETERAN" - VETERAN (Y/N)? - "Y"=YES,"N"=NO
 ;      "AG/ALLY" - Agency/Allied Country
 ;      "SPININJ" - Spinal Cord Injury
 ;      "MOH" - Medal of Honor
 ;      "PENAEFDT" - Pension Award Effective Date
 ;      "PENTRMDT" - Pension Terminated Date
 ;      "PENAREAS" - Pension Award Reason
 ;      "PENTRMR1" - Pension Terminated Reason 1
 ;      "PENTRMR2" - Pension Terminated Reason 2
 ;      "PENTRMR3" - Pension Terminated Reason 3
 ;      "PENTRMR4" - Pension Terminated Reason 4
 ;      "DENTC2IN" - Class II Dental Indicator - "Y"=YES,"N"=NO
 ;      "DENTC2DT" - Dental Appl Due Before Date
 ;      "PILOCK"   - Pension Indicator Lock
 ;      "PALOCK"   - Pension Award Lock
 ;
 N NODE
 Q:'$G(DFN) 0
 K DGPAT S DGPAT=""
 S DGPAT("DFN")=DFN
 S NODE=$G(^DPT(DFN,0))
 Q:NODE="" 0
 S DGPAT("NAME")=$P(NODE,"^")
 S DGPAT("DOB")=$P(NODE,"^",3)
 S DGPAT("SEX")=$P(NODE,"^",2)
 S DGPAT("SSN")=$P(NODE,"^",9)
 ;
 S DGPAT("DEATH")=$P($G(^DPT(DFN,.35)),"^")
 S DGPAT("PATYPE")=$P($G(^DPT(DFN,"TYPE")),"^")
 S DGPAT("VETERAN")=$P($G(^DPT(DFN,"VET")),"^")
 S DGPAT("PREFAC")=$P($G(^DPT(DFN,"ENR")),"^",2)
 S DGPAT("PFSRC")=$P($G(^DPT(DFN,"ENR")),"^",3)
 S DGPAT("INELDATE")=$P($G(^DPT(DFN,.15)),"^",2)
 S DGPAT("INELREA")=$P($G(^DPT(DFN,.3)),"^",7)
 S DGPAT("INELDEC")=$P($G(^DPT(DFN,"INE")),"^",6)
 S DGPAT("PID")=$P($G(^DPT(DFN,.36)),"^",3)
 S DGPAT("AG/ALLY")=$P($G(^DPT(DFN,.3)),"^",9)
 S DGPAT("SPININJ")=$P($G(^DPT(DFN,57)),"^",4)
 S DGPAT("MOH")=$P($G(^DPT(DFN,.54)),"^",1)
 ;
 S NODE=$G(^DPT(DFN,.385))
 S DGPAT("PENAEFDT")=$P(NODE,"^")
 S DGPAT("PENAREAS")=$P(NODE,"^",2)
 S DGPAT("PENTRMDT")=$P(NODE,"^",3)
 S DGPAT("PENTRMR1")=$P(NODE,"^",4)
 S DGPAT("PENTRMR2")=$P(NODE,"^",5)
 S DGPAT("PENTRMR3")=$P(NODE,"^",6)
 S DGPAT("PENTRMR4")=$P(NODE,"^",7)
 S DGPAT("DENTC2IN")=$P(NODE,"^",8)
 S DGPAT("DENTC2DT")=$P(NODE,"^",9)
 S DGPAT("PILOCK")=$P(NODE,"^",10)
 S DGPAT("PALOCK")=$P(NODE,"^",11)
 Q 1
 ;
SSN(DFN) ;
 ;Description: Function returns the patient's SSN, or "" on failure.
 ;
 Q:'DFN ""
 Q $P($G(^DPT(DFN,0)),"^",9)
 ;
NAME(DFN) ;
 ;Description: Function returns the patient's NAME, or "" on failure.
 ;
 Q:'DFN ""
 Q $P($G(^DPT(DFN,0)),"^")
 ;
EXT(SUB,VAL) ;
 ;Description: Given the subscript used in the PATIENT object array,
 ;   DGPAT(), and a field value, returns the external representation of
 ;   the value, as defined in the fields output transform of the PATIENT
 ;   file.
 ;Input: 
 ;  SUB - array subscript
 ;  VAL - field value
 ;Output:
 ;  Function Value - returns the external value of the field
 ;
 Q:(($G(SUB)="")!($G(VAL)="")) ""
 ;
 N FLD
 S FLD=$$FIELD^DGENPTA1(SUB)
 Q:(FLD="") ""
 Q $$EXTERNAL^DILFD(2,FLD,"F",VAL)
 ;
 ;
VALPAT(DFN) ; --
 ; Description: This function returns a 1 if the patient DFN is valid, 0 if the patient DFN is not valid.
 ;
 ;  Input:
 ;    DFN - as pointer to patient in Patient (#2) file
 ;
 ; Output:
 ;   Function Value - Is patient (DFN) valid?
 ;                    Return 1 if successful, otherwise 0
 ;
 ; init variables
 N DGVALID S DGVALID=0
 ;
 ; is patient (DFN) valid?
 I $G(DFN),$D(^DPT(DFN,0)) S DGVALID=1
 ;
 Q DGVALID
 ;
 ;
CURINPAT(DFN) ; --
 ; Description: This function will determine if the patient is a current inpatient.
 ;
 ;  Input:
 ;    DFN - IEN of record in Patient (#2) file
 ;
 ; Output:
 ;   Function Value - Is patient a current inpatient? 
 ;                    Return 1 if successful, otherwise 0
 ;
 N DGCUR S DGCUR=0
 ;
 ; if valid patient, check if current inpatient
 I $$VALPAT(DFN) D
 .;
 .; is patient a current inpatient?
 .I $G(^DPT(DFN,.105)) S DGCUR=1
 ;
 Q DGCUR
 ;
 ;
INPAT(DFN,DGBEG,DGEND) ; --
 ; Description: This function will determine if a patient was an inpatient between a specified date range.
 ;
 ;  Input:
 ;       DFN - IEN of record in Patient (#2) file
 ;    DGBEG - as begin date/time for inpatient search
 ;    DGEND - as end date/time for inpatient search
 ;
 ; Output:
 ;   Function Value - Was patient an inpatient between date range?
 ;                    Return 1 if successful, otherwise 0
 ;
 N DGINPAT,DGSDT,DGEDT,DGMOVE,DGTRANS
 S DGINPAT=0
 ;
 ; if not valid patient (DFN) and not valid date range, exit
 I '$$VALPAT(DFN),'($$RANGE(DGBEG,DGEND)) G INPATQ
 ;
 ; init date/time(s)
 S DGSDT=DGBEG-.0001,DGEDT=DGEND+$S($P(DGEND,".",2)="":.2359,1:"")
 ;
 ; use "APRD" x-ref of Patient Movement (#405) file
 F  S DGSDT=$O(^DGPM("APRD",+DFN,DGSDT)) Q:'DGSDT!(DGSDT>DGEDT)!(DGINPAT)  D
 .S DGMOVE=0 F  S DGMOVE=$O(^DGPM("APRD",+DFN,DGSDT,DGMOVE)) Q:'DGMOVE!(DGINPAT)  D
 ..; - transaction type of movement
 ..S DGTRANS=$P($G(^DGPM(DGMOVE,0)),"^",2)  ; movement transaction type
 ..; - if trans type not DISCHARGE, CHECK-IN LODGER, CHECK-OUT LODGER
 ..I DGTRANS'=3,(DGTRANS'=4),(DGTRANS'=5) S DGINPAT=1
 ;
INPATQ Q DGINPAT
 ;
 ;
OUTPAT(DFN,DGBEG,DGEND) ; --
 ; Description: This function will determine if a patient has an outpatient encounter between a specified date range that has successfully been checked out.
 ;
 ;  Input:
 ;       DFN - IEN of record in Patient (#2) file
 ;    DGBEG - as begin date/time for outpatient search
 ;    DGEND - as end date/time for outpatient search
 ;
 ; Output:
 ;   Function Value - Does patient have outpatient encounter between date
 ;                    range that that has successfully been checked out?
 ;                    Return 1 if successful, otherwise 0
 ;
 N DGOUT,DGSDT,DGEDT,DGOE
 S DGOUT=0
 ;
 ; if not valid patient (DFN) and not valid date range, exit
 I '$$VALPAT(DFN),'($$RANGE(DGBEG,DGEND)) G OUTPATQ
 ;
 ; init date/time(s)
 S DGSDT=DGBEG-.0001,DGEDT=DGEND+$S($P(DGEND,".",2)="":.2359,1:"")
 ;
 ; use "ADFN" x-ref of Outpatient Encounter (#409.68) file
 F  S DGSDT=$O(^SCE("ADFN",+DFN,DGSDT)) Q:'DGSDT!(DGSDT>DGEDT)!(DGOUT)  D
 .;
 .S DGOE=0 F  S DGOE=$O(^SCE("ADFN",+DFN,DGSDT,DGOE)) Q:'DGOE!(DGOUT)  D
 ..; - if encounter checked out, set flag
 ..I $P($G(^SCE(+DGOE,0)),"^",7) S DGOUT=1
 ;
OUTPATQ Q DGOUT
 ;
 ;
RANGE(DGBEG,DGEND) ; --
 ; Description: This function returns a 1 if two dates are a valid date range, 0 if they are not valid.
 ;
 ;  Input:
 ;    DGBEG - as begin date of date range
 ;    DGEND - as end date of date range
 ;
 ; Output:
 ;   Function Value - Is date range valid?
 ;                    Return 1 if successful, otherwise 0
 ;
 N DGOK
 ;
 S DGOK=0
 ;
 ; if input parameters not defined, exit
 I '$D(DGBEG),('$D(DGEND)) G RANGEQ
 ;
 ; remove time from dates
 S DGBEG=(DGBEG/1),DGEND=(DGEND/1)
 ;
 ; if begin date greater than end date, exit
 I DGBEG>DGEND G RANGEQ
 ;
 ; if begin date and end date future dates, exit
 I DGBEG>DT,(DGEND>DT) G RANGEQ
 ;
 S DGOK=1
 ;
RANGEQ Q DGOK
 ;
LOOKUP(SSN,DOB,SEX,ERROR) ;
 ;Description: This function will do a search for the patient based on
 ;the identifying information provided. The function will be successful
 ;only if a single patient is found matching the identifiers provided.
 ;
 ;Inputs:
 ;  SSN - patient Social Security Number
 ;  DOB - patient date of birth (FM format)
 ;  SEX - patient sex
 ;Outputs:
 ;  Function Value - patient DFN if successful, 0 otherwise
 ;  ERROR - if unsuccessful, an error message is returned (optional, pass by reference)
 ;
 N DFN,NODE
 ;
 I $G(SSN)="" S ERROR="INVALID SSN" Q 0
 S DFN=$O(^DPT("SSN",SSN,0))
 I 'DFN S ERROR="SSN NOT FOUND" Q 0
 I $O(^DPT("SSN",SSN,DFN)) S ERROR="MULTIPLE PATIENTS MATCHING SSN" Q 0
 S NODE=$G(^DPT(DFN,0))
 I $P(NODE,"^",2)'=SEX S ERROR="SEX DOES NOT MATCH" Q 0
 I $E($P(NODE,"^",3),1,3)'=$E(DOB,1,3) S ERROR="DOB DOES NOT MATCH" Q 0
 I $E($P(NODE,"^",3),4,5),$E($P(NODE,"^",3),4,5)'=$E(DOB,4,5) S ERROR="DOB DOES NOT MATCH" Q 0
 Q DFN
