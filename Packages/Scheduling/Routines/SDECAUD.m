SDECAUD ; ALB/WTC - VISTA SCHEDULING - Audit Statistics Compiler ;
 ;;5.3;Scheduling;**686**;Aug 13, 1993;Build 53
 ;;Per VHA Directive 2004-038, this routine should not be modified
    ;
    Q  ;
    ;
BKGND   ;
    ;
    ;  Compile statistics for yesterday.
    ;
    D COMPILE() ;
    Q  ;
    ;
SELECT  ;
    ;
    ;  Compile statistics for selected date or range of dates.
    ;
    N DATE,DATE1,DATE2,%DT,Y,I,X1,X2,X,TODAY ;
    ;
    D NOW^%DTC S TODAY=X ;
    W !,"Compile audit statistics for a date or date range.",! ;
SELECT1 ;
    S %DT="AEX",%DT("A")="Begin date: " D ^%DT Q:Y<0  I Y'<TODAY W "...Must be earlier than today.",! G SELECT1 ;
    S DATE1=Y ;
SELECT2 ;
    S %DT="AEX",%DT("A")="End date: " D ^%DT Q:Y<0  I Y'<TODAY W "...Must be earlier than today.",! G SELECT2 ;
    S DATE2=Y ;
    I DATE1>DATE2 W "... Dates entered out of sequence.  Re-enter.",! G SELECT ;
    ;
    ;  Compile data for each date in range but skip a date if compile previously run for that date.
    ;
    F I=0:1 S X1=DATE1,X2=I D C^%DTC S DATE=X Q:DATE>DATE2  D  ;
    . W ! S Y=DATE D DD^%DT W Y ;
    . I $D(^SDAUDIT("C",DATE)) W "...previously compiled.  Skipped." Q  ;
    . D COMPILE(DATE) W "...compiled." ;
    Q  ;
    ;
