%ZISG2 ;SFISC/AC -- Device Handler Prototype
 ;;8.0T3
LOAD ;LOAD TMP ARRAY
 S %=$G(^$E("WINDOW")) I $L(%) S %PARENT("PARENT")=%
 I '$D(XGWIN) D PREP^XG
 D GET^XGCLOAD("ZISG DEVICE W1","ZISGDEV","TMP")
 D GET^XGCLOAD("ZISG DEVICE TRM","ZISGTRM","TMP")
 D GET^XGCLOAD("ZISG DEVICE SPL","ZISGSPL","TMP")
 D GET^XGCLOAD("ZISG DEVICE SDP","ZISGSDP","TMP")
 D GET^XGCLOAD("ZISG DEVICE HFS","ZISGHFS","TMP")
 D GET^XGCLOAD("ZISG DEVICE MT","ZISGMT","TMP")
 S TMP("ZISGDEV","G","QDTIME","TITLE")=""
 Q
B1 ;OLD B1 CODE FROM ZISG ROUTINE
 ;;I '^$W("ZISGDEV","G","PROMPT","VISIBLE") D
 ;;.S ^$W("ZISGDEV","G","PROMPT","VALUE")=^$W("ZISGDEV","G","DEV","VALUE")
 ;;.S ^$W("ZISGDEV","G","PROMPT","VISIBLE")=1
 ;;.;S ^$W("ZISGDEV","G","QFRAME","VISIBLE")=0
 ;;E  D
 ;;.S ^$W("ZISGDEV","G","PROMPT","VISIBLE")=0
 ;;.;S ^$W("ZISGDEV","G","QFRAME","VISIBLE")=1
 ;;.S ITEM=$O(^$W("ZISGDEV","G","PROMPT","VALUE",""))
 ;;.I ITEM S ^$W("ZISGDEV","G","DEV","VALUE")=^$W("ZISGDEV","G","PROMPT","CHOICE",ITEM)
 Q
B2 ;;I '^$W("ZISGTRM","G","SUBTYPE","VISIBLE") D
 ;;.S ^$W("ZISGTRM","G","SUBTYPE","VALUE")=^$W("ZISGTRM","G","SUB","VALUE")
 ;;.;S ^$W("ZISGTRM","G","MARGIN","ACTIVE")=0
 ;;.S ^$W("ZISGTRM","G","SUBTYPE","VISIBLE")=1
 ;;E  D
 ;;.S ^$W("ZISGTRM","G","SUBTYPE","VISIBLE")=0
 ;;.;S ^$W("ZISGTRM","G","MARGIN","ACTIVE")=1
 ;;.S ITEM=$O(^$W("ZISGTRM","G","SUBTYPE","VALUE",""))
 ;;.I ITEM S ^$W("ZISGTRM","G","SUB","VALUE")=^$W("ZISGTRM","G","SUBTYPE","CHOICE",ITEM)
 Q
