PRCHAMU1 ;WISC/DJM-Reprint amendment ;3/1/95  1:22 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
GETPO ;get a valid PO
 ;the variable RETURN is either the PO/REQ# or null if no PO is selected
 N DIC,D,Y,X,PRCAM,PRCHQ,D0,D1
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))
 S DIC="^PRC(443.6,",DIC(0)="QEAMZ"
 S DIC("A")=$S($D(PRCHREQ):"REQUISITION NO.: ",1:"PURCHASE ORDER: ")
 S DIC("S")="I +$P(^(0),U)=PRC(""SITE"")"_$S($D(PRCHREQ):",$P(^(0),U,2)=8",1:",$P(^(0),U,2)<8")_",$D(^(6))>9,$P($G(^(6,0)),U,4)>0"
 D ^DIC K DIC Q:Y<0
 S PRCHPO=+Y
 S (PRCAM,PRCHAM)=0
 F  S PRCAM=$O(^PRC(443.6,+Y,6,PRCAM)) Q:PRCAM'>0  S PRCHAM=PRCAM
 D ^PRCHSF3
 W !,"QUEUED TO SUPPLY PRINTER"
 S PRCHQ="^PRCHPAM8",D0=PRCHPO,D1=PRCHAM,PRCHQ("DEST")="S8"
 D ^PRCHQUE
 Q
