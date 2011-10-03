GMVUTL ;HOIFO/RM,MD,FT-CALLABLE ENTRY POINTS FOR PROGRAMMER UTILITIES ;08/12/09  17:15
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ;  #5076 - MDCLIO1 calls          (private)
 ;  #5269 - MDTERM calls           (private)
 ; #10103 - XLFDT calls            (supported)
 ;
 ; This routine supports the following IAs:
 ; #5046 - CLIO, F1250 entry points       (supported)
 ;
EN1 ; CALL TO CONVERT TEMPERATURE (F) IN VARIABLE X TO TEMPERATURE (C)
 ; IN VARIABLE Y
 S Y=$J(X-32*5/9,0,1)
 Q
EN2 ; CALL TO CONVERT AN INCHES MEASUREMENT IN X TO A CENTIMETER 
 ; MEASUREMENT IN Y
 S Y=$J(2.54*X,0,2)
 Q
EN3 ; CALL TO CONVERT A WEIGHT (LBS) IN VARIABLE X TO A WEIGHT (KG)
 ; IN VARIABLE Y
 S Y=$J(X/2.2,0,2)
 Q
CLIO(GMVCLIO,GMVGUID) ; Calls Clinical Observations to get a single record
 ; Input:
 ;   GMVCLIO = array name (required)
 ;   GMVGUID = Global Unique ID (required)
 ; Output:
 ;   GMVCLIO(0) =
 ;
 I $G(GMVGUID)="" S GMVCLIO(0)="" Q
 N GMVARRAY,GMVCNT,GMVCS,GMVDATE,GMVDY,GMVFLAG,GMVFLD,GMVFR,GMVHR,GMVL,GMVLOOP,GMVM,GMVMI,GMVMO
 N GMVO2,GMVP,GMVPAIN,GMVPO2,GMVQ,GMVQFLAG,GMVQLOOP,GMVS,GMVSC,GMVSUP,GMVTIME,GMVU,GMVX,GMVY,GMVYR,X,Y
 I $T(QRYOBS^MDCLIO1)="" S GMVCLIO(0)="",GMVCLIO(5)="" Q
 D QRYOBS^MDCLIO1("GMVARRAY",GMVGUID)
 I '$D(GMVARRAY("OBSERVED_DATE_TIME")) S GMVCLIO(0)="",GMVCLIO(5)="" Q
 S GMVPAIN=$$GETIEN^GMVGETVT("PN",2),GMVCNT=0
 S GMVPO2=$$GETIEN^GMVGETVT("PO2",2),(GMVFR,GMVO2,GMVSUP)=""
 S $P(GMVCLIO(0),U,1)=$G(GMVARRAY("OBSERVED_DATE_TIME","I"))
 S $P(GMVCLIO(0),U,2)=$G(GMVARRAY("PATIENT_ID","I"))
 S $P(GMVCLIO(0),U,4)=$G(GMVARRAY("ENTERED_DATE_TIME","I"))
 S $P(GMVCLIO(0),U,5)=$G(GMVARRAY("HOSPITAL_LOCATION_ID","I"))
 S $P(GMVCLIO(0),U,6)=$G(GMVARRAY("ENTERED_BY_ID","I"))
 S $P(GMVCLIO(0),U,8)=$G(GMVARRAY("SVALUE","I"))
 S GMVX=$G(GMVARRAY("TERM_ID","I"))
 I GMVX]"" D
 .S GMVX=$$GETIEN^GMVGETVT(GMVX,4)
 .S $P(GMVCLIO(0),U,3)=GMVX
 .Q
 ; NOTE: PAIN needs external value from CLIO
 I $P(GMVCLIO(0),U,3)=GMVPAIN D
 .S $P(GMVCLIO(0),U,8)=$G(GMVARRAY("SVALUE","E"))
 .Q
 S GMVFLAG=0
 F GMVLOOP=1,2,3,8 D  Q:GMVFLAG
 .S:$P(GMVCLIO(0),U,GMVLOOP)="" GMVFLAG=1
 .Q
 I GMVFLAG S GMVCLIO(0)="",GMVCLIO(5)="" Q
 ;check unit of measurement and convert value if needed
 I $G(GMVARRAY("UNIT_ID","E"))="DEGREES C" D
 .S $P(GMVCLIO(0),U,8)=+$$CVTVAL^MDTERM($P(GMVCLIO(0),U,8),"DEGREES C","DEGREES F",1)
 I $G(GMVARRAY("UNIT_ID","E"))="CENTIMETER" D
 .S $P(GMVCLIO(0),U,8)=+$$CVTVAL^MDTERM($P(GMVCLIO(0),U,8),"CENTIMETER","INCH",2)
 I $G(GMVARRAY("UNIT_ID","E"))="KILOGRAM" D
 .S $P(GMVCLIO(0),U,8)=+$$CVTVAL^MDTERM($P(GMVCLIO(0),U,8),"KILOGRAM","POUND",2)
 I $G(GMVARRAY("UNIT_ID","E"))="MILLIMETERS OF MERCURY" D
 .S $P(GMVCLIO(0),U,8)=+$$CVTVAL^MDTERM($P(GMVCLIO(0),U,8),"MILLIMETERS OF MERCURY","CENTIMETERS H2O",1)
 ; entered-in-error - won't get errors from clio
 S $P(GMVCLIO(2),U,1)="" ;error flag
 S $P(GMVCLIO(2),U,2)="" ;error entered by
 S $P(GMVCLIO(2),U,3)="" ;reason entered in error
 ;
 S GMVCLIO(5)="",GMVCNT=0
 S GMVCS=$G(GMVARRAY("CUFF_SIZE_ID","I"))
 I GMVCS]"" D
 .S GMVCS=$$GETIEN^GMVGETQL(GMVCS,2)
 .S GMVCNT=GMVCNT+1
 .S $P(GMVCLIO(5),U,GMVCNT)=GMVCS
 .Q
 S GMVL=$G(GMVARRAY("LOCATION_ID","I"))
 I GMVL]"" D
 .S GMVL=$$GETIEN^GMVGETQL(GMVL,2)
 .S GMVCNT=GMVCNT+1
 .S $P(GMVCLIO(5),U,GMVCNT)=GMVL
 .Q
 S GMVM=$G(GMVARRAY("METHOD_ID","I"))
 I GMVM]"" D
 .S GMVM=$$GETIEN^GMVGETQL(GMVM,2)
 .S GMVCNT=GMVCNT+1
 .S $P(GMVCLIO(5),U,GMVCNT)=GMVM
 .Q
 S GMVP=$G(GMVARRAY("POSITION_ID","I"))
 I GMVP]"" D
 .S GMVP=$$GETIEN^GMVGETQL(GMVP,2)
 .S GMVCNT=GMVCNT+1
 .S $P(GMVCLIO(5),U,GMVCNT)=GMVP
 .Q
 S GMVS=$G(GMVARRAY("SITE_ID","I"))
 I GMVS]"" D
 .S GMVS=$$GETIEN^GMVGETQL(GMVS,2)
 .S GMVCNT=GMVCNT+1
 .S $P(GMVCLIO(5),U,GMVCNT)=GMVS
 .Q
 S GMVQ=$G(GMVARRAY("QUALITY_ID","I"))
 I GMVQ]"" D
 .S GMVQ=$$GETIEN^GMVGETQL(GMVQ,2)
 .S GMVCNT=GMVCNT+1
 .S $P(GMVCLIO(5),U,GMVCNT)=GMVQ
 .Q
 I $P(GMVCLIO(0),U,3)=GMVPO2 D
 .S GMVLOOP=0
 .F  S GMVLOOP=$O(GMVARRAY("CONTEXT",GMVLOOP)) Q:'GMVLOOP  D
 ..I $G(GMVARRAY("CONTEXT",GMVLOOP,"TERM_ID","E"))="SUPPLEMENTAL OXYGEN CONCENTRATION" D
 ...S GMVO2=$G(GMVARRAY("CONTEXT",GMVLOOP,"SVALUE","E"))
 ..I $G(GMVARRAY("CONTEXT",GMVLOOP,"TERM_ID","E"))="SUPPLEMENTAL OXYGEN FLOW RATE" D
 ...S GMVFR=$G(GMVARRAY("CONTEXT",GMVLOOP,"SVALUE","E"))
 ..S GMVM=$G(GMVARRAY("CONTEXT",GMVLOOP,"METHOD_ID","I"))
 ..I GMVM]"" D
 ...S GMVM=$$GETIEN^GMVGETQL(GMVM,2)
 ...Q:'GMVM
 ...S GMVQFLAG=0
 ...F GMVQLOOP=1:1 Q:$P($G(GMVCLIO(5)),U,GMVQLOOP)=""  I $P($G(GMVCLIO(5)),U,GMVQLOOP)=GMVM S GMVQFLAG=1 Q
 ...I GMVQFLAG=0 S GMVCNT=GMVCNT+1,$P(GMVCLIO(5),U,GMVCNT)=GMVM
 S:GMVO2]"" GMVO2=GMVO2_"%"
 S:GMVFR]"" GMVFR=GMVFR_" l/min"
 I GMVFR="",GMVO2="" S GMVSUP=""
 I GMVFR'="",GMVO2="" S GMVSUP=GMVFR
 I GMVFR="",GMVO2'="" S GMVSUP=GMVO2
 I GMVFR'="",GMVO2'="" S GMVSUP=GMVFR_" "_GMVO2
 S $P(GMVCLIO(0),U,10)=GMVSUP
 Q
 ;
