IBCNBUH ;ALB/ARH-Ins Buffer: Help Text ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
HELP D HELP1,HELP3
 Q
WAIT N DIR,DIRUT,X,Y W !! S DIR(0)="E" D ^DIR W !! Q
 ;
HELP1 ;
 W !!,"The left side of the display contains data from a buffer file entry."
 W !,?3,"BOLD:  buffer data that is printed in bold will be added to the existing ",!,?10,"insurance entry if the MERGE option is used."
 W !!,"The right side of the display contains data from an existing insurance entry."
 W !,?3,"BOLD:  existing insurance data that is printed in bold will be replaced with ",!,?10,"the corresponding buffer entry data if the OVERWRITE option is used."
 Q
 ;
HELP2 W !!,"When a buffer entry is determined to be a match with an existing insurance ",!,"entry, these are the options that may be used to move the data from the buffer ",!,"entry to the insurance entry:"
 W !!,"MERGE:",?11,"Data from the buffer entry will be saved to the insurance entry ",!,?11,"ONLY if the corresponding data field in the insurance entry is blank."
 W !,?11,"Therefore only blank fields in the insurance entry will be filled, ",!,?11,"any existing data in the insurance entry will remain unchanged."
 W !!,"OVERWRITE:",?11,"ALL non-blank data in the buffer entry will be saved to the insurance"
 W !,?11,"entry.  If a buffer entry field has a value it will be saved to the ",!,?11,"corresponding insurance entry field.  Therefore blank insurance ",!,?11,"fields will be filled and existing insurance data replaced."
 W !!,"REPLACE:",?11,"ALL fields in the buffer entry will be saved to the insurance entry, "
 W !,?11,"including blank fields.  Therefore all data in the insurance entry ",!,?11,"will be deleted then completely replaced by the buffer entry."
 W !!,"NO CHANGE: This option may be used to identify the Insurance entry that",!,?11,"corresponds to a buffer entry without actually changing any of",!,?11,"the Insurance Information.  The Buffer data is ignored."
 D WAIT^IBCNBAA
 W !!,"INDIVIDUALLY ACCEPT (SKIP BLANKS): This option may be used to accept only",!,?11,"non-blank specific fields from the buffer entry into the Insurance",!,?11,"entry.  Only those values accepted by the user will replace the"
 W !,?11,"corresponding fields in the Insurance entry."
 Q
 ;
HELP3 W !!,"Options for moving Buffer data to Insurance files:"
 W !!,"MERGE:     Save buffer data only if Insurance field is blank."
 W !!,"OVERWRITE: Save all non-blank fields in Buffer to Insurance fields."
 W !!,"REPLACE:   All data deleted from Insurance fields and replaced with Buffer data."
 W !!,"NO CHANGE: The buffer data is ignored, the Insurance entry will not be changed."
 W !!,"INDIVIDUALLY ACCEPT (SKIP BLANKS): Save non-blank user-confirmed Buffer fields."
 Q
