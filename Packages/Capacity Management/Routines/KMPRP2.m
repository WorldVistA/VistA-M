KMPRP2 ;OAK/KAK - RUM Hourly Occurrences Distribution ;11/29/04  11:57
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
EN ;-- entry point
 ;
 N %ZIS,CONT,DATA,DIR,HR,KMPRDATE,KMPROPR,KMPROPT,OUT,POP
 N STRT,USER,X,Y
 ;
 S OUT=0
 F  D  Q:OUT
 .D HDR^KMPDUTL4(" Hourly Occurrence Distribution ") W !
 .S KMPROPR=$$OPR
 .I 'KMPROPR S OUT=1 Q
 .;
 .; select option, protocol or rpc entry
 .S KMPROPT=$$OPRSEL(KMPROPR) Q:'KMPROPT
 .;
 .; determine date from file 8971.1
 .S STRT=$O(^KMPR(8971.1,"B",0))
 .S DIR(0)="DO^"_STRT_":"_DT
 .S DIR("A")="Select DATE ",DIR("?")=" ",DIR("?",1)="Enter a date."
 .W !
 .D ^DIR
 .I $D(DIRUT) Q
 .S KMPRDATE=Y
 .S $P(KMPRDATE,U,2)=$$FMTE^XLFDT(Y)
 .;
 .; select output device
 .S %ZIS="Q",%ZIS("A")="Device: "
 .W ! D ^%ZIS I POP W !,"No action taken." Q
 .; if queued
 .I $D(IO("Q")) D  Q
 ..N ZTDESC,ZTRTN,ZTSAVE
 ..K IO("Q")
 ..S ZTDESC="RUM Hourly Occurrence Distribution"
 ..S ZTRTN="EN1^KMPRP2"
 ..S ZTSAVE("KMPRDATE")="",ZTSAVE("KMPROPR")="",ZTSAVE("KMPROPT")=""
 ..D ^%ZTLOAD
 ..W:$G(ZTSK) !,"Task #",ZTSK
 ..D EXIT
 .;
 .D EN1
 Q
 ;
EN1 ;-- entry point from taskman
 ;
 Q:'$G(KMPRDATE)
 Q:'$G(KMPROPR)
 Q:$G(KMPROPT)=""
 ;
 D DATA,PRINT,EXIT
 ;
 Q
 ;
