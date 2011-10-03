GMRYED6 ;HIRMFO/YH-D/C IV AND IV SITE MAINTENANCE ;9/10/92
 ;;4.0;Intake/Output;;Apr 25, 1997
ADDSOL1 S DA=DFN,(GMROUT,GMRDC)=0 D LISTIV^GMRYUT0,SEL^GMRYUT13 I GMROUT D Q4 Q
 Q:$G(GMRZ(1))=""  S GCATH(2)=$S($D(^GMRD(126.74,"B",GCATH)):$O(^GMRD(126.74,"B",GCATH,0)),1:"")
REMOVE S GMRVTYP=GMRZ(1) D DC I GMROUT D Q4 Q
 S GREC=DA,GMRDEL="",(GX,GDCDT)=$P(^GMR(126,DA(1),"IV",DA,0),"^",9),GDCREAS=$P(^(0),"^",11),GLOC=$P(^(0),"^",2) G:GDCDT="" Q4  G:$P(^(0),"^",2)="" Q4 I '$D(^GMR(126,DA(1),"IV",DA,"IN",0)) S GLABEL="",GHLOC=GMRHLOC D DC^GMRYUT0 G ADD
 I '$D(^GMR(126,DA(1),"IV",DA,"IN","C")) S GLABEL="",GHLOC=GMRHLOC D DC^GMRYUT0 G ADD
 S GDT=$O(^GMR(126,DA(1),"IV",DA,"IN","C",0)) I GDT'>0 S GLABEL="",GHLOC=GMRHLOC D DC^GMRYUT0 G ADD
 S GGDA=$O(^GMR(126,DA(1),"IV",DA,"IN","C",GDT,0)) G:GGDA'>0 ADD W !,"Last reading for AMOUNT LEFT is "_$P(^GMR(126,DA(1),"IV",DA,"IN",GGDA,0),"^",2)_" mls"
 I $P(^GMR(126,DA(1),"IV",DA,"IN",GGDA,0),"^",2)'>0 D IVINTK^GMRYUT8 G:GMROUT ADD W !,"Total amount absorbed for this solution: "_$S($P(^GMR(126,DA(1),"IV",DA,"IN",GGDA,0),"^",2)["*":"UNKNOWN",1:($P(GDATA,"^",5)-GTOTAL)_" mls"),! G ADD
NEXT ;
 K DD S DA(2)=DA(1),DA(1)=DA,(GX,X)=GDCDT,GMRDEL="",DIC="^GMR(126,"_DA(2)_",""IV"","_DA(1)_",""IN"",",DIC(0)="ML",DLAYGO=126.313 D WAIT^GMRYUT0 G:GMROUT Q4 D FILE^DICN L -^GMR(126,DFN) K DR,DIC,DLAYGO,DD S DA=+Y I Y'>0 G Q4
 S GHLOC=GMRHLOC,GLABEL="" D IV^GMRYUT8 G:'$D(GTOTAL) ADD W !,"Total amount absorbed for this solution: ",($P(GDATA,"^",5)-GTOTAL)_" mls",!
