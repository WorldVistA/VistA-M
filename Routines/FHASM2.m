FHASM2 ; HISC/REL - Assessment (cont) ;5/14/93  10:03
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
FRM ; Calculate Frame Size
 W !!,"Wrist Circumference: " W:WCCM WCCM_" cm// " R X:DTIME G KIL^FHASM1:'$T!(X["^")
 I X="",$G(WCCM) S X=WCCM
 S WCCM=X
 G F1:X=""
 I X'?1.2N.1".".N!(X<2)!(X>50) W *7,!,"Value should be between 2 and 50cm.; press RETURN to bypass." G FRM
 S WCIR=+X,RAT=HGT*2.54/WCIR
 I SEX="F" S FRM=$S(RAT>11.0:"S",RAT<10.1:"L",1:"M")
 I SEX="M" S FRM=$S(RAT>10.4:"S",RAT<9.6:"L",1:"M")
 W "   ",$S(FRM="S":"Small",FRM="M":"Medium",1:"Large")," Frame" G IBW
F1 I FRM="" S FRM="M"
 S X="" W !!,"Frame Size (SMALL,MEDIUM,LARGE) "_FRM R "// ",X:DTIME
 I '$T!(X["^") S FHQUIT=1 G KIL^FHASM1
 S:X="" X=FRM D TR^FHASM1
 I $P("SMALL",X,1)'="",$P("MEDIUM",X,1)'="",$P("LARGE",X,1)'="" W *7,"  Enter S, M or L" G F1
 S FRM=$E(X,1)
