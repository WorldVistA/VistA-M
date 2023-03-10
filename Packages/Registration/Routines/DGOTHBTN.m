DGOTHBTN ;SLC/SS,RM,JC - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ; 03/27/2019
 ;;5.3;Registration;**952,977,1029,1035,1047**;Aug 13, 1993;Build 13
 ;
 ;
 ;ICR#   TYPE       DESCRIPTION
 ;-----  ----       ---------------------
 ; 2056  Sup        ^DIQ  : GETS
 ;10103  Sup        ^XLFDT: $$FMADD,$$FMDIFF
 ; 2992  Sup        ^XTV(8989.51) access
 ;
 ;Functionality:
 ;This function is called from the "OROTHCL GET" RPC to compose  
 ; OTH (Other Than Honorable) status, 
 ; PP (Presumptive Psychosis) status, 
 ; PRF (Patient Record Flag) and its history 
 ; as a text to display in OTH/PP/inactive PRF history button and associated pop-up message in CPRS.
 ;Will be called by OROTHCL code, that is used by ORTHCL GET RPC
 ;See also the DG ICR# 6873 that provides CPRS access to this API. 
 ;
 ;Input parameters:
 ; RET - reference type parameter to return data
 ; DGDFN - patient's IEN in the file (#2)
 ; DGDATE - the date to calculate status and compose the text to return to CPRS
 ;          default = DT (today)
 ;
 ;ATTENTION: Here below is what the ORTHCL GET RPC is supposed to return to GUI code 
 ;           (actual return values of this API below not necessarily should be the same 
 ;           but need to provide all information to support OR M-code that will pass it to the OR RPC)
 ;
 ;Return array:
 ;If RET(0)<0 : error code less than zero^error message - it is an error, and do not display anything
 ;
 ;If RET(0)=0 : then do not display anything in CPRS
 ;
 ;If RET(0)>0 : see the description below:
 ;
 ;RET(0) = number of lines to return
 ;RET(1) = text for the 1st line on the button ^Text to display when hover over the 1st line on the button 
 ;RET(2) = text for the 2nd line on the button^Text to display when hover over the 2nd line on the button
 ;RET(3) = text for the 1st line of the button-click popup message ^ Text for the 1st line of the warning popup message (see the example for the OTH-90 below)
 ;RET(>3)= text lines for the rest of the text in the popup message when the user clicks on the button or for the warning popup message
 ;NOTE: empty or null values in array elements greater than 3 will not be displayed on the CPRS side.
 ;      Enter at least a blank space in the piece to include a blank line in the displayed text.  
 ;
 ;Example for OTH-EXT:
 ;RET(0)=6
 ;RET(1)="OTH-EXT^Other than Honorable, click for details"
 ;RET(2)=" "
 ;RET(3)="Other than Honorable - Extended"
 ;RET(4)="Eligible for Mental Health care only"
 ;RET(5)="Not time limited - pending VBA adjudication"
 ;RET(6)="Adjudication will determine eligibility for continuing care"
 ;
 ;Example for OTH-90 with zero days remaining:
 ;RET(0)=10
 ;RET(1)="OTH^Other than Honorable, click for details"
 ;RET(2)="0D,P1^Zero days remaining in the most recent period"
 ;RET(3)="Other Than Honorable Status"
 ;RET(4)="   "
 ;RET(5)="Zero days remaining in the most recent period^WARNING:  EMERGENT MH OTH"
 ;RET(6)="^Zero days remaining in the most recent period."
 ;RET(7)="^Authorization from VISN Chief Medical Officer is required for an additional 90-Day period."
 ;RET(8)="   "
 ;RET(9)="Call Registration team for details."
 ;RET(10)="Clinician: Determine and document in 1st line of Progress Note if MH treatment related to service."
 ;
 ;Example for OTH-90 with less than 7 days remaining:
 ;RET(0)=10
 ;RET(1)="OTH^Other than Honorable, click for details"
 ;RET(2)="5D,P1^5 day(s) remaining in the current period"
 ;RET(3)="Other Than Honorable Status"
 ;RET(4)="   "
 ;RET(5)="5 day(s) remaining in the current period^WARNING:  EMERGENT MH OTH"
 ;RET(6)="^Less than 7 day(s) remaining in the current period."
 ;RET(7)="^Authorization from VISN Chief Medical Officer is required for an additional 90-Day period."
 ;RET(8)="   "
 ;RET(9)="Call Registration team for details."
 ;RET(10)="Clinician: Determine and document in 1st line of Progress Note if MH treatment related to service." 
 ;
 ;Example for OTH-90 with more than 7 days remaining:
 ;RET(0)=8
 ;RET(1)="OTH^Other than Honorable, click for details"
 ;RET(2)="80D,P1^80 day(s) remaining in the current period"
 ;RET(3)="Other Than Honorable Status"
 ;RET(4)="   "
 ;RET(5)="80 day(s) remaining in the current period"
 ;RET(6)="   "
 ;RET(7)="Call Registration Team for Details."
 ;RET(7)=RET(7)_Additional Line 1 if defined in ^XTV(8989.51,IEN,20,1,0)
 ;RET(8)=Additional Line 2 if defined in ^XTV(8989.51,IEN,20,2,0) or it will be a blank line.
 ;RET(9)="Clinician: Determine and document in 1st line of Progress Note if MH treatment related to service." 
 ;
 ;Example for PP workaround settings only:
 ;RET(0)=7
 ;RET(1)="PP^Presumptive Psychosis Authority, click for details"
 ;RET(2)="^"
 ;RET(3)="Eligible for mental health care only under Presumptive Psychosis"
 ;RET(4)="Authority."
 ;RET(5)="PP Category: No value was selected as PP Indicator is not completed."
 ;RET(6)="Patients who experienced MST are eligible for MST related mental"
 ;RET(7)="health and medical care."
 ;
 ;Example for PP workaround settings and PP category:
 ;RET(0)=7
 ;RET(1)="PP^Presumptive Psychosis Authority, click for details"
 ;RET(2)="Fsm^Former Service Member with prior OTH discharge; should now be post-adjudication."
 ;RET(3)="Eligible for mental health care only under Presumptive Psychosis"
 ;RET(4)="Authority: Former Service Member with prior OTH discharge;"
 ;RET(5)="should now be post-adjudication."
 ;RET(6)="Patients who experienced MST may be eligible for MST-related care;"
 ;RET(7)="check with Eligibility for specifics."
 ;
 ;Example for PP category without PP workaround settings (the mailman will be also sent to the DGEN ELIGIBILITY ALERT group in DGOTHBT2):
 ;RET(0)=6
 ;RET(1)="PP^Presumptive Psychosis Authority, click for details"
 ;RET(2)="Dec^VETERAN DECLINES ENROLLMENT"
 ;RET(3)="Eligible for mental health care only under Presumptive Psychosis"
 ;RET(4)="Authority: VETERAN DECLINES ENROLLMENT."
 ;RET(5)="Patients who experienced MST are eligible for MST related mental"
 ;RET(6)="health and medical care." ^
 ;
 ;Example for inactive PRFs:
 ;RET(0)=23
 ;RET(1)="Inactive Flag^Patient has Inactive Flag(s), click to view"
 ;RET(2)=" "
 ;RET(3)="Flag name: HIGH RISK FOR SUICIDE   Status: INACTIVE"
 ;RET(4)="  Initial Assigned Date: OCT 12, 2020@16:27:10"
 ;RET(5)="  Originating Site: CAMP MASTER"
 ;RET(6)="  Owner Site: CAMP MASTER"
 ;RET(7)="  CAMP MASTER changes:"
 ;RET(8)="    DATE/TIME: NOV 25, 2020@10:45:44    ACTION: INACTIVATE"
 ;RET(9)="  BAY PINES VAMC changes:"
 ;RET(10)="    DATE/TIME: NOV 25, 2020@10:19:17    ACTION: REACTIVATE"
 ;RET(11)="  CAMP MASTER changes:"
 ;RET(12)="    DATE/TIME: NOV 24, 2020@09:26:06    ACTION: INACTIVATE"
 ;RET(13)="  NEW YORK HHS changes:"
 ;RET(14)="    DATE/TIME: NOV 24, 2020@09:25:30    ACTION: CONTINUE"
 ;RET(15)="  *****additional info is in vista*****"
 ;RET(16)=" "
 ;RET(17)="Flag name: MISSING PATIENT                Status: INACTIVE"
 ;RET(18)="  Initial Assigned Date: OCT 12, 2020@16:27:54"
 ;RET(19)="  Originating Site: CAMP MASTER"
 ;RET(20)="  Owner Site: CAMP MASTER"
 ;RET(21)="  CAMP MASTER changes:"
 ;RET(22)="    DATE/TIME: DEC 01, 2020@12:06:47    ACTION: INACTIVATE"
 ;RET(23)="  *****additional info is in vista*****"
 ;
 ;
