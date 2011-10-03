%ZISG1 ;Device Handler prototype
 ;;8.0T3
 ;W !,$D(^$DI) K (%BUG) ;S:'$D(%BUG) %BUG=0 K:%BUG="NO" %BUG
 S XGDA=""
 I '$D(XGION) D
 .S XGION=$S($D(^$W("ZISGDEV","G","DEV","VALUE")):^$W("ZISGDEV","G","DEV","VALUE"),1:"")
 S:$G(XGION)]"" XGDA=$O(^%ZIS(1,"B",XGION,0))
 S XGIOT=$G(^%ZIS(1,+XGDA,"TYPE"))
 I XGIOT']""!('XGDA) D ^XGLMSG("E","No Device has been selected.") q
 I XGIOT'="TRM" G @XGIOT
 D INIT
 I $D(^$W("ZISGTRM")) S ^$W("ZISGTRM","VISIBLE")=1 ;K ^$W("ZISGTRM")
 E  M ^$W("ZISGTRM")=TMP("ZISGTRM")
 S ^$DI($PD,"FOCUS")="ZISGTRM"
 I $G(^%ZOSF("OS"))["VAX DSM" ESTART 0
 ;D ESTA^XG(0)
 ;;I $D(XGIOST) D
 ;;.S ^$W("ZISGTRM","G","SUB","VALUE")=XGIOST
 ;;.ETRIGGER ^$W("ZISGTRM","G","SUB","EVENT","CHANGE")
 S ^$W("ZISGTRM","VISIBLE")=1
 ;D S^XG("ZISGTRM","VISIBLE",1)
 D B2
 ESTART
 ;D ESTA^XG()
ERR ;K ^$W("ZISGTRM")
 ;D K^XG("ZISGTRM")
 ;D S^XG("ZISGTRM","VISIBLE",0)
 Q
SUBTYPE ;
 D B2^%ZISG3
 Q
B2 G B2^%ZISG3
DEV ; Callback for DEV item.
 Q
SUB ; Callback for SUB item
 G SUB^%ZISG3
CHGRAD ;CHANGE IN MARGIN
 G CHGRAD^%ZISG3
OK ; Callback for exit item in menu
 W !,"EXIT^%ZISG1 CALLED UPON CANCEL OF MORE"
 ;D S^XG("ZISGTRM","VISIBLE",0)
 S ^$W("ZISGTRM","VISIBLE")=0
 W !,"JUST BEFORE ESTOP OF TAG EXIT^%ZISG1"
 ESTOP
 ;D ESTO^XG
 QUIT
CANCEL K ^$W("ZISGTRM")
 ESTOP
 ;D ESTO^XG
 QUIT
HELP ;Callback for help.
 D ^XGLMSG("I","Help is not available at this time.")
 Q
INIT ;create names of devices into ACDEV 
 N %,%1,%2
 K TMP("ZISGTRM","G","SUBTYPE","CHOICE")
 S %1="" F %=1:1 S %1=$O(^%ZIS(2,"B",%1)) Q:%1']""  F %2=0:0 S %2=$O(^%ZIS(2,"B",%1,%2)) Q:%2'>0  S TMP("ZISGTRM","G","SUBTYPE","CHOICE",%)=%1
 Q
 ;
SPL ;Entry point for SPOOL devices.
 I '$D(DUZ) D ^XGLMSG("E","Your DUZ is not defined!") Q
 I $S($D(^VA(200,DUZ,"SPL")):$E(^("SPL"),1),1:"N")'["y" D  Q
 .D ^XGLMSG("E","You aren't an authorized SPOOLER user.") Q
 .; W:'$D(IOP) !?5,"You aren't an authorized SPOOLER user." Q
 I '$D(^$W("ZISGSPL")) D
 .M ^$W("ZISGSPL")=TMP("ZISGSPL")
 .M TMP("OLD","G","ZISGSPL","CHOICE")=^XMB(3.51,"B")
 .S X="",Y=""
 .S XGDIC("S")="I '$P(^XMB(3.51,Y,0),U,10)"
 .F  S X=$O(TMP("OLD","G","ZISGSPL","CHOICE",X)) Q:X=""  D
 ..S Y="" F  S Y=$O(TMP("OLD","G","ZISGSPL","CHOICE",X,Y)) Q:Y=""  D
 ...I 0
 ...X:$D(^DD(3.51,0,"SCR")) ^("SCR") I $T X XGDIC("S") I $T S TMP("NEW","G","ZISGSPL","CHOICE",X_"^"_Y)=X
 .M ^$W("ZISGSPL","G","DOC","CHOICE")=TMP("NEW","G","ZISGSPL","CHOICE")
 E  S ^$W("ZISGSPL","VISIBLE")=1
 S ^$DI($PD,"FOCUS")="ZISGSPL"
 ESTART
 Q
SPLOK ; Callback for exit item in menu
 W !,"OK BUTTON CALLED IN SPOOL SETUP"
 S XGDOC=^$W("ZISGSPL","G","DOC","VALUE")
 ;D S^XG("ZISGSPL","VISIBLE",0)
 S ^$W("ZISGSPL","VISIBLE")=0
 ESTOP
 ;D ESTO^XG
 QUIT
SPLNOK K ^$W("ZISGSPL")
 ESTOP
 ;D ESTO^XG
 QUIT
 ;
MT ;Magtape device setup
 S XGDA=""
 I '$D(XGION) D
 .S XGION=$S($D(^$W("ZISGDEV","G","DEV","VALUE")):^$W("ZISGDEV","G","DEV","VALUE"),1:"")
 S:$G(XGION)]"" XGDA=$O(^%ZIS(1,"B",XGION,0))
 M ^$W("ZISGMT")=TMP("ZISGMT")
 S ^$W("ZISGMT","G","OPENPARAM","VALUE")=$G(^%ZIS(1,+XGDA,"IOPAR"))
 S ^$DI($PD,"FOCUS")="ZISGMT"
 ESTART
 Q
