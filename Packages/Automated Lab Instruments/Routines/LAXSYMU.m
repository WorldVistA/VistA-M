LAXSYMU ;MLD/ABBOTT/SLC/RAF - AxSYM INTERFACE Utility Routine; 6/12/96 0900
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**11,19**;Sep 27, 1994
 ;
 ; This routine serves as general UTILITY routine for the AxSYM
 ; interface.  While not as efficient as all code being in ONE
 ; routine, portability requirements must be met.       /mld
 ;
 Q  ; call line tag
 ;
UPDT ; To LA global ($TR used to remove CTRL chars from LAFRAM)
 L +^LA(INST,"I")
 I '$D(^LA(INST,"I")) X $G(^LAB(62.4,INST,1)) ; runs LAXSYM (LA->LAH)
 S:'$D(^LA(INST,"I"))#2 ^LA(INST,"I")=0,^("I",0)=0
 S CNT=$G(^LA(INST,"I"))+1,^("I")=CNT,^("I",CNT)=$TR(LAFRAM,LANOCTL1)
 K LAFRAM,X
 S LAFRAME="",LARETRY=0,LALINK=0
 L -^LA(INST,"I")
 Q
 ;
CKSUM(S,MOD) ; convert string (S) to decimal num (N) then to 
 ;         hex modulo 16**MOD (def=2=256)
 N I,HX,HXN,DIV,N S N=0,DIV=1 S:'$D(MOD) MOD=2
 F I=1:1:$L(S) S N=N+$A(S,I) ; get ASCII chars in string S
 F I=1:1:MOD S DIV=16*DIV ;    get MOD value (def=16*16)
 S HX=N#DIV,N=""
 F  Q:HX=0  S HXN=HX#16,HX=HX\16,N=$S(HXN>9:$E("ABCDEF",HXN#10+1),1:HXN)_N
 S N="00000000"_N,N=$E(N,$L(N)-MOD+1,$L(N))
 Q N
 ;
SEND(N) ; Send reply msg (ACK, NAK, etc.)
 W $C(N)
 D:DEBUG DEBG(N,"O")
 Q
 ;
DEBG(A,B) ; DEBuG tool - capture all data going in & out.  (Def=OFF)
 ; A=data that went out/came in  B="I"=IN; "O"=OUT
 N MSG,CT
 S MSG=$S(B="I":"IN: ",1:"OUT: ")_A_" %^% "_$H
 S (CT,^LA(DEB,0))=$G(^LA(DEB,0))+1,^LA(DEB,CT)=MSG
 Q
 ;
NAK(M) ; send NAK and retry (M = error 'type', EOT, STX, etc.)
 S ^LA(INST,"ERR",$H,M)=LAFRAME ; capture
 S LAFRAME="",LARETRY=LARETRY+1 ; increment # retries
 I LARETRY=7 D SEND(EOT),@("SET^"_LANM) Q  ; too many NAK's - goto idle
 I 'LALINK S LAFRNM=$S(LAFRNM:LAFRNM-1,1:7) ; LALINK=1 on 1ST frame
 K LAFRAM,X
 D SEND(NAK)
 Q
 ;
LA1INIT ; Init vars only for LAXSYM
 S X="TRAP^"_LANM,@^%ZOSF("TRAP"),I=0,LANOCTL1=""
 S ALPHA="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 F  S I=$O(TC(I)) Q:'I  I $G(TC(I,4)) S LATEST(TC(I,4),TC(I,0))=I
 F I=1:1:31 S LANOCTL1=LANOCTL1_$C(I) ; ctl chars
 Q
 ;
 ; Continuation of LAPORT33 (LANM) due to size req'mts /mld
