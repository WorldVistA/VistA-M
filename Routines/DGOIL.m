DGOIL ;ALB/AAS - INPATIENT LIST ; 28-SEPT-90
 ;;5.3;Registration;**162,279,498**;Aug 13, 1993
 ;
% ; -- start here
 D HOME^%ZIS W @IOF
 W !!,?32,"Inpatient List",!!!
 ;
WARD ; -- by ward or by name
 S DIR("B")="WARD",DIR(0)="S^1:WARD;0:NAME",DIR("A")="SORT BY" D ^DIR K DIR G:$D(DIRUT) END1 S DGWARD=+Y
 ;
FIRST ; -- get range of the output
 S DIR("B")="FIRST",DIR(0)="F^1:30",DIR("A")="START WITH "_$S(DGWARD:"WARD LOCATION",1:"NAME")
 S DIR("?",1)="Enter all or part of a ward name.  If the FROM and TO wards are pure"
 S DIR("?")="numbers (no alphas), no wards with an alpha suffix will appear on the sort."
 D ^DIR K DIR G:$D(DIRUT) END1
 S DGBEG=$$CAP(Y)
 S:DGBEG="FIRST" DGBEG=""
 ;
 S DIR("B")="LAST",DIR(0)="F^1:30",DIR("A")="GO TO "_$S(DGWARD:"WARD LOCATION",1:"NAME") D ^DIR K DIR G:$D(DIRUT) END1
 S DGEND=$$CAP(Y)
 S:DGEND="LAST" DGEND="ZZZZZZZ"
 ;
 I DGBEG'=DGEND,DGBEG]DGEND W !!,"End must be after beginning",! G FIRST
 ; Ask Division (sets VAUTD)
 I '$$ASKDIV^DGUTL() G END1
 ;
BRKOUT ; -- with ward breakout
 W !! S DIR("B")="YES",DIR(0)="Y",DIR("A")="PRINT WITH WARD BREAKOUT" D ^DIR K DIR G:$D(DIRUT) END1 S DGBRK=+Y
 ;
DRG ; -- with DGR breakout
 S DGDRG=0 I DGBRK S DIR("B")="YES",DIR(0)="Y",DIR("A")="PRINT WITH DRG BREAKOUT" D ^DIR G:$D(DIRUT) END1 S DGDRG=+Y
 ;
DEV W:DGDRG !,*7,"This output requires 132 column output"
 S DGPGM="DQ^DGOIL",DGVAR="DGWARD^DGBEG^DGEND^DGBRK^DGDRG^VAUTD#"
 D ZIS^DGUTQ G:POP END U IO
 ;
DQ ;  -- entry point to start processing
 K ^UTILITY($J)
 S (POP,DGPG)=0 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ S DGDATE=Y
 S AFFIL=$S($D(^DG(43,1,"GL")):$P(^("GL"),"^",4),1:0)
 S:DGBEG]""&(+DGBEG'=DGBEG) DGBEG=$E(DGBEG,1,($L(DGBEG)-1))_$C($A($E(DGBEG,$L(DGBEG)))-1)_"~"
 S:DGBEG]""&(+DGBEG=DGBEG) DGBEG=DGBEG-.0000001
 ;
