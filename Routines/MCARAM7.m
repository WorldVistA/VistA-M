MCARAM7 ;WASH ISC/JKL-MUSE SUMMARY LOOKUP AND FILE IN DHCP ;6/26/96  12:27
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
 ;Lookup for last transmission in Summary file 700.5
 ;USAGE:  S X=$$LSUM^MCARAM7(A,B,.C)
 ;WHERE:  A=Date/time of record in FileMan format
 ;        B=Name of patient equivalent to name in Patient file (#2)
 ;       .C=Array into which data is placed
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0 and a value array:
 ;  C("SUM") = IEN of existing Summary record
 ;  C("PID") = PID of patient
 ;  C("NAME") = name of patient
 ;
 ;variables
 ;MCERR = error message
 ;
LSUM(MCDT,MCNM,MCS) ;
 ; Where MCDT is Date/time of record in FileMan format
 ;       MCNM is Name of patient equivalent to name in Patient file (#2)
 ;       MCS is array into which data is placed
 ;
 ;  Retrieves PID from Name X-ref of Patient file (#2)
 N MCI,DIC,D,X,Y,MCERR S MCS("SUM")=""
 S DIC="^DPT(",DIC(0)="XZ",D="B",X=MCNM D IX^DIC
 I +Y'>0 S MCERR="21-Name for Summary not in Patient file" Q $$LOG^MCARAM7(MCERR)
 S MCS("PID")=+Y,MCS("NAME")=$P(Y(0),U)
 I '$D(^MCAR(700.5,"B",MCDT)) S MCERR="22-Date/Time not in Summary file" Q $$LOG^MCARAM7(MCERR)
 S MCI=0 F  S MCI=$O(^MCAR(700.5,"B",MCDT,MCI)) Q:MCI=""  I $D(^MCAR(700.5,"PT",MCS("NAME"),MCI)) S MCS("SUM")=MCI
 I MCS("SUM")="" S MCERR="23-Name does not exist for Date/Time in Summary file" Q $$LOG^MCARAM7(MCERR)
 Q 0
 ;
KPERR(MCA,MCS) ;Transfer local array data into new 700.5 Summary record in DHCP
 ; occurs for every data transfer attempt whether or not successful
 ;USAGE:  S X=$$KPERR^MCARAM7(.A,.B)
 ;WHERE:  A=Array of local data arranged for EKG file
 ;        B=DHCP data stored in Summary file including
 ;          B("SUM")=IEN of Summary file
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0
 ; MCS("FLDT")=Creation date in 700.5, file date/time 
 ;
 ; Number of attempts of same data record, field 5
 ; Obsolete with transaction processing, still needed for MCARAP* report
 N MCI,%,DIC,X,Y,MCERR
 S MCS(5)=1
 ; Date/Time Initial, creation of entry in Summary file, field .05
 D NOW^%DTC S (MCS("FLDT"),MCS(.05),MCS(.06))=%
 ; Date/Time Latest, latest transmission attempt, field .06
 ; Transaction processing makes latest transmission date/time
 ; same as initial date/time except for those with imaging updates
 ; Auto instrument name, defined in MCARAM, field 1
 S MCS(1)=MCINST
 ; Reason for failure to pass DHCP validity checks, field 4
 S MCS(4)=$$RFFL(.MCA,.MCS)
 ; Social Security Number, field 2
 S MCS(2)=MCA(.02)
 ; Name, field 3
 S MCS(3)=MCA("NAME")
 ; Type of transmission, field 7
 S MCS(7)=MCTYPE
 S MCI=.05,DIC("DR")=".05///"_MCS(.05) F  S MCI=$O(MCS(MCI)) Q:MCI=""!(MCI?1A.A)  S DIC("DR")=DIC("DR")_";"_MCI_"///"_MCS(MCI)
 K DD,DO N DLAYGO S DLAYGO=700.5,DIC="^MCAR(700.5,",DIC(0)="LXZ",X=MCA("DT")
 D FILE^DICN
 I +Y>0 S MCS("SUM")=+Y Q 0
 S MCERR="9-Summary record not filed" Q $$LOG^MCARAM7(MCERR)
 ;
RFFL(MCA,MCS) ; Convert processing errors to 700.5 file fields
 ;USAGE:  S X=$$RFFL^MCARAM7(.A,.B)
 ;WHERE:  A=Array of local data
 ;        B=DHCP data for Summary file including
 ;          B("SUM")=internal record number of Summary file
 ; returns field 4 of 700.5 file, reason for failure
 ;   field 4 : "D"ate/Time error, "L"oad into DHCP error
 ;             "N"ame error, "S"ocial Security Number error
 ;      Integers for specific errors listed in the Summary Print,
 ;      MCARAP2 - Errors numbered >50 have not been filed as EKG records
 ; returns field 6 of 700.5 file, error code for last transmission
 ;   field 6 : "S"uccessful or "U"nsuccessful
 ; MCA("ERR") = # of processing errors
 ;successful transfer attempt
 S MCS(6)="S" I $$GRERR(.MCA)=0 Q ""
 ;unsuccessful transfer attempt
 S MCS(6)="U",MCERR=+MCA("ERR",0)
 I +MCERR=51!(+MCERR=52)!(+MCERR=53) S:$G(MCA("DT"))="" MCA("DT")=MCS("FLDT")
 Q $S(+MCERR>62:"P",+MCERR>60:"M",+MCERR>57:"L",+MCERR>55:"N",+MCERR>53:"S",+MCERR>50:"D",1:+MCERR)
 ;
GRERR(MCA) ;Find first fatal error
 ;USAGE:  S X=$$GRERR(A)
 ;WHERE:  A=array of local data
 ;        if successful, returns 1 and A("ERR",0)=first fatal error >50
 ;        if unsuccessful, returns 0
 ;variables MCERR,MCI,MCJ
 N MCERR,MCI,MCJ
 I MCA("ERR")=0 Q 0
 S MCI=MCA("ERR") F MCJ=1:1:MCI I +MCA("ERR",MCJ)>50 S MCERR=MCA("ERR",MCJ) Q
 I $D(MCERR) S MCA("ERR",0)=MCERR Q 1
 Q 0
 ;
LOG(MCERR) ;Logs type of error in local array
 ;USAGE:  S X=$$LOG^MCARAM7(A)
 ;WHERE:  A=Free text error
 ;  returns the error message and updates the error array
 S MCA("ERR")=MCA("ERR")+1,MCA("ERR",MCA("ERR"))=MCERR
 Q MCERR
