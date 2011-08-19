PSXMISC1 ;BIR/WPB,BAB-Transmission Data Validation ;MAR 1,2002@13:13:34
 ;;2.0;CMOP;**3,18,23,28,30,42,41,52,54,58,64**;11 Apr 97;Build 1
 ;Reference to ^PSDRUG(  supported by DBIA #1983
 ;Reference to ^PS(52.5, supported by DBIA #1978
 ;Reference to ^PSRX(    supported by DBIA #1977
 ;Reference to ^PS(55,   supported by DBIA #2228
 ;Reference to PROD2^PSNAPIS supported by DBIA #2531
 ;Reference to ^PSSLOCK supported by DBIA #2789
 ;Reference to CHKRX^PSOBAI supported by DBIA #4910
CHKDATA ;checks the data elements in PSRX before putting the rx in 550.2
 Q:'$D(^PS(52.5,REC,0))
 K DRUGCHK,PSXRXERR,PSXDGST,WARNS
 S (RXN,PSXPTR)=$P($G(^PS(52.5,REC,0)),"^",1) I PSXPTR="" S PSXOK=8 Q
 D PSOL^PSSLOCK(RXN) S PSOMSG=+PSOMSG ; sets PSOMSG
 I ($P(^PS(52.5,REC,0),U,3)'=XDFN)!($P(^PSRX(PSXPTR,0),U,2)'=XDFN) S PSXOK=8 Q
 I '$D(^PSRX(PSXPTR,0)) S PSXOK=8 Q
 S RXNUM=$P($G(^PSRX(PSXPTR,0)),"^",6),RXEX=$P($G(^PSRX(PSXPTR,0)),"^",1)
 I $G(^PSDRUG(RXNUM,"ND"))'="" D
 .S PTRA=$P($G(^PSDRUG(RXNUM,"ND")),U,1),PTRB=$P($G(^PSDRUG(RXNUM,"ND")),U,3)
 .I $G(PTRA)'="" S ZX=$$PROD2^PSNAPIS(PTRA,PTRB),DRUGCHK=$P($G(ZX),"^",3)
 S:$G(DRUGCHK)'="" PSXDGST=$P(ZX,"^",2)_"^"_$P(ZX,"^")
 I '$D(DRUGCHK) S DRUGCHK=0
 S:'$D(^PSDRUG("AQ",RXNUM)) PSXOK=1
 S:$G(DRUGCHK)'=1 PSXOK=1
 I $P(^PSDRUG(RXNUM,2),"^",3)'["O" S PSXOK=1,PSXCK=RXNUM D UNMARK^PSXUTL
 S:$P($G(^PSRX(PSXPTR,"STA")),U,1)'=5 PSXOK=5
 ;gets the fill number by ordering thru the refill node for the last
 ;refill number
 S FILNUM=0 F REF=0:0 S REF=$O(^PSRX(PSXPTR,1,REF)) Q:REF'>0  S:REF>0 FILNUM=REF S:REF="" FILNUM=0
 ;I $G(PSXFLAG)=2 S PSXOK=0 Q
 S RXF=FILNUM
 S REL=$S(RXF>0:$P($G(^PSRX(RXN,1,RXF,0)),U,18),RXF=0:$P($G(^PSRX(RXN,2)),U,13),1:"") I $G(REL)'="" S PSXOK=6
 S:((PSXOK=0)&(FILNUM>0)&($P($G(^PSRX(PSXPTR,1,FILNUM,0)),"^",2)'="M")) PSXOK=3
 S:((PSXOK=0)&(FILNUM'>0)&($P($G(^PSRX(PSXPTR,0)),"^",11)'="M")) PSXOK=3
 I $G(^PS(52.5,REC,"P"))="1" S PSXOK=4
 S PSXDIV=$S(FILNUM=0:$P($G(^PSRX(PSXPTR,2)),U,9),FILNUM>0:$P($G(^PSRX(PSXPTR,1,FILNUM,0)),"^",9),1:"")
 ;If trans div does not match Rx div eliminate
 I PSXDIV'=PSOSITE S PSXOK=7 Q
 ; Changes for Controlled subs 
 N PSXCSC,PSXCSD S PSXCSRX=""
 S PSXCSC=$P($G(^PSDRUG(RXNUM,0)),"^",3)
 ;Can't trans DEA schedule 1 or 2
 I $G(PSXCSC)[1!$G(PSXCSC)[2 S PSXOK=10 Q
 ;If CS must be DEA 3-5 to qualify
 F PSXCSD=3:1:5 I PSXCSC[PSXCSD S PSXCSRX=1
 ;If not CS drug and CS trans eliminate
 I ($G(PSXCSRX)<1)&($G(PSXCS)=1) S PSXOK=9 Q
 ;If CS drug and not CS trans eliminate
 I ($G(PSXCSRX)=1)&($G(PSXCS)<1) S PSXOK=9 Q
 ; Checks for do not mail and expiration date thereof
 ; moved to under NOGO
 ;
 G:PSXOK'=0 STOP
NOGO ;any rx that does not pass the following checks will not be transmitted
 ;and an error message will be generated and sent to the user who
 ;initiated the transmission.  All that pass the checks will be sent.
 S RXERR=0,PSXRXERR=RXEX_"^"_RXF
 I RXEX[" " S RXERR=13,PSXRXERR=PSXRXERR_"^"_RXERR
 S QTY=$S(RXF>0:$P($G(^PSRX(RXN,1,RXF,0)),U,4),RXF=0:$P($G(^PSRX(RXN,0)),U,7),1:"") G:$G(QTY)'=""&($G(QTY)>0)&(QTY?.N)!(QTY?.N1".".N) NG1 S RXERR=2,PSXRXERR=PSXRXERR_"^"_RXERR
NG1 S PHY=$S(RXF>0:$P($G(^PSRX(RXN,1,RXF,0)),U,17),RXF=0:$P($G(^PSRX(RXN,0)),U,4),1:"") I PHY="" S RXERR=3,PSXRXERR=PSXRXERR_"^"_RXERR
 S DAYS=$S(RXF>0:$P($G(^PSRX(RXN,1,RXF,0)),U,10),RXF=0:$P($G(^PSRX(RXN,0)),U,8),1:"") I (DAYS'>0)!(DAYS="") S RXERR=4,PSXRXERR=PSXRXERR_"^"_RXERR
 S PHARCLK=$S(RXF>0:$P($G(^PSRX(RXN,1,RXF,0)),U,7),RXF=0:$P($G(^PSRX(RXN,0)),U,16),1:"") I PHARCLK="" S RXERR=9,PSXRXERR=PSXRXERR_"^"_RXERR
 S DRUG=$P($G(^PSRX(RXN,0)),U,6),PSTAT=$P($G(^(0)),U,3),FDATE=$P($G(^PSRX(RXN,2)),U,2)
 D TSTSIG
 S DFN=$P($G(^PSRX(RXN,0)),U,2) D ADD^VADPT I ($G(VAPA(1))="")!($G(VAPA(4))="")!($P($G(VAPA(5)),"^",2)="")!($G(VAPA(6))'>0)!($P($G(VAPA(11)),"^",2)'>0) S RXERR=10,PSXRXERR=PSXRXERR_"^"_RXERR
 D DEM^VADPT
 I VADM(1)["MERGING" S RXERR=17,PSXRXERR=PSXRXERR_"^"_RXERR
 ;MVP OIFO BAY PINES;ELR;PSX*2*52  CHANGED RXERR FROM 10 TO 19. ADDED NEW ERROR IN PSXERR
 I $G(VA("PID"))["000-00" S RXERR=19,PSXRXERR=PSXRXERR_"^"_RXERR ; SSN ["000-00" indicates test patient
 S (CNTR,XC,DUPFLG)=0,DUPRX="" F  S XC=$O(^PSRX("B",RXEX,XC)) Q:XC'>0  S CNTR=CNTR+1,DUPRX=DUPRX_"^"_XC
 I CNTR>1 D
 .Q:$P(DUPRX,"^",3)=""
 .F I2=2:1 S I1=$P(DUPRX,"^",I2) Q:I1=""  S PSREC=$O(^PS(52.5,"B",I1,"")) Q:$G(PSREC)'>0  S:($P(^PS(52.5,PSREC,0),"^",2)<PSXDTRG&($P(^PS(52.5,PSREC,0),"^",7)="Q")) DUPFLG=1
 S:$G(DUPFLG)>0 PSXRXERR=PSXRXERR_"^"_"14"
 K CNTR,XC,DUPRX,I2,I1,PSREC,DUPFLG
 I $D(^PSRX(PSXPTR,4,0)) D
 .S RXERR=""
 .S ZX=0 F  S ZX=$O(^PSRX(PSXPTR,4,ZX)) Q:ZX'>0  D
 ..I $P(^PSRX(PSXPTR,4,ZX,0),"^",3)=RXF&($P(^PSRX(PSXPTR,4,ZX,0),"^",4)'=3) S RXERR=12
 ..I $P(^PSRX(PSXPTR,4,ZX,0),"^",3)=RXF&($P(^PSRX(PSXPTR,4,ZX,0),"^",4)=3) S RXERR=""
 .I RXERR'="" S PSXRXERR=PSXRXERR_"^"_RXERR
 I DRUG="" S RXERR=5,PSXRXERR=PSXRXERR_"^"_RXERR
 I DRUG S WARNS=$P(^PSDRUG(DRUG,0),"^",8) D
 .;IF USING NEW WARNING SOURCE, LENGTH OF OLD WARNINGS DOESN'T MATTER
 .I '$D(PSSWSITE) S PSSWSITE=+$O(^PS(59.7,0))
 .I $P($G(^PS(59.7,PSSWSITE,10)),"^",10)="N" Q
 .I $G(WARNS) S:$L(WARNS)>11 RXERR=16,PSXRXERR=PSXRXERR_"^"_RXERR
 I SIG="" S RXERR=6,PSXRXERR=PSXRXERR_"^"_RXERR
 I PSTAT="" S RXERR=7,PSXRXERR=PSXRXERR_"^"_RXERR
 I FDATE'?7N S RXERR=8,PSXRXERR=PSXRXERR_"^"_RXERR
 I '$$MAILOK(RXN) D
 . S COM="Removed from CMOP Suspense - Mail Status Change" D NOW^%DTC S DTTM=% K % D ACTLOG^PSXRPPL
 . D DELETE^PSXRPPL S PSXOK=1
 . ;MVP OIFO BAY PINES;ELR;PSX*2*5 DELETE MM MSG FOR DO NOT MAIL
 . ;S RXERR=15,PSXRXERR=PSXRXERR_"^"_RXERR ;mail message to users
 I $D(^TMP($J,"PSXBAI",DFN)),'$G(^TMP($J,"PSXBAI",DFN)) D
 . S PSXOK=8
 . D CHKACT(PSXPTR)
 . I '$G(PSXFIRST) K PSXRXERR Q
 . S COM="Bad Address Indicator or Foreign Address. Not removed from CMOP Suspense" D NOW^%DTC S DTTM=% K % D ACTLOG^PSXRPPL
 . S RXERR=20,PSXRXERR=PSXRXERR_"^"_RXERR ;mail message to users
PSOMSG I +PSOMSG=0 S RXERR=18,PSXRXERR=PSXRXERR_"^"_RXERR ; from PSSLOCK
 I $P($G(PSXRXERR),"^",3)'="" S PSXOK=8 D ER7^PSXERR
STOP K DAYS,DRUG,FDATE,PHARCLK,PHY,PSTAT,QTY,RXERR,RXEX,SIG,VAPA(1),DRUGCHK,PTRA,PTRB,REL,RXNUM,PHARCLK1,ZX,VAPA(4),VAPA(5),VAPA(6)
 Q
 ;
TSTSIG ; include testing for BAD characters in SIG
 I $P(^PSRX(RXN,"SIG"),"^",2)'>0 S SIG=$P(^PSRX(RXN,"SIG"),"^") D TSTCHAR
 I $P(^PSRX(RXN,"SIG"),"^",2)=1 N L S L=0 F  S L=$O(^PSRX(RXN,"SIG1",L)) Q:L'>0  S SIG=$G(^PSRX(RXN,"SIG1",L,0)) D TSTCHAR Q:SIG=""
 Q
TSTCHAR ; test each character of SIG for certain characters
 N I,C
 I '$D(^TMP($J,"PSXCHAR")) D
 . F I=0:1:31 S ^TMP($J,"PSXCHAR",I)=""
 . F I=92,94,124,127 S ^TMP($J,"PSXCHAR",I)=""
 F I=1:1:$L(SIG) S C=$A($E(SIG,I)) I $D(^TMP($J,"PSXCHAR",C)) S SIG="" Q
 Q
MAILOK(TRX) ; return 1 if patient still in mail status & ok to CMOP
 N PSOMDT,PSOMC,DFN
 S DFN=$P(^PSRX(TRX,0),"^",2),PSOMDT=$P($G(^PS(55,DFN,0)),"^",5),PSOMC=$P($G(^PS(55,DFN,0)),"^",3)
 I (PSOMC>1&(PSOMDT>DT))!(PSOMC>1&(PSOMDT<1)) Q 0
 Q 1
ADDROK(TRX) ; return 1 if not foreign and not bad address indicator 
 N DFN,PSOFORGN
 S DFN=$P($G(^PSRX(TRX,0)),"^",2) I DFN="" Q:0
 ;BHW;PSX*2*64;Changed Quit below from Q:+(^TMP... to Q +(^TMP...
 I $D(^TMP($J,"PSXBAI",DFN)) Q +(^TMP($J,"PSXBAI",DFN))
 D ADD^VADPT
 S PSOFORGN=$P($G(VAPA(25)),"^",2) I PSOFORGN'="",PSOFORGN'["UNITED STATES" S PSOFORGN=1
 I PSOFORGN S ^TMP($J,"PSXBAI",DFN)=0 Q 0
 I $T(CHKRX^PSOBAI)']"" S ^TMP($J,"PSXBAI",DFN)=1 Q 1
 N PSORX,PSOBADR
 S PSORX=TRX
 S PSOBADR=$$CHKRX^PSOBAI(PSORX)
 I '$P(PSOBADR,"^") S ^TMP($J,"PSXBAI",DFN)=1 Q 1
 I $P(PSOBADR,"^",2)=1 S ^TMP($J,"PSXBAI",DFN)=1 Q 1
 S ^TMP($J,"PSXBAI",DFN)=0
 Q 0
 ;
CHKACT(RXN) ; SEE IF FILL IS ALREADY ON ACTIVITY LOG FOR FOREIGN OR BAD ADDRESS
 N JJ,RFCNT,XX,COM
 S PSXFIRST=1
 S COM="Bad Address Indicator or Foreign Address."
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RXN,1,RF)) Q:'RF  S RFCNT=$S(RF<6:RF,1:RF+1)
 S JJ=0 F  S JJ=$O(^PSRX(RXN,"A",JJ)) Q:'JJ  S XX=$G(^PSRX(RXN,"A",JJ,0)) I $P(XX,"^",4)=RFCNT,$P(XX,"^",5)[COM S PSXFIRST=0 Q
 Q
