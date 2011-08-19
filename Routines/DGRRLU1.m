DGRRLU1 ;alb/aas - DG Replacement and Rehosting RPC for VADPT ;1/4/06  11:31
 ;;5.3;Registration;**538**;Aug 13, 1993
 ;
 SET X="You Can't Enter DGRRLU1 at top of routine!"
 QUIT
 ;
BUS(RESULT,PARAMS) ; -- return business logic data for 1 patient in xml format
 ; -- RPC: DGRR GET PTLK BUSINESS DATA 
 ; 
 ; -- input  [required] PARAMS("PATIENT_ID_TYPE") = 'DFN' or 'ICN'
 ;           [required] PARAMS("PATIENT_ID") = a DFN value or an ICN value
 ;           [required] PARAMS("USER_ID_TYPE") = 'VPID' or 'DUZ'
 ;           [required] PARAMS("USER_ID") = value of a VPID, or DUZ
 ;           [optional] PARAMS("USER_INSTITUTION") = Station # (Defaults to DUZ(2) if not received)
 ; [temporary/optional] PARAMS("PATIENT_RECORD_FLAG") = Optional.  If 1 the query returns old version of the patient_record_flag business rule
 ;           
 ; -- returns result array that contains XML document containing data for 12 checks of patient
 ;    related to lookup that is executed in the business layer.  See Patient Lookup documentation
 ;    for logic
 ;       
 NEW X,Y,CNT,DGRRLINE,DGRRESLT,PTID,DGENR,ICN,USERID,INSTTTN,ERRMESS
 KILL RESULT,DGRRESLT
 SET CNT=0
 SET DGRRLINE=0
 K ^TMP($J,"PLU-BRULES")
 SET DGRRESLT="^TMP($J,""PLU-BRULES"")"
 SET RESULT=$NA(@DGRRESLT)
 DO DT^DICRW
 ;
USER ; establish the DUZ from User ID
 IF ($G(PARAMS("USER_ID_TYPE"))="VPID") SET USERID=$$IEN^XUPS($G(PARAMS("USER_ID")))
 IF ($G(PARAMS("USER_ID_TYPE"))="DUZ") SET USERID=$G(PARAMS("USER_ID"))
 IF +$G(USERID)>0 DO DUZ^XUP(USERID)
 IF +$G(USERID)<1 SET ERRMESS="USER_ID_TYPE: "_$G(PARAMS("USER_ID_TYPE"))_"  USER_ID: "_$G(PARAMS("USER_ID"))_" does not exist."
 ;
