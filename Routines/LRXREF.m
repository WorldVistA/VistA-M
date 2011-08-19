LRXREF ;SLC/RWA/DALOI/FHS - BUILD CROSS-REFERENCES FOR RE-INDEX ;7/9/92  01:26
 ;;5.2;LAB SERVICE;**70,153,263**;Sep 27, 1994
AVS1 ;Rebuild "AVS" cross-reference in file 68 for Re-index utility
 I $D(DIU(0)),'$L($P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,4)) S ^LRO(68,"AVS",DA(2),DA(1),DA)=$P(^LRO(68,DA(2),1,DA(1),1,DA,0),U)_"^"_$P(^(3),U,5)
 Q
AVS2 I $D(DIU(0)),$L($P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,4)) K ^LRO(68,"AVS",DA(2),DA(1),DA)
 Q
AVS3 I '$D(DIU(0)),$L($P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,4)) K ^LRO(68,"AVS",DA(2),DA(1),DA)
 Q
AVS4 I '$D(DIU(0)),'$L($P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,4)) S ^LRO(68,"AVS",DA(2),DA(1),DA)=$P(^LRO(68,DA(2),1,DA(1),1,DA,0),U)_"^"_$P(^(3),U,5)
 Q
 ;
AC1 ;Build "AC" cross-reference when comment is deleted from a verified
 ;test in File 63. Audit trail only.
 I '$D(DIU(0)),$D(DUZ),$P(^LR(DA(2),"CH",DA(1),0),U,3) S ^LR(DA(2),"CH",DA(1),1,"AC",DUZ,$H)=$P(^LR(DA(2),"CH",DA(1),0),U,3,4)_"^"_X
 Q
 ;Build and Kill "AN"" cross-reference in File 69, when results available
AN1 S ^LRO(69,"AN",$E($P(^LRO(69,DA(1),1,DA,0),U,7),1,15),$P(^(0),U),9999999-$P(^LRO(69,DA(1),1,DA,1),U))=""
 Q
AN2 K ^LRO(69,"AN",$E($P(^LRO(69,DA(1),1,DA,0),U,7),1,15),$P(^(0),U),9999999-$P(^LRO(69,DA(1),1,DA,1),U))
 Q
 ; Build and Kill "AR" cross-reference in File 69, when results available
AR1 S LRDT=$E(X,1,7),LRLLOC=$E($P(^LRO(69,DA(1),1,DA,0),U,7),1,15)
 S LRDFN=$P(^(0),U),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) S LRGN=^DIC(+LRDPF,0,"GL")_DFN_",0)" S LRGN=$S($D(@LRGN):@LRGN,1:"") S LRPNM=$P(LRGN,U)
 Q
AR2 S ^LRO(69,LRDT,1,"AR",LRLLOC,LRPNM,LRDFN)="" K LRDT,LRGN,LRDFN,LRLLOC,LRPNM
 Q
AR3 K ^LRO(69,LRDT,1,"AR",LRLLOC,LRPNM,LRDFN) K LRDT,LRGN,LRDFN,LRLLOC,LRPNM
 Q
LRKILL ; This cross-reference will be reset when the cumulative runs.  Due
 ;to the complexity of the cumulative reporting it was felt that 
 ;it was better to have reprinted data rather than possibly having
 ;some data not printed at all.
 K ^LAC("LRKILL") Q
AP ;Build and kill "AP" cross-refernce in File 69, when results available
 S LRDATE=$P($P(^LRO(69,DA(1),1,DA,3),U),"."),LRPHY=$P(^LRO(69,DA(1),1,DA,0),U,6),LRPHY=$S($D(^VA(200,LRPHY,0)):$E($P(^(0),U),1,20),1:"UNK")
 S LRDFN=$P(^LRO(69,DA(1),1,DA,0),U),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) S LRGN=^DIC(+LRDPF,0,"GL")_DFN_",0)" S LRGN=$S($D(@LRGN):@LRGN,1:"") S LRPNM=$P(LRGN,U)
 Q
AP1 S ^LRO(69,LRDATE,1,"AP",LRPHY,LRPNM,LRDFN)="" K LRDATE,LRPHY,LRPNM,LRDFN,LRGN,LRDPF,DFN
 Q
AP2 K ^LRO(69,LRDATE,1,"AP",LRPHY,LRPNM,LRDFN) K LRDATE,LRPHY,LRPNM,LRDFN,LRGN,LRDPF,DFN
 Q
AL ;Build and kill "AL" cross-reference inFile 69, when results available
 S LRDATE=$P($P(^LRO(69,DA(1),1,DA,3),U),"."),LRDFN=$P(^LRO(69,DA(1),1,DA,0),U),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) S LRGN=^DIC(+LRDPF,0,"GL")_DFN_",0)" S LRGN=$S($D(@LRGN):@LRGN,1:"") S LRPNM=$P(LRGN,U)
 S LRLLOC=$E($P(^LRO(69,DA(1),1,DA,0),U,7),1,15)
 Q
AL1 S ^LRO(69,LRDATE,1,"AL",LRLLOC,LRPNM,LRDFN)="" K LRDATE,LRPNM,LRDFN,LRGN,LRDPF,DFN,LRLLOC
 Q
AL2 K ^LRO(69,LRDATE,1,"AL",LRLLOC,LRPNM,LRDFN) K LRDATE,LRPNM,LRDFN,LRGN,LRDPF,DFN,LRLLOC
 Q
UP ;Convert lower to upper case.
 F %=1:1:$L(X) I $E(X,%)?1L S X=$E(X,1,%-1)_$C($A(X,%)-32)_$E(X,%+1,99)
 Q
TRIG ;Trigger LAB Workload
 ;Stuff the Cap Code Name into field .03 of field 4 of field 1 of field 1
 ;of ^LRO(67.9 LAB MONTHLY WORKLOAD
 S X=$P($G(^LAM($O(^LAM("E",$P(^LRO(67.9,DA(3),1,DA(2),1,DA(1),1,DA,0),U),0)),0)),U)
 Q
TRIGTS ;Trigger to stuff treating specialty name into .03 field of ^DD(67.91148
 S X=$P($G(^DIC(42.4,+$P($G(^LRO(67.9,DA(4),1,DA(3),1,DA(2),1,DA(1),1,DA,0)),U),0)),U) S:'$L(X) X="AMBULATORY CARE"
 Q
TRIG9 ;Trigger for LAB Workload
 ;Stuff the Cap Code Name into field .03 of field 4 of field 1 of field 1
 ;of ^LRO(67.99999 ARCHIVED LAB MONTHLY WORKLOAD
 S X=$P($G(^LAM($O(^LAM("E",$P(^LRO(67.99999,DA(3),1,DA(2),1,DA(1),1,DA,0),U),0)),0)),U)
 Q
TRIGTS9 ;Trigger to stuff treating specialty name into .03 field of ^DD(67.999991148
 S X=$P($G(^DIC(42.4,+$P($G(^LRO(67.99999,DA(4),1,DA(3),1,DA(2),1,DA(1),1,DA,0)),U),0)),U) S:'$L(X) X="AMBULATORY CARE"
 Q
LAM185 ;Trigger logic to set TYPE(#5) of CODE (#18) of WKLD CODE (#64)
 N %1
 S %1=$P(X,";",2),X=$S(%1="ICPT(":"CPT",%1="LAB(61.1,":"SNO",%1="LAB(95.3,":"LOINC",%1="ICD9(":"ICD",1:"NOS")
 Q
