HBHCWORK ; LR VAMC(IRMS)/MJT-HBHC Medical Foster Home (MFH) worksheet, Entry points:  BLANK & EN ; 7/20/07
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
BLANK ; Blank worksheet entry point; HBHCNOD0="" & HBHCMFHP="-1" are dummy values
 S HBHCBLNK="Blank",HBHCNOD0="",HBHCMFHP="-1"
EN ; Entry point
 D MFHS^HBHCUTL3
 ; HBHCMFHS variable set in MFHS^HBHCUTL3
 G:$D(DIRUT)!('$D(HBHCMFHS)) EXIT
 I '$D(HBHCBLNK) K DIC S DIC="^HBHC(633.2,",DIC(0)="AEMQZ" D ^DIC S HBHCMFHP=+Y G:Y=-1 EXIT S HBHCNOD0=$G(^HBHC(633.2,HBHCMFHP,0))
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCWORK",ZTDESC="HBPC MFH Worksheet",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 S $P(HBHCY12,"_",13)="",$P(HBHCY20,"_",21)="",$P(HBHCY30,"_",31)="",$P(HBHCY40,"_",41)="",$P(HBHCY50,"_",51)="",$P(HBHCY65,"_",66)="",HBHCPAGE=0
 I $D(HBHCBLNK) S HBHCHEAD="Medical Foster Home (MFH) Blank Worksheet",HBHCHDR="W ?26,""MFH Name:"""
 I '$D(HBHCBLNK) S HBHCHEAD="Medical Foster Home (MFH) Worksheet",HBHCHDR="W ?26,""MFH Name:  ""_$P(HBHCNOD0,U)"
 S HBHCCOLM=(80-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 D TODAY^HBHCUTL D:IO'=IO(0)!($D(IO("S"))) HDRPAGE^HBHCUTL
 I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 D HDRPAGE^HBHCUTL
 D PROCESS
 D ENDRPT^HBHCUTL1
EXIT ; Exit module
 D ^%ZISC
 K DIC,HBHCBLNK,HBHCCC,HBHCCOLM,HBHCHDR,HBHCHEAD,HBHCI,HBHCJ,HBHCMFHP,HBHCMFHS,HBHCNOD0,HBHCNODE,HBHCPAGE,HBHCPRV,HBHCTDY,HBHCY12,HBHCY20,HBHCY30,HBHCY40,HBHCY50,HBHCY65,HBHCZ,X,Y
 Q
PROCESS ; Process MFH demographic, inspection, & training data
 W !!,"Address:",?15,$S($P(HBHCNOD0,U,8)]"":$P(HBHCNOD0,U,8),1:HBHCY65)
 W !!,"City:",?15,$S($P(HBHCNOD0,U,9)]"":$P(HBHCNOD0,U,9),1:HBHCY65)
 W !!,"State Code:",?15,$S($P(HBHCNOD0,U,10)]"":$P($G(^DIC(5,$P(^HBHC(631.8,$P(HBHCNOD0,U,10),0),U),0)),U),1:HBHCY65)
 W !!,"County Code:",?15,$S($P(HBHCNOD0,U,15)]"":$P($G(^DIC(5,$P(^HBHC(631.8,$P(HBHCNOD0,U,10),0),U),1,$P(HBHCNOD0,U,15),0)),U)_"  ("_$P($G(^DIC(5,$P(^HBHC(631.8,$P(HBHCNOD0,U,10),0),U),1,$P(HBHCNOD0,U,15),0)),U,3)_")",1:HBHCY65)
 W !!,"ZIP Code:",?15,$S($P(HBHCNOD0,U,11)]"":$P(HBHCNOD0,U,11),1:HBHCY65)
 W !!,"Phone Number:",?15,$S($P(HBHCNOD0,U,14)]"":$P(HBHCNOD0,U,14),1:HBHCY65)
 W !!,"Opened Date:" S:$P(HBHCNOD0,U,2)]"" Y=$P(HBHCNOD0,U,2) D DD^%DT W ?30,$S($P(HBHCNOD0,U,2)]"":Y,1:HBHCY50)
 S:$P(HBHCNOD0,U,16)]"" Y=$P(HBHCNOD0,U,16) D DD^%DT
 W !!,"Primary Caregiver Name:",?30,$S($P(HBHCNOD0,U,3)]"":$P(HBHCNOD0,U,3),1:HBHCY50)
 W !!,"Caregiver Date of Birth:",?30,$S($P(HBHCNOD0,U,16)]"":Y,1:HBHCY50)
 W !!,"Maximum Patients:",?20,$S($P(HBHCNOD0,U,4)]"":$P(HBHCNOD0,U,4),1:"  1  2  3"),?34,"Bedbound Patient Maximum:",?62,$S($P(HBHCNOD0,U,5)]"":$P(HBHCNOD0,U,5),1:"  0  1  2")
 W !!,"License Required:",?20,$S($P(HBHCNOD0,U,12)="Y":"Yes",$P(HBHCNOD0,U,12)="N":"No",1:"  Yes   No"),?34,"License Expiration Date:" S:$P(HBHCNOD0,U,13)]"" Y=$P(HBHCNOD0,U,13) D DD^%DT W ?60,$S($P(HBHCNOD0,U,13)]"":Y,1:HBHCY20)
 W !!,"Closure Date:" S:$P(HBHCNOD0,U,6)]"" Y=$P(HBHCNOD0,U,6) D DD^%DT W ?16,$S($P(HBHCNOD0,U,6)]"":Y,1:HBHCY30),?50,"Voluntary Closure:",?70,$S($P(HBHCNOD0,U,7)="Y":"Yes",$P(HBHCNOD0,U,7)="N":"No",1:"  Yes   No")
