IVMZ07C ;BAJ/PHH - HL7 Z07 CONSISTENCY CHECKER -- DRIVER ROUTINE ; 1/17/2008
 ;;2.0;INCOME VERIFICATION MATCH;**105,128,134**;JUL 8,1996;Build 1
 ;
 ; 
 ; This routine calls various checking subroutines and manages arrays and data filing
 ; for inconsistency checking prior to building a Z07 HL7 record.  This routine returns
 ; a value and must be called as an API:
 ; 
 ; I '$$EN^IVMZ07C(DFN) Q
 ;
 ; Values returned:
 ; 0 = Fail: inconsistencies found, do not build Z07 record
 ; 1 = Pass: No inconsistencies found, Ok to build Z07 record
 ;
 ; Must be called from entry point
 Q
 ;
EN(DFN) ; entry point.  Patient DFN is sent from calling routine.
 ; initialize working variables
 N PASS,DGP,DGSD,U
 S U="^"
 ; 
 ; Input:        DFN     = ^DPT(DFN) of record to check
 ;                       BATCH   = 1     batch/background job records should be counted
 ;                                       = 0     single job, do not count records
 ; structure:
 ; 1. delete existing Z07 inconsistencies
 ; 2. load data arrays
 ; 3. call subroutines
 ; 4. check for Pass/Fail
 ; 5. update file 38.5 if necessary
 ; 6. return Pass/Fail
 ; 
 ; Set flag
 S PASS=0
 I '$D(^DPT(DFN)) Q PASS
 S PASS=1
 ;
 ; Load Patient and Spouse/dependent data
 D LOADPT(DFN,.DGP),LOADSD^IVMZ072(DFN,.DGSD)
 ;
 ; Do checks and file inconsistencies
 D WORK(DFN,.DGP,.DGSD)
 ;
 ; Delete old Inconsistency info
 D DELETE(DFN)
 ;
 ; File new inconsistencies if necessary
 I $$FILE(DFN) S PASS=0
 ;
 ; update counters
 D COUNT(PASS)
 ;
 ; return pass/fail flag
 Q PASS
 ;
COUNT(PASS) ; counter for batch run
 N I
 ; Set it up the first time through
 I '$D(^TMP($J,"CC")) D
 . F I=0,1 S ^TMP($J,"CC",I)=0
 ;
 ; Increment Batch counter
 S ^TMP($J,"CC",PASS)=^TMP($J,"CC",PASS)+1
 Q
 ;
LOADPT(DFN,DGP) ; load patient data into arrays
 N NIEN,IEN,I,DTTM,NAMCOM,NAME
 ; we need to load data from the following files
 ; Patient File                          2
 ; Name Components                       20
 ; Patient Enrollment                    27.11
 ; Means test file                       408.31
 ; MST History file                      29.11
 ; Note: we also need Catastrophic data info, but that subroutine loads its own data array.
 ; 
 ; ***************************
 ; DGP("PAT") Patient file
 F I=0,.3,.15,.29,.31,.32,.321,.322,.35,.36,.361,.38,.52,"SSN","TYPE","VET" S DGP("PAT",I)=$G(^DPT(DFN,I))
 S NAME=$P($G(^DPT(DFN,0)),"^",1),NAMCOM=$P($G(^DPT(DFN,"NAME")),"^",1)'=""
 ; 
 ; ***************************
 ; DGP("NAME") Name Components
 I NAMCOM S NIEN=$P(^DPT(DFN,"NAME"),U,1) I '$D(^VA(20,NIEN,1)) S NAMCOM=0
 S DGP("NAME",1)=$S(NAMCOM:$G(^VA(20,NIEN,1)),1:$P(NAME,",")_"^"_$P($P(NAME,",",2)," ",1)_"^"_$P($P(NAME,",",2)," ",2))
 ;
 ; ***************************
 ;
 ; DGP("ENR") Patient Enrollment
 S NIEN="",NIEN=$P($G(^DPT(DFN,"ENR")),U,1)
 I NIEN]"",$D(^DGEN(27.11,NIEN)) M DGP("ENR")=^DGEN(27.11,NIEN)
 ; 
 ; ***************************
 ; DGP("MEANS") Means Test
 S NIEN=+$$LST^DGMTU(DFN) I NIEN,$D(^DGMT(408.31,NIEN,0)) S DGP("MEANS",0)=^DGMT(408.31,NIEN,0)
 ;
 ; ***************************
 ; DGP("MST") MST History
 S (DTTM,NIEN)=""
 S DTTM=$O(^DGMS(29.11,"APDT",DFN,""),-1)
 I DTTM'="" D
 . S NIEN=$O(^DGMS(29.11,"APDT",DFN,DTTM,""),-1)
 . I $D(^DGMS(29.11,NIEN,0)) S DGP("MST",0)=^DGMS(29.11,NIEN,0)
 ;
 ; ***************************
 Q
 ;
