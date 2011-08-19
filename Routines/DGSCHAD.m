DGSCHAD ;ALB/MRL - SCHEDULED ADMISSIONS ENTRY/CANCEL ;12/4/91  14:14 ;
 ;;5.3;Registration;**117,187**;Aug 13, 1993
 ;OERR MODIFICATIONS
1 ;Schedule Admission
 D Q S DGNEW=0 K ORACTION G Q:$D(DGSKIP) W !! S DIC("A")="Schedule admission for patient:  ",DIC(0)="AEZQLM"
11 S DLAYGO=41.1,DIC("S")="I '$P(^DGS(41.1,+Y,0),""^"",13)",DIC="^DGS(41.1," D ^DIC K DLAYGO,DIC("S"),DIC("A") G Q:Y'>0 S DGSCH=+Y,DFN=+$P(Y,"^",2)
EN S DGNEW=+$P(Y,U,3) I 'DGNEW&($D(ORACTION)) W !,"Editing is not allowed through this option, only adding",*7,! G Q
 I $D(^DPT(+$P(^(0),"^",1),.35)),+^(.35) S Y=^(.35) X ^DD("DD") W !!,*7,"PATIENT DIED ON ",Y,"...CAN'T SCHEDULED ADMIT FOR EXPIRED PATIENT!!" D:DGNEW KILL G Q:$D(ORACTION),1:'$D(DGSKIP),Q
 S (DA,Y)=DGSCH,DR="[DGSCHADMIT]",DIE=DIC D DIV^DGUTL,^DIE,SA G 1:DGERR I $S('$D(^DGS(41.1,"B",DFN)):1,'$D(^DPT(DFN,.3)):1,$P(^DPT(DFN,.3),"^",1)'="N":1,1:0) G Q:$D(ORACTION),1:'$D(DGSKIP),Q
 K DFN1,DGPMDA,DGJJ G Q:$D(DGSKIP)
TP W ! D ASK^DGBLRV
 G Q:$D(ORACTION),1:'$D(DGPMDA) Q
2 ;Cancel Scheduled Admission
 D WARN W !! S DIC("A")="Cancel scheduled admission for patient:  ",DIC("S")="I '$P(^DGS(41.1,+Y,0),""^"",13)",DIC(0)="AEZQM",DIC="^DGS(41.1," D ^DIC K DIC("A"),DIC("S") G Q:Y'>0 S DGSCH=+Y
 W !!,*7,"All questions must be answered or this scheduled admission won't be cancelled!!" S (DA,Y)=DGSCH,DIE=DIC,DR="13;14////^S X=DUZ;15;16;" D ^DIE,CA,Q G 2
 Q
SA ;Check SA for missing data
 W ! S DGSCH1=$S($D(^DGS(41.1,+DGSCH,0)):^(0),1:"") I DGSCH1']"" S DGERR=0 Q
 S DGERR=0,DGERSUB="PATIENT NAME^DATE OF RESERVATION^LENGTH OF STAY EXPECTED^ADMITTING DIAGNOSIS^PROVIDER^SURGERY^OPT/NSC STATUS^^^WARD OR TREATING SPECIALTY^^DIVISION"
 F I=1,2,4,5,10,12 I $P(DGSCH1,"^",I)']"" S DGERR=1 W !?4,"> ",$P(DGERSUB,"^",I)," is not specified."
 I $P(DGSCH1,"^",10)="W",$P(DGSCH1,"^",8)']"" S DGERR=1 W !?4,"> WARD location to which admit is scheduled is not specified."
 I $P(DGSCH1,"^",10)="T",$P(DGSCH1,"^",9)']"" S DGERR=1 W !?4,"> TREATING SPECIALTY to which admit is scheduled is unspecified."
 W !!,*7,"[",$S('DGERR:"ADMISSION HAS BEEN",1:"NOTHING")," SCHEDULED",$S('DGERR:"",1:"...ACTION DELETED"),"]" D:DGERR KILL Q
CA ;Check for missing CA data
 W ! S DGERR=0,DGERR1="",DGERSUB="DATE/TIME CANCELLED^CANCELLED BY^REASON CANCELLED^WAS PATIENT NOTIFIED",DGSCH1=$S($D(^DGS(41.1,+DGSCH,0)):^(0),1:"") I DGSCH1']"" Q
 F I=13:1:16 S:$P(DGSCH1,"^",I)]"" DGERR1=DGERR1_I_"///@;" I $P(DGSCH1,"^",I)']"" W !?4,"> ",$P(DGERSUB,"^",I-12)," is unspecified." S DGERR=1
 W !!,*7,"...Scheduled Admission has ",$S(DGERR:"not ",1:""),"been Cancelled..." Q:'DGERR  I $L(DGERR1) S DIE="^DGS(41.1,",DIC(0)="AEQMZ",DR=DGERR1 D ^DIE K DR
 Q
WARN D Q D:'$D(DT) DT^DICRW Q
KILL S DIK="^DGS(41.1,",DA=DGSCH D ^DIK K DIK Q
Q K DGNEW,DGERR,DGERR1,DGERSUB,DGSCH,DGSCH1,DFN1,DIC,DIE,DR,X,Y,DGSDIV,DA,DIK,I Q
OREN D Q S XQORQUIT=1,DGNEW=0,DIC(0)="ELN",X=+ORVP D 11 Q
 ;
WACT(DGW,DGDT) ;ward active on scheduled admit date?
 ;  input:      DGW = ien of WARD LOCATION file
 ;             DGDT = date of interest - defaults to DT
 ;  returns:   1 if active 
 ;             0 if inactive (out-of-service)
 ;            -1 if error
 ;
 N DGX,DGY
 I '$D(DGW) Q -1
 I '$D(^DIC(42,DGW,0)) Q -1
 S DGY=$S($D(DGDT):DGDT,1:DT) I $P(DGY,".",1)'?7N Q -1
 S DGX=+$O(^DIC(42,DGW,"OOS","B",DGY+.1),-1),DGX=$S($D(^DIC(42,DGW,"OOS",+$O(^(+DGX,0)),0)):^(0),1:"")
 I '$P(DGX,U,6) Q 1
 I $P(DGX,U,6),'$P(DGX,U,4) Q 0
 I $P(DGX,U,6),$P(DGX,U,4)'>DGY Q 1
 Q 0
