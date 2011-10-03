RAPSET ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Set Sign-on parameters ;5/22/97  14:22
 ;;5.0;Radiology/Nuclear Medicine;**21**;Mar 16, 1998
 D CHKSP^RAUTL2
 I 'RADV!('RALC) W !!,*7,"You must initialize at least one Radiology/Nuclear Medicine Division",!,"and one Imaging Location to proceed.",!,"Refer to the Radiology/Nuclear Medicine ADPAC Guide.",!! K RADV,RALC S XQUIT="" Q
 K RADV,RALC S (RADIV,RALOC,RADEV,DIV,LOC,DEV)="" G LOC:$D(^RA(79.2,"AC","E"))
 D HOME^%ZIS ;I $D(IOS),IOS S DEV=$P(^%ZIS(1,+IOS,0),"^")
 ;
LOC I $S('($D(DUZ)#2):1,'DUZ:1,1:0) W !,*7,"Your user code 'DUZ' must be defined to continue." S XQUIT="" G Q^RAPSET1
 S DEV="" W:$D(^RA(79.2,"AC","E")) ?15,"**** Normal Computer is Down. ****",!
 I $G(DIC("B"))="",$D(^DISV(+DUZ,"^RA(79.1,")),$D(^RA(79.1,+^DISV(+DUZ,"^RA(79.1,"),0)) S DIC("B")=$S($D(^RA(79.1,+^DISV(+DUZ,"^RA(79.1,"),0)):$S($D(^SC(+^(0),0)):$P(^(0),"^"),1:""),1:"") I DIC("B")']"" K DIC("B")
 I $D(DIC("B")),$P($G(^RA(79.1,+^DISV(+DUZ,"^RA(79.1,"),0)),U,19) K DIC("B")
 ; display default img loc ONLY IF it matches proc's img loc's img type
 ; SETDISV^RAREG3 already took care of settg default DIC("B") if lone img type
 G:'$G(RAITN) LOC1
 N RA1,RA2,RA3
 G:$G(DIC("B"))="" LOC1
 S RA1=0,RA2=0 ; RA1 = name of loc   RA2 = ien of img loc
 F  S RA1=$O(^SC("B",DIC("B"),RA1)) Q:'RA1  S:'RA2 RA2=$O(^RA(79.1,"B",RA1,0)) ; use 1st non-null RA2
 S RA3=$P(^RA(79.1,RA2,0),"^",6) ;ien img type
 I RA3'=RAITN K DIC("B")
 I $P(^RA(79.1,RA2,0),"^",19) K DIC("B") ;Don't show inactive loc as dflt