F1205(GMV1205,GMVX,GMVY) ; Return file 120.5 record as nodes
 ;  Input: GMV1205 = array name to hold nodes (required)
 ;            GMVX = File 120.5 IEN or CliO GUID (required)
 ;            GMVY = Return records marked as errors? (optional)
 ;               0 = don't return, 1 = return error records
 ;                   (default = 0)
 ; Output:GMV1205(0) = file 120.5 zero node
 ;               (2) = 120.5,#2 ^ 120.5, #3 ^ 120.5, #4 delimited by
 ;                     tilde (~)
 ;               (3) = qualifier IENS delimited by caret (^)
 ;         
 N GMVCNT,GMVFLAG,GMVLIST,GMVLOOP,GMVNODE,GMVNODE2,GMVIEN1
 S GMVX=$G(GMVX),GMVY=$G(GMVY,0)
 S (GMV1205(0),GMV1205(2),GMV1205(5))=""
 I GMVX'=+GMVX Q
 S GMVY=$S(GMVY=1:1,1:0)
 S GMVNODE2=$G(^GMR(120.5,+GMVX,2))
 I GMVY=0,$P(GMVNODE2,U,1)=1 Q 
 S GMV1205(0)=$G(^GMR(120.5,GMVX,0))
 S GMVFLAG=0
 F GMVLOOP=1,2,3,8 D  Q:GMVFLAG
 .S:$P(GMV1205(0),U,GMVLOOP)="" GMVFLAG=1
 .Q
 I GMVFLAG S (GMV1205(0),GMV1205(2),GMV1205(5))="" Q
 S GMV1205(2)=GMVNODE2
 S (GMVCNT,GMVIEN1)=0,GMVLIST=""
 F  S GMVIEN1=$O(^GMR(120.5,GMVX,2.1,GMVIEN1)) Q:'GMVIEN1  D
 .S GMVCNT=GMVCNT+1
 .S $P(GMVLIST,"~",GMVCNT)=+$P($G(^GMR(120.5,GMVX,2.1,GMVIEN1,0)),U,1)
 .Q
 S $P(GMV1205(2),U,3)=GMVLIST
 S (GMVCNT,GMVIEN1)=0
 F  S GMVIEN1=$O(^GMR(120.5,GMVX,5,"B",GMVIEN1))  Q:'GMVIEN1  D
 .S GMVCNT=GMVCNT+1
 .S $P(GMV1205(5),U,GMVCNT)=GMVIEN1
 .Q
 Q
 ;