IBW ; Target Body Weight
 W !!,"Calculation of Target Body Weight",! S METH=""
 I H1'<60 W !?10,"H   Hamwi" S METH=METH_"H"
 I SEX="M",(H1<76),(H1>60),(AGE'<19) W !?10,"M   Metropolitan 83" W !?10,"S   Spinal Cord Injury" S METH=METH_"MS"
 I SEX="F",(H1<73),(H1>57),(AGE'<19) W !?10,"M   Metropolitan 83" W !?10,"S   Spinal Cord Injury" S METH=METH_"MS"
 I SEX="M",(H1<74),(H1>60),(AGE>64) W !?10,"G   Geriatric" S METH=METH_"G"
 I SEX="F",(H1<70),(H1>57),(AGE>64) W !?10,"G   Geriatric" S METH=METH_"G"
 I AGE<10 W !?10,"P   Pediatric" S METH=METH_"P"
 W !?10,"E   Enter Manually" S METH=METH_"E"
SEL W !!,"Method: " W:CIBW'="" CIBW_" // " R X:DTIME I '$T!(X["^") G KIL^FHASM1
 I X="",CIBW'="" S X=CIBW
 D TR^FHASM1
 I METH'[$E(X,1)!(X="") W *7,!,"   You Must Choose from the List Above" G SEL
 S CIBW=X
 S METH=$E(X,1) D E:METH="E",H^FHASM2D:METH="H",^FHASM2A:METH="M",^FHASM2A:METH="S",^FHASM2B:METH="G",^FHASM2C:METH="P" G:FHQUIT KIL^FHASM1 I IBW'>0 G KIL^FHASM1:IBW="^",IBW
AMP S FHAMP="NO" I AMP'="" S FHAMP="YES"
 G:FHQUIT KIL^FHASM1
 S X="" W !!,"Does Patient have an Amputation? "_FHAMP R "// ",X:DTIME
 I X="^" S FHQUIT=1 G:'$T!(X["^") KIL^FHASM1
 S:X="" X=FHAMP D TR^FHASM1
 S FHAMP=X
 I $P("YES",FHAMP,1)'="",$P("NO",FHAMP,1)'="" W *7," Answer YES or NO" G AMP
 ;S FHAMP=$E(FHAMP,1),FHAMP=FHAMP="Y" G:'FHAMP A5
 I $E(FHAMP,1)="N" S AMP="" G A5
A1 W !!,"Amputee Types: (may be multiple, e.g: 2,2,5)"
 W !!?5,"1 Hand              (0.7%)",?36,"2 Total Leg        (16.1%)",!?5,"3 Total Arm         (4.9%)",?36,"4 Foot              (1.5%)"
 W !?5,"5 Forearm and Hand  (2.3%)",?36,"6 Calf and Foot     (5.8%)"
A2 I AMP'="" W !!,"Total Amputee %: ",AMP K DIR S DIR(0)="SAO^Y:Yes;N:No",DIR("A")="Do you wish to change this? ",DIR("B")="N" D ^DIR G:$D(DIRUT) KIL^FHASM1 I Y="N" G A5
 S AMP=0 R !!?2,"Amputee Types: ",X:DTIME G:'$T!(X["^") KIL^FHASM1
 F K=1:1 S Y=$P(X,",",K) Q:Y=""  G:Y'?1N!(Y<1)!(Y>6) A6 S AMP=AMP+$P(".7,16.1,4.9,1.5,2.3,5.8",",",Y)
A3 W !!,"Total Amputee %: ",AMP," // " R X:DTIME S:X="" X=AMP G:'$T!(X["^") KIL^FHASM1
 I X<.5!(X>50) W *7,!,"Total % of amputations should be .5% to 50%" G A3
 S AMP=+$J(X,0,1),IBW=100-AMP*IBW/100,IBW=+$J(IBW,0,0)
A4 S X1=$S(FHU'="M":IBW_"#",1:+$J(IBW/2.2,0,1)_"kg")
 W !!,"Select TBW after Amputee Correction: ",X1,"// " R X:DTIME I '$T!(X["^") G KIL^FHASM1
 I X=""!(X=+X1) G A5
 D WGT^FHASM1 I Y<1 D WGP^FHASM1 G A4
 S IBW=+Y
A5 S IBW=+$J(IBW,0,0) G ^FHASM3
A6 W *7,!!?5,"Enter a string of types (e.g: 1,1,4); no digit can exceed 6." G A2
E ; Manual Entry of Target Weight
 W !!,"Enter Target Body Weight: " W:IBW'="" IBW_"lbs// " R X:DTIME I '$T!(X["^") S FHQUIT=1 Q
 I X="",IBW'="" S X=IBW
 D WGT^FHASM1 I Y<1 D WGP^FHASM1 G E
 S IBW=+Y Q
 ;
ASK ;ask user to edit or create assessment.
 D PRTA
 I 'FHDIC S FHASK="C" Q
 R !!,"Do you want to Edit or Create or Delete Assessment? E// ",FHASK:DTIME I '$T!(FHASK["^") S FHQUIT=1 Q
 S:FHASK="" FHASK="E" S X=FHASK D TR^FH S FHASK=X
 S FHASK=$E(FHASK)
 I (FHASK'="E"),(FHASK'="C"),(FHASK'="D") W *7,!?5,"Enter 'E' to Edit work in progress assessment or 'C' to Create new assessment or 'D' to Delete assessment!!" G ASK
 I (FHASK="E")!(FHASK="D") D AAS
 Q
AAS ;ask user which assesment to edit or delete.
 W !
 K DIC S DIC="^FHPT(FHDFN,""N"",",DIC(0)="Q",DA=FHDFN,X="??"
 S DIC("S")="D DCS^FHASM2 I FHDIC"
 S DIC("W")="S FHASS=$P($D(^FHPT(FHDFN,""N"",+Y,""DI"")),U,6) W ""  "",$S(FHASS=""C"":""Complete"",FHASS=""S"":""Signed"",1:""Work in Progress"")"
 D ^DIC S DIC="^FHPT(FHDFN,""N"",",DIC(0)="AEQM"
 S DIC("A")="SELECT Assessment Date: "
 W !,"You can only access your own Work in Progress Assessment, unless you have an FHMGR key.",!
 S DIC("W")="S FHASS=$P($D(^FHPT(FHDFN,""N"",+Y,""DI"")),U,6) W ""  "",$S(FHASS=""C"":""Complete"",FHASS=""S"":""Signed"",1:""Work in Progress"")"
 D ^DIC I "^"[X!$D(DTOUT) S FHQUIT=1 Q
 G:Y<1 AAS
 S FHCAS=+Y
 K DIC
 Q
DCS S FHDIC=0 I '$D(^FHPT(FHDFN,"N",Y,"DI")),$D(^XUSEC("FHMGR",DUZ)) S FHDIC=1
 I '$D(^FHPT(FHDFN,"N",Y,"DI")),$D(^FHPT(FHDFN,"N",Y,0)),($P(^(0),U,23)=DUZ) S FHDIC=1
 I $D(^FHPT(FHDFN,"N",Y,0)),($P(^(0),U,23)=DUZ),($D(^FHPT(FHDFN,"N",Y,"DI"))&(($P($G(^FHPT(FHDFN,"N",+Y,"DI")),U,6)="W"))) S FHDIC=1
 I $D(^FHPT(FHDFN,"N",Y,"DI")) I ($P($G(^FHPT(FHDFN,"N",+Y,"DI")),U,6)="W"),$D(^XUSEC("FHMGR",DUZ)) S FHDIC=1
 Q
 ;
DCS1 S FHDIC=0
 F FHI9=0:0 S FHI9=$O(^FHPT(FHDFN,"N",FHI9)) Q:FHI9'>0  D
 .I '$D(^FHPT(FHDFN,"N",FHI9,"DI")),$D(^XUSEC("FHMGR",DUZ)) S FHDIC=1
 .I '$D(^FHPT(FHDFN,"N",FHI9,"DI")),$D(^FHPT(FHDFN,"N",FHI9,0)),($P(^(0),U,23)=DUZ) S FHDIC=1
 .I $D(^FHPT(FHDFN,"N",FHI9,0)),($P(^(0),U,23)=DUZ),($D(^FHPT(FHDFN,"N",FHI9,"DI"))&(($P($G(^FHPT(FHDFN,"N",+FHI9,"DI")),U,6)="W")!($P($G(^FHPT(FHDFN,"N",FHI9,"DI")),U,6)=""))) S FHDIC=1
 .I $D(^FHPT(FHDFN,"N",FHI9,"DI")) I ($P(^FHPT(FHDFN,"N",+FHI9,"DI"),U,6)="W")!($P(^FHPT(FHDFN,"N",FHI9,"DI"),U,6)=""),$D(^XUSEC("FHMGR",DUZ)) S FHDIC=1
 Q
PRTA ;print if there is a current assessment.
 S DTP=FHCASD D DTP^FH W !!,"Last Assessment on File: ",$S($G(FHCASD):$E(DTP,1,9),1:"No Assessment") S DTP=""
 W:FHCAS ?40,"Status: ",$S(FHASS="C":"Completed",FHASS="S":"Signed",FHASS="W":"Work in Progress",1:"")
 D DCS1
 Q
