YS119PS0 ;SLC/KCM - Patch 119 post-init - utilities; 9/15/2015
 ;;5.01;MENTAL HEALTH;**119**;Dec 30, 1994;Build 40
 Q
 ;
FIXTESTS ; Fixes for existing tests
 D FIXHIPPO
 D AUDIT^YS119PS1
 D BAI^YS119PS1
 D MMPI2RF^YS119PS1
 D MOCA^YS119PS1
 D PCPTSD^YS119PS1
 D PHQ9^YS119PS1
 D WAISR^YS119PS1
 D EN1^YS119PS2  ; MCMI3
 Q
FINDTEST(NAME) ; return test id given name
 Q +$O(^YTT(601.71,"B",NAME,0))
 ;
FINDSGRP(IEN,SEQ) ; return scalegroup id given test id and group sequence
 I '$D(SEQ) Q +$O(^YTT(601.86,"AD",IEN,0))
 Q +$O(^YTT(601.86,"AC",IEN,SEQ,0))
 ;
FINDSCL(IEN,SEQ) ; return scale id given scalegroup id and scale sequence
 I '$D(SEQ) Q +$O(^YTT(601.87,"AD",IEN,0))
 Q +$O(^YTT(601.87,"AC",IEN,SEQ,0))
 ;
FINDRPT(IEN) ; return a report id given a test id
 Q +$O(^YTT(601.93,"C",IEN,0))
 ;
FINDCTNT(TIEN,DESIG) ; return content id given test id and designator
 N CIEN,X0,DONE
 S DONE=0
 S CIEN=0 F  S CIEN=$O(^YTT(601.76,"AC",TIEN,CIEN)) Q:'CIEN  D  Q:DONE
 . I $P(^YTT(601.76,CIEN,0),U,5)=DESIG S DONE=1
 Q CIEN
 ;
FINDQD(TIEN,DESIG) ; return question id given test id and designator
 N CIEN
 S CIEN=$$FINDCTNT(TIEN,DESIG)
 Q $P(^YTT(601.76,CIEN,0),U,4)
 ;
FINDCHC(TIEN,DESIG,SEQ) ; return choice id
 ; given test id, designator, and choice sequence
 N QIEN,CTYPIEN,CIEN
 S CIEN=0
 S QIEN=$$FINDQD(TIEN,DESIG)
 S CTYPIEN=$P($G(^YTT(601.72,+QIEN,2)),U,3)
 I CTYPIEN S CIEN=$O(^YTT(601.751,"AC",CTYPIEN,SEQ,0))
 Q CIEN
 ;
DELANY(FILEN,IEN) ; remove any MH record
 Q:FILEN<601  Q:FILEN>604  ; limit to MH files
 N DIK,DA
 S DIK="^YTT("_FILEN_",",DA=IEN
 D ^DIK
 Q
UPDANY(FILEN,IEN,CHGS) ; update any MH record
 Q:FILEN<601  Q:FILEN>604  ; limit to MH files
 N FDA,DIERR
 M FDA(FILEN,IEN_",")=CHGS
 D FILE^DIE("","FDA")
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 K CHGS ; clean up for next call
 Q
UPDRPT(IEN,TAG,RTN) ; Update MH REPORT entry with text in @TAG
 N I,X,WP,DIERR
 F I=1:1 S X=$P($T(@(TAG_"+"_I_U_RTN)),";;",2,99) Q:X="zzzzz"  S WP(I)=X
 D WP^DIE(601.93,IEN_",",2,"","WP")
 I $D(DIERR) D MES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
UPDWP(FILEN,IEN,WP) ; update word processing field in MH
 N DIERR
 D WP^DIE(FILEN,IEN_",",1,"","WP")
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
UPDDT(TSTIEN) ; Update LAST EDIT DATE so GUI pull over new changes 
 S CHGS(18)=3160729
 D UPDANY^YS119PS0(601.71,TSTIEN,.CHGS)
 Q
 ;
 ;
