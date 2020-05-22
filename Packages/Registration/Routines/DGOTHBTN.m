DGOTHBTN ;SLC/SS,RM - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ;03/27/2019
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;ICR#   TYPE       DESCRIPTION
 ;-----  ----       ---------------------
 ; 2056  Sup        ^DIQ  : GETS
 ;10103  Sup        ^XLFDT: $$FMADD,$$FMDIFF
 ;
 ;This API provides the exact text to display in OTH button and pop-up message in CPRS
 ;Will be called by OROTHCL code, that is used by ORTHCL GET RPC
 ;
 ;ATTENTION: Here below is what the ORTHCL GET RPC is supposed to return to GUI code 
 ;           (actual return values of this API below not necessarily should be the same 
 ;           but need to provide all information to support OR M-code that will pass it to the OR RPC) ;
 ;
 ;If RET(0)<0 : error code less than zero ^ error message - it is an error, and do not display anything
 ;
 ; 
 ;If RET(0)=0 : then do not display anything
 ;
 ;
 ;for OTH-MST,COMBAT,PROV ========================
 ;
 ;RET(0) - number of lines 
 ;   Example for OTH-MST:  RET(0)=5
 ;   Example for OTH-CBMT:  RET(0)=5
 ;   Example for OTH-PROV:  RET(0)=5
 ;
 ;RET(1)= Text for the 1st line on the button ^ Text to display when hover over the 1st line on the button
 ;   Example for OTH-MST:  RET(1)="OTH-MST^Other than Honorable, click for details"
 ;   Example for OTH-CBMT:  RET(1)="OTH-CMBT^Other than Honorable, click for details"
 ;   Example for OTH-PROV:  RET(1)="OTH-PROV^Other than Honorable, click for details"
 ;
 ;RET(2)= Text for the 2nd line on the button^Text to display when hover over the 2nd line on the button
 ;   Example for OTH-MST:  RET(2)=""
 ;   Example for OTH-CBMT:  RET(2)=""
 ;   Example for OTH-PROV:  RET(2)=""
 ;
 ;RET(3)= Text for the 1st line of the button-click message ^ Text for the 1st line of the warning popup message
 ;   Example for OTH-MST:  RET(3)="Other than Honorable"
 ;   Example for OTH-CBMT:  RET(3)="Other than Honorable"
 ;   Example for OTH-PROV:  RET(3)="Other than Honorable"
 ;
 ;RET(4)= Text for the 2nd line on the popup message^Text for the 2nd line of the warning popup message
 ;   Example for OTH-MST:  RET(4)="Eligible for Mental Health care only"
 ;   Example for OTH-CBMT:  RET(4)="Eligible for Mental Health care only"
 ;   Example for OTH-PROV:  RET(4)="Eligible for Mental Health care only"
 ;
 ;RET(5)= Text for the 3rd line on the popup message^Text for the 3nd line of the warning popup message
 ;   Example for OTH-MST:  RET(5)="Not time limited"
 ;   Example for OTH-CBMT:  RET(5)="Not time limited"
 ;   Example for OTH-PROV:  RET(5)="Not time limited"
 ;
 ;
 ;for OTH-90 ========================
 ;
 ;RET(0) - number of lines 
 ;   Example for OTH-90:  RET(0)=5
 ;
 ;RET(1)= Text for the 1st line on the button ^ Text to display when hover over the 1st line on the button
 ;   Example for OTH-90:  RET(1)="OTH^Other than Honorable, click for details"
 ;
 ;RET(2)= Text for the 2nd line on the button^Text to display when hover over the 2nd line on the button
 ;   Example for OTH-90:  RET(2)="70D,P2^70 days left in period 2"
 ;   Example for OTH-90:  RET(2)="4D,P2^4 days left in period 2"
 ;
 ; 
 ;RET(3)= Text for the 1st line of the button-click message ^ Text for the 1st line of the warning popup message
 ;   Example for OTH-90:  RET(3)="70 days left in period 2"
 ;   Example for OTH-90:  RET(3)="4 days left in period 2^you have only 4 days left in the current period"
 ;
 ;RET(4)= Text for the 2nd line on the popup message^Text for the 2nd line of the warning popup message
 ;   Example for OTH-90:  RET(4)="Authorization is required for the further care"
 ;   Example for OTH-90:  RET(4)="Authorization is required for the further care^Authorization is required for the next period"
 ;
 ;RET(5)= Text for the 3rd line on the popup message^Text for the 3nd line of the warning popup message
 ;   Example for OTH-90:  RET(5)="Call registration for details"
 ;
