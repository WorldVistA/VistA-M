QAPPOST ;557/THM-POST INIT FOR SURVEY GENERATOR V 2.0 [ 03/04/95  11:32 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 I '$D(DUZ(2)) W !!,*7,"DUZ(2) is not defined.  Please set and rerun QAPPOST by entering D ^QAPPOST",! Q
 Q:DUZ(2)=557  ;don't delete the developer's copy
EN F X="QAPDEL","QAPUSPRT" X ^%ZOSF("TEST") D:$T  I '$T W !!,"The routine ",X," is not on disk.",!,"No action needed.",!
 .W !,"Deleting the routine ",X," since it is no longer needed..." H 1 X ^%ZOSF("DEL")
 W !!,"Finished.",!
DELEND K DIC,X,Y,DIK,DA
 Q
