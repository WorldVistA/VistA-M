GMRYUT6 ;HIRMFO/YH-IV SOLUTION SELECT FROM PHARMACY/NURS FILES ;5/13/96
 ;;4.0;Intake/Output;;Apr 25, 1997
PSSOL ;LIST PATIENT IV SOLUTION FROM PHARMACY ORDER
 K GMRY S (GMRZ,GMRZ(1),GMRZ(2),GMRZ(3))="",(GMRX,GMRY)=0 D GETIV^GMRYPSIV(DFN,GMRVTYP,.GMRY) I GMRY'>0 W !,"No pharmacy active IV order for this patient",! G NURSOL
SEL ;Select from the following pharmacy active IV order(s)
 W !,"pharmacy active IV order for the patient:",! F GMRX=1:1:GMRY W !,GMRX_"."_$P(GMRY(GMRX),"^")_" "_$P(GMRY(GMRX),"^",2)_" "_$P(GMRY(+GMRX),"^",4),!
 W !,"Select a number between 1 and "_GMRY_": " S GMRX=0 R GMRX:DTIME I '$T!(GMRX["^") S GMROUT=1 G Q
 G:GMRX="" NURSOL G:GMRX<1!(GMRX>GMRY) SEL
 S GMRZ=$P(GMRY(+GMRX),"^"),GMRZ(2)=+$P(GMRY(+GMRX),"^",2),GMRZ(1)=$P(GMRY(+GMRX),"^",3),GMRZ(3)=+$P(GMRY(+GMRX),"^",4) D ASK1 G:GMRX=""!("Yy"[GMRX) Q G SEL
NURSOL ;SELECT FROM NUR SOLUTION FILE
 D NURSOL^GMRYUT7 G:GMROUT Q
 S GMRZ=$P(Y(0),"^"),GMRZ(1)=$P(Y(0),"^",2),GMRZ(2)=+$P(Y(0),"^",3),GMRZ(3)="" D ASK1 G:GMRX=""!("Yy"[GMRX)!GMROUT Q S (GMRZ,GMRZ(1),GMRZ(2),GMRZ(3))="" G NURSOL
Q K X,Y,GMRX,GMRY,GMRDA,GMRD S:GMRZ=""!(GMRZ(1)="")!(GMRZ(2)="") GMROUT=1 Q
ASK1 S X="" W !,"Amount of solution in mls in the container: "_$S(GMRZ(2)="":"",1:GMRZ(2)_"// ") R X:DTIME S:'$T!(X["^") GMROUT=1 Q:GMROUT
 I (X'=""&(X'>0))!(X["?") W !!,"Enter total amount of solution in mls in the container.",! S X="" G ASK1
 I '(X?1.4N!(X?1.4N1"."1N))&(X'="") W !,"ERROR ENTRY",! G ASK1
 I GOPT'="RESTART"&((X>9999!(X<.1))&(X'="")) W !!,"Amount of solution has to be a number between .1 and 9999.",!! G ASK1
 I GOPT="RESTART"&(X>$G(GSAVE)) W !!,"The number must be equal to or less than the remaining amount.",!! G ASK1
 I X[".",$L($P(X,".",2))>1 W !!,"Only 1 decimal digit allowed",! G ASK1
 S:X>0 GMRZ(2)=+X I GMRZ(2)=0 G ASK1
ASK3 W !,"Enter a number for infusion rate (Example: 125 = 125 ml/hr): "_$S(GMRZ(3)>0:GMRZ(3)_"// ",1:" ") S X="" R X:DTIME S:'$T!(X["^") GMROUT=1 Q:GMROUT
 G:X="" ASK4 I X'=""&(X'?1.3N!(X<0)!(X>999)) W !,"Enter a number between 1 and 999 or enter <RET> to bypass this entry",! G ASK3
 I X>0 S GMRZ(3)=X G ASK4
 I X["?" W !,"Enter the rate at which the infusion is to take place.",!,"For example: a number 125 entered means the infusion rate is 125 mls/hr",! S X="" G ASK3
ASK4 W !,GMRZ_"  "_$S(GMRZ(1)="A":"admixture",GMRZ(1)="P":"piggyback",GMRZ(1)="B":"blood/blood product",GMRZ(1)="H":"hyperal",GMRZ(1)="I":"intralipids",1:"")_"   "_GMRZ(2)_" mls  "_$S(GMRZ(3)'="":GMRZ(3),1:"UNKNOWN")_" ml/hr"
 W "   Is it correct " S %=1 D YN^DICN S GMRX=$S(%=1:"Y",%=2:"N",1:"") S:%<0 GMROUT=1 Q:GMRX="Y"!(GMRX="N")!GMROUT
 W !!,"If data is correct, please enter 'Y', else enter 'N' if incorrect.",! G ASK4
 Q
ADDHNG S DR="S:GMRVTYP[""P"" Y=""@1"";1///^S X=GMRZ;@1;2//^S X=""N"";S:GMRVTYP[""P"" Y=""@2"";3//^S X=""N"";@2;4///^S X=""`""_DUZ;I GADD=""Y"" S Y=""@3"";5//^S X=""D"";@3;" Q
SITEDES ;SELECT IV SITE DESCRIPTION, CALLED BY DATA ENTRY ROUTINES
 K GMRY,GSEL S GMRZ="",GMRTRNS=2 K GMRX D DISPLAY^GMRYUT5 R GMRX:DTIME I '$T!(GMRX["^") S GMROUT=1,GMRZ="" G QL
 I GMRX="" S GMRZ=$P(^GMRD(126.72,1,0),"^") G ASK2
 S I=$L(GMRX,",") F X=1:1:I S Y=$P(GMRX,",",X) I ((Y'?.N1"-".N)&(Y'?.N))!((Y["-")&($P(Y,"-",2)<$P(Y,"-",1))!($P(Y,"-",1)=0)!($P(Y,"-",2)=0)) S GMRX="?"
 I GMRX["?" W !!,"Select an item or a combination of items such as ",!,"1,3-5 to describe the IV site you observe",! G SITEDES
 D VALIDAT^GMRYUT9 G:'$D(GSEL) SITEDES S GMRX=0 F  S GMRX=$O(GSEL(GMRX)) Q:GMRX'>0!('$D(GMRY(+GMRX)))  S GMRZ=GMRZ_$S($L(GMRZ)>0:", ",1:"")_$P(GMRY(GMRX),"^",2)
 I $L(GMRZ)>50 W !,"The string length is longer than 50 characters!" G SITEDES
ASK2 G:$L(GMRZ)'>0 SITEDES S X=""
QL K %,GMRX,GMRY,GMRN,GMRTRNS,GSEL Q
