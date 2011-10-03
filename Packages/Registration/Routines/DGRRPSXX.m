DGRRPSXX ; ALB/SGG - DGRR patient services - TEST MUMPS SIDE COMPONENTS  ; Compiled December 9, 2003 15:38:25
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ; This routine is ======== FOR TESTING PURPOSES ONLY =========
 ; 
 ;      It can be called to print out an XML doc from the mumps database
 ;      for one patient record by inputing that patients DFN
 ; eg D TEST^DGRRPSXX("DFN",dfn#,,)
 ;      or to get the XML from a patient ICN
 ; eg D TEST^DGRRPSXX("ICN",icn#,,)
 ;
 ; it can also be used to run the mumps software against every patient DFN
 ; in the database, NOT RECOMMENDED  eg TEST^DGRRPSXX(,,1,)
 ; or against every patient ICN in the database, 
 ; NOT RECOMMENDED EITHER eg TEST^DGRRPSXX(,,1,)
 ; 
 ; 
 ; NOTE:  INTRACE and OUTTRACE line tags have been commented out in DGRRPSGT
 ; to prevent the building of the XTMP global.  If this routine is 
 ; needed for testing these comments will need to be removed from DGRRPSGT
 ; for TEST^DGRRPSXX to work correctly.
 ; 
 ; 
TEST(TYPE,NUM,ALLICN,ALLDFN,REQDT) ;
 ; TYPE DFN OR ICN
 ; NUM DFN# OR ICN#
 ;
 ;
 ;
 NEW ICNALL,DFNALL,PTID,PARAMS
 ;
 I ($G(ALLICN)_$G(ALLDFN))="" D  Q
 .SET PARAMS("PatientId_Type")=$G(TYPE)
 .SET PARAMS("PatientId")=$G(NUM)
 .SET PARAMS("REQUESTED_DATE")=$G(REQDT)
 .I ($G(TYPE)="")!($G(NUM)="") DO
 ..; default parameters if not defined
 ..SET PARAMS("PatientId_Type")="ICN"
 ..SET PARAMS("PatientId")="5000000199"
 .DO APPLY
 ;
 I $G(ALLICN)'="" N ICN SET ICN="" FOR  SET ICN=$O(^DPT("AICN",ICN)) QUIT:ICN=""  DO
 .SET PARAMS("PatientId")=ICN
 .SET PARAMS("PatientId_Type")="ICN"
 .DO APPLY
 ;
 I $G(ALLDFN)'="" N DFN SET DFN=0 FOR  SET DFN=$O(^DPT(DFN)) QUIT:'+DFN  DO
 .SET PARAMS("PatientId")=DFN
 .SET PARAMS("PatientId_Type")="DFN"
 .DO APPLY
 QUIT
APPLY ;
 SET PARAMS("UserId")="User ID supplied?"
 SET PARAMS("UserInstitution")="User Institution Supplied?"
 SET PARAMS("PrimaryDemo")=1
 SET PARAMS("SecondaryDemo")=1
 SET PARAMS("TertiaryDemo")=1
 SET PARAMS("MainAddress")=1
 SET PARAMS("TemporaryAddress")=1
 SET PARAMS("ConfidentialAddress")=1
 SET PARAMS("ContactInfo")=1
 SET PARAMS("ADTInfo")=1
 SET PARAMS("EnrollEligibility")=1
 SET PARAMS("Incompetent")=1
 N RESULT
 DO PATIENT^DGRRPSGT(.RESULT,.PARAMS)
 WRITE !! DO VIEWLAST() WRITE !!
 QUIT
 ;
VIEWLAST(TRACENO) ; ENTER(-1) TO GET THE ONE BEFORE LAST
 NEW I
 IF $G(TRACENO)<0 SET TRACENO=($O(^XTMP("DGRRPS","TRACE",""),-1))+TRACENO
 IF $G(TRACENO)="" SET TRACENO=($O(^XTMP("DGRRPS","TRACE",""),-1))
 WRITE !!,"<< RESULT DATA FOR TRACENO: ",TRACENO," >>"
 WRITE !!,"data:",!,"=====",!
 SET I="" FOR  SET I=$O(^XTMP("DGRRPS","TRACE",TRACENO,"DATA",I)) QUIT:I=""  DO
 .WRITE !,^XTMP("DGRRPS","TRACE",TRACENO,"DATA",I)
 WRITE !!,"parameters:",!,"===========",!
 SET I="" FOR  SET I=$O(^XTMP("DGRRPS","TRACE",TRACENO,"PARAMS",I)) QUIT:I=""  DO
 .WRITE !,I,?30,^XTMP("DGRRPS","TRACE",TRACENO,"PARAMS",I)
 WRITE !!,"<< END OF DATA FOR TRACENO: ",TRACENO," >>",!
 QUIT
 ;
TESTERR ; test error
 SET PARAMS("PatientId_Type")="XZZZICN"
 SET PARAMS("PatientId")=" ICN: 5000000199^852098"
 SET PARAMS("TemporaryAddress")=1
 SET PARAMS("ConfidentialAddress")=1
 DO PATIENT^DGRRPSGT(.RESULT,.PARAMS)
 WRITE !! DO VIEWLAST() WRITE !!
 QUIT