ADD I GMROUT D CANCEL G Q4
 I GOPT["DCIV",$D(^GMR(126,DFN,"IV",G(1),"IN",0)) S I=+$P(^(0),"^",3) S GST(GSITE,G,G(1))=GMRVTYP_"^"_$S($D(^GMR(126,DFN,"IV",G(1),"IN",I,0)):$P(^(0),"^",2),1:"")
ASK Q:GOPT["DCIV"  S GADD="",GMROUT=0 W !,"Do you wish to ",!,?5,"Convert to lock/port",!,?5,"Hang a new solution",!,"Please enter the FIRST character for your selection or press return to continue: "
 R GADD:DTIME I '$T!(GADD["^") D CANCEL S GMROUT=1 G Q4
 I GADD["?" W !,"The current solution has been discontinued.",!,"Do you want to hang a new bottle or convert the line to a lock/port",! G ASK
 I GADD="" S GSAVE=GSITE D SELSITE^GMRYMNT S GSITE=GSAVE
 I GADD="",+$G(GCT(GLOC))>0 W !,"The solution has been DC'ed" G Q4
 I GADD="",+$G(GCT(GLOC))=0 S %=1 W !,"The IV site has no more solutions hanging. Do you want to DC IV SITE" D YN^DICN G:%'=1 ASK S GSAVE=GOPT,GOPT="DCIV",GX=GDCDT,DA(1)=DFN,DA=$O(^GMR(126,DFN,"IVM","B",GSITE,0)) D EN4^GMRYUT5 S GOPT=GSAVE Q
 S GADD=$E(GADD),GADD=$S("Cc"[GADD:"C","Hh"[GADD:"H",1:"") G:GADD="" ASK
 W !,$S(GADD["C":"Convert to lock/port",GADD["D":"DC the IV",GADD["H":"Hang new solution",1:"") ;S %=1 D YN^DICN G:%'=1 ASK
ASK1 I GADD["H" S DA=DFN,GADD="Y",GX=GDCDT,GMRDEL="",GDR=0 D SOLTYPE^GMRYUT7 G:GMROUT ASK D ADDIV^GMRYED2
 I GADD["C" S DA=DFN,GADD="Y",GX=GDCDT,GMRDEL="",GDR=0,GMRVTYP="L",GMRZ(1)="L",GMRZ(2)="*",GMRZ(3)="" D LOCK^GMRYED5 G:GMROUT ASK S GMRZ="LOCK/PORT" D LOCK^GMRYUT8
 D:GMROUT CANCEL D ASK1^GMRYED5 G Q4
STCARE G:GSITE="" Q4 S GX=$S(GDCIV=6:GX,1:GDCDT),DA(1)=DFN,DA=$O(^GMR(126,DA(1),"IVM","B",GSITE,0)) D EN4^GMRYUT5
Q4 Q:GDCIV>1&(GDCIV<5)
 D KILLV^GMRYUT0 K GLOC,GSTAR,GCATH,GMRX,GMRY,GADD,GDATA,GHLOC,GMRZ,GTEYPE,GTOTAL,GMRDEL,GNN,GTXT,X,Y,GDC,GMRDC,GMRAMT,GMRQUAL,GX,GLABEL,GTYPE Q
 ;
DC Q:$G(GMRZ(1))=""  S:$D(GDCDA) GDCDA=DA S GDATA=^GMR(126,DA(1),"IV",DA,0),GDT=$P(GDATA,"^"),GTYPE=$P(GDATA,"^",4) W !!,"Discontinued ",?5,$P(GDATA,"^",3)_"  "_$S(GTYPE'["L":$P(GDATA,"^",5)_" mls ("_GTYPE_") ",1:"")_$P(GDATA,"^",2)
 S Y=GDT X ^DD("DD") W "   started on "_$P(Y,":",1,2),! S GSITE=$P(GDATA,"^",2) D:+$G(GDCIV)'=1 DCREASON^GMRYUT11 Q:GMROUT
 S DIE="^GMR(126,"_DA(1)_",""IV"",",DR=$S(GDCIV=1:"8///^S X=GDCDT;",1:"8//NOW;")_"9///^S X=""`""_DUZ;10///^S X=GDCREAS" D WAIT^GMRYUT0 I GMROUT K DIE,DR Q
 D ^DIE L -^GMR(126,DFN) K DIE,DR S GREC=DA
 I $P(^GMR(126,DA(1),"IV",DA,0),"^",9)="" S GMROUT=1,$P(^(0),"^",10)="",$P(^(0),"^",11)=""
 Q
CANCEL ;
 S $P(^GMR(126,DFN,"IV",GREC,0),"^",9)="",$P(^(0),"^",10)="",$P(^(0),"^",11)="",GMROUT=1 W !,"DC cancelled!!!",! Q:'$D(GREC(1))  Q:GREC(1)=0
 S DA(2)=DFN,DA(1)=GREC,DA=GREC(1),DIK="^GMR(126,"_DA(2)_",""IV"","_DA(1)_",""IN"",",(X,GX)=GDCDT D ^DIK K DIK W !,"The IV intake record has been deleted",!! Q