WORK(DFN,DGP,DGSD) ;
 ; call subroutines to run rules and file any inconsistencies
 ;
 ; Demographics rules
 D EN^IVMZ7CD(DFN,.DGP,.DGSD)
 ;
 ; Enrollment/Eligibility rules
 D EN^IVMZ7CE(DFN,.DGP)
 ;
 ; Service rules
 D EN^IVMZ7CS(DFN,.DGP)
 ;
 ; Catastrophic Disability rules
 D EN^IVMZ7CCD(DFN)
 ;
 ; Registration Inconsistencies
 D EN^IVMZ7CR(DFN,.DGP,.DGSD)
 ;
 Q
 ;
DELETE(DFN) ; delete all Z07 inconsistencies from INCONSISTENT DATA file (#38.5).  Since we're not sure which rules
 ; will block a Z07 record, we need to loop through the INCONSISTENT DATA ELEMENTS file (#38.6) and grab only 
 ; those rules which are marked to prevent building a Z07 record:
 ; 
 ;
 N DELARRY,RULE,DIK,DA
 ; 
 ; create an array of rules which prevent Z07 records 
 S RULE=0 F  S RULE=$O(^DGIN(38.6,RULE)) Q:RULE=""  Q:$A(RULE)>$A(9)  D
 . I $P(^DGIN(38.6,RULE,0),U,6) S DELARRY(RULE)=""
 ;
 ; Now we have to check the patient INCONSISTENT DATA file (#38.5) and delete any records which have to be rechecked.
 ; 
 S DIK="^DGIN(38.5,"_DFN_","_"""I"""_","
 ;
 S DA="" F  S DA=$O(DELARRY(DA)) Q:DA=""  D ^DIK
 Q
 ;
FILE(DFN) ;
 N FILE,SUCCESS,CCS,I,DGENDA,DATA,SUBFILE,DIK,DA
 S FILE=38.5,CCS=0
 ; if no inconsistencies, return 0
 I '$D(^TMP($J,DFN)) D  Q CCS
 . ; clean up INCONSISTENT DATA file if no inconsistencies exist
 . I '$P($G(^DGIN(38.5,DFN,"I",0)),"^",4) D
 . . S DIK="^DGIN(38.5,",DA=DFN
 . . D ^DIK
 ;
 ; else process inconsistencies and return PASS=0
 S CCS=1
 ; if a new entry, create a stub
 S DATA(.01)=DFN
 I '$D(^DGIN(FILE,"B",DFN)) D
 . S DATA(2)=$$DT^XLFDT,DATA(3)=.5
 . S SUCCESS=$$ADD^DGENDBS(FILE,,.DATA,,DFN)
 ;
 ; update file header with data and user info.
 ; Last Updated field (#4) = Today's date
 ; Last Updated by field (#5) = Postmaster
 S DGENDA=DFN,DATA(4)=$$DT^XLFDT,DATA(5)=.5
 S SUCCESS=$$UPD^DGENDBS(FILE,.DGENDA,.DATA)
 ;
 ; add inconsistencies to file
 K DATA
 S SUBFILE=38.51,DGENDA(1)=DFN
 S I="" F  S I=$O(^TMP($J,DFN,I)) Q:I=""  D
 . S (DATA(.01),DATA(.001),DGENDA)=I
 . S SUCCESS=$$ADD^DGENDBS(SUBFILE,.DGENDA,.DATA)
 ;
 ; kill temp file before exit
 K ^TMP($J,DFN)
 ;
 Q CCS
 ;