DATA ;-- set data
 Q:'$G(KMPRDATE)
 Q:'$G(KMPROPR)
 Q:$G(KMPROPT)=""
 ;
 N DATA,DOT,END,I,IEN,JOB,NODE,OCCUR,OPT,OPT1,OPTION,PT
 K ^TMP($J)
 ;
 S CONT=1,DOT=0
 W:$E(IOST,1,2)="C-" !?2,"Compiling data..."
 ;
 I +KMPRDATE=DT D TODAY,EXIT Q
 ;
 S IEN=0
 F  S IEN=$O(^KMPR(8971.1,"B",+KMPRDATE,IEN)) Q:'IEN  D 
 .S DOT=DOT+1
 .W:'(DOT#100)&($E(IOST,1,2)="C-") "."
 .;
 .Q:'$D(^KMPR(8971.1,IEN,0))
 .;
 .S DATA(0)=^KMPR(8971.1,IEN,0),NODE=$P(DATA(0),U,3)
 .;I DATA(0)["SCMC PCMM GUI WORKSTATION" W DATA(0),!
 .S OPTION=$$OPRCHK(KMPROPR,KMPROPT,DATA(0))
 .Q:OPTION=""
 .;
 .S DATA(1.1)=$G(^KMPR(8971.1,IEN,1.1)),DATA(1.2)=$G(^(1.2)),DATA(2.1)=$G(^(2.1)),DATA(2.2)=$G(^(2.2))
 .;I DATA(0)["SCMC PCMM GUI WORKSTATION" W DATA(0),!
 .;
 .F I=1:1:24 D
 ..S $P(^TMP($J,"HR",NODE),U,I)=$P($G(^TMP($J,"HR",NODE)),U,I)+$P(DATA(1.1),U,I)+$P(DATA(2.1),U,I)
 ..S $P(^TMP($J,"HR",NODE,"USER"),U,I)=$P($G(^TMP($J,"HR",NODE,"USER")),U,I)+$P(DATA(1.2),U,I)+$P(DATA(2.2),U,I)
 ;
 Q
 ;
TODAY ;
 ; 1 - option, 2 - protocol, 3 - rpc
 I +KMPROPR=1 S OPT1=$P(KMPROPT,U,2)_"***"
 I +KMPROPR=2 S OPT1="***"_$P(KMPROPT,U,2)
 I +KMPROPR=3 S OPT1="`"_$P(KMPROPT,U,2)_"***"
 ;
 S NODE=""
 F  S NODE=$O(^KMPTMP("KMPR","DLY",NODE)) Q:NODE=""  D
 .S ^TMP($J,"HR",NODE)=""
 .S OPT=""
 .F  S OPT=$O(^KMPTMP("KMPR","DLY",NODE,+$H,OPT)) Q:OPT=""  D
 ..S DOT=DOT+1
 ..W:'(DOT#100)&($E(IOST,1,2)="C-") "."
 ..;
 ..I OPT[OPT1!((+KMPROPR=1)&(OPT[("!"_OPT1))) D
 ...;W OPT,!
 ...; if searching options do not count option***protocol
 ...I (+KMPROPR=1)&($P(OPT,"***",2)'="") Q
 ...;
 ...S JOB=""
 ...F  S JOB=$O(^KMPTMP("KMPR","DLY",NODE,+$H,OPT,JOB)) Q:JOB=""  D
 ....S PT=""
 ....F  S PT=$O(^KMPTMP("KMPR","DLY",NODE,+$H,OPT,JOB,PT)) Q:PT=""  S DATA=^(PT) D
 .....F I=10:1:33 S OCCUR=$P(DATA,U,I) I +OCCUR D
 ......S $P(^TMP($J,"HR",NODE),U,I-9)=$P(^TMP($J,"HR",NODE),U,I-9)+OCCUR
 ......S $P(^TMP($J,"HR",NODE,"USER"),U,I-9)=$P($G(^TMP($J,"HR",NODE,"USER")),U,I-9)+1
 ;
 Q
 ;
EXIT ;
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K ^TMP($J)
 ;
 Q
 ;
PRINT ;-- print data
 ;
 U IO
 ;
 N LINE,NODE,NOWFM,NOWHR,OCCUR,SITE,TIME,TOTOCC,TOTUSR,USER
 ;
 ; facility name
 S SITE=$$SITE^VASITE
 S SITE=$P(SITE,U,2)_" ("_$P(SITE,U,3)_")"
 ;
 S $P(LINE,"=",IOM)="="
 ;
 D HDR
 ;
 I '$D(^TMP($J,"HR")) D  Q
 .W !,?28,"<<<No Data to Report>>>",!!
 .D CONTINUE^KMPDUTL4("Press RETURN to continue",1,.CONT)
 ;
 I +KMPRDATE=DT D
 .S NOWFM=$$HTFM^XLFDT($H)
 .S NOWHR=+$E($P(NOWFM,".",2),1,2)
 F TIME=0:1:23 D  Q:'CONT
 .W ?2,$S(TIME<10:"0",1:""),TIME,?7
 .I +KMPRDATE=DT I TIME>NOWHR D  Q
 ..W ?10,"<<<No Data>>>",!
 ..I $Y>(IOSL-3) D
 ...D CONTINUE^KMPDUTL4("Press RETURN to continue or '^' to exit",1,.CONT)
 ...D:CONT HDR
 .S NODE="",(TOTOCC,TOTUSR)=0
 .F  S NODE=$O(^TMP($J,"HR",NODE)) Q:NODE=""  D
 ..S OCCUR=$P(^TMP($J,"HR",NODE),U,TIME+1),TOTOCC=TOTOCC+OCCUR
 ..S USER=$P($G(^TMP($J,"HR",NODE,"USER")),U,TIME+1),TOTUSR=TOTUSR+USER
 ..W $J($FN(OCCUR,",",0),9)
 .W $J($FN(TOTOCC,",",0),9),$J($FN(TOTUSR,",",0),9)
 .I +KMPRDATE=DT I TIME=NOWHR W "  <<<Partial Data>>>"
 .W !
 .I $Y>(IOSL-3) D
 ..D CONTINUE^KMPDUTL4("Press RETURN to continue or '^' to exit",1,.CONT)
 ..D:CONT HDR
 ;
 D:CONT CONTINUE^KMPDUTL4("Press RETURN to continue",1,.CONT)
 Q
 ;
HDR ;
 N NODE,TITLE,X
 S TITLE="Hourly Occurrence Distribution for "_$P(KMPROPT,U,2)
 W:$Y @IOF W !
 W ?(80-$L($G(SITE))\2),$G(SITE),!
 W ?(80-$L(TITLE)\2),TITLE,!
 W ?31,"For "_$P($G(KMPRDATE),U,2),!!
 W LINE,!," Hour",?10
 S NODE=""
 F  S NODE=$O(^TMP($J,"HR",NODE)) Q:NODE=""  D
 .W "  ",$S($E(NODE,1,3)=+NODE:" "_$E(NODE,$L(NODE)-2,$L(NODE)),1:$E(NODE,$L(NODE)-3,$L(NODE))),"   "
 S X=$X
 W " Total    Total",!
 W ?X,"  Occ      User",!,LINE,!
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
 ;
 S DIR(0)="SO^1:Option/Task;2:Protocol;3:RPC"
 D ^DIR
 ;
 Q $S(Y:Y_"^"_$G(Y(0)),1:"")
 ;
OPRCHK(OPR,OPT,DATA) ;-- extrinsic function
 ;- check to see if option, protocol or rpc matches
 ;-----------------------------------------------------------------------
 ; OPR.... Results from $$OPR above
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
 ;
 N OPTION
 ;
 ; option - piece 4, protocol - piece 5, rpc - piece 7
 S OPTION=$S((+OPR=1):$P(DATA,U,4),(+OPR=2):$P(DATA,U,5),1:$P(DATA,U,7))
 ;
 Q $S(OPTION="":"",OPTION'=$P(OPT,U,2):"",(+OPR=1)&($P(DATA,U,5)'=""):"",1:OPTION)
 ;
OPRSEL(OPR) ;-- extrinsic function - select entry
 ;-----------------------------------------------------------------------
 ; OPT.... Results from $$OPR above
 ;
 ; Return: IEN^Name - this will be from the Option file, Protocol file,
 ;                    or RPC file, depending on the value of OPR
 ;         "" - no selection made
 ;-----------------------------------------------------------------------
 Q:'$G(OPR) ""
 Q:OPR<1!(OPR>3) ""
 ;
 N DIC,X,Y
 ;
 W !
 ; 1 - option, 2 - protocol, 3 - rpc
 S DIC=$S((+OPR)=1:19,(+OPR)=2:101,1:8994)
 S DIC(0)="AEMQZ",DIC("A")="Select "_$P(OPR,U,2)_": "
 D ^DIC
 ;
 Q $S(Y<0:"",1:+Y_"^"_Y(0,0))
