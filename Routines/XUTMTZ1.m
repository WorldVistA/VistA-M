XUTMTZ1 ;SEA/RDS - TaskMan: Toolkit: Test Utilities (Symbol Table) ;5/20/91  15:40 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
RECORD ;queuable entry point to record the symbol table at ^TMP("XUTMTZ",
 S ^TMP("XUTMTZ","VAR",$J,$H)=ZTSK_", VARIABLE DUMP"
 S X="^TMP(""XUTMTZ"",""VAR"",$J,$H," D DOLRO^%ZOSV
 H 1 S ^TMP("XUTMTZ","VAR",$J,$H)="-----------------------------------------"
 Q
 ;
SETUP ;programmer mode entry point to setup a task's symbol table
 ;
REPORT ;entry--report all errors in Error file by count
 K ^TMP("XUTMTZ"),^("XUTMTZ1")
 S ZTRANSLT="" F ZTA=0:1:31,127 S ZTRANSLT=ZTRANSLT_$C(ZTA)
 S ZT1=0 F ZT=0:0 S ZT1=$O(^%ZTER(1,ZT1)),ZT2=0 Q:'ZT1  F ZT=0:0 S ZT2=$O(^%ZTER(1,ZT1,1,ZT2)) Q:'ZT2  I $D(^(ZT2,"ZE"))#2 S ZTE=$E($TR(^("ZE"),ZTRANSLT,""),1,40) I ZTE]"" S X=$S($D(^TMP($J,"XUTMTZ",ZTE))#2:^(ZTE)+1,1:1),^(ZTE)=X W "."
 S ZT1="" F ZT=0:0 S ZT1=$O(^TMP($J,"XUTMTZ",ZT1)) Q:ZT1=""  S ZTX=^(ZT1),^TMP($J,"XUTMTZ1",ZTX,ZT1)="" W "."
 S ZT1=0 F ZT=0:0 S ZT1=$O(^TMP($J,"XUTMTZ1",ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^TMP($J,"XUTMTZ1",ZT1,ZT2)) Q:ZT2=""  W !,ZT1,?5,ZT2
 K ^TMP($J,"XUTMTZ"),^("XUTMTZ1"),ZT,ZT1,ZT2,ZTA,ZTE,ZTRANSLT,ZTX
 Q
 ;
REMOVE ;entry--remove a type of error from the Error file
 F QUASI=0:0 D READ Q:$D(DIRUT)  D DEL
 K DA,DIK,DIRUT,DTOUT,DUOUT,QUASI,X,ZT,ZTC,ZTE,ZTYPE
 Q
 ;
READ ;REMOVE--read in type of error to remove
 K DIRUT,DTOUT,DUOUT,ZTYPE
 R !,"Error to remove: ",X:$S($D(DTIME)#2:DTIME,1:60)
 I '$T W $C(7),"**TIMEOUT**" S DTOUT=1,DIRUT=1 Q
 I X="^" S DUOUT=1,DIRUT=1 Q
 I X="" S DIRUT=1 Q
 I X="?" W !!?5,"Answer must be free text.",!?5,"Every error that contains the answer will be purged from the Error file.",! G READ
 I X?."?" W !!,"Generating frequency report" D REPORT W ! G READ
 S ZTYPE=X
 Q
 ;
DEL ;REMOVE--remove type of error from Error file
 S DA(1)=0,ZTC=0 F ZT=0:0 S DA(1)=$O(^%ZTER(1,DA(1))),DA=0,DIK="^%ZTER(1,DA(1),1," Q:'DA(1)  W !,DA(1) F ZT=0:0 S DA=$O(^%ZTER(1,DA(1),1,DA)) Q:'DA  W "." I $D(^(DA,"ZE"))#2 S ZTE=^("ZE") I ZTE[ZTYPE D ^DIK W DA S ZTC=ZTC+1
 W !!,"Number of errors removed: ",ZTC,!
 Q
 ;
REPORT2 ;entry--report all errors in TaskMan Error file by count
 K ^TMP("XUTMTZ"),^("XUTMTZ1")
 S ZTRANSLT="" F ZTA=0:1:31,127 S ZTRANSLT=ZTRANSLT_$C(ZTA)
 S ZT1=0 F ZT=0:0 S ZT1=$O(^%ZTSCH("ER",ZT1)),ZT2=0 Q:'ZT1  F ZT=0:0 S ZT2=$O(^%ZTSCH("ER",ZT1,ZT2)) Q:'ZT2  I $D(^(ZT2))#2 S ZTE=$E($TR(^(ZT2),ZTRANSLT,""),1,40) I ZTE]"" S X=$S($D(^TMP($J,"XUTMTZ",ZTE))#2:^(ZTE)+1,1:1),^(ZTE)=X W "."
 S ZT1="" F ZT=0:0 S ZT1=$O(^TMP($J,"XUTMTZ",ZT1)) Q:ZT1=""  S ZTX=^(ZT1),^TMP($J,"XUTMTZ1",ZTX,ZT1)="" W "."
 S ZT1=0 F ZT=0:0 S ZT1=$O(^TMP($J,"XUTMTZ1",ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^TMP($J,"XUTMTZ1",ZT1,ZT2)) Q:ZT2=""  W !,ZT1,?5,ZT2
 K ^TMP($J,"XUTMTZ"),^("XUTMTZ1"),ZT,ZT1,ZT2,ZTA,ZTE,ZTRANSLT
 Q
 ;