COMPILE(DATE)   ;
    ;
    ;  Compile audit statistics for a date.  If date not specified, use yesterday.
    ;
    K ^TMP($J) ;
    N D1,CLERK,DA,X,TYPE,MRTC,APPTDATE,STATUS,PIECE,GLOBAL,DIC,DA1,DLAYGO,FLD ;
    ;
    I $G(DATE)="" S DATE=$$HTFM^XLFDT($H-1,1) ;
    ;
    ;  Do not compile if done previously.
    ;
    I $D(^SDAUDIT("C",DATE)) Q  ;
    ;
    ;  Loop thru date/user cross-reference in the SDEC APPT REQUEST file (#409.85) and count APPT and MRTC Requests opened.
    ;
    S D1=DATE-.001 F  S D1=$O(^SDEC(409.85,"AC",D1)) Q:'D1  Q:D1\1'=DATE  D  ;
    .   ;
    .   S CLERK=0 F  S CLERK=$O(^SDEC(409.85,"AC",D1,CLERK)) Q:'CLERK  D  ;
    ..  ;
    ..  ; Initialize statistics counters for the user.
    ..  ;
    ..  I '$D(^TMP($J,CLERK,DATE)) S ^TMP($J,CLERK,DATE)="0^0^0^0^0^0^0^0^0^0^0^0^0" ;
    ..  ;
    ..  S DA=0 F  S DA=$O(^SDEC(409.85,"AC",D1,CLERK,DA)) Q:'DA  S X=^SDEC(409.85,DA,0) D  ;
    ... ;
    ... ;  Parse request data
    ... ;
    ... S TYPE=$P(X,"^",5),APPTDATE=$P(X,"^",23),STATUS=$P(X,"^",17) ;
    ... S MRTC=+$P($G(^SDEC(409.85,DA,3)),"^",1) ;
    ... ;
    ... ;  APPT request made
    ... ;
    ... I TYPE="APPT",MRTC=0 S $P(^(DATE),"^",2)=$P(^TMP($J,CLERK,DATE),"^",2)+1 ;
    ... ;
    ... ;  MRTC request
    ... ;
    ... I MRTC=1 S $P(^(DATE),"^",5)=$P(^TMP($J,CLERK,DATE),"^",5)+1 ;
    ;
    ;    Loop thru date/user cross-reference in the RECALL REMINDERS file (#403.5) and count PtCSch entries added.
    ;
    S D1=DATE-.001 F  S D1=$O(^SD(403.5,"AC",D1)) Q:'D1  Q:D1\1'=DATE  D  ;
    .   ;
    .   S CLERK=0 F  S CLERK=$O(^SD(403.5,"AC",D1,CLERK)) Q:'CLERK  D  ;
    ..  ;
    ..  I '$D(^TMP($J,CLERK,DATE)) S ^TMP($J,CLERK,DATE)="0^0^0^0^0^0^0^0^0^0^0^0^0" ;
    ..  S $P(^(DATE),"^",10)=$P(^TMP($J,CLERK,DATE),"^",10)+1 ;
    ;
    ;    Loop thru date/user cross-reference in the SD WAIT LIST file (#409.3) and count EWL entries made.
    ;
    S D1=DATE-.001 F  S D1=$O(^SDWL(409.3,"AC",D1)) Q:'D1  Q:D1\1'=DATE  D  ;
    .   ;
    .   S CLERK=0 F  S CLERK=$O(^SDWL(409.3,"AC",D1,CLERK)) Q:'CLERK  D  ;
    ..  ;
    ..  I '$D(^TMP($J,CLERK,DATE)) S ^TMP($J,CLERK,DATE)="0^0^0^0^0^0^0^0^0^0^0^0^0" ;
    ..  S $P(^(DATE),"^",7)=$P(^TMP($J,CLERK,DATE),"^",7)+1 ;
    ;
    ;   Loop thru date appointment made cross-reference in the SDEC APPOINTMENT file (#409.84) and count appointments
    ;   made by type (EWL, Consult, PtCSch, APPT).  Increment request closed for each appointment made.
    ;
    S DA=0 F  S DA=$O(^SDEC(409.84,"AC",DATE,DA)) Q:'DA  S CLERK=$P(^SDEC(409.84,DA,0),"^",8),TYPE=$P($G(^SDEC(409.84,DA,2)),"^",1) D  ;
    .   ;
    .   Q:CLERK=""  ;  Skip if data missing
    .   ;
    .   S PIECE=$S($P(TYPE,";",2)="SDWL(409.3,":8,$P(TYPE,";",2)="GMR(123,":12,$P(TYPE,";",2)="SD(403.5,":11,$P(TYPE,";",2)="SDEC(409.85,":3,1:0) ;
    .   Q:'PIECE  ;
    .   I '$D(^TMP($J,CLERK,DATE)) S ^TMP($J,CLERK,DATE)="0^0^0^0^0^0^0^0^0^0^0^0^0" ;
    .   ;
    .   ;  Update appointment made.
    .   ;
    .   S $P(^(DATE),"^",PIECE)=$P(^TMP($J,CLERK,DATE),"^",PIECE)+1 ;
    .   ;
    .   ;  Update APPT or EWL request closed.
    .   ;
    .   S PIECE=$S($P(TYPE,";",2)="SDWL(409.3,":9,$P(TYPE,";",2)="SDEC(409.85,":4,1:0) Q:'PIECE  ;
    .   ;
    .   ;  Determine if APPT request is MRTC
    .   ;
    .   I $P(TYPE,";",2)="SDEC(409.85," S PTR=$P(TYPE,";",1),MRTC=+$P($G(^SDEC(409.85,PTR,3)),"^",1) I MRTC S PIECE=6 ;
    .   ;
    .   ;  Update request closed
    .   ;
    .   S $P(^(DATE),"^",PIECE)=$P(^TMP($J,CLERK,DATE),"^",PIECE)+1 ;
    ;
    ;    Loop thru date appointment cancelled cross-reference in the SDEC APPOINTMENT file (#409.84) and count cancellations.
    ;
    S D1=DATE-.001 F  S D1=$O(^SDEC(409.84,"AD",D1)) Q:'D1  Q:D1\1'=DATE  D  ;
    .   ;
    .   S DA=0 F  S DA=$O(^SDEC(409.84,"AD",D1,DA)) Q:'DA  S CLERK=$P(^SDEC(409.84,DA,0),"^",21) D  ;
    ..  ;
    ..  Q:CLERK=""  ;  Skip if data is missing
    ..  ;
    ..  I '$D(^TMP($J,CLERK,DATE)) S ^TMP($J,CLERK,DATE)="0^0^0^0^0^0^0^0^0^0^0^0^0" ;
    ..  S $P(^(DATE),"^",13)=$P(^TMP($J,CLERK,DATE),"^",13)+1 ;
    ;
    ;    Loop thru date/time-user cross-reference in SDEC CONTACTS file (#409.86) and count contacts.
    ;
    S D1=DATE-.001 F  S D1=$O(^SDEC(409.86,"AD",D1)) Q:'D1  Q:D1\1'=DATE  D  ;
    .   ;
    .   S CLERK=0 F  S CLERK=$O(^SDEC(409.86,"AD",D1,CLERK)) Q:'CLERK  D  ;
    ..  ;
    ..  S DA=0 F  S DA=$O(^SDEC(409.86,"AD",D1,CLERK,DA)) Q:'DA  D  ;
    ... S DA1=0 F  S DA1=$O(^SDEC(409.86,"AD",D1,CLERK,DA,DA1)) Q:'DA1  D  ;
    ....    I '$D(^TMP($J,CLERK,DATE)) S ^TMP($J,CLERK,DATE)="0^0^0^0^0^0^0^0^0^0^0^0^0" ;
    ....    S $P(^(DATE),"^",1)=$P(^TMP($J,CLERK,DATE),"^",1)+1 ;
    ;
    ;
    ;  Update the SD Audit Statistics file (#409.97)
    ;
    S GLOBAL=^DIC(409.97,0,"GL") ;
    S CLERK=0 F  S CLERK=$O(^TMP($J,CLERK)) Q:'CLERK  D  ;
    .   ;
    .   K DO S DIC=GLOBAL,DIC(0)="FL",DLAYGO="409.97",X=CLERK,DIC("DR")="1////"_DATE ;
    .   F FLD=2:1:14 S DIC("DR")=DIC("DR")_";"_FLD_"////"_$P(^TMP($J,CLERK,DATE),"^",FLD-1) ;
    .   D FILE^DICN ;
    ;
    K ^TMP($J) ;
    ;
    Q  ;
    ;
    ;*zeb+tag 2/28/18 686 return compiled data
    ;--------------------
    ;SUMMGET2 - Return compiled Audit Report data via RPC
    ;--------------------
    ;Parameters
    ;----------
    ;SDECRET - global reference to array with return values
    ;SDBEG   - start date for reporting; defaults to 1/2/1841
    ;SDEND   - end date for reporting; defaults to 10/15/2114
    ;USER    - IEN of a user to report on; defaults to all users
    ;----------
    ;Returns (one row for each user)
    ;----------
    ;USERIEN  - user's IEN
    ;USERNAME - user's name
    ;CONTACTS - number of patient contacts
    ;APPTOPEN - number of APPT requests opened
    ;APPTMADE - number of appointments made for APPT requests
    ;APPTCLSD - number of APPT requests closed
    ;MRTCOPEN - number of MRTC requests opened
    ;MRTCCLSD - number of MRTC requests closed
    ;EWLOPEN  - number of EWL requests opened
    ;EWLMADE  - number of appointments made for EWL requests
    ;EWLCLSD  - number of EWL requests closed
    ;PTCSOPEN - number of PtCSch requests opened
    ;PTCSMADE - number of appointments made for PtCSch requests
    ;CNSLTMD  - number of appointments made for consults
    ;APPTCXLD - number of appointments canceled
    ;ACTIONS  - total number of actions
SUMMGET2(SDECRET,SDBEG,SDEND,USER)  ;Get compiled Audit Report for a given date range
 N X,Y,%DT,U,X1,X2
 N SDTMP,SDECLN,SDSTATS,SDPC,SDDT,SDASIEN,SDASDATA
 S U="^"
 ;translate dates to FM format
 I SDBEG]"" S %DT="" S X=$P(SDBEG,"@",1) D ^%DT S SDBEG=Y S:Y=-1 SDBEG=1410102 I 1
 E  S SDBEG=1410102 ;default begin date
 I SDEND]"" S %DT="" S X=$P(SDEND,"@",1) D ^%DT S SDEND=Y S:Y=-1 SDEND=4141015 I 1
 E  S SDEND=4141015 ;default end date
 ;check user
 I USER]"",'$D(^VA(200,+USER,0)) S USER=""
 ;set up return array
 S SDECRET="^TMP(""SDECAUD"","_$J_",""SUMMGET2"")"  ;global reference to return array
 K @SDECRET
 S SDECLN=0
 ;set up column headers for return array
 ;              1             2              3              4               5             6
 S SDTMP="T00030USERIEN^T00030USERNAME^T00030CONTACTS^T00030APPTOPEN^T00030APPTMADE^T00030APPTCLSD"
 ;                     7              8              9             10            11
 S SDTMP=SDTMP_"^T00030MRTCOPEN^T00030MRTCCLSD^T00030EWLOPEN^T00030EWLMADE^T00030EWLCLSD"
 ;                     12             13             14            15             16
 S SDTMP=SDTMP_"^T00030PTCSOPEN^T00030PTCSMADE^T00030CNSLTMD^T00030APPTCXLD^T00030ACTIONS"
 S @SDECRET@(SDECLN)=SDTMP_$C(30)
 ;if a single user is specified, loop over x-ref for dates for that user
 I USER]"" D  I 1
 .S SDSTATS="0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 .S X1=SDBEG,X2=-1 D C^%DTC S SDDT=X
 .F  S SDDT=$O(^SDAUDIT("E",USER,SDDT)) Q:SDDT=""  Q:SDDT>SDEND  D
 ..S SDASIEN=""
 ..F  S SDASIEN=$O(^SDAUDIT("E",USER,SDDT,SDASIEN)) Q:SDASIEN=""  D
 ...S SDASDATA=^SDAUDIT(SDASIEN,0)
 ...S $P(SDASDATA,U,16)=$$GET1^DIQ(409.97,SDASIEN_",",15) ;field 15 is computed, so isn't in global
 ...F SDPC=1:1:14 S $P(SDSTATS,U,SDPC)=$P(SDSTATS,U,SDPC)+$P(SDASDATA,U,SDPC+2)
 .S SDECLN=SDECLN+1
 .S SDTMP=USER_U_$$GET1^DIQ(200,USER_",",.01)_U_SDSTATS
 .S @SDECRET@(SDECLN)=SDTMP_$C(30)
 ;otherwise, loop over x-ref for users for those dates
 E  D
 .F  S USER=$O(^SDAUDIT("E",USER)) Q:USER=""  D
 ..S SDSTATS="0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 ..S X1=SDBEG,X2=-1 D C^%DTC S SDDT=X
 ..F  S SDDT=$O(^SDAUDIT("E",USER,SDDT)) Q:SDDT=""  Q:SDDT>SDEND  D
 ...S SDASIEN=""
 ...F  S SDASIEN=$O(^SDAUDIT("E",USER,SDDT,SDASIEN)) Q:SDASIEN=""  D
 ....S SDASDATA=^SDAUDIT(SDASIEN,0)
 ....S $P(SDASDATA,U,16)=$$GET1^DIQ(409.97,SDASIEN_",",15) ;field 15 is computed, so isn't in global
 ....F SDPC=1:1:14 S $P(SDSTATS,U,SDPC)=$P(SDSTATS,U,SDPC)+$P(SDASDATA,U,SDPC+2)
 ..Q:SDSTATS="0^0^0^0^0^0^0^0^0^0^0^0^0^0"  ;don't send back if user has no data to send
 ..S SDECLN=SDECLN+1
 ..S SDTMP=USER_U_$$GET1^DIQ(200,USER_",",.01)_U_SDSTATS
 ..S @SDECRET@(SDECLN)=SDTMP_$C(30)
 Q
