MAGDSTA3 ;WOIFO/PMK - Study Tracker - Query/Retrieve user patient lookup ; Jun 01, 2020@12:10:06
 ;;3.0;IMAGING;**231**;Mar 19, 2002;Build 9;Feb 27, 2015
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; API's and RPC'S for MAGDSTQA VistA PII lookup routine
 ;
 ; Supported IA #3646  reference $$EMPL^DGSEC4 function call
 ; Supported IA #767 Reading DG SECURITY LOG ^DGSL(38.1,DFN,0) 
 ; Supported IA #2051 reference FIND^DIC subroutine call
 ; Supported IA #2054 reference CLEAN^DILF subroutine call
 ; Supported IA #10061 reference DEM^VADPT subroutine call
 ; Supported IA #10035 for Fileman reads of ^DPT
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #2602 Reading AUDIT file (#1.1) ^DIA(2,...)
 ; Supported IA #3065 reference $$HLNAME^XLFNAME function call 
 ;
 Q
 ;
PATLKUP(OUTPUT,INPUT) ; RPC = MAG DICOM PATIENT LOOKUP
 ; patient lookup
 ; modified from FINDP^SCUTBK11 for SC PATIENT LOOKUP rpc
 ; 
 ;   INPUT = value to lookup
 ;     Lookup uses multiple index lookup of File #2
 ;     
 ;   OUTPUT = data
 ;     OUTPUT(0) = number of records
 ;     for i=1:number of records returned: 
 ;      DFN^patient name^DOB^PID^SEX^DOD^Sensitive
 ;       1        2       3   4   5   6      7
 ;       
 ;       (DOD = Date of Death)
 ;       
 K OUTPUT
 D FIND^DIC(2,,".01;.03;.363;.09;.02;.351","PS",INPUT,300,"B^BS^BS5^SSN")
 I $G(DIERR) D CLEAN^DILF Q
 N SCOUNT S SCOUNT=+^TMP("DILIST",$J,0)
 N SC F SC=1:1:SCOUNT D
 . N NODE,DASHSSN,DFN,DOB,DOD,NAME,PID,PRILONGID,SENSITIVE,SEX,SSN
 . S NODE=^TMP("DILIST",$J,SC,0)
 . ; IEN^NAME^DOB^Primary Long ID^SSN^SEX^DOD
 . ;  1   2    3        4          5   6   7
 . S DFN=$P(NODE,"^",1),NAME=$P(NODE,"^",2)
 . S DOB=$P(NODE,"^",3),DOD=$P(NODE,"^",4)
 . S SSN=$P(NODE,"^",5),SEX=$P(NODE,"^",6)
 . S DASHSSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,11)
 . S PRILONGID=$P(NODE,"^",4)
 . I $E(SSN,1,9)'?9N S (DASHSSN,PRILONGID)=SSN
 . S PID=$S($L(PRILONGID)>5:PRILONGID,1:DASHSSN)
 . D SCREEN(.SENSITIVE,DFN)
 . D SAVEINFO^MAGDSTQA(.OUTPUT,DFN,NAME,DOB,PID,SEX,DOD,SENSITIVE)
 . Q
 S OUTPUT(0)=SCOUNT
 K ^TMP("DILIST",$J)
 Q
 ;
