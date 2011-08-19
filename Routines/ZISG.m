%ZISG ;Device Handler prototype ;2/18/93  16:30
 ;;8.0T3
 S $ZT="ERR^%ZISG"
 D LOAD^%ZISG2
 D INIT
 K TMP("ZISGDEV","PARENT")
 I $D(%PARENT) S TMP("ZISGDEV","PARENT")=%PARENT("PARENT")
 S TMP("ZISGDEV","G","QFRAME","VISIBLE")=1
 M ^$WINDOW("ZISGDEV")=TMP("ZISGDEV")
 ;D M^XG("ZISGDEV",$NA(TMP("ZISGDEV")))
 ;I $G(^%ZOSF("OS"))["VAX DSM" ESTART 0 ;NEEDED FOR VAX DSM
 ;D ESTA^XG(0)
 D B1
 ESTART
 W !,"THIS IS THE LINE AFTER ESTART COMMAND IN ^%ZISG"
 ;D ESTA^XG()
ERR ;K ^$W("ZISGDEV")
 ;D K^XG("ZISGTRM")
 ;D K^XG("ZISGDEV")
 W !,"$ZE="_$ZE
 W !,"$EC="_$EC
 W !,"$EREF="_$EREF
 K:$D(^$W("ZISGMT")) ^$W("ZISGMT")
 K:$D(^$W("ZISGHFS")) ^$W("ZISGHFS")
 K:$D(^$W("ZISGSDP")) ^$W("ZISGSDP")
 K:$D(^$W("ZISGSPL")) ^$W("ZISGSPL")
 K:$D(^$W("ZISGTRM")) ^$W("ZISGTRM")
 K:$D(^$W("ZISGDEV")) ^$W("ZISGDEV")
 W !,"$D(%PARENT)="_$D(%PARENT)
 ;I '$D(%PARENT) D CLEAN^XG
 Q
B1 ;***VADIMS MWAPI/KWAPI INTERFACE***
 I '@XGWIN@("ZISGDEV","G","PROMPT","VISIBLE") D
 .;D S^XG("ZISGDEV","G","PROMPT","VALUE",@XGWIN@("ZISGDEV","G","DEV","VALUE"))
 .S DEV=@XGWIN@("ZISGDEV","G","DEV","VALUE")
 .I DEV]"" D
 ..S ITEM=$$DEVITEM(DEV)
 ..I ITEM]"" D
 ...D S^XG("ZISGDEV","G","PROMPT","VALUE",ITEM,"")
 ...D S^XG("ZISGDEV","G","PROMPT","TOPSHOW",ITEM)
 .D S^XG("ZISGDEV","G","PROMPT","VISIBLE",1)
 .;S ^$W("ZISGDEV","G","QFRAME","VISIBLE")=0
 E  D
 .D S^XG("ZISGDEV","G","PROMPT","VISIBLE",0)
 .;S ^$W("ZISGDEV","G","QFRAME","VISIBLE")=1
 .S ITEM=$O(@XGWIN@("ZISGDEV","G","PROMPT","VALUE",""))
 .I ITEM D
 ..D S^XG("ZISGDEV","G","DEV","VALUE",@XGWIN@("ZISGDEV","G","PROMPT","CHOICE",ITEM))
 ..S XGION=@XGWIN@("ZISGDEV","G","PROMPT","CHOICE",ITEM)
 Q
PROMPT ;PROMPT CALLBACK
 D B1
 N ITEM,VALUE
 S ITEM=$O(^$W("ZISGDEV","G","PROMPT","VALUE",""))
 S VALUE=^$W("ZISGDEV","G","PROMPT","CHOICE",ITEM)
 W !,"ION==>>"_VALUE
 S DA=$O(^%ZIS(1,"B",VALUE,0))
 Q:'DA
 S XGIOST=$P($G(^%ZIS(2,+$G(^%ZIS(1,+DA,"SUBTYPE")),0)),"^")
 S XGIOM=+$G(^%ZIS(1,+DA,91)),XGIOSL=$P($G(^(91)),"^",3)
 Q
SELQ ;SELECT/DESELECT QUEUING
 D S^XG("ZISGDEV","G","QTIME","ACTIVE",1)
 Q
DSELQ D S^XG("ZISGDEV","G","QTIME","ACTIVE",0)
 Q
DEV ; Callback for DEV item.
 N REF,ITEM
 S REF="^$W("""_^$EVENT("WINDOW")_""",""G"")"
 W !,^$W("ZISGDEV","G","DEV","VALUE")
 S DEV=^$W("ZISGDEV","G","DEV","VALUE")
 I DEV]"" D
 .N %,%1
 .K ^$W("ZISGDEV","G","PROMPT","VALUE")
 .F %=1:1 Q:'$D(^$W("ZISGDEV","G","PROMPT","CHOICE",%))!(DEV="")  D
 ..S %1=^$W("ZISGDEV","G","PROMPT","CHOICE",%)
 ..I %1=DEV S ^$W("ZISGDEV","G","PROMPT","VALUE",%)="" S DEV="" Q
 ..I %1]DEV S ^$W("ZISGDEV","G","PROMPT","TOPSHOW")=% S DEV="" Q
 S XGION=$S($D(@REF@("DEV","VALUE")):@REF@("DEV","VALUE"),1:"")
 Q
DEVITEM(X) ;
 N %,%1,Y S Y=""
 K ^$W("ZISGDEV","G","PROMPT","VALUE")
 F %=1:1 Q:'$D(^$W("ZISGDEV","G","PROMPT","CHOICE",%))!(X="")  D
 .S %1=^$W("ZISGDEV","G","PROMPT","CHOICE",%)
 .I %1=X!(%1]X) S Y=% S X="" Q
 Q Y
SETST ;Set subtype
 Q
SUB ; Callback for SUB item
 Q
OK ;Callbak for OK button.
 G OK^%ZISG2
MSGOK ;
 K ^$W("MESSAGE")
 ESTOP
 Q
MORE ; Callback for advanced setup.
 Q
HELP ;Callback for help.
 D ^XGLMSG("I","Help is not available at this time.")
 Q
EXIT ; Callback for exit item in menu
 S IOP="^" D ^%ZIS
 ;ESTOP
 D ESTO^XG
 QUIT
INIT ;create names of devices into ACDEV 
 N %,%1,%2
 K TMP("ZISGDEV","G","PROMPT","CHOICE")
 S %1="" F %=1:1 S %1=$O(^%ZIS(1,"B",%1)) Q:%1']""  F %2=0:0 S %2=$O(^%ZIS(1,"B",%1,%2)) Q:%2'>0  S TMP("ZISGDEV","G","PROMPT","CHOICE",%)=%1
 Q
 ;
QTIME ;
 G QTIME^%ZISG2
