PSN125E ;BIR/DMA-environment check for data updates ; 07 Sep 2006  7:37 AM
 ;;4.0; NATIONAL DRUG FILE;**125**; 30 Oct 98;Build 4
 I $D(DUZ)#2 N DIC,X,Y S DIC=200,DIC(0)="N",X="`"_DUZ D ^DIC I Y>0
 E  W !!,"You must be a valid user." S XPDQUIT=2
 I $$PATCH^XPDUTL(XPDNM) W !!,"This patch has already been installed." S XPDQUIT=1 Q
 Q
