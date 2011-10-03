KMPDHUA ;OAK/RAK - Remote Synchronous HL7 Protocol ;3/15/04  07:48
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
EN ;-entry point
 ;
 N DIC,I,KMPDATE,KMPDNMSP,KMPDPROT,KMPDSRCH,POP,X,Y
 N ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 ;
 ; option header
 D HDR^KMPDUTL4(" Synchronous Remote Protocol Distribution ") W !!
 ; select protocol
 S DIC=101,DIC(0)="AELMQZ",DIC("A")="Select Protocol: "
 D ^DIC Q:(+Y)<0  S KMPDPROT=Y
 ;
 ; select namespace (package file)
 D NMSPARRY(.KMPDNMSP) Q:'$D(KMPDNMSP)
 ;
 ; select date range
 D DATERNG^KMPDUTL2(.KMPDATE) Q:'KMPDATE
 ;
 ; element to rate protocols
 K DIR
 S DIR(0)="SO^1:Message Size;2:Character Transmission Rate;3:Message Transmission Rate"
 S DIR("B")=1
 D ^DIR Q:$G(Y)=""!($G(Y)="^")
 S KMPDSRCH=$S(Y:Y_"^"_$G(Y(0)),1:Y)
 ;
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC="Synchronous Distribution Report"
 .S ZTRTN="EN1^KMPDHUA"
 .F I="KMPDATE","KMPDNMSP","KMPDPROT","KMPDSRCH" S ZTSAVE(I)=""
 .D ^%ZTLOAD W:$G(ZTSK) !,"Task #",ZTSK
 .D EXIT
 ;
 D EN1
 ;
 Q
 ;
EN1 ;-- entry point from taskman
 ;
 Q:'$G(KMPDATE)
 Q:'$D(KMPDNMSP)
 Q:'$G(KMPDSRCH)
 ;
 N END,ERROR,STR,X
 ;
 S STR=$P(KMPDATE,U),END=$P(KMPDATE,U,2)
 Q:'STR!('END)
 ;
 ; get data from hl7 api
 W:'$D(ZTQUEUED) !,"Gathering HL7 data..."
 K ^TMP("KMPDH",$J),^TMP("KMPDH-1",$J)
 ;
 D DATA,PRINT,EXIT
 ;
 Q
 ;
DATA ;
 ; if 'all' namespaces
 I $G(KMPDNMSP(0))="*" D 
 .S X=$$CMF^HLUCM(STR,END,1,KMPDPROT,"KMPDH","EITHER",.ERROR)
 ; if 'specific' namespaces
 E  D 
 .S X=$$CMF^HLUCM(STR,END,.KMPDNMSP,KMPDPROT,"KMPDH","BOTH",.ERROR)
 ;
 ; determine search list
 S FAC=""
 F  S FAC=$O(^TMP("KMPDH",$J,"RFAC","LR","R",FAC)) Q:FAC=""  D 
 .S NMSP=""
 .F  S NMSP=$O(^TMP("KMPDH",$J,"RFAC","LR","R",FAC,NMSP)) Q:NMSP=""  S TOT=^(NMSP) D 
 ..; 1 - message size = chr/message
 ..; 2 - charater transmission rate - chr/sec/msg
 ..; 3 - message transmission rate - sec/msg
 ..S SRCH=""
 ..I (+KMPDSRCH)=1 S SRCH=$P(TOT,U)/$P(TOT,U,2)
 ..I (+KMPDSRCH)=2 S SRCH=($P(TOT,U)/$P(TOT,U,3))/$P(TOT,U,2)
 ..I (+KMPDSRCH)=3 S SRCH=$P(TOT,U,3)/$P(TOT,U,2)
 ..Q:SRCH=""
 ..S ^TMP("KMPDH-1",$J,SRCH,FAC,NMSP)=""
 ;
 Q
 ;
EXIT ;
 S:$D(ZTQUEUED) ZTREQ="@"
 K KMPDATE,KMPDNMSP,KMPDPROT,KMPDSRCH
 K ^TMP("KMPDH",$J),^TMP("KMPDH-1",$J)
 D ^%ZISC
 Q
 ;
