QAMSANE ;HISC/DAD-MONITOR SANITY CHECK ;9/10/93  14:35
 ;;1.0;Clinical Monitoring System;;09/13/1993
 ;
 ;Checks monitor with internal entry number QAMD0 for correctness.
 ;If the monitor is ok Y is returned as 1.  If The monitor is not
 ;ok Y will be returned as -1.  Error messages will also be printed
 ;if QAMMSGS contains an 'E'.  Warning messages will also be printed
 ;if QAMMSGS contains a 'W' (in addition to an 'E').  No messsages
 ;will be printed if QAMMSGS is undefined or null.
 ;
 ; Required variables
 ;  QAMD0   = IEN of a monitor (file #743)
 ;  QAMMSGS = <UNDEF> or Null - Do not display any messages
 ;            E               - Display error messages only
 ;            EW              - Display error and warning messages
 ;
 S Y=1 G EXIT:$D(QAMD0)[0,EXIT:QAMD0'?1N.N
 N QAMZERO,QAMONE,QAMTHRES,QAMERR,X
 S QAMZERO=$G(^QA(743,QAMD0,0)),QAMONE=$G(^QA(743,QAMD0,1))
 S QAMTHRES=$P(QAMONE,"^",3),QAMMSGS=$G(QAMMSGS)
 I QAMMSGS["E" W !!,"Checking monitor..."
 I QAMZERO="" S QAMERR=1 D ERROR G DONE ; Monitor exists
 I $P(QAMZERO,"^",4)="" S QAMERR=2 D ERROR ; Auto enroll monitor
 I $O(^QA(743,QAMD0,"COND",0))'>0 S QAMERR=3 D ERROR ; No conditions
 I $G(^QA(743,QAMD0,"REL"))="" S QAMERR=4 D ERROR ; Fall out relate
 I $G(^QA(743,QAMD0,"SMP"))="",$O(^QA(743,QAMD0,"COND","AS",0)) S QAMERR=5 D ERROR ; Sample size relate
 I $P(QAMONE,"^",15)'>0 S QAMERR=6 D ERROR ; Cond for date of event
 I $P(QAMONE,"^")'>0 S QAMERR=7 D ERROR ; Time frame
 I QAMTHRES="" S QAMERR=8 D ERROR ; Threshold
 I QAMTHRES["%",$P(QAMONE,"^",2)'>0 S QAMERR=9 D ERROR ; Minimum sample
 I QAMTHRES,QAMTHRES'["%",$P(QAMONE,"^",2)>QAMTHRES S QAMERR=10 D ERROR ; Pre-threshold alert level > threshold
 I QAMTHRES["%",$P(QAMONE,"^",4)="" S QAMERR=11 D ERROR ; Hi/Lo percent
 I $P(QAMONE,"^",9),$G(^QA(743,QAMD0,"WSR"))="" S QAMERR=12 D ERROR ; Print daily worksheets and no worksheet routine
 I $P(QAMONE,"^",10,12)["1",$P(QAMONE,"^",13)'>0 S QAMERR=13 D ERROR ; Bulletin mail group
 I $P(QAMONE,"^",6)'>0 S QAMERR=14 D ERROR ; Start date
 I $P(QAMONE,"^",6),$P(QAMONE,"^",7),$P(QAMONE,"^",7)<$P(QAMONE,"^",6) S QAMERR=15 D ERROR ; End date < Start date
 I $P(QAMONE,"^",5)'>0 S QAMERR=16 D ERROR ; On/Off switch
DONE I QAMMSGS["E" W !,$S(Y=1:"No errors found.",Y=-1:"All errors must be corrected in order for this monitor to run !!",1:""),!
EXIT K QAMMSGS
 Q
ERROR ; *** Set error flag (Y=-1) optionally write error message
 S X=$P($T(ERRMSG+QAMERR),";;",2)
 S:X Y=-1 Q:QAMMSGS=""  Q:(X'>0)&(QAMMSGS'["W")
 W !?2,$S(X:"*ERROR*",1:"Warning"),":  ",$P(X,"^",2)
 Q
ERRMSG ;;$S(1:"*ERROR*",0:"Warning") ^ Monitor error and warning messages
 ;;1^Monitor not found
 ;;1^AUTO ENROLL MONITOR not specified
 ;;1^No CONDITIONS specified
 ;;1^FALL OUT RELATIONSHIP not specified
 ;;0^SAMPLE RELATIONSHIP not specified
 ;;1^CONDITION FOR DATE OF EVENT not specified
 ;;0^TIME FRAME not specified
 ;;0^THRESHOLD not specified
 ;;0^MINIMUM SAMPLE not specified
 ;;0^PRE-THRESHOLD ALERT LEVEL greater than THRESHOLD
 ;;0^HI/LO PERCENT not specified
 ;;0^PRINT DAILY WORKSHEETS selected, WORKSHEET ROUTINE not specified
 ;;0^BULLETIN MAIL GROUP not specified
 ;;1^START DATE not specified
 ;;1^END DATE is less than the START DATE
 ;;0^ON/OFF SWITCH is turned off
