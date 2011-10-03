PSIVORH ;BIR/MLM-MAIN DRIVER FOR IV HYPERALS - OE/RR INTERFACE ;09 FEB 93 / 10:02 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
EN ; Entry point called by IV Hyperal protocol.
 S X=ORACTION,PSIVAC="O"_$S(X="N":"N",X=1:"E",X=2:"R",X=4:"H",X=6:"D",X="8":"S",1:"") S:X'=5&(X'=7) PSIVUP=+$$GTPCI^PSIVUTL
 S DFN=+ORVP,X=ORACTION I X=5!(X=7)!(X=8) D @ORACTION Q
 D ENCPP^PSIVOREN Q:'PSJIVORF!('PSJORF)  D EN1,DONE^PSIVORA1
 Q
 ;
EN1 ; Take action on existing order.
 I ORGY>8 D @ORGY Q
 I '$G(ORPK) W !,"INSUFFICIENT INFORMATION, CANNOT CONTINUE." S OREND=1 Q
 I ORPK["V",($P($G(^PS(55,DFN,"IV",+ORPK,0)),U,17)="O") D ONCALL^PSIVORV1 Q
 S PSJORD=ORPK,PSJORSTS=ORSTS L +@$S(PSJORD["V":"^PS(55,DFN,""IV"",+PSJORD)",1:"^PS(53.1,+PSJORD)"):1 E  W $C(7),!!,"This order is being edited by another user." S OREND=1 Q
 D @ORACTION L -@$S(PSJORD["V":"^PS(55,DFN,""IV"",+PSJORD)",1:"^PS(53.1,+PSJORD)")
 Q
 ;
NEW ; Enter a new IV Hyperal order.
 W !!,"HYPERAL ORDER ENTRY NOT AVAILABLE",!
 Q
 ;
1 ; Edit an existing order.
 W !!,"EDIT OF HYPERAL ORDERS NOT AVAILABLE",!
 Q
 ;
2 ; Renew
 W !!,"RENEWAL OF HYPERAL ORDERS NOT AVAILABLE",!
 Q
 ;
3 ; Flag
 Q
 ;
4 ; Hold
 W !!,"HOLD OF HYPERAL ORDERS NOT AVAILABLE",!
 Q
 ;
5 ; Event
 D 5^PSIVORA
 Q
 ;
6 ; Cancel - Delete pending or unreleased orders from Nonverified orders 
 ; (53.1) and Orders (100) files.
 I ORSTS=1 W $C(7),!,"This order has already been DISCONTINUED." Q
 W !!,"CANCEL HYPERAL ORDERS NOT AVAILABLE",! Q
 Q
 ;
7 ; Purge
 D 7^PSIVORA
 Q
 ;
8 ; Print
 K DIR S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!'($D(ORPK)) S OREND=1 Q
 S:'$G(PSIVUP) PSIVUP=+$$GTPCI^PSIVUTL S:'$D(PSIVAC) PSIVAC="OS" S (ON,ON55)=ORPK,DFN=+ORVP D @$S(ON["V":"GT55^PSIVORFB",1:"GT531^PSIVORFA("_DFN_","""_ON_""")"),ENDT^PSIVORV1
 Q
 ;
9 ; release order (status=incomplete in 53.1, pending in 100)
 S X=ORACTION I X=4!(X=6) D @ORACTION Q
 G:"36"'[ORSTS 9^PSIVORA
 Q
 ;
10 ; Verify
 Q