OTHBTN(DGDFN,DGDATE,RET) ;
 ;
 N DGEXP,PPWRK,PPCAT,PRFINF
 K ^TMP($J,"DGPRINFO")
 S PRFINF=$$PRFINFO^DGOTHBT2(DGDFN,"DGPRINFO")
 S RET(0)=0
 ;check OTH
 S DGEXP=$$GETEXPR^DGOTHD(DGDFN)
 ;if OTH (and possibly inactive PRF)
 I DGEXP'="" D OTH(DGEXP,DGDFN,.RET,PRFINF) K ^TMP($J,"DGPRINFO") Q
 ;check for PP workaround settings 
 S PPWRK=$$PPWRKARN^DGPPAPI(DGDFN)
 ;check for PP category
 S PPCAT=$$PPINFO^DGPPAPI(DGDFN)
 ;if PP (and possibly inactive PRF)
 I PPWRK'="N"!(PPCAT'="") D PRESUMP(PPWRK,PPCAT,DGDFN,.RET,PRFINF) K ^TMP($J,"DGPRINFO") Q
 ;check if PRF
 ;if no inactive PRF then quit
 I $P(PRFINF,U,3)'="I" K ^TMP($J,"DGPRINFO") Q
 ;if at least one inactive PRF flag
 D INPRFONL^DGOTHBT2(DGDFN,"DGPRINFO",.RET)
 K ^TMP($J,"DGPRINFO")
 ;if nothing then don't display button - RET(0) is already set to 0
 Q
 ;
 ;/** Process OTH patient with or without inactive PRF
 ;check for OTH settings and prepare the text for the button and pop-up window
 ;Input:
 ; DGEXP - OTH data from $$GETEXPR^DGOTHD(DGDFN)
 ; DGDFN - IEN in the file (#2)
 ; RET - to return an array with data
 ;Output:
 ; RET(0)=0  - nothing to display
 ;or
 ; RET(0)>0, RET - with data to display on the button
 ;*/
