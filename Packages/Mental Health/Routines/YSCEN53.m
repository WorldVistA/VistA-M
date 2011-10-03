YSCEN53 ;ALB/ASF-TEAM HX REPORT ;4/3/90  10:49 ; 4/10/09 2:31pm
 ;;5.01;MENTAL HEALTH;**96**;Dec 30, 1994;Build 46
 ;Reference to ^ICD( supported by DBIA #370
 ;Reference to ICDCODE APIs supported by DBIA #3990
 ;Reference to ^ICD9( supported by DBIA #5388
 ;  Called from routine YSCEN52
A ;
 S (YSFLGP,YST1)=0 F  S YST1=$O(^UTILITY($J,"YS",YST1)) Q:'YST1!Q3  F YS="DRG","DXLS","LOS" I $D(^UTILITY($J,"YS",YST1,YS)) D:YS?1"D".E HD^YSCEN56,HD1,L1,L5:YS="DRG" D:YS="LOS" L4 D:YS'="DXLS" WAIT^YSCEN1
 Q
L1 ;
 S (YSBE,YSI)=0 F  S YSI=$O(^UTILITY($J,"YS",YST1,YS,YSI)) Q:'YSI  D L2
 Q
L2 ;
 S G=^UTILITY($J,"YS",YST1,YS,YSI)
 I YS="DRG" W ! I $D(^ICD(YSI,1,1,0)) W YSI,?5,$E(^ICD(YSI,1,1,0),1,25)
 I YS="DXLS" N YSDXX,YSDXG,YSDXG1 S YSDXX=$P($$ICDDX^ICDCODE(YSI),U,2),YSDXG=$$ICDD^ICDCODE(YSDXX,"YSDXG1") W !,YSDXX,?8,$E(YSDXG1(1),1,20) ;asf 4/10/09
L3 ;
 S N=+$P(G,U,2),YSBAR=+G/N,YSSX=+$P(G,U,3)
 W ?32,$J(N,3),?38,$J(YSBAR,6,1)
 S X=(YSSX/N)-(YSBAR*YSBAR) D SQR W ?49,$J(Y,6,2)
 W ?57,$J($P(G,U,5),4),"/",$P(G,U,4)
 I +$P(G,U,6) S YSBE=YSBE+$P(G,U,6)
 I $P(G,U,6) W ?67,$J($P(G,U,6),8,2)
 Q
HD1 ;
 W !?32,"# of",?40,"mean",?47,"standard" W:YS="DRG" ?67,"days to" W !,$S(YS="DRG":"DRG",1:"DXLS"),?32,"pts",?40,"LOS",?47,"deviation",?59,"range" W:YS="DRG" ?67,"break even" W ! F ZZ=1:1:11 W "-------"
 Q
SP ;asf 4/10/09
 N YSDD1,YSDD2 S YSDD1=$$ICDDX^ICDCODE($P(^ICD9(YSI,0),U))
 S YSDD1=$P(YSDD1,U,2),YSDD2=$$ICDD^ICDCODE(YSDD1,"YSDD2")
 S G1=$E(YSDD2(1),I1,$L(^(1))) F I1=I1+45:1 S X=$E(G1,I1) Q:X=" "!(X="")
 W $S($L(G1):$E(G1,1,I1),1:"") I $L(G1)>I1 W !?14 G SP
 Q
L4 ;
 D:'$D(^UTILITY($J,"YS",YST1,"DXLS")) HD^YSCEN56 D HD1 W !,"Team total: " S G=^UTILITY($J,"YS",YST1,YS) D L3
 I $D(^UTILITY($J,"YS",YST1,"DXLS",0)) S G=^UTILITY($J,"YS",YST1,"DXLS",0) W !,"not coded:" D L3
 W !! Q
L5 ;
 W:YSBE !?67,"--------",!?67,$J(YSBE,8,2) Q
SQR ;
 S Y=0 Q:X'>0  S Y=1+X/2
L ;
 S T=Y,Y=X/T+T/2 G L:Y<T
 K T Q
EXP ;  Called from routine YSCEN52
 W @IOF,!?IOM-$L("INPATIENT PSYCHIATRIC HISTORY")\2,"INPATIENT PSYCHIATRIC HISTORY",! F ZZ=0:1 S X=$P($T(EXP1+ZZ),";;",2) Q:X="END"  W !,X
 Q
EXP0 ;  Called from routine YSCEN61
 W @IOF,!?IOM-$L("Current Inpatient Break even Report")\2,"Current Inpatient Break even Report",! F ZZ=0:1 S X=$P($T(EXP11+ZZ),";;",2) Q:X="END"  W !,X
 Q
EXP1 ;;This option will provide a full list of admits or discharges from
 ;;the selected ward sorted by team.  Patients may appear more than
 ;;once if they change teams within this ward.  Only the last team
 ;;gets credit in the summary LOS, DRG and DXLS tables.
 ;;
EXP11 ;;Please use this summary data carefully as in order to do concurrent
 ;;program planning, the computer uses DSM and ICD9 primary diagnosis
 ;;if full PTF data is not available.  As surgery, procedures and other
 ;;data points are not available this creates a best guess DRG. The data
 ;;should be evaluated accordingly. The letter following the DRG number
 ;;denotes the source of the DXLS: p= PTF DXLS, m= First PTF dx,
 ;;i= Primary ICD9 code, d= Primary DSM code.
 ;;END
EX ; Called from routine YSCEN52
 Q:$D(^UTILITY($J,"YS","DFN",DFN))  S ^UTILITY($J,"YS","DFN",DFN)=""
 S G=$S($D(^UTILITY($J,"YS",YST1,"LOS")):^("LOS"),1:"^^^0^99999")
 S $P(G,U)=$P(G,U)+LOS,$P(G,U,2)=$P(G,U,2)+1,$P(G,U,3)=$P(G,U,3)+(LOS*LOS) S:LOS>$P(G,U,4) $P(G,U,4)=LOS S:LOS<$P(G,U,5) $P(G,U,5)=LOS S ^UTILITY($J,"YS",YST1,"LOS")=G
 S G=$S($D(^UTILITY($J,"YS",YST1,"DRG",YSDRG)):^(YSDRG),1:"^^^0^99999")
 S $P(G,U)=$P(G,U)+LOS,$P(G,U,2)=$P(G,U,2)+1,$P(G,U,3)=$P(G,U,3)+(LOS*LOS) S:LOS>$P(G,U,4) $P(G,U,4)=LOS S:LOS<$P(G,U,5) $P(G,U,5)=LOS
 Q:'YSDRG  S:YSBE $P(G,U,6)=$P(G,U,6)+(YSBD-LOS) S ^UTILITY($J,"YS",YST1,"DRG",YSDRG)=G
 S G=$S($D(^UTILITY($J,"YS",YST1,"DXLS",DXLS)):^(DXLS),1:"^^^0^9999")
 S $P(G,U)=$P(G,U)+LOS,$P(G,U,2)=$P(G,U,2)+1,$P(G,U,3)=$P(G,U,3)+(LOS*LOS) S:LOS>$P(G,U,4) $P(G,U,4)=LOS S:LOS<$P(G,U,5) $P(G,U,5)=LOS
 S ^UTILITY($J,"YS",YST1,"DXLS",DXLS)=G
