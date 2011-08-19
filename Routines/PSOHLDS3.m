PSOHLDS3 ;BHAM ISC/SAB,LC,PWC - BUILD PROFILE FOR AUTOMATED INTERFACE ;4/13/05 1:53pm
 ;;7.0;OUTPATIENT PHARMACY;**156,198**;DEC 1997
 ;reference to PSDRUG suppoprted by DBIA # 221
 ;reference to PS(50.606 supported by DBIA # 2174
 ;reference to PS(50.7 supported by DBIA #2223
 ;reference to PS(55 supported by DBIA # 2228
 ;reference to PS(56 supported by DBIA # 2229
 ;
 ;PSO*198 add check to insert spaces into PMI segments, also add
 ;        "NTE|6||" to beginning of NTE6 segment
 ;
START ;build profile for the NTE4 segment
 Q:'$D(DFN)
 N II K ^TMP($J,"PRF")
 S PSODFN=DFN I '$D(PSODTCUT) D CUTDATE^PSOFUNC
 S:'$D(Z) Z=1 S:'$D(NEW1) (NEW1,NEW11)="^" S %DT="",X="T" D ^%DT S DT1=Y S X1=DT1,X2=-365 D C^%DTC S EXPS=X S X1=DT1,X2=-182 D C^%DTC S EXP=X
 F RXX=0:0 S RXX=$O(^PS(55,DFN,"P",RXX)) Q:'RXX  S RXNN=+^(RXX,0) I $D(^PSRX(RXNN,0)),$P($G(^("STA")),"^")'=13 S RXPX=^PSRX(RXNN,0),$P(RXPX,"^",15)=$P($G(^("STA")),"^"),RXPX2=^(2) D CHK
 I '$D(^TMP($J,"PRF")) G PPP
 ;
SD S CNT=1 F SD="A","C","S" I $D(^TMP($J,"PRF",SD)) S DRNME="" D DRNME
PPP D PEND
 K ^TMP($J,"PRF")
 K A,B,DRNME,DRP,EXP,EXPS,I,II,ISSD,J,LINE,LN,MESS,MJK,NEW1,NEW11,PHYS,POP,PQTY,TTTT,RFL,RFS,RXF,RXNN,RXPX,RXPX2,RXPNO,RXX
 K SD,SIG,STA,X,X1,X2,Y,Z,CNT,PEND,PSODTCUT,PSOPRPAS,PZZODRUG,RFDATE
 Q
DRNME S DRNME=$O(^TMP($J,"PRF",SD,DRNME)) Q:DRNME=""  D ISSD G DRNME
 ;
ISSD F ISSD=0:0 S ISSD=$O(^TMP($J,"PRF",SD,DRNME,ISSD)) Q:'ISSD  S RXPNO="" D RXPNO
 Q
RXPNO S RXPNO=$O(^TMP($J,"PRF",SD,DRNME,ISSD,RXPNO)) Q:RXPNO=""  S RXNN=^(RXPNO) I $D(^PSRX(RXNN,0)) S RXPX=^(0),RXPX2=^(2) D PRT G RXPNO
 ;
CHK Q:PSODTCUT>$P(RXPX2,"^",6)
 I $P(^PSRX(RXNN,"STA"),"^")=12 S II=RXNN D LAST^PSORFL Q:PSODTCUT>RFDATE
 I $P(RXPX,"^",3)=7!($P(RXPX,"^",3)=8)&('PSOPRPAS) Q
 S J="^"_RXNN_"^" Q:(NEW1[J)!(NEW11[J)  Q:$P(RXPX,"^",13)<EXPS  S RXPNO=$P(RXPX,"^"),ISSD=$P(RXPX,"^",13)
 Q:'$D(^PSDRUG($P(RXPX,"^",6),0))  S DRP=^(0),SD=$S($P(DRP,"^",3)["S":"S",$P(RXPX,"^",15)=12:"C",1:"A"),DRNME=$P(DRP,"^"),^TMP($J,"PRF",SD,DRNME,ISSD,RXPNO)=RXNN
 Q
PRT S RFS=$P(RXPX,"^",9),PQTY=$P(RXPX,"^",7)
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=$P(RXPX,"^",4) D ^DIC
 S PHYS=$S(+Y:$P(Y,"^",2),1:"UNKNOWN"),II=RXNN D LAST^PSORFL S RXF=0 F MJK=0:0 S MJK=$O(^PSRX(RXNN,1,MJK)) Q:'MJK  S RXF=RXF+1
 S STA=$S($P(^PSRX(RXNN,"STA"),"^")=14:"DC",$P(^PSRX(RXNN,"STA"),"^")=15:"DE",$P(^PSRX(RXNN,"STA"),"^")=16:"PH",1:$E("ANRHPS     ECD",(1+$P(^PSRX(RXNN,"STA"),"^")))),STA=$S(DT1>$P(RXPX2,"^",6):"E",1:STA)
 D SIG S FSIG=$O(FSIG(""),-1)
 S ^TMP("PSO",$J,PSI)="NTE"_FS_4_FS_FS,NTE4=1
 S ^TMP("PSO",$J,PSI,CNT)=SD_CS_RXPNO_CS_DRNME_CS_$E(ISSD,4,5)_"/"_$E(ISSD,6,7)
 S ^TMP("PSO",$J,PSI,CNT)=^TMP("PSO",$J,PSI,CNT)_CS_$E(RFL,1,5)_CS_RFS_CS_RXF_CS_PQTY_CS_STA_CS_$E(PHYS,1,20)_CS_$S($G(FSIG)'="":FSIG,1:"""""")_FS_"Profile Information"
 S CNT=CNT+1
 Q
SIG ;Format Sig
 S PSPROSIG=$P($G(^PSRX(RXNN,"SIG")),"^",2) K FSIG,BSIG D
 .I PSPROSIG D FSIG^PSOUTLA("R",RXNN,80) Q
 .D EN2^PSOUTLA1(RXNN,80) F GGGGG=0:0 S GGGGG=$O(BSIG(GGGGG)) Q:'GGGGG  S FSIG(GGGGG)=BSIG(GGGGG)
 K PSPROSIG,GGGGG,BSIG Q
PEND ;include pending orders in profile
 N PSPCOUNT,PSPPEND,ZXXX,PSPSTAT,FSIGZZ,PZZDRUG,PSSODRUG,PZXZERO,PPPPP,GGGGG
 S PSPCOUNT=1,PSPPEND="" F PPPPP=0:0 S PPPPP=$O(^PS(52.41,"P",DFN,PPPPP)) Q:'PPPPP  S PSPSTAT=$P($G(^PS(52.41,PPPPP,0)),"^",3) I PSPSTAT="NW"!(PSPSTAT="HD")!(PSPSTAT="RNW") S PSPPEND(PSPCOUNT)=PPPPP,PSPCOUNT=PSPCOUNT+1
 Q:'$O(PSPPEND(0))
 F ZXXX=0:0 S ZXXX=$O(PSPPEND(ZXXX)) Q:'ZXXX  S PZXZERO=$G(^PS(52.41,PSPPEND(ZXXX),0)) D:$P(PZXZERO,"^")
 .S PZZDRUG=$P(PZXZERO,"^",9),PZZODRUG=$P(PZXZERO,"^",8) Q:'PZZDRUG  Q:'PZZODRUG
 .S PEND="P"_CS_$S(PZZDRUG:$P($G(^PSDRUG(+PZZDRUG,0)),"^"),1:$P($G(^PS(50.7,+PZZODRUG,0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"))
 .S PEND=PEND_CS_$E($P(PZXZERO,"^",6),4,5)_"/"_$E($P(PZXZERO,"^",6),6,7)_"/"_$E($P(PZXZERO,"^",6),2,3)
 . K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=+$P(PZXZERO,"^",5) D ^DIC
 .S PEND=PEND_CS_$P(PZXZERO,"^",10)_CS_$P(PZXZERO,"^",11)_CS_$S(+Y:$P(Y,"^",2),1:"")
 .D FSIG^PSOUTLA("P",PSPPEND(ZXXX),100) S PEND=PEND_CS_$G(FSIG(1)) F FSIGZZ=1:0 S FSIGZZ=$O(FSIG(FSIGZZ)) Q:'FSIGZZ  S PEND=PEND_CS_$G(FSIG(FSIGZZ))
 S:$D(PEND) ^TMP("PSO",$J,PSI,CNT)=PEND
 S CNT=CNT+1
 Q
 ;
START2 ;build NTE for drug interactions
 K PSOSERV
 S RX=IRXN,RXY=^PSRX(RX,0)
 I $D(^PS(52.4,RX,0)) S SCRIPT=$P(^PS(52.4,RX,0),"^",10),SEV=$P(^PS(52.4,RX,0),"^",9) F X=1:1 S RXX(X)=$P(SCRIPT,",",X),SEV(X)=$P(SEV,",",X) Q:RXX(X)=""  D
 .S SER=$P(^PS(56,SEV(X),0),"^",4) S:$G(SER)=1 PSOSERV=1
 .S DIRX=$P($G(^PSRX(RXX(X),0)),"^"),TYP=$S(SER=1:"CRITICAL",SER=2:"SIGNIFICANT",1:"UNKNOWN")
 .S DRG=$P(^PSDRUG($P(^PSRX(RXX(X),0),"^",6),0),"^")
 .S:X=1 NTE5=DIRX_CS_TYP_CS_DRG
 .S:X>1 NTE5=RS_DIRX_CS_TYP_CS_DRG
 I '$D(^PS(52.4,RX,0)),$D(^PSRX(RX,"DRI")) S SCRIPT=$P(^PSRX(RX,"DRI"),"^",2),SEV=$P(^PSRX(RX,"DRI"),"^") F X=1:1 S RXX(X)=$P(SCRIPT,",",X),SEV(X)=$P(SEV,",",X) Q:RXX(X)=""  D
 .S SER=$P(^PS(56,SEV(X),0),"^",4)
 .S DIRX=$P($G(^PSRX(RXX(X),0)),"^"),TYP=$S(SER=1:"CRITICAL",SER=2:"SIGNIFICANT",1:"UNKNOWN")
 .S DRG=$P(^PSDRUG($P(^PSRX(RXX(X),0),"^",6),0),"^")
 .S:X=1 NTE5=DIRX_CS_TYP_CS_DRG
 .S:X>1 NTE5=RS_DIRX_CS_TYP_CS_DRG
 S NTE5=NTE5_CS_$S('$G(PSOSERV):"MAY REQUIRE",1:"REQUIRES")_$S('$G(PSOSERV):" REVIEWING BY A PHARMACIST",1:" INTERVENTION BY A PHARMACIST")
 K SER,SCRIPT,DIRX,TYP,DRG,SEV,RXX,RX,RXY
 Q
START3 ;build NTE for drug allergy warning label                    ;PSO*198
 Q:'$G(DAW)
 S NTE6="NTE"_FS_6_FS_FS
 I '$G(DIN) D
 . S DARX=$P(^PSRX(IRXN,0),"^"),DRG=$P(^PSDRUG(IDGN,0),"^")
 . S NTE6=NTE6_DARX_CS_DRG
 I $G(DIN) D
 . S DARX=$P(^PSRX(IRXN,0),"^"),DRG=$P(^PSDRUG(IDGN,0),"^") D
 . . S NTE6=NTE6_DARX_CS_DRG
 . . F XY=1:1 S INGRE=ING(XY) S:XY=1 NTE6=NTE6_CS_INGRE S:XY>1 NTE6=NTE6_RS_INGRE Q:'INGRE
 K DARX,DRG,XY,INGRE
 Q
 ;PSO*198
SPACE(PLN,CLN) ;check if a space should be inserted between lines of text
 ;  Input:   PLN - previous line of text
 ;           CLN - current line of text to be appended to previous
 ;  function return:  0 - do not insert space
 ;                    1 - insert space
 ;
 ;quit 0, on cases where a space should NOT be inserted else assume 1
 ;
 N TSTP,TSTC,PCHR2,CCHR2                   ;  QUIT 0 CASES BELOW
 Q:PLN="" 0                                ;no previous line, ignore
 Q:$E(PLN,$L(PLN))=" " 0                   ;prev line ends in " "
 Q:$E(CLN,1)=" " 0                         ;curr line begins in " "
 S PCHR2=$E(PLN,$L(PLN)-1,$L(PLN))         ;last 2 char of prev line
 S CCHR2=$E(CLN,1,2)                       ;first 2 char of curr line
 Q:PCHR2?1A1"/" 0                          ;the prev & curr lines
 Q:CCHR2?1"/"1A 0                          ; split, ex: "and/or"
 Q:PCHR2?1A1"-" 0                          ;the prev & curr lines
 Q:CCHR2?1"-"1A 0                          ; split ex: "15-25 degrees"
 S TSTP=$TR(PCHR2,"abcdefghijklmnoqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S TSTC=$TR(CCHR2,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S TSTP=TSTP_TSTC
 Q:TSTP="E.G." 0                           ;lines are splitting "e.g."
 Q:TSTP="I.E." 0                           ;lines are splitting "i.e."
 ;
 Q 1
