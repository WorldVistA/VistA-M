PRCHP181 ;SF/FKV-PRINT FOR SF18 REQUEST FOR QUOTATIONS ;7-20-89/8:36 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN W "10.PLEASE FURNISH QUOTATIONS TO",?35,"|11.BUSINESS CLASSIFICATION (check appropriate boxes)",!,?3,"THE ISSUING OFFICE ON OR BE-",?35,"|",!
 W ?3,"FORE CLOSE OF BUSINESS (date)",?35,"| ___SMALL",?52,"___OTHER THAN SMALL",?73,"___VIETNAM VETERAN-OWNED",!
 W ?6,PRCHDT1,?35,"| ___WOMEN-OWNED",?52,"___DISADVANTAGED",?73,"___DISABLED VETERAN-OWNED",!,$E(PRCHUNDL,1,35),"|",$E(PRCHUNDL,1,62),!
 W "IMPORTANT: This is a request for information, and quotations furnished are not offers. If you are",!
 W "unable to quote, please so indicate on this form and return it. This request does not commit the",!
 W "Government to pay any costs incurred in the preparation of the submission of this quotation or to",!
 W "contract for supplies or services. Supplies are of domestic origin unless otherwise indicated by",!
 W "quoter. Any representations and/or certifications attached to this Request for Quotations must be",!,"completed by the quoter.",!,PRCHUNDL,!
 W ?18,"12.SCHEDULE (Include applicable Federal, State and local taxes)",!,PRCHUNDL,!
 W "ITEM NO.",?9,"|",?15,"SUPPLIES/SERVICES",?44,"|",?47,"QUANTITY",?56,"|",?58,"UNIT",?64,"|",?69,"UNIT PRICE",?81,"|",?88,"AMOUNT",!
 W "__(a)____|___________(b)____________________|____(c)____|__(d)__|_______(e)______|_______(f)______",!
 ; PRINT ITEMS ON QUOTATION
 S PRCHLI="F K=44,56,64,81 W ?K,""|"" W:K=81 !",DIWL=1,DIWR=33,DIWF="",PRCHDY=43,PRCHI=0 D ITEM
 G ^PRCHP183
 ;
ITEM ;
 S PRCHI=$O(^PRCS(410,PRCHD0,"IT",PRCHI)) Q:'PRCHI  G:'$D(^(PRCHI,0)) ITEM S PRCHX=^(0),PRCHITEM=+$P(PRCHX,U,1),PRCHIMAS=+$P(PRCHX,U,5)
 K ^UTILITY($J,"W")
 I $D(^PRC(441,PRCHIMAS,0)) S PRCHP=0 F PRCHJJ=1:1 S PRCHP=$O(^PRC(441,PRCHIMAS,1,PRCHP)) Q:PRCHP=""  S X=^(PRCHP,0) D DIWP^PRCUTL($G(DA))
 I '$D(^PRC(441,PRCHIMAS,0)) S PRCHP=0 F PRCHJJ=1:1 S PRCHP=$O(^PRCS(410,PRCHD0,"IT",PRCHI,1,PRCHP)) Q:PRCHP=""  S X=^(PRCHP,0) D DIWP^PRCUTL($G(DA))
 K ^TMP($J,"W")
 S %X="^UTILITY($J,",%Y="^TMP($J," D %XY^%RCR K ^UTILITY($J,"W")
 ;K PRCHJJ S PRCHUNIT=+$P(PRCHX,U,3),PRCHUNIT=$S($D(^PRCD(420.5,PRCHUNIT,0)):$P(^(0),U,1),1:"")
 K PRCHJJ S PRCHUNIT=+$P(PRCHX,U,3),PRCHUNIT=$P($G(^PRCD(420.5,PRCHUNIT,0)),U,1)
 S PRCHQTY=$S($P(^PRCS(410,PRCHD0,"IT",PRCHI,0),U,2)[".":$J($P(PRCHX,U,2),10,2),1:$J($P(PRCHX,U,2),7))
 S (PRCHUP,PRCHNSN,PRCHVS,PRCHPM)="" I $D(^PRC(441,PRCHIMAS,0))#2 S PRCHNSN=$P(^(0),U,5)
 I $D(^PRC(441,PRCHIMAS,2,PRCHVCNT,0))#2 S PRCHVS=$P(^(0),U,4),PRCHUP=$P(^(0),U,7),PRCHPM=$P(^(0),U,8)
 I PRCHUP]"",$D(^PRCD(420.5,PRCHUP,0)) S PRCHUP=$S($P(^(0),U,2)]"":$P(^(0),U,2),1:$P(^(0),U))
 I '$D(^TMP($J,"W")) S ^TMP($J,"W",1)=1,^(1,1,0)="***NO DESCRIPTION***"
 S PRCHCNT=+^TMP($J,"W",1)
 I PRCHUP]"",PRCHPM]"" S PRCHCNT=PRCHCNT+1,^TMP($J,"W",1,PRCHCNT,0)=PRCHPM_" Per "_PRCHUP
 I PRCHVS]"" S PRCHCNT=PRCHCNT+1,^TMP($J,"W",1,PRCHCNT,0)="STK# "_PRCHVS
 I PRCHNSN]"" S PRCHCNT=PRCHCNT+1,^TMP($J,"W",1,PRCHCNT,0)="NSN# "_PRCHNSN
 S:PRCHCNT'>0 PRCHCNT=1
 S X=PRCHDY,PRCHDY=PRCHDY+PRCHCNT+1 I PRCHDY>64 S PRCHDY=X D ENDPG S PRCHDY=PRCHCNT+2
 S I=0,J=0 D PRT G ITEM
 ;
PRT S I=I+1,J=$O(^TMP($J,"W",1,J)) Q:'J  S X=$G(^(J,0)) I I=1 W ?9,"|",?44,"|",?56,"|",?64,"|",?81,"|",!,$J(PRCHITEM,8)
 W ?9,"|",?11,X I I'=1 X PRCHLI G PRT
 W ?44,"|",?46,PRCHQTY,?56,"|",?59,PRCHUNIT,?64,"|",?81,"|",!
 G PRT
 ;
ENDPG F Z=0:0 W:PRCHDY<63 ! S PRCHDY=PRCHDY+1 I PRCHDY>62 W ?45,"PAGE "_PRCHPAGE,! S PRCHPAGE=PRCHPAGE+1 W @IOF K Z Q
 Q
