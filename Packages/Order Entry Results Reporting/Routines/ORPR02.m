ORPR02 ; slc/dcm/rv - Dances with Prints ;09/13/06  13:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,260**;Dec 17, 1997;Build 26
PRINT(ORVP,ARAY,SARAY,LOC,SELECT,ALTPRAM,NOQUE,ORTIMES) ;Decisions
 ;ORVP=DFN;DPT(
 ;ARAY=Name of global storing list of orders or just the local aray
 ;@ARAY@(#)=ORIFN;DA of action       - Array of orders to print
 ;SARAY(PKG,ORIFN)=Device ptr^# of copies  (used by Consults service copies)
 ;LOC=Location (ORL)
 ;SELECT=Set for desired reports (chart^label^req^service^work)
 ;ALTPRAM=Alternate for PARAM variable (overrides internal parameters):
 ;        PROMPT CC^CC DEVICE^L DEVICE^R DEVICE^PROMPT L^PROMPT R^PROMPT W^W DEVICE
 ;NOQUE=1 to force interactive device selection; used for service copies
 ;ORTIMES=# of copies
 N PARAM,IFN,ORPARAY,VAR
 S ORPARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 I '$G(ORVP) S ORVP=$$PAT(.ARAY) I '$G(ORVP) S VAR("ARAY")="" D EN^ORERR("PRINT~ORPR02 called with invalid ORVP",,.VAR) G END
 I '$L($G(LOC)) S LOC=$$LOC(.ARAY) I 'LOC S VAR("ARAY")="" D EN^ORERR("PRINT~ORPR02 called with invalid LOC",,.VAR) G END
 I $S('$O(@ORPARAY@(0)):1,+$G(LOC)'>0:1,1:0),'$D(SARAY) G END
 N ORAL,ORIFN
 K ^TMP("ORAL",$J)
 S PARAM=$S($L($G(ALTPRAM)):ALTPRAM,1:""),ORAL="^TMP(""ORAL"",$J)"
 D:'$L($G(ALTPRAM)) PARAM($G(LOC))
 D ARAY(.ARAY)
 I '$D(SELECT) D CHART(.ARAY,PARAM),LABEL(.ORAL,PARAM,$G(ORTIMES)),REQ(.ORAL,PARAM),SERV(.ORAL,PARAM,.SARAY,$G(NOQUE)),WORK(.ARAY,PARAM) G END
 I $D(SELECT) D CHART(.ARAY,PARAM):$P(SELECT,"^"),LABEL(.ORAL,PARAM,$G(ORTIMES)):$P(SELECT,"^",2),REQ(.ORAL,PARAM):$P(SELECT,"^",3),SERV(.ORAL,PARAM,.SARAY,$G(NOQUE)):$P(SELECT,"^",4),WORK(.ARAY,PARAM):$P(SELECT,"^",5)
 G END
CHART(ARAY,PARAM) ;Chart copies
 ;ARAY=Array of orders to print
 ;PARAM=Print parameters based on location
 S ARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 I $L($P(PARAM,"^"))!($L($P(PARAM,"^",2))) S X=$$DEVICE($P(PARAM,"^")_"^CHART COPY",$P(PARAM,"^",2),"C1^ORPR03")
 Q
WORK(ARAY,PARAM) ;Work Copy
 S ARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 I $L($P(PARAM,"^",7))!($L($P(PARAM,"^",8))) S X=$$DEVICE($P(PARAM,"^",7)_"^WORK COPY",$P(PARAM,"^",8),"W1^ORPR03")
 Q
LABEL(ARAY,PARAM,ORTIMES) ;Labels
 N ORPLF,ORTKG,ORPRMT
 S ARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 I $L($P(PARAM,"^",3))!$L($P(PARAM,"^",5)) D
 . S (ORPLF,ORTKG)=0
 . I $O(@ARAY@(0)) F  S ORTKG=$O(@ARAY@(ORTKG)) Q:ORTKG'>0!(ORPLF)  D
 .. S ORPLF=$S($$GET^XPAR("SYS","ORPF WARD LABEL FORMAT",ORTKG,"I"):1,1:0)
 . S ORPRMT=$S(ORPLF:$P(PARAM,"^",5),1:"*")_"^LABELS"
 . S X=$$DEVICE(ORPRMT,$P(PARAM,"^",3),"L1^ORPR03",$G(ORTIMES))
 Q
REQ(ARAY,PARAM) ;Requisitions
 N ORPLF,ORTKG,ORPRMT,ORIFN,ORDLG
 S ARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 I $L($P(PARAM,"^",4))!$L($P(PARAM,"^",6)) D
 . S (ORPLF,ORTKG)=0
 . I $O(@ARAY@(0)) F  S ORTKG=$O(@ARAY@(ORTKG)) Q:ORTKG'>0!(ORPLF)  D
 .. S ORPLF=$S($$GET^XPAR("SYS","ORPF WARD REQUISITION FORMAT",ORTKG,"I"):1,1:0)
 .. I ORTKG=$O(^DIC(9.4,"B","DIETETICS",0)) D
 ... S ORIFN=0 F  S ORIFN=$O(@ARAY@(ORTKG,ORIFN)) Q:'ORIFN  D
 .... S ORDLG=+$P(^OR(100,+ORIFN,0),U,5)
 .... I ORDLG'=$O(^ORD(101.41,"B","FHW SPECIAL MEAL",0)) S ORPLF=0
 . S ORPRMT=$S(ORPLF:$P(PARAM,"^",6),1:"*")_"^REQUISITIONS"
 . S X=$$DEVICE(ORPRMT,$P(PARAM,"^",4),"R1^ORPR03")
 Q
SERV(ARAY,PARAM,SARAY,NOQUE) ;Service copies
 N ZTRTN,ZTSAVE,ZTIO,ZTDTH,ZTSK,GLOB
 S ARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 S GLOB=$S($E(ARAY)="^":$E(ARAY,1,$L(ARAY)-1)_",",1:ARAY_"(")
 I $O(@ARAY@(0)) D
 . I $G(NOQUE)'=1 D  Q
 .. S ZTRTN="SVCOPY^ORPR03()",(ZTSAVE("CHART"),ZTSAVE("ORVP"),ZTSAVE("ARAY"),ZTSAVE(GLOB),ZTSAVE("PARAM"),ZTSAVE("SARAY("),ZTSAVE("ORPRES"),ZTSAVE("LOC"),ZTSAVE("LOC("),ZTIO)="",ZTDTH=$H
 .. S ZTDESC="Service copy root task" D ^%ZTLOAD
 . D SVCOPY^ORPR03(1)
 Q
END ;Leave
 D HOME^%ZIS
 Q
DEVICE(PRMT,DEF,ZTRTN,ORTIMES) ; Gets device for output
 ;PRMT=Prompt?^Report name
 ;DEF=Print device
 ;ZTRTN=Routine
 ;ORTIMES=# of copies
 N %ZIS,DIC,DIR,IOP,FORCEQUE,X,Y,ZTIO,ZTDESC,ZTDTH,OREND,GLOB,ORIOPTR,ORION
 I $P(PRMT,"^")="*" Q 1
 I $P(PRMT,"^")=0,'$G(DEF) Q 1
 I +PRMT S DIR("A")="Print "_$P(PRMT,"^",2)_" for the orders: ",DIR("B")="YES",DIR("?")="Answer YES to have "_$P(PRMT,"^",2)_" printed for the orders.",DIR(0)="YA" D ^DIR I 'Y Q 1
 I +$G(DEF)>0 D
 . N X,DIC
 . S X="`"_+DEF,DIC(0)="NX",DIC=3.5
 . D ^DIC
 . I Y<1 S %ZIS("A")=$P(PRMT,"^",2)_"Print DEVICE: " Q
 . S:+PRMT=1 %ZIS("B")=$P(Y,"^",2)
 . S ORION=$P(Y,"^",2)
 . S:+PRMT=0!(+PRMT=2) ORIOPTR="`"_+Y,%ZIS="QN"
 I $L($G(ARAY)) S GLOB=$S($E(ARAY)="^":$E(ARAY,1,$L(ARAY)-1)_",",1:ARAY_"("),ZTSAVE(GLOB)="",ZTSAVE("ARAY")=""
 S (ZTSAVE("ORTIMES"),ZTSAVE("ORTKG"),ZTSAVE("ORVP"),ZTSAVE("ORPRES"),ZTSAVE("ORSEQ"),ZTSAVE("ORCUM("),ZTSAVE("LOC"),ZTSAVE("LOC("),ZTSAVE("ORRACT"))="",ZTDESC=$P(PRMT,"^",2)
 S:+PRMT'=1 FORCEQUE=1,ZTDTH=$H
 D QUE^ORUTL1(ZTRTN,ZTDESC,.ZTSAVE,$G(ORIOPTR),$G(ZTDTH),.%ZIS,$G(FORCEQUE),1,$G(ORION))
 Q ""
PAT(ARAY) ;Get patient if not passed
 S ARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 Q:'$O(@ARAY@(0)) ""
 S X=$O(@ARAY@(0)),X=$P($G(^OR(100,+@ARAY@(X),0)),"^",2)
 Q X
LOC(ARAY) ;Get location if not passed
 S ARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 Q:'$O(@ARAY@(0)) ""
 S X=$O(@ARAY@(0)),X=$P($G(^OR(100,+@ARAY@(X),0)),"^",10)
 Q X
TEST ;Test call
 N DALE,OREND S OREND=0
 K ^TMP("ORPARAY",$J)
 F ORI=6752:0 S ORI=$O(^OR(100,ORI)) Q:ORI<1!(ORI>8000)  S ^TMP("ORPARAY",$J,ORI)=ORI_";1"
 W @IOF
 D PRINT("","^TMP(""ORPARAY"",$J)","","","1^1^1^1^1")
 ;D GUI("^TMP(""ORPARAY"",$J)",63,"C",,1)
 K ^TMP("ORPARAY",$J)
 Q
PARAM(LOC) ;Get Print parameters
 ;LOC=Ptr to location SC(42,LOC,
 ;Returns Parameters in PARAM
 ;PARAM=Prompt for CC^CC device^L Device^R Device^Prompt for L^Prompt for R^Prompt for W^WC device
 Q:'$G(LOC)
 F I="ORPF PROMPT FOR CHART COPY","ORPF CHART COPY PRINT DEVICE","ORPF LABEL PRINT DEVICE","ORPF REQUISITION PRINT DEVICE","ORPF PROMPT FOR LABELS","ORPF PROMPT FOR REQUISITIONS","ORPF PROMPT FOR WORK COPY","ORPF WORK COPY PRINT DEVICE" D
 . S PARAM=PARAM_$$GET^XPAR("ALL^"_+LOC_";SC(",I,1,"I")_"^"
 Q
ARAY(ARAY) ;Set aray up by package in ^TMP("ORAL",$J,package,orifn;action)
 S ARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY")
 N X,IFN S IFN=0
 F  S IFN=$O(@ARAY@(IFN)) Q:IFN<1  S X=$G(^OR(100,+@ARAY@(IFN),0)) K:$P(X,"^",2)'=ORVP @ARAY@(IFN) I +X,$P(X,"^",2)=ORVP,$P(X,"^",14) S ^TMP("ORAL",$J,$P(X,"^",14),@ARAY@(IFN))=""
 Q
GUI(ARAY,DEVICE,FMT,LOC,TASK,ORTIMES) ;Silence of the Prints
 ;ARAY=Name of global storing list of orders or just the local aray
 ;@ARAY@(#)=ORIFN;DA of action       - Array of orders to print
 ;DEVICE=printer (internal ptr value)
 ;FMT=C:Chart copy, L:Labels, R:Requisitions, S:Service copies W:Work copies
 ;LOC=Location (ORL)
 ;TASK=1 to not task, 0 or undefined to task (default)
 ;     this affects the closing of devices in ^ORPR03
 ;ORTIMES=# of copies
 N ORPARAY,VAR
 S ORPARAY=$S($L($G(ARAY))&('$G(ARAY)):ARAY,1:"ARAY"),ARAY=ORPARAY
 Q:'$O(@ORPARAY@(0))  Q:'$D(IO)  Q:'$D(FMT)  Q:FMT=""  Q:"CLRSW"'[FMT
 N ORAL,ORVP,X,ZTRTN
 K ^TMP("ORAL",$J)
 S ORVP=$$PAT(.ARAY),ORAL="^TMP(""ORAL"",$J)"
 I 'ORVP S VAR("ARAY")="" D EN^ORERR("GUI~ORPR02 called with invalid ORVP",,.VAR) Q
 I '$G(LOC) S LOC=$$LOC(.ARAY)
 D ARAY(.ARAY)
 I "WC"'[FMT K ARAY S ARAY=ORAL
 S X=0_"^"_$S(FMT="L":"Labels",FMT="R":"Requisitions",FMT="S":"Service Copies",FMT="C":"Chart Copies",FMT="W":"Work Copies",1:"")
 S ZTRTN=$S(FMT="S":"SVCOPY^ORPR03()",1:FMT_"1^ORPR03")
 S:FMT="S" TASK=1
 I $G(TASK) D @ZTRTN Q
 I '$G(TASK) S X=$$DEVICE(X,DEVICE,ZTRTN)
 Q
