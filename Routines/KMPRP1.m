KMPRP1 ;OAK/RAK - RUM Data by Option/Protocol/RPC ;11/29/04  08:47
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
EN ;-- entry point.
 ;
 N %ZIS,CONT,KMPRDATE,KMPROPR,KMPROPT,OUT,POP
 N X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 ;
 S OUT=0
 F  D  Q:OUT
 .D HDR^KMPDUTL4(" RUM Data by Option/Protocol/RPC ")
 .S KMPROPR=$$OPR I 'KMPROPR S OUT=1 Q
 .; select option, protocol or rpc entry
 .S KMPROPT=$$OPRSEL(KMPROPR) Q:'KMPROPT
 .; determine start date from file 8971.1
 .D RUMDATES^KMPRUTL(.KMPRDATE) Q:'KMPRDATE
 .; select output device.
 .S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 .W ! D ^%ZIS I POP W !,"No action taken." Q
 .; if queued.
 .I $D(IO("Q")) K IO("Q") D  Q
 ..S ZTDESC="RUM Data by Option for '"_$P(KMPROPT,U,2)_"'."
 ..S ZTRTN="EN1^KMPRP1"
 ..S ZTSAVE("KMPRDATE")="",ZTSAVE("KMPROPR")="",ZTSAVE("KMPROPT")=""
 ..D ^%ZTLOAD W:$G(ZTSK) !,"Task #",ZTSK
 ..D EXIT
 .;
 .; if output to terminal display message.
 .W:$E(IOST,1,2)="C-" !?3,"compiling data..."
 .D EN1
 ;
 Q
 ;
EN1 ;-- entry point from taskman.
 ;
 Q:'$G(KMPRDATE)
 Q:'$G(KMPROPR)
 Q:$G(KMPROPT)=""
 ;
 N ELEMENT,KMPRARRY,KMPRDAYS
 ;
 ; set elements data into ELEMENT() array.
 D ELEARRY^KMPRUTL("ELEMENT") Q:'$D(ELEMENT)
 S KMPRARRY=$NA(^TMP("KMPR OPT DATA",$J))
 K @KMPRARRY
 D DATA,PRINT,EXIT
 K @KMPRARRY
 ;
 Q
 ;
DATA ;-- set data into KMPRARRY
 Q:'$D(ELEMENT)
 Q:$G(KMPRARRY)=""
 Q:'$G(KMPRDATE)
 Q:'$G(KMPROPR)
 Q:$G(KMPROPT)=""
 ;
 N DATE,END,I,IEN,OPTION,START
 ;
 ; start and end dates.
 S START=$P(KMPRDATE,U),END=$P(KMPRDATE,U,2)
 S DATE=START-.1,KMPRDAYS=0
 F  S DATE=$O(^KMPR(8971.1,"B",DATE)) Q:'DATE!(DATE>END)  D 
 .S IEN=0,KMPRDAYS=KMPRDAYS+1
 .F  S IEN=$O(^KMPR(8971.1,"B",DATE,IEN)) Q:'IEN  D 
 ..Q:'$D(^KMPR(8971.1,IEN,0))  S DATA(0)=^(0),DATA(1)=$G(^(1)),DATA(2)=$G(^(2))
 ..S OPTION=$$OPRCHK(KMPROPR,KMPROPT,DATA(0)) Q:OPTION=""
 ..F I=1:1:8 D 
 ...S $P(@KMPRARRY@(OPTION),U,I)=$P($G(@KMPRARRY@(OPTION)),U,I)+$P(DATA(1),U,I)
 ...S $P(@KMPRARRY@(OPTION),U,I)=$P($G(@KMPRARRY@(OPTION)),U,I)+$P(DATA(2),U,I)
 ;
 Q
 ;
EXIT ;
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K KMPUDATE,KMPUNAM
 ;
 Q
 ;