GETREC(GMVARRAY,GMVID,GMVERR) ; Checks CLIO and Vitals databases. Returns
 ; record as nodes with internal values.
 ;  Input: GMVARRAY = array name passed by reference (required)
 ;            GMVID = File 120.5 IEN or CliO GUID (required)
 ;           GMVERR = Return records marked as errors? (optional)
 ;                0 = don't return, 1 = return error records
 ;                   (default = 0)
 ; Output:GMVARRAY(0) = same as File 120.5 zero node
 ;                (2) = 120.5, #2 ^ 120.5, #3 ^ 120.5, #4 delimited by
 ;                      tilde (~)
 ;                (3) = qualifier IENS (File 120.52) delimited by caret (^)
 ;
 ; example:
 ; >D GETREC^GMVUTL(.RESULT,12196,0) ZW RESULT     
 ; RESULT(0)="3080108.093626^217^21^3080108.0937^67^4658^^4^^1.0 l/min 22%"
 ; RESULT(2)="^^"
 ; RESULT(5)=134
 ;
 S GMVID=$G(GMVID),GMVERR=$G(GMVERR)
 I GMVID="" Q
 S GMVERR=$S(GMVERR=1:1,1:0)
 I GMVID=+GMVID D  Q
 .D F1205(.GMVARRAY,GMVID,GMVERR)
 .Q
 I GMVID'=+GMVID D  Q
 .D CLIO(.GMVARRAY,GMVID)
 .Q
 Q
QRYDATE(RESULT,SDATE,EDATE) ; Returns a list of GUIDs found in the
 ; Clinical Observations package for the date range specified
 ;  Input: RESULT = array name surrounded by quotes (required)
 ;                  ex: "ARRAY", "^TMP($J)"
 ;          SDATE = start date of search range in FileMan internal
 ;                  format (optional)
 ;                  default is T-24 hours
 ;          EDATE = end date in FileMan internal format (optional)
 ;                  default is current date/time
 ; Output: RESULT(0)=number of entries returned 
 ;                   or "-1^error message"
 ;         RESULT(n)=Global Unique ID (aka GUID)
 ; where n is a sequential number starting with 1
 ;
 ; example:
 ; >D QRYDATE^GMVUTL("ARRAY",3070301,3070401)
 ; >ZW ARRAY
 ; ARRAY(0)=3
 ; ARRAY(1)="{FD0FEBBC-8EC1-42E4-9483-4BDBE6370728}"
 ; ARRAY(2)="{A7C7FFEB-0CD5-4D55-BB34-35B9620F4ECC}"
 ; ARRAY(3)="{D0CEA9D2-A519-41C2-A4AE-9C24C7498E56}"
 ;
 I $T(QRYDATE^MDCLIO1)="" D  Q
 .S @RESULT@(0)="-1^QRYDATE entry point not found in MDCLIO1"
 .Q
 K ^TMP($J),@RESULT
 S SDATE=$G(SDATE,$$FMADD^XLFDT($$NOW^XLFDT(),,-24))
 S EDATE=$G(EDATE,$$NOW^XLFDT())
 I SDATE>EDATE D  Q
 .S @RESULT@(0)="-1^Start Date is after end date"
 .Q
 D QRYDATE^MDCLIO1(RESULT,SDATE,EDATE)
 Q
