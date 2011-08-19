PRSDAH ;HISC/DAD-PAID AD HOC REPORTS DRIVER ;04/18/95  10:58
 ;;4.0;PAID;;Sep 21, 1995
 S X="QAQAHOC0" X ^%ZOSF("TEST")
 I '$T W !!,*7,"This option requires the installation of the QM Integration Module." G EXIT
 S DIR(0)="SO^1:Basic Employee Fields;2:Title 38 Employee Fields;3:Physician & Dentist Fields;4:Followup Code Fields"
 S DIR("A")="Select Ad Hoc Report Category" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!("^"[X) Q
 I Y=1 D ^PRSDAH1 G EXIT
 I Y=2 D ^PRSDAH2 G EXIT
 I Y=3 D ^PRSDAH3 G EXIT
 I Y=4 D ^PRSDAH4 G EXIT
EXIT D KILL^XUSCLEAN Q