PRINT ;-- print data from KMPRARRY.
 Q:'$D(ELEMENT)
 Q:$G(KMPRARRY)=""
 ;
 U IO
 ;
 N DATA,OCCUR,I,NUMBER,PIECE,SITE
 ;
 ; facility name.
 S SITE=$$SITE^VASITE
 S SITE=$P(SITE,U,2)_" ("_$P(SITE,U,3)_")"
 ;
 I '$D(@KMPRARRY) D  Q
 .D HDR
 .W !!!?28,"<<<No Data to Report>>>"
 .D CONTINUE^KMPDUTL4("Press RETURN to continue",2,.CONT)
 ;
 S OPTION=""
 F  S OPTION=$O(@KMPRARRY@(OPTION)) Q:OPTION=""  D 
 .D HDR S DATA=@KMPRARRY@(OPTION),I=0,OCCUR=$P(DATA,U,8)
 .F  S I=$O(ELEMENT(I)) Q:'I  D 
 ..W !,$P(ELEMENT(I),U) S PIECE=$P(ELEMENT(I),U,2)
 ..W $$REPEAT^XLFSTR(".",25-$X)
 ..S NUMBER=$P(DATA,U,PIECE)
 ..; per occurrence.
 ..W:OCCUR&(PIECE'=8) ?28,$J($FN(NUMBER/OCCUR,",",$S(I<3:2,1:0)),$S(I<3:14,1:11))
 ..W ?50,$J($FN(NUMBER,",",$S(I<3:2,1:0)),$S(I<3:18,1:15))
 ;
 D CONTINUE^KMPDUTL4("Press RETURN to continue",2,.CONT)
 ;
 Q
 ;
HDR ;
 N TITLE
 W:$Y @IOF
 S TITLE="RUM Data for Option: "_$P(KMPROPT,U,2)
 W !?(80-$L(TITLE)\2),TITLE
 W !?(80-$L($G(SITE))\2),$G(SITE)
 W !?23,"For "_$P($G(KMPRDATE),U,3)_" to "_$P($G(KMPRDATE),U,4)
 W !
 W !?28,"per Occurrence",?50,"         Totals"
 W !
 ;
 Q
 ;
OPR() ;-- extrinsic function - select option, protocol or rpc
 ;-----------------------------------------------------------------------
 ; Return: 1 - Option
 ;         2 - Protocol
 ;         3 - RPC
 ;        "" - No selection made
 ;-----------------------------------------------------------------------
 N DIR,X,Y
 S DIR(0)="SO^1:Option;2:Protocol;3:RPC"
 D ^DIR
 Q $S(Y:Y_"^"_$G(Y(0)),1:"")
 ;
OPRCHK(OPR,OPT,DATA) ;-- extrinsic function - check to see if option, protocol or rpc matches
 ;-----------------------------------------------------------------------
 ; OPR.... Results from $$OPR above.
 ; OPT.... Option, protocol or rpc name to be matched
 ; DATA... Zero node of file 8971.1 (RESOURCE USAGE MONITOR)
 ;
 ; Return: OptionName - match
 ;                 "" - no match
 ;-----------------------------------------------------------------------
 Q:$G(OPR)="" ""
 Q:'OPR!($P(OPR,U,2)="") ""
 Q:'$D(DATA) ""
 Q:(+OPR)<1!((+OPR)>3) ""
 N OPTION
 ; option - piece 4, protocol - piece 5, rpc - piece7
 S OPTION=$S((+OPR)=1:$P(DATA,U,4),(+OPR)=2:$P(DATA,U,5),1:$P(DATA,U,7))
 Q $S(OPTION="":"",OPTION'=$P(OPT,U,2):"",1:OPTION)
 ;
OPRSEL(OPR) ;-- extrinsic function - select entry
 ;-----------------------------------------------------------------------
 ; OPT.... Results from $$OPR above.
 ;
 ; Return: IEN^Name - this will be from the Option file, Protocol file,
 ;                    or RPC file, depending on the value of OPR.
 ;         "" - no selection made
 ;-----------------------------------------------------------------------
 Q:'$G(OPR) ""
 Q:OPR<1!(OPR>3) ""
 N DIC,X,Y
 ; 1 - option, 2 - protocol, 3 - rpc
 S DIC=$S((+OPR)=1:19,(+OPR)=2:101,1:8994)
 S DIC(0)="AEMQZ",DIC("A")="Select "_$P(OPR,U,2)_": "
 W ! D ^DIC
 Q $S(Y<0:"",1:+Y_"^"_Y(0,0))