FIXHIPPO ; fix MOCA ALT1 mis-spelling of hippopotamus
 N TSTIEN,QUIEN,CHIEN,SCALE,KEY,CHGS,RPTIEN
 S TSTIEN=$$FINDTEST^YS119PS0("MOCA ALT 1")
 S QUIEN=$$FINDQD^YS119PS0(TSTIEN,"4C.")
 S SCALE=$$FINDSCL^YS119PS0($$FINDSGRP^YS119PS0(TSTIEN))
 S CHGS(1)="Hippopotamus"
 D UPDWP^YS119PS0(601.72,QUIEN,.CHGS)  ; update question
 K CHGS
 S CHIEN=$$FINDCHC^YS119PS0(TSTIEN,"4C.",1)
 S CHGS(3)="Correctly named hippopotamus"
 D UPDANY^YS119PS0(601.75,CHIEN,.CHGS) ; update choice
 S KEY=0 F  S KEY=$O(^YTT(601.91,"AC",SCALE,KEY)) Q:'KEY  D
 . I $P(^YTT(601.91,KEY,0),U,3)'=QUIEN Q
 . S CHGS(3)="Correctly named hippopotamus"
 . D UPDANY^YS119PS0(601.91,KEY,.CHGS) ; update target in scoring key
 S RPTIEN=$$FINDRPT^YS119PS0(TSTIEN)
 D UPDRPT^YS119PS0(RPTIEN,"HIPPORPT","YS119PS0") ; update report
 D UPDDT^YS119PS0(TSTIEN)
 Q
HIPPORPT ;
 ;;.| .| Montreal Cognitive Assessment, Alternate 1| | Date Given: <.Date_Given.>| Clinician: <.Staff_Ordered_By.>| Location: <.Location.>| | Veteran: <.Patient_Name_Last_First.>| SSN: <.Patient_SSN.>| 
 ;;DOB: <.Patient_Date_Of_Birth.> (<.Patient_Age.>)| Gender: <.Patient_Gender.>| | MoCA Score: <-MoCA Score->| |    A score of 26 or greater is considered normal.| | Questions and Answers| | 1. 
 ;;Alternating Trail Making.  Correct Pattern: 1-A- 2- B- 3- C- 4- D- 5- E, without drawing any lines that cross. Any error that is not immediately self-corrected is scored incorrect.|     
 ;;<*Answer_5614*>| 2. Rectangle-Visuoconstructional Skills. Correct: All must be present: three-dimensional, all lines are drawn, no line is added, lines are relatively parallel and their length is 
 ;;correct.|     <*Answer_5615*>| 3. Draw a clock   |    3A. Clock face must be a circle with only minor distortion acceptable (e.g.,| slight imperfection on closing the circle).|     <*Answer_5616*>|   
 ;; 3B. All clock numbers must be present with no additional numbers; numbers must be in the correct order and placed in the approximate quadrants on the clock face; Roman numerals are acceptable; 
 ;;numbers can be placed outside the circle contour. |     <*Answer_5617*>|    3C. There must be two hands jointly indicating the correct time; the hour hand must be clearly shorter than the minute 
 ;;hand; hands must be centered within the clock face with their junction close to the clock center. |     <*Answer_5618*>| 4. Naming pictured animals|    4A. Giraffe|     <*Answer_5619*>|    4B. Bear|  
 ;;   <*Answer_5620*>|    4C. Hippopotamus|     <*Answer_5621*>| 5. Attention|    5A. Forward Digit Span.|     <*Answer_5622*>|    5B. Backward Digit Span. Correct response for the backwards trial is 
 ;;2-5-8.|     <*Answer_5623*>|    5C. Vigilance. Correct when there is zero to one errors (an error is a tap on a wrong letter or a failure to tap on letter A).|     <*Answer_5624*>|    5D. Serial 7s 
 ;;starting at 90. Continue for five responses.|     <*Answer_5625*>| 6. Language|    6A. Sentence repetition. A bird can fly into closed windows when it's dark and windy.|     <*Answer_5626*>|    6B. 
 ;;Sentence repetition. The caring grandmother sent groceries over a week ago.|     <*Answer_5627*>| 7. Words beginning with the letter S.|     <*Answer_5628*>| 8. Abstaction|    8A. Similarity between 
 ;;DIAMOND - RUBY.|     <*Answer_5630*>|    8B. Similarity between CANNON - RIFLE.|     <*Answer_5643*>| 9. Delayed recall|    9A. Recall TRUCK|     <*Answer_5631*>|    9B. Recall BANANA.|     
 ;;<*Answer_5632*>|    9C. Recall VIOLIN.|     <*Answer_5633*>|    9D. Recall DESK.|     <*Answer_5634*>|    9E. Recall GREEN.|     <*Answer_5635*>| 10. Orientation|    10A. Today's date,|     
 ;;<*Answer_5636*>|    10B. Current month|     <*Answer_5637*>|    10C. Current year|     <*Answer_5638*>|    10D. Day of the week|     <*Answer_5639*>|    10E. What place is this?|     <*Answer_5640*>| 
 ;;   10F. What city are we in?|     <*Answer_5641*>| 11. Years of formal education:|     <*Answer_5642*>| | Copyright (c) Z. Nasreddine MD| | Information contained in this note is based on a 
 ;;self-report assessment and is not sufficient to use alone for diagnostic purposes.  Assessment results should be verified for accuracy and used in conjunction with other diagnostic activities and 
 ;;procedures.|     $~
 ;;zzzzz
 ;
 ;
