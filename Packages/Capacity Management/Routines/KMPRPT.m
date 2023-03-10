KMPRPT ;OAK/RAK - RUM Data by Option/Protocol/RPC ;12/2/05  10:01
 ;;2.0;CAPACITY MANAGEMENT - RUM;**2**;May 28, 2003;Build 12
EN ;-- entry point.
 ;
 N %ZIS,KMPRDATE,KMPRNODE,KMPROPT,KMPRTTL,OUT,POP,X,Y
 N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 ;
 ; title
 S KMPRTTL=" RUM Test Lab Data "
 D HDR^KMPDUTL4(KMPRTTL)
 ; select date
 S KMPRDATE=$$DATE Q:KMPRDATE=""
 ; node
 S KMPRNODE=$P(KMPRDATE,U,2) Q:KMPRNODE=""
 S KMPRDATE=$P(KMPRDATE,U,3) Q:'KMPRDATE
 ; select option
 W !     S KMPROPT=$$OPTION(KMPRNODE,KMPRDATE)
 I KMPROPT="" W $C(7),!?3,"No Options for this Date!" Q
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC=KMPRTTL
 .S ZTRTN="EN1^KMPRPT"
 .S ZTSAVE("KMPRDATE")="",ZTSAVE("KMPRNODE")="",ZTSAVE("KMPROPT")=""
 .S ZTSAVE("KMPRTTL")=""
 .D ^%ZTLOAD W:$G(ZTSK) !,"Task #",ZTSK
 .D EXIT
 ;
 ; if output to terminal display message.
 W:$E(IOST,1,2)="C-" !?3,"compiling data..."
 D EN1
 ;
 Q
 ;
EN1 ;-- entry point from taskman.
 ;
 Q:'$G(KMPRDATE)
 Q:$G(KMPRNODE)=""
 Q:$G(KMPROPT)=""
 ;
 S KMPRTTL=$G(KMPRTTL)
 ;
 K ^TMP($J)
 D DATA,PRINT,EXIT
 K ^TMP($J)
 ;
 Q
 ;
DATA ;-- set data into KMPRARRY
 ;
 Q:'$G(KMPRDATE)
 Q:$G(KMPRNODE)=""
 Q:$G(KMPROPT)=""
 ;
 N CNT,CONT,DATA,DATE,FMHDATE,HDATE,HR,I,JOB,LAB,MINUTES,OPT,OPTION,QUIET
 ;
 S QUIET=$D(ZTQUEUED)
 ;
 K ^TMP($J)
 S FMHDATE=+$$HTFM^XLFDT(KMPRDATE,1)
 ;
 S HR=""
 F  S HR=$O(^KMPTMP("KMPR","DLY",KMPRNODE,KMPRDATE,HR)) Q:HR=""  D 
 .S OPTION=""
 .F  S OPTION=$O(^KMPTMP("KMPR","DLY",KMPRNODE,KMPRDATE,HR,OPTION)) Q:OPTION=""  D 
 ..S OPT=$$OPT(OPTION) Q:OPTION=""
 ..Q:OPT'=KMPROPT
 ..S JOB=0
 ..F  S JOB=$O(^KMPTMP("KMPR","DLY",KMPRNODE,KMPRDATE,HR,OPTION,JOB)) Q:'JOB  D 
 ...;
 ...S DATA=^KMPTMP("KMPR","DLY",KMPRNODE,KMPRDATE,HR,OPTION,JOB)
 ...S MINUTES=$P(DATA,U,10,999)
 ...;
 ...S LAB=""
 ...; if current data is negative
 ...I $P(LAB,U,5)<0 D 
 ....S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"C"),U,5)=$P(LAB,U,5)
 ...;
 ...; if new data is negative
 ...I ($P(DATA,U,5)<0) D 
 ....S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"N"),U,5)=$P(DATA,U,5)
 ...;
 ...; if sum of pieces are negative
 ...I ($P(LAB,U,5)+$P(DATA,U,5))<0 D 
 ....S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"T"),U,5)=($P(LAB,U,5))_"+"_($P(DATA,U,5))_"="_($P(LAB,U,5)+$P(DATA,U,5))
 ...;
 ...; accumulate totals
 ...; data elements - pieces 1 - 8
 ...F I=1:1:8 S $P(LAB,U,I)=$P($G(LAB),U,I)+$P(DATA,U,I)
 ...;
 ...; CNT(1) = minutes  0 = 29
 ...; CNT(2) = minutes 30 = 59
 ...F I=1:1:30 S $P(CNT(1),U,I)=$P(MINUTES,U,I)
 ...F I=31:1:60 S $P(CNT(2),U,(I-30))=$P(MINUTES,U,I)
 ...;
 ...S ^TMP($J,FMHDATE,KMPRNODE,OPT,HR)=LAB
 ...F I=1:1:30 S $P(^TMP($J,FMHDATE,KMPRNODE,OPT,HR,1),U,I)=$P($G(^TMP($J,FMHDATE,KMPRNODE,OPT,HR,1)),U,I)+$P(CNT(1),U,I)
 ...F I=1:1:30 S $P(^TMP($J,FMHDATE,KMPRNODE,OPT,HR,2),U,I)=$P($G(^TMP($J,FMHDATE,KMPRNODE,OPT,HR,2)),U,I)+$P(CNT(2),U,I)
 ...W:'QUIET "."
 ;
 Q
 ;
