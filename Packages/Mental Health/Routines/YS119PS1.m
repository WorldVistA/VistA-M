YS119PS1 ;SLC/KCM - Patch 119 post-init - fixes ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**119**;Dec 30, 1994;Build 40
 Q
 ;
AUDIT ; fix scalegroup, scale, report
 N TSTIEN,IEN,CHGS
 S TSTIEN=$$FINDTEST^YS119PS0("AUDIT")
 ; update MH CHOICES: LEGACY VALUE (#4)
 S IEN=$$FINDCHC^YS119PS0(TSTIEN,2,2) ; 2nd question, 2nd choice
 S CHGS(4)=0
 D UPDANY^YS119PS0(601.75,IEN,.CHGS)
 ; update MH SCALEGROUPS:  SCALEGROUP NAME (#2), ORDINATE TITLE (#4)
 S IEN=$$FINDSGRP^YS119PS0(TSTIEN,1)
 S CHGS(2)="AUDIT",CHGS(4)="T - Score"
 D UPDANY^YS119PS0(601.86,IEN,.CHGS)
 ; update MH SCALES:  SCALE NAME (#3), XLABEL (#4)
 S IEN=$$FINDSCL^YS119PS0(IEN,1)
 S CHGS(3)="AUDIT",CHGS(4)="AUDIT"
 D UPDANY^YS119PS0(601.87,IEN,.CHGS)
 ; update MH REPORT:  switch score to <-AUDIT->, remove "A score of..."
 S IEN=$$FINDRPT^YS119PS0(TSTIEN)
 D UPDRPT^YS119PS0(IEN,"AUDITRPT","YS119PS1")
 D UPDDT^YS119PS0(TSTIEN)
 Q
AUDITRPT ;
 ;;.|.|Alcohol Use Disorders Identification Test||Date Given: <.Date_Given.>|Clinician: <.Staff_Ordered_By.>|Location: <.Location.>||Veteran: <.Patient_Name_Last_First.>|SSN: <.Patient_SSN.>|DOB: 
 ;;<.Patient_Date_Of_Birth.> (<.Patient_Age.>)|Gender: <.Patient_Gender.>||   AUDIT Score: <-AUDIT->| |
 ;;  Questions and Answers||1. How often do you have a drink containing alcohol? |    <*Answer_89*>|2. How many drinks containing alcohol do you have on a typical day when you are drinking? 
 ;;|    <*Answer_90*>|3. How often do you have six or more drinks on one occasion? |    <*Answer_91*>|4. How often during the last year have you found that you were not able to stop drinking once you 
 ;;had started? |    <*Answer_92*>|5. How often during the last year have you failed to do what was normally expected from you because of drinking? |    <*Answer_93*>|6. How often during the last year 
 ;;have you needed a first drink in the morning to get yourself going after a heavy drinking session? |    <*Answer_94*>|7. How often during the last year have you had a feeling of guilt or remorse 
 ;;after drinking? |    <*Answer_95*>|8. How often during the last year have you been unable to remember what happened the night before because you had been drinking? |    <*Answer_96*>|9. Have you or 
 ;;someone else been injured as a result of your drinking? |    <*Answer_97*>|10. Has a relative or friend, or a doctor or other health worker been concerned about your drinking or suggested that you 
 ;;cut down? |    <*Answer_98*>| ||Information contained in this note is based on a self report assessment and is not sufficient to use alone for diagnostic purposes. Assessment results should be 
 ;;verified for accuracy and used in conjunction with other diagnostic activities.|      $~
 ;;zzzzz
 ;
BAI ; remove scale, Beck Anxiety Index, leaving Beck Anxiety Inventory
 N TSTIEN,SGIEN,IEN,DEL
 S TSTIEN=$$FINDTEST^YS119PS0("BAI")
 S SGIEN=$$FINDSGRP^YS119PS0(TSTIEN)
 S DEL=0
 S IEN=0 F  S IEN=$O(^YTT(601.87,"AD",SGIEN,IEN)) Q:'IEN  D  Q:DEL
 . I $P(^YTT(601.87,IEN,0),U,4)="Beck Anxiety Index" S DEL=IEN
 Q:'DEL  ; already deleted
 D DELANY^YS119PS0(601.87,DEL)
 D UPDDT^YS119PS0(TSTIEN)
 Q
MMPI2RF ; fix reversed questions
 N TSTIEN,CTNTIEN,CHGS
 S TSTIEN=$$FINDTEST^YS119PS0("MMPI-2-RF")
 ; update MH INSTRUMENT CONTENT: QUESTION SEQUENCE (#2)
 S CTNTIEN=$$FINDCTNT^YS119PS0(TSTIEN,"305.")
 S CHGS(2)=3060
 D UPDANY^YS119PS0(601.76,CTNTIEN,.CHGS)
 S CTNTIEN=$$FINDCTNT^YS119PS0(TSTIEN,"306.")
 S CHGS(2)=3070
 D UPDANY^YS119PS0(601.76,CTNTIEN,.CHGS)
 D UPDDT^YS119PS0(TSTIEN)
 Q
MOCA ; fix MOCA* misspellings
 D FIXMOCA("MOCA","5D.")
 D FIXMOCA("MOCA ALT 1","5D.")
 D FIXMOCA("MOCA ALT 2","5D.")
 Q
FIXMOCA(NAME,DESIG) ; fix MOCA mis-spellings
 N TSTIEN,QUIEN,SCALE,KEY,SPEC,CHGS
 S SPEC("substract")="subtract"
 S TSTIEN=$$FINDTEST^YS119PS0(NAME)
 S QUIEN=$$FINDQD^YS119PS0(TSTIEN,DESIG)
 S SCALE=$$FINDSCL^YS119PS0($$FINDSGRP^YS119PS0(TSTIEN))
 S KEY=0 F  S KEY=$O(^YTT(601.91,"AC",SCALE,KEY)) Q:'KEY  D
 . I $P(^YTT(601.91,KEY,0),U,3)'=QUIEN Q
 . ; update MH SCORING KEYS: TARGET (#3)
 . S CHGS(3)=$$REPLACE^XLFSTR($P(^YTT(601.91,KEY,0),U,4),.SPEC)
 . D UPDANY^YS119PS0(601.91,KEY,.CHGS)
 D UPDDT^YS119PS0(TSTIEN)
 Q
PCPTSD ; fix PC-PTSD scale name and report
 N TSTIEN,IEN,CHGS
 S TSTIEN=$$FINDTEST^YS119PS0("PC PTSD") ; (not to be confused with PC-PTSD)
 S IEN=$$FINDSCL^YS119PS0($$FINDSGRP^YS119PS0(TSTIEN))
 ; update MH SCALES: SCALE NAME (#3)
 S CHGS(3)="PC PTSD Total"
 D UPDANY^YS119PS0(601.87,IEN,.CHGS)
 ; update MH REPORT:  switch score to <-PC PTSD Total->
 S IEN=$$FINDRPT^YS119PS0(TSTIEN)
 D UPDRPT^YS119PS0(IEN,"PCPTSDRP","YS119PS1")
 D UPDDT^YS119PS0(TSTIEN)
 Q
PCPTSDRP ;
 ;;.| .| Primary Care PTSD Screen| | Date Given: <.Date_Given.>| Clinician: <.Staff_Ordered_By.>| Location: <.Location.>| | Veteran: <.Patient_Name_Last_First.>| SSN: <.Patient_SSN.>| DOB: 
 ;;<.Patient_Date_Of_Birth.> (<.Patient_Age.>)| Gender: <.Patient_Gender.>| | | PC PTSD Screen Score: <-PC PTSD Total->| | <.DLL_String.>|  |  |  Questions and Answers| |  1. Have had any nightmares about it or 
 ;;thought about it when you did not want to?|     <*Answer_3826*>|  2. Tried hard not to think about it or went out of your way to avoid situations that remind you of it?|     <*Answer_3827*>|  3. Were 
 ;;constantly on guard, watchful, or easily startled?|     <*Answer_3828*>|  4. Felt numb or detached from others, activities, or your surroundings?|     <*Answer_3829*>| | | Information contained in 
 ;;this note is based on a self-report assessment and is not sufficient to use alone for diagnostic purposes.  Assessment results should be verified for accuracy and used in conjunction with other 
 ;;diagnostic activities and procedures.|  $~
 ;;zzzzz
 ;
PHQ9 ;
 N TSTIEN,IEN,CHGS
 S TSTIEN=$$FINDTEST^YS119PS0("PHQ9")
 S IEN=$$FINDSCL^YS119PS0($$FINDSGRP^YS119PS0(TSTIEN))
 ; update MH SCALES: SCALE NAME (#3)
 S CHGS(3)="PHQ9"
 D UPDANY^YS119PS0(601.87,IEN,.CHGS)
 ; update MH REPORT:  switch score to <-PHQ9->
 S IEN=$$FINDRPT^YS119PS0(TSTIEN)
 D UPDRPT^YS119PS0(IEN,"PHQ9RPT","YS119PS1")
 D UPDDT^YS119PS0(TSTIEN)
 Q
PHQ9RPT ;
 ;;.|.|Patient Health Questionnaire - 9 (PHQ-9)||Date Given: <.Date_Given.>|Clinician: <.Staff_Ordered_By.>|Location: <.Location.>||Veteran: <.Patient_Name_Last_First.>|SSN: <.Patient_SSN.>|DOB: 
 ;;<.Patient_Date_Of_Birth.> (<.Patient_Age.>)|Gender: <.Patient_Gender.>||   PHQ-9 Depression Scale Score: <-PHQ9->| |Guide for Interpreting PHQ-9 scores:|  0-4: The score suggests the patient may not 
 ;;need depression treatment.|  5-14: Physician uses clinical judgment about treatment based on |            patient's duration of symptoms and functional impairment.|  15 or more: Warrants treatment 
 ;;for depression, using antidepressant, |            psychotherapy and/or a combination of treatment.||Questions and Answers||Over the last 2 weeks, how often have you been bothered by any of the 
 ;;following problems?|1. Little interest or pleasure in doing things|    <*Answer_3374*>|2. Feeling down, depressed, or hopeless|    <*Answer_3375*>|3. Trouble falling or staying asleep, or sleeping 
 ;;too much|    <*Answer_3376*>|4. Feeling tired or having little energy|    <*Answer_3377*>|5. Poor appetite or overeating|    <*Answer_3378*>|6. Feeling bad about yourself or that you are a failure or 
 ;;have let yourself or your family down|    <*Answer_3379*>|7. Trouble concentrating on things, such as reading the newspaper or watching television|    <*Answer_3380*>|8. Moving or speaking so slowly 
 ;;that other people could have noticed. Or the opposite being so fidgety or restless that you have been moving around a lot more than usual|    <*Answer_3381*>|9. Thoughts that you would be better off 
 ;;dead or of hurting yourself in some way|    <*Answer_3382*>|10. If you checked off any problems, how DIFFICULT have these problems made it for you to do your work, take care of things at home or get 
 ;;along with other people?|    <*Answer_4019*>||Information contained in this note is based on a self report assessment and is not sufficient to use alone for diagnostic purposes. Assessment results 
 ;;should be verified for accuracy and used in conjunction with other diagnostic activities.||Copyright 2001 Pfizer Inc.|All rights reserved. Reproduced with permission of Pfizer Inc.|PRIME-MD is a 
 ;;trademark of Pfizer Inc       $~
 ;;zzzzz
 ;
WAISR ; make case in scoring keys for WAI-SR match case in choices
 N TSTIEN,SGIEN,SCALE,KEY,CHGS
 S TSTIEN=$$FINDTEST^YS119PS0("WAI-SR")
 S SGIEN=$$FINDSGRP^YS119PS0(TSTIEN)
 S SCALE=0 F  S SCALE=$O(^YTT(601.87,"AD",SGIEN,SCALE)) Q:'SCALE  D
 . S KEY=0 F  S KEY=$O(^YTT(601.91,"AC",SCALE,KEY)) Q:'KEY  D
 . . I $P(^YTT(601.91,KEY,0),U,4)'="Fairly Often" Q
 . . ; update MH SCORING KEYS: TARGET (#3)
 . . S CHGS(3)="Fairly often"
 . . D UPDANY^YS119PS0(601.91,KEY,.CHGS)
 D UPDDT^YS119PS0(TSTIEN)
 Q
