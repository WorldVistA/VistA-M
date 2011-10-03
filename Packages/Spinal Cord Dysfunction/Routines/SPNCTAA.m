SPNCTAA ;WDE/SD SCORE TYPE MAIN DRIVER ;6/27/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19,20**;01/02/1997
 ;
 ; This is to select the type of data to enter for a patient.
 ; If none of the given report are selected then SPNFEXIT is set to 1
 ; and the program exits.
 ; Returns SPNSCOR as a value of 1 to 12 indicating the type
 ; of SCORE to be entered/edited
 ;
 ; Output:
 ;      SPNFEXIT = 1 User exited
 ;                 0 User passed
 ;      SPNSCOR  = 1-12  SCORE TYPE
IN ;set up dir string for inpatient
 K SPNAA,DIR S DIR(0)="SOM^"
 S SPNXX=0 F  S SPNXX=$O(^TMP($J,SPNXX)) Q:SPNXX=""  W "." S SPNYY=0 F  S SPNYY=$O(^TMP($J,SPNXX,SPNYY)) Q:SPNYY=""  S SPNZZ=0 F  S SPNZZ=$O(^TMP($J,SPNXX,SPNYY,SPNZZ)) Q:SPNZZ=""  D
 .S SPNRR=$P($G(^SPNL(154.1,SPNZZ,0)),U,2) Q:SPNRR=""  ;RECORD TYPE ON FILE
 .S SPNSS=$P($G(^SPNL(154.1,SPNZZ,2)),U,17) Q:SPNSS=""  ;SCORE TYPE ON FILE
 .I SPNRR=SPNFTYPE S SPNAA(SPNSS)=0
 ;I $D(SPNAA(A))=0 D
 S SPNQQ=0 F A=1,2,3,4,5,6 D
 .I $D(SPNAA(A))=0 I A=1 S DIR(0)=DIR(0)_A_":INPT START;"
 .I $D(SPNAA(A))=0 I A=2 S DIR(0)=DIR(0)_A_":INPT GOAL;"
 .I A=3 S DIR(0)=DIR(0)_A_":INPT INTERIM;"
 .I $D(SPNAA(A))=0 I A=4 S DIR(0)=DIR(0)_A_":INPT REHAB FINISH;"
 .I $D(SPNAA(A))=0 I A=5 S DIR(0)=DIR(0)_A_":INPT FOLLOW-UP (END);"
 .I A=6 S DIR(0)=DIR(0)_A_":UNKNOWN;"
 K A,SPNSS,SPNXX,SPNYY,SPNZZ
 ;K DIR S DIR(0)="SOM^1:INPT START;2:INPT GOAL;3:INPT INTERIM;4:INPT REHAB FINISH;5:INPT FOLLOW-UP (END);6:UNKNOWN"
 S DIR("?",1)="   Enter 1 for an INPT START outcome"
 S DIR("?",2)="   Enter 2 for an INPT GOAL outcome"
 S DIR("?",3)="   Enter 3 for an INPT INTERIM outcome"
 S DIR("?",4)="   Enter 4 for an INPT REHAB FINISH outcome"
 S DIR("?",5)="   Enter 5 for an INPT FOLLOW-UP (END) outcome"
 S DIR("?",6)="   Enter 6 for UNKNOWN if the score type is not known"
 S DIR("?")="   Enter 1,2,3,4,5 or 6."
 D ASK
 Q:(SPNSCOR="")!(SPNSCOR=0)!(SPNEXIT=1)
 ;   take input and convert it to proper value based on dd value
 S SPNSCOR=$S(SPNSCOR=1:1,SPNSCOR=2:2,SPNSCOR=3:3,SPNSCOR=4:4,SPNSCOR=5:5,1:11)
 Q
