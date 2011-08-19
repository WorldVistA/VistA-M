SDCLAS0 ;ALB/TMP - Clinic Assignment List Select and Extract ;  22 MAR 1985
 ;;5.3;Scheduling;**32,115**;Aug 13, 1993
SELECT W !!,"Do you want the report for active patients only" S %=1 D YN^DICN I %<0 G OUT
 I '% W !,"Respond (Y)es for a report of only patients with future appointments",!,"Respond (N)o for a report which also includes patients who are enrolled,",!,"  but have no future appointments" G SELECT
 S SDFAST='(%-1)
SELECT1 W !!,"Sort by (C)linic or (S)top Code?: " R X:DTIME G:"^"[X OUT D:X?.E1"?" H1 S X=$E(X,1),X=$$UP^XLFSTR(X) G:"SC"'[X SELECT1 S SDSRT=X,SDSAV="" G:SDSRT="S" SEL1A
SEL1 W !!,"Select Clinic: ",$S(SDSAV']"":"ALL// ",1:"") R X:DTIME Q:X["^"  G:'$T OUT G:X["?" H2 I X="",SDSAV']"" S X="ALL"
 S X=$$UP^XLFSTR(X)
 I X="" S:$P(SDSAV,",",2)']""&($P(SDSAV,",",1)'["--") SDIFN=+SDSAV,SDSAV="" Q
 I X="ALL" S SDSAV="",SDIFN="ALL" Q
 I X["--" S SDSAV=SDSAV_X_"," G SEL1
LOOK D ^DIC G:Y'>0 SEL1 K DIC("S") S SDSAV=SDSAV_+Y_"," G SEL1
SEL1A K DIC("S") W !!,"Select Stop Code: ALL// " R X:DTIME Q:X["^"  G:'$T OUT G:X["?" H3 I X="" S SDIFN="ALL" Q
LOOK1 S DIC="^DIC(40.7,",DIC(0)="EFMQ" D ^DIC G:Y'>0 SEL1A S SDIFN=+Y
 Q
OUT S X="^" Q
EXT S (SDLAST,SDNEXT)="",U="^"
 F I=0:0 S I=$O(^DPT(DFN,"S",I)) Q:'I  I $P(^DPT(DFN,"S",I,0),U,2)'["C",$P(^(0),U,2)'["N",+^DPT(DFN,"S",I,0)=SDIFN S:I'>SDTS SDLAST=I I I>SDTS S SDNEXT=I Q
 S ^UTILITY($J,"S",$E($P(^SC(SDIFN,0),U),1,30),SDIFN,$E($P(Y(0),U),1,20),DFN)=SDLAST_U_SDNEXT_U_$P(Y(1),U)_U_SDENR_U_SDACT_U_$P(Y(1),U,2)
 I SDACT S ^UTILITY($J,"SDACT",SDIFN)=^UTILITY($J,"SDACT",SDIFN)+1
 I 'SDACT S ^UTILITY($J,"SDENR",SDIFN)=^UTILITY($J,"SDENR",SDIFN)+1
 K SDACT,Y Q
AEB F A=0:0 S A=$O(^DPT("AEB1",SDIFN,A)) Q:'A!(A>(SDTS_.9))  F A1=0:0 S A1=$O(^DPT("AEB1",SDIFN,A,A1)) Q:'A1  I '$D(^UTILITY($J,"PAT",SDIFN,A1)),$D(^DPT(A1,0)),$S('$D(^(.35)):1,'^(.35):1,1:0) S (SDENR,SDACT)=0 D AEB1
 Q
AEB1 F A2=0:0 S A2=$O(^DPT("AEB1",SDIFN,A,A1,A2)) Q:'A2!($D(^UTILITY($J,"PAT",A1,SDIFN)))  F A3=0:0 S A3=$O(^DPT("AEB1",SDIFN,A,A1,A2,A3)) Q:'A3  D AEB2
 Q
AEB2 I $D(^DPT(A1,"DE",A2,1,A3,0)),+^(0)<(SDTS_.9) S X=+$P(^(0),"^",3) I X'<SDTS!('X) S SDACT=0,SDENR=1 D T2
 Q
H1 W !!,"Enter C to select and sort by clinic or S to sort and select by a stop code" Q
H2 W !!,"Valid responses:",!,?5,"A clinic name or abbreviation",!,?5,"A range of clinics separated by two dashes",!,?10,"(example: GEN MED--GEN MEDZ will report all clinics whose names start GEN MED)"
 W !,?5,"'ALL' to report all clinics",!,?5,"Hit return when done selecting clinics" G LOOK
H3 W !!,"Enter a stop code or 'All' for all stop codes" G LOOK1
T2 S DFN=A1,Y(1)=^DPT(A1,"DE",A2,1,A3,0),Y(0)=^DPT(A1,0)
 D SET1^SDCLAS I '$D(^UTILITY($J,"PAT"," ",DFN)) D MT^SDCLAS S ^UTILITY($J,"PAT"," ",DFN)=$P(Y(0),"^",9)_"^"_SDELIG_"^"_SDZIP_"^"_$P(Y(0),"^",3)_"^"_SDMT
 D EXT Q
SPLIT S SD01=$P(SDZ,"--",1),SD02=$P(SDZ,"--",2) I SD01?1N.N G S1
 I $D(^SC("B",SD01)) S X=$O(^SC("B",SD01,0)) S:X>0 SDZ(X)=""
 S SDI=SD01 F II=0:0 S SDI=$O(^SC("B",SDI)) Q:SDI]SD02!(SDI="")  S X=$O(^SC("B",SDI,0)) S:X>0 SDZ(X)=""
 K SD01,SD02,II,X,SDI Q
S1 F II=SD01-1:0 S II=$O(^SC(II)) Q:'II!(II>SD02)  S SDZ(II)=""
 K SD01,SD02,II Q
