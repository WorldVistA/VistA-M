PRCHJRP2 ;BP/VAC - Continuation of PRCHJRP1 ; 11/13/12 1:23pm
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine is a continuation of PRCHJRP1
 ;Its intent is to receive the VAL arrary from the call to the
 ;   Transaction File, separate out the fields, evaluate if the data
 ;   should be reported, and then store it in a ^TMP array to be
 ;   used to print the Transaction Report.
 ; ^XTMP("PRCHJRP1",0)=purge date^create date^"Transaction Report - eCMS/IFCAP"
 ; ^XTMP("PRCHJRP1",LL1,2237 number,transaction date,station,type,0)=
 ;    eCMS date,substation,eCMS User Name,Phone,email,reason
 ; ^XTMP("PRCHJRP1",LL1,2237 number,transaction date,station,type,1..n
 ;    = comments
 ;NOTE:LL1 is passed in on ZTSAVE and is equal to $J from PRCHJRP1
 ;
 ;VAL(2237 number,event date,event type,0)=
 ;   External Reference Number,Transaction Status text,HL7 message ID,
 ;   Station,sub-station,ecms User name, phone,email,returned/canceled date, returned/canceled reason,Comments
 ;VAL(2237 number,event date,event type,1..n)=
 ;  comments
 ;
 ;All variables are NEW'd in PRCHJRP1.
 Q
 ;
BLD ;This begins to build the ^TMP array
 S A=""
 S A=$O(VAL(A))
 S B=0
 F I=1:1 S B=$O(VAL(A,B)) Q:+B=0  D
 .S C=0
 .F J=1:1 S C=$O(VAL(A,B,C)) Q:+C=0  D
 ..;Type must be either 6,8, or 10
 ..Q:C<6
 ..Q:C>10
 ..Q:"79"[C
 ..S DAT=$G(VAL(A,B,C,0)) Q:DAT=""
 ..F K=1:1:11 S QD(K)=$P(DAT,"^",K)
 ..;Evaluate if the record should be reported on
 ..S OK="Y" D
 ...I IDATE="ALL" Q
 ...S TDATE=$P(B,".",1)
 ...I TDATE<IJDATE S OK="N"
 ...I TDATE>SJDATE S OK="N"
 ..Q:OK="N"
 ..D
 ...I STAT="ALL" Q
 ...I STAT'=QD(4) S OK="N"
 ..Q:OK="N"
 ..D
 ...I SSTAT="ALL" Q
 ...I (SSTAT="NONE")&($E($G(QD(5)),4,5)="") S OK="Y" Q
 ...I STAT_SSTAT'=QD(5) S OK="N"
 ..Q:OK="N"
 ..D
 ...I CONT="ALL" Q
 ...S QD(12)=$P(A,"-",4)
 ...I CONT'=QD(12) S OK="N"
 ..Q:OK="N"
 ..D
 ..;CHECK IF CP IS VALID FOR STATION AND FCP
 ..I ACC(0)=2 D
 ...S QD(12)=$P(A,"-",1),QD(13)=$P(A,"-",4)
 ...I $G(ACC(QD(12),QD(13)))'=1 S OK="N"
 ..D
 ...I TYPE="ALL" Q
 ...I (TYPE=3)&(C'=10) S OK="N" Q
 ...I (TYPE=2)&(C'=8) S OK="N" Q
 ...I (TYPE=1)&(C'=6) S OK="N" Q
 ...I (TYPE=4)&(UNAME'=QD(8)) S OK="N" Q
 ...I (TYPE=5)&(N2237'=A) S OK="N" Q
 ..Q:OK="N"
 ..S ODAT=QD(9)_"^"_QD(5)_"^"_QD(6)_"^"_QD(7)_"^"_QD(8)_"^"_QD(10)_"  "_QD(11)
 ..S ST=QD(4),FCP=$P(A,"-",4)
 ..S ^XTMP("PRCHJRP1",LL1,A,B,C,ST,FCP,0)=ODAT
 ..;NOW ADD WP FIELDS
 ..S M=0
 ..F L=1:1 S M=$O(VAL(A,B,C,M)) Q:M=""  D
 ...S ODAT=$G(VAL(A,B,C,M)) Q:ODAT=""
 ...S ^XTMP("PRCHJRP1",LL1,A,B,C,ST,FCP,M)=ODAT
 Q
HELP(NUM) ;This section will disply HELP messages for the input prompts.
 ;NUM is the indicator value identifying the prompt
 I NUM=1 D
 .W !,"Enter the date to select the earliest date for the report or",!," 'ALL' for all dates.",!
 .D HELP2
 I NUM=2 D
 .W !,"Enter a date to select the most recent date for the report",!
 .D HELP2
 I NUM=3 D
 .W !,"Enter a single 3 digit station number, 'ALL' for all stations, or '^' to quit.",!
 I NUM=4 D
 .W !,"Enter 2 characters for sub-station, 'ALL' for all sub-stations, 'NONE'"
 .W !,"to exclude all sub-stations, or '^' to quit",!
 I NUM=5 D
 .W !,"Enter the 3 or 4 digit Fund Control Point, 'ALL' for all FCPs, or '^' to quit.",!
 I NUM=6 D
 .W !,"Type=1: This selection will display only those message events that are Returns ",!,"to Accountable Officers."
 .W !,"Type=2: This selection will display only those message events that are Returns ",!,"to the Control Point level."
 .W !,"Type=3: This selection will display only those message events that are Canceled"
 .W !,"Type=4: Entering at least 2 characters of the eCMS User's Contact",!,"last name, will display a list of users for you to choose from."
 .W !,"Type=5: Enter the complete 2237 number you want to see, or a partial number",!,"for a list of possible matches i.e., 688-12-4-123",!
 Q
HELP2 ; Additional help message for dates
 W !,"Examples of Valid Dates"
 W !,"  JAN 20 1957 OR 20 JAN 57 OR 1/20/57 OR 012057"
 W !,"  T   (FOR TODAY), T+1 (FOR TOMORROW), T+2, T+7 etc"
 W !,"  T-1 (FOR YESTERDAY, T-3W  (FOR 3 WEEKS AGO), etc"
 W !,"If the year is omitted, the computer uses CURRENT YEAR.  Two digit year"
 W !,"assumes no more than 20 years in the future, or 80 years in the past."
 W !
 Q
HELP3 ;Displays help for user names
 W !,"Enter first 2 or more characters of Contact Name or enter ?? to obtain"
 W !,"a listing of possible choices."
 q
HELP4 ;Displays eCMS user names
 ;N STOP,TMP1,TMP2,K,ANS2
 S X="",STOP="G",UNAME=""
 ;used to be AEU
 I $D(^PRCV(414.06,"ACONTACT"))<1 W !,"No records are available" HANG 3 S UNAME="" Q
 F K=1:1 S X=$O(^PRCV(414.06,"ACONTACT",X)) Q:(X="")!(STOP="S")  D
 .W !,?5,K,?10,X
 .S Y=0
 .F L=1:1 S Y=$O(^PRCV(414.06,"ACONTACT",X,Y)) Q:(Y="")!(STOP="S")  D
 ..S Z=0
 ..F M=1:1 S Z=$O(^PRCV(414.06,"ACONTACT",X,Y,Z)) Q:(Z="")!(STOP="S")  D
 ...S MNAME=$P($G(^PRCV(414.06,Y,1,Z,1)),"^",6)
 ...S TMP1(K)=MNAME
 ...S TMP2(K)=X
 .W ?35,TMP1(K)
 .I K#5=0 D
 ..W !,"Select a name by the number or press <ENTER> to continue " R ANS2:DTIME I '$T S STOP="S" Q
 ..I ANS2="^" S STOP="S" Q
 ..I ANS2'?.N W !,"Enter numbers or '^' only.",! Q
 ..I ANS2>0&(ANS2'>K) S STOP="S",UNAME=TMP2(ANS2),MNAME=TMP1(ANS2)
HELP4D I UNAME="" W !,"Select a name by the number or <ENTER> to exit " R ANS2:DTIME I '$T G HELP4E
 I UNAME["?" W !,"Select a name by the number or <ENTER> to exit " R ANS2:DTIME I '$T G HELP4E
 I ANS2=""!(ANS2="^") Q
 I ANS2'?.N G HELP4D
 I ANS2>K G HELP4D
 I $D(TMP2(ANS2)) S UNAME=TMP1(ANS2),MNAME=TMP2(ANS2)
HELP4E K TMP1,TMP2
 Q
