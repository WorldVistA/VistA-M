IBAMTEL ;ALB/CPM - MEANS TEST BILLING ERROR LOCATIONS ; 14-NOV-91
 ;;2.0;INTEGRATED BILLING;**153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine contains the various points at which errors may
 ; be trapped while calculating Means Test charges for Hospital
 ; and Nursing Home admissions.  This routine will be utilized
 ; by both the Nightly Compilation job (IBAMTC) and the Movement
 ; Event Driver interface (IBAMTD).
 ;
TEXT ;
 ;;The error was encountered while initializing billing parameters.
 ;;The error was encountered while closing out charges for billing cycles over 365 days in length.
 ;;The error was encountered while passing charges and closing the billing cycle for patients who are no longer Means Test billable.
 ;;The error was encountered while passing charges and closing the billing cycle for patients who are on leave.
 ;;The error was encountered while passing charges and closing events as a result of an ASIH movement (to DOM).
 ;;The error was encountered while adding a billable event (New Admission).
 ;;The error was encountered while adding a new billing cycle.
 ;;The error was encountered while determining the action type for the per diem charge.
 ;;The error was encountered while passing charges and closing events as a result of an ASIH movement (to HOSP/NHCU).
 ;;The error was encountered while adding a billable event (ASIH Movement).
 ;;The error was encountered while passing a per diem charge as a result of a skipped day.
 ;;The error was encountered while passing a per diem charge as a result of a new Fiscal Year.
 ;;The error was encountered while adding a new per diem charge.
 ;;The error was encountered while determining the daily rate for the copayment.
 ;;The error was encountered while passing a copayment charge as a result of a specialty change.
 ;;The error was encountered while passing a copayment charge as a result of a skipped day.
 ;;The error was encountered while passing a copayment charge as a result of a new Fiscal Year.
 ;;The error was encountered while adding a new copayment charge.
 ;;The error was encountered while passing a copayment charge as a result of reaching the Medicare Deductible ceiling.
 ;;The error was encountered while passing outstanding per diem charges on the last day of the billing cycle.
 ;;The error was encountered while passing outstanding copayment charges on the last day of the billing cycle.
 ;;The error was encountered while passing charges 4 days from the patient's statement date.
 ;;The error was encountered while closing out billing cycles over 365 days in length.
 ;;The error was encountered while retrieving billing cycle information.
 ;;The error was encountered while passing charges for patients who are discharged.
 ;;The error was encountered while passing a per diem charge for a single-day admission.
 ;;The error was encountered while passing a copayment charge for a single-day admission.
 ;;The error was encountered while posting charges to Accounts Receivable.
 ;;The error was encountered after successfully posting charges to Accounts Receivable.
 ;;The error was encountered while cancelling a charge during Means Testing.
