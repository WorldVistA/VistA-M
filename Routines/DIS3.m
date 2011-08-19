DIS3 ;SFISC/SEARCH - PROGRAMMER ENTRY POINT ;12/16/93  13:16
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;
 N DIQUIET,DIFM S L=$G(L),DIFM=+L D CLEAN^DIEFU,INIT^DIP
 S:$G(DIC) DIC=$G(^DIC(DIC,0,"GL")) G QER1:$G(DIC)="" N DK S DK=+$P($G(@(DIC_"0)")),U,2) G QER1:'DK
 N DISV,Y D  S DISV=+Y I Y<0 S DIC="DISTEMP" G QER
 .N DIC,X,DIS S Y=-1,DIS=$G(DISTEMP) Q:DIS=""
 .S X=$S($E(DIS)="[":$P($E(DIS,2,99),"]"),1:DIS),DIC="^DIBT(",DIC(0)="Q",DIC("S")="I '$P(^(0),U,8),$P(^(0),U,4)=DK,$P(^(0),U,5)=DUZ!'$P(^(0),U,5),$D(^(""DIS""))"
 .D ^DIC Q
 N DISTXT S %X="^DIBT(DISV,""DIS"",",%Y="DIS(" D %XY^%RCR
 S %X="^DIBT(DISV,""O"",",%Y="DISTXT(" D %XY^%RCR
 K ^DIBT(DISV,1)
 D EN1^DIP G EXIT
 ;
QER1 S DIC="DIC"
QER D BLD^DIALOG(201,DIC) D:'$G(DIQUIET) MSG^DIALOG()
 D Q^DIP
EXIT K DIC,DISTEMP Q
 ;DIALOG #201  'The input variable...is missing or invalid.'
