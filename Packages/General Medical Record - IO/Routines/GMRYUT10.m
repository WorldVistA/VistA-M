GMRYUT10 ;HIRMFO/YH-IV RESTART ;6/11/93
 ;;4.0;Intake/Output;;Apr 25, 1997
OTHRSOL ;ENTER OTHER NAME OF SOLUTION
 W !!,"Please SPECIFY the name of the solution",!,?2,"(maximum 75 characters): " S X="" R X:DTIME I '$T!(X["^") S GMROUT=1 Q
 I X=""!(X["?")!($L(X)>75) W !,"Enter the name of this IV solution or ^ to quit",! G OTHRSOL
YN W !,X_"  " S %=1 D YN^DICN W:%=0 !!,"Enter Y(es) or N(o) to confirm your entry is correct or not.",! G:%=0 YN I %=1 S $P(Y(0),"^")=X Q
 S:%<0 GMROUT=1 Q:GMROUT  G OTHRSOL
EDTSOL ;
 W !,"Enter additional vitamins/electrolytes using a ; to separate additives",! S $P(Y(0),"^")=$$RW^GMRYDIR($P(Y(0),"^"),75) Q:GMROUT
YN2 W !,$P(Y(0),"^")_"  " S %=1 D YN^DICN W:%=0 !!,"Enter Y(es) or N(o) to confirm your entry is correct or not.",! G:%=0 YN2 Q:%=1
 S:%<0 GMROUT=1 Q:GMROUT  G EDTSOL
RESTART ;RESTART IV
 K GMRXX S GMRXX=0,GDR=1 D NOW^%DTC S GNOW=%,X1=%,X2=-1 D C^%DTC S GDT(1)=X,GDT=9999999-X D SEARCH Q:GMROUT
 I GMRXX=0 D
 .W !!,"An IV can't be restarted for one or more of the following reasons:",!,?5,"1. The specific item has been running over 24 hrs.",!,?5,"2. The solution has been discontinued for over 8 hrs.",!,?5,"3. The remaining solution is under 5 mls."
 .W !,?5,"4. The reason for discontinuation is 'INFUSED'.",!! S GMROUT=1
 Q:GMROUT  D WRITE
 K GTIME Q
SEARCH ;SEARCH THE IV STARTED WITHIN 24 HRS DC'D WITHIN 8 HRS
 I '$D(^GMR(126,DFN,"IV","C")) W !!,"There are no IVs in the database for this patient!",! S GMROUT=1 Q
 S GIVDT=0 F  S GIVDT=$O(^GMR(126,DFN,"IV","C",GIVDT)) Q:GIVDT'>0  Q:GIVDT>GDT  D SCREEN
 Q
SCREEN S GDA=0 F  S GDA=$O(^GMR(126,DFN,"IV","C",GIVDT,GDA)) Q:GDA'>0  D SAVE
 Q
SAVE S GDATA=^GMR(126,DFN,"IV",GDA,0),GDC=+$P(GDATA,"^",9) Q:(GNOW-GDC)>8!(GDC'>0)  Q:$P($G(^GMR(126,DFN,"IV",GDA,1)),"^")>0
 S GDA(1)=0,GDA(1)=$S('$D(^GMR(126,DFN,"IV",GDA,"IN",0)):0,1:+$P(^(0),"^",3)),GVOL=$S(GDA(1)'>0:0,'$D(^GMR(126,DFN,"IV",GDA,"IN",GDA(1),0)):0,1:$P(^(0),"^",2)) I '(GVOL["*"!(GVOL>4)) Q
 S GREASON=$P(GDATA,"^",11) Q:GREASON["INFUSED"!(GREASON["Infused")!(GREASON["infused")  S GMRXX=GMRXX+1,GMRXX(GMRXX)=$P(GDATA,"^",1,5)_"^"_$P(GDATA,"^",12)_"^"_GDC_"^"_GREASON_"^"_GVOL_"^"_GDA Q
WRITE Q:GMROUT  W !!,"Select one of the following IV(s) to restart",! F I=1:1:GMRXX W !,I_". " D WRT
 W !!,"Please enter your choice: " S I="" R I:DTIME I '$T!(I["^")!(I="") S GMROUT=1 Q
 I I=""!(I["?")!(I'?.N) W @IOF,!!,"Enter the number of the IV solution you want to restart",! G WRITE
 S I=+I
YN1 D SET
 I GMRXX>0 S GDR=2 W @IOF G WRITE
 K GCATH,GDC,GHLOC,GMRXX,GMRYY,II,I,GNOW,GREASON,GSDC,GVOL,GX Q
WRT W $P(GMRXX(I),"^",3)_" ("_$P(GMRXX(I),"^",4)_") "_$P(GMRXX(I),"^",5)_" ml "_$S($P(GMRXX(I),"^",6)'="":$P(GMRXX(I),"^",6)_" ml/hr ",1:"") S Y=$P(GMRXX(I),"^") X ^DD("DD") W !,?4,"started on "_$P(Y,":",1,2)
 S (GTIME,Y)=$P(GMRXX(I),"^",7) X ^DD("DD") W !,?4,"DC'd on "_$P(Y,":",1,2)_"    "_$P(GMRXX(I),"^",9)_" ml left",!,?4,"DC reason: "_$P(GMRXX(I),"^",8) Q
SET S GDATA=GMRXX(+I),GHLOC=GMRHLOC,GMRZ=$P(GDATA,"^",3),(GMRZ(1),GMRVTYP)=$P(GDATA,"^",4),GMRZ(2)=$P(GDATA,"^",9),GMRZ(3)=$P(GDATA,"^",6),GSAVE(1)=+$P(GDATA,"^",10) K GMRXX(+I) S GMRXX=GMRXX-1
 D:GMRXX>0 RESET S:GMRZ(2)'>0 GMRZ(2)="" S GSAVE=GMRZ(2) S:GSAVE="" GSAVE=+$P(GDATA,"^",5)
ASK S GMRX="" D ASK1^GMRYUT6 Q:GMROUT  G:GMRX="N" ASK
ASK2 I GDR=1 D DT^GMRYUT3 S:GX="" GMROUT=1 Q:GMROUT  W:GX<GTIME !!,"Start date/time comes before the DC'd date/time.",! G:GX<GTIME ASK2 D
 . S GMROUT(1)=0,GMROUT(1)=$$ADM^GMRYUT12(.GMROUT,DFN,GX) Q:GMROUT
 . S (GSITE,GCATH,GCATH(1))="" D SITECATH^GMRYSTCA
 . Q
 Q:GMROUT  S GSAVE=GMRVTYP K DD S X=+GX,DLAYGO=126.03,DA(1)=DFN,DIC="^GMR(126,"_DA(1)_",""IV"",",DIC(0)="ML" D WAIT^GMRYUT0 Q:GMROUT  D FILE^DICN L -^GMR(126,DFN) K DIC,DLAYGO,DD
 I Y'>0 S GMROUT=1 Q
 S DA=+Y,GMRVTYP=GSAVE
 S DIE="^GMR(126,"_DA(1)_",""IV"",",DR="2///^S X=GMRZ;3///^S X=GMRZ(1);4///^S X=GMRZ(2);11///^S X=GMRZ(3);6///^S X=""`""_DUZ;7///^S X=""`""_GHLOC;"_$S(GDR=1:"1///^S X=GSITE;5///^S X=GCATH;17///^S X=GCATH(1)",GDR=2:"1///^S X=GSITE",1:"")
 D WAIT^GMRYUT0 I GMROUT K DIE,DR Q
 D ^DIE L -^GMR(126,DFN) K DIE,DR I $P(^GMR(126,DA(1),"IV",DA,0),"^",2)=""!($P(^(0),"^",3)="")!($P(^(0),"^",5)="") W !!,"Undefined value in the record.",!! D DELIV^GMRYED2 S GMROUT=1 Q
 S $P(^GMR(126,DFN,"IV",GSAVE(1),1),"^")=GX,$P(^(1),"^",2)=DA,GLINE=DA D RESTART^GMRYED2 Q
RESET ;
 K GMRYY S (GMRYY,II)=0 F  S II=$O(GMRXX(II)) Q:II'>0  S GMRYY=GMRYY+1,GMRYY(GMRYY)=GMRXX(II)
 K GMRXX S GMRXX=0 F II=1:1:GMRYY S GMRXX(II)=GMRYY(II),GMRXX=GMRXX+1