LOC1 D:'$D(RACCESS(DUZ)) VARACC^RAUTL6(DUZ) ; Setup user's access
 S DIC("A")="Please select a sign-on Imaging Location: "
 S DIC("S")="I $D(RACCESS(DUZ,""LOC"",+Y))"
 I $D(RAOPT("REG"))#2!('$D(^XUSEC("RA ALLOC",DUZ))) D
 .S DIC("S")=DIC("S")_"&($P(^RA(79.1,+Y,0),U,19)']"""")"
 I $D(RADUPSCN),($D(RAREGX(4))),($D(RAYN)) D
 . S DIC("B")=$P($G(^SC(+$G(^RA(79.1,RAREGX(4),0)),0)),U)
 . N X S X=$P($G(^RA(79.1,RAREGX(4),0)),U,19) I X,X'>DT K DIC("B")
 . S DIC("S")=DIC("S")_"&(+Y=RAREGX(4))" ; RA FLASH (DUP^RAEDCN)
 . Q
 S DIC="^RA(79.1,",DIC(0)="AEMQ" D ^DIC
 K DIC("A"),DIC("S") I $D(DTOUT)!($D(DUOUT)) S XQUIT="" G Q^RAPSET1
 I Y<0 W !?3,*7,"You must choose an Imaging 'Location' to continue...",!?3,"or enter '^' to stop.",! G LOC1
 S LOC=+Y,DIV=$O(^RA(79,"AL",LOC,0))
 I DIV'>0!('$D(^RA(79,+DIV,0))) W !,*7,"Radiology/Nuclear Medicine Division definition error. Call your site manager." S XQUIT="" G Q^RAPSET1
 S RADIV=^RA(79,DIV,0),RALOC=$S($D(^RA(79.1,LOC,0)):^(0),1:"")
 I RALOC']"" W !!,*7,"Imaging Location definition error. Call your site manager." S XQUIT="" G Q^RAPSET1
 ;
PAR S RAMDIV=DIV,Y=$S($D(^RA(79,DIV,.1)):^(.1),1:""),RAMDV="" F I=1:1 Q:$P(Y,"^",I,99)']""  S RAMDV=RAMDV_$S($P(Y,"^",I)="Y"!($P(Y,"^",I)="y"):1,1:0)_"^"
 I $P(RAMDV,"^",6),DEV,$P(RADEV,"^")["Y" S $P(RAMDV,"^",6)=0
 ;
 S RAMLC=LOC_"^"_$S('$P(RAMDV,"^",2):+$P(RALOC,"^",2),1:0)
 S RAI=$S($P(RALOC,"^",3)']"":-1,1:+$P(RALOC,"^",3)),RAFLH=$S($D(^%ZIS(1,+RAI,0)):$P(^(0),"^"),1:"")
 I RAFLH']""!($D(^RA(79.2,"AC","E"))) S %ZIS="N",%ZIS("A")="Default Flash Card Printer: " D ^%ZIS D:POP NOESC S RAFLH=$S(POP:"",IO=IO(0):"",1:ION),RAI=$S(RAFLH="":"",1:$O(^%ZIS(1,"B",RAFLH,0)))
 S RAMLC=RAMLC_"^"_RAFLH_"^"_$S($P(RAMDV,"^",8):$S($P(RALOC,"^",4):$P(RALOC,"^",4),1:2),1:0),RAFLH=$S(RAFLH']"":0,RAI>0:RAI,1:0)
 S RAI=$S($P(RALOC,"^",5)']"":-1,1:+$P(RALOC,"^",5)),RAJAC=$S($D(^%ZIS(1,+RAI,0)):$P(^(0),"^"),1:"")
 I RAJAC']""!($D(^RA(79.2,"AC","E"))) S %ZIS="N",%ZIS("A")="Default Jacket Label Printer: " D ^%ZIS D:POP NOESC S RAJAC=$S(POP:"",IO=IO(0):"",1:ION),RAI=$S(RAJAC="":"",1:$O(^%ZIS(1,"B",RAJAC,0)))
 S RAMLC=RAMLC_"^"_RAJAC_"^"_$P(RALOC,"^",6,9),RAJAC=$S(RAJAC']"":0,RAI>0:RAI,1:0)
 S RAI=$S($P(RALOC,"^",10)']"":-1,1:+$P(RALOC,"^",10)),RARPT=$S($D(^%ZIS(1,+RAI,0)):$P(^(0),"^"),1:"")
 I RARPT']""!($D(^RA(79.2,"AC","E"))) S %ZIS="N",%ZIS("A")="Default Report Printer: " D ^%ZIS D:POP NOESC S RARPT=$S(POP:"",IO=IO(0):"",1:ION),RAI=$S(RARPT="":"",1:$O(^%ZIS(1,"B",RARPT,0)))
 S RAMLC=RAMLC_"^"_RARPT_"^"_$P(RALOC,"^",11,13),RARPT=$S(RARPT']"":0,RAI>0:RAI,1:0) S LINE="",$P(LINE,"-",80)=""
 S RAIMGTY=$$IMGTY^RAUTL12("l",+RAMLC)
 I RAIMGTY']"" D UNDEF,KILL^RAPSET1 Q
 D HOME^%ZIS G ^RAPSET1
 ;
UNDEF ; Message for undefined imaging types
 N RAVAPOR
 I '+$G(RAMLC) D  Q
 . W !?5,"Imaging Location data is not defined, "
 . W "contact IRM.",$C(7)
 . Q
 S RAVAPOR=$P($G(^SC(+$P($G(^RA(79.1,+RAMLC,0)),U),0)),U)
 W !?5,"An Imaging Type was not defined for the following Imaging"
 W !?5,"Location: '"_$S(RAVAPOR']"":"Unknown",1:RAVAPOR)_"'"
 Q
NOESC ; No up-arrow allowed at Flash Card, Jacket Label, or Report
 ; printer device prompts after selecting sign-on imaging location.
 W $C(7),!,"No up-arrow allowed.  Default printer will be your terminal."
 Q
