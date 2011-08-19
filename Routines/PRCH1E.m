PRCH1E ;WISC/PLT-IFCAP RETRIEVE UNREGISTERED PURCHASE CARD CHARGES ;10/15/97  14:26
V ;;5.1;IFCAP;**8**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;retrieve unregistered purchase card charges
 N PRCA,PRCB,PRCRI
 N A,B,C
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
Q1 D YN^PRC0A(.X,.Y,"Ready to Retrieve Unregistered Purchase Card Charges","O","YES")
 I X["^"!(X="")!'Y G EXIT
 D EN^DDIOL("Start Retrieving:")
 S PRCRI=0,PRCTR=0
 F  S PRCRI=$O(^PRCH(440.6,"ST","N~",PRCRI)) QUIT:'PRCRI  D:$P(^PRCH(440.6,PRCRI,0),"^",17)=""  K:$P(^PRCH(440.6,PRCRI,0),"^",17) ^PRCH(440.6,"ST","N~",PRCRI)
 . N A,B,C,X,Y
 . S A=^PRCH(440.6,PRCRI,0),B=$P(A,"^",4),PRCRI(440.5)=$O(^PRC(440.5,"B",B,0))
 . QUIT:'PRCRI(440.5)
 . S PRCRI(200)=$P(^PRC(440.5,PRCRI(440.5),0),"^",8) QUIT:PRCRI(200)=""
 . I $D(PRC("SITE")) Q:$P(^PRC(440.5,PRCRI(440.5),2),"^",3)'=PRC("SITE")
 . W "." D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI,"16////"_PRCRI(200))
 . S PRCTR=$G(PRCTR)+1
 . QUIT
 ;
 I $G(PRCTR)>0 W !!?5,"Found "_PRCTR_" charge(s). Task completed !!" H 2
 I $G(PRCTR)=0 W !!?5,"No charges were found. Task completed !!" H 2
 K PRCTR
EXIT QUIT
