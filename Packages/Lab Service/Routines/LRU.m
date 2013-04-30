LRU ;DALOI/STAFF - LAB UTILITY ;05/11/10  15:14
 ;;5.2;LAB SERVICE;**1,72,201,248,350**;Sep 27, 1994;Build 230
 ;
 ;Reference to ^DIC(4 supported by IA #10090
 ;Reference to ^XMB(1 supported by IA #10091
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to ^%DT supported by IA #10003
 ;Reference to ^%ZIS supported by IA #10086
 ;Reference to ^DIC supported by IA #10006
 ;Reference to ^DIE supported by IA #10018
 ;Reference to PID^VADPT6 supported by IA #10062
 ;Reference to $$FMTE^XLFDT supported by IA #10103
 ;
 S X="T",%DT="" D ^%DT,D S H(10)=Y
 Q
 ;
 ;
LOCK ;Set and kill lock for ^DIE call. If lock fails LR("CK")=1 is set.
 N LRLOKVAR
 I '$D(DIE) S LR("CK")=1 Q
 D CK I '$G(LR("CK")) D ^DIE K LR("CK") D FRE
 Q
 ;
 ;
CK ;
 D:$D(LRLOKVAR)#2 FRE
 S LRLOKVAR=DIE_DA_")" L +@(LRLOKVAR):DILOCKTM
 I '$T D
 . W !,$C(7),"ANOTHER TERMINAL IS EDITING THIS ENTRY!" S LR("CK")=1
 . K LRLOKVAR
 Q
 ;
 ;
FRE I $D(LRLOKVAR) L -@(LRLOKVAR) K LRLOKVAR
 Q
 ;
F ;
 S LRQ=LRQ+1,X="N",%DT="T" D ^%DT,D^LRU
 ;Suppress unnecessary form feeds
 I $G(LRSS)'="BB" W:IOST?1"C".E!($D(LR("F"))) @IOF
 W:$G(LRSS)="BB" @IOF
 W !,Y,?22,LRQ(1),?(IOM-10),"Pg: ",LRQ
 Q
 ;
 ;
M R !,"'^' TO STOP: ",X:DTIME S:'$T!(X["^") LR("Q")=1
 W $C(13),$J("",15),$C(13)
 Q
 ;
 ;
T ; Returns the Month/Day
 Q:'Y  S Y=Y_"000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_$S(Y[".":" "_$E(Y,9,10)_":"_$E(Y,11,12),1:"")
 Q
 ;
 ;
A ; Returns Date in format mm/dd/yyyy with time if a time is passed.
 Q:'Y  S Y=$$FMTE^XLFDT(Y,"5M")
 I $L($P(Y,"/"))=1 S $P(Y,"/")="0"_$P(Y,"/") ;--> pad for 2 digit day
 I $L($P(Y,"/",2))=1 S $P(Y,"/",2)="0"_$P(Y,"/",2) ;--> pad for 2 digit month
 Q
 ;
 ;
D ; Returns date in eye-readable month format
 S Y=$TR($$FMTE^XLFDT(Y,"M"),"@"," ")
 Q
 ;
 ;
DA ; Returns date in eye-readable month format
 S Y=$$FMTE^XLFDT(Y,"M")
 Q
 ;
 ;
DT ; If Blood Bank maintain existing display, else display 4 digit year.
 I $G(LRSS)="BB" S Y=Y_"000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_" "_$S(Y[".":$E(Y,9,10)_":"_$E(Y,11,12),1:"") Q
 D A
 Q
 ;
 ;
SSN ;
 S (SSN,SSN(1),SSN(2))=$G(SSN)
 I '$G(LRDPF),$G(LRDFN) S:$P($G(^LR(+LRDFN,0)),U,2) LRDPF=+$P(^(0),U,2)
 S (VA("BID"),VA("PID"))="" G:'$G(LRDPF)!(+$G(LRDPF)'=2) SSNFM
 N I,X,Y,N
 I $D(DFN) D PID^VADPT6 S (SSN,SSN(2))=VA("PID"),SSN(1)=VA("BID")
 ;
SSNFM ;
 S SSN(2)=$TR(SSN,"-","")
 ;I $G(DUZ("AG"))'="","NAFARMY"[DUZ("AG") D  Q
 ;. S SSN=$S($L(SSN)<11:$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10),1:$E(SSN,10,11)_"/"_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9))
 ;. S SSN(1)=$S($P(SSN,"-",3):$P(SSN,"-",3),1:$E(SSN,9,12))
 ;
 ; Setup identifier for PATIENT (#2) file related entry
 I $G(LRDPF)=2,$G(DFN)="" D
 . S:$L(SSN)>8 SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,99)
 . S SSN(1)=$S($P(SSN,"-",3):$P(SSN,"-",3),$L($E(SSN,($L(SSN)-3),$L(SSN))):$E(SSN,($L(SSN)-3),$L(SSN)),1:"????")
 . S:'$L(SSN) SSN="?"
 ;
 ; Setup identifier for non-PATIENT (#2) file related entry
 I $G(LRDPF)'=2 D
 . I SSN?9N.1A S SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,99)
 . S SSN(1)=$S($P(SSN,"-",3):$P(SSN,"-",3),$L($E(SSN,($L(SSN)-3),$L(SSN))):$E(SSN,($L(SSN)-3),$L(SSN)),1:"????")
 ;
 I SSN="" S SSN="?"
 ;
 Q
 ;
 ;
