QANPST2 ;B'ham ISC/PTD-Post-Init Routine to Add 'Extended Care' to the National Service File ;7/15/92
 ;;2.0;Incident Reporting;;08/07/1992
 I '$O(^ECC(730,0)) W !,"National Service File - #730 does not exist on your system.",!,"Post-Init routine unable to add new entry!" G EXIT
 I '$D(^ECC(730,47,0)) W !,"'EXTENDED CARE' will now be added to file 730 - National Service File.",!,"..."
 I $D(^ECC(730,47,0)),$P(^(0),"^")="EXTENDED CARE" G EXIT ;Post-Init has previously run and addition has previously been made
 I $D(^ECC(730,47,0)),$P(^(0),"^")'="EXTENDED CARE" D WARN G EXIT ;Local entry incorrectly added to file
 L +^ECC(730):5 I '$T W !,*7,"National Service file CANNOT be accessed, ",!,"try again later! " G EXIT
 S ^ECC(730,47,0)="EXTENDED CARE"_"^"_"181B1"_"^",^ECC(730,"B","EXTENDED CARE",47)=""
 S $P(^ECC(730,0),"^",3)=47,$P(^ECC(730,0),"^",4)=$P(^ECC(730,0),"^",4)+1
 L -^ECC(730)
 W !,"National Service File updated!",!,"'EXTENDED CARE' entry has been added.",!!
EXIT ;Quit
 Q
WARN ;Warning message
 W !!,*7,"It appears that local additions have been made to the National Service File.",!,"Local additions are ONLY allowed through the Interim Management Support",!,"software, beginning with DA #1000."
 W "  Since local modifications have been made,",!,"it is the site's responsibility to delete illegal entries and re-run the",!,"post-init routine.",!
 Q
