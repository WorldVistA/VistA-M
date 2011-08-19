DPTLK4 ;ALB/JFP - MAS Patient Look-up Create stub entry patient file ; 09/01/96
 ;;V5.3;PATIENT FILE;**73**;DEC 11,1996
FILE(FLDARR) ; -- Creates stub in patient file
 ;Inputs:
 ;   FLDARR   - array of field elements to file
 ;Outputs:
 ;   0        - sucess
 ;   -1^error - 
 ;
 ; -- Check input
 Q:'$D(FLDARR) "-1^required parameter not passed"
 ; -- New variables
 N Y
 ;
 ; -- Create stub entry in patient file
 S DIC="^DPT(",DIC(0)="L",DLAYGO=2
 ; -- Set X = patient name
 S X=$G(@FLDARR@(2))
 ; -- Set DIR string = SEX;DOB;SSN;PATIENT TYPE;VETERAN;SC
 S DIC("DR")=".02///"_$G(@FLDARR@(4))_";.03///"_$G(@FLDARR@(3))_";.09////"_$G(@FLDARR@(1))_";391///"_$G(@FLDARR@(5))_";1901///"_$G(@FLDARR@(6))_";.301///"_$G(@FLDARR@(7))
 K DD,DO D FILE^DICN
 K DIC,DLAYGO,X
 Q Y
 ;
 I $P(Y,"^",3)'=1 Q "-1^Could not add patient to patient file"
 Q 0
 ;