B D LRU S %DT="AEX",%DT(0)="-N",%DT("A")="Start with Date TODAY// " D ^%DT K %DT I X="" S Y=DT W H(10)
 Q:Y<1  S LRSDT=Y
 S %DT="AEX",%DT("A")="Go    to   Date TODAY// " D ^%DT K %DT I X="" S Y=DT W H(10)
 Q:Y<1  S LRLDT=Y I LRSDT>LRLDT S X=LRSDT,LRSDT=LRLDT,LRLDT=X
 S Y=LRSDT D D^LRU S LRSTR=Y,Y=LRLDT D D^LRU S LRLST=Y
 Q
 ;
 ;
YN W "? ",$P("YES// ^NO// ","^",%) S LR("%1")=%
RX R %Y:$S($D(DTIME):DTIME,1:99999) E  S DTOUT=1,%Y="^" W $C(7)
 S:%Y]""!'% %=$A(%Y),%=$S(%=89:1,%=121:1,%=78:2,%=110:2,%=94:-1,1:0)
 I %Y="@"!(%Y="S") S %=-1 Q
 I '%,%Y]"" W $C(7),!?4,"ANSWER 'YES', 'NO', '^', '@'",!?4,"or press RETURN key to accept default response (if one)" S:$D(LR("%1")) %=LR("%1") W !! G YN
 W:$X>73 ! W $P("  (YES)^  (NO)","^",%) K LR("%1")
 Q
 ;
 ;
XR Q:'$D(LRSS)  S LRXR="A"_LRSS,LRXREF=LRXR_"A"
 Q
 ;
 ;
WAIT W !!,"..."
 W $P("HMMM^EXCUSE ME ^SORRY","^",$R(3)+1),", ",$P("THIS MAY TAKE A WHILE^LET ME PUT YOU ON 'HOLD' ^HOLD ON^JUST A MOMENT PLEASE^I'M WORKING AS FAST AS I CAN^LET ME THINK ABOUT THAT ","^",$R(6)+1)_"..."
 H 1
 Q
 ;
 ;
K K A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,V,W,X,Y,Z
 Q
 ;
 ;
