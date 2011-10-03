PSXRHLP ;BIR/WPB-Help Messages for the Remote Sites ;14 Dec 2001
 ;;2.0;CMOP;**28**;11 Apr 97
 ; Reference to ^PS(52.5, supported by DBIA #1978
MSG1 ;help message, allows the user to return to the main menu or exit
 ;the routine
 W @IOF
 W !!,"1 & 2",!,"  - Initiate CMOP Transmission will gather data for the selected date range and"
 W !,"transmit to the CMOP.  The sender receives a ""Transmission Confirmation"" message"
 W !,"via Mailman when the data transmission is completed."
 W !!,"3 & 4",!,"  - Print CMOP Labels from Suspense will gather data for the selected date range"
 W !,"and print the labels.  NO DATA will TRANSMIT to the CMOP.  Drugs or items for"
 W !,"all labels printed should be filled locally."
 W !!,"5 - Standard Print from Suspense will print all labels for Rx's NOT 'Queued to"
 W !,"Send' for the selected date range.  All usual outpatient prompts will be displayed."
 Q
MSG2 ;help message, allows the user to return to the main menu or exit
 ;the routine
 W @IOF
 W !!,"1 - Reset and Transmit to CMOP will reset entries which have 'printed but not"
 W !,"transmitted for the selected date range and automatically transmit data"
 W !,"to the CMOP.  "
 W !!,"2 - Reset and Print CMOP Labels will reset entries which have 'printed but not"
 W !,"transmitted' for the selected date range and print labels.  There will be"
 W !,"NO DATA TRANSMITTED to the CMOP.   The Rx's for the labels printed must be"
 W !,"filled locally."
 W !!,"3 - Standard Reset and Print Again will reset and print all outpatient labels not"
 W !,"'Queued to Send' and usual outpatient prompts will be displayed."
 Q
DATAERR ;list of errrors that can occur while checking the rx prior to transmit
 ;;Quantity
 ;;Prescribing Physician
 ;;Days supply
 ;;Drug id
 ;;SIG
 ;;Patient status
 ;;Fill date
 ;;Clerk
 ;;Patient Address
 ;;Original batch ^not on file.^is currently processing.^is closed.^is already on hold.
DERR ;list of errors for tranmission
 ;;State
 ;;Site
 ;;Name
 ;;Street Address
 ;;City
 ;;Zip Code
 ;;Area Code
 ;;Phone Number
 ;;Refillable Instructions
 ;;Nonrefillable Instructions
 Q
DEACT W !!,?7,"**************************************************************"
 I '$D(^PS(52.5,"AQ")) S AZ=1 G D1
 I $D(^PS(52.5,"AQ")) W !,?7,"WARNING:  There are Rx's currently suspended for CMOP."
 W !!,?7,"If you inactivate CMOP processing:"
 W !,?7,"1)  These Rx's will not transmit to the CMOP, but will remain"
 W !,?7,"    in the RX SUSPENSE file.  These Rx's cannot be accessed by"
 W !,?7,"    Outpatient Pharmacy options.  Ideally, these Rx's should"
 W !,?7,"    be transmitted or printed before inactivation takes place."
 W !,?7,"    If CMOP processing is activated, these prescriptions can"
 W !,?7,"    be transmitted."
D1 W !,?7,$S($G(AZ)'>0:"2)  ",$G(AZ)=1:"1)  ",1:"")_"Before inactivating, please have all pharmacy users sign"
 W !,?7,"    off until inactivation is complete.  CMOP Rx's input by"
 W !,?7,"    users who do not sign off the system will be suspended for"
 W !,?7,"    CMOP transmission."_$S($G(AZ)'>0:" (See #1)",1:"")
 I $G(AZ)=1 W "  These Rx's can not be accessed by",!,?7,"    Outpatient Pharmacy options.  If CMOP processing is",!,?7,"    activated these prescriptions can be transmitted."
 I $D(^PSX(550,"AT")) W !,?7,$S($G(AZ)'>0:"3)  ",$G(AZ)=1:"2)  ",1:"")_"Your current auto transmission schedule will be",!,?7,"    cancelled on inactivation."
 W !,?7,"***************************************************************",!
 K AZ
 Q
OPSUS ;EP OP SUSPENSE MESSAGE
 W !!,?7,"***************************************************************",!
 W !,?7,PSXNEW
 W !!,?7,"Prescriptions "
 W $S(PSXNEWI=1:"will be processed into",1:"are in")," CMOP suspense and"
 W !,?7,"held until either:"
 W !!,?14,"1. CMOP transmissions are activated."
 W !,?14,"2. Outpatient menues are used to pull prescriptions from"
 W !,?14,"CMOP suspense.",!
 W !,?7,"***************************************************************",!
 Q
