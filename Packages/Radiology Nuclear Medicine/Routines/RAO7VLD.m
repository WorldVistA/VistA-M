RAO7VLD ;HISC/GJC-Validate OE/RR data to Rad (frontdoor) ;1/6/98  13:02
 ;;5.0;Radiology/Nuclear Medicine;**75**;Mar 16, 1998;Build 4
 ;
EN1(RAA,RAB,RAC,RAX,RAY,RAZ) ; Pass in parameters to validate data
 ; Returns '0' if data is valid, '1' if data is invalid
 ; This call is not used on pointer type data fields.
 ;                ***** variable list *****
 ; RAA=file #                RAB=field #
 ; RAC=flag parameters       RAX=value being checked
 ; RAY=result of call array  RAZ=Error Array (not used)
 ;***********************************************************************
 K %DT(0) D CHK^DIE(RAA,RAB,RAC,RAX,.RAY)
 Q $S(RAY["^":1,1:0)
 ;
EN2(T1,T2,T3) ;
 ; Pass in parameters to validate pointer type data.
 ; This call is only used on pointer type data fields.
 ;                ***** variable list *****
 ; T1=file #       T2=IEN (if app)      T3=.01 fields value
 ; X=0 if proper match, 1 if no match   Y=global node (assumed to be '0')
 ;***********************************************************************
 N X,Y,Z S X=0
 F Z=$G(T1),$G(T2),$G(T3) S:Z']"" X=1 Q:X
 Q:X X ; all parameters must be defined
 S Y=$G(@(^DIC(T1,0,"GL")_T2_",0)"))
 Q $S($P(Y,"^")=T3:0,1:1)
EN3(X,Y) ; does entry exist in a file
 ; X-> file #        'Y'-> ien
 ; 0 if entry exists, 1 if entry does not exist
 Q $S($D(@(^DIC(+X,0,"GL")_+Y_",0)"))#2:0,1:1)
 ;
EN4(X) ;P75 Check CPRS entered CLINICAL HISTORY text for validity.
 ;This function returns: 1 if the string is valid else 0.
 ;Please note that once the data is valid, (a minimum of two
 ;alphanumeric characters on a character string) subsequent data
 ;strings may not be valid but are still stored. 
 N CHAR,CNT,FLG,I,LEN S (CNT,FLG)=0,LEN=$L(X)
 F I=1:1:LEN D  Q:FLG
 .S CHAR=$E(X,I)
 .S:CHAR?1AN CNT=CNT+1
 .I CHAR'?1AN,(CNT) S CNT=0
 .S:CNT=2 FLG=1
 .Q
 Q FLG
 ;
EN5(RAD0,RANSTAT,RADUZ,RAREA) ; update the 'REQUEST STATUS TIMES' multiple
 ; in the Rad/Nuc Med Orders file.  All parameters must be in the
 ; internal format.
 ; RAD0=top level ien                 RANSTAT=new status
 ; RADUZ=user ien                     RAREA=reason for status change
 ; Pass back '1' if error, '0' if no error.
 N ARR
 S ARR(7,75.12,"+1,"_RAD0_",",".01")=RALDT
 S ARR(7,75.12,"+1,"_RAD0_",",2)=RANSTAT
 S ARR(7,75.12,"+1,"_RAD0_",",3)=RADUZ
 S ARR(7,75.12,"+1,"_RAD0_",",4)=RAREA
 D UPDATE^DIE("","ARR(7)")
 Q +$G(DIERR)
EN6(X) ; Check if parent procedure has descendents
 ; Passes back: 0 if descendents else 1
 ; X is the ien of the procedure (71)
 Q $S(+$O(^RAMIS(71,X,4,0)):0,1:1)
