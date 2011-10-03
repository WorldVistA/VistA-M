PRCEADJ1 ;WISC/CLH/LDB/SJG-FISCAL 1358 ADJUSTMENTS ; 04/21/93  4:20 PM
V ;;5.1;IFCAP;**23**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Adjustment processing FISCAL
 N PRC410,PRC442,DA,I,PO,PRC,PRCB,PRCF,PRCFA,DIC,TRNODE,X,Y,FSO,PX,TRDA,X1,PODA,NOGO
V1 D OUT S PRCF("X")="AB" D ^PRCFSITE Q:'%
 D LU^PRCS58OB(.Y,.PRC,.PRCF) G:Y<0 OUT
 S PRCFA("RETRAN")=0
RETRAN ; Entry point for rebuild/transmit
 W !,"...retrieving 1358 information...",! D WAIT^DICD
 S (DA,TRDA)=+Y
 D NODE^PRCS58OB(DA,.TRNODE)
 S (X,X1)=$P(TRNODE(4),U,5) D VER^PRCH58OB(.PRC,.X)
 I X="" W !!,"Unable to Process due to lack of Obligation Number." G OUT
 S PODA=X,PRC410=TRDA,PRC442=X,NOGO="" D OB1^PRCS58OB(TRDA,X)
 D PO^PRCH58OB(PODA,.PO) S PO=PODA
 D HILO^PRCFQ
FMSCHK ;
 ;  Patch 23, disable obligation process for SO with "Q" & "T" status
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 D FMSTAT I $D(SOSTAT),("^Q^T^R^E^")[$E(SOSTAT,1),SOSTAT'="CALM" D  G V1
 .W !! K MSG S MSG(1)="    One of the previous documents has not been accepted in FMS."
 .S MSG(2)="    The adjustment to this 1358 cannot be obligated at this time."
 .S MSG(3)="    In order for the obligation of this adjustment to proceed, the"
 .S MSG(4)="    previous document cannot have a status of 'REJECTED', 'ERROR"
 .S MSG(5)="    IN TRANSMISSION', 'QUEUED FOR TRANSMISSION', or 'TRANSMITTED'.",MSG(6)="  "
 .S MSG(7)="    FMS Document: "_SODOC,MSG(8)="    Status: "_SOSTAT,MSG(9)="  "
 .S MSG(10)="    No further action is being taken on this obligation."
 .D EN^DDIOL(.MSG) K MSG W !
 .Q
SC W:$D(IOF) @IOF W "PROCESS 1358 ADJUSTMENT",?40,"Obligation #: ",IOINHI,$P(PO(0),"^")
 W !!,IOINLOW,"     Service Balance: $ ",IOINHI,$FN(+PO(8)-$P(PO(8),"^",3),"P,",2)
 W !,IOINLOW,"      Fiscal Balance: $ ",IOINHI,$FN(+PO(8)-$P(PO(8),"^",2),"P,",2)
 W !,IOINLOW,"Amount of Adjustment: $ ",IOINHI,$FN($P(TRNODE(4),"^",8),",P",2)
 W !!,IOINLOW,?20,"ORIGINAL",?45,"ADJUSTMENT"
 W !!,IOINLOW,"  COST CENTER: ",?21,IOINHI,+$P(PO(0),"^",5),?48,+$P(TRNODE(3),"^",3) I +$P(PO(0),"^",5)'=+$P(TRNODE(3),"^",3) S NOGO=NOGO_3 W $C(7),?60,"*****"
 W !!,IOINLOW,?10,"BOC #1:",?22,IOINHI,$P($P(PO(0),"^",6)," "),?49,$P($P(TRNODE(3),"^",6)," ") I +$P(PO(0),"^",6)'=+$P(TRNODE(3),"^",6) W $C(7),?60,"*****" S NOGO=NOGO_2
 I +$P(PO(0),"^",8)>0!(+$P(TRNODE(3),"^",8)>0) W !,IOINLOW,?10,"BOC #2:",?22,IOINHI,$P($P(PO(0),"^",8)," "),?49,$P($P(TRNODE(3),"^",8)," ") I +$P(PO(0),"^",8)'=+$P(TRNODE(3),"^",8) W $C(7),?60,"*****" S NOGO=NOGO_2
 W IOINORM
 I NOGO[2 D SUB G OUT ;G:'Y V D SAEDIT^PRCS58OB(.PO,TRDA) S I=4
 I NOGO[3 D CC G OUT
CHECK ; Check adjustment amount with obligation/liquidation/authorization amounts
 I PRC442,+$G(PRCFA("RETRAN"))=0,$$EN1^PRCE0A(PRC410,PRC442,1) W !,$C(7),"Send 1358 adjustment back to service.",! G OUT
 S PRCFA("MOD")="M^1^Modification Entry"
 W ! D VENCONM^PRCFFU15(+PO)
 D EN^PRCFFU14(TRDA) I ACCEDIT G SC
 D AUTACC^PRCFFU6 S PRCFA("ACCEDIT")=1
 N Y S PRCFA("IDES")="1358 Obligation Adjustment" W ! D OKAY^PRCFFU
 ; Patch 23, fix Y undef error
 ;I Y K DIR,Y D ^PRCESOM I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 G V1
 I Y K DIR,Y D ^PRCESOM G:'$G(PRCFA("RETRAN")) V1 S Y=0    ; patch 23
 I 'Y!($D(DIRUT)) W ! D EN^DDIOL("No further processing is being taken on this adjustment.")
OUT K DTOUT,DIR,DUOUT,DIRUT,DIROUT
OUT1 K DA,D0,ACCEDIT,BBFY,BEGDATE,CONT,CONTEND,CONTIEN,ENDDATE,ESIGMSG,EXIT
 K FMSMOD,FMSVENID,GECSFMS,I,NEWACC,NEWDATE,NOGO
 K NUMB,OB,PARAM1,PO,PODA,PODATE,POIEN,PRC410,PRC442,PRCCC,PRCCCC,PRCCSCC
 K PRCCP,PRCFA,PRCFMO,PRCREQST,PRCSTA,PRCSTR,PRCTMP,SODOC,SOSTAT
 K STR2,TMP410,TMP442,TRDA,TRNODE,VENCONT,X,X1
 Q
FMSTAT ; Check status of prior FMS Documments
 D FMSTAT^PRCEADJ(+PO,.SODOC,.SOSTAT)
 Q
SUB ; Check BOCs (subaccounts)
 K MSG  W !!
 S MSG(1)="  BOCs on the adjustment are not the same as on the original obligation."
 S MSG(2)="  Processing cannot continue - please return to the Service for correction.",MSG(3)=" "
 S MSG(4)="  No further processing is being taken on this adjustment."
 D MSG(.MSG)
 Q
CC ; Check Cost Centers
 K MSG W !!
 S MSG(1)="  Cost Center on the adjustment is not the same as on the original"
 S MSG(2)="  obligation.  Processing cannot continue - please return to the"
 S MSG(3)="  Service for correction.",MSG(4)=" "
 S MSG(5)="  No further processing is being taken on this adjustment."
 D MSG(.MSG)
 Q
MSG(X) ; Display message
 Q:'$D(MSG)
 D EN^DDIOL(.MSG),ENCON^PRCFQ
 Q