OTHBTN(DGDFN,DGDATE,RET) ;
 N DGEXP,DGTYP
 S DGEXP=$$GETEXPR^DGOTHD(DGDFN)
 I DGEXP="" S RET(0)=0 Q
 I DGEXP<0 S RET(0)=DGEXP Q
 I DGEXP'?1"OTH".E S RET(0)=0 Q
 I $$ISOTH^DGOTHD(DGEXP)>1 D OTH90(DGDFN,.RET) Q
 S RET(0)=0
 Q
 ;
OTH90(DGDFN,RET) ;calculate the CPRS EMERGENT OTH button
 K RET
 N DGN,DGIEN33,DGRET,DGCLCK,DGLS365D,DGLS365I,DG90A,DGCNTR,DG90,DGCRNT,LSTDAY
 N Z,DTSTR,DGSDT365,DGEDT365,DGSDT90,DGEDT90,DGNXT365,DGARR,DGERR,I,II
 I $$ISOTHD^DGOTHD(DGDFN)=0 S RET(0)="-1^Patient's primary eligibility code is no longer EXPANDED MH CARE NON-ENROLLEE" Q
 S DGIEN33=+$O(^DGOTH(33,"B",DGDFN,0))
 I DGIEN33=0 S RET(0)="-1^Unable to find an entry in OTH ELIGIBILITY PATIENT file #33 for this patient" Q
 D GETS^DIQ(33,DGIEN33_",",".01;.02;1*;2*","I","DGARR","DGERR")
 I $D(DGERR) S RET(0)="-1^FileMan Error #"_DGERR("DIERR",1)_": "_DGERR("DIERR",1,"TEXT",1) Q
 I $G(DGARR(33,DGIEN33_",",.02,"I"))<1 S RET(0)="-1^Patient is no longer Other Than Honorable eligible" Q
 D CLOCK^DGOTHRP2(DGIEN33)
 I DGLS365D'>0 S RET(0)="-1^No 365 days clocks started" Q
 ;check if one of the 365 or 90-day period is missing
 I $$MSNGPRD(DGLS365D,.DGCLCK) Q
 D RESULT^DGOTHRP3(.DGARR,.DGCLCK,DGIEN33)
 I '$D(DGRET) S RET(0)="-1^Check patient's 90-Day period, one of them is missing" Q
 S DGCNTR=1,(LSTDAY,DGCRNT)=0
 S RET(DGCNTR)="OTH^Other than Honorable, click for details"
 S DGCNTR=DGCNTR+1
 F I=1:1:DGLS365D D
 . ;get date for the last 365 and 90-day period
 . I 'DGCRNT D LSTPRD
 . Q:DGCRNT>0
 . I DGRET(I)<1,$D(DGRET(I+1)) Q
 . S II="" F  S II=$O(DGRET(I,II)) Q:II=""  D
 . . N DG90
 . . S DG90=DGRET(I,II)
 . . ;determine if today is the last day for the 90-day care period
 . . I $P(DG90,U,2)=DT S LSTDAY=1
 . . I 'LSTDAY,$P(DG90,U,3)<1,$D(DGRET(I,II+1)) Q
 . . I DGCNTR=2 S DGCRNT=1 D BTN,HDR
 . . I $P(DG90,U,3)>=7,$P(DG90,U,3)<=90 D
 . . . I $P(DG90,U)>DT D AUTH1 Q
 . . . S DGCNTR=DGCNTR+1
 . . . S RET(DGCNTR)=$$POPUP
 . . . I '$D(DGRET(I,II+1)) D
 . . . . I 'DGNXT365 D AUTH1 Q
 . . . . D NXT365
 . . I $P(DG90,U,3)<7 D
 . . . ;display warning message for less than 7 days
 . . . S DGCNTR=DGCNTR+1
 . . . S RET(DGCNTR)=$$POPUP
 . . . D WARN
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)="   "
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)="Call Registration team for details."
 S RET(0)=DGCNTR
 Q
 ;
