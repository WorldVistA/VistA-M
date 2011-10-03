ECXDRUG ;BIR/DMA-Report of Drugs Missing Class or NDC ; 6/7/05 1:42pm
 ;;3.0;DSS EXTRACTS;**8,84**;Dec 22, 1997
 W @IOF,!!,"This routine will generate a list of drugs missing either VA Class or NDC.",!,"These two elements make up the feeder key for your drug products,",!,"and should be entered.",!!,"Note - supply items may not have an NDC",!!
 S %ZIS="Q" D ^%ZIS K %ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="EN^ECXDRUG",ZTDESC="Report of drugs missing class or NDC" D ^%ZTLOAD,^%ZISC Q
 ;
EN ;entry point
 N ARRAY,DR,A,A1,B,J,DIR,DIRUT,ECQ
 S ARRAY="^TMP($J,""ECXLIST"")"
 K @ARRAY
 ;Call pharmacy drug file (#50) api dbia 4483 and create ^TMP global
 D DATA^PSS50(,"??",DT,,,"ECXLIST")
 D HEAD
 S DR="" F  S DR=$O(@ARRAY@("B",DR)) Q:DR=""!$D(ECQ)  D
 .F J=0 S J=$O(@ARRAY@("B",DR,J)) Q:'J!$D(ECQ)  D
 ..S A=@ARRAY@(J,.01)_U_^(2)_U_^(3),B=^(31)
 ..I $P(A,U,2)=""!($P(A,U,3)["S")!(B="") D  I $Y+5>IOSL D HEAD
 ...W !,?5,$P(A,U) W:$P(A,U,2)="" ?50,"YES" W:B="" ?60,"YES" W:$P(A,U,3)["S" ?70,"YES"
 K @ARRAY
OUT D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
HEAD I IOST["C-" S DIR(0)="E" D ^DIR I 'Y S ECQ=1 Q
 W:$Y @IOF W !,?25,"DRUG NAME",?48,"MISSING",?58,"MISSING",?68,"SUPPLY",!,?49,"CLASS",?60,"NDC",?69,"ITEM",! Q
 ;
