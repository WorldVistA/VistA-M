PRCFDE2 ;WISC/LKG-ENTER/EDIT CERTIFIED INVOICE ;7/19/95  14:32
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
VENDOR ;Edit Vendor information
 N PRCFERR,I
 I '$G(PRCF("VENDA")) S X="Incomplete Vendor Information on PO/1358.  Unable to Edit Vendor Data.*" D MSG^PRCFQ Q
 S (PRCFA("VEND"),DA)=PRCF("VENDA")
 G:$G(PRCF("NUVEND")) A
 D HILO^PRCFQ,INFO^PRCFAC3
 K IOINHI,IOINLOW,IOINORM,PRCTMP D EDIT^PRCFAC31
 I 'Y!($D(DIRUT)) W !!,"No further action is being taken on this Vendor.",! G VENDX
A L +(^PRC(440.3,DA),^PRC(440,DA)):5 E  W !,"Vendor information being edited by another user",! G VENDX
 K ^PRC(440.3,DA) S %X="^PRC(440,DA,",%Y="^PRC(440.3,DA," D %XY^%RCR
A1 S DIE=440,DR=$S($P($G(^PRC(411,PRC("SITE"),0)),U,20):$S($D(^XUSEC("PRCFA VENDOR EDIT",DUZ)):"[PRCF FMS VENEDIT2B]",1:"[PRCF FMS VENEDIT2]"),1:$S($D(^XUSEC("PRCFA VENDOR EDIT",DUZ)):"[PRCF FMS VENEDIT1B]",1:"[PRCF FMS VENEDIT1]"))
 D ^DIE K DIE,DR,ORDER
 G:'$D(DA) A2
 S X=$G(^PRC(440,DA,7)),PRCFERR=0
 F I=3,7,8,9 I $P(X,U,I)="" S PRCFERR=1 Q
 I $G(PRCFERR) D  G:Y=1 A1
 . W !!,"Warning - Payment Information for this Vendor is Incomplete."
 . W !,"Payment information will have to be re-edited, if vendor is to be paid."
 . S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you wish to re-edit the payment information now"
 . D ^DIR K DIR
 I '$G(PRCFERR) W ! D VEDIT^PRCHE1A(PRCFA("VEND"),PRC("SITE"))
A2 L -^PRC(440.3,PRCF("VENDA")),-^PRC(440,PRCF("VENDA"))
VENDX K DA,PRCFA("VEND"),DIRUT,DIROUT,DTOUT,DUOUT,%X,%Y
 S X="Returning to Payments Module.*" D MSG^PRCFQ
 Q
CLSD1358(PODA,MSG) ;Determine if 1358, status Transaction Complete or
 ;Canceled, Totally Liquidated
 N PRCFX,PRCFY,PRCFZ
 Q:PODA'?1.N 0 Q:'$D(^PRC(442,PODA,0)) 0
 S PRCFX=$O(^PRCD(442.5,"C",1358,"")) Q:PRCFX="" 0
 I $P(^PRC(442,PODA,0),U,2)'=PRCFX Q 0
 S PRCFX=$P($G(^PRC(442,PODA,7)),U),PRCFZ=$P($P($G(^PRC(442,PODA,0)),U,3)," ")
 I PRCFX]"",";40;105;"[(";"_$P($G(^PRCD(442.3,PRCFX,0)),U,3)_";") D  Q 1
 . W:MSG !,"Warning - This 1358 has been closed."
 . W:MSG !,"In order for this invoice to be paid, the ",PRCFZ," FCP Official will have ",!,"  to reopen this 1358 and maybe adjust its obligation amount."
 S PRCFY=$G(^PRC(442,PODA,8))
 I $P(PRCFY,U)-$P(PRCFY,U,2)'>0 D  Q 1
 . W:MSG !,"Warning - This 1358 has already been totally liquidated."
 . W:MSG !,"In order for this invoice to be paid, the ",PRCFZ," FCP official must first do",!,"  an Increase Adjustment."
 Q 0
