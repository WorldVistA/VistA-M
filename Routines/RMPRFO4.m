RMPRFO4 ;PHX/HPL-PRINT FL 10-90 ADP LETTER ;11/01/1994
 ;;3.0;PROSTHETICS;;Feb 09, 1996
EST ;PRINT VENDOR'S ESTIMATE SECTION OF FL 10-90
 S LINES=0,HEADING="VENDOR'S ESTIMATE" W !!,?IOM-$L(HEADING)\2,HEADING
 S HEADING="(To be completed by Vendor)" W !,?IOM-$L(HEADING)\2,HEADING
 W !,?5,$$REPEAT^XLFSTR("-",70)
 W !,?5,"|",?12,"Article or Service",?37,"|Quantity| Unit |Unit Cost|Total Cost|"
 W !,?5,$$REPEAT^XLFSTR("-",70)
 S LAPS=$Y F LP=LAPS:1:47 W !,?5,"|",?37,"|",?46,"|",?53,"|",?63,"|",?74,"|" I $Y>20&(IOST["C-") K DIR S DIR(0)="FO^ :",DIR("A")="Push return to continue" D ^DIR G:(X="^")!($D(DTOUT)) QWIT W @IOF
 W !,?5,$$REPEAT^XLFSTR("-",70)
 W !,?5,"|  Vendor:",?42,"Contract number (if applicable) |"
 W !,?5,"|  Address:",?74,"|"
 W !,?5,"|  City:",?74,"|",!,?5,"|  State:",?26,"Zip:",?74,"|"
 W !,?5,"|  Telephone:",?74,"|",!,?5,"|  Date:",?37,"Signature & Title of Company Official|"
 W !,?5,"|  Note:List Terms/Discounts if Applicable",?74,"|"
 W !,?5,$$REPEAT^XLFSTR("-",70)
 W !,?59,"FL 10-90 ADP"
 I IOST["C-" K DIR S DIR(0)="FO^ :",DIR("A")="Push return to continue" D ^DIR G:(X="^")!($D(DTOUT)) QWIT W @IOF
 D:$G(MORE)=1 MORE^RMPRFO6,EST D EXIT^RMPRFO3,^%ZISC
QWIT Q