OUT ;set up dir string for outpatient
 K SPNAA,DIR S DIR(0)="SOM^"
 S SPNXX=0 F  S SPNXX=$O(^TMP($J,SPNXX)) Q:SPNXX=""  W "." S SPNYY=0 F  S SPNYY=$O(^TMP($J,SPNXX,SPNYY)) Q:SPNYY=""  S SPNZZ=0 F  S SPNZZ=$O(^TMP($J,SPNXX,SPNYY,SPNZZ)) Q:SPNZZ=""  D
 .S SPNRR=$P($G(^SPNL(154.1,SPNZZ,0)),U,2) Q:SPNRR=""  ;RECORD TYPE
 .S SPNSS=$P($G(^SPNL(154.1,SPNZZ,2)),U,17) Q:SPNSS=""  ;SCORE TYPE
 .I SPNRR=SPNFTYPE S SPNAA(SPNSS)=0
 S SPNQQ=0 F A=6,7,8,9,10,11 D
 .I $D(SPNAA(A))=0 I A=6 S DIR(0)=DIR(0)_"1:OUTPT START;"
 .I $D(SPNAA(A))=0 I A=7 S DIR(0)=DIR(0)_"2:OUTPT GOAL;"
 .I A=8 S DIR(0)=DIR(0)_"3:OUTPT INTERIM;"
 .I $D(SPNAA(A))=0 I A=9 S DIR(0)=DIR(0)_"4:OUTPT REHAB FINISH;"
 .I $D(SPNAA(A))=0 I A=10 S DIR(0)=DIR(0)_"5:OUTPT FOLLOW-UP (END);"
 .I A=11 S DIR(0)=DIR(0)_"6:UNKNOWN;"
 K A,SPNSS,SPNXX,SPNYY,SPNZZ
 ;K DIR S DIR(0)="SOM^1:OUTPT START;2:OUTPT GOAL;3:OUTPT INTERIM;4:OUTPT REHAB FINISH;5:OUTPT FOLLOW-UP (END);6:UNKNOWN"
 S DIR("?",1)="   Enter 1 for an OUTPT START outcome"
 S DIR("?",2)="   Enter 2 for an OUTPT GOAL outcome"
 S DIR("?",3)="   Enter 3 for an OUTPT INTERIM outcome"
 S DIR("?",4)="   Enter 4 for an OUTPT REHAB FINISH outcome"
 S DIR("?",5)="   Enter 5 for an OUTPT FOLLOW-UP (END) outcome"
 S DIR("?",6)="   Enter 6 for UNKNOWN if the score type is not known"
 S DIR("?")="   Enter 1,2,3,4,5 or 6."
 D ASK
 Q:(SPNSCOR="")!('+SPNSCOR)!(SPNEXIT=1)
 ;       take the input and convert it to the proper value based on
 ;       the dd value.
 S SPNSCOR=$S(SPNSCOR=1:6,SPNSCOR=2:7,SPNSCOR=3:8,SPNSCOR=4:9,SPNSCOR=5:10,1:11)
 Q
ANNUAL ;Annual eval  No reason to ask for care type as it is annual eval
 ;no score type is entered for annual eval
 S SPNSCOR=11
 Q
CONT ;continuum of care No reason to ask for care type as it is continuum
 ;no score type is entered for continuum of care
 K SPNAA,DIR S DIR(0)="SOM^"
 S DIR(0)=DIR(0)_"1:CC ADMIT;"
 S DIR(0)=DIR(0)_"2:CC GOAL;"
 S DIR(0)=DIR(0)_"3:CC INTERIM;"
 S DIR(0)=DIR(0)_"4:CC DISCHARGE;"
 S DIR(0)=DIR(0)_"5:CC OUTPT;"
 S DIR(0)=DIR(0)_"6:UNKNOWN;"
 S DIR("?",1)="   Enter 1 for an CC ADMIT outcome"
 S DIR("?",2)="   Enter 2 for an CC GOAL outcome"
 S DIR("?",3)="   Enter 3 for an CC INTERIM outcome"
 S DIR("?",4)="   Enter 4 for an CC DISCHARGE outcome"
 S DIR("?",5)="   Enter 5 for an CC OUTPT outcome"
 S DIR("?",6)="   Enter 6 for UNKNOWN if the score type is not known"
 S DIR("?")="   Enter 1,2,3,4,5 or 6."
 D ASK
 Q:(SPNSCOR="")!('+SPNSCOR)!(SPNEXIT=1)
 ;       take the input and convert it to the proper value based on
 ;       the dd value.
 S SPNSCOR=$S(SPNSCOR=1:12,SPNSCOR=2:13,SPNSCOR=3:14,SPNSCOR=4:15,SPNSCOR=5:16,1:11)
 Q
ASK ;
 S SPNEXIT=0
 I $D(IOF) W @IOF
 K DIRUT
 I $D(IOF) W @IOF
 S SPNSCOR=0
 S DIR("A")="Select the Score Type for this outcome"
 W ! D ^DIR K DIR S SPNSCOR=+Y
 I $D(DIRUT) S SPNEXIT=1 Q
 I $D(DIRUT) S:$D(DTOUT)!($D(DUOUT)) SPNEXIT=1 Q
 Q:SPNSCOR<1
 I $D(IOF) W @IOF
 Q
