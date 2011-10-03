IVMCME4 ;ALB/SEK,BRM,TDM - CHECK INCOME TEST DATA ; 8/28/02 2:19pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,49,58,62**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is called from IVMCME.
 ;
ZMT(STRING) ; check ZMT segment
 ;
 ; Input:  STRING as ZMT segment
 ;
 ; Output: ERROR message or null
 ;
 N ERROR,I,X,Y
 S ERROR=""
 S X=$P(STRING,HLFS,2) I $E(X,1,4)<1993 S ERROR="Invalid Date of Test" G ZMTQ
 S X=$$FMDATE^HLFNC(X),%DT="X" D ^%DT I Y<0 S ERROR="Invalid Date of Test" G ZMTQ
 ;
 ; Means Test Status Checks
 I IVMTYPE=1 D MT^IVMCME5(STRING,ARRAY("ZIC")) I ERROR]"" G ZMTQ
 ;
 ; Copay Test Status Checks
 I IVMTYPE=2 D CO^IVMCME5(STRING) I ERROR]"" G ZMTQ
 ;
 ; Long Term Care Status Checks
 I IVMTYPE=4 D LTC^IVMCME5(STRING) I ERROR]"" G ZMTQ
 ;
 ; Field content/length
 F I=4,5 I $$NUM^IVMCME2($P(STRING,HLFS,I),10,2) S ERROR=$S(I=4:"INCOME",1:"NET WORTH")_" field content/length error" Q
 I ERROR]"" G ZMTQ
 ;
 ; gather income totals
 D INC^IVMCME5 I ERROR]"" G ZMTQ
 ;
 ; Adjudicate Date/Time
 S X=$P(STRING,HLFS,6) I X]"" D  I ERROR]"" G ZMTQ
 . I $E(X,1,4)<1993!($E(X,1,4)>($E(DT,1,3)+1700)) S ERROR="Invalid Adjudication Date/Time" Q
 . S X=$$FMDATE^HLFNC(X),%DT="TX" D ^%DT I Y<0 S ERROR="Invalid Adjudication Date/Time" Q
 ;
 ; Agree to Pay Deductible
 S X=$P(STRING,HLFS,7) I X]"",(X'=0),(X'=1) S ERROR="Invalid Agreed To Pay Deductible Value" G ZMTQ
 I $P(STRING,HLFS,26)="A",X'="" S ERROR="MT Copay Exempt veteran-Agree to Pay Deductible should be null" G ZMTQ
 ;
 ; Threshold A value
 I IVMTYPE=1 D  I ERROR]"" G ZMTQ
 .S X=$P(STRING,HLFS,8) I X']"" S ERROR="Invalid Threshold A value"
 .I (X'>0)!(X'<99001) S ERROR="Invalid Threshold A value"
 ;
 ; GMT Threshold Value
 I IVMTYPE=1 D  I ERROR]"" G ZMTQ
 .S X=$P(STRING,HLFS,28)
 .I ((X'="")&(X'=0))&((X'>0)!(X'<100000)) S ERROR="Invalid GMT Threshold"
 ;
 ; Deductibe Expenses
 I $$NUM^IVMCME2($P(STRING,HLFS,9),10,2) S ERROR="Deductible Expenses field content/length error" G ZMTQ
 I $P(STRING,HLFS,4)<($P(STRING,HLFS,9)) S ERROR="Deductible Expenses cannot exceed income" G ZMTQ
 ;
 ; Means Test Completion Date/Time
 S X=$P(STRING,HLFS,10) I $E(X,1,4)<1992 S ERROR="Invalid Completion Date/Time" G ZMTQ
 S X=$$FMDATE^HLFNC(X),%DT="TX" D ^%DT I Y<0 S ERROR="Invalid Completion Date/Time" G ZMTQ
 ;
 ; Hardship consistency checks
 N HARDSHIP K HARDSHIP
 S HARDSHIP("Y/N")=$P(STRING,HLFS,13)
 S HARDSHIP("SITE")=$P(STRING,HLFS,23)
 S HARDSHIP("EFFDATE")=$P(STRING,HLFS,24)
 ;
 I (IVMTYPE'=4),(HARDSHIP("Y/N"))!(+HARDSHIP("SITE"))!(HARDSHIP("EFFDATE")) D  I ERROR]"" G ZMTQ
 .I HARDSHIP("Y/N")="" S ERROR="Missing Hardship Indicator" Q
 .I HARDSHIP("SITE")="" S ERROR="Missing Site Granting Hardship" Q
 .;starting in year 2000, all hardships should have an effective date
 .I $E($P(STRING,HLFS,2),1,4)'<2000,(HARDSHIP("EFFDATE")="") S ERROR="Missing Hardship Effective Date" Q
 .I $L(HARDSHIP("EFFDATE")) S X=$$FMDATE^HLFNC(HARDSHIP("EFFDATE")),%DT=X D ^%DT I Y<0 S ERROR="Invalid Hardship Effective Date" Q
 .I HARDSHIP("EFFDATE"),(HARDSHIP("EFFDATE")<$P(STRING,HLFS,2)) S ERROR="Hardship Effective Date earlier than Means Test Date" Q
 ;
 ; Date Veteran Signed/Refused to Sign
 D SIGN^IVMCME5 I ERROR]"" G ZMTQ
 ;
 ; Source of Test
 S X=$P(STRING,HLFS,18)
 I X'=1,X'=2,X'=3,X'=4 S ERROR="Source of Test must be identified" G ZMTQ
 I X=4,$P(STRING,HLFS,22)="" S ERROR="Site Conducting Test must be identified" G ZMTQ
 ;
ZMTQ Q ERROR
