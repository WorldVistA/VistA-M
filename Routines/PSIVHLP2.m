PSIVHLP2 ;BIR/PR-CONTINUED HELP TEXT ;12 JUL 96 / 10:30 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 W ! F PSIVHLP=0:1 S PSIVHLP2=$P($T(@HELP+PSIVHLP),";",3) Q:PSIVHLP2=""  W !,PSIVHLP2
 W ! K HELP,PSIVHLP2,PSIVHLP Q
OMP ;;This option will allow costs to be changed in the statistics file.
 ;;The Average Drug Cost Per Unit field in the Additive or Solution file
 ;;must first have been edited for the new cost to appear.
 ;;A single drug or multiple drugs (separated by  , ) may be selected.
 ;;After drugs have been selected, the editing of the statistics file
 ;;runs as a background job.
 ;;
ACT ;;This active order report will list all active orders containing
 ;;the specified drug. You may pick a single drug or you may select
 ;;all drugs by entering ^ALL.
 ;;
ZW ;;This active order report will list all active orders within the
 ;;ward that you specify. You may select a specific ward. You may
 ;;also select Outpatient orders by entering ^OUTPATIENT or you may
 ;;select all wards by entering ^ALL.
 ;;
LABLOG ;;If you wish to view the label log as part of the activity log,
 ;;please answer yes. The label log will show date and time labels
 ;;were printed, who printed them, where the labels came from, and
 ;;how many were printed. This log will also show labels recycled,
 ;;destroyed, and cancelled.
 ;;
DCR ;;You may capture drug costs several different ways. Select ^ALL
 ;;and you will get a report of all IV drugs. Select a single drug
 ;;name and you will get a report for just that drug. Select ^NON
 ;;and you will get a report of just non-formulary drugs. Select
 ;;^CAT and you will get a report only for the drugs that you have
 ;;defined in your category file for the particular category you
 ;;select. This feature is a report generator that allows you to
 ;;define your own cost reports.  Select ^VADC and you will get a report
 ;;just for the VA drug class code you select. If you are running the
 ;;drug cost report, you may also select ^HIGH to get a high/low cost
 ;;report. You define the upper and lower bounds. You may also select
 ;;^TYPE to get a report by IV type. This feature will allow you
 ;;to subtract cancelled and recycled out of AMIS.  Run the drug cost
 ;;report for 1 IV room and select a type. The bag summary gives
 ;;the % of bags cancelled, recycled, and destroyed. Take this percentage
 ;;and subtract it out of the AMIS count for that IV room.
 ;;NOTE: you may not include patient data when running the drug cost
 ;;report by IV type.
 ;;
CON ;;The condensed report will 'NOT' show you cost and units by ward
 ;;and will never include patient data. If you are simply looking for
 ;;a drug cost total and do not need to know units and cost by ward,
 ;;or patient, run the condensed version of this report.
 ;;
IVR ;;You may run the Ward, Provider, or Drug cost report for one or all
 ;;IV rooms. Enter ^ALL to get a report for all IV rooms or enter
 ;;the specific IV room you wish to capture data for. This feature
 ;;allows you to keep report size low if you only need data for one
 ;;room. It also allows you to do cost and summary comparisons
 ;;between IV rooms. It also allows you to subtract out recycled
 ;;and cancelled from AMIS by running the drug cost report by Type
 ;;and 1 IV room. The bag summary may be used as described in
 ;;the drug prompt help text.
 ;;
REPRINT ;;Enter a date, without time, that corresponds to the date which
 ;;labels are to be reprinted for. Example: If you ran scheduled
 ;;labels for today and you want to reprint labels from that set,
 ;;enter a "T" for "TODAY" or <RETURN>.
 ;
NVO ;;Choose 'P' to work on all nonverified orders for a single patient,
 ;;'I' to work on all nonverified orders for a specific IV room,
 ;;or 'W' to work on all nonverified orders for a specific ward.
 ;;
INCOMP ;;Enter 'D' delete the order from the system, or 'B' to take
 ;;no action on this order.
