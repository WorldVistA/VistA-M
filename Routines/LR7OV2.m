LR7OV2 ;slc/dcm - Menu actions for parameter updates ;8/11/97
 ;;5.2;LAB SERVICE;**121,187**;Sep 27, 1994
 ;
ALL ;Get all tests in file 60. Used for initial conversion.
 N AIFN
 S AIFN=0 F  S AIFN=$O(^LAB(60,AIFN)) Q:AIFN<1  D ADD^LR7OV0(AIFN) I "N"[$P(^LAB(60,AIFN,0),"^",3) D DEACT^LR7OV0(AIFN)
 Q
ALLU ;Update all tests in file 60.
 N AIFN
 W !,"This option will update OE/RR with all Lab tests in file 60.",!,"This will take some time.  Are you sure you want to continue" S %=2 D YN^DICN
 I %=0 W !!,"Answer YES to update all lab tests, NO to quit." G ALLU
 Q:%'=1  S AIFN=0
 ;I $$VER^LR7OU1<3 W !!,"Cannot continue.  OE/RR 3.0 has not been installed." Q
 I '$$XPARCK W !!,"Cannot continue.  XPAR Parameter utilities have not been installed." Q
 F  S AIFN=$O(^LAB(60,AIFN)) Q:AIFN<1  D UPD^LR7OV0(AIFN) W "."
 W !!,"----DONE----"
 Q
SING ;Update OE/RR with single test from file 60
 ;I $$VER^LR7OU1<3 W !!,"Cannot continue.  OE/RR 3.0 has not been installed." Q
 I '$$XPARCK W !!,"Cannot continue.  XPAR Parameter utilities have not been installed." Q
 N DIC,Y
 S DIC=60,DIC(0)="AEQM" D ^DIC Q:Y<1
S1 W !!,"Update OE/RR with parameters for test: "_$P(^LAB(60,+Y,0),"^")
 S %=1 D YN^DICN
 I %=0 W !!,"Answer YES to update OE/RR with the parameters in file 60 for selected test" G S1
 Q:%'=1  D UPD^LR7OV0(+Y)
 W !!,"----DONE----"
 Q
PARAM ;Update OE/RR with lab parameters
 ;I $$VER^LR7OU1<3 W !!,"Cannot continue.  OE/RR 3.0 has not been installed." Q
 I '$$XPARCK W !!,"Cannot continue.  XPAR Parameter utilities have not been installed." Q
 W !,"This option will update OE/RR with all Lab ordering parameters.",!,"OK to continue" S %=2 D YN^DICN
 I %=0 W !!,"Answer YES to update all lab ordering parameters, NO to quit." G PARAM
 Q:%'=1  D EN^LR7OV1
 W !!,"----DONE----"
 Q
EN(ORVP,TALK) ;Convert lab patients on the fly
 ;ORVP=Patient DFN;DPT( (variable ptr format)
 ;TALK=1 to write, 0 for silence
 I $$VER^LR7OU1<3 Q  ;OE/RR 2.5 Check
 I $G(^ORD(100.99,1,"CONV")) Q
 N LRPDFN,LRORD,ODT,SN,X,LRODT,LRSN,FLG
 S X="^"_$P(ORVP,";",2)_+ORVP_",""LR"")",LRPDFN=+$S($D(@X):@X,1:0),FLG=0 Q:'LRPDFN
 Q:'$D(^LRO(69,"D",LRPDFN))
 S ODT=0 F  S ODT=$O(^LRO(69,"D",LRPDFN,ODT)) Q:ODT<1  S SN=0 F  S SN=$O(^LRO(69,"D",LRPDFN,ODT,SN)) Q:SN<1  Q:'$D(^LRO(69,ODT,1,SN,0))  D
 . S X=^LRO(69,ODT,1,SN,0),LRORD=+$G(^(.1)) I $P(X,"^",11) Q
 . F  L +^LRCNVRT(LRORD):360 Q:$T
 . S LRODT=0
 . D NEW1^LR7OB0(ODT,SN,"ZC") W:$G(TALK) "."
 . S $P(^LRO(69,ODT,1,SN,0),"^",11)=1.69
 . L -^LRCNVRT(LRORD)
 Q
XPARCK() ;Check for existance of XPAR routine
 Q $L($T(XPAR^XPAR))
