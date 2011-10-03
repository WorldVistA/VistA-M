GMRYUT1 ;HIRMFO/YH-PATIENT I/O UTILITIES - IV SEARCH BY TYPE ;2/14/91
 ;;4.0;Intake/Output;;Apr 25, 1997
IVTYP ;LIST CURRENT IV LINES BY SELECTED IV TYPE
 S (GWRITE,GMRVDT,GDT,GN)=0 F JJ=0:0 S GDT=$O(^GMR(126,DFN,"IV","TYP",GDT)) Q:GDT'>0!(GMRVDT>0)  D IVTYP1
 Q:GN=0
 I GN=1 S (GMRVDT,GIVDT)=+$P(GN(GN),"^"),GSITE=$P(GN(GN),"^",2),GMRVP=+$P(GN(GN),"^",3) Q
 F JJ=1:1:GN W !,JJ,".  " S Y=+$P(GN(JJ),"^") X ^DD("DD") W $P(GN(JJ),"^",4)_"  "_$P(GN(JJ),"^",5)_" mls  "_$P(GN(JJ),"^",2)_"  "_$P(Y,":",1,2)
 W !,"Select a number between 1 and ",GN," : " S X=0 R X:DTIME S:'$T GMROUT=1 Q:GMROUT!(X["^")!(X="")
 I X["?" W !!,"Select the line of "_GLABEL_" which you want to record intake " G IVTYP
 I $S(X<1!(X>GN):1,'$D(GN(X)):1,1:0) G IVTYP
 W ! S (GMRVDT,GIVDT)=+$P(GN(X),"^"),GSITE=$P(GN(X),"^",2) S GMRVP=+$P(GN(X),"^",3)
 Q
IVTYP1 ;SELECT IV BY TYPE
 S GDA="",GMRVP=0 F JJ=0:0 S GDA=$O(^GMR(126,DFN,"IV","TYP",+GDT,GDA)) Q:GDA=""  I GDA=GMRVTYP S GMRVP=$O(^GMR(126,DFN,"IV","TYP",+GDT,GDA,0)) I GMRVP>0,$P(^GMR(126,DFN,"IV",+GMRVP,0),"^",9)="" D SETA
 Q
SETA S GN=GN+1,GN(GN)=(9999999-GDT)_"^"_$P(^GMR(126,DFN,"IV",+GMRVP,0),"^",2)_"^"_GMRVP_"^"_$P(^(0),"^",3)_"^"_$P(^(0),"^",5)
 Q
SELECT ;SELECT IV TO START OR DC
 W ! F II=1:1:GNN Q:GMROUT!(GMRNO["^")  D WRITE I II=GNN!'(II#5) W !!,"Select a number to edit or ^ to quit selection"_$S(GMRDC:": ",'GMRDC:"") W:'GMRDC !,"(i.e., 1 to edit; 1@ to delete; new IV if none selected): " R GMRNO:DTIME S:'$T GMROUT=1
 G:GMRNO["?"!(GMRNO>GNN) SELECT
 Q
WRITE S Y=$P(GMRDATA(GN),"^") X ^DD("DD") W !,GN,". "_$P(GMRDATA(GN),"^",6)_"  "_$S($P(GMRDATA(GN),"^",3)'["L":$P(GMRDATA(GN),"^",7)_" mls ("_$P(GMRDATA(GN),"^",3)_")  ",1:"")_$P(GMRDATA(GN),"^",4)_"  "_$P(GMRDATA(GN),"^",8)_" on ",$P(Y,":",1,2)
 I $P(GMRDATA(GN),"^",5)'="" S Y=$P(GMRDATA(GN),"^",5) X ^DD("DD") W "  DC'ed on ",Y
 W !
 Q
QUEST ;
 W:GMRDC=1 "Select a number(i.e., 1 to edit; 1@ to delete or N to add; ^ to quit",!,"selection): "
 W:GMRDC=2 "Select a number to edit or ^ to quit "
 W:GMRDC=0 "Select a number i.e., 1@ to delete or <RET> for new: " R GX:DTIME I '$T!(GX["^^") S GMROUT=1
 Q:GX=""  I GX["?" D HELP S GN(2)=GN(3) Q
 I ($L(GX)=1&(GX="N"!(GX="n")!(GX="^")))!($L(GX)=2&(GX="^^")) Q
 I (GX?.N&$D(GMRDATA(+GX)))!(GX?.N1"@"&$D(GMRDATA(+GX))) Q
 D HELP S GX=9999 Q
HELP ;
 W @IOF W:GNANS'="IV" "** The listing is an inversed display of "_GLABEL_" records in the database",!
 W "** To edit ... enter a number, i.e., 1",!,"** To delete ... enter a number@, i.e., 1@",!,"** To add ... enter N",?38,"** ^ to quit edit an I/O TYPE",!,"** <RET> RETURN for more listing"
 W ?38,"** ^^ to quit the data entry option",!
 Q