PRINT ;-- print sync/facility data
 N DATA,DATE,FAC,I,J,NMSP,PROT,RANK,SRCH
 D HDR
 I '$D(^TMP("KMPDH-1",$J)) W !?5," No Data to Report" Q
 S SRCH="A",RANK=1
 F  S SRCH=$O(^TMP("KMPDH-1",$J,SRCH),-1) Q:'SRCH  D 
 .W !,RANK,".",?5,$J($FN(SRCH,",",$S((+KMPDSRCH)=3:2,1:0)),10)
 .S FAC="",RANK=RANK+1
 .F  S FAC=$O(^TMP("KMPDH-1",$J,SRCH,FAC)) Q:FAC=""  D 
 ..W ?17,$E($P(FAC,"~",2),1,18) S NMSP=""
 ..F  S NMSP=$O(^TMP("KMPDH-1",$J,SRCH,FAC,NMSP)) Q:NMSP=""  D 
 ...W ?37,NMSP S DATE=0 K TOT
 ...F  S DATE=$O(^TMP("KMPDH",$J,"RFAC","LR","R",FAC,NMSP,DATE)) Q:'DATE  D 
 ....S PROT=""
 ....F  S PROT=$O(^TMP("KMPDH",$J,"RFAC","LR","R",FAC,NMSP,DATE,PROT)) Q:PROT=""  S DATA=^(PROT) D 
 .....; tcp/mail/unknown
 .....S DATA("T")=$G(^TMP("KMPDH",$J,"HR","TM","T",FAC,DATE,NMSP,PROT))
 .....S DATA("M")=$G(^TMP("KMPDH",$J,"HR","TM","M",FAC,DATE,NMSP,PROT))
 .....S DATA("TMU")=$G(^TMP("KMPDH",$J,"HR","TM","U",FAC,DATE,NMSP,PROT))
 .....; incoming/outgoing/unknown
 .....S DATA("I")=$G(^TMP("KMPDH",$J,"NMSP","IO","I",FAC,NMSP,DATE,PROT))
 .....S DATA("O")=$G(^TMP("KMPDH",$J,"NMSP","IO","O",FAC,NMSP,DATE,PROT))
 .....S DATA("IOU")=$G(^TMP("KMPDH",$J,"NMSP","IO","U",FAC,NMSP,DATE,PROT))
 .....; calculate sub-totals
 .....F I=1:1:3 D 
 ......S $P(TOT,U,I)=$P($G(TOT),U,I)+$P(DATA,U,I)
 ......S $P(TOT("T"),U,I)=$P($G(TOT("T")),U,I)+$P(DATA("T"),U,I)
 ......S $P(TOT("M"),U,I)=$P($G(TOT("M")),U,I)+$P(DATA("M"),U,I)
 ......S $P(TOT("TMU"),U,I)=$P($G(TOT("TMU")),U,I)+$P(DATA("TMU"),U,I)
 ......S $P(TOT("I"),U,I)=$P($G(TOT("I")),U,I)+$P(DATA("I"),U,I)
 ......S $P(TOT("O"),U,I)=$P($G(TOT("O")),U,I)+$P(DATA("O"),U,I)
 ......S $P(TOT("IOU"),U,I)=$P($G(TOT("IOU")),U,I)+$P(DATA("IOU"),U,I)
 ...;
 ...; back to NMSP level
 ...;
 ...W ?45,$J($FN($P(TOT,U),",",0),9)
 ...W ?56,$J($FN($P(TOT,U,2),",",0),9)
 ...W ?67,$J($FN($P(TOT,U,3),",",0),9)
 ...W !
 ...F I="T","M","TMU","I","O","IOU" D 
 ....W ! W:I="I"!(I="L") !
 ....W ?21,$S(I="T":"TCP",I="M":"Mail",I="TMU":"T/M Unknown",1:"")
 ....W ?21,$S(I="I":"Incoming",I="O":"Outgoing",I="IOU":"I/O Unknown",1:"")
 ....F J=1:1:3 W ?$S(J=1:45,J=2:56,1:67),$J($FN($P($G(TOT(I)),U,J),",",0),9)
 ..W !
 ;
 Q
 ;
HDR ;
 S KMPDATE=$G(KMPDATE)
 S KMPDPROT=$G(KMPDPROT)
 S KMPDSRCH=$G(KMPDSRCH)
 W @IOF
 N X
 S X=$$SITE^VASITE,X=$P(X,U,2)_" ("_$P(X,U)_")"
 W !?(80-$L(X)\2),X,?62,"Printed: ",$$FMTE^XLFDT(DT,2)
 W !?21,"Synchronous Remote Protocol Distribution"
 S X="'"_$P(KMPDPROT,"^",2)_"'"
 W !?((80-$L(X))\2),X
 S X=$P($P(KMPDATE,U,3),"@")_": "_$P($P(KMPDATE,U,3),"@",2)
 S X=X_" - "_$P($P(KMPDATE,U,4),"@")_": "_$P($P(KMPDATE,U,4),"@",2)
 W !?(80-$L(X)\2),X
 S X=$P(KMPDSRCH,U)_" - "_$P(KMPDSRCH,U,2)
 W !?((80-$L(X))\2),X
 S X=$S((+KMPDSRCH)=1:"  Chr/Msg",(+KMPDSRCH)=2:"Ch/Sc/Mg",(+KMPDSRCH)=3:"  Sec/Msg",1:"OTHER")
 W !
 W !,"Rank",?6,X,?17,"Remote Facility",?37,"Nmsp",?45,$J("Chrs",9),?56,$J("Messages",9),?67,$J("Seconds",9)
 W !,"----",?6,"---------",?17,"------------------",?37,"----",?45,"---------",?56,"---------",?67,"---------"
 ;
 Q
 ;
NMSPARRY(KMPDNMSP) ;-- namespace arry
 K KMPDNMSP
 N DIC,NM1,NMSP,PKG,X,Y
 S DIC=9.4,DIC(0)="AEMQZ",DIC("A")="Select Namespace: "
 W ! D SELECT^KMPDUT4("KMPDNMSP",1,5)
 Q:$G(KMPDNMSP(0))=""
 Q:KMPDNMSP(0)'="*"&($O(KMPDNMSP(0))="")
 I KMPDNMSP(0)'="*" K KMPDNMSP(0),NM1 D 
 .S I="" F  S I=$O(KMPDNMSP(I)) Q:I=""  S PKG=KMPDNMSP(I) D:PKG 
 ..S NMSP=$P($G(^DIC(9.4,PKG,0)),U,2)
 ..S:NMSP'="" NM1(NMSP)=PKG
 ..K KMPDNMSP(I)
 .M KMPDNMSP=NM1
 ;
 Q
