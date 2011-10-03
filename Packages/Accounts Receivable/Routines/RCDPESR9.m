RCDPESR9 ;ALB/TMK - ERA return file field captions ;09-SEP-2003
 ;;4.5;Accounts Receivable;**173,252**;Mar 20, 1995;Build 63
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Note: if the 835 flat file changes, make the corresponding changes
 ;       in this routine.
835 ;;HEADER DATA
 ;;835^^Return Message ID^S Y=X_" (ERA HEADER DATA)"
 ;;835^^X12/Proprietary flag^S Y=$S(X="X":"X12",1:X)
 ;;835^^File Date^S Y=$$FDT^RCDPESR9(X)
 ;;835^^File Time^S Y=$E(X,1,2)-$S($E(X,1,2)>12:12,1:0)_":"_$E(X,3,4)_$S($E(X,1,2)=24:" AM",$E(X,1,2)>11:" PM",1:" AM")
 ;;835^1^MRA^S Y=""
 ;;835^^Payer Name
 ;;835^^Payer ID
 ;;835^^Trace Number
 ;;835^^Date Claims Paid^S Y=$$FDT^RCDPESR9(X)
 ;;835^^Total ERA Amount^S Y=$$ZERO^RCDPESR9(X,1)
 ;;835^^Erroneous Provider Tax ID
 ;;835^^Tax ID correction Flag^S Y=$S(X="E":"CHANGED BY EPHRA",X="C":"DETERMINED FROM CLAIM DATA",X="":"NO CHANGE MADE",1:X)
 ;;835^^Sequence Control #
 ;;835^^Sequence #
 ;;835^^Last Sequence #
 ;;835^^Contact Information
 ;;835^^Payment Method Code
 ;;835^^Billing Provider NPI
 ;
01 ;;PAYER CONTACT INFORMATION
 ;;01^^ERA Contact Name
 ;;01^^ERA Contact #1
 ;;01^^ERA Contact #1 Type^S Y=$$EXTERNAL^DILFD(344.4,3.03,,X)
 ;;01^^ERA Contact #2
 ;;01^^ERA Contact #2 Type^S Y=$$EXTERNAL^DILFD(344.4,3.05,,X)
 ;;01^^ERA Contact #3
 ;;01^^ERA Contact #3 Type^S Y=$$EXTERNAL^DILFD(344.4,3.07,,X)
 ;
02 ;;PAYER ADJUSTMENT RECORD
 ;;02^^Line Type^S Y=X_" (ERA LEVEL PAYER ADJUSTMENT RECORD)"
 ;;02^^X12 Adjustment Reason Code
 ;;02^^Provider Adjustment Identifier
 ;;02^^Adjustment Amount^S Y=$$ZERO^RCDPESR9(X,1)
 ;;02^^X12 Reason Text
 ;
05 ;;CLAIM PATIENT ID
 ;;05^^Line Type^S Y=X_" (CLAIM LEVEL PATIENT ID DATA)"
 ;;05^^Bill #
 ;;05^^Patient Last Name
 ;;05^^Patient First Name
 ;;05^^Patient Middle Name
 ;;05^^Patient ID #
 ;;05^1^Record Contains Patient Name Change^S Y=""
 ;;05^1^Record Contains Patient ID Change^S Y=""
 ;;05^^Statement Start Date^S Y=$$FDT^RCDPESR9(X)
 ;;05^^Statement End Date^S Y=$$FDT^RCDPESR9(X)
 ;
10 ;;CLAIM STATUS DATA
 ;;10^^Line Type^S Y=X_" (CLAIM LEVEL CLAIM STATUS DATA)"
 ;;10^^Bill #
 ;;10^^Claim Processed^S Y=$$YN^RCDPESR9(X)
 ;;10^^Claim Denied^S Y=$$YN^RCDPESR9(X)
 ;;10^^Claim Pended^S Y=$$YN^RCDPESR9(X)
 ;;10^^Claim Reversal^S Y=$$YN^RCDPESR9(X)
 ;;10^^Claim Status Code
 ;;10^1^Crossed Over Name^S Y=""
 ;;10^1^Crossed Over ID^S Y=""
 ;;10^^Submitted Charge^S Y=$$ZERO^RCDPESR9(X,1)
 ;;10^^Amount Paid^S Y=$$ZERO^RCDPESR9(X,1)
 ;;10^^ICN
 ;;10^^DRG Code Used
 ;;10^^DRG Weight Used^S Y=$J($$ZERO^RCDPESR9(X,1)/100,4)
 ;;10^^Discharge Fraction^S Y=$$ZERO^RCDPESR9(X,1)
 ;;10^^Rendering NPI
 ;;10^^Entity Type Qualifier
 ;;10^^Last Name
 ;;10^^First Name
 ;