SHOWC(TSTIEN) ; show content entries
 N CIEN
 S CIEN=0 F  S CIEN=$O(^YTT(601.76,"AC",TSTIEN,CIEN)) Q:'CIEN  D PRTCAP(601.76,CIEN)
 Q
SHOWK(TSTIEN) ; show scale key entries
 N SGSEQ,SGIEN,SCSEQ,SCIEN,KEY
 S SGSEQ=0 F  S SGSEQ=$O(^YTT(601.86,"AC",TSTIEN,SGSEQ)) Q:'SGSEQ  D
 . S SGIEN=0 F  S SGIEN=$O(^YTT(601.86,"AC",TSTIEN,SGSEQ,SGIEN)) Q:'SGIEN  D
 . . W !!,">>>>>>>>>> Scale Group Seq#",SGSEQ,"  Name: ",$P(^YTT(601.86,SGIEN,0),U,3)
 . . S SCSEQ=0 F  S SCSEQ=$O(^YTT(601.87,"AC",SGIEN,SCSEQ)) Q:'SCSEQ  D
 . . . S SCIEN=0 F  S SCIEN=$O(^YTT(601.87,"AC",SGIEN,SCSEQ,SCIEN)) Q:'SCIEN  D
 . . . . W !,"---------- Scale Seq#",SCSEQ,"  Name: ",$P(^YTT(601.87,SCIEN,0),U,3)
 . . . . S KEY=0 F  S KEY=$O(^YTT(601.91,"AC",SCIEN,KEY)) Q:'KEY  D PRTCAP(601.91,KEY)
 Q
PRTCAP(FILEN,IEN) ; Captioned output for a record
 N TABTO,COLWIDTH,INDENT,DFLTIOM,FIELD,VALS,FLDS
 S TABTO=0,COLWIDTH=40,INDENT=2,DFLTIOM=80
 D GETS^DIQ(FILEN,IEN_",","*","EN","VALS")
 W !!
 S FIELD=0 F  S FIELD=$O(VALS(FILEN,IEN_",",FIELD)) Q:'FIELD  D
 . D FIELD^DID(FILEN,FIELD,"","LABEL","FLDS")
 . I TABTO>($G(IOM,DFLTIOM)-COLWIDTH) S TABTO=0 W ?INDENT,!
 . W ?TABTO,FLDS("LABEL"),": ",VALS(FILEN,IEN_",",FIELD,"E")
 . S TABTO=TABTO+COLWIDTH
 Q
