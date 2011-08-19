IVMUCHK4 ;ALB/CAW - Filter routine to validate IVM Center Transmission, Con't ; September 19, 1994
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;**1**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is a continuation of IVMUCHK.  It performs checks on incoming means test
 ; transmissions to ensure they are accurate prior to their upload into DHCP.
 ;
 ;
ZMT(STRING) ; check ZMT segment
 ;
 ; Input:  STRING as ZMT segment
 ;
 ; Output: ERROR message or null
 ;
 N ERROR,I,X
 S ERROR=""
 S X=$P(STRING,HLFS,2) I $E(X,1,4)<1993!($E(X,1,4)>($E(DT,1,3)+1700)) S ERROR="Invalid Date of Test" G ZMTQ
 S X=$$FMDATE^HLFNC(X),%DT="X" D ^%DT I Y<0 S ERROR="Invalid Date of Test" G ZMTQ
 ;
 ; Status Checks
 D MT^IVMUCHK5(STRING,ARRAY("ZIC")) I ERROR]"" G ZMTQ
 ;
 ; Field content/lenght
 F I=4,5 I $$NUM^IVMUCHK2($P(STRING,HLFS,I),10,2) S ERROR=$S(I=4:"INCOME",1:"NET WORTH")_" field content/length error"
 I ERROR]"" G ZMTQ
 ;
 ; gather income totals
 D INC^IVMUCHK5 I ERROR]"" G ZMTQ
 ;
 ; Adjudicate Date/Time
 S X=$P(STRING,HLFS,6) I X]"" D  I ERROR]"" G ZMTQ
 . I $E(X,1,4)<1993!($E(X,1,4)>($E(DT,1,3)+1700)) S ERROR="Invalid Adjudication Date/Time" Q
 . S X=$$FMDATE^HLFNC(X),%DT="TX" D ^%DT I Y<0 S ERROR="Invalid Adjudication Date/Time" Q
 ;
 ; Agree to Pay Deductible
 S X=$P(STRING,HLFS,7) I X]"",(X'=0),(X'=1) S ERROR="Invalid Agreed To Pay Deductible Value" G ZMTQ
 I $P(STRING,HLFS,3)="A",X'="" S ERROR="Cat A veteran-Agree to Pay Deductible should be null" G ZMTQ
 ;
 ; Threshold A value
 S X=$P(STRING,HLFS,8) I X']"" S ERROR="Invalid Threshold A value" G ZMTQ
 I (X'>0)!(X'<99001) S ERROR="Invalid Threshold A value" G ZMTQ
 ;
 ; Deductibe Expenses
 I $$NUM^IVMUCHK2($P(STRING,HLFS,9),10,2) S ERROR="Deductible Expenses field content/length error" G ZMTQ
 I $P(STRING,HLFS,4)<($P(STRING,HLFS,9)) S ERROR="Deductible Expenses cannot exceed income" G ZMTQ
 ;
 ; Means Test Completion Date/Time
 S X=$P(STRING,HLFS,10) I $E(X,1,4)<1992!($E(X,1,4)>($E(DT,1,3)+1700)) S ERROR="Invalid Completion Date/Time" G ZMTQ
 S X=$$FMDATE^HLFNC(X),%DT="TX" D ^%DT I Y<0 S ERROR="Invalid Completion Date/Time" G ZMTQ
 ;
 ; Previous Year Threshold
 S X=$P(STRING,HLFS,11) I X]"" S ERROR="Previous year threshold value must be null" G ZMTQ
 ;
 ; Dependents
 I $P(STRING,HLFS,12)'=DEP S ERROR="Number of Dependents does not match dependents transmitted" G ZMTQ
 ;
 ; Hardship
 S X=$P(STRING,HLFS,13) I X]"",X'=0 S ERROR="Can't accept Hardship transmissions" G ZMTQ
 I $P(STRING,HLFS,14)]"" S ERROR="Hardship Review Date should be null" G ZMTQ
 ;
 ; Date Veteran Signed/Refused to Sign
 D SIGN^IVMUCHK5 I ERROR]"" G ZMTQ
 ;
 ; Date IVM Verif. MT Complete
 I $P(STRING,HLFS,20)]"" S X=$$FMDATE^HLFNC($P(STRING,HLFS,20)),%DT="X" D ^%DT I Y<0 S ERROR="Invalid Date IVM Verif. MT Complete Test" G ZMTQ
 ;
 ; Declines to Give Info
 S X=$P(STRING,HLFS,16) I X]"" S ERROR="Declines to give Income Info must be null" G ZMTQ
 ;
 ; Type of Test/Source of Test/Primary Income Test
 S X=$P(STRING,HLFS,17) I X'=1 S ERROR="Type of Test must be set to 1 for Means Test" G ZMTQ
 S X=$P(STRING,HLFS,18) I X'=2 S ERROR="Source of Test must be set to 2 for IVM" G ZMTQ
 S X=$P(STRING,HLFS,19) I 'X S ERROR="Primary Income Test should be set to 1 if returned" G ZMTQ
 ;
 ;Refused to Sign
 S X=$P(STRING,HLFS,21) I X]"",(X'=0),(X'=1) S ERROR="Refused to Sign has invalid value" G ZMTQ
 I $P(STRING,HLFS,21)]"",X=1,$P(STRING,HLFS,7)'=0 S ERROR="Veteran Refused To Sign-Agreed to Pay Deductible set to yes"
ZMTQ Q ERROR
