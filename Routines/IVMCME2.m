IVMCME2 ;ALB/SEK,BRM - CHECK ANNUAL INCOME DATA ; 12/18/01 2:19pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,49**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is called from IVMCME.
 ;
 ;
ZIC(STRING,DEPIEN) ; check validity of ZIC segment
 ;
 ; Input:  STRING as ZIC segment
 ;         DEPIEN as the IEN of the dependent in the array, if applicable
 ;
 ; Output: ERROR message or null
 ;
 N ERROR,FLAG,I,X,Y
 S ERROR="",X=$P(STRING,HLFS,2),FLAG=0
 I $E(X,1,4)<1992!($E(X,5,8)'="0000") S ERROR="Invalid Income Year in ZIC" G ZICQ
 F I=3:1:20 I $$NUM($P(STRING,HLFS,I),7,2) S ERROR=$P($T(ZICFLD+I),";;",2)_" field content/length error" Q
 I ERROR]"" G ZICQ
 I $G(DEPIEN) D  I ERROR]"" G ZICQ
 . F I=13,14 I $P(STRING,HLFS,I)]"" S ERROR="Dependents can't have medical or funeral expenses" Q
 . I DEPIEN=SPOUSE,($P(STRING,HLFS,15)]"") S ERROR="No educational expenses for spouse" Q
 . I DEPIEN'=SPOUSE D  Q:ERROR]""
 . . I $P(STRING,HLFS,15)&('$P(ARRAY(DEPIEN,"ZIR"),U,9)) S ERROR="Dependent Educational Exp. error-income not avail. to vet" Q
 . . S X=$E($P(STRING,HLFS,2),1,4) D ^%DT S X=Y
 . . I $P(STRING,HLFS,15)]"" S X=$P(^DG(43,1,"MT",X,0),U,17) I X'<$P(STRING,HLFS,9) S ERROR="Income does not exceed child exclusion amount-educational expense not allowed" Q
 . . F I=16:1:20 I $P(STRING,HLFS,I)]"" S ERROR="No net worth figures allowed for dependent children"
 I $P(STRING,HLFS,20)>$P(STRING,HLFS,19) S ERROR="Debts can't be greater than Other Property or Assets" G ZICQ
 I '$G(DEPIEN) D  I ERROR]"" G ZICQ
 . I IVMTYPE'=1 Q
 . I $P(ARRAY("ZMT"),HLFS,3)="C" Q
 . S FLAG=0 F I=16:1:20 I $P(STRING,HLFS,I)]"" S FLAG=1 Q
 . I 'FLAG,SPOUSE F I=16:1:20 I $P(ARRAY(SPOUSE,"ZIC"),HLFS,I)]"" S FLAG=1 Q
ZICQ Q ERROR
 ;
 ;
NUM(NUMBER,DIGIT,DECIMAL) ; function to determine if valid numeric value
 ; 
 ; Input:  NUMBER as data element to evaluate
 ;         DIGIT as number of digits allowed
 ;         DECIMAL as number of decimal places
 ;
 N ERROR
 S ERROR=0
 I NUMBER'?.N.1".".2N S ERROR=1 G NUMQ
 I $L($P(NUMBER,".",1))>DIGIT S ERROR=1 G NUMQ
 I NUMBER<0 S ERROR=1
NUMQ Q ERROR
 ;
 ;
ZICFLD ; ZIC field names
 ;;
 ;;INCOME YEAR
 ;;SOCIAL SECURITY
 ;;US CIVIL SERVICE
 ;;US RAILROAD RETIREMENT
 ;;MILITARY RETIREMENT
 ;;UNEMPLOYMENT COMPENSATION
 ;;OTHER RETIREMENT
 ;;EMPLOYMENT INCOME
 ;;INTEREST, DIVIDEND, ANNUITY
 ;;WORKERS COMP/BLACK LUNG
 ;;OTHER INCOME
 ;;MEDICAL EXPENSES
 ;;FUNERAL AND BURIAL EXPENSES
 ;;EDUCATIONAL EXPENSES
 ;;CASH AMOUNT IN BANK ACCOUNTS
 ;;STOCKS AND BONDS
 ;;REAL PROPERTY
 ;;OTHER PROPERTY OR ASSETS
 ;;DEBTS
