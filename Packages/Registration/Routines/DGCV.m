DGCV ;ALB/DW,ERC,BRM,TMK,LBD - COMBAT VET ELIGIBILTY; 10/15/05 ; 6/16/09 10:40am
 ;;5.3;Registration;**528,576,564,673,778,792,797**; Aug 13, 1993;Build 24
 ;
CVELIG(DFN) ;
 ;API will determine whether or not this veteran needs to have CV End
 ;Date set.  If this determination cannot be done due to imprecise
 ;or missing dates, it returns which dates need editing.
 ;Input:
 ;  DFN - Patient file IEN
 ;Output
 ;  RESULT
 ;    0 - CV End Date should not be set
 ;    1 - CV End Date should be set
 ;  If critical dates are imprecise return the following
 ;    A - CV End Date should not be set, imprecise Service Sep date
 ;    B - CV End Date should not be set, imprecise Combat To date
 ;    C - CV End Date should not be set, imprecise Yugoslavia To date
 ;    D - CV End Date should not be set, imprecise Somalia To date
 ;    E - CV End Date should not be set, imprecise Pers Gulf To date
 ;  If the Service Sep Date is missing, and there are no OEF/OIF/UNKNOWN
 ;    OEF/OIF records on file, return the following so that it  will
 ;    appear on the Imprecise/Missing Date Report
 ;    F - missing Service Sep Date & no OEF OIF or OEF/OIF Unknown dates
 ;  If critical dates are missing but the corresponding indicator fields
 ;    are set to 'YES' return the following
 ;    G - missing Combat To Date, but Combat Indicated? = 'Yes'
 ;    H - missing PG To Date, but PG Indicated? = 'Yes'
 ;    I - missing Somalia To Date, but Somalia Indicator = 'Yes'
 ;    J - missing Yugoslavia To Date, but Yugoslavia Indicator = 'Yes'
 ;
 N DG1,DG2,I,RESULT
 N DGCOM,DGCVDT,DGCVFLG,DGGULF,DGSOM,DGSRV,DGYUG,DGOEIF
 S (DG1,DG2,RESULT)=0
 I $G(DFN)']"" Q RESULT
 I '$D(^DPT(DFN)) Q RESULT
 ;
 ;get combat related data from top-level VistA fields
 N DGARR,DGERR
 D GETS^DIQ(2,DFN_",",".327;.322012;.322018;.322021;.5294;.5295","I","DGARR","DGERR")
 D PARSE
 ;
 S DG1=$$CHKSSD(DFN) ;check SSD for imprecise or missing
 S DGDATE=$G(DGCOM)_"^"_$G(DGYUG)_"^"_$G(DGSOM)_"^"_$G(DGGULF)_"^"_$G(DGOEIF)
 ;
 I $S(DG1="F":1,1:$P(DGDATE,U,5)>$G(DGSRV)) D
 . ; Use OIF/OEF/UNKNOWN OEF/OIF to dt only when SSD missing or SSD less
 . ; than OIF/OEF/UNKNOWN OEF/OIF to dt
 . N DGSRV,Z
 . S DGSRV=$P(DGDATE,U,5),Z=$$CHKSSD(DFN)
 . I Z=1 S DG1=Z
 ;
 S DG2=$$CHKREST(DGDATE,$G(DGSRV)) ;check other "TO" dates for imprecise, missing or invalid
 S RESULT=$$RES(DG1,$G(DG2))
 Q RESULT
 ;
