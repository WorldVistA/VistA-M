RMPORPT ;(NG)/DG/CAP /HINES CIOFO/HNC - Home Oxygen Primary Item Report ;7/24/98
 ;;3.0;PROSTHETICS;**29,46**;Feb 09, 1996
SITE ;Set up site variables.
 D HOSITE^RMPOUTL0 I '$D(RMPOXITE) Q
 ;
LI ;List the sought patient.
 N PBREAK,NBREAK S (PBREAK,NBREAK)=""
 S DIC="^RMPR(665,"
 S BY(0)="^TMP($J,",L(0)=3
 S DIS(0)="I $P($G(^RMPR(665,D0,""RMPOA"")),U,7)=RMPOXITE,$P($G(^RMPR(665,D0,""RMPOA"")),U,2)'="""",$P($G(^RMPR(665,D0,""RMPOA"")),U,3)="""""
 S L=0,FR="",(PAGE,RMEND,RMPORPT)=0
 S $P(SPACE," ",80)="",COUNT=0
 D NOW^%DTC
 S Y=% X ^DD("DD") S RPTDT=$P(Y,"@",1)_"  "_$P($P(Y,"@",2),":",1,2)
 S DHD="W ?0 D RPTHDR^RMPORPT"
 S DIOEND="I $G(Y)'[U S COUNT=$E(""      "",1,(6-$L(COUNT)))_COUNT W !!,?50,""Total Patients: "",COUNT S RMEND=1 S:IOST[""P-"" RMPORPT=1"
 ;S DIOEND="S:$G(Y)[U RMEND=1 I '$G(RMEND) S COUNT=$E(""      "",1,(6-$L(COUNT)))_COUNT W !!,?50,""Total Patients: "",COUNT"
 S FLDS="D PBREAK^RMPORPT,.01;C1;L18;""PATIENT"",D SSN^RMPORPT W X;C20;R4;""SSN"",D IT^RMPORPT W X;C27;L30;"""""
 S FLDS(1)="D QTY^RMPORPT W X;C60;L2;""QTY"",D UCOST^RMPORPT W X;C63;""UNIT COST"",D TCOST^RMPORPT W X;C72;""TOTAL COST"""
 D SORT
 D EN1^DIP
 I RMPORPT=0,$G(RMEND) K DIR S DIR(0)="E" D ^DIR
EXIT ;
 ;K SPACE,RB,COUNT,PAGE,RMPOF,RPTDT,^TMP($J,"RMPORPT")
 ;K FRMDT,TODT,Y,VA,VADM,DFN,RCOST,RNAM,XIOSL,UCOST
 K ^TMP($J) N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
CNT ;COUNT NAMES
 I X'="" S COUNT=COUNT+1
 Q
PBREAK ;Print the break of primary items.
 D IT^RMPORPT
 I PBREAK'=NBREAK W !,"Primary Item: ",PBREAK,! S NBREAK=PBREAK
 Q
 ;
SSN ;GET SSN
 S X=""
 K VA,VADM S DFN=D0 D ^VADPT
 S RNAM=$E(VADM(1),1,22)_"^"_$P(VA("PID"),"-",3)
 S X=$P(VA("PID"),"-",3)
 D CNT
 Q
IT ;Get the primary Item.
 S (X,UCOST,QTY)="" N RR,RA S (RR,RA)=0
 F  S RA=$O(^RMPR(665,D0,"RMPOC",RA)) Q:RA=""  I $P($G(^RMPR(665,D0,"RMPOC",RA,0)),U,11)="Y" D  Q
 . ; PROSTHETICS PATIENT FILE
 . S RR=$P(^RMPR(665,D0,"RMPOC",RA,0),U)
 . S UCOST=$P(^RMPR(665,D0,"RMPOC",RA,0),U,4)
 . S QTY=$P(^RMPR(665,D0,"RMPOC",RA,0),U,3)
 . ;PROS ITEM FILE
 . S RR=$P(^RMPR(661,RR,0),U)
 . ; ITEM MASTER FILE
 . S RR=$P(^PRC(441,RR,0),"^",2)
 . S X=$E(RR,1,30)
 . S PBREAK=X
 Q
 ;
QTY ;Get the quntity of the primary item.
 S X=""
 S X=QTY
 Q
 ;
UCOST ;Get the unit cost of the primary item.
 S X=""
 S X=$J(UCOST,7,2)
 Q
 ;
TCOST ;Calculate the total cost of the primary item.
 S X=""
 S X=QTY*UCOST,X=$J(X,8,2)
 Q
 ;
ZPAGE(RY)  ;Print page.
 I ($Y+RY)<IOSL Q
 S RKO="ZL DIO2 X ^TMP($J,1) ZL RMPORPT" X RKO K RKO
 Q
 ;
RPTHDR ;Report header.
 N RA S RA=RMPO("NAME"),PAGE=PAGE+1
 W RPTDT,?(40-($L(RA)/2)),RA,?72,"Page: "_PAGE
 W !?23,"Primary Item Report",!
 W !?64,"Unit",?73,"Total"
 W !,"Patient",?20,"SSN",?26,"Primary Item",?58,"Qty"
 W ?64,"Cost",?74,"Cost"
 W !,"=================",?19,"====",?26,"=============================="
 W ?58,"===",?64,"======",?73,"======"
 W !
 Q
 ;
SORT ;Sort patient by primary item and patient name.
 N D0,X,Y,UCOST,QTY,PBREAK
 S (X,Y,UCOST,QTY,PBREAK)=""
 S D2=0
ST F  S D2=$O(^RMPR(665,"AHO",D2)) Q:D2=""  D
 .S D0="" F  S D0=$O(^RMPR(665,"AHO",D2,D0)) Q:D0=""  D
 ..S DFN=$P($G(^RMPR(665,D0,0)),U,1)
 ..K VADM D ^VADPT S Y=VADM(1)
 ..D IT S:X'="" ^TMP($J,X,Y,D0)=""
 Q
 ;