INIT ; initialize various parameters for the AxSYM
 ;
 S (HOME,T,TSK,INST)=+$E(LANM,7,8),LANOCTL1=""
 S X="TRAP^"_LANM,@^%ZOSF("TRAP"),DUZ=.5,LANOCTL2=""
 S DEB="D"_INST,OUT="",BASE=0,OK=0
 S TOUT=5,U="^",(LADEV,IOP)=$G(^LAB(62.4,INST,.75))
 I $D(^LA(INST,"R")) D  Q:$D(^LA(INST,"R"))
 .S LRCHK=^LA(INST,"R") H 35 S LRCHK1=^LA(INST,"R") D
 ..I LRCHK'=LRCHK1 S ^LA(INST,"ERR",$H)="LAPORT"_INST_" is already running ...aborted" K LRCHK,LRCHK1 Q
 ..I LRCHK=LRCHK1 K LRCHK,LRCHK1,^LA(INST,"R"),^LA("LOCK","D"_INST) Q
 ;
 H 1 ; allows calling routine to close port before opening again
 I LADEV="" D  Q
 .S ^LA(INST,"ERR",$H)="DIRECT DEVICE field is empty!  aborted"
ZIS D ^%ZIS I POP D  Q
 .S ^LA(INST,"ERR",$H)=LADEV_" was busy .... aborted"
 ;
 ; set READ timeout, terminating chars, max character count
 S NUL=0,SOH=1,STX=2,ETX=3,EOT=4,ENQ=5,ACK=6,NAK=21,ETB=23,LF=10,CR=13
 S (CNT,LARETRY,LAFRNM)=0,LATOUT=75,DEBUG=0,OK=1
 S LACRLF=$C(CR)_$C(LF),LACRETX=$C(CR)_$C(ETX)
 F I=3,13,23 S LANOCTL1=LANOCTL1_$C(I) ; to remove ctl chars from LAFRAM
 ; LANOCTL2=restricted chars - 3,4,13,23 (ETX,EOT,CR,ETB) are OK
 F I=1,2,5:1:12,14:1:22,24:1:31 S LANOCTL2=LANOCTL2_$C(I)
 ; start fresh
 K ^LA(INST,"ERR"),^LA(INST,"ERX")
 I $D(^LA(DEB,0)) K ^LA(DEB) S ^LA(DEB,0)=0 ;clean out debug node
 S ^LA(INST,"R")=$H,^LA("LOCK","D"_INST)=$J ; running flag
 Q
 ;
BKGND ; Entry point to start ANY bi-directional background job /mld
 N DIC,DIR,DIRUT,LRDASH,LRJOB,LRJOBIO,LRJOBN,LRJOBNM,T,X,Y,ZTSK
 S IOP=0 D ^%ZIS
 S $P(LRDASH,"-",IOM)=""
 S DIC=62.4,DIC(0)="AEMQ",DIC("S")="I Y<99,$G(^(.75))]""""" D ^DIC K DIC
 I Y<1 W !,"NO JOB SELECTED",! H 1 QUIT
 S LRJOBN=+Y,LRJOBNM=$P(Y,"^",2),LRJOB="LAPORT"_LRJOBN
 S (LRJOBIO,X)=$G(^LAB(62.4,LRJOBN,.75)) ; direct device field
 S IOP=X,%ZIS="" D ^%ZIS
 I POP D  H 1 QUIT
 .D HOME^%ZIS
 .W !!,?3,$C(7),"Unable to open ",LRJOBIO," for instrument ",LRJOBNM,"."
 .W !,?3,"This would indicate that the interface is already running.",!
 D ^%ZISC
 W !!
 S DIR(0)="Y0",DIR("A")="Start the direct connect "_LRJOBNM_" interface now",DIR("B")="NO"
 D ^DIR K DIR Q:Y'=1
 S ZTRTN=LRJOB,ZTIO=LRJOBIO,ZTDTH=$H,ZTDESC="Lab Direct Connect Port"_LRJOBN
 K ^LA("LOCK","D"_LRJOBN)
 D ^%ZTLOAD
 W !,"Lab Direct Connect Interface for ",LRJOBNM,$S($D(ZTSK):"",1:" NOT")," tasked to start",!
 I $G(ZTSK) W "Task #",ZTSK,!
 Q
