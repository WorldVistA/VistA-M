IBARXEC0 ;ALB/AAS - RX COPAY EXEMPTION CONVERSION HELP ; 07-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
RESTART ; -- help for restarting the conversion
 S DIR(0)="Y",DIR("A")="Show help on Restarting",DIR("B")="NO"
 D ^DIR K DIR
 I $D(DIRUT) S IBQUIT=1 Q
 Q:Y<1
 ;
 W !!
 F I=1:1 S LINE=$P($T(TEXT1+I),";",3) Q:LINE=""!(IBQUIT)  W !,LINE I ($Y+5)>IOSL D PAUSE^IBOUTL Q:IBQUIT  W @IOF
 W !! Q
 ;
 ;
 Q
 ;
HELP S DIR(0)="Y",DIR("A")="Do you want to see the help",DIR("B")="NO"
 D ^DIR K DIR
 I $D(DIRUT) S IBQUIT=1 Q
 Q:Y<1
 ;
 W !!
 F I=1:1 S LINE=$P($T(TEXT+I),";",3) Q:LINE=""!(IBQUIT)  W !,LINE I ($Y+5)>IOSL D PAUSE^IBOUTL Q:IBQUIT  W @IOF
 W !! Q
 ;
TEXT ;;  ;
 ;;This routine is the Medication Copayment Exemption
 ;;Conversion.  It should be started immediately after bringing
 ;;your system up after the installation of the Medication
 ;;Copayment Exemption Patch.  It will not run unless all parts
 ;;of the installation have been completed.
 ;;  ; 
 ;;Running of this conversion will set up the correct exemption
 ;;status for all patients who have received a pharmacy copay
 ;;charge since Oct. 30, 1992.  For all patients determined to
 ;;be exempt it will cancel the charges in Integrated Billing
 ;;and then adjust the patient account to remove the copay
 ;;charges plus any administrative and interest charges that
 ;;may have accumulated on the canceled charges.
 ;;  ;
 ;;In order for this conversion to work correctly you must have
 ;;AR version 3.7 installed correctly to do refunds.  This
 ;;includes setting up an entry in the SERVICE/SECTION file
 ;;with the name of 'FISCAL' and a mail symbol of '04'.  One
 ;;entry in file 411 must be identified as the primary
 ;;station. A Common Numbering series for refunds for the
 ;;Primary Station, for 'FISCAL' service must be set up.
 ;;Make sure that there are sufficient bill numbers available,
 ;;you may generate 1000 to 5000 refunds during this conversion
 ;;depending on the size of your facility.
 ;;  ;
 ;;This conversion may run for a significant period of time.
 ;;It can be run with the users on a live system but should
 ;;not be run at peak business hours.  It can be
 ;;restarted at any time.  It will pick up after the patient it
 ;;last processed.  If you do not queue the conversion,
 ;;pressing '^' return will pause the conversion after it finishes
 ;;the current patient and display the conversion's current
 ;;progress.
 ;;  ;
 ;;After the conversion has completed, there will be a mail
 ;;message sent to the pharmacy copay mail group, the
 ;;user who started the conversion, and the Albany ISC telling
 ;;them the final statistics on the conversion.
 ;;  ;
 ;;There are two reports that will need to be printed after the
 ;;conversion has completed.  One in Accounts Receivable and one
 ;;in Integrated Billing.  You should reconcile these reports.
 ;;For each patient listed on either report there should be a
 ;;matching patient and equal dollar amount shown.  The only 
 ;;exception will be if interest and/or admin charges have been
 ;;removed in AR they will not show on the IB report.
 ;;
 ;;
TEXT1 ;;
 ;;This is the current status of the Medication Copayment Exemption
 ;;Conversion.  It may be restarted at any time.  If a second
 ;;conversion is started the running conversion will stop at the
 ;;conclusion of a patient.  This may affect the total counts
 ;;kept for quick reports by losing the count of the patient 
 ;;being processed.
 ;;  ;
 ;;If you are unsure stop now and do a system status.  The conversion
 ;;routines are all named IBARXEC*.  If your system is live, you may
 ;;see an intermittent conversion on the fly of a patient who has
 ;;not been converted.
 ;;
