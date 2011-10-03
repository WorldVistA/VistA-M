RMPORLP ;(NG)/DG/CAP /HINES-CIOFO/HNC- HOME OXY PTS ;7/24/98
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
 ;
SITE ;Set up site variables.
 D HOSITE^RMPOUTL0 I '$D(RMPOXITE) Q
 ;
LI ;List the sought patient. ;DW
 S DIC="^RMPR(665,",BY="[RMPO-RPT-HOPATIENTLIST]",L=0,FR=""
 S PAGE=0
 S DIS(0)="S Z=$G(^RMPR(665,D0,""RMPOA"")) I ($P(Z,U,7)=RMPOXITE),$P(Z,U,3)="""""
 ;S DIS(0)="I $P($G(^RMPR(665,D0,""RMPOA"")),U,7)=RMPOXITE",PAGE=0
 S $P(SPACE," ",80)="",$P(DASH,"-",79)="",(COUNT,RMEND,RMPORPT)=0
 D NOW^%DTC S Y=% X ^DD("DD")
 S RPTDT=$P(Y,"@",1)_"  "_$P($P(Y,"@",2),":",1,2)
 S DHD="W ?0 D RPTHDR^RMPORLP"
 S DIOEND="I $G(Y)'[U S COUNT=$E(""      "",1,(6-$L(COUNT)))_COUNT W !!,?50,""TOTAL PATIENTS: "",COUNT S RMEND=1 S:IOST[""P-"" RMPORPT=1"
 ;S DIOEND="I $G(Y)'[U D DIOEND S RMEND=1 S:IOST[""P-"" RMPORPT=1"
 S FLDS=".01;C1;L22;""PATIENT"",D SSN^RMPORLP W X;C25;L4;""SSN"",D GET^RMPORLP W X;C30;L30;""PRIMARY ITEM"""
 S FLDS(2)="D SDT^RMPORLP W X;C61;L8;""START"",D EDT^RMPORLP W X;C70;""EXPIRE"""
 D EN1^DIP
 I RMPORPT=0,$G(RMEND) K DIR S DIR(0)="E" D ^DIR
EXIT ;
 K ^TMP($J)
 N RMPRSITE,RMPR D KILL^XUSCLEAN
 Q
DIOEND ;
 S COUNT=$E("      ",1,(6-$L(COUNT)))_COUNT
 W !!,?50,"Total Patients: ",COUNT
 Q
CNT ;COUNT NAMES
 I X'="" S COUNT=COUNT+1
 Q
GET ;Get the primary item.  ;DW
 S X="" N RR,RA S (RR,RA)=0
 F  S RA=$O(^RMPR(665,D0,"RMPOC",RA)) Q:RA=""  I $P($G(^RMPR(665,D0,"RMPOC",RA,0)),U,11)="Y" D  Q
  . ; PROSTHETICS PATIENT FILE
  . S RR=$P(^RMPR(665,D0,"RMPOC",RA,0),U)
  . ;PROS ITEM FILE
  . S RR=$P(^RMPR(661,RR,0),U)
  . ; ITEM MASTER FILE
  . S RR=$P(^PRC(441,RR,0),"^",2)
  . S X=$E(RR,1,30)
 Q
 ;
SSN ;GET SSN
 S X=""
 K VA,VADM S DFN=D0 D ^VADPT
 S X=$P(VA("PID"),"-",3)
 D CNT
 Q
SDT ;GET START DATE  (USE INITIAL OXYGEN RX DATE)
 S X="" N RA
 S RA=$P($G(^RMPR(665,D0,"RMPOA")),U,2)
 I RA S X=$E(RA,4,5)_"/"_$E(RA,6,7)_"/"_$E(RA,2,3)
 Q
EDT ;Expiration Date of current Rx.
 N J,D,Y,RA S (J,Y,X,D,RA)=""
 F  S D=$O(^RMPR(665,D0,"RMPOB","B",D)) Q:D=""  D
 . S J="",J=$O(^RMPR(665,D0,"RMPOB","B",D,J)) Q:J=""  S:(J>RA) RA=J
 ;I J="" Q
 I RA="" Q
 S Y=$P($G(^RMPR(665,D0,"RMPOB",RA,0)),U,3)
 I Y S X=X_$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_($E(Y,1,3)+1700)
 Q
EDTX ;Rx Expiration Date.
 ;Get the expiration dates for all active Rx.
 N J,D,EDT,C,TD S (J,D,EDT,C,X)=""
 ; Get today's date.
 D NOW^%DTC S TD=X,X=""
 ; Get the active Rx.
 F  S D=$O(^RMPR(665,D0,"RMPOB","B",D)) Q:D=""  S C=C+1 D
 .F  S J=$O(^RMPR(665,D0,"RMPOB","B",D,J)) Q:J=""  D
 .. S EDT=$P($G(^RMPR(665,D0,"RMPOB",J,0)),U,3)
 .. I EDT S X=X_$E(EDT,4,5)_"/"_$E(EDT,6,7)_"/"_($E(EDT,1,3)+1700)_" "
 ; Define the other dates.
 I C="" S X="N/A" Q
 Q
RPTHDR ;Report header
 N RA S RA=RMPO("NAME"),PAGE=PAGE+1
 W RPTDT,?(40-($L(RA)/2)),RA,?68,"Page: "_PAGE
 W !?22,"Alphabetical List Home Oxygen Patients",!?68,"Date Current",!?68,"Prescription"
 W !,"Patient",?25,"SSN",?29,"Primary Item",?61,"Active",?70,"Expires"
 W !,"=======================",?24,"====",?29,"==============================",?60,"======== ==========",!
 Q
