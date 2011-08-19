PRCFDCI ;WISC/CTB-CHECK IN DOCUMENTS FROM SERVICE ;7/19/95  14:30
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DIE K %DT S X="T" D ^%DT S PRCFD("TODAY")=Y
 S DIE="^PRCF(421.5,",DR="[PRCF CI CHECK-IN]",DA=PRCF("CIDA") D ^DIE
 K PRCFD("AMT CERT"),PRCFD("CERT SHP"),PRCFD("INV AMT"),PRCFD("SHP AMT")
 I $P(^PRCF(421.5,PRCF("CIDA"),1),"^",5) S %A="Do you wish to print the suspension letter at this time",%B="",%=1 D ^PRCFYN I %=1 D PRCFCHK,^PRCFDSUS
 S %=0 D CHECK D
 . I $G(PRCFNOPO)=1 S X=0 D STATUS^PRCFDE1 Q  ;if there is no valid PO
 . I '% S X=10 D STATUS^PRCFDE1 Q
 I $G(PRCFNOPO)=1 S PRCFNOPO=0 Q
 S %A="Is this document ready to go to accounting",%B="",%=1
 D ^PRCFYN I %'=1 S X=10 D STATUS^PRCFDE1 Q
 D SIG S X=$S(%:15,1:10) D STATUS^PRCFDE1
 Q
OUT D OUT^PRCFDE Q
PRCFCHK ;CHECK FOR AMOUNT APPROVED FOR PAYMENT
 I $P($G(^PRCF(421.5,PRCF("CIDA"),0)),U,15) S PRCF("CHECK")=1 Q
 S %A(1)="     The Invoice Tracking record for this claim voucher does not show"
 S %A(2)="     an amount approved for payment.  Does this mean that the claim voucher"
 S %A(3)="     has been disapproved and that no check will be issued",%=2,%A=" ",%B=""
 D ^PRCFYN S PRCF("CHECK")=$S(%=1:0,1:1)
 Q
CHECK ;CHECK THAT ALL INFO IS COMPLETE, ASK ES
 F I=0,1,2 S P(I)=$G(^PRCF(421.5,DA,I))
 S %=1,X=",,1,2,3,4,,6,,,,,,,13,,,,,,11.5,19,20"
 I $P(P(0),U,8)="" W !,$P(^DD(421.5,6,0),U)_" is Blank.",$C(7),!,"You may enter a Vendor now.",! S PRCFD("PAY")=1 D VENED G CHECK
 F I=3:1:6,15 I $P(P(0),"^",I)="" W !,$P(^DD(421.5,$P(X,",",I),0),"^")_" is Blank.",$C(7) S %=0
 ;I $D(P(1)),+P(1)=0 F I=2,9,21,22,23 I $P(P(0),"^",I)="" W !,$P(^DD(421.5,$P(X,",",I),0),"^")_" is Blank.",$C(7) S %=0
 I $D(P(1)),+P(1)=0 F I=21 I $P(P(0),"^",I)="" W !,$P(^DD(421.5,$P(X,",",I),0),"^")_" is Blank.",$C(7) S %=0
 I $P(P(0),"^",7)="",$P(P(1),"^",3)="" W !,"Both PURCHASE ORDER NUMBER and PURCHASE ORDER POINTER fields are blank.",$C(7) S %=0
 K X
 S X=0 F I=11,12,26 I $P(P(0),"^",I)]"" S X=1 Q
 I 'X,$P(P(0),"^",13)'="X" S X=1
 I X F I=11,12,13,26 I $P(P(0),"^",I)]"" Q:'%  F J=12,13,26 I I+J'=37,J'>I,$P(P(0),"^",J)="" W !,"Discount Information is Incomplete.",$C(7) S %=0 G CK
 I +$P(P(0),"^",11)'=0,+$P(P(0),"^",26)'=0 W !,$C(7),"You may not have both a Discount % and a Discount Amount." S %=0 K P
CK I % I $P($G(^PRCF(421.5,DA,0)),U,15)'>0 S X="No funds authorized for payment.*" D MSG^PRCFQ S %=1 K P Q
 I % S X="Data appears OK for payment.*" D MSG^PRCFQ S %=1 K P Q
 W !!,"No further action can be taken until document is corrected."
 K P S ZX=%,%A="Do you wish to correct this information now",%B="",%=1
 D ^PRCFYN I %'=1 S %=ZX K ZX Q
 S DIE=421.5,DR="[PRCF CI VOUCHER AUDIT]",DA=PRCF("CIDA") D ^DIE
 I $P(^PRCF(421.5,DA,0),U,8)']"" D VENED
 K PRCF("VENDA"),PRCFD("DOI"),PRCFD("PODA"),PRCFD("DOP"),PRCFD("DIR")
 K PRCFD("INV TYPE"),PRCF("PTR"),PRCF("DAYS"),PRCF("NAME"),PRCF("X")
 K PRCF("PT"),PRCFD("DOD"),ZX
 I $P($G(^PRCF(421.5,PRCF("CIDA"),0)),U,15)=""!($P($G(^(0)),U,21)="") D
 . S DIE=421.5,DR="[PRCF CI CHECK-IN]",DA=PRCF("CIDA") D ^DIE K DIE,DR
 . K PRCFD("AMT CERT"),PRCFD("CERT SHP"),PRCFD("INV AMT"),PRCFD("SHP AMT")
 I $P(^PRCF(421.5,PRCF("CIDA"),1),"^",5) S %A="Do you wish to print the suspension letter at this time",%B="",%=1 D ^PRCFYN I %=1 D PRCFCHK,^PRCFDSUS
 G CHECK
SIG K PRCFK D SIG^PRCFACX0 I $D(PRCFA("SIGFAIL")) K PRCFA("SIGFAIL") S X="  <No Further Action Taken.>" D MSG^PRCFQ S %=0 K P Q
 S DA=PRCF("CIDA"),MESSAGE=""
 D REMOVE^PRCFDES1(DA),ENCODE^PRCFDES1(DA,DUZ,.MESSAGE)
 K MESSAGE,P S %=1
 Q
VENED ;
 S DIC=440,DIC(0)="AENMQ" S:$P($G(^PRC(411,PRC("SITE"),0)),U,20) DIC(0)=DIC(0)_"L",DLAYGO=440
 S DIC("A")="Invoice's Vendor: " S:$G(PRCF("VENDA"))?1.N DIC("B")=$P($G(^PRC(440,PRCF("VENDA"),0)),U)
 D ^DIC K DIC,DLAYGO,ORDER,PRCHOV3,STATE Q:+Y<1  S PRCF("VENDA")=+Y
 I $P(Y,U,3) S PRCF("NUVEND")=1 D VENDOR^PRCFDE2
 S DIE=421.5,DR="6////"_PRCF("VENDA"),DA=PRCF("CIDA") D ^DIE
 K DIE,DR
 Q