SCREEN(SCREEN,DFN) ; RPC = MAG DICOM GET PT SENSITIVITY
 ; Screening logic sensitive patients
 ; Input  : DFN - Pointer to PATIENT file (#2)
 ; Output : 0 - Don't apply screen
 ;          1 - Apply screen - sensitive patient
 ;          2 - Apply screen - employee
 ; Notes  : Screen applied if patient is sensitive or an employee
 ;
 N DGTIME,DGT,DGA1,DG1,DGXFR0
 ; Sensitive - screen
 I $P($G(^DGSL(38.1,DFN,0)),"^",2) S SCREEN=1 Q
 ; Employee - screen
 I $$EMPL^DGSEC4(DFN) S SCREEN=2 Q
 ;Don't screen
 S SCREEN=0
 Q
 ;
 ;
 ;
HISTLKUP(PII,DFN) ; RPC = MAG DICOM PATIENT HISTORY
 ; look up historical patient changes in the audit archive
 ;   INPUT = value to lookup
 ;     Lookup uses multiple index lookup of File #2
 ;     
 ;   OUTPUT = data
 ;     OUTPUT(0) = number of records
 ;     for i=1:number of records returned: 
 ;      DFN^Patient Name^DOB^PID^SEX^DOD^Sensitive^Changed Field^Change date & time
 ;       1        2       3   4   5   6      7           8              9
 ;       
 ;       (DOD = Date of Death; DOD and Sensitive are null)
 ;
 N DOB,NAME,SEX,SSN,VA,VADM,VAERR,X
 N DATETIME ; date and time of the SSN change
 N DIAIEN ; ien of the record in the AUDIT file (#1.1)
 N FIELDNUMBER ; SSN is field .09 in the PATIENT file (#2)
 N FIELD ; name of MUMPS FIELD holding the field data
 N OLD,NEW ; previous and new field value
 ;
 K PII S PII(0)=0
 ; save current PII
 D DEM^VADPT
 S NAME=VADM(1)
 S SSN=$P(VADM(2),"^",2) ; with dashes
 S DOB=$P(VADM(3),"^",1),DOB=$$FMTE^XLFDT(DOB,"5Z") ; MM/DD/YYYY format
 I DOB?1"00/00/"4N S $P(NODE,"^",3)=$E(DOB,7,10) ; only year
 S SEX=$P(VADM(5),"^",2)
 D SAVEINFO^MAGDSTQA(.PII,DFN,NAME,DOB,SSN,SEX,,,,"(todayCC)") ; CC is not displayed
 ;
 ; save PII changes
 S DIAIEN="" F  S DIAIEN=$O(^DIA(2,"B",DFN,DIAIEN),-1) Q:DIAIEN=""  D
 . S X=$G(^DIA(2,DIAIEN,0))
 . S CHANGEDATE=$P(X,"^",2),FIELDNUMBER=$P(X,"^",3)
 . S NEW=$G(^DIA(2,DIAIEN,2)),OLD=$G(^DIA(2,DIAIEN,3))
 . I FIELDNUMBER=.01 S CHANGED="NAME" ; name change record
 . E  I FIELDNUMBER=.02 S CHANGED="SEX" ;  sex change record
 . E  I FIELDNUMBER=.03 S CHANGED="DOB" ;  dob change record
 . E  I FIELDNUMBER=.09 S CHANGED="SSN" D  ;  SSN change record
 . . S OLD=$E(OLD,1,3)_"-"_$E(OLD,4,5)_"-"_$E(OLD,6,10) ; remember "P"
 . . S NEW=$E(NEW,1,3)_"-"_$E(NEW,4,5)_"-"_$E(NEW,6,10) ; remember "P"
 . . Q
 . E  Q  ; other field
 . I OLD'=@CHANGED W !?10,"Old ",CHANGED," not matching: ",OLD," to ",@CHANGED
 . S @CHANGED=NEW
 . D SAVEINFO^MAGDSTQA(.PII,DFN,NAME,DOB,SSN,SEX,,,CHANGED,CHANGEDATE)
 . Q
 Q
 ;
DCMNAME(OUT,DFN) ; RPC = MAG DICOM FORMAT PATIENT NAME
 ; get properly formatted DICOM patient name
 ; HL7:   family ^ given ^ middle ^ suffix ^ prefix ^ degree
 ; DICOM: family ^ given ^ middle ^ prefix ^ suffix (4 & 5 swapped, no degree)
 N DGNAME,DICOMNAME,HL7NAME
 K OUT
 I '$G(DFN) S OUT="-1,No Patient Identified" Q
 S DGNAME("FILE")=2,DGNAME("IENS")=DFN,DGNAME("FIELD")=.01
 S HL7NAME=$$HLNAME^XLFNAME(.DGNAME,"","^") ; get HL7 formatted name
 I HL7NAME="" S OUT="-2,No patient found with DFN="_DFN Q
 ; convert to DICOM format by swapping 4th and 5th components
 S DICOMNAME=$P(HL7NAME,"^",1,3) ; family ^ given ^ middle
 S $P(DICOMNAME,"^",4)=$P(HL7NAME,"^",5) ; prefix (e.g., DR)
 S $P(DICOMNAME,"^",5)=$P(HL7NAME,"^",4) ; suffix (e.g., JR or III)
 S OUT=DICOMNAME
 Q
 ;
ANPREFIX(OUT) ; RPC = MAG DICOM GET ACN PREFIX
 ; Get the value of the accession number prefix
 S OUT=$$ANPREFIX^MAGDSTAB
 Q
 ;
DASHES(OUT) ; RPC = MAG DICOM GET PT ID DASHES
 ; Get the value of the patient identifier dashes
 S OUT=$$DASHES^MAGDSTAB
 Q
