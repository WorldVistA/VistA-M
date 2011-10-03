PSDTER2 ;BIR/LTL-Barcode Terminal Type/Device Loader ; 26 Nov 93
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 ;An IRM utility to stuff green sheet formatting
 ;data into fields in the TERMINAL TYPE file.
 Q:XPDENV'=1  D DT^DICRW
 W !!,"Please select the Terminal Type for the printer currently used by Pharmacy",!!,"to print green sheets (VA FORM 10-2638).",!!
 N DIC,DIE,DA,DR,DLAYGO,DIR,DIRUT,DTOUT,PSDALL,PSDCHO,PSDKY,PSDTERM,X,Y
BEG S PSDCHO=3
TERM S DIC="^%ZIS(2,",DIC(0)="AEMQL",DLAYGO=3.2
 S DIC("B")="P-HP BARCODER"
 D ^DIC K DIC G:Y<1 END S PSDTERM=$P(Y,U,2),PSDTERM(1)=+Y
 I '$P(Y,U,3) S DIC="^%ZIS(2,",DA=+Y W !!,"Current settings:",! D EN^DIQ
SURE S DIR(0)="Y",(DIR("A",1),PSDTERM(4))="Are you sure that you want to stuff the Controlled Substances barcode set-up",DIR("A")="into the "_PSDTERM_" Terminal Type",DIR("B")="No"
 S (DIR("?"),PSDTERM(6))="Yes and I'll update OPEN EXECUTE, RIGHT MARGIN, PAGE LENGTH, Etc. fields." W ! D ^DIR K DIR G:Y<1 END
 S PSDTERM(2)="Update the DEVICE file",PSDTERM(3)="Yes, and I will add the "_PSDTERM_" Terminal Type and update a few fields in the device of your selection."
HP ;Hewlett Packard update
 S DIE="^%ZIS(2,",DA=PSDTERM(1)
 W !!,"Updating ",PSDTERM,"."
 S DR=".02///NO;1////0;2////#;3////58;4////$C(8);6////W $C(27)_""E""_$C(27)_""&l0O""_$C(27)_""(8U""_$C(27)_""(s0p""_$S($G(PSDCPI)=10:""10h14"",1:""12h12"")_""v0s0b6T"";10////$C(27)_""(s10H"";12////$C(27)_""(s12H"""
 S DR(1,3.2,1)="12.15////$C(27)_""&l8C"";12.16////$C(27)_""&l12C"";60////$S($D(PSDX2):$C(27)_""*p""_(PSDX2-1*300+200)_""y*p""_(PSDX1-1*810+38)_""X"",1:"""")_$C(27)_""(0Y""_$C(27)_""(s0p8.1h12v0s0b0T*"""
 S DR(1,3.2,2)="61////""*""_$C(27)_""&l0O""_$C(27)_""(8U""_$C(27)_""(s0p""_$S($G(PSDCPI)=10:""10h14"",1:""12h12"")_""v0s0b6T"""
 D ^DIE K DR S PSDKY=1 Q
 S DIR(0)="Y",DIR("A")=PSDTERM(2),DIR("B")="No",DIR("?")=PSDTERM(3)
 W ! D ^DIR K DIR Q:Y<1
 S DIC="^%ZIS(1,",DIC(0)="AEMQL",DLAYGO=3.5,DIC("B")="HP III BARCODER"
 W ! D ^DIC K DIC Q:Y<1  S DIE="^%ZIS(1,",DA=+Y
 S DR=".02;1;1.95///NO;2///TERMINAL;3////^S X=PSDTERM(1);4///YES;5///YES;9////0;10////#;11////58;12////$C(8);61;62;63///NOT SPOOLED;64////96"
 D ^DIE
KY ;Kyocera update
 I $G(PSDALL)!(PSDCHO=3)!($G(PSDCHO(1))=2) D  G:'$G(PSDALL) BEG
 .I $G(PSDALL) D  Q:Y<1
 ..S DIC="^%ZIS(2,",DIC(0)="L",DLAYGO=3.2,X="P-KYOCERA-BARCODE"
 ..D ^DIC K DIC Q:Y<1  S PSDTERM=$P(Y,U,2),PSDTERM(1)=+Y
 ..I '$P(Y,U,3) S DIC="^%ZIS(2,",DA=+Y W !,"Current settings:",! D EN^DIQ
 ..S DIR(0)="Y",DIR("A",1)=PSDTERM(4),DIR("?")=PSDTERM(6),DIR("B")="No"
 ..S DIR("A")="into the "_PSDTERM_" Terminal Type" W ! D ^DIR K DIR
 .S DIE="^%ZIS(2,",DA=PSDTERM(1)
 .W !!,"Updating ",PSDTERM,"."
 .S PSDKY="W ""!R! RES;FONT ""_$S($G(PSDCPI)=10:1,1:6)_"";EXIT;"""
 .S PSDKY(1)="""!R! FONT 6; UNIT D; ""_$S('$D(PSDX1):"""",PSDX1=1:""MRP 0,-60 ; "",1:"""")_$S('$D(PSDX1):"""",1:""MRP ""_(PSDX1>1*810+38)_"" , 0 ;"")_"" BARC 19, N, '"""
 .S PSDKY(2)="""', 60, 60, 3, 6, 6, 6, 3, 6, 6, 6;""_$S('$D(PSDX1):"""",PSDX1=PSDCNT:""MRP 0 , 60;"",1:"""")_""EXIT;"""
 .S DR=".02///NO;1////0;2////#;3////66;4////$C(8);6////^S X=PSDKY;60////^S X=PSDKY(1);61////^S X=PSDKY(2)"
 .D ^DIE
 .S DIR(0)="Y",DIR("A")=PSDTERM(2),DIR("B")="No",DIR("?")=PSDTERM(3)
 .W ! D ^DIR K DIR Q:Y<1
 .S DIC="^%ZIS(1,",DIC(0)="AEMQL",DLAYGO=3.5,DIC("B")="KYOCERA BARCODER"
 .W ! D ^DIC K DIC Q:Y<1  S DIE="^%ZIS(1,",DA=+Y
 .S DR=".02;1;1.95///NO;2///TERMINAL;3////^S X=PSDTERM(1);4///YES;5///YES;9////0;10////#;11////66;12////$C(8)" D ^DIE
TRAK ;Trakker update
 I $G(PSDALL)!(PSDCHO=4)!($G(PSDCHO(1))=3) D TRAK^PSDTER1
END I '$G(PSDKY) S XPDQUIT=2 W !!,"Sorry these routines cannot be loaded without setting up the terminal type.",!! Q
