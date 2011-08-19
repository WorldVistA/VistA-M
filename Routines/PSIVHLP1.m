PSIVHLP1 ;BIR/PR-HELP TEXT CONTINUED ;12 JUL 96 / 10:30 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 W ! F PSIVHLP=0:1 S PSIVHLP1=$P($T(@HELP+PSIVHLP),";",3) Q:PSIVHLP1=""  W !,PSIVHLP1
 W ! K HELP,PSIVHLP1,PSIVHLP Q
DRGINQ ;;Enter 'ADDITIVE' if you want to print information on the
 ;;IV ADDITIVE file or 'SOLUTION' to print information on the
 ;;IV SOLUTION file.
 ;;
RNTBAT ;;Enter the # that corresponds to the suspended labels
 ;;that you wish to reprint.
 ;;
RESWL ;;Answer 'Y' if you want to reset the ward list.  You should only
 ;;be using this option if you have accidently run the ward list for
 ;;the coverage times you have entered.
 ;;
OPUR ;;If you do not want to purge this IV order that you have chosen
 ;;enter an '^', 'N' or the RETURN key.  If you want to purge the
 ;;IV order that you have chosen enter a 'Y'.
 ;;
UWL ;;The # that is shown as a default will be the # that
 ;;will appear on the manufacturing list.  To update this #
 ;;type the correct # of doses that should appear on the
 ;;manufacturing list.  If an order has been Dc'd, purged or put on
 ;;'HOLD' status, it will not appear on the update ward list option.
 ;;>>> NOTE <<<
 ;;You may also DC = DC order, H = HOLD order or O = put order ON CALL.
 ;;
ONUWL ;;Type the order # for this patient that you wish to update.
 ;;This # can be found on the ward list under the patients
 ;;name.  The # in the symbol [#] is the order #.
 ;;
YNPRG ;;If you are sure you want to start the purge, answer 'Y'.
 ;;If you want to cancel the purge, enter an '^' or 'N'.
 ;;
NCILBL ;;If you want the labels that you are about to print to be
 ;;counted into the daily cost reports, answer 'Y'.  If you are
 ;;reprinting labels and don't want the labels to be counted
 ;;as daily usage, enter 'N'.
 ;;
PRTVW ;;If you want a view of the order printed to a printer before it
 ;;is purged, enter 'Y'.  If a printed view of the order is not
 ;;needed, enter 'N'.
 ;;
PRTAVW ;;If you want a view of the order's activity log printed to a printer
 ;;before it is purged, enter 'Y'.  If a printed view of the activity
 ;;log is not needed, enter 'N'.
 ;;
NOL ;;Enter the # of labels that you wish to print.  You may only
 ;;print 1-10 labels at a time.
 ;;
SUSRPT ;;If you want this report printed to the printer that you selected
 ;;when entering into the IV PACKAGE, enter 'Y'.  Enter 'N' to have
 ;;this report printed to this device.
 ;;
PRORPT1 ;;To have an activity log printed with each view of an order,
 ;;enter a 'Y'.  If an activity log is not needed with each view, enter
 ;;an 'N'.
 ;;
ADMYN ;;Since this patient has not been admitted into the hospital, you
 ;;will be entering IV ORDERS as 'Outpatient IVs'.  If you want to
 ;;continue with order entry, answer 'Y'.  If you do not want
 ;;to enter the orders as 'Outpatient IV' orders, answer 'N'.
 ;;
RTDS ;;If bottles for this order were returned for
 ;;recycling, enter 'R'.  If the bottles for this order that were
 ;;returned are going to be destroyed, enter 'D'.
 ;;Enter 'C' for cancelled I.E. labels printed but IV's were not made.
 ;;
PROFL ;;Enter an 'S' to see only active IV ORDERS, 'L' to see all IV ORDERS
 ;;or an 'N' to see no profile of IV ORDERS.
 ;;
LBSUSD ;;Enter the order # for which labels should be deleted.
 ;;More than one may be deleted by separating order #'s by ",".
 ;;Enter "ALL" to delete all suspended labels for the patient."
 ;;
PROVRP ;;Enter the name of the Provider (last name, first name) or
 ;;^ALL to capture data for all Providers
 ;;
DRGCST ;;Enter drug name, ^ALL (all drugs), ^NON (non-formulary drugs),
 ;;^CAT (category of drugs you have set up in the category file)
 ;;^VADC (va class codes), or ^HIGH (high/low cost- drug cost report only)
 ;;
WARD ;;Enter a specific Ward name for which data should be captured
 ;;or ^ALL to capture data for all WARDS or ^OUTPATIENT to capture
 ;;data for only the outpatient ward.
 ;;
PATQ ;;Respond "Y"  to capture cost and units dispensed
 ;;for each patient that has received drug(s) selected.
 ;;
AORS ;;To edit the unit cost of a drug, you must first indicate if the
 ;;drug is an ADDITIVE (enter "A") or a SOLUTION (enter "S").
 ;;
 ;;
