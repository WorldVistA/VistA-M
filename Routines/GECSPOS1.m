GECSPOS1 ;WISC/RFJ-version 2 GCS installation PIMS patch 5.3*47     ;30 Jun 92
 ;;2.0;GCS;;MAR 14, 1995
 Q
 ;
 ;
PATCH ;  install PIMS patch
 W !!,"==================== *** INSTALLING  PIMS  5.3  PATCH 47 *** =================="
 W !,"Installing PIMS Patch DG*5.3*47, routine DGGECSB ..."
 NEW %,%N,X,DIF,XCNP,DIE,XCN,XCM
 K ^TMP($J,"GECSPOS1")
 S X="GECSDG" X ^%ZOSF("TEST") I '$T W !,"Cannot install PIMS patch DG*5.3*47",!,"routine GECSDG not found!",! Q
 S X="DGGECSB" X ^%ZOSF("TEST") I '$T D INST Q
 S DIF="^TMP($J,""DGGECSB"",",XCNP=0,X="DGGECSB" X ^%ZOSF("LOAD") I $P($G(^TMP($J,"GECSPOS1",2,0)),";",3)'="5.3" D INST
 Q
INST ;Install update DGGECSB routine
 K ^TMP($J,"GECSPOS1")
 S DIF="^TMP($J,""GECSPOS1"",",XCNP=0,X="GECSDG" X ^%ZOSF("LOAD")
 S DIE="^TMP($J,""GECSPOS1"",",XCN=2,X="DGGECSB" X ^%ZOSF("SAVE")
 K ^TMP($J,"GECSPOS1")
 W " OK, DONE."
 Q
