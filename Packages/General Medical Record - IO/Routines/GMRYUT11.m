GMRYUT11 ;HIRMFO/YH-IV FLUSH ;10/18/96
 ;;4.0;Intake/Output;;Apr 25, 1997
PATIENT ;SEARCH PATIENT BY WARD AND ROOM
 I '$D(^NURSF(214,"AF","A",GMRWARD)) S GMROUT=1 Q
 S GNURWRD=GMRWARD,GNURWRD(1)=GMRWARD(1) F DFN=0:0 S DFN=$O(^NURSF(214,"AF","A",GNURWRD,DFN)) Q:DFN'>0!GMROUT  D WARDPT
 S GMRWARD=GNURWRD,GMRWARD(1)=GNURWRD(1) K GNURWRD Q
WARDPT ;
 D PT^GMRYUT0 Q:"Ss"[GMREDB&($S($P(GMRBED,"-")="":1,1:'$D(GNRMBD($P(GMRBED,"-")))))!(GMRNAM="")
 S GROOM="BLANK",GBED="BLANK" S:GMRBED'="" GROOM=$P(GMRBED,"-"),GBED=$P(GMRBED,"-",2) S ^TMP("GMRPT",$J,GROOM,GBED,DFN)="" Q
MHOUR ;SCREEN MILITARY HOUR, CLLED BY DD NURSING SHIFT HOUR
 S:$L(X)>4!($L(X)<4) X="" Q:X=""  S GMROUT=0 F GMRY=1:1:4 S GMRY(1)=$A($E(X,GMRY)) S:GMRY(1)<48!(GMRY(1)>57) GMROUT=1 Q:GMROUT
 I GMROUT S X="" K GMRY,GMROUT Q
 I X=0!(X>2400) S X="" K GMRY,GMROUT Q
 I $E(X,3,4)>60 S X="" K GMRY,GMROUT Q
 K GMRY,GMROUT Q
DCREASON ;LIST IV DC REASON CALLED BY D/C IV EDIT
 N GMRX,I S GDCREAS="INFUSED"
 W !!,"Select one of the following reasons for DCing or ^ to exit",!! S X="",I=0 F  S X=$O(^GMRD(126.76,"B",X)) Q:X=""  S X(1)=$O(^GMRD(126.76,"B",X,0)) Q:X(1)'>0  S I=I+1 W ?10,I_". "_$P(^GMRD(126.76,X(1),0),"^"),! S GMRX(I)=$P(^(0),"^")
 Q:I'>0  S GMRX=0 W !,"Select a number between 1 and "_I_": INFUSED// " R GMRX:DTIME I '$T!(GMRX["^") S GMROUT=1 Q
 I GMRX["?" W !!,"Select a number between 1 and "_I_" for the reason of this DCing.",!,"INFUSED is default.",! G DCREASON
ASKYN Q:GMRX=""  I $D(GMRX(+GMRX)) S GDCREAS=$P(GMRX(+GMRX),"^") W !,GDCREAS Q
 G DCREASON
WRITE ;PRINT I/O RECORDS FOR SELECTION
 S GY=$P(GMRDATA(GN),"^"),GY(1)=+$P(GMRDATA(GN),"^",2)
 S Y=GY X ^DD("DD") W ?5,GN_".",?10,$P(Y,":",1,2)
 I GNANS="OUT" D
 . N GI S GI=$P($G(^GMR(126,DA,GNANS,GY(1),0)),"^",4)
 . I GI'="",GI?1.3N W ?40,GI_" mls"
 . E   S GI(1)=$E(GI) S:GI(1)'="*" GI(1)=$$UP^XLFSTR(GI(1)) W ?40,$S(GI(1)="*":"*",GI(1)="S":"Small",GI(1)="M":"Medium",GI(1)="L":"Large",1:"")
 . S GSTYP=$P($G(^GMR(126,DA,GNANS,GY(1),0)),"^",3)
 .Q
 I GNANS="OUT",GSTYP'="",$D(^GMRD(126.6,+GSTYP,0)) W "   "_$P(^(0),"^"),!
 G:GNANS="OUT" Q1 I GNANS="IV" W ?40,$P(GMRDATA(+GN),"^",3)_" mls left   Intake: "_$S($P(GMRDATA(+GN),"^",3)["*":"unknown",1:$P(GMRDATA(+GN),"^",4)_" mls"),! G Q1
 I GNANS="IN",$D(^GMR(126,DA,GNANS,GY(1),0)) W ?40,"Total: "_+$P(^(0),"^",5)_" mls",!
 I GNANS="IN",$D(^GMR(126,DA,GNANS,GY(1),1,0)) S GY(2)=0 F  S GY(2)=$O(^GMR(126,DA,GNANS,GY(1),1,GY(2))) Q:GY(2)'>0  S GY(3)=$G(^(GY(2),0)) W ?40,$S($D(^GMRD(126.8,+$P(GY(3),"^"),0)):$P(^(0),"^"),1:"") W ?60,+$P(GY(3),"^",2)_" mls",!
Q1 W ! K GSTYP Q
