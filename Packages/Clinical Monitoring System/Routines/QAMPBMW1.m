QAMPBMW1 ;HISC/DAD-BUILD A MONITOR WORKSHEET ;4/9/93  09:01
 ;;1.0;Clinical Monitoring System;;09/13/1993
 K UNDL S $P(UNDL,"_",81)="",QAOSQUIT=0
 I QAOSCPY=1,$E(IOST)="C" D FF
 W !?27,"Build a Monitor Worksheet"
 S X="1. Shortened code name or number: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 S X="2. Title: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 S X="3. Service: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 S X="4. Standard of Care: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 F QA=1:1:6 W !!,UNDL
 D PAUSE Q:QAOSQUIT
 S X="5. Clinical Indicator: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 F QA=1:1:6 W !!,UNDL
 W !!,"6. Rationale(s):"
 W ! D EN^QAMPBMW0("^QA(743.91,")
 D PAUSE Q:QAOSQUIT
 S X="Rationale Explanation: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 F QA=1:1:6 W !!,UNDL
 W !!,"7. Auto Enroll Monitor: Yes / No"
 D PAUSE Q:QAOSQUIT
 D FF
 W !,"8. Conditions that apply: (Number each to aid you in answering questions"
 W !,"related to conditions.)"
 W ! D EN^QAMPBMW0("^QA(743.3,")
 D PAUSE Q:QAOSQUIT
 W !!,"Do any of the conditions require the development of a group?  If so, use the"
 W !,"Group Edit option to build the needed group(s).  See the condition description"
 W !,"for what groups are needed and their parent files."
 F QA=1:1:3 D
 . S X="Group Name: ",X=X_$E(UNDL,1,38-$L(X)) W !!,X
 . S X="Parent File: ",X=X_$E(UNDL,1,40-$L(X)) W ?40,X
 . S X="Group Members: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 . Q
 D PAUSE Q:QAOSQUIT
 S X="What other information is required by each condition?"
 S X=X_$E(UNDL,1,80-$L(X)) W !!,X
 F QA=1:1:4 W !!,UNDL
 W !!,"Which conditions define the denominator (sample)?"
 F QA=1:1:2 W !!,$E(UNDL,1,24),?28,$E(UNDL,1,24),?56,$E(UNDL,1,24)
 W !!,"9. Choose which conditions define the fall outs and what is their relationship"
 W !,"to each other?  Use & (and), ! (or), ' (not), and parentheses () to specify the"
 W !,"relationship between two or more conditions.  Example: (C1&C2)!(C3&C4)"
 W !!,UNDL
 D PAUSE Q:QAOSQUIT
 D FF
 W !,"10. What is the relationship between the conditions that define the denominator"
 W !,"(sample)?  Use & (and), ! (or), ' (not), and parentheses () to specify the"
 W !,"relationship between two or more conditions.  Example: (C1&C2)!(C3!C4)"
 W !!,UNDL
 S X="11. What condition defines the date of the event: "
 S X=X_$E(UNDL,1,80-$L(X)) W !!,X
 W !!,"12. Time Frame: (Choose only one.)"
 W ! D EN^QAMPBMW0("^QA(743.92,")
 S X="13. Threshold: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 W !,"If this is a percent threshold, should the threshold be met when the calculated"
 W !,"percentage is (high) >= or (low) <= the threshold."
 D PAUSE Q:QAOSQUIT
 S X="14. For percent thresholds, the Minimum Sample Size: "
 S X=X_$E(UNDL,1,80-$L(X)) W !!,X
 S X="    For numeric thresholds, the Pre-Threshold Alert Level: "
 S X=X_$E(UNDL,1,80-$L(X)) W !!,X
 W !!,"15. Do you want to allow 'duplicate' fall outs during the time frame: Yes / No"
 W !!,"16. Other Data to Capture: Review the list of data elements for each condition"
 W !,"you are using to select a list for capture with each fall out."
 F QA=1:1:4 W !!,$E(UNDL,1,39),?40,$E(UNDL,1,40)
 D PAUSE Q:QAOSQUIT
 W !!,"17. Do you want to print:      1) Daily fall out list:  Yes / No"
 W !,"                               2) Daily worksheets:     Yes / No"
 W !!,"18. Do you want a bulletin:    1) When threshold met:   Yes / No"
 W !,"                               2) At end of time frame: Yes / No"
 W !,"                               3) When alert level met: Yes / No"
 S X="19. What mail group will receive the bulletins: "
 S X=X_$E(UNDL,1,80-$L(X)) W !!,X
 S X="20. Start Date: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 S X="    End   Date: ",X=X_$E(UNDL,1,80-$L(X)) W !!,X
 W !!,"21. Remember to turn it ON and mark it as FINISHED."
 D PAUSE Q:QAOSQUIT
 Q
FF ;
 W @IOF
 Q
PAUSE ;
 Q:$E(IOST)'="C"  K DIR S DIR(0)="E" D ^DIR S QAOSQUIT=$S(Y'>0:1,1:0)
 Q