SORT ;  -- sort inpatients, store in ^utility($j,
 S W=$S(DGWARD:DGBEG,1:"") ;if sorting by ward start with DGBEG
 F I=0:0 Q:W=DGEND  S W=$O(^DPT("CN",W)) Q:W']""!(DGWARD&(W]DGEND))  S DFN="" F J=0:0 S DFN=$O(^DPT("CN",W,DFN)) Q:'DFN  S DGPM=^(DFN) D
 .I 'VAUTD S DGWD=$O(^DIC(42,"B",W,0)) Q:'DGWD  S DGWD=$S('$D(^DIC(42,DGWD,0)):0,+$P(^(0),U,11):$P(^(0),U,11),1:0) Q:'$D(VAUTD(DGWD))
 .D SETU
 ;
 D HDR1 I '$D(^UTILITY($J)) W !,"No Matches Found" G END
BYWARD ; -- if by ward get entries to print
 I DGWARD S W="" F I=0:0 S W=$O(^UTILITY($J,W)) Q:W']""!($D(DUOUT))  D HDR:$D(N) S N="" F J=0:0 S N=$O(^UTILITY($J,W,N)) Q:N']""!($D(DUOUT))  S DFN="" F K=0:0 S DFN=$O(^UTILITY($J,W,N,DFN)) Q:'DFN!($D(DUOUT))  S DGPM=^(DFN) D ^DGOIL1
 ;
BYNAME ;  -- if by name get entries to print
 I 'DGWARD S N=DGBEG F I=0:0 S N=$O(^UTILITY($J,N)) Q:N']""!(N]DGEND)!($D(DUOUT))  S W="" F J=0:0 S W=$O(^UTILITY($J,N,W)) Q:W']""!($D(DUOUT))  S DFN="" F K=0:0 S DFN=$O(^UTILITY($J,N,W,DFN)) Q:'DFN!($D(DUOUT))  S DGPM=^(DFN) D ^DGOIL1
 G END
 ;
SETU ;  -- set utility($j,$s(sort by ward:ward,1:name),$s(sort by ward:name,1:ward),dfn)=pointer to dgpm
 Q:'$D(^DPT(DFN,0))
 S NAME=$P(^DPT(DFN,0),"^")
 S ^UTILITY($J,$S(DGWARD:W,1:NAME),$S(DGWARD:NAME,1:W),DFN)=DGPM
 Q
 ;
HDR D LEGEND Q:$D(DUOUT)
HDR1 S DGPG=DGPG+1 W @IOF,"INPATIENT LIST",?(IOM-29) W DGDATE,"  PAGE: ",DGPG
 W !,"Patient name",?19,"PT ID",?27,"Admit/Tran Ward",?51,"LOS   AA Pass   UA ASIH" I DGDRG W ?76,"DRG",?83,"Avg",?88,$S('AFFIL:"non-",AFFIL=2:"Int-",1:"Affil"),?96,"L/H",?104,"local",?112,"Days to",?120,"% in ",?128,"flag"
 W !?30,"date",?38,"location" I DGDRG W ?83,"LOS",?88,$S(AFFIL'=1:"Affil",1:""),?96,"Trim",?104,"L/H",?112,"Trim",?120,"Trim"
 I DGDRG W !?104,"Trim",?112,"Nat/Loc",?120,"Nat/Loc"
 W ! F I=1:1:IOM W "="
 I $D(^UTILITY($J)),DGWARD W !,?8,"WARD LOCATION: ",$S('$D(N):$O(^UTILITY($J,"")),$D(W):W,1:"") D
 .S I=0 F  S I=$O(VAUTD(I)) Q:'I  W ?45,"DIVISION(S): ",VAUTD(I),!
 Q
END K ^UTILITY($J) D:'$D(DUOUT)&('POP)&('$D(DIRUT)) LEGEND Q:$D(ZTQUEUED)
END1 K %,I,J,K,L,N,M,W,NAME,X,X1,X2,X3,Y,Z,AFFIL,DFN,VA,DGBEG,DGBRK,DGDATE,DGDRG,DGEND,DGPM,DGPGM,DGVAR,DGWARD,DIR,DUOUT,DGOUT,DGL,DRG,DRGCAL,DGPG,DIRUT,VAIN,DGASIH,ADM,DIS,VAUTD
 D ^%ZISC Q
 ;
LEGEND ;  -legend for flag column
 F L=1:1 Q:IOSL<($Y+6)  W !
 W !,"'+' Before the Patient name indicates patient is currently ASIH, '!' Indicates patient chose not to be in Facility Directory"
 W:DGDRG&($E(IOST,1,2)'="C-") !,"LEGEND:  '####' - Stay exceeds high trim,  '**' - Stay exceeds 69% of high trim,  '@' Stay exceeds 49% of high trim"
 I $E(IOST,1,2)="C-" R !,"Press '^' to QUIT or Return to Continue",Z:DTIME I '$T!(Z["^") S DUOUT=1 Q
 Q
CAP(X)  ; -convert lower case input to upper case.
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
