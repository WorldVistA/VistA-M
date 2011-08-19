ABSVTP1 ;VAMC ALTOONA/CTB - BUILD MASTER FILE FROM AUSTIN ;12/17/93  2:38 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;;JULY 6, 1994
 ;THIS ROUTINE CONTINUES FROM ABSVTP AND LOOPS THROUGH TMP TO BUIL D MASTER FILE.
EN I $S('$D(^ABS(503330,0)):1,$P(^(0),"^",3)+$P(^(0),"^",4)=0:1,1:0) G ^ABSVTP2
 S X="There appears to be data in the Voluntary Master File #503330.  I will not overwrite existing data.  I will make new entries where necessary.  Where an entry already exists, I will add the appropriate station information." D MSG^ABSVQ
 S X="Since data exists, will now check to assure that there are no duplicate SSN's in your data." D MSG^ABSVQ,WAIT^ABSVYN
 S SSN=0 F I=1:1 S SSN=$O(^ABS(503330,"D",SSN)) Q:SSN=""  S N=$O(^ABS(503330,"D",SSN,0)) S N1=$O(^ABS(503330,"D",SSN,N)) I N1 W !,"DUPLICATE RECORDS EXIST FOR SSN ",SSN,".  Correction Necessary" S SSNCK=""
 I $D(SSNCK) K SSNCK S X="No further action can be taken until duplicate SSN's have been corrected.*" D MSG^ABSVQ Q
 S X="No duplicate SSN's were found.  Update will now continue." D MSG^ABSVQ
 G ^ABSVTP2
