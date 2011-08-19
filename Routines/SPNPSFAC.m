SPNPSFAC ;SD/CM- RETURNS SITES WHERE PT HAS BEEN TREATED ;10-5-99
 ;;2.0;Spinal Cord Dysfunction;**11**;01/02/1997
START ;
 S U="^"
 W !!!,"This option shows the facilities (other VA sites) at which"
 W !,"a patient has been treated.",!!
 I '$D(^DGCN(391.91,"B")) W !!,*7,"No records on file!  Consult IRM regarding installation of CIRN.",!! Q
PICK S DIC=154,DIC(0)="AEMQZ" D ^DIC G:Y<0 EXIT
 S SPNDA=$P(Y,U)
 I '$D(^DGCN(391.91,"B",SPNDA)) W !!,"Pt has not been treated at any other VA site.",! G PICK
 W !!,"Pt Has Been Treated at",?36,"Date Last Treated",!
 S SPNIEN=0 F  S SPNIEN=$O(^DGCN(391.91,"B",SPNDA,SPNIEN)) Q:'+SPNIEN  W !,$P(^DIC(4,$P(^DGCN(391.91,SPNIEN,0),U,2),0),U,1),?36,$$FMTE^XLFDT($P($G(^DGCN(391.91,SPNIEN,0)),U,3),"5DZ")
 W !! G PICK
 G EXIT
EXIT ;
 K SPNDA,SPNIEN,DIC
 Q