INSTTTN ; set institution to USER_INSTITUTION if available else set to default institution
 ;USER_INSTITUTION parameter if defined will contain the station number for
 ;an institution.  Call $$IEN^XUAF4 (IA#2171) to convert station number to IEN.
 SET INSTTTN=$G(PARAMS("USER_INSTITUTION")),INSTTTN=$$IEN^XUAF4(INSTTTN)
 IF INSTTTN="" S INSTTTN=$G(DUZ(2))
 ;
PATIENT ; establish Patient VPID from Patient ID
 IF $G(PARAMS("PATIENT_ID_TYPE"))="ICN" DO 
 .SET ICN=$G(PARAMS("PATIENT_ID"))
 .SET PTID=$$CHARCHK^DGRRUTL($$GETDFN^MPIF001($P(ICN,"V",1)))
 IF $G(PARAMS("PATIENT_ID_TYPE"))="DFN" DO 
 .SET PTID=$$CHARCHK^DGRRUTL($GET(PARAMS("PATIENT_ID")))
 IF ($G(PTID)<1) SET ERRMESS="PATIENT_ID_TYPE: "_$G(PARAMS("PATIENT_ID_TYPE"))_"   PATIENT_ID: "_$G(PARAMS("PATIENT_ID"))_" does not exist."
 IF ($G(PTID)>0),($G(^DPT(PTID,0))="") SET ERRMESS="For Patient Id ("_PTID_"), no data exists."
 ;
 DO ADD^DGRRLU($$XMLHDR^DGRRUTL())
 IF ($G(ERRMESS)'="") D ADD^DGRRLU("<error message="_ERRMESS_"'></error>") GOTO BUSEND
 DO ADD^DGRRLU("<businessRules patientId='"_PTID_"' patientName='"_$$CHARCHK^DGRRUTL($P($G(^DPT(PTID,0)),"^",1))_"' patientSSN='"_$P($G(^DPT(PTID,0)),"^",9)_"'>")
 DO ADD^DGRRLU("<error message=''></error>")
 D RULES(PTID,INSTTTN)
BUSEND DO ADD^DGRRLU("</businessRules>")
 QUIT
 ;
RULES(DFN,DIV) ;
 ; -- display order from old SRS  
 ;    Messages will display in the following order: 
 ;    emp SSN mission, Similar, Deceased, Security (sometimes), CWAD, Missing, Test, Enrollment and Means Test. 
 ;    
 N DOD,MASPARAM,TPFIELD,SENSITIV,USERKEY,SIM,PTSSN,PRIM1,EMPSSN,PTSSN
 SET EMPSSN=$$GET1^DIQ(200,DUZ_",",9,"I","","DGNPERR")
 SET PTSSN=$P($G(^DPT(DFN,0)),"^",9)
 SET USERKEY=$S($D(^XUSEC("DG RECORD ACCESS",DUZ)):"true",1:"false")
 SET MASPARAM=$S(+$P($G(^DG(43,1,"REC")),"^")=1:"true",1:"false") ;Restrict Patient Record Access (#1201)
 ;
0 ; -- employee SSN missing from new person file
 N X
 S X="   <businessRule alertId='employeeSSNExists' empSsn='"_$$CHARCHK^DGRRUTL(EMPSSN)
 S X=X_"' masParameter='"_$$CHARCHK^DGRRUTL(MASPARAM)
 S X=X_"' userRecordAccessPrivilege='"_$$CHARCHK^DGRRUTL(USERKEY)_"'></businessRule>"
 D ADD^DGRRLU(X)
 ;
1 ; -- similar patients, Checks the BS5 cross reference for similar patients and matches last name
 ;    bs5 index is first character of last name concatenated with last 4 of ssn.
 ;    give warning, ask if okay, 
 ;    
 SET SIM=$S($$BS5^DPTLK5(DFN)=1:"true",1:"false")
 DO ADD^DGRRLU("  <businessRule alertId='similarPatients' similarPatientsFound='"_$$CHARCHK^DGRRUTL(SIM)_"'></businessRule>")
 ;
2 ; -- deceased patient
 ;    give warning if patient is deceased
 SET DOD=$P($G(^DPT(DFN,.35)),"^",1)
 DO ADD^DGRRLU("  <businessRule alertId='deceasedPatient' theDateOfDeath='"_$$CHARCHK^DGRRUTL(DOD)_"'></businessRule>")
 ;
3 ; -- accessing own record and user doesn't have dg record access key and MAS parameter to restrict patient records=yes
 ;    check parameter first, check key second.  if (param && !userKey), if (emp ssn == to pt ssn) don't allow (check format of ssn)
 ;    if (empssn=="") tell them to get added and don't allow access
 SET X="  <businessRule alertId='accessOwnRecord' masParameter='"_$$CHARCHK^DGRRUTL(MASPARAM)
 SET X=X_"' userRecordAccessPrivilege='"_$$CHARCHK^DGRRUTL(USERKEY)_"' employeeSSN='"_$$CHARCHK^DGRRUTL(EMPSSN)_"' patientSSN='"_$$CHARCHK^DGRRUTL(PTSSN)_"'></businessRule>"
 DO ADD^DGRRLU(X)
 ;
4 ; -- primary elig = employee and user doesn't hold dg security office key,from EMPL^DGSEC4(DFN)
 ;    give message and log if chosen
 NEW ELIST,DGELIG
 S DGELIG=0,ELIST=""
 F  S DGELIG=+$O(^DPT("AEL",DFN,DGELIG)) Q:'DGELIG  D
 . S ELIST=ELIST_$P($G(^DIC(8.1,+$P($G(^DIC(8,DGELIG,0)),"^",9),0)),"^",1)_","
 SET USERKEY=$S($D(^XUSEC("DG SECURITY OFFICER",DUZ)):"true",1:"false")
 DO ADD^DGRRLU("  <businessRule alertId='patientIsEmployee' eligibilityList='"_$$CHARCHK^DGRRUTL(ELIST)_"' primElig='"_$$CHARCHK^DGRRUTL($$PRIM^DGRRLUA(DFN))_"' userSecurityOfficerPrivilege='"_$$CHARCHK^DGRRUTL(USERKEY)_"'></businessRule>")
 ;
5 ; -- sensitive record and user doesn't have the dg sensitivity key
 ;    ask to continue, if yes, log if chosen
 SET SENSITIV=$S($P($G(^DGSL(38.1,DFN,0)),"^",2)=1:"true",1:"false")
 SET USERKEY=$S($D(^XUSEC("DG SENSITIVITY",DUZ)):"true",1:"false")
 DO ADD^DGRRLU("  <businessRule alertId='sensitiveRecord' isSensitive='"_$$CHARCHK^DGRRUTL(SENSITIV)_"' userSensitivityPrivilege='"_$$CHARCHK^DGRRUTL(USERKEY)_"'></businessRule>")
 ;
6 ; -- cwad for patient (C)risis notes, Clinical (W)arnings, (A)lergies, and Advance (D)irectives 
 NEW CWAD
 SET CWAD=$$CWAD^ORQPT2(DFN)
 DO ADD^DGRRLU("  <businessRule alertId='cwadChecks' cwads='"_$$CHARCHK^DGRRUTL(CWAD)_"'></businessRule>")
 ;
7 ; -- patient on MPR, see if patient is listed in Missing Patient Register
 NEW MPREC
 ;S X="MPRCHK" X ^%ZOSF("TEST") I $T I $L($T(GUI^MPRCHK)) D GUI^MPRCHK(DFN,.MPREC) ; MPR
 DO ADD^DGRRLU("  <businessRule alertId='patientOnMPR' value='"_$$CHARCHK^DGRRUTL($S($G(MPREC(0))=1:"true",1:"false"))_"'></businessRule>")
 ;
8 ; -- test patient 
 ;    if (dataColumn=1) display message.
 S TPFIELD="false"
 I $$TESTPAT^VADPT(DFN) S TPFIELD="true"
 DO ADD^DGRRLU("  <businessRule alertId='testPatient' testPatientColumn='"_$$CHARCHK^DGRRUTL(TPFIELD)_"'></businessRule>")
 ;
9 ; -- enrollment information FROM DPTLK,  Provide Enrollment data for user notification
 ;    
 ; If patient is NOT ELIGIBLE, display Enrollment Status (Ineligible Project Phase I)
 ; Get Enrollment Group Threshold Priority and Subgroup
 ; Compare Patient's Enrollment Priority to Enrollment Group Threshold
 ;
 NEW ENCAT,ENPRIO,ENSUBGRP,ENEND,LINE,DGENST
 S ENCAT=""
 I $$GET^DGENA($$FINDCUR^DGENA(+DFN),.DGENR) D
 . S ENCAT=$$CATEGORY^DGENA4(+DFN)
 . S ENCAT=$$EXTERNAL^DILFD(27.15,.02,"",ENCAT)
 S ENPRIO=$S($G(DGENR("PRIORITY")):$$EXT^DGENU("PRIORITY",DGENR("PRIORITY")),1:"")
 S ENSUBGRP=$S($G(DGENR("SUBGRP"))="":"",1:$$EXT^DGENU("SUBGRP",$G(DGENR("SUBGRP"))))
 SET ENEND=$G(DGENR("END"))
 SET DGENST=$S($G(DGENR("STATUS"))=10:DGENR("STATUS"),$G(DGENR("STATUS"))=19:DGENR("STATUS"),$G(DGENR("STATUS"))=20:DGENR("STATUS"),1:"")
 I DGENST'="" S DGENST=$$EXTERNAL^DILFD(27.11,.04,"",DGENST)
 ; check for Combat Veteran Eligibility, if elig do not display EGT info
 N DGENTHR
 S DGENTHR=1
 I '$$CVEDT^DGCV(+DFN) D
 .;Get Enrollment Group Threshold Priority and Subgroup
 .N DGEGTIEN,DGEGT
 .S DGEGTIEN=$$FINDCUR^DGENEGT
 .S DGEGT=$$GET^DGENEGT(DGEGTIEN,.DGEGT)
 .Q:$G(DGENR("PRIORITY"))=""!($G(DGEGT("PRIORITY"))="")
 .;Compare Patient's Enrollment Priority to Enrollment Group Threshold
 .S DGENTHR=$$ABOVE^DGENEGT1(+DFN,DGENR("PRIORITY"),$G(DGENR("SUBGRP")),DGEGT("PRIORITY"),DGEGT("SUBGRP"))
 SET LINE="  <businessRule alertId='enrollmentData' category='"_$$CHARCHK^DGRRUTL(ENCAT)_"' endDate='"_$$CHARCHK^DGRRUTL(ENEND)_"' priority='"
 SET LINE=LINE_$$CHARCHK^DGRRUTL(ENPRIO)_"' subgroup='"_$$CHARCHK^DGRRUTL(ENSUBGRP)_"' status='"_$$CHARCHK^DGRRUTL(DGENST)
 SET LINE=LINE_"' aboveThreshold='"_DGENTHR_"'></businessRule>"
 D ADD^DGRRLU(LINE)
 ;
 D 10^DGRRLU1A
END ;
 QUIT