OK ;Callbak for OK button.
 N REF
 S REF=XGWIN_"("""_@XGEVENT@("WINDOW")_""",""G"")"
 S IOP=$S($G(@REF@("QUEUE","VALUE")):"Q;",1:"")
 I $G(@REF@("QUEUE","VALUE")),$G(@REF@("QTIME","VALUE"))="NOW"!($G(@REF@("QDTIME","TITLE"))="") S ZTDTH=$H
 S XGION=$S($D(@REF@("DEV","VALUE")):@REF@("DEV","VALUE"),1:"")
 I XGION="" D ^XGLMSG("E","You have not selected a device.") Q
 ;ENTER RETRIEVE TYPE INFO HERE:
 S XGDA=""
 I '$D(XGION) D
 .S XGION=$S($D(^$W("ZISGDEV","G","DEV","VALUE")):^$W("ZISGDEV","G","DEV","VALUE"),1:"")
 S:$G(XGION)]"" XGDA=$O(^%ZIS(1,"B",XGION,0))
 S XGIOT=$G(^%ZIS(1,+XGDA,"TYPE"))
 W !,"XGION==>>"_XGION
 W !,"XGIOT==>>"_XGIOT
 ;G @XGIOT
TRM ;W:$D(@REF@("PROMPT","VALUE")) !,@REF@("PROMPT","VALUE"),@REF@("PROMPT","CHOICE",+$O(@REF@("PROMPT","VALUE","")))
 S REF=XGWIN_"(""ZISGTRM"",""G"")"
 W !,"REF==>>"_REF
 ;
 S XGIOST=$S($D(@REF@("SUB","VALUE")):@REF@("SUB","VALUE"),1:"")
 W !,"SUB==>>"_XGIOST
 ;W:$D(^$W("ZISGTRM","G","SUBTYPE","VALUE")) !,^$W("ZISGTRM","G","SUBTYPE","CHOICE",+$O(^$W("ZISGTRM","G","SUBTYPE","VALUE","")))
 ;W:$D(@REF@("SUBTYPE","VALUE")) !,@REF@("SUBTYPE","VALUE"),@REF@("PROMPT","CHOICE",+$O(@REF@("SUBTYPE","VALUE","")))
 ;
 S XGIOM=$S($D(@REF@("MARGINVAL","VALUE")):@REF@("MARGINVAL","VALUE"),1:"")
 W !,XGIOM
 S XGIOSL=$S($D(@REF@("PAGELENGTHVAL","VALUE")):@REF@("PAGELENGTHVAL","VALUE"),1:"")
 W !,XGIOSL
 W !,"ZTDTH==>>"_$G(ZTDTH)
 S IOP=IOP_XGION
 I XGIOT="SPL" S %=0 D  Q:%
 .I '$D(DUZ) D ^XGLMSG("E","Your DUZ is not defined!") S %=1 Q
 .I $S($D(^VA(200,DUZ,"SPL")):$E(^("SPL"),1),1:"N")'["y" D
 ..D ^XGLMSG("E","You aren't an authorized SPOOLER user.") S %=1 Q
 I XGIOT="SPL" S IOP=IOP_";"_XGDOC
 S:XGIOST]"" IOP=IOP_";"_XGIOST
 S:XGIOM]""!(XGIOSL]"") IOP=IOP_";"_XGIOM_";"_XGIOSL
 W !,"IOP==>>"_IOP
 S %ZIS="Q" D ^%ZIS
 G ERRMSG:POP
 ;ESTOP
 D ESTO^XG
 Q
ERRMSG ;Pop-up error message.
 D ^XGLMSG("E","THIS DEVICE IS BUSY")
 Q
QTIME ;
 S X=^$W("ZISGDEV","G","QTIME","VALUE")
 D ASK I Y=-1 D DTHLP Q
 W !,"ZTDTH==>>"_ZTDTH
 N %H
 S %H=ZTDTH D YX^%DTC
 S Y="("_Y_")"
 S ^$W("ZISGDEV","G","QDTIME","TITLE")=Y
 Q
 ;
ASK ;GET--ask for start time
 I $D(ZTQUEUED) D:ZTDTH]""  Q
 . S %DT="FRS",X=ZTDTH D ^%DT S ZTDTH=$$%H^%ZTLOAD2(+Y)
 . Q
 S %DT="RSX"
 I $D(ZTNOGO) D NEXT^XQ92 I X="" D  Q
 .N %
 .S %="Output is never allowed for this option!"
 .D ^XGLMSG("W",%) S ZTDTH="" Q
 I $D(ZTNOGO) S Y=X,%DT="S" D DD^%DT S %DT("B")=Y,%DT="RSX"
 I $D(ZTNOGO),'$D(XQNOGO) D
 .N %
 .S %="Output from this option is restricted during certain times"
 .D ^XGLMSG("W",%)
 D ^%DT I $D(ZTNOGO) D
 .S ZT=Y,X=Y
 .D ^XQ92 S Y=ZT Q:X]""
 .N % S %="That is a restricted time!"
 .D ^XGLMSG("W",%)
 K %DT,%T,X5
 S ZTDTH=$$%H^%ZTLOAD2(+Y) Q
 Q
DTHLP ;Help for Date input
 N I
 F I=1:1 S Y=$T(Z+I) Q:Y=""  S %(I)=$P(Y,";",3,999)
 K ^$EVENT("OK")
 D ^XGLMSG("I",.%)
 W !,^$DI($PD,"FOCUS")
 S ^$DI($PD,"FOCUS")="ZISGDEV,QTIME"
 Q
Z ;
 ;;Examples of Valid Dates:
 ;;  JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057
 ;;  T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7,  etc.
 ;;  T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc.
 ;;If the year is omitted, the computer uses the CURRENT YEAR.
 ;;If the date is omitted, the current date is assumed.
 ;;Follow the date with a time, such as JAN 20@10, T@10AM, 10:30, etc.
 ;;You may enter a time, such as NOON, MIDNIGHT or NOW.
 ;;Seconds may be entered as 10:30:30 or 103030AM.
 ;;Time is REQUIRED in this response.
