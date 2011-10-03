XWBDLOG ;ISF/RWF - Debug Logging for Broker ;12/08/2004  08:54
 ;;1.1;RPC BROKER;**35**;Mar 28, 1997
 Q
 ;
 ;Setup the log, Clear the log location.
LOGSTART(RTN) ;Clear the debug log
 Q:'$G(XWBDEBUG)
 K ^XTMP("XWBLOG"_$J)
 S ^XTMP("XWBLOG"_$J,0)=$$HTFM^XLFDT($$HADD^XLFDT($H,7))_"^"_$$DT^XLFDT
 S ^XTMP("XWBLOG"_$J,.1)=0
 D LOG("Log start: "_$$HTE^XLFDT($H)),LOG(RTN)
 Q
LOG(MSG) ;Record Debug Info
 Q:'$G(XWBDEBUG)
 N CNT
 S CNT=1+$G(^XTMP("XWBLOG"_$J,.1)),^(.1)=CNT,^(CNT)=$E($H_"^"_MSG,1,255)
 Q
 ;
 ;
VIEW ;View log files
 N DIRUT,XWB,DIR,IX,X,CON
 D HOME^%ZIS
 W !,"Log Files"
 S XWB="XWBLOG",CON=""
 F  S XWB=$O(^XTMP(XWB)) Q:XWB'["XWBLOG"  D
 . D V1(.XWB)
 . I $$WAIT(.CON) S:CON=3 XWB="XWC"
 . Q
 Q
 ;
V1(XWB) ;View one log
 N IX,X,CNT
 S IX=.9,X=$G(^XTMP(XWB,IX)),CON=0,CNT=+$G(^XTMP(XWB,.1))
 Q:CNT<1
 W !!,"Log from Job ",$E(XWB,7,99)," ",CNT," Lines"
 F  S IX=$O(^XTMP(XWB,IX)) Q:'$L(IX)  S X=^XTMP(XWB,IX) D VL1(IX,X)
 Q
 ;
VL1(J,K) ;Write a line
 I $Y'<IOSL,$$WAIT(.CON) S IX="A" S:CON=3 XWB="XWC" Q
 Q:'$D(^XTMP(XWB,IX))
 N H,D,T,I
 S H=$P($$HTE^XLFDT($P(K,"^"),"2S"),"@",2)_" = "
 S D=$P(K,"^",2,99),K=D
 I D?.E1C.E D
 . S D=""
 . F I=1:1:$L(K) S T=$A(K,I),D=D_$S(T>31:$E(K,I),1:"\"_$E((1000+T),3,4))
 S T=$L(H)
 F  W !,H,?T,$E(D,1,68) S H="",D=$E(D,69,999) Q:'$L(D)
 Q
 ;
WAIT(CON) ;continue/kill/exit
 S DIR("?")="Enter RETURN to continue, Next for next log, Kill to remove log, Exit to quit log view."
 S DIR("A")="Return to continue, Next log, Exit: "
 S DIR(0)="SAB^1:Continue;2:Next;3:Exit;4:Kill",DIR("B")="Continue"
 D ^DIR
 S CON=+Y
 I Y=4 D K1(XWB,0) H 1
 I Y=1 W @IOF
 Q Y>1
 ;
K1(REF,S) ;Kill one
 I REF["XWBLOG" K ^XTMP(REF)
 I 'S W !,"Log "_REF_" deleted."
 Q
 ;
KILLALL ;KILL ALL LOG Entries
 N DIR,XWB
 S DIR(0)="Y",DIR("A")="Remove all XWB log entries",DIR("B")="No"
 D ^DIR Q:Y'=1
 S XWB="XWBLOG"
 F  S XWB=$O(^XTMP(XWB)) Q:XWB'["XWBLOG"  D K1(XWB,1)
 W !,"Done"
 Q
