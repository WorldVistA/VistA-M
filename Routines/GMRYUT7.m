GMRYUT7 ;HIRMFO/YH-IV SOLUTION SELECT TO START ;10/16/96
 ;;4.0;Intake/Output;;Apr 25, 1997
SOLTYPE ;SELECT SOLUTION TYPE
 S GMRVTYP=""
 W !,"Select one of the IV types listed below",!,?5,"A - admixture",!,?5,"B - blood/blood product",!,?5,"H - hyperal",!,?5,"I - intralipid",!,?5,"P - piggyback",!,?5,"L - locks/ports",!,?5,"Please enter a character: " S X="" R X:DTIME
 I '$T!(X["^") S GMROUT=1 Q
 S GMRVTYP=$S("Aa"[X:"A","Hh"[X:"H","Ii"[X:"I","Bb"[X:"B","Pp"[X:"P","Ll"[X:"L",1:"") I GMRVTYP'=""&(X'="") D  Q
 . W "  "_$S(GMRVTYP="A":"admixture",GMRVTYP="B":"blood/blood product",GMRVTYP="H":"hyperal",GMRVTYP="I":"intralipid",GMRVTYP="P":"piggyback",GMRVTYP="L":"locks/ports",1:"")
 . Q
  W !,"Select type of IV solution you want to hang by entering",!,"the first character of the solution category",! G SOLTYPE
 Q
NURSOL ;SELECT IV SOLUTION FROM NUR SOLUTION FILE 126.9 TO HUNG
 K GMRY,GMRB S (GMRY,GMRX)=0 F  S GMRX=$O(^GMRD(126.9,"C",GMRVTYP,GMRX)) Q:GMRX'>0  I $D(^GMRD(126.9,GMRX,0)) S GMRY=GMRY+1,GMRB($P(^(0),"^"))=^(0)
 S GMRB(" OTHER")="OTHER^"_GMRVTYP_"^0",GMRY=0,GMRB="" F  S GMRB=$O(GMRB(GMRB)) Q:GMRB=""  S GMRY=GMRY+1,GMRY(GMRY)=GMRB(GMRB)
SEL0 I GMRY=0 W !,"No solutions found in the NURS SOLUTION FILE 126.9",! S GMROUT=1 Q
 S GMRN=(GMRY\2)+(GMRY#2) F I=1:1:GMRN S $P(GTXT(I)," ",80)="" I $D(GMRY(I)) S X="",X=I_". "_$P(GMRY(I),"^")_"  "_+$P(GMRY(I),"^",3)_" mls",GTXT(I)=X_$E(GTXT(I),$L(X),80)
 F I=GMRN+1:1:GMRY I $D(GMRY(I)) S GTXT(I-GMRN)=$E(GTXT(I-GMRN),1,40)_I_". "_$P(GMRY(I),"^")_"  "_+$P(GMRY(I),"^",3)_" mls"
SEL W !!,"Select a(n) "_$S(GMRVTYP="A":"admixture",GMRVTYP="B":"blood/blood product",GMRVTYP="H":"hyperal",GMRVTYP="I":"intralipid",GMRVTYP="P":"piggyback",1:"")_" from the following Nursing Solution file listing ",! F I=1:1:GMRN W !,GTXT(I)
 W !!,"Enter a number/name for your selection,",!,"Enter additional vitamins/electrolytes using a ; to separate,",!,"for example, 4;multivits): "  S X="" R X:DTIME I '$T!(X["^") S GMROUT=1 K GMRB,GTXT,GMRN Q
 I X=""!(X["?")!(X>GMRY) W !,"Enter the number or the first couple of letters of",!,"the solution you want to start",! G SEL
 I X>0,$D(GMRY(+X)) S Y(0)=GMRY(+X),$P(Y(0),"^")=$P(Y(0),"^")_$P(X,+X,2) D:$P(Y(0),"^")["OTHER" OTHRSOL^GMRYUT10 K GMRB,GTXT,GMRN Q
 Q:GMROUT  S X=$$UP^XLFSTR(X) K GMRB,GTXT,GMRW,GMRX S (GMRW,GMRX)=0 F  S GMRX=$O(GMRY(GMRX)) Q:GMRX'>0  I $E($P(GMRY(GMRX),"^"),1,$L(X))=X S GMRW=GMRW+1,GMRW(GMRW)=GMRY(GMRX)
 I GMRW=0 W !,"No solution selected",! G SEL0
 K GMRY S GMRY=GMRW F I=1:1:GMRY S GMRY(I)=GMRW(I)
 G SEL0
SITEDC ;SCREEN THE SELECTED IV SITE WAS D/C'D
 Q:GMROUT  N GDA S GSTDC=0,GDA=+$P(^GMR(126,DA(2),"IVM",DA(1),1,0),"^",3) Q:GDA'>0  S:$P(^GMR(126,DA(2),"IVM",DA(1),1,GDA,0),"^",6)["Y" GSTDC=1 Q
DRAIN ;SELECT SUBTYPE OF OUTPUT DRAINAGE
 K GMRY,GTXT S GMRZ="",(GMRY,GMRX)=0 F  S GMRX=$O(^GMRD(126.6,"C",GTP,GMRX)) Q:GMRX'>0  I $D(^GMRD(126.6,GMRX,0)) S GMRY=GMRY+1,GMRY(GMRY)=$P(^(0),"^")_"^"_GMRX
 I GMRY=0 W !,"No OUTPUT SUBTYPE set!!!",! K GMRY,GMRX Q
 S GMRN=(GMRY\2)+(GMRY#2) F I=1:1:GMRN S $P(GTXT(I)," ",80)="" I $D(GMRY(I)) S X="",X=I_". "_$P(GMRY(I),"^"),GTXT(I)=X_$E(GTXT(I),$L(X),80)
 F I=GMRN+1:1:GMRY I $D(GMRY(I)) S GTXT(I-GMRN)=$E(GTXT(I-GMRN),1,30)_I_". "_$P(GMRY(I),"^")
 F I=1:1:GMRN W !,GTXT(I)
 W !,"Select a number for the "_GLABEL_" SUBTYPE(optional): " S X="" R X:DTIME S:'$T GMROUT=1 S:X["^" (GMROUT,GMROUT(1))=1 I GMROUT!(X="")!GMROUT(1) K GMRY,GMRX,GMRN,GTXT Q
 I X>0,$D(GMRY(+X)) S GMRZ=+$P(GMRY(+X),"^",2) W !,$P(GMRY(+X),"^") Q
 W !,"Subtype for "_GLABEL_" is optional. However if you to wish",!,"to identify the subtype of "_GLABEL_", then enter the number of your selection",! G DRAIN
SELSITE ;
 N GMRZ,I S (GMRZ,I)=0 F  S I=$O(GMRY(I)) Q:I'>0  I $E($P(GMRY(I),"^",2))=GMRX S GMRZ=GMRZ+1,GMRZ(GMRZ)=$P(GMRY(I),"^",2)
 Q:GMRZ=0  I GMRZ=1 S X=GMRZ(1) Q
 S I=0 F  S I=$O(GMRZ(I)) Q:I'>0  W !,I_". "_GMRZ(I)
 W !,"Select a number from the above list: " S I=0 R I:DTIME I '$T!(I["^") S GMROUT=1 Q
 I $D(GMRZ(+I)) S X=GMRZ(+I) Q
 G SELSITE
