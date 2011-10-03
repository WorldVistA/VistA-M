PSGPLDPH ;BIR/RLW-ENTER UNITS DISPENSED (HELP) ;16 AUG 94 / 5:56 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
PRNM ;
 W !!?2,"Answer 'Y' to be shown only those orders that have PRN as a SCHEDULE TYPE,",!,"or have PRN as their SCHEDULE.  Enter 'N' to be shown all orders.  Enter '^'",!,"to exit this pick list." Q
 ;
FIMSG ;
 W !!,"  Answer 'Y' if the editing of this pick list is complete, and the data may be",!,"filed into the respective patients' records.  Answer 'N' (or '^') if you'll need",!,"to edit this pick list again."
 W "  Pick lists that are filed away may still be",!,"printed at any time, but are no longer selectable at any other option." Q
 ;
FMSG ;
 W !!,"  Enter a 'Y', an '^', or press the RETURN key if you are through with this picklist.  Enter an 'N' to go through this pick list once again." Q
 ;