OTH(DGEXP,DGDFN,RET,PRFINF) ;
 N PPRET
 S RET(0)=0
 ;if error then quit
 I DGEXP<0 S RET(0)=DGEXP Q
 ;if there are no any inactive PRF 
 ;or there are no any inactive PRF that are qualified
 ;then show just OTH information
 I $P(PRFINF,U,3)'="I"!($$QUALINACT^DGOTHBT2("DGPRINFO",DGDFN)=0) D  Q
 .I DGEXP'?1"OTH".E S RET(0)=0 Q
 .;determine the OTH type
 .I $$ISOTH^DGOTHD(DGEXP)>1 D  Q
 ..;set RET for OTH-90 and return 
 ..D OTH90(DGDFN,.RET)
 .;if OTH-EXT then set RET for OTH-EXT
 .S RET(0)=11
 .S RET(1)="OTH-EXT^Other than Honorable, click for details"
 .S RET(2)=" "
 .S RET(3)="Other than Honorable - Extended"
 .S RET(4)=" "
 .S RET(5)="Eligible for Mental Health care only unless Veteran has positive MST screen."
 .S RET(6)=" "
 .S RET(7)="If MST Screen is positive, Veteran is eligible for MST related mental health and medical care."
 .S RET(8)="Please review MST checkbox or complete MST screening."
 .S RET(9)=" "
 .S RET(10)="Not time limited - pending VBA adjudication."
 .S RET(11)="Adjudication will determine eligibility for continuing care."
 .Q
 ;if at least one inactive PRF
 D OTHINPRF^DGOTHBT2(DGDFN,DGEXP,"DGPRINFO",.RET)
 Q
 ;
 ;/**
 ;process PP patient with or without inactive PRF
 ;check for PP settings and prepare the text for the button and pop-up window
 ;Input:
 ; WRKARND - PP work around data from $$PPWRKARN^DGOTHBT2(DGDFN)
 ; PPIND - PP category data from $$PPINFO^DGOTHBT2(DGDFN)
 ; DGDFN - IEN in the file (#2)
 ; RET - to return an array with data
 ;Output:
 ; RET(0)=0  - nothing to display
 ;or
 ; RET(0)>0, RET - with data to display on the button
 ;*/
PRESUMP(WRKARND,PPIND,DGDFN,RET,PRFINF) ;
 N PPRET
 S RET(0)=0
 S PPRET=$P(PPIND,U,1)
 ;if there are no any inactive PRF
 ;then show just PP information
 D  I $P(PRFINF,U,3)="I",$$QUALINACT^DGOTHBT2("DGPRINFO",DGDFN)=1 D PRWITHPP^DGOTHBT2(DGDFN,"DGPRINFO",.RET)
 .I PPRET="N" Q  ;if indicator = NO then we NEVER show PP indicator
 .I PPIND="",WRKARND="N" Q  ;if no indicator data AND no workaround settings then don't show PP indicator
 .I PPIND="",WRKARND="Y" D WORKARND(.RET) Q  ;if no indicator data BUT workaround settings exist- then set RET to warn the user
 .I PPRET="Y",WRKARND="Y" D SHOWPP(PPIND,.RET) Q  ;set RET for regular message when PP indicator data exist
 .I PPRET="Y",WRKARND="N" D SHOWPP(PPIND,.RET) D SENDMAIL^DGOTHBT2(DGDFN) Q  ;set RET for regular message when PP indicator data exist
 ;if at least one inactive PRF
 Q
 ;
 ;
