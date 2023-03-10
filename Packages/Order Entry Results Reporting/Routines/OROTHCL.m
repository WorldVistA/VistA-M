OROTHCL ;SLC/SS/RM - OTHD CLOCK INTERFACE ; 06/13/19  09:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377,437**;Dec 17, 1997;Build 29
 ;
 ;
 ;Functionality:
 ;This function is called from the "OROTHCL GET" RPC to retrieve 
 ; OTH (Other Than Honorable) status, 
 ; PP (Presumptive Psychosis) status, 
 ; PRF (Patient Record Flag) and its history 
 ; as a text to display in OTH/PP/inactive PRF history button and associated pop-up message in CPRS.
 ;
 ;The OR code below calls DG API OTHBTN^DGOTHBTN to get text lines to display in CPRS,
 ;it works in conjunction with Registration patches: DG*5.3*952, DG*5.3*977, DG*5.3*1029
 ;
 ;ICR:
 ; Supports the ICR# 6873
 ; between DG (custodial) and OR (subscriber) namespaces
 ;
 ;Input parameters:
 ; RET - reference type parameter to return data
 ; DFN - patient's IEN in the file (#2)
 ; ORDATE - the date to calculate status and compose the text to display to CPRS
 ;          default = DT (today)
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
 ;RET(7)="Call Registration team for details."
 ;RET(8)="Clinician: Determine and document in 1st line of Progress Note if MH treatment related to service." 
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
 ;RET(6)="health and medical care." 
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
GET(RET,DFN,ORDATE) ;
 K RET
 ;insert the check for
 I $T(OTHBTN^DGOTHBTN)="" S RET(0)="-2^OTHD clock functionality is not available" Q
 I $G(DFN)'>0 S RET(0)="-1^patient IEN is not defined" Q
 S ORDATE=$S($G(ORDATE)>0:ORDATE,1:DT)
 D OTHBTN^DGOTHBTN(DFN,ORDATE,.RET)
 Q
 ;
