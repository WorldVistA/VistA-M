LAMSD ;SLC/DLG - MICROSCAN BUILD DOWNLOAD FILE ;7/20/90  09:48 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;Called by LRDOWN from the AutoInstrument file.
 ;Call with LRLL = loadlist to build
 ;Call with LRINST = Auto Instrument pointer
A S:$D(ZTQUEUED) ZTREQ="@" S FD="|" S:'$D(T) T=LRINST D:'$D(^LA(T,"O")) SETO^LAB
 F LRTRAY=LRTRAY:0 D:$D(^LRO(68.2,LRLL,1,LRTRAY)) TRAY S LRTRAY=$O(^LRO(68.2,LRLL,1,LRTRAY)) Q:LRTRAY'>0
 S OUT="L||Y|" D SEND
 S T=+LRINST I '$D(^LA(T,"P")) L ^LA(T) S ^LA(T,"P")="MICROSCAN^OUT" L ^LA("Q") S Q=^LA("Q")+2,^("Q")=Q,^("Q",Q-1)=T,^(Q)=T L
 K LRTRAY,Q,LRAA,LRAD,LRAN,CNT,T,PNM,LRDPF,DFN,LRRM,SSN,LRWARD,LRSERV,LRDC,LRDOC,DOB,FD,LRSPEC,LRACC,LRT,LRISO
 S LREND=1 Q  ;Don't need the send pass.
TRAY F LRCUP=0:0 S LRCUP=$O(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP)) Q:LRCUP'>0  D PT,SPEC,ISO
 Q
PT ;Get patient data and send a P record
 S LR(0)=^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,0),LRAA=+LR(0),LRAD=$P(LR(0),"^",2),LRAN=$P(LR(0),"^",3)
 S LR(1)=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LR(.2)=^(.2),LR(3)=^(3),X=^LR(+LR(1),0),PNM="",LRDPF=$P(X,"^",2),DFN=$P(X,"^",3) D PT^LRX
 ;SSN is returned from PT^LRX could be reformated.
 S LR(2)=@(^DIC(LRDPF,0,"GL")_DFN_",0)"),LRIP=$S($D(^(.1)):"I",1:"O"),LRRM=$S($D(^(.101)):^(.101),1:"")
 ;LRIP say inpatient if have a ward.
 S SSN=$P(LR(2),U,9),SSN=$E(SSN,10,11)_"\"_$E(SSN,1,9) ;Special DoD format
 S LRWARD=$P(LR(1),"^",7),X=$P(LR(1),"^",9),LRSERV=$S(X="":99,1:$P(^DIC(45.7,X,0),"^",1)) S:LRWARD="" LRWARD=99
 S X=$P(LR(1),"^",8),X=$P(^VA(200,X,0),U,2),LRDOC=$S(X="":99,1:X),LRDC=+LR(3) ;Send the INITAL field from provider file or 99
 S X=$S(DOB>1999999:"N",1:"Y"),DOB=$E(DOB,2,7) ;X is DOB<1900, DOB=YYMMDD
 S OUT="P||"_SSN_FD_$E($P(PNM,",",1),1,16)_FD_$E($P(PNM,",",2),1,16)_FD_DOB_FD_SEX_"||||"_LRRM_FD_FD_FD_LRWARD_FD_FD_LRSERV_"|||||"_X_FD_LRIP
 D SEND Q
SPEC ;Send specimen 'B' record
 S X=+$P(LR(0),"^",5),LRSPEC=$S($D(^LAB(61,X,0)):$P(^(0),U,5),1:99) ;Send abbreviation from topography file
 S LRLAD=$P(LR(3),U,3)_"0000" ;Send Lab arrival time
 S LRACC=LRAN ;Will just send the number part
 S OUT="B||"_LRACC_FD_SSN_FD_LRDOC_FD_FD_LRSPEC_"|||"_$E(LRDC,2,7)_FD_$E(LRDC_"0000",9,12)_FD_FD_$E(LRLAD,2,7)_FD_$E(LRLAD,9,12)_"||||||"_LRWARD
 D SEND Q
ISO ;find the ISOLATES to do
 F LRI=0:0 S LRI=$O(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,3,LRI)) Q:LRI'>0  S LLR=^(LRI,0) D I2 ; 3 HAS REPLACED 658000 AFTER NEW FILE DEFINITION WAS MADE SLC/FHS
 S OUT="L||N|" D SEND
 Q
I2 ;Send the 'R' test request record.
 S X1=$P(LLR,U),X2=$P(LLR,"^",2) ;X1 is Test/Panel, X2 is Isolate
 ;Add code to do any test/panel conversion before sending
 S OUT="R||"_X2_FD_LRACC_FD_X1
 D SEND Q
 Q
SEND ;Put in the output queue
 S OUT=$C(2)_OUT D OUT S CHK=13 F I=1:1:$L(OUT) S CHK=CHK+$A(OUT,I)
 S CHK=CHK#256,OUT=$C(CHK\16+64)_$C(CHK#16+64)_$C(3) D OUT ;NO LF
 Q
OUT ;
 L ^LA(LRINST) S CNT=^LA(LRINST,"O")+1,^("O")=CNT,^("O",CNT)=OUT L
 L ^LA("Q") S Q=^LA("Q"),^LA("Q")=Q+2,^LA("Q",Q-1)=T,^LA("Q",Q)=T L  Q
