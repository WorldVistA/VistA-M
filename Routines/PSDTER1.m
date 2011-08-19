PSDTER1 ;BIR/LTL-Barcode Terminal Type/Device Loader (cont'd) ; 26 Nov 93
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 ;An IRM utility to stuff barcoding
 ;data into fields in the DEVICE & TERMINAL TYPE files.
TRAK ;Trakker update
 D  G:'$G(PSDALL) BEG^PSDTER Q
 .I $G(PSDALL) D  Q:Y<1
 ..S DIC="^%ZIS(2,",DIC(0)="L",DLAYGO=3.2,X="C-VT420 (9440)"
 ..D ^DIC K DIC Q:Y<1  S PSDTERM=$P(Y,U,2),PSDTERM(1)=+Y
 ..I '$P(Y,U,3) S DIC="^%ZIS(2,",DA=+Y W !,"Current settings:",! D EN^DIQ
 ..S DIR(0)="Y",DIR("A",1)=PSDTERM(4),DIR("?")=PSDTERM(6),DIR("B")="No"
 ..S DIR("A")="into the "_PSDTERM_" Terminal Type" W ! D ^DIR K DIR
 .S DIE="^%ZIS(2,",DA=PSDTERM(1)
 .W !!,"Updating ",PSDTERM,"."
 .S DR="1////80;2////#;3////9999;6////W $C(0);99////TRAKKER 9440 TO AUX PORT OF VT420;110////W $C(27)_""[5i"";111////W $C(27)_""[4i"""
 .D ^DIE K DIE,DA,DR
 .S DIR(0)="Y",DIR("A")=PSDTERM(2),DIR("B")="No",DIR("?")=PSDTERM(3)
 .W ! D ^DIR K DIR Q:Y<1
 .S DIC="^%ZIS(1,",DIC(0)="AEMQL",DLAYGO=3.5,DIC("B")="TRAKKERSL"
 .W ! D ^DIC K DIC Q:Y<1  S DIE="^%ZIS(1,",DA=+Y
 .S DR=".02//SLAVED 9440 FROM VT420 AUX PORT;1////0;2///TERMINAL;3////^S X=PSDTERM(1);9////80;10////#;11////9999;12////$C(8)" D ^DIE
