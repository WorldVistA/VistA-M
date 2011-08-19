PSIVHLP3 ;BIR/PR-CONTINUED HELP TEXT ;12 JUL 96 / 10:30 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
EN(HELP) W ! F PSIVHLP=0:1 S PSIVHLP2=$P($T(@HELP+PSIVHLP),";",3) Q:PSIVHLP2=""  W !,PSIVHLP2
 W ! K HELP,PSIVHLP2,PSIVHLP Q
CMPLTE ;;== B  == Bypass and leave order unchanged.
 ;;== DC == Discontinue order.
 ;;== E  == Edit the order.
 ;;== F  == Finish the order. Only ask fields required to make this
 ;;         order active that cannot be calculated automatically.
 ;;
 ;;
QOPADD ;;A protocol must be created for a quick order before it may be used
 ;;to enter orders through OE/RR. The name of the protocol created will
 ;;be in the format "PSJQ"_internal entry number_" "_quick order name.
 ;;Once a protocol is created for a Pharmacy quick order, the quick
 ;;order is uneditable until it's protocol is deleted.
 ;;
 ;;
QOPDEL ;;A Pharmacy quick order may not be edited if a protocol has been
 ;;created for it. Enter "YES" to delete the quick order protocol,
 ;;or "NO" to leave it unchanged.
 ;;
 ;; **IMPORTANT** Remember to remove the quick order protocol from any
 ;;protocol menus it has been added to before deleting!
 ;;
 ;;
STPDTHLP ;;A number of doses (dose limit) may be entered and the stop date will
 ;;be automatically calculated. To specify a dose limit enter a number
 ;;corresponding to the number of doses the to be administered.
 ;;(Example: 4 for 4 doses).
