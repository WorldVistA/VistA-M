SDCLAS ;ALB/TMP,MRY - Clinic Assignment List Extract ;12/23/92  11:42
 ;;5.3;Scheduling;**63,243,517,523**;Aug 13, 1993;Build 6
 ;SD/517 CORRECTED ALL $NEXT FUNCTIONAL COMMANDS
 S DIV="" D DIV^SDUTL I $T D CALST^SDDIV Q:Y<0
 S:'$D(DTIME) DTIME=300 I '$D(DT) D DT^SDUTL
 S SDIFN="",SDI=0,DIC="^SC(",DIC(0)="EFMQ",DIC("S")="I $P(^(0),U,3)=""C"",'$G(^(""OOS"")),$S(DIV="""":1,$P(^(0),U,15)=DIV:1,1:0)" D SELECT^SDCLAS0 K DIC Q:X["^"
 S Y=DT D DTS^SDUTL S SDTS=Y
OPT2 W !!,"Select 'As of' Date: ",SDTS," // " R X:DTIME Q:X["^"  I X']"" S SDTS=DT G OVR
 S %DT(0)=-DT,%DT="EPX" D ^%DT K %DT
 I Y'>0 W !,*7,"A date must be entered here to get a 'snapshot' of the clinic's enrollment as of",!,"  this date.  Date can not be in future." G OPT2
 S SDTS=+Y
OVR I SDSRT="C",SDSAV']"",SDIFN'="ALL",$S('$D(^SC(SDIFN,"I")):0,+^("I")=0:0,+^("I")>SDTS:0,+$P(^("I"),"^",2)'>SDTS&(+$P(^("I"),"^",2)'=0):0,1:1) W !,"Clinic ",$S(SDTS=DT:"is",1:"was")," inactive" W:SDTS<DT " on date selected" G END^SDCLAS1
 W !!,*7,"This needs to be printed at 132 columns"
 S PGM="START^SDCLAS",VAR="SDIFN^SDSRT^DIV^SDTS^SDSAV^SDFAST",VAL=SDIFN_"^"_SDSRT_"^"_DIV_"^"_SDTS_"^"_SDSAV_"^"_SDFAST D ZIS^DGUTQ Q:POP
START K ^UTILITY($J) S SDSTOP=$S(SDSRT="S":SDIFN,1:""),SD1="",U="^" U IO G:SDIFN="ALL"!(SDSRT="S")!(SDSAV]"") ALL
ONE S ONE=1 D INIT F SDAPPT=SDTS:0 S SDAPPT=$O(^SC(SDIFN,"S",SDAPPT)) Q:SDAPPT'>0  D PT
 D:'SDFAST AEB^SDCLAS0 G ^SDCLAS1
ALL S ONE=0 I SDSAV']"" S SDIFN=0 F  S SDIFN=$O(^SC(SDIFN)) Q:'SDIFN  I $P(^(SDIFN,0),"^",3)="C" D APPT
 I SDSAV]"" D APART S SDIFN=0 F  S SDIFN=$O(SDZ(SDIFN)) Q:'SDIFN  I $D(^SC(SDIFN,0)),$P(^(0),"^",3)="C" D APPT
 G ^SDCLAS1
APPT D CHECK I 'POP K ^UTILITY($J,"PAT",SDIFN) D INIT F SDAPPT=SDTS:0 S SDAPPT=$O(^SC(SDIFN,"S",SDAPPT)) D:SDAPPT>0 PT I SDAPPT'>0 D:'SDFAST AEB^SDCLAS0 Q
 Q
PT S SD=0 F  S SD=$O(^SC(SDIFN,"S",SDAPPT,1,SD)) Q:'SD  Q:'$D(^(SD,0))  S DFN=+^(0) D PT1
 Q
PT1 I '$D(^UTILITY($J,"PAT",SDIFN,DFN)),$D(^DPT(DFN,0)),$D(^("S",SDAPPT,0)),$P(^(0),"^",2)=""!($P(^(0),"^",2)="I"),$S('$D(^DPT(DFN,.35)):1,'^(.35):1,1:0) D S,EXT^SDCLAS0
 Q
S S Y(0)=^DPT(DFN,0),SDACT=1,SDENR=0 D SET1
 S I=0 F  S I=$O(^DPT(DFN,"DE","B",SDIFN,I)) Q:'I  I $D(^DPT(DFN,"DE",I,0)) D EDENR Q:SDENR
 S ^UTILITY($J,"PAT",SDIFN,DFN)="" S:'$D(Y(1))!('SDENR) Y(1)="" I '$D(^UTILITY($J,"PAT"," ",DFN)) D MT S ^UTILITY($J,"PAT"," ",DFN)=$P(Y(0),"^",9)_"^"_SDELIG_"^"_SDZIP_"^"_$P(Y(0),"^",3)_U_SDMT
 Q
EDENR K Y(1) S I1=0 F  S I1=$O(^DPT(DFN,"DE",I,1,I1)) Q:'I1  S X=$P(^(I1,0),"^"),X(1)=$P(^(0),"^",3) Q:X>SDTS  S:'X(1)!(X(1)>SDTS) Y(1)=^(0),SDENR=1 Q:SDENR
 Q
SET1 S SDELIG=$S($D(^DPT(DFN,.36)):$P(^(.36),"^",1),1:""),SDELIG=$S($D(^DIC(8,+SDELIG,0)):SDELIG,1:""),SDELIG(1)=$S(SDELIG]"":$P(^(0),"^",5),1:""),SDZIP=$S($D(^DPT(DFN,.11)):$P(^(.11),"^",6),1:"")
 Q
MT ;
 S SDMT="*" Q:SDELIG(1)']""  I SDELIG(1)="N" S SDMT="N" Q
 S SDMT=$$LST^DGMTU(DFN) I SDMT']"" S SDMT=$S(SDELIG'=6:"A",1:"X") Q
 S:$P(SDMT,U,2)>SDTS SDMT=$$LST^DGMTU(DFN,SDTS)
 I $P(SDMT,U,4)="P" S SDMT=$$PA^DGMTUTL($P(SDMT,U)),SDMT=$S('$D(SDMT):"U",SDMT="MT":"C",SDMT="GMT":"G",1:"U")
 E  S SDMT=$P(SDMT,U,4)
 I SDMT="" S SDMT="X"
 I SDMT="P" S SDMT="C"
 I SDMT="R" S SDMT="U"
 I SDMT="N" S SDMT="A"
 D DOM^SDOPC4(DFN,SDTS_.9,.SDMT) I SDMT="X0" S SDMT="X"
 K SDMT1 Q
CHECK S POP=0 I SDSRT="S",SDSTOP'="ALL",$P(^SC(SDIFN,0),"^",7)'=SDSTOP S POP=1 Q
 I $S(DIV="":1,$P(^SC(SDIFN,0),"^",15)=DIV:1,1:0),$S('$D(^SC(SDIFN,"I")):1,+^("I")=0:1,+^("I")>DT:1,+$P(^("I"),"^",2)'>DT&(+$P(^("I"),"^",2)'=0):1,1:0) Q
 S POP=1 Q
APART S SDZ="" F I=1:1 Q:$P(SDSAV,",",I)']""  S SDZ=$P(SDSAV,",",I) D:SDZ["--" SPLIT^SDCLAS0 I SDZ'["--" S:'$D(SDZ(+SDZ)) SDZ(+SDZ)=""
 Q
INIT F I1="SDENR","SDACT" S I2="^UTILITY("_$J_","""_I1_""","_SDIFN_")",@I2=0
 Q
