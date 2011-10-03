LADKERMI ;SLC/RWF/DLG - KERMIT PROTOCALL CONTROLLER  -  DIRECT CONNECT ;7/19/90  15:06 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;;
 ;Call with T set to Instrument data is to/from
A I $D(^LA("KR",0)) L ^LA("KR") S (%,^(0))=^LA("KR",0)+1,^(%)=T_"^"_IN_"%^%"_$H L
 Q:IN="~A"  L ^LA(T,"P") S:'$D(^LA(T,"P")) ^("P")="KERMIT^"_$S($E(IN,3)="N":"OUT",1:"IN") S MODE=$P(^("P"),"^",2)
 ;P1=Seq #, P2=Last type, P3=Reset point if don't get file
 S:'$D(^LA(T,"P1")) ^LA(T,"P1")=0,^("P2")="" S LAKSPK=""
 D RCHK,@MODE Q
RCHK ;Check received packet and set parts, check for mode changes.
 S LAKERR=0,LARLEN=$A(IN)-32,LAKERR=$L(IN)-1-LARLEN,LAKRSEQ=$A(IN,2)-32,LAKTYPE=$E(IN,3) Q:LAKERR
 I LAKTYPE="E" S MODE="RESTART" Q
 S LAKERR=(LAKTYPE'="S")&(^LA(T,"P1")'=LAKRSEQ),C=0 Q:LAKERR  F I=1:1:LARLEN S C=C+$A(IN,I)
 S CHKSUM=C\64#4+C#64,LAKERR=$A(IN,LARLEN+1)-32-CHKSUM
 I MODE="IN","Y"[LAKTYPE S MODE="OUT"
 I MODE="OUT","FS"[LAKTYPE S MODE="IN"
 I MODE="QUIT","S"[LAKTYPE S MODE="IN" I '$D(^LA("LOCK",T)),$D(^LAB(62.4,T,1)) X ^(1)
 I MODE="QUIT","Y"[LAKTYPE S MODE="OUT",^LA(T,"P3")=^LA(T,"O",0),^LA(T,"P2")=""
 S $P(^LA(T,"P"),"^",2)=MODE L  Q
IN D NAK:LAKERR,RACK:'LAKERR,KICK:LAKTYPE="B" S OUT=LAKSPK,%=OUT D:$D(^LA("KR",0)) DEBUG Q  ;Upload
NAK I LAKRSEQ+1=^LA(T,"P1") S LAKSPK=$C(LAKRSEQ+32)_"Y" D SPACK Q  ;Packet not right
 S LAKSPK=$C(^LA(T,"P1")+32)_"N" D SPACK Q
 ;S LAKSPK=$C(LAKRSEQ+32)_"N" D SPACK Q
SPACK S LAKSPK=$C($L(LAKSPK)+33)_LAKSPK,C=0 F I=1:1:$L(LAKSPK) S C=C+$A(LAKSPK,I) ;Send a responce packet
 S CHKSUM=C\64#4+C#64,LAKSPK=$C(1)_LAKSPK_$C(CHKSUM+32) Q
 Q
RACK S ^LA(T,"P1")=LAKRSEQ+1#64,^("P2")=LAKTYPE
 I LAKTYPE="B" S ^LA(T,"P")="KERMIT^QUIT" ;Good packet
 I LAKTYPE="S" S LAKSPK=" Y~} @-#N1" D SPACK Q  ;Send initiate, Return config.
 S LAKSPK=$C(LAKRSEQ+32)_"Y" D SPACK Q
QUIT K ^LA(T,"P"),^("P1"),^("P2"),^("P3") I '$D(^LA("LOCK",T)),$D(^LAB(62.4,T,1)) X ^(1)
 Q
RESTART S:$D(^LA(T,"P3")) ^LA(T,"O",0)=^LA(T,"P3")
OUT L ^LA(T,"O") D SCHK,RSEND:LAKERR,NEXT:'LAKERR L  Q  ;Download
SCHK I LAKTYPE="N" S LAKERR=1 Q  ;If a NAK, call resend.
 I ^LA(T,"P2")="Z",LAKTYPE="Y" S ^LA(T,"P2")="" K ^LA(T,"P3") Q  ;end of file
 I ^LA(T,"P2")="B",LAKTYPE="Y" S ^LA(T,"P")="KERMIT^QUIT" Q  ;end of session
 S O=^LA(T,"O",0)+1 I '$D(^(O)) S LAKSPK=$C(LAKRSEQ+33)_"E0000" D SPACK S OUT=LAKSPK Q
 Q
RSEND S O=^LA(T,"O",0)-1 S:O'<0 ^(0)=O ;Resend last packet, Fall into Next
NEXT S O=^LA(T,"O",0)+1 I '$D(^(O)) K:'$D(^LA("LOCK",T)) ^LA(T) Q
 S ^LA(T,"O",0)=O,OUT=^(O),^LA(T,"P1")=$A(OUT,3)-32,^("P2")=$E(OUT,4)
 I $E(OUT,4)="S" S ^LA(T,"P3")=O-1 ;Set restart point.
 I $D(^LA("KR",0)) D DEBUG
 Q
DEBUG L ^LA("KR") S (OUT1,^(0))=^LA("KR",0)+1,^(OUT1)=$E(T_"^Sent:"_OUT_"%^%"_$H,1,200)
 K OUT1 L  Q
KICK ;Start a download after an upload. (done async)
 Q:'$D(^LA(T,"O",0))  Q:^LA(T,"O")'>^LA(T,"O",0)  S:$D(^LA(T,"P3")) ^LA(T,"O",0)=^LA(T,"P3") S ^LA(T,"P3")=^LA(T,"O",0)
 L ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=T L  Q
