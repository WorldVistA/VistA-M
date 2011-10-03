SDNDIS ;ALB/TMP - CHECK FOR AND DISCHARGE PATIENTS EXCEEDING MAX # OF NO SHOWS ; 8-14-86
 ;;5.3;Scheduling;;Aug 13, 1993
DIS W !!,".. Searching for patients who have exceeded the maximum # of no-shows allowed ..",! K SDCTR
 K FSW F A=0:0 S A=$N(^UTILITY($J,"CL",A)) Q:A'>0  F B=0:0 S B=$N(^UTILITY($J,"CL",A,B)) Q:B'>0  I $D(^DPT(A,0)) F A0=0:0 S A0=$N(^UTILITY($J,"CL",A,B,A0)),GDATE=A0,SC=B Q:A0<0  K A1 D NUM
 Q:'$D(SDCTR)  F I=0:0 S I=$N(SDCTR(I)) Q:I'>0  W !!,$S($D(^SC(I,0)):$P(^(0),"^",1),1:" "),?35,": ",SDCTR(I)," patient",$S(SDCTR(I)>1:"s ",1:" "),"exceeded max # of NO SHOWS"
 W !!,"No patients discharged ",!!,"The records of the patients who have exceeded the maximum NO SHOW limit",!,"will need to be reviewed for possible discharge from the specified clinics !"
 W ! K SDCTR Q
NUM D DISCH S (SDCONS,POP)=0,SDCMAX=$S($D(^SC(SC,"SDP")):+^("SDP"),1:"") Q:SDCMAX']""
 I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
 I $D(A1),A1 F A2=A1:0 S A2=$N(^DPT(+A,"S",A2)) Q:A2'>0!((A2\1)>DT)!(SDCONS>SDCMAX)  I $D(^(+A2,0)),+^(0)=SC S SDZSC=^(0),SDCONS=$S($P(SDZSC,U,2)["N":SDCONS+1,1:0)
 I SDCONS>SDCMAX S SDC=SC,SDCTR(SDC)=$S($D(SDCTR(SDC)):SDCTR(SDC)+1,1:1)
 I  W *7,!,"Please note that this patient -- ",$P($P(^DPT(+A,0),U),",",2)," ",$P($P(^(0),U),",",1)," --SSN ",$P(^(0),U,9),!,"has exceeded the maximum # of NO SHOWS",!,"in the following clinic : ",$P(^SC(SDC,0),U,1),!! H 5
 Q
DISCH S SDC=SC I $D(^SC(SC,"SL")),+$P(^("SL"),"^",5) S SDC=$P(^("SL"),"^",5)
 K SDIS F I=0:0 S I=$N(^DPT(+A,"DE","B",SDC,I)) Q:I'>0!($D(SDIS))  I $D(^DPT(+A,"DE",I)) F I1=0:0 S I1=$N(^DPT(+A,"DE",I,1,I1)) Q:I1'>0  S SDIS=$S($P(^(I1,0),"^",3)']"":1,1:0) I SDIS,$P(^(0),U) S A1=$P(^(0),U) Q
 Q
