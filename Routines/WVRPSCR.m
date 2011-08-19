WVRPSCR ;HCIOFO/FT,JR IHS/ANMC/MWR - Display Compliance Rates ;12/9/98  13:39
 ;;1.0;WOMEN'S HEALTH;**3**;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  THIS REPORT WILL DISPLAY COMPLIANCE RATES FOR PAPS & MAMS.
 ;
PRINT ;EP
 ;
 N I,J,M,N,P,Q
 D SETUP
 D TITLE^WVUTL5("COMPLIANCE RATES FOR PAPS AND MAMS")
 D TEXT1,DIRZ^WVUTL3 G:WVPOP EXIT
 D DATES   G:WVPOP EXIT
 D AGERNG  G:WVPOP EXIT
 D DEVICE  G:WVPOP EXIT
 D DATA^WVRPSCR1,EN^WVRPSCR2
 D DISPLAY
 I WVCRT&('$D(IO("S")))&('$G(WVPOP)) D DIRZ^WVUTL3 W @IOF
 ;
EXIT ;EP
 D KILLALL^WVUTL8
 Q
 ;
SETUP ;EP
 D SETVARS^WVUTL5
 Q
 ;
DATES ;EP
 ;---> ASK DATE RANGE.  RETURN DATES IN WVBEGDT AND WVENDDT.
 D ASKDATES^WVUTL3(.WVBEGDT,.WVENDDT,.WVPOP)
 Q
 ;
AGERNG ;EP
 ;---> ASK AGE RANGE.
 ;---> RETURN AGE RANGE IN WVAGRG.
 D AGERNG^WVRPSCR1(.WVAGRG,.WVPOP)
 Q
 ;
DEVICE ;EP
 ;---> GET DEVICE AND POSSIBLY QUEUE TO TASKMAN.
 S ZTRTN="DEQUEUE^WVRPSCR"
 F WVSV="AGRG","BEGDT","ENDDT" D
 .I $D(@("WV"_WVSV)) S ZTSAVE("WV"_WVSV)=""
 ;---> SAVE ATTRIBUTES ARRAY. NOTE: SUBSTITUTE LOCAL ARRAY FOR WVATT.
 I $D(WVCC) N N S N=0 F  S N=$O(WVCC(N)) Q:N=""  D
 .S ZTSAVE("WVCC("""_N_""")")=""
 D ZIS^WVUTL2(.WVPOP,1,"HOME")
 Q
 ;
 ;
DISPLAY ;EP
 U IO
 S WVTITLE="*  WOMEN'S HEALTH: COMPLIANCE RATES FOR PAPS AND MAMS  *"
 D CENTERT^WVUTL5(.WVTITLE)
 D TOPHEAD^WVUTL7
 S WVPAGE=1,WVPOP=0
 S WVSUB="W !?3,""For Age Range: "",$S(WVAGRG=1:""ALL"",1:WVAGRG)"
 ;
 S (WVPOP,N,Z)=0
 W:WVCRT @IOF D HEADER8^WVUTL7
 F  S N=$O(^TMP("WV",$J,N)) Q:'N!(WVPOP)  D
 .I N=16.001!(N=7.001) W ! D HDR^WVRPSCR2
 .I $Y+3>IOSL D:WVCRT DIRZ^WVUTL3 Q:WVPOP  I $O(^TMP("WV",$J,N))'="" W @IOF D HEADER8^WVUTL7 D:'WVCRT HDR^WVRPSCR2
 .W !,^TMP("WV",$J,N,0)
 D ^%ZISC
 Q
 ;
DEQUEUE ;EP
 ;---> CALLED BY TASKMAN
 D SETUP,DATA^WVRPSCR1,EN^WVRPSCR2,DISPLAY,EXIT
 Q
 ;
TEXT1 ;
 ;;This report is designed to serve as an indicator of compliance
 ;;rates for PAPs and MAMs.  The report will display the percentages
 ;;of women who received PAPs and MAMs for compliance purposes only,
 ;;within the selected date range.
 ;;
 ;;Only patients who have had normal results for procedures in the
 ;;specified date range are counted; the intent is to exclude
 ;;any procedures that would involve abnormal results, diagnostic
 ;;and follow-up procedures, etc.  Due to the complexities
 ;;involved in the treatment of individual cases that involve
 ;;abnormal results, those patients will not be included, even
 ;;though some of them may have received screening PAPs or MAMs.
 ;;
 ;;This report, therefore, serves ONLY AS AN INDICATOR (NOT as an exact
 ;;count of compliance rates) for gauging the success rates of annual
 ;;screening programs.  It can be run for several different time frames
 ;;in order to examine trends.  Assuming a screening cycle of one year,
 ;;a minimum date range spanning 15 months is recommended.
 S WVTAB=5,WVLINL="TEXT1" D PRINTX
 Q
 ;
PRINTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