OTH90(DGDFN,RET) ;calculate the CPRS EMERGENT OTH button
 K RET
 N DGN,DGIEN33,DGRET,DGCLCK,DGLS365D,DGLS365I,DG90A,DGCNTR,DG90,DGCRNT,LSTDAY
 N Z,DTSTR,DGSDT365,DGEDT365,DGSDT90,DGEDT90,DGNXT365,DGARR,DGERR,I,II,ZJMC
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
 . . I $P(DG90,U,3)<1,$D(DGRET(I,II+1)) Q
 . . I $P(DG90,U,2)=DT S LSTDAY=1
 . . I DGCNTR=2 S DGCRNT=1 D BTN,HDR,MST
 . . I $P(DG90,U,3)>=7,$P(DG90,U,3)<=90 D
 . . . I $P(DG90,U)>DT D AUTH1 Q
 . . . S DGCNTR=DGCNTR+1
 . . . S RET(DGCNTR)=$$POPUP
 . . . I '$D(DGRET(I,II+1)) D
 . . . . I 'DGNXT365 D AUTH1 Q
 . . . . D NXT365
 . . I $P(DG90,U,3)<7 D
 . . . ;display warning message
 . . . S DGCNTR=DGCNTR+1
 . . . S RET(DGCNTR)=$$POPUP
 . . . D WARN
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)="   "
 S DGCNTR=DGCNTR+1
 N LOCMSG1,LOCMSG2,DIE,DA,DR,ARRAY,DIC,X,LOCIEN,LOCDFLT
 S LOCDFLT="Call Registration Team for Details. "
 ; ICR 2992 access to ^XTV(8989.51
 S DIC="^XTV(8989.51,",DIC(0)="QEZ",X="OR OTH BTN LOCAL MSG"
 D ^DIC
 S LOCIEN=$P($G(Y),"^")
 D GETS^DIQ(8989.51,LOCIEN_",","**","","ARRAY")
 S LOCMSG1=$G(ARRAY(8989.51,LOCIEN_",","20",1))
 S LOCMSG2=$G(ARRAY(8989.51,LOCIEN_",","20",2))
 S RET(DGCNTR)=$G(LOCDFLT)_$G(LOCMSG1),DGCNTR=DGCNTR+1
 S RET(DGCNTR)=$G(LOCMSG2),DGCNTR=DGCNTR+1
 S RET(DGCNTR)=" ",DGCNTR=DGCNTR+1
 S RET(DGCNTR)="Clinician: Determine and document in 1st line of Progress Note if MH treatment related to service."
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
MST ;Text for MST information.
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)="Eligible for MH care only. Remember to perform MST screen."
 S DGCNTR=DGCNTR+1
 S RET(DGCNTR)=" "
 Q
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
 ;
 ;
 ;/** Set RET for the case when PP category was selected for the patient
 ;Input:
 ; PPIND - returned by $$PPINFO^DGOTHBT2(DGDFN)
 ;Output:
 ; RET - local array to return information to send to CPRS
 ;
 ;*/
SHOWPP(PPIND,RET) ;
 N DGRET,DGCAT
 S DGRET=$P(PPIND,U,2,3)
 S RET(1)="PP^Presumptive Psychosis Authority, click for details"
 S DGCAT=$P(DGRET,U)
 I DGCAT="OTH" D  Q
 . S RET(2)="Fsm^Former Service Member with prior OTH discharge; should now be post-adjudication."
 . S RET(3)="Eligible for mental health care only under Presumptive Psychosis Authority: Former Service Member with"
 . S RET(4)="prior OTH discharge; should now be post-adjudication."
 . S RET(5)="Patients who experienced MST may be eligible for MST-related care; check with Eligibility for specifics."
 . S RET(6)=""
 . S RET(0)=6
 S RET(2)=$E(DGCAT,1,1)_$$LOW^XLFSTR($E(DGCAT,2,3))_U_$P(DGRET,U,2)
 S RET(3)="Eligible for mental health care only under Presumptive Psychosis Authority: "_$P(DGRET,U,2)_"."
 S RET(4)="Patients who experienced MST are eligible for MST related mental health and medical care."
 S RET(0)=4
 Q
 ;
 ;/** Set RET array for the messages to display in CPRS when we have PP workaround settings
 ;Input:
 ; nothing 
 ;Output:
 ; RET - local array to return information to send to CPRS
 ;*/
WORKARND(RET) ;
 S RET(1)="PP^Presumptive Psychosis Authority, click for details"
 S RET(2)="^"
 S RET(3)="Eligible for mental health care only under Presumptive Psychosis Authority."
 S RET(4)="PP Category: No value was selected as PP Indicator is not completed."
 S RET(5)="Patients who experienced MST are eligible for MST related mental health and medical care."
 S RET(0)=5
 Q
 ;