PRINT ;
 ;
 N DATA,DATE,ELEMENTS,HR,MINUTES,NODE,OCCUR,OPTION
 I '$D(^TMP($J)) W !?3,"No Data to Report!" W @IOF,!?($L(KMPRTTL)\2),KMPRTTL,! Q
 ;
 S DATE=0,CONT=1
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  S NODE="" D  Q:'CONT
 .F  S NODE=$O(^TMP($J,DATE,NODE)) Q:NODE=""  S OPTION="" D  Q:'CONT
 ..F  S OPTION=$O(^TMP($J,DATE,NODE,OPTION)) Q:OPTION=""  S HR=0 D  Q:'CONT
 ...D HDR
 ...F  S HR=$O(^TMP($J,DATE,NODE,OPTION,HR)) Q:'HR  D  Q:'CONT
 ....Q:'$D(^TMP($J,DATE,NODE,OPTION,HR))#10  S DATA=^(HR)
 ....S ELEMENTS=$P(DATA,U,1,8)
 ....S OCCUR=$P(DATA,U,8)
 ....S MINUTES=$P(DATA,U,10,99)
 ....W !,$J(HR,3)
 ....W ?6,$J($FN($S($P(ELEMENTS,U):$P(ELEMENTS,U)/OCCUR,1:$P(ELEMENTS,U)),",",1),5)
 ....W ?14,$J($FN($S($P(ELEMENTS,U,2):$P(ELEMENTS,U,2)/OCCUR,1:$P(ELEMENTS,U,2)),",",1),5)
 ....W ?22,$J($FN($S($P(ELEMENTS,U,3):$P(ELEMENTS,U,3)/OCCUR,1:$P(ELEMENTS,U,3)),",",1),5)
 ....W ?30,$J($FN($S($P(ELEMENTS,U,4):$P(ELEMENTS,U,4)/OCCUR,1:$P(ELEMENTS,U,4)),",",1),5)
 ....W ?41,$J($FN($S($P(ELEMENTS,U,5):$P(ELEMENTS,U,5)/OCCUR,1:$P(ELEMENTS,U,5)),",",1),10)
 ....W ?53,$J($FN($S($P(ELEMENTS,U,6):$P(ELEMENTS,U,6)/OCCUR,1:$P(ELEMENTS,U,6)),",",1),10)
 ....; elapsed time in hr:mn:sc format
 ....S X=$S($P(ELEMENTS,U,7):$P(ELEMENTS,U,7)/OCCUR,1:$P(ELEMENTS,U,7))
 ....W ?65,$J($FN($$TIME(X),",",1),8)
 ....W ?75,$J(OCCUR,3)
 ...D CONTINUE^KMPDUTL4("Press RETURN to continue",3,.CONT)
 Q
 ;
EXIT ;--cleanup
 S:$D(ZTQUEUED) ZTREQ="@"
 K KMPRDATE,KMPRNODE,KMPROPT,KMPRTTL
 ;
 Q
 ;
