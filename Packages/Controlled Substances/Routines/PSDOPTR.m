PSDOPTR ;BIR/LTL-Review OP Transactions for a Drug ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 N PSDOUT I '$D(PSDSITE) D ^PSDSET I '$D(PSDSITE) S PSDOUT=1 G END
 N C,CNT,DFN,DIC,DIR,DIRUT,DTOUT,DUOUT,PSD,PSDEV,PSDI,PSDR,PSDU,PSDLOC,PSDLOCN,PSDT,PSDTB,X,Y S PSDOUT=1,PSDU=0
 D DT^DICRW
 S PSDLOC=$P(PSDSITE,U,3),PSDLOCN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
LOOK S DIC="^PSD(58.8,",DIC(0)="AEQ",DIC("A")="Select Dispensing Site: "
 S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$S($P($G(^(0)),U,2)[""M"":1,$P($G(^(0)),U,2)[""S"":1,1:0),($S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0))"
 S DIC("B")=$P(PSDSITE,U,4)
 W ! D ^DIC K DIC G:Y<0 END S PSDLOC=+Y,PSDLOCN=$P(Y,U,2)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=$P(Y,U,2)
CHKD K ^TMP("PSD",$J)
 S DIR(0)="S^1:Sort by Drug;2:Sort by Rx #;3:Sort by Inventory Type"
 S DIR("A")="Sort by",DIR("B")=1
 S DIR("?")="Please select the sort that sounds most promising."
 D ^DIR K DIR G:$D(DIRUT) END G:Y=2 ^PSDOPTX G:Y=3 ^PSDOPTI
 G ^PSDOPTS Q
END Q
