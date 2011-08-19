XTVGC2A1 ;ISC-SF..SEA/JLI - COMPARE SAVED AND CURRENT NAMESPACE DATA ;5/10/93  13.06 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
OPTS ;
 I $P(XTVX,(","_XTNN_","),2)="0)" S $P(XTVY,U,5)="",$P(XTVY,U,12)=""
 I $P(XTVG,(","_XTNN_","),2)="0)" D
 .S $P(XTVGY,U,5)="",$P(XTVGY,U,12)=""
 .S J=$P(XTVGY,U,7) I J>0,$P(XTVY,U,7)'="" S I=$P(^DIC(9.2,J,0),U),I(0)=$O(@(XTBAS1_"""B"",""HELP FRAMES"",0)")) I I(0)>0 S I(0)=$O(@(XTBAS1_I(0)_",1,""B"","""_I_""",0)")) I I(0)>0,$P(XTVY,U,7)=+^(I(0)) S $P(XTVY,U,7)=J
 S I=$P($P(XTVX,(","_XTNN_",10,"),2),","),J=$P($P(XTVG,(","_XTNN_",10,"),2),",") D
 .I I>0,J>0,I=J S J=+XTVGY I J>0 D
 ..S I(0)=$P(^DIC(19,J,0),U),I(0)=$O(@(XTBAS1_XTTYI_",1,""B"","""_I(0)_""",0)")) I I(0)>0,+XTVY=^(I(0)) S K=+XTVY,$P(XTVY,U)=J,K="^DIC(19,"_XTNN_",10,""B"","_K_","_I_")",^TMP($J,"OB",K)="^DIC(19,"_XTNN_",10,""B"","_J_","_I_")"
 I XTVX[",10,""B"",",$D(^TMP($J,"OB",XTVX)) S XTVX=^(XTVX)
 I XTVX[",99)",XTVG[",99)" S XTVY="",XTVGY=""
 Q
HFS ;
 I $P(XTVX,(","_XTNN_","),2)="0)" S $P(XTVY,U,4)=""
 I $P(XTVG,(","_XTNN_","),2)="0)" S $P(XTVGY,U,4)=""
 ;.S $P(XTVGY,U,5)="",$P(XTVGY,U,12)=""
 ;.S J=$P(XTVGY,U,7) I J>0,$P(XTVY,U,7)'="" S I=$P(^DIC(9.2,J,0),U),I(0)=$O(@(XTBAS1_"""B"",""HELP FRAMES"",0)")) I I(0)>0 S I(0)=$O(@(XTBAS1_I(0)_",1,""B"","""_I_""",0)")) I $P(XTVY,U,7)=+^(I(0)) S $P(XTVY,U,7)=J
 S I=$P($P(XTVX,(","_XTNN_",2,"),2),","),J=$P($P(XTVG,(","_XTNN_",2,"),2),",") D
 .I I>0,J>0,I=J S J=+$P(XTVGY,U,2) I J>0 D
 ..S I(0)=$P(^DIC(9.2,J,0),U),I(0)=$O(@(XTBAS1_XTTYI_",1,""B"","""_I(0)_""",0)")) I I(0)>0,+$P(XTVY,U,2)=^(I(0)) S $P(XTVY,U,2)=J
 ;I XTVX[",10,""B"",",$D(^TMP($J,"OB",XTVX)) S XTVX=^(XTVX)
 ;I XTVX[",99)",XTVG[",99)" S XTVY="",XTVGY=""
 Q
CHECK ;
 S:XTVX["~IEN~" XTVX=$S($E(XTVX)'=U:U,1:"")_$P(XTVX,"~IEN~")_XTNN_$P(XTVX,"~IEN~",2)
 D:XTTY="OPTIONS" OPTS D:XTTY["FRAMES" HFS
 F I=$L(XTVY):-1 Q:$E(XTVY,I)'=U  S XTVY=$E(XTVY,1,I-1)
 F I=$L(XTVGY):-1 Q:$E(XTVGY,I)'=U  S XTVGY=$E(XTVGY,1,I-1)
 S:'$D(XTVTYP) XTVTYP="" I XTVG="" D:XTSEEN=0 HEDR W !,"* DEL *   ",XTVX," = ",XTVY Q
 I XTVX="" Q:XTTY="OPTIONS"&(XTVG[",10,""B"",")  D:XTSEEN=0 HEDR W !,"* ADD *   ",XTVG," = ",XTVGY Q
 S XTVB=$S(XTVX=XTVG:0,1:1)
 I XTVB S XTVX5=$E(XTVX,1,$L(XTVX)-1),XTVG5=$E(XTVG,1,$L(XTVG)-1) F XTVI=1:1 S XTVG6=$P(XTVG5,",",XTVI),XTVX6=$P(XTVX5,",",XTVI) I XTVG6'=XTVX6 S XTVB=$S(+XTVX6=XTVX6:$S(+XTVG6'=XTVG6:-1,XTVX6<XTVG6:-1,1:1),+XTVG6=XTVG6:1,XTVG6]XTVX6:-1,1:1) Q
 I XTVB<0 D:XTSEEN=0 HEDR W !,"* DEL *   ",XTVX," = ",XTVY S M=M+1,XTVX=$S('$D(@XTVF0):"",1:^(0)),XTVY=$S(XTVX="":"",1:^(1)) G CHECK
 I XTVB>0 Q:XTTY="OPTIONS"&(XTVG[",10,""B"",")  D:XTSEEN=0 HEDR W:(XTVTYP="")!($P(XTVG,",",2)'="""AB""") !,"* ADD *   ",XTVG," = ",XTVGY S XTVG=$Q(@XTVG) D MSMQ^XTVGC2 S:XTVG'[XTVG1 XTVG="" S XTVGY=$S(XTVG="":"",1:@XTVG) G CHECK
 I XTVGY'=XTVY D:XTSEEN=0 HEDR W !,"* OLD *   ",XTVX," = ",XTVY,!,"* NEW *   ",XTVX," = ",XTVGY
 Q
HEDR S XTSEEN=1 W !!,"CHANGED ",$E(XTTY,1,$L(XTTY)-1),":   ",XTVAL,"        IEN=",XTNN
 Q