MTOK ; Callback for exit item in menu
 W !,"OK BUTTON CALLED IN SPOOL SETUP"
 S XGPAR=^$W("ZISGMT","G","OPENPARAM","VALUE")
 ;D S^XG("ZISGMT","VISIBLE",0)
 S ^$W("ZISGMT","VISIBLE")=0
 W !,"JUST BEFORE ESTOP OF TAG MTOK^%ZISG1"
 ESTOP
 ;D ESTO^XG
 QUIT
MTNOK K ^$W("ZISGMT")
 ESTOP
 ;D ESTO^XG
 QUIT
SDP ;SDP device setup
 S XGDA=""
 I '$D(XGION) D
 .S XGION=$S($D(^$W("ZISGDEV","G","DEV","VALUE")):^$W("ZISGDEV","G","DEV","VALUE"),1:"")
 S:$G(XGION)]"" XGDA=$O(^%ZIS(1,"B",XGION,0))
 M ^$W("ZISGSDP")=TMP("ZISGSDP")
 S ^$W("ZISGSDP","G","OPENPARAM","VALUE")=$G(^%ZIS(1,+XGDA,"IOPAR"))
 S ^$DI($PD,"FOCUS")="ZISGSDP"
 ESTART
 Q
SDPOK ; Callback for exit item in menu
 W !,"OK BUTTON CALLED IN SPOOL SETUP"
 S XGPAR=^$W("ZISGSDP","G","OPENPARAM","VALUE")
 ;D S^XG("ZISGSDP","VISIBLE",0)
 S ^$W("ZISGSDP","VISIBLE")=0
 W !,"JUST BEFORE ESTOP OF TAG SDPOK^%ZISG1"
 ESTOP
 ;D ESTO^XG
 QUIT
SDPNOK K ^$W("ZISGSDP")
 ESTOP
 ;D ESTO^XG
 QUIT
HFS ;HOST FILE device setup
 S XGDA=""
 I '$D(XGION) D
 .S XGION=$S($D(^$W("ZISGDEV","G","DEV","VALUE")):^$W("ZISGDEV","G","DEV","VALUE"),1:"")
 S:$G(XGION)]"" XGDA=$O(^%ZIS(1,"B",XGION,0))
 M ^$W("ZISGHFS")=TMP("ZISGHFS")
 S ^$W("ZISGHFS","G","OPENPARAM")=$G(^%ZIS(1,+XGDA,"IOPAR"))
 S ^$DI($PD,"FOCUS")="ZISGHFS"
 ESTART
 Q
HFSOK ; Callback for exit item in menu
 W !,"OK BUTTON CALLED IN SPOOL SETUP"
 S XGPAR=^$W("ZISGHFS","G","OPENPARAM","VALUE")
 ;D S^XG("ZISGHFS","VISIBLE",0)
 S ^$W("ZISGHFS","VISIBLE")=0
 W !,"JUST BEFORE ESTOP OF TAG HFSOK^%ZISG1"
 ESTOP
 ;D ESTO^XG
 QUIT
HFSNOK K ^$W("ZISGHFS")
 ESTOP
 ;D ESTO^XG
 QUIT
