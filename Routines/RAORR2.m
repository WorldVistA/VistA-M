RAORR2 ;HISC/CAH,FPT,GJC AISC/DMK-Verify a request from OERR ;9/12/94  11:11
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 K RAERR
 I $S('$D(ORPK):1,'ORPK:1,'$D(ORVP):1,'$L(ORVP):1,'$D(^RAO(75.1,ORPK,0)):1,1:0) S RAERR=1 G FAIL
 S RAIPROC=$P(^RAO(75.1,ORPK,0),"^",2) I 'RAIPROC S RAERR=1 G FAIL
 I '$D(^RAO(75.1,"AP",+ORVP,RAIPROC)) S RAERR=1 G FAIL
 S RATIME=$O(^RAO(75.1,"AP",+ORVP,RAIPROC,0))
 I $P(RATIME,".")>(9999999-DT) S RAERR=2 G FAIL
 ;
 S RAS3=+ORVP,X=RAIPROC,RAQUIT=1
 D ORDPRC1^RAUTL2,STATUS:'$D(RAQUIT)
 K RAERR,RAIPROC,RAO(0),RARDT,RAROIFN,RATIME,RAQUIT,RAQUIT,X,RAMDV
 Q
 ;
STATUS S RAERR=3 D FAIL H 1 Q
 Q
 ;
FAIL W !!,$P($T(ERR+RAERR),";;",2),! I RAERR=1 S OREND=1
 Q
ERR ;Error messages if the order fails the verify process(ORGY=10)
 ;;Invalid or missing information needed to verify the order.
 ;;Request Date for this order is in the past. May want to cancel the order.
 ;;You may want to cancel this order.
 Q
