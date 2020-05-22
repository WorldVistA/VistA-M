DGENELA1 ;ALB/CJM,RTK,TDM,PJR,RGL,LBD,EG,TMK,CKN,ERC,HM - Patient Eligibility API ;20 Jan 2015  3:27 PM
 ;;5.3;Registration;**147,327,314,367,497,451,564,631,672,659,583,746,653,688,841,909,972,952**;Aug 13,1993;Build 160
 ;
CHECK(DGELG,DGPAT,DGCDIS,ERRMSG) ;
 ;Does validation checks on the eligibility contained in the DGELG array.
 ;
 ;Input:
 ;  DGELG - array containing eligibility data (pass by reference)
 ;  DGPAT - array containing patient data (pass by reference)
 ;  DGCDIS - array containing catastrophic disability determination (pass by reference)
 ;
 ;Output:
 ;  Function Value - returns 1 if all validation checks passed, 0 otherwise
 ;  ERRMSG - returns a message if validations fail (pass by reference)
 ;
 N SUCCESS,NATCODE,BAD,SUB,CODE,DGONV,DGTEXT,INELDATE
 S SUCCESS=0
 S ERRMSG=""
 ;
 D  ;drops out of block on failure
 .;
 .;get optional arrays if not there
 .I '$D(DGPAT),'$$GET^DGENPTA(DGELG("DFN"),.DGPAT) S ERRMSG="PATIENT NOT FOUND" Q
 .I '$D(DGCDIS),'$$GET^DGENCDA(DGELG("DFN"),.DGCDIS) S ERRMSG="PATIENT NOT FOUND" Q
 .;
 .;do field level checks
 .S SUB="" F  S SUB=$O(DGELG(SUB)) Q:(SUB="")  I SUB'="ELIG",SUB'="RATEDIS",'$$CHKFIELD(SUB,DGELG(SUB)) S ERRMSG="BAD VALUE, FIELD = "_$$GET1^DID(2,$$FIELD(SUB),"","LABEL") Q
 .;
 .Q:(SUB'="")  ;didn't finish the loop
 .;
 .;also check SC % field of Rated Disabilities
 .S SUB="" F  S SUB=$O(DGELG("RATEDIS",SUB)) Q:(SUB="")  I '$$CHKFIELD("PER",DGELG("RATEDIS",SUB,"PER")) S ERRMSG="BAD VALUE, FIELD = DISABILITY % OF THE RATED DISABILITIES MULTIPLE" Q
 .Q:(SUB'="")  ;didn't finish the loop
 .;
 .I DGELG("SC")="Y",DGELG("SCPER")="" S ERRMSG="SC% UNSPECIFIED FOR SC VET" Q
 .;
 .;!! put this check back when POS is added to the Z11 message
 .;I DGPAT("VETERAN")="Y",'DGELG("POS") S ERRMSG="POS UNSPECIFIED" Q 
 .;
 .I 'DGELG("ELIG","CODE") S ERRMSG="PRIMARY ELIGIBILITY IS UNSPECIFIED" Q
 .;
 .I (DGELG("VACKAMT")>0),(DGELG("A&A")_DGELG("HB")_DGELG("VAPEN")_DGELG("VADISAB")'["Y") S ERRMSG="VA CHECK AMOUNT > 0 BUT INCOME INDICATORS ALL SHOW 'NO'" Q
 .;
 .;
 .;
 .I (DGELG("SC")="N"),(DGELG("VADISAB")="Y") S ERRMSG="NSC VETERANS CAN NOT BE RECEIVING VA DISABILITY BENEFITS" Q
 .;
 .S BAD=1 D  Q:BAD  ;check primary eligibility
 ..S NATCODE=$$NATCODE^DGENELA(DGELG("ELIG","CODE"))
 ..Q:'NATCODE
 ..;
 ..I NATCODE=21 S ERRMSG="CATASTROPHICALLY DISABLED NOT ALLOWED AS PRIMARY ELIGIBILITY" Q
 ..;
 ..I (DGPAT("VETERAN")="Y"),(DGELG("SC")="Y"),(DGELG("SCPER")<50),(NATCODE'=3) S ERRMSG="PRIMARY ELIGIBILITY CODE INCONSISTENT WITH SERVICE CONNECTED PERCENTAGE" Q
 ..;
 ..I (DGPAT("VETERAN")="Y"),(DGELG("SC")="Y"),(DGELG("SCPER")>49),(NATCODE'=1) S ERRMSG="PRIMARY ELIGIBILITY CODE INCONSISTENT WITH SERVICE CONNECTED PERCENTAGE" Q
 ..;
 ..S DGONV=$O(^DIC(21,"B","OTHER NON-VETERANS","")),INELDATE=$P($G(^DPT(DFN,.15)),"^",2)
 ..I INELDATE'="",DGPAT("INELDATE")'>0,DGELG("POS"),DGELG("POS")=DGONV,'$D(^DIC(21,DGELG("POS"),"E",DGELG("ELIG","CODE"))) D
 ...S DGTEXT="Patient was previously determined to be ineligible for VA health care.  Upon review, the individual is determined to be eligible for "
 ...S DGTEXT=DGTEXT_"VA care.  Please update period of service and other eligibility data as needed.."
 ...D ADDMSG^DGENUPL3(.MSGS,DGTEXT,0)
 ..;
 ..I (DGPAT("VETERAN")="Y"),(DGELG("SC")="Y"),(NATCODE=1)!(NATCODE=3) S BAD=0 Q  ;primary eligibility OK
 ..;
 ..I (DGPAT("VETERAN")="Y"),(DGELG("POW")="Y"),NATCODE'=18 S ERRMSG="PRIMARY ELIGIBILITY SHOULD BE PRISONER OF WAR" Q
 ..;
 ..I (DGPAT("VETERAN")="Y"),(DGELG("POW")="Y"),NATCODE=18 S BAD=0 Q
 ..;
 ..I (DGPAT("VETERAN")="Y"),(DGELG("PH")="Y"),NATCODE'=22 S ERRMSG="PRIMARY ELIGIBILITY SHOULD BE PURPLE HEART RECIPIENT" Q
 ..;
 ..I (DGPAT("VETERAN")="Y"),(DGELG("PH")="Y"),NATCODE=22 S BAD=0 Q
 ..;
 ..; disabled DG*5.3*367, for Inel
 ..;I (DGPAT("VETERAN")'=$P($G(^DIC(8.1,NATCODE,0)),"^",5)) S ERRMSG="PRIMARY ELIGIBILTY NOT CONSISTENT WITH VETERAN STATUS" Q
 ..;
 ..I DGELG("A&A")'="Y",NATCODE=2 S ERRMSG="PRIMARY ELIGIBILITY INCONSISTENT WITH A&A INDICATOR" Q
 ..;
 ..I DGELG("HB")'="Y",NATCODE=15 S ERRMSG="PRIMARY ELIGIBILITY INCONSISTENT WITH HOUSEBOUND INDICATOR" Q
 ..;
 ..I DGELG("VAPEN")'="Y",NATCODE=4 S ERRMSG="PRIMARY ELIGIBILITY INCONSISTENT WITH VA PENSION INDICATOR" Q
 ..;
 ..I DGELG("SC")="Y",((NATCODE=4)!(NATCODE=5)) S ERRMSG="NSC ELIGIBILITY CODE INCONSISTENT WITH SERVICE CONNECTION INDICATOR" Q
 ..;
 ..I (DGPAT("DOB")>2061231),(NATCODE=16) S ERRMSG="DOB IS INCONSISTENT WITH ELIGIBILITY OF MEXICAN BORDER WAR" Q
 ..;
 ..I (DGPAT("DOB")>2071231),(NATCODE=17) S ERRMSG="DOB IS INCONSISTENT WITH ELIGIBILITY OF WORLD WAR I" Q
 ..;
 ..;primary eligibility is good
 ..S BAD=0
 .;
 .S SUCCESS=1
 .;check eligibilities multiple
 .S CODE=0 F  S CODE=$O(DGELG("ELIG","CODE",CODE)) Q:'CODE  D  Q:('SUCCESS)
 ..S NATCODE=$$NATCODE^DGENELA(CODE)
 ..Q:'NATCODE
 ..I NATCODE=21,'DGCDIS("DATE") S SUCCESS=0,ERRMSG="CATASTROPHICALLY DISABLED ELIGIBILITY REQUIRES CATASTROPHICALLY DISABLED DETERMINATION DATE" Q
 .;
 Q SUCCESS
 ;
STORE(DGELG,DGPAT,DGCDIS,ERROR,SKIPCHK) ;
 ;Stores an eligibility record for a patient. The patient record must
 ;already exist. A lock on the Patient record is required, and is
 ;released upon completion.
 ;
 ;Input:
 ;  DGELG - eligibility array (pass by reference)
 ;  DGPAT - patient array (optional, pass by reference)
 ;  DGCDIS - array containing the catastrophic disability determination (optional, pass by reference)
 ;  SKIPCHK - flag, set to 1 means that the consistency checks
 ;            were already done & should be skipped
 ;
 ;Output:
 ;  Function Value - returns 1 if successful, otherwise 0
 ;  ERROR - in event of failure returns an error message (pass by reference, optional)
 ;
 N SUCCESS,DATA,FIELD,DA,DFN,COUNT,OTHSTAT,Z
 S DFN=$G(DGELG("DFN"))
 S SUCCESS=0
 S ERROR=""
 ;
 D  ;drops out of block on failure
 .I '$$LOCK^DGENPTA1(DFN) S ERROR="UNABLE TO LOCK PATIENT RECORD" Q
 .I $G(SKIPCHK)'=1,'$$CHECK(.DGELG,.DGPAT,.DGCDIS,.ERROR) Q
 .S SUB="" F  S SUB=$O(DGELG(SUB)) Q:SUB=""  D
 ..I SUB'="ELIG",SUB'="RATEDIS",SUB'="DFN" S FIELD=$$FIELD(SUB) I FIELD S DATA(FIELD)=DGELG(SUB)
 .;lock Camp Lejeune when it comes over from HEC in Z11 - DG*5.3*909
 .I "^Y^N^"[("^"_$G(DATA(.321701))_"^") S DATA(.32171)=1
 .;
 .;don't add the Primary Eligibility unless different, so as to not
 .;fire off x-refs unless necessary
 .I $P($G(^DPT(DFN,.36)),"^")'=DGELG("ELIG","CODE") S DATA(.361)=DGELG("ELIG","CODE")
 .;
 .; Only update User Enrollee fields if the incoming UE status is
 .; greater than the USER ENROLLEE VALID THROUGH on file.
 .I $G(DATA(.3617))<$P($G(^DPT(DFN,.361)),"^",7) K DATA(.3617),DATA(.3618)
 .; update field 2/.5501 and entry in file 33
 .I +$O(^DGOTH(33,"B",DFN,""))>0 S DATA(.5501)="" ; DG*5.3*952
 .S OTHSTAT=$G(DGELG("OTH")) ; DG*5.3*952
 .I "^0^1^"[(U_OTHSTAT_U) D  ; ; DG*5.3*952
 ..S Z=$$FILSTAT^DGOTHUT1(DFN,OTHSTAT) I '+Z S ERROR="FILEMAN FAILED TO UPDATE FILE 33: "_$P(Z,U,2) Q  ; DG*5.3*952
 ..I OTHSTAT=1 S DATA(.5501)=DGELG("OTHTYPE") ; DG*5.3*952
 ..Q  ; DG*5.3*952
 .;
 .;update Patient file record with data from Z11
 .D UPDZ11^DGENELA2
 .;
 .;delete eligibilities that do not belong
 .D DELELIG^DGENELA2(DFN,.DGELG)
 .;
 .;overlay Rated Disabilities
 .Q:'$$OVERLAY()
 .;
 .;Add the new Patient Eligibilities
 .;Don't add the an eligibility unless different - so as to not
 .;fire off the x-refs unless necessary.
 .;Also, try to assign ien = the code (see input transform of the field).
 .K DA,DATA
 .S DA(1)=DFN
 .S DATA(.01)=0
 .F  S DATA(.01)=$O(DGELG("ELIG","CODE",DATA(.01))) Q:'DATA(.01)  I '$D(^DPT(DFN,"E","B",DATA(.01))) I '$$ADD^DGENDBS(2.0361,.DA,.DATA,,$S($D(^DPT(DFN,"E",DATA(.01))):0,1:DATA(.01))) S ERROR="FILEMAN FAILED TO ADD PATIENT ELIGIBILITY" Q
 .;
 .S SUCCESS=1
 ;
 D UNLOCK^DGENPTA1(DFN)
 Q SUCCESS
 ;
FIELD(SUB) ;
 ;given a subscript from the ELIGIBILITY array, returns the field number
 ;
 Q:SUB="CODE" .361
 Q:SUB="SC" .301
 Q:SUB="SCPER" .302
 Q:SUB="EFFDT" .3014
 Q:SUB="POW" .525
 Q:SUB="PH" .531
 Q:SUB="A&A" .36205
 Q:SUB="HB" .36215
 Q:SUB="VAPEN" .36235
 Q:SUB="VACKAMT" .36295
 Q:SUB="DISRET" .3602
 Q:SUB="DISLOD" .3603
 Q:SUB="MEDICAID" .381
 Q:SUB="MEDASKDT" .382 ;EVC - DG*5.3*653
 Q:SUB="AO" .32102
 Q:SUB="IR" .32103
 Q:SUB="EC" .322013  ;name change from Env Con, DG*5.3*688
 Q:SUB="MTSTA" ""  ;don't map Means Test Category
 Q:SUB="P&T" .304
 Q:SUB="P&TDT" .3013  ;field added with DG*5.3*688
 Q:SUB="POS" .323
 Q:SUB="UNEMPLOY" .305
 Q:SUB="SCAWDATE" .3012
 Q:SUB="RATEINC" .293
 Q:SUB="CLAIMNUM" .313
 Q:SUB="CLAIMLOC" .314
 Q:SUB="VADISAB" .3025
 Q:SUB="ELIGSTA" .3611
 Q:SUB="ELIGSTADATE" .3612
 Q:SUB="ELIGVERIF" .3615
 Q:SUB="ELIGENTBY" .3616
 Q:SUB="RD" .01
 Q:SUB="PER" 2
 Q:SUB="RDSC" 3
 Q:SUB="RDEXT" 4
 Q:SUB="RDORIG" 5
 Q:SUB="RDCURR" 6
 Q:SUB="UEYEAR" .3617
 Q:SUB="UESITE" .3618
 Q:SUB="AOEXPLOC" .3213
 Q:SUB="CVELEDT" .5295
 Q:SUB="SHAD" .32115
 Q:SUB="MOH" .541
 Q:SUB="MOHAWRDDATE" .542  ;MOH AWARD DATE DG*5.3*972 HM
 Q:SUB="MOHSTATDATE" .543  ;MOH STATUS DATE DG*5.3*972 HM
 Q:SUB="MOHEXEMPDATE" .544 ;MOH COPAYMENT EXEMPTION DATE DG*5.3*972 HM
 Q:SUB="CLE" .321701     ; Added for Camp Lejeune - DG*5.3*909
 Q:SUB="CLEDT" .321702   ; Added for Camp Lejeune - DG*5.3*909
 Q:SUB="CLEST" .321703   ; Added for Camp Lejeune - DG*5.3*909
 Q:SUB="CLESOR" .321704  ; Added for Camp Lejeune - DG*5.3*909
 ;
 Q ""
 ;
CHKFIELD(SUB,VAL) ;
 ;Description: Does field level validation of the value. Returns 1
 ;if the value is good, 0 otherwise.
 ;
 Q:($G(VAL)="") 1  ;for now, all NULL values assumed okay
 ;
 N BAD S BAD=0
 I (SUB="SCPER")!(SUB="PER"),(+VAL'=VAL)!(VAL>100)!(VAL<0)!(VAL?.E1"."1N.N) S BAD=1
 I SUB="VACKAMT",+VAL'=VAL&(VAL'?.N1"."2N)!(VAL>99999)!(VAL<0) S BAD=1
 I SUB="DISRET",VAL'=0,VAL'=1 S BAD=1
 I SUB="DISLOD",VAL'=0,VAL'=1 S BAD=1
 I SUB="MEDICAID",VAL'=0,VAL'=1 S BAD=1
 I SUB="RATEINC",VAL'=0,VAL'=1 S BAD=1
 I SUB="ELIGSTA",VAL'="P",VAL'="R",VAL'="V" S BAD=1
 I SUB="POW",VAL'="Y",VAL'="N",VAL'="U" S BAD=1
 Q 'BAD
 ;
 ;
OVERLAY() ;
 ;Description: Overlay the local Rated Disabilities with whatever HEC
 ;sent.
 ;
 N SUCCESS S SUCCESS=1
 ;
 ;delete the rated disabilities multiple
 D DELRDIS^DGENELA2(DFN)
 ;
 ;add the rated disabilities
 K DATA,DA
 S DA(1)=DFN
 S COUNT=0
 F  S COUNT=$O(DGELG("RATEDIS",COUNT)) Q:'COUNT  D
 .S DATA(.01)=DGELG("RATEDIS",COUNT,"RD")
 .I DATA(.01) D
 ..S DATA(2)=DGELG("RATEDIS",COUNT,"PER")
 ..S DATA(3)=DGELG("RATEDIS",COUNT,"RDSC")
 ..S DATA(4)=DGELG("RATEDIS",COUNT,"RDEXT")
 ..S DATA(5)=DGELG("RATEDIS",COUNT,"RDORIG")
 ..S DATA(6)=DGELG("RATEDIS",COUNT,"RDCURR")
 ..I '$$ADD^DGENDBS(2.04,.DA,.DATA) S ERROR="FILEMAN FAILED TO ADD RATED DISABILTIES",SUCCESS=0
 Q SUCCESS
