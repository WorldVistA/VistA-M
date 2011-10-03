MCARAM6 ;WASH ISC/JKL-MUSE LOOKUP IN DHCP ;5/2/96  12:49
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
 ;Lookup for last record in EKG file given a date/time and SSN
 ;USAGE:  S X=$$LSSN^MCARAM6(A,B,.C)
 ;WHERE:  A=Date/time of record in FileMan format
 ;        B=Social Security Number in consecutive digits
 ;       .C=Array into which data is placed
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0 and a value array:
 ;  C("EKG") = IEN of existing EKG record
 ;  C(1) = PID of patient, field 1, Medical Patient
 ;  C("NAME") = name of patient
 ;
 ;variables
 ;MCERR = error message
 ;
LSSN(MCDT,MCSS,MCP) ;
 ; Where MCDT is Date/time of record in FileMan format
 ;       MCSS is Social Security Number in consecutive digits
 ;       MCP is array into which data is placed
 ;
 ;  Retrieves PID from SSN X-ref of Patient file
 N MCI,DIC,D,X,Y S MCP("EKG")=""
 S DIC="^DPT(",DIC(0)="XZ",D="SSN",X=MCSS D IX^DIC
 I +Y'>0 S MCERR=$$EMPSSN(MCSS,.Y) I +MCERR=55 Q MCERR
 S MCP(1)=+Y,MCP("NAME")=$P(Y(0),U)
 I '$D(^MCAR(691.5,"B",MCDT)) S MCERR="12-Date/Time not in EKG file" Q $$LOG^MCARAM7(MCERR)
 S MCI=0 F  S MCI=$O(^MCAR(691.5,"B",MCDT,MCI)) Q:MCI=""  I $D(^MCAR(691.5,"C",MCP(1),MCI)) S MCP("EKG")=MCI
 I MCP("EKG")="" S MCERR="15-PID does not exist for Date/Time" Q $$LOG^MCARAM7(MCERR)
 Q 0
 ;
ERR ;Error return
 Q MCERR
 ;
EMPSSN(MCSS,Y) ;Determine if unretrievable SSN belongs to an employee
 ;USAGE:  S X=$$EMPSSN^MCARAM6(A,.B)
 ;WHERE:  A=Social Security Number
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0 and an array:
 ;    B = patient id , B(0) = patient name
 ;
 N MCEPID,MCEMP,DIC,D,X,Y
 S MCERR="55-Social Security Number not in Patient file"
 I '$D(^DPT("SSN",MCSS)) Q MCERR
 S MCEPID=$O(^DPT("SSN",MCSS,0))
 I '$D(^DPT(MCEPID,.36)) G STYPE
 ;  Retrieves Employee entry from Eligibility Code file
SELIG S DIC="^DIC(8,",DIC(0)="XZ",D="B",X="EMPLOYEE" D IX^DIC
 I +Y'>0 G STYPE
 S MCEMP=+Y
 I ^DPT(MCEPID,.36)=MCEMP,$D(^DPT(MCEPID,0)) S Y=MCEPID,Y(0)=$P(^DPT(MCEPID,0),"^") Q 0
STYPE I '$D(^DPT(MCEPID,"TYPE")) Q MCERR
 ;  Retrieves Employee entry from Type of Patient file
 S DIC="^DG(391,",DIC(0)="XZ",D="B",X="EMPLOYEE" D IX^DIC
 I +Y'>0 Q MCERR
 S MCEMP=+Y
 I ^DPT(MCEPID,"TYPE")=MCEMP,$D(^DPT(MCEPID,0)) S Y=MCEPID,Y(0)=$P(^DPT(MCEPID,0),"^") Q 0
 Q MCERR
 ;
 ;Lookup for last record in EKG file given a date/time and full name
 ;USAGE:  S X=$$LNAME^MCARAM6(A,B,.C)
 ;WHERE:  A=Date/time of record in FileMan format
 ;        B=Full Name in DHCP format
 ;       .C=Array into which data is placed
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0 and a value array:
 ;  C("EKG") = IEN of existing EKG record
 ;  C(1) = PID of patient, field 1, Medical Patient
 ;  C("NAME") = name of patient
 ;
 ;variables
 ;MCERR = error message
 ;
LNAME(MCDT,MCNAME,MCP) ;
 ; Where MCDT is Date/time of record in FileMan format
 ;       MCNAME is Full Name in DHCP format
 ;       MCP is array into which data is placed
 ;
 ;  Retrieves PID from Name X-ref of Patient file
 N MCI,DIC,D,X,Y S MCP("EKG")=""
 S DIC="^DPT(",DIC(0)="XZ",D="B",X=MCNAME D IX^DIC
 I +Y'>0 S MCERR=$$EMPNAME(MCNAME,.Y) I +MCERR=56 Q MCERR
 S MCP(1)=+Y,MCP("NAME")=$P(Y(0),U)
 I '$D(^MCAR(691.5,"B",MCDT)) S MCERR="12-Date/Time not in EKG file" Q $$LOG^MCARAM7(MCERR)
 S MCI=0 F  S MCI=$O(^MCAR(691.5,"B",MCDT,MCI)) Q:MCI=""  I $D(^MCAR(691.5,"C",MCP(1),MCI)) S MCP("EKG")=MCI
 I MCP("EKG")="" S MCERR="15-PID does not exist for Date/Time" Q $$LOG^MCARAM7(MCERR)
 Q 0
 ;
EMPNAME(MCNAME,Y) ;Determine if unretrievable name belongs to an employee
 ;USAGE:  S X=$$EMPNAME^MCARAM6(A,.B)
 ;WHERE:  A = Name
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0 and an array:
 ;    B = patient id , B(0) = patient name
 ;
 N MCEPID,MCEMP,DIC,D,X,Y
 S MCERR="56-Name does not match Patient file"
 I '$D(^DPT("B",MCNAME)) Q MCERR
 S MCEPID=$O(^DPT("B",MCNAME,0))
 I '$D(^DPT(MCEPID,.36)) G NTYPE
 ;  Retrieves Employee entry from Eligibility Code file
NELIG S DIC="^DIC(8,",DIC(0)="XZ",D="B",X="EMPLOYEE" D IX^DIC
 I +Y'>0 G NTYPE
 S MCEMP=+Y
 I ^DPT(MCEPID,.36)=MCEMP,$D(^DPT(MCEPID,0)) S Y=MCEPID,Y(0)=$P(^DPT(MCEPID,0),"^") Q 0
NTYPE I '$D(^DPT(MCEPID,"TYPE")) Q MCERR
 ;  Retrieves Employee entry from Type of Patient file
 S DIC="^DG(391,",DIC(0)="XZ",D="B",X="EMPLOYEE" D IX^DIC
 I +Y'>0 Q MCERR
 S MCEMP=+Y
 I ^DPT(MCEPID,"TYPE")=MCEMP,$D(^DPT(MCEPID,0)) S Y=MCEPID,Y(0)=$P(^DPT(MCEPID,0),"^") Q 0
 Q MCERR