15 ;;CLAIM STATUS DATA
 ;;15^^Line Type^S Y=X_" (CLAIM LEVEL CLAIM STATUS DATA (CONTINUED))"
 ;;15^^Bill #
 ;;15^^Covered Amount^S Y=$$ZERO^RCDPESR9(X,1)
 ;;15^1^Discount Amount^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;15^1^Day Limit Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;15^1^Interest Amount^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;15^1^Tax Amount^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;15^1^Total Before Taxes Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;15^^Patient Responsibility Amount^S Y=$$ZERO^RCDPESR9(X,1)
 ;;15^1^Negative Reimbursement^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;
17 ;;CLAIM LEVEL PAYER CONTACT INFORMATION
 ;;17^^Line Type^S Y=X_" (CLAIM LEVEL PAYER CONTACT INFO)"
 ;;17^^Bill #
 ;;17^^Contact Name
 ;;17^^Contact #1
 ;;17^^Contact #1 Type^S Y=$$EXTERNAL^DILFD(361.1,25.03,,X)
 ;;17^^Contact #2
 ;;17^^Contact #2 Type^S Y=$$EXTERNAL^DILFD(361.1,25.05,,X)
 ;;17^^Contact #3
 ;;17^^Contact #3 Type^S Y=$$EXTERNAL^DILFD(361.1,25.07,,X)
 ;
20 ;;CLAIM LEVEL ADJUSTMENT DATA
 ;;20^^Line Type^S Y=X_" (CLAIM LEVEL CLAIM ADJUSTMENT DATA)"
 ;;20^^Bill #
 ;;20^^Adjustment Group Code
 ;;20^^Adjustment Reason Code
 ;;20^^Adjustment Amount^S Y=$$ZERO^RCDPESR9(X,1)
 ;;20^^Quantity^S Y=$$ZERO^RCDPESR9(X)
 ;;20^^Reason Code Text
 ;
30 ;;CLAIM LEVEL MEDICARE INPT ADJUDICATION DATA
 ;;30^^Line Type^S Y=X_" (CLAIM LEVEL MEDICARE INPATIENT ADJUDICATION DATA)"
 ;;30^^Bill #
 ;;30^^Covered Days/Visits^S Y=$$ZERO^RCDPESR9(X)
 ;;30^1^Lifetime Reserve Days Count^S Y=$$ZERO^RCDPESR9(X,,1)
 ;;30^1^Lifetime Psych Days Count^S Y=$$ZERO^RCDPESR9(X,,1)
 ;;30^^Claim DRG Amt^S Y=$$ZERO^RCDPESR9(X,1)
 ;;30^1^Claim Disproportionate Share Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;30^1^Claim MSP Pass thru Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;30^1^Claim PPS Capital Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;30^1^PPS-Capital FSP DRG Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;30^1^PPS-Capital HSP DRG Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;30^1^PPS-Capital DSH DRG Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;30^1^Old Capital Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;30^^Non-Covered Days^S Y=$$ZERO^RCDPESR9(X)
 ;
35 ;;CLAIM LEVEL MEDICARE ADJUDICATION DATA
 ;;35^^Line Type^S Y=X_" (CLAIM LEVEL MEDICARE ADJUDICATION DATA)"
 ;;35^^Bill #
 ;;35^1^PPS-Capital IME Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^PPS-Operating Hosp Specific DRG Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^Cost Report Day Count^S Y=$$ZERO^RCDPESR9(X)
 ;;35^1^PPS-Operating Fed Specific DRG Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^Claim PPS Capital Outlier Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^Claim Indirect Teaching Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^Non-payable Professional Component Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^PPS-Capital Exception Amt^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^Outpatient Reimbursement %^S Y=$$ZERO^RCDPESR9(X)
 ;;35^1^HCPCS Payable Amount^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^ESRD Paid Amount^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;;35^1^Non-payable Professional Component^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;
