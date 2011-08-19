LRDAGE ;DFW/MRL/DALOI/FHS - RETURN TIMEFRAME IN DAYS, MONTHS OR YEARS; 15 MAR 90
 ;;5.2;LAB SERVICE;**279,302**;Sep 27, 1994
 ;Adapted from IDAGE routine
 ;If period is under 31 days then format is nnd where d=days
 ;If period is under 2 years then format is nnm where m=month(s)
 ;In all other cases format is in nny where y=years
 ;
 ;
 ;Entry point from patient file in VA FileManager
 ;
DFN(DFN,FILE,LRCDT) ; Call returns patient age based on specimen collection date
 ; Age is returned as day (dy) month (mo) or years (yr)
 ; DFN = IEN of patient
 ; FILE =  File number where patient is found
 ; LRCDT = Specimen collection date otherwise age will be calculated
 ; using the current date
 ; Sex is a coded value of Male = "M" (default) Female = "F"
 ; DOD = Date of Death
 N LRSAGE
 S:'$G(LRCDT) LRCDT=$$DT^XLFDT
 S LRCDT=$P(LRCDT,".")
 S SEX="M",AGE="99yr"
 D GETS^DIQ(FILE,DFN_",",".02;.03;.351","IE","LRSAGE")
 S SEX=$G(LRSAGE(FILE,DFN_",",.02,"I")) S:$L(SEX)="" SEX="M"
 S DOB=$G(LRSAGE(FILE,DFN_",",.03,"I")) I '$G(DOB) Q
 S DOD=$G(LRSAGE(FILE,DFN_",",.351,"I"))
 S AGE=$$DATE(DOB,LRCDT)
 Q
 ;
DATE(DOB,LRCDT) ;Entry point if passing only a valid Date without patient
 ;  Dates must be defined in VA FileManager internal format.
 ;   DOB, Date of birth
 ;   LRCDT = collection date
 ; Date formate error will return 99yr
 N X,Y,%DT
 I '$G(LRCDT) S LRCDT=$$DT^XLFDT
 S DOB=$P(DOB,".")
 I '$G(DOB) Q "99yr"  ;no DOB passed
 S X=DOB,LRCDT=$P(LRCDT,".")
 I $S(DOB'=+DOB:1,LRCDT'=+LRCDT:1,1:0) Q "99yr"
 I $S(DOB'?7N.NE:1,LRCDT'?7N.NE:1,1:0) Q "99yr"
 D ^%DT I Y'>0 Q "99yr"  ;invalid date
 S X=LRCDT
 K %DT D ^%DT I Y'>0 Q "99yr"  ;invalid date
 ;
CALC ;Calculate timeframe based on difference between DOB and collection
 ; date. Time is stripped off.
 ; .0001-24 hour = dy
 ; 0-29 days = dy
 ; 30-730 dy = mo
 ; >24 mo = yr
 ;
 I DOB>LRCDT Q "99yr"
 I DOB=LRCDT Q "1dy"  ;same dates---pass 1 day old
 S X=$E(LRCDT,1,3)-$E(DOB,1,3)-($E(LRCDT,4,7)<$E(DOB,4,7))
 I X>1 S X=+X_"yr" Q X   ;age 2 years or more---pass in years
 S X=$$FMDIFF^XLFDT(LRCDT,DOB,1)
 I X>30 S X=X\30_"mo" Q X  ;over 30 days---pass in months
 E  S X=X_"dy" Q X  ;under 31 days---pass in days
 Q "99yr"