RES(DG1,DG2) ;determine the final RESULT code from DG1 & DG2
 ;if SSD evaluates to earlier than 11/11/98, can't set CV End Date
 I DG1=0!($G(DG2)=0) Q 0
 ;if SSD is 1
 I DG1=1,($G(DG2)=1!($G(DG2)']"")) Q 1
 I DG1=1,($G(DG2)=0) Q 0
 I DG1=1 Q DG2
 ;if SSD is imprecise or missing
 I DG1'=1,($G(DG2)=1) S DG2=""
 Q DG1_DG2
 ;
CHKDATE(DGDATE,I,SSD) ;check to see if date is imprecise or missing
 ;if imprecise check to see if the imprecision prevents CV evaluation
 ;if not imprecise check to see if after 11/11/98
 ; Note that SSD doesn't appear to ever be used here (TMK)
 N RES
 S RES=0
 I $G(DGDATE)']"",I'=5 D  Q RES
 . S RES=$S(I=0:"F",I=1:"G",I=2:"H",I=3:"I",I=4:"J",1:"")
 I $E(DGDATE,6,7)="00" D
 . I I=0 I DGDATE>2981111 S RES="A" Q
 . I DGDATE=2980000!(DGDATE=2981100) D  Q
 .. ; Note OIF/OEF/UNKNOWN OEF/OIF will not get here as these dates by
 .. ; definition are after 11/11/98
 . . S RES=$S(I=0:"A",I=1:"B",I=2:"C",I=3:"D",I=4:"E",1:"")
 Q:RES="A" RES
 I DGDATE>2981111 S RES=1
 Q RES
 ;
SETCV(DFN,DGSRV) ;calculate CV end date
 ;    DGSRV is the most recent of the Service Separation Date 
 ;    or the OEF/OIF To Date, called from file #2 new style 
 ;    cross reference "ACVCOM"
 N DGCVEDT,DGFDA
 I $$GET1^DIQ(2,DFN_",",.5295,"I") Q
 S DGCVEDT=$$CALCCV(DFN,DGSRV)
 Q:DGCVEDT=""
 S DGFDA(2,DFN_",",.5295)=DGCVEDT
 D FILE^DIE(,"DGFDA")
 Q
 ;
CALCCV(DFN,DGSRV) ; Calculate CV end date given DFN and date to start 
 ; calculation from
 ; Function returns null or CV end date calculated
 N DGCVEDT,DGNDAA,DGPLUS3,DGTMPDT,DGYRS
 I $G(DFN)']""!($G(DGSRV)']"") Q ""
 I '$D(^DPT(DFN)) Q ""
 S DGNDAA=3080128
 D CVRULES(DFN,DGSRV,DGNDAA,.DGYRS)
 Q:$G(DGYRS)'=3&($G(DGYRS)'=5) ""
 ;NDAA legislation, enacted 1/28/08, gives vets discharged
 ;on or after 1/28/03 (2 years previously) CV Eligibility 
 ;for 5 years.  Vets discharged before 1/28/03 get eligibility 
 ;for 3 years after enactment (or until 1/27/2011) DG*5.3*778
 S DGTMPDT=$S(DGYRS=3:DGNDAA,1:DGSRV)
 S DGCVEDT=($E(DGTMPDT,1,3)+DGYRS)_$E(DGTMPDT,4,7)
 S DGCVEDT=$$FMADD^XLFDT(DGCVEDT,-1)
 Q DGCVEDT
 ;