37 ;;CLAIM LEVEL MEDICARE ADJUDICATION DATA REMARKS
 ;;37^^Line Type^S Y=X_" (CLAIM LEVEL MEDICARE ADJUDICATION DATA REMARKS)"
 ;;37^^Bill #
 ;;37^^Type^S Y=$S(X="O":"MOA",X="I":"MIA",1:X)
 ;;37^^Claim Payment Remark Code
 ;;37^^Claim Payment Remark Code Message Text
 ;
40 ;;SERVICE LINE DATA
 ;;40^^Line Type^S Y=X_" (CLAIM LEVEL SERVICE LINE DATA)"
 ;;40^^Bill #
 ;;40^^Procedure
 ;;40^^Revenue Code
 ;;40^^Modifier 1
 ;;40^^Modifier 2
 ;;40^^Modifier 3
 ;;40^^Modifier 4
 ;;40^^Description
 ;;40^^Original Procedure
 ;;40^^Original Modifier 1
 ;;40^^Original Modifier 2
 ;;40^^Original Modifier 3
 ;;40^^Original Modifier 4
 ;;40^^Original Charge^S Y=$$ZERO^RCDPESR9(X,1)
 ;;40^^Original Units^S Y=$$ZERO^RCDPESR9(X,1)
 ;;40^^Amount Paid^S Y=$$ZERO^RCDPESR9(X,1)
 ;;40^^Covered Units^S Y=$$ZERO^RCDPESR9(X,1)
 ;;40^^Service From Date^S Y=$$FDT^RCDPESR9(X)
 ;;40^^Service To Date^S Y=$$FDT^RCDPESR9(X)
 ;;40^^Procedure Type
 ;;40^^Applies to Billing Line
 ;
41 ;;SERVICE LINE DATA
 ;;41^^Line Type^S Y=X_" (CLAIM LEVEL SERVICE LINE DATA (CONTINUED))"
 ;;41^^Bill #
 ;;41^^Allowed Amount^S Y=$$ZERO^RCDPESR9(X,1)
 ;;41^1^Per Diem Amount^S Y=$$ZERO^RCDPESR9(X,1,1)
 ;
42 ; SERVICE LINE DATA
 ;;42^^Line Type^S Y=X_" (CLAIM LEVEL SERVICE LINE DATA (CONTINUED))"
 ;;42^^Bill #
 ;;42^^Line Item Remark Code
 ;;42^^Line Item Remark Code Text
 ;
45 ;;SERVICE LINE ADJUSTMENT DATA
 ;;45^^Line Type^S Y=X_" (CLAIM LEVEL SERVICE LINE ADJUSTMENT DATA)"
 ;;45^^Bill #
 ;;45^^Adjustment Group Code
 ;;45^^Adjustment Reason Code
 ;;45^^Adjustment Amount^S Y=$$ZERO^RCDPESR9(X,1)
 ;;45^^Quantity^S Y=$$ZERO^RCDPESR9(X)
 ;;45^^Reason Code Text
 ;
FDT(X) ; returns MM/DD/YYYY or MM/DD/YY from YYYYMMDD or YYMMDD in X
 I $L(X)=8,X?8N S X=$E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4)
 I $L(X)=6,X?6N S X=$E(X,3,4)_"/"_$E(X,5,6)_"/"_$E(X,1,2)
 Q X
 ;
ZERO(X,D,NULL) ; Returns numeric value of X without leading 0's
 ; or null if no value wanted for 0 amount
 ; D = 1 if dollar amt
 N Z
 I X["." S Z=$P(X,"."),X=+Z_"."_$P(X,".",2)
 I X'["." D
 . I $G(D) S X=+$E(X,1,$L(X)-2)_"."_$E(X,$L(X)-1,$L(X))
 . S X=$S('$G(D):+X,1:$J(X,"",2))
 Q $S(X:X,$G(NULL):"",1:X)
 ;
YN(X) ; Returns YES for X="Y" and NO for X="N"
 S X=$S(X="Y":"YES",X="N":"NO",1:X)
 Q X
 ;
