IB20P347 ;BP/BDM - PHARMACY API CALLS POST-INSTALL ROUTINE; DECEMBER 20, 2006
 ;;2.0;INTEGRATED BILLING;**347**;21-MAR-94;Build 24
 ;
 ;This is a post-install routine
 ;
 ;The purpose of this routine is to modify six entries in file ^IBE(350.1 to comply with
 ;new pharmacy APIs.
 ;
 N CNT,CNT2,CODE,IBN,IBSUB
 F CNT=1:1 S IBSUB=$P($T(ENTRIES+CNT),";;",2) Q:IBSUB="END"  S IBN=$O(^IBE(350.1,"B",IBSUB,0)) I IBN D
 .F CNT2=1:1 S CODE=$P($T(ENTRIES+CNT2),";;",2) Q:CODE="END"  D
 .S ^IBE(350.1,IBN,20)=$P($T(CODE+1),";;",2)
 Q
ENTRIES ;Entries for file 350.1
 ;;PSO NSC RX COPAY CANCEL
 ;;PSO NSC RX COPAY NEW
 ;;PSO NSC RX COPAY UPDATE
 ;;PSO SC RX COPAY CANCEL
 ;;PSO SC RX COPAY NEW
 ;;PSO SC RX COPAY UPDATE
 ;;END
CODE ;
 ;;S:'$D(^(10)) X="" I $D(^(10)) X ^(10) S X=$S($D(Y(0)):$P(Y(0),U),1:"UNK") I $D(Y(0)) S X=X_"-"_$S($$DRUG^IBRXUTL1(+$P(Y(0),U,6))'="":$$DRUG^IBRXUTL1(+$P(Y(0),U,6)),1:"UNK DRUG"),X=$E(X,1,18)_"-"_$S($D(IBUNIT):IBUNIT,$D(IBX):$P(IBX,U,2),1:"")
 ;;END