CVRULES(DFN,DGSRV,DGNDAA,DGYRS) ;apply rules for the CV End Date
 ;extension project - DG*5.3*778
 ;DGSRV - most recent of Service Sep Date or OEIUUF to date
 ;   DGYRS = 3 years from NDAA or 1/27/2011
 ;         = 5 years from SSD or Enrollment App Date
 ;determine how many years extra CV eligibility to give
 N DGCIEN,DGCUTOFF,DGENRDT,DGPIEN,DGPRI,DGQT,DGSTAT
 ;determine if veteran has an enrollment record prior
 ;to 1/28/2008 (the NDAA date) and no CV End Date for
 ;this enrollment
 S DGYRS=5
 S (DGPRI,DGQT)=0
 S DGCUTOFF=3030128
 S DGCIEN=$$FINDCUR^DGENA(DFN)
 I $G(DGCIEN),($D(^DGEN(27.11,DGCIEN,0)))]"" D
 . S DGENRDT=$$GET1^DIQ(27.11,DGCIEN_",",75.01,"I") Q:$G(DGENRDT)']""
 . I $P(DGENRDT,".",1)<DGNDAA S DGPRI=1 Q
 . I DGENRDT'<DGNDAA D
 . . S DGPIEN=DGCIEN
 . . F  S DGPIEN=$$FINDPRI^DGENA(DGPIEN) Q:'DGPIEN  D  Q:DGQT
 . . . S DGENRDT=$$GET1^DIQ(27.11,DGPIEN_",",75.01,"I")
 . . . Q:$G(DGENRDT)']""
 . . . I $P(DGENRDT,".",1)<DGNDAA S (DGPRI,DGQT)=1
 ;if DGPRI=1, then there is an enrollment prior to 1/28/08
 I DGPRI=1 D  Q
 . I $G(DGCIEN)]"" S DGSTAT=$$GET1^DIQ(27.11,DGCIEN_",",.04,"E")
 . I $G(DGSTAT)["INITIAL APPLICATION BY VAMC"!($G(DGSTAT)["BELOW ENROLLMENT GROUP THRESHOLD") D
 . . I DGSRV<DGCUTOFF S DGYRS=3
 ;
 ;if no enrollment prior to 1/28/08 (DGPRI=0) check service date
 ;against cutoff date - 1/28/03
 I DGSRV<DGCUTOFF S DGYRS=3
 Q
 ;
CVEDT(DFN,DGDT) ;Provide Combat Vet Eligibility End Date, if eligible
 ;Supported DBIA #4156
 ;Input:  DFN - Patient file IEN
 ;        DGDT - Treatment date (optional), 
 ;               DT is default
 ;Output :RESULT=(1,0,-1)^End Date (if populated, otherwise null)^CV
 ;               Eligible on DGDT(1,0)^is patient eligible on input date?
 ;      (piece 1)  1 - qualifies as a CV
 ;                 0 - does not qualify as a CV
 ;                -1 - bad DFN or date
 ;      (piece 3)  1 - vet was eligible on date specified (or DT)      
 ;                 0 - vet was not eligible on date specified (or DT)
 ;
 N RESULT
 S RESULT=""
 I $G(DFN)="" Q -1
 I '$D(^DPT(DFN)) Q -1
 ;if time sent in, drop time
 I $G(DGDT)']"" S DGDT=DT
 I DGDT?7N1"."1.6N S DGDT=$E(DGDT,1,7)
 I DGDT'?7N Q -1
 S RESULT=$$GET1^DIQ(2,DFN_",",.5295,"I")
 I $G(RESULT)']"" Q 0
 S RESULT=$S(DGDT'>RESULT:RESULT_"^1",1:RESULT_"^0") ; if treatment date is earlier or equal to end date, veteran is eligible
 S RESULT=$S($G(RESULT):1_"^"_RESULT,1:0)
 Q RESULT
 ;
PARSE ;GETS^DIQ called in CVELIG - in this subroutine stuff results into array
 ;If there's MSE data in new MSE sub-file #2.3216 get last
 ;Service Separation Date (DG*5.3*797)
 I $D(^DPT(DFN,.3216)) S DGSRV=$P($$LAST^DGMSEUTL(DFN),U,2)
 E  S DGSRV=$G(DGARR(2,DFN_",",.327,"I"))
 S DGCOM=$G(DGARR(2,DFN_",",.5294,"I")) ;Combat To Date
 S DGGULF=$G(DGARR(2,DFN_",",.322012,"I")) ;Persian Gulf To Date
 S DGSOM=$G(DGARR(2,DFN_",",.322018,"I")) ;Somalia To Date
 S DGYUG=$G(DGARR(2,DFN_",",.322021,"I")) ;Yugoslavia To Date
 S DGCVDT=$G(DGARR(2,DFN_",",.5295,"I")) ;CV End Date
 ; get last OIF/OEF/UNKNOWN OEF/OIF episode from multiple
 S DGOEIF=$P($$LAST^DGENOEIF(DFN),U)
 Q
 ;
CHKSSD(DFN) ;check the Serv Sep Date [Last]
 ; DGSRV=last SSD
 ;  Output - RESULT
 ;    1 - Date is present and after 11/11/1998
 ;    0 - Date is present but before 11/11/1998
 ;    A - Date is imprecise & either is or potentially is after 11/11/98
 ;    F - Date is missing
 N DG1
 I $G(DGSRV)']"" Q "F"
 S DG1=$$CHKDATE(DGSRV,0)
 I $G(DG1)']"" S DG1=0
 Q DG1
 ;
CHKREST(DGDATE,SSD) ;
 ; SSD = optional, = to the last serv sep date
 N DG3,DG4,DGDT,DGFLG,DGLEN,DGQ,DGR,DGRES,DGX
 S (DG3,DG4,DGR,DGRES)=""
 S DGQ=0 ;loop terminator
 S DGFLG=0 ;flag to indicate that one of the dates is missing (no 
 ;          need to check this for OIF/OEF/UNKNOWN OEF/OIF since
 ;          by definition, these must always be post 11/11/98)
 F DGX=1:1:5 D
 . S DGDT=$P(DGDATE,U,DGX) D
 . . I DGX'=5,$G(DGDT)']"" S DGFLG=1
 . . S DG4=$$CHKDATE(DGDT,DGX,$G(SSD))
 . . I $G(DG4)'=0 S DG3=$G(DG3)_$G(DG4)
 S DGLEN=$L(DG3)
 S DGQ=0
 F DGX=1:1:DGLEN S DGCHAR=$E(DG3,DGX) D  Q:DGQ=1
 . I DGCHAR=1 S DG3=DGCHAR,DGQ=1 Q
 . I "BCDE"[DGCHAR S DGR=DGR_DGCHAR,DGQ=2
 I DGQ=1 Q 1
 I DGQ=2 Q $E(DGR)
 I DGFLG=1 S DGRES=$$MISS(DFN,DGLEN,DG3)
 Q DGRES
 ;
MISS(DFN,DGLEN,DGRES) ;there is at least one missing date, and in order to 
 ;return a RESULT of a missing date, need to check to see if the 
 ;corresponding indicator field is set to 'YES'
 N DGARR,DGCHAR,DGERR,DGQ,DGR,DGX
 N DGCIND,DGPGIND,DGSIND,DGYIND
 S (DGCHAR,DGQ,DGR)=0
 D GETS^DIQ(2,DFN_",",".32201;.322019;.322016;.5291","I","DGARR","DGERR")
 S DGCIND=$G(DGARR(2,DFN_",",.5291,"I")) ;Combat Service Indicated
 S DGYIND=$G(DGARR(2,DFN_",",.322019,"I")) ;Yugo service indicated
 S DGSIND=$G(DGARR(2,DFN_",",.322016,"I")) ;Somalia service indicated
 S DGPGIND=$G(DGARR(2,DFN_",",.32201,"I")) ;Pers Gulf service indicated
 F DGX=1:1:DGLEN S DGCHAR=$E(DGRES,DGX) D  Q:DGQ=1
 . I DGCHAR="G",($G(DGCIND)="Y") S DGR="G",DGQ=1 Q
 . I DGCHAR="H",($G(DGYIND)="Y") S DGR="H",DGQ=1 Q
 . I DGCHAR="I",($G(DGSIND)="Y") S DGR="I",DGQ=1 Q
 . I DGCHAR="J",($G(DGPGIND)="Y") S DGR="J"
 Q DGR
DELCV(DFN) ;called by the Kill logic of the ACVCOM cross reference
 ;if $$CVELIG^DGCV returns a 0 the CV End Date should be deleted
 ;because this would indicate that fields have been changed and
 ;CV eligibility is no longer appropriate
 ;
 N DGCV,DGFDA
 K DGCVFLG
 S DGCVFLG=0
 I $G(DFN)']"" Q
 I '$D(^DPT(DFN)) Q
 S DGCV=$$GET1^DIQ(2,DFN_",",.5295,"I")
 I $G(DGCV)']"" Q
 S DGCVFLG=1
 S DGFDA(2,DFN_",",.5295)="@"
 D FILE^DIE(,"DGFDA")
 Q
