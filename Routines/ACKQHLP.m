ACKQHLP ;AUG/JLTP BIR/PTD-QUASAR Help Text ; [ 11/02/95 15:38 ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 Q:$S('($D(ACKQHLP)#2):1,$E(ACKQHLP)=U:0,$T(@ACKQHLP)="":1,1:0)
 N ACKTXT,EXP,FIND,I,TAG,X,Y
 ;  If field 100 display narrative for all word processing fields
 I $E(ACKQHLP)=U,$P(ACKQHLP,"^",2)="509850.6",$P(ACKQHLP,"^",3)="100" D CPTEXT,DDHLP1 Q
 I $E(ACKQHLP)=U D DDHLP Q
 F I=1:1 S TAG=ACKQHLP_"+"_I,@("ACKTXT=$P($T("_TAG_"),"";;"",2)") Q:ACKTXT=""  D PROC W !,ACKTXT
 K ACKQHLP Q
DDHLP ;DISPLAY HELP TEXT FROM DD'S FIELD DESCRIPTION
 W @IOF
DDHLP1 S X(1)=+$P(ACKQHLP,U,2),X(2)=+$P(ACKQHLP,U,3) Q:$S('X(1):1,'X(2):1,'$D(^DD(X(1),X(2),0)):1,1:0)
 S I=0 F  S I=$O(^DD(X(1),X(2),21,I)) Q:'I  S ACKTXT=^(I,0) D PROC W !,ACKTXT
 K ACKQHLP Q
PROC ;
 F  Q:ACKTXT'["|"  S EXP=$P(ACKTXT,"|",2) D RESOLV S ACKTXT=$P(ACKTXT,"|")_EXP_$P(ACKTXT,"|",3,245)
 Q
RESOLV ;
 S X=EXP X ^%ZOSF("UPPERCASE")
 I Y="TAB" S EXP="",FIND=$F(ACKTXT,"|")-2,$P(EXP," ",FIND\8+1*8-(FIND))="" Q
 I Y="NOWRAP"!(Y="WRAP") S EXP="" Q  ;NOWRAP IS FORCED NO MATTER
 I $E(Y,1,4)="S X=" X Y S EXP=X Q
 Q
 ;
CPTEXT ;  Display C&P exam for Audio # 1305 worksheet narrative
 W @IOF,?30,"Compensation and Pension Examination"
 W ! S X="For AUDIO" D CNTR^ACKQUTL(X)
 W ! S X="#1305 Worksheet" D CNTR^ACKQUTL(X)
 W !!," An examination of hearing impairment must be conducted by a state-licensed"
 W !," audiologist and must include a controlled speech discrimination test"
 W !," (specifically, the Maryland CNC recording) and a pure tone audiometry test in"
 W !," a sound isolated booth that meets American National Standards Institute"
 W !," standards (ANSI S3.1.1991) for ambient noise."
 W !!," Measurements will be reported at the frequencies of 500, 1000, 2000, 3000,"
 W !," and 4000 Hz.  The examination will include the following tests: pure tone"
 W !," audiometry by air conduction at 250, 500, 1000, 2000, 3000, 4000 Hz, and 8000"
 W !," Hz; and by bone conduction at 250, 500, 1000, 2000, 3000, and 4000 Hz;"
 W !," spondee thresholds; speech recognition using the recorded Maryland CNC Test;"
 W !," tympanometry; and acoustic reflex tests, and, when necessary, Stenger tests."
 W !," Bone conduction thresholds are measured when the air conduction thresholds"
 W !," are poorer than 15 dB HL.  A modified Hughson-Westlake procedure will be used"
 W !," with appropriate masking.  A Stenger test must be administered whenever pure"
 W !," tone air conduction thresholds at 500, 1000, 2000, 3000, and 4000 Hz"
 W !," differ by 20 dB or more between the two ears."
 K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR
 ;
 W @IOF,?30,"Compensation and Pension Examination"
 W ! S X="For AUDIO" D CNTR^ACKQUTL(X)
 W ! S X="#1305 Worksheet (Continued)" D CNTR^ACKQUTL(X)
 W !!," Maximum speech recognition will be reported with the 50-word VA-approved"
 W !," recording of the Maryland CNC test.  When speech recognition is 92% or less,"
 W !," a performance intensity function will be obtained with a starting"
 W !," presentation level of 40dB re SRT.  If necessary, the starting level will be"
 W !," adjusted upward to obtain a level at least 5 dB above the threshold at 2000"
 W !," Hz.  The examination will be conducted without the use of hearing aids. Both"
 W !," ears must be examined for hearing impairment even if hearing loss in only one"
 W !," ear is at issue.",!!
 ;
 Q
1 ;;
 ;;  
 ;;     You are selecting a date range for this report.  Enter a starting
 ;;     and ending date for which you want the report to run.  The report will
 ;;     gather all data beginning with (inclusively) the start date and ending
 ;;     with (inclusively) the ending date.
 ;;     
 ;;     To run the report for a single day's data, specify that date as
 ;;     both the beginning and ending date.  Use standard DHCP date format.
 ;; 
 ;;|S X="" D HELP^%DTC S X=""|
2 ;;
 ;;  
 ;;     The appointments shown here have already been entered for the
 ;;     patient/date you have selected.  Answer YES if you wish to edit one
 ;;     of the appointments shown here.  If you are trying to enter a new
 ;;     appointment for this patient/date then you should answer NO.
 ;; 
3 ;;
 ;;  
 ;;     Select the C&P exam you wish to adequate.  You can select by
 ;;     DATE OF EXAM, by PATIENT NAME, SSN, or initial and last four.  You
 ;;     can only choose exams with the status AWAITING ADEQUATION.
 ;; 
4 ;;
 ;;  
 ;;     Subtotals will be shown for clinician(s), other provider(s), or
 ;;     student(s).  At this time you must decide whether to count the
 ;;     procedures for a single clinician/other provider/student or to
 ;;     include all.
 ;; 
6 ;;
 ;;  
 ;;     Answer YES if you are ready to enter your electronic
 ;;     signature to release this exam.  Answer NO if this exam is
 ;;     not ready to be released to the regional office.
 ;; 