V ; Cleanup variables
 ;
 ; Task background job to create messages
 I $D(^LAHM(62.49,"AC")) D
 . N ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTDESC,ZTSK
 . S ZTIO="",ZTRTN="ORU^LA7VMSG",ZTDTH=$H,ZTDESC="Send Lab LEDI HL7 Result Message to collecting site"
 . D ^%ZTLOAD
 ;
 D K
 K %,%DT,%X,%Y,A,AGE,DO,D1,DA,DE,DFN,DG,DI,DIC,DIE,DIR,DIRUT
 K DIWF,DIWL,DLAYGO,DOB,DR,DTOUT,DX,LR,LRA,LRAA,LRABO,LRABV
 K LRAC,LRAD,LRADM,LRADX,LRAN,LRAP,LRAPX,LRAU,LRAWRD,LRAX,LRB,LRBL
 K LRBLT,LRC,LRCAP,LRCAPA,LRCAPLOC,LRCPT,LRCS,LRD,LRDATA
 K LRDATE,LRDFN,LRDPAF,LRDPF,LRDTI,LRE,LREND,LREP,LREXP
 K LRF,LRFLN,LRFNAM,LRFND,LRG,LRH,LRI,LRIDT,LRIFN,LRJ
 K LRK,LRL,LRLDT,LRLIDT,LRLLOC,LRLOKVAR,LRLST,LRM
 K LRMD,LRN,LRND,LRNO,LRNOP,LRO,LRODT,LROLLOC,LROPT,LRORU3
 K LRP,LRPABO,LRPF,LRPFN,LRPMOD,LRPNM,LRPPT,LRPRAC
 K LRPRH,LRPTF,LRQ,LRQA,LRR,LRRB,LRRC,LRRMD,LRS,LRSA,LRSAV
 K LRSD,LRSDT,LRSEL,LRSET,LRSF,LRSIT,LRSN,LRSOP,LRSS,LRST
 K LRSTR,LRSVC,LRT,LRTK,LRTOD,LRTREA,LRTS,LRU,LRV,LRW
 K LRWARD,LRWD,LRWHN,LRWHO,LRWRD,LRWW,LRX,LRXR,LRXREF
 K LRY,LRZ,PNM,POP,SEX,SSN,VA,VADM,VAIN
 K ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 K ^UTILITY($J),^TMP($J),^TMP("LRBL",$J),^TMP("LR",$J)
 Q
 ;
 ;
LRAD ;
 S X=$P(^LRO(68,LRAA,0),"^",3),(Y,LRAD)=$S(X="Y":$E(Y,1,3)_"0000","M"[X:$E(Y,1,5)_"00","Q"[X:$E(Y,1,3)_"0000"+(($E(Y,4,5)-1)\3*300+100),1:Y)
 D D^LRU S LRH(0)=Y
 Q
 ;
 ;
H W !,$C(7),"TO SORT IN SEQUENCE, STARTING FROM A CERTAIN NAME,",!?7,"TYPE THAT NAME"
 Q
 ;
 ;
H1 W !,$C(7),"TO SORT ONLY UP TO A CERTAIN NAME,",!?7,"TYPE THAT NAME"
 Q
 ;
 ;
L ;
 D:'$D(IOM) I
 K LR("%")
 S LR("%")="-",$P(LR("%"),"-",IOM-1)="-"
 Q
 ;
 ;
L1 ;
 D:'$D(IOM) I
 K LR("%1")
 S LR("%1")="=",$P(LR("%1"),"=",IOM-1)="="
 Q
 ;
 ;
I ;
 S IOP="HOME" D ^%ZIS
 Q
 ;
 ;
S S (LR("Q"),LRQ)=0,LRQ(1)=$$INS
 Q
 ;
 ;
INS() ;Set institution Name from ^XMB
 N Y
 S Y=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),U,17),0)),U)
 Q Y
 ;
 ;
INSN() ;Set primary institution number from ^XMB
 N Y
 S Y=+$P($G(^XMB(1,1,"XUS")),U,17)
 Q Y
 ;
 ;
DUZ2 ;Allow user to change Division [DUZ(2)] value
 N A
 S A(1)="*** THIS OPTION IS NO LONGER AVAILABLE ***",A(1,"F")="!?18"
 S A(2)="Use Kernel option 'Change my Division' [XUSER DIV CHG]",A(2,"F")="!?18"
 D EN^DDIOL(.A)
 Q