DATE() ;--extrinsic function - select list of dates
 ;-----------------------------------------------------------------------------
 ; Return: FileManExternalDate^NodeName^$HDate
 ;         "" - no entry selected
 ;-----------------------------------------------------------------------------
 N CNT,DIC,DOT,FMDT,HDT,NODE,X,Y
 K ^TMP("KMPRPT-LIST",$J)
 S NODE="",(CNT,DOT)=0
 F  S NODE=$O(^KMPTMP("KMPR","DLY",NODE)) Q:NODE=""  S HDT=0 D 
 .F  S HDT=$O(^KMPTMP("KMPR","DLY",NODE,HDT)) Q:'HDT  D 
 ..S FMDT=$$FMTE^XLFDT($$HTFM^XLFDT(HDT))
 ..S CNT=CNT+1,DOT=DOT+1 W:'(DOT#100) "."
 ..S ^TMP("KMPRPT-LIST",$J,CNT,0)=FMDT_"^"_NODE_"^"_HDT
 ..S ^TMP("KMPRPT-LIST",$J,"B",FMDT,CNT)=""
 S ^TMP("KMPRPT-LIST",$J,0)="RUM Date^1.01^"_CNT_"^"_CNT
 S DIC="^TMP(""KMPRPT-LIST"",$J,"
 S DIC(0)="E",X="?" D ^DIC
 S DIC(0)="AEQZ"
 S DIC("A")="Select RUM Date: "
 S DIC("W")="W "" - ""_$P(^(0),U,2)"
 D ^DIC
 K ^TMP("KMPRPT-LIST",$J)
 Q $S(Y<1:"",1:$G(Y(0)))
 Q
 Q ""
 ;
HDR ;--header info
 W @IOF
 W ?((80-$L(KMPRTTL))\2),KMPRTTL
 S X=$$FMTE^XLFDT(DATE)
 W !?((80-$L(X))\2),X
 S X="Option: "_OPTION_"   Node: "_NODE
 W !?((80-$L(X)\2)),X
 ;S X="Option: "_OPTION
 ;W !?((80-$L(X))\2),X
 W !
 W !?3,"|---------------------------Per Occurrence------------------------|"
 W !,"Hour",?6," CPU",?14," DIO",?22,"  BIO",?30," Page",?41,"M Commands",?53,"  Global",?65,"Elapsed",?75,"Occ"
 W !?6,"Time",?30,"Faults",?53,"References",?65,"  Time"
 W !,$$REPEAT^XLFSTR("-",IOM)
 ;
 ;
OPTION(KMPRNODE,KMPRDATE) ;--extrinsic function - select list of options to display
 ;-----------------------------------------------------------------------------
 ; KMPRNODE... node
 ; KMPRDATE... date in $h format
 ;
 ; Return: FileManExternalDate^NodeName^$HDate
 ;         "" - no entry selected
 ;-----------------------------------------------------------------------------
 Q:'$G(KMPRDATE) ""
 Q:$G(KMPRNODE)="" ""
 N CNT,DIC,DOT,FMDT,HDT,NODE,X,Y
 K ^TMP("KMPRPT-LIST",$J)
 S HR="",(CNT,DOT)=0
 F  S HR=$O(^KMPTMP("KMPR","DLY",KMPRNODE,KMPRDATE,HR)) Q:HR=""  S OPTION="" D 
 .F  S OPTION=$O(^KMPTMP("KMPR","DLY",KMPRNODE,KMPRDATE,HR,OPTION)) Q:OPTION=""  D 
 ..S OPT=$$OPT(OPTION) Q:OPT=""
 ..Q:$O(^TMP("KMPRPT-LIST",$J,"B",OPT,0))
 ..S CNT=CNT+1,DOT=DOT+1 W:'(DOT#100) "."
 ..S ^TMP("KMPRPT-LIST",$J,CNT,0)=OPT
 ..S ^TMP("KMPRPT-LIST",$J,"B",OPT,CNT)=""
 ;
 Q:'CNT ""
 S ^TMP("KMPRPT-LIST",$J,0)="RUM Option^1.01^"_CNT_"^"_CNT
 S DIC="^TMP(""KMPRPT-LIST"",$J,"
 S DIC(0)="E",X="??" D ^DIC
 S DIC(0)="AEQZ"
 S DIC("A")="Select RUM Option: "
 D ^DIC
 K ^TMP("KMPRPT-LIST",$J)
 Q $S(Y<1:"",1:$G(Y(0)))
 ;
OPT(KMPROPT) ;--extrinsic function - option name
 ;-----------------------------------------------------------------------------
 ; KMPROPT... option name as stored in ^KMPTMP("KMPR","DLY"
 ;
 ; Return: OptionName
 ;         "" - if not option
 ;-----------------------------------------------------------------------------
 Q:$G(KMPROPT)="" ""
 ; quit if protocol
 Q:$E(KMPROPT)="!" ""
 ; quit if job queued
 Q:$E(KMPROPT)="$" ""
 Q $P(KMPROPT,"***")
 ;
TIME(X) ;-- extrinsic function - display time as hr:mn:sc
 Q:'$G(X) 0
 N %
 S %=X,X="" S:%'<86400 X=(%\86400) S:%#86400 X=X_" "_(%#86400\3600)_":"_$E(%#3600\60+100,2,3)_":"_$E(%#60+100,2,3)
 Q X
