PSJDEA ;BIR/CML3-HELP TEXT FOR DEA FIELD IN DRUG FILE ;20 JUN 94 / 5:24 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 N %,%Y,X,Y
 W !,"The special handling code is 1 to 6 characters.  If applicable, the schedule",!,"code must appear in the first position.  For example, a schedule 3 narcotic",!,"would be coded as '3A' and a schedule 2 depressant would be coded as '2L'."
 W ! F  S %=2 W !,"Would you like a list of the codes" D YN^DICN Q:%  W !!,"Answer 'YES' to view a list of the available codes.",!
 I %=1 W ! F X=1:1 S Y=$P($T(L+X),";",3,99) Q:Y=""  W !?10,Y
 W ! Q
 ;
L ; list of codes
 ;;0          MANUFACTURED IN PHARMACY
 ;;1          SCHEDULE 1 ITEM
 ;;2          SCHEDULE 2 ITEM
 ;;3          SCHEDULE 3 ITEM
 ;;4          SCHEDULE 4 ITEM
 ;;5          SCHEDULE 5 ITEM
 ;;6          LEGEND ITEM
 ;;9          OVER-THE-COUNTER
 ;;L          DEPRESSANTS AND STIMULANTS
 ;;A          NARCOTICS AND ALCOHOLICS
 ;;P          DATED DRUGS
 ;;I          INVESTIGATIONAL DRUGS
 ;;M          BULK COMPOUND ITEMS
 ;;C          CONTROLLED SUBSTANCES - NON NARCOTIC
 ;;R          RESTRICTED ITEMS
 ;;S          SUPPLY ITEMS
 ;;B          ALLOW REFILL (SCHEDULE 3, 4, 5 NARCOTICS ONLY)
 ;;W          NOT RENEWABLE
 ;;
 ;
EDIT ;
 I X["B",X<3!(X'["A") W !,"  The B designation is only valid for schedule 3, 4, and 5 narcotics!",$C(7) K X Q
 Q