INSPECT ; Process inspection data
 W !
 F HBHCI=1:1:4 D WRITE D:$D(^HBHC(633.2,HBHCMFHP,HBHCI)) LOOP
TRAIN ; Process training data
 Q:$D(HBHCBLNK)
 W !
 F HBHCI=5:1:11 D WRITE2 D:$D(^HBHC(633.2,HBHCMFHP,HBHCI)) LOOP
 Q
WRITE ; Write Inspection headers
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<10) W:HBHCPAGE>0 @IOF D HDRPAGE^HBHCUTL
 W !! W:HBHCI=1 "Nurse" W:HBHCI=2 "Social Work" W:HBHCI=3 "Dietitian" W:HBHCI=4 "Fire/Safety" W " Inspection:",!!?3,"Date:",?10,HBHCY20,?33,"Name:",?40,HBHCY40 W:'$D(HBHCBLNK) !,?10,"Previous Inspection(s):"
 Q
WRITE2 ; Write training headers
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<12) W:HBHCPAGE>0 @IOF D HDRPAGE^HBHCUTL
 W !! W:HBHCI=5 "Home Operation" W:HBHCI=6 "Fire/Safety" W:HBHCI=7 "Medication Management" W:HBHCI=8 "Personal Care" W:HBHCI=9 "Infection Control" W:HBHCI=10 "End of Life Issues" W:HBHCI=11 "Other"
 W " Training Date:",?40,HBHCY40 W:HBHCI=11 !!,?32,"Topic:",?40,HBHCY40 W !?3,"Previous Training Date(s):"
 Q
LOOP ; Write previous Inspection & Training data
 S HBHCJ=0
 F  S HBHCJ=$O(^HBHC(633.2,HBHCMFHP,HBHCI,HBHCJ)) Q:HBHCJ'>0  S HBHCNODE=$G(^HBHC(633.2,HBHCMFHP,HBHCI,HBHCJ,0)) S Y=$P(HBHCNODE,U) D DD^%DT D:HBHCI<5 NAME W:HBHCI<5 !?13,Y,?43,"Name:  ",$S(HBHCPRV]"":HBHCPRV,1:"") W:HBHCI>4 !?6,Y D TOPIC
 Q
TOPIC ; Write Other Training Topic, if exists
 W:HBHCI=11 ?40,"Topic:  ",$P(HBHCNODE,U,2)
 Q
NAME ; Obtain Provider Name from VA(200 file
 N Y
 K DA,DIC,DR,^UTILITY("DIQ1",$J)
 S DIC=200,DR=.01,DA=$P(HBHCNODE,U,2) D EN^DIQ1
 S HBHCPRV=^UTILITY("DIQ1",$J,200,DA,DR)
 K DA,DIC,DR,^UTILITY("DIQ1",$J)
 Q
