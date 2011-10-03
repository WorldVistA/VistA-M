IVMCME1 ;ALB/SEK - CHECK INCOME RELATION DATA ; 02-MAY-95
 ;;2.0;INCOME VERIFICATION MATCH;**17**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is called from IVMCME.
 ;
ZIR(STRING,DEPIEN) ; check validity of ZIR segment
 ;
 ; Input:  STRING as ZIR segment
 ;         DEPIEN as the IEN of the dependent in the array, if applicable
 ;
 ; Output: ERROR message or null
 ;
 N ERROR,I,X
 S ERROR=""
 F I=2,3,5:1:9 D  I ERROR]"" G ZIRQ
 . S X=$P(STRING,HLFS,I)
 . I X]"",(X'=0),(X'=1) S ERROR=$P($T(ZIRFLD+I),";;",2)_" contains unacceptable value" Q
 I $$NUM^IVMCME2($P(STRING,HLFS,4),5,2) S ERROR="Invalid number for Amount Contributed to Spouse" G ZIRQ
 S X=$P(STRING,HLFS,10) I X]""&((X>30)!(X<0)!(+X'=X)) S ERROR="Invalid number in Number of Dependent Children field" G ZIRQ
 I X]"",(X'=DEP-SPOUSE) S ERROR="Number of Dependent Children does not match dependents transmitted" G ZIRQ
 I '$G(DEPIEN) D  I ERROR]"" G ZIRQ ; if veteran ZIR segment
 . I $P(STRING,HLFS,2)']"" S ERROR="Must have Married Last Calendar Year for veteran" Q
 . I SPOUSE,'$P(STRING,HLFS,2) S ERROR="Spouse transmitted, but Married Last Calendar Year is NO" Q
 . I 'SPOUSE,$P(STRING,HLFS,2) S ERROR="No spouse transmitted, but Married Last Calendar Year is YES" Q
 . I '$P(STRING,HLFS,2),($P(STRING,HLFS,3)]"") S ERROR="Can't have Lived with Patient if not Married" Q
 . I $P(STRING,HLFS,2),($P(STRING,HLFS,3)']"") S ERROR="Must have Living with Patient if Married" Q
 . I $P(STRING,HLFS,3),($P(STRING,HLFS,4)]"") S ERROR="Should not have Amount contributed to spouse if living w/patient" Q
 . I $P(STRING,HLFS,3)=0,($P(STRING,HLFS,4)']"") S ERROR="Need amount contributed to spouse if not living w/patient" Q
 . F I=6:1:9 I $P(STRING,HLFS,I)]"" S ERROR=$P($T(ZIRFLD+I),";;",2)_" should not be filled in for veteran" Q
 . I '$P(STRING,HLFS,3),SPOUSE,($P(STRING,HLFS,4)<600) F I=3:1:20 I $P(ARRAY(SPOUSE,"ZIC"),HLFS,I) S ERROR="No income data allowed if spouse didn't live w/vet & amt contributed <$600" Q
 I $G(DEPIEN)=SPOUSE D  I ERROR]"" G ZIRQ ; if spouse ZIR segment
 . F I=2:1:10 I $P(STRING,HLFS,I)]"" S ERROR=$P($T(ZIRFLD+I),";;",2)_" should not be filled in for spouse ZIR" Q
 I $G(DEPIEN),(DEPIEN'=SPOUSE) D  I ERROR]"" G ZIRQ ; if child ZIR segment
 . I $P(STRING,HLFS,3)']"" S ERROR="Dependents must have Lived With Patient field" Q
 . I '$P(STRING,HLFS,8),($P(STRING,HLFS,9)]"") S ERROR="Shouldn't have Income Available answered if Child had no income" Q
 . I $P(STRING,HLFS,3),($P(STRING,HLFS,7)]"") S ERROR="Shouldn't have Contributed to Support if living w/patient" Q
 . I '$P(STRING,HLFS,8) F I=3:1:20 I $P(ARRAY(DEPIEN,"ZIC"),HLFS,I) S ERROR="Shouldn't have income data if Child Had Income is NO" Q
ZIRQ Q ERROR
 ;
 ;
ZIRFLD ; ZIR field names
 ;;
 ;;MARRIED LAST CALENDAR YEAR
 ;;LIVED WITH PATIENT
 ;;AMOUNT CONTRIBUTED TO SPOUSE
 ;;DEPENDENT CHILDREN
 ;;INCAPABLE OF SELF SUPPORT
 ;;CONTRIBUTED TO SUPPORT
 ;;CHILD HAD INCOME
 ;;INCOME AVAILABLE TO YOU
 ;;NUMBER OF DEPENDENT CHILDREN
