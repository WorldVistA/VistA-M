SDASO ;MAN/GRR - APPEND TESTS TO PENDING APPOINTMENT ; 22 DEC 83  11:02 am
 ;;5.3;Scheduling;;Aug 13, 1993
 S:'$D(DTIME) DTIME=300 D:'$D(DT) DT^SDUTL S HDT=DT,APL=""
RD S DIC="^DPT(",DIC(0)="AEQM",CNT=0 D ^DIC G:"^"[X END I Y<0 W !,*7,*7,"PATIENT NOT FOUND",*7,*7 G RD
 S DFN=+Y,NAME=$P(Y,"^",2) W ! I $N(^DPT(DFN,"S",HDT))'>0 G NO
 S NDT=HDT,L=0 F J=1:1 S NDT=$N(^DPT(DFN,"S",NDT)) Q:NDT'>0  I $S($P(^(NDT,0),"^",2)']"":1,$P(^(0),"^",2)["I":1,1:0) D CHKSO S SC=+^(0),L=L+1 D FLEN S Z(L)=NDT_"^"_SC_"^"_APL_"^"_COMMENT
 G:L'>0 NO F ZZ=1:1:L W !!,ZZ,") " S Y=$P($P(Z(ZZ),"^",1),".",1) D DT^SDM0 S X=$P(Z(ZZ),"^",1) X ^DD("FUNC",2,1) W " ",$J(X,8)," (",$P(Z(ZZ),"^",3)," MINUTES)  ",$P(^SC($P(Z(ZZ),"^",2),0),"^",1)," ",$P(Z(ZZ),"^",4)
WH R !!,"SCHEDULE TESTS FOR WHICH NUMBERED APPOINTMENT: ",APP:DTIME G:APP=""!(APP="^") RD I APP?."?" D HLP G WH
 I APP'?1N.N W !,"INVALID ENTRY, MUST BE NUMERIC" G WH
 I $L(APP)>5 W !,"ENTER A NUMBER BETWEEN 1 AND ",ZZ G WH
 I APP<1!(APP>ZZ) W !,"ENTER A NUMBER BETWEEN 1 AND ",ZZ G WH
 I $$CO(DFN,+Z(APP),"add") G WH
 S SD=$P(Z(APP),"^",1) S CNT=CNT+1,Y=SD D DTS^SDUTL S SODT=Y,SDWR=0,(LAB,XRAY,EKG)="" D ORD^SDM3 G RD
NOPE W:'CNT !,*7,"NOTHING SCHEDULED" G RD
NO W !,"NO PENDING APPOINTMENTS",*7,*7,*7
 G RD
FLEN I $D(^SC(SC,"S",NDT)) F ZL=0:0 S ZL=$N(^SC(SC,"S",NDT,1,ZL)) Q:ZL<0  I +^(ZL,0)=DFN S APL=$P(^SC(SC,"S",NDT,1,ZL,0),"^",2) Q
 Q
CHKSO S COMMENT="",SDAPAV=^(0),SDANAM="LAB"_U_"XRAY"_U_"EKG" F SDJ=3,4,5 I $P(SDAPAV,"^",SDJ)]"" S:$L(COMMENT) COMMENT=COMMENT_"," S COMMENT=COMMENT_$S(SDJ=3:"LAB",SDJ=4:"XRAY",1:"EKG"),@($P(SDANAM,U,SDJ-2))=$P(SDAPAV,U,SDJ)
 ;NAKED REFERENCE - ^DPT(DFN,"S",Date,0)
 S:$L(COMMENT) COMMENT="("_COMMENT_" TEST SCHEDULED)" Q
END K CNT,NDT,L,J,HDT,SC,SD,APL,COMMENT,Z,ZZ,APP,ZL,SDJ,X,%DT,DIC,DFN,NAME,Y,POP,SDAPAV,SDTY Q
HLP W !,"Enter the number that corresponds to the appointment." Q
 ;
CO(DFN,SDT,ACTION) ; -- can action be performed ; has appt been co'ed
 N Y
 S Y=0
 I $P($G(^SCE(+$P(^DPT(DFN,"S",SDT,0),U,20),0)),U,12)=2 D
 .S Y=1
 .W !,*7,"This appointment has been checked out!"
 .W !,"Please use Add/Edit stop code functionality to ",ACTION," the appropriate test."
 Q Y
