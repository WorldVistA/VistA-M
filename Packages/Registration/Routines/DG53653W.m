DG53653W ;TDM - Patch DG*5.3*653 Install Utility Routine ; 10/24/05 9:28am
 ;;5.3;Registration;**653**;AUG 13, 1993;Build 2
 ; Called from DG53653U
 Q
 ;
401 S @ROOT@(.01)="RATED INCOMPETENT INVALID"
 S @ROOT@(2)="RATED INCOMPETENT MUST BE EITHER YES, NO, OR UNKNOWN/NULL"
 S DGWP(1,0)="If completed, the value of Rated Incompetent must be either yes,"
 S DGWP(2,0)="no, or unknown."
 Q
 ;
402 S @ROOT@(.01)="ELIGIBLE FOR MEDICAID INVALID"
 S @ROOT@(2)="ELIGIBLE FOR MEDICAID MUST BE EITHER YES, NO, OR NULL"
 S DGWP(1,0)="If completed, the value of Eligible For Medicaid must be either"
 S DGWP(2,0)="yes or no."
 Q
 ;
403 S @ROOT@(.01)="DT MEDICAID LAST ASKED INVALID"
 S @ROOT@(2)="ELIGIBLE FOR MEDICAID IS YES AND DATE MEDICAID LAST ASKED IS MISSING"
 S DGWP(1,0)="The value of 'Eligible for Medicaid' is Yes, but the Date Medicaid"
 S DGWP(2,0)="Last Asked value is null."
 Q
 ;
404 Q  ;Same as #15?
 S @ROOT@(.01)="INELIGIBLE REASON INVALID"
 S @ROOT@(2)="INELIGIBLE DATE IS PRESENT AND THE INELIGIBLE REASON IS MISSING"
 S DGWP(1,0)="There is an Ineligible Date present, but the Ineligible Reason"
 S DGWP(2,0)="is missing."
 Q
 ;;
405 Q  ;Same as #19?
 S @ROOT@(.01)="NON VETERAN ELIG CODE INVALID"
 S @ROOT@(2)="ELIGIBILITY CODE FOR NON-VETERAN IS NOT A VALID VALUE"
 S DGWP(1,0)="The value of Eligibility Code is completed, but it does not match"
 S DGWP(2,0)="one of the non-veteran values."
 Q
 ;
406 S @ROOT@(.01)="CLAIM FOLDER NUMBER INVALID"
 S @ROOT@(2)="CLAIM FOLDER NUM MUST BE 7 TO 8 DIGITS. IF 9 DIGITS THEN MUST BE SSN"
 S DGWP(1,0)="Claim Folder Number must consist of 7 or 8, or 9 numbers if SSN."
 Q
 ;
407 S @ROOT@(.01)="ELIGIBILITY STATUS INVALID"
 S @ROOT@(2)="THE VALUE ENTERED FOR ELIGIBILITY STATUS MUST BE P, R, V OR NULL"
 S DGWP(1,0)="The value of Eligibility Status is completed, but it does not match"
 S DGWP(2,0)="one of the values."
 Q
 ;
408 ;Removed per customer 05/08/2006 - BAJ
 ;S @ROOT@(.01)="DECLINE TO GIVE INCOME INVALID"
 ;S @ROOT@(2)="MEANS TEST IS PRESENT, NO INCOME AND DECLINE TO GIVE INCOME NOT YES"
 ;S DGWP(1,0)="A Means Test is present, there is no income and the Declines to"
 ;S DGWP(2,0)="Give Income is null or no."
 Q
 ;
409 S @ROOT@(.01)="AGREE TO PAY DEDUCT INVALID"
 S @ROOT@(2)="MEANS TEST IS PRESENT AND AGREE TO PAY DEDUCTIBLE IS NULL"
 S DGWP(1,0)="A Means Test is present, the status of the test is either MT Co-Pay"
 S DGWP(2,0)="Required, GMT Co-Pay Required or Pending Adjudication and Agree to"
 S DGWP(3,0)="pay Deductible is null."
 Q
 ;
410 Q  ;Same as #404
 ;
411 S @ROOT@(.01)="ENROLLMENT APP DATE INVALID"
 S @ROOT@(2)="ENROLLMENT APPLICATION DATE MUST BE A PRECISE DATE"
 S DGWP(1,0)="Enrollment Application Date must be a precise date."
 Q
 ;
412 Q  ;Same as #24
 S @ROOT@(.01)="POS/ELIG CODE INVALID"
 S @ROOT@(2)="POS INCONSISTENT WITH PRIMARY ELIGIBILITY CODE"
 S DGWP(1,0)="POS Inconsistent With Primary Eligibility."
 Q
 ;
413 Q  ;Same as #13
 S @ROOT@(.01)="POS INVALID"
 S @ROOT@(2)="POS UNSPECIFIED"
 S DGWP(1,0)="POS Unspecified."
 Q
