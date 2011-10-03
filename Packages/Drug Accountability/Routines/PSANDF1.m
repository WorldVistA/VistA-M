PSANDF1 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**58**; 10/24/97
 ;This routine provides the extended help for calls in PSANDF.
 ;
NDC ;Extended help for entering NDC ;*58 11 characters
 W !?5,"The NDC must be 11-digits. If the NDC does not contain",!?5,"11 numbers, zero fill the section of the NDC that is missing."
 W !!?5,"The NDC contains three sections separated by dashes.",!?5,"It contains 5 digits, a dash, 4 digits, a dash, then 2 digits."
 W !!?5,"For Example: If the NDC is 12345-123-1, enter 12345012301.",!?5,"             If the NDC is 12345-123-12, enter 12345012312."
 Q
NDCUPC ;Extended help for selecting either NDC or UPC
 W !?5,"Select NDC to enter a National Drug Code prompt.",!?5,"Select UPC to enter a Universal Product Code prompt."
 Q
NDFDRG ;Extended help for NDF "Is XXX the drug you received?" question.
 W !?5,"Enter YES to assign the drug to the line item.",!!?5,"If it is not the drug you received, enter NO. You",!?5,"will then be able to select the correct drug from the DRUG file."
 Q
REA ;Extended help for 'description or reason why the item is not in the DRUG file'
 W !?5,"You must enter a description or reason why the item will never be",!?5,"found in the DRUG file. Enter 1-30 characters. This description or"
 W !?5,"reason will be printed on the invoice where the drug name is usually",!?5,"printed. By entering a description or reason, you will be allowed to"
 W !?5,$S($D(PSABEFOR):"verify",1:"process")_" the item."
 Q
SELNDF ;Extended help for selecting a NDF drug
 W !?5,"Select the drug you received for the line item.",!?5,"If you want to choose the drug from the DRUG file, enter ""^""."
 Q
SUP ;Extended help for 'Is this a supply item'
 W !?5,"Enter YES if the item is a supply item or if it will never be entered",!?5,"into the DRUG file. Enter NO if the item is or will be in the DRUG file."
 Q
UPC ;Extended help for entering UPC
 W !?5,"Enter up to 30 characters in the Universal Product Code field."
 Q
