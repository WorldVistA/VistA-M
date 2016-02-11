DPTLK4 ;ALB/JFP - MAS Patient Look-up Create stub entry patient file ; 09/01/96
 ;;5.3;Registration;**73,857,915**;Aug 13, 1993;Build 6
FILE(FLDARR,DGVIC40) ; -- Creates stub in patient file
 ;Inputs:
 ;   FLDARR   - array of field elements to file
 ;   DGVIC40  - flag indicating VIC 4.0 card
 ;Outputs:
 ;   0        - sucess
 ;   -1^error - 
 ;
 ; *857 made changes to support new vic 4.0 card (elz)
 ;
 ; -- Check input
 Q:'$D(FLDARR) "-1^required parameter not passed"
 ; -- New variables
 N Y,Z,DIC,SAVY
 ;
 ; -- Create stub entry in patient file
 S DIC="^DPT(",DIC(0)="EL",DLAYGO=2
 ;
 ; -- Set X = patient name
 S X=$S($G(DGVIC40):$G(@FLDARR@(.01)),1:$G(@FLDARR@(2)))
 ;
 ; -- if VIC 4.0 card DIR string = 
 ;    SEX;DOB;SSN;POBCity;POBState;MMN;ICN;ICNCheck;MBI
 I $G(DGVIC40) S DIC("DR")="",Z=.01 F  S Z=$O(@FLDARR@(Z)) Q:'Z  S:Z'=991.01&(Z'=991.02) DIC("DR")=DIC("DR")_Z_$S($L(@FLDARR@(Z)):"///"_@FLDARR@(Z),1:"")_";"
 ;
 ; -- add in other fields for prompt PATIENT TYPE;VETERAN;SC;MBI
 I  S DIC("DR")=DIC("DR")_"391;1901;.301"
 ;
 ; -- Set DIR string (old VIC) = SEX;DOB;SSN;PATIENT TYPE;VETERAN;SC
 E  S DIC("DR")=".02///"_$G(@FLDARR@(4))_";.03///"_$G(@FLDARR@(3))_";.09////"_$G(@FLDARR@(1))_";391///"_$G(@FLDARR@(5))_";1901///"_$G(@FLDARR@(6))_";.301///"_$G(@FLDARR@(7))
 ;
 ; -- set date entered into file (missing from prior vic versions)
 S DIC("DR")=DIC("DR")_";.097////"_DT
 ;
 K DD,DO D FILE^DICN S SAVY=Y
 K DIC,DLAYGO,X
 ;
 ; need to update mpi with icn/correlation
 I Y>0,$G(@FLDARR@(991.01)),$G(@FLDARR@(991.02)),$T(VIC40^MPIFAPI)'="" D VIC40^MPIFAPI(+Y,@FLDARR@(991.01)_"V"_@FLDARR@(991.02))
 Q SAVY
 ;