MSNGPRD(DGLS365D,DGCLCK) ;check if there are 90-Day period missing
 N I,II,MSNGPRD
 S MSNGPRD=0
 F I=1:1:DGLS365D D  Q:MSNGPRD
 . I '$D(DGCLCK(I)) D  Q
 . . S RET(0)="-1^The 365-Day period # "_I_" is missing."
 . . S MSNGPRD=1
 . F II=1:1:DGCLCK(I) D  Q:MSNGPRD
 . . I DGCLCK(I,II)'=II D
 . . . S RET(0)="-1^The "_II_$S(II=1:"st",II=2:"nd",II=3:"rd",45[II:"th")_" 90-Day period for the 365 days period # "_I_" is missing."
 . . . S MSNGPRD=1
 Q MSNGPRD
 ;
BTN ;Text to be displayed in the button and when user hover the button
 ;
 S RET(DGCNTR)=$S($G(LSTDAY):"LD",1:$P(DG90,U,3)_"D")_",P"_II_"^"_$$POPUP()
 Q
 ;
HDR ;display popup message header
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)="Other Than Honorable Status"
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)="   "
 Q
 ;
POPUP() ;Text to be displayed in the popup message
 Q $S($G(LSTDAY):$$LSTDAY(),$P(DG90,U,3)=0:"Zero days remaining ",1:$P(DG90,U,3)_" day(s) remaining ")_"in the "_$$MSG()_" period"
 ;
AUTH1 ;Display authorization verbiage in the popup message
 I $P(DG90,U,4)="" D  Q
 . I $P(DG90,U)>DT S DGCNTR=DGCNTR+1 D AUTH3 Q
 . S DGCNTR=DGCNTR+1
 . S RET(DGCNTR)="Authorization required for further care."
 I DGSDT90<=DT D  Q
 . S DGCNTR=DGCNTR+1
 . S RET(DGCNTR)=$$AUTH2()
 S DGCNTR=DGCNTR+1
 D AUTH3
 Q
 ;
LSTDAY() ;
 Q "Last day patient is eligible for treatment "
 ;
AUTH2() ;
 Q "Authorization from VISN Chief Medical Officer is required for an additional 90-Day period."
 ;
AUTH3 ;
 S RET(DGCNTR)=$P(DG90,U,3)_" day(s) are authorized starting on "_$$FMTE^XLFDT($P(DG90,U))
 Q
MSG() ;
 Q $S($G(LSTDAY):"current",(('DGNXT365)&(DGRET(I)>0)):"current",1:"most recent")
 ;
WARN ;display warning message when user selects a patient less than 7 day(s) remaining.
 S RET(DGCNTR)=RET(DGCNTR)_"^WARNING:  EMERGENT MH OTH"
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)=$S($G(LSTDAY):"^"_$$LSTDAY(),$P(DG90,U,3)=0:"^Zero days remaining ",1:"^Less than 7 day(s) remaining ")_"in the "_$$MSG()_" period."
 I 'DGNXT365 D  Q
 . I DGSDT90<=DT D
 . . S DGCNTR=DGCNTR+1
 . . S RET(DGCNTR)="^"_$$AUTH2()
 . . I $P(DG90,U,3)<7 S RET(DGCNTR+1)=$P(RET(DGCNTR),U,2),DGCNTR=DGCNTR+1
 E  D
 . I '$D(DGRET(I,II+1)) D
 . . S DGCNTR=DGCNTR+1
 . . S RET(DGCNTR)="^"_$$NXT2()
 . . D NXT365
 Q
 ;
LSTPRD ;get dates for the last 365 and 90- day period
 S DTSTR=DGRET(I,DGCLCK(I))
 S DGSDT365=$P(DGRET(I,1),U),DGEDT365=$$FMADD^XLFDT(DGSDT365,365)
 S DGSDT90=$P(DTSTR,U),DGEDT90=$P(DTSTR,U,2)
 S DGNXT365=$S(DGEDT365<=DT:1,$$FMDIFF^XLFDT(DGEDT90,DGSDT365)>=365:1,(DGSDT90>=DT||DGSDT90<=DT)&(DGEDT90>=DT):0,1:0)
 Q
 ;
NXT365 ;display verbiage for the next 365-day period
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)=$$NXT2()
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)="Please contact Registration to start the clock."
 Q
 ;
NXT2() ;
 Q "Patient is eligible for an additional 90-Day period for the next 365-Day."
 ;
