PSGPL0 ;BIR/CML3-GETS UNITS COUNT FOR PSGPL & PSGPEN ;29 OCT 96 / 8:31 PM
 ;;5.0; INPATIENT MEDICATIONS ;**50,83,110,125,129**;16 DEC 97
 ;
 ; Reference to ^PS(51.1 supported by DBIA #2177.
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ;
EN ;
 K PSGMAR S PSGPLC=0 D RUN
 ;
DONE K HCD,HM,I,J,PSGD,PLSD,CD,M,MID,MN,ND,ND1,PREX,OD,ST,QD1,QD2,QQ,TS,UD,WDT,WS,WS1,X,X1,X2 Q
 ;
RUN ; quit if fill on request prn or stop date not found
 S ND1=$P($G(^PS(55,PSGP,5,PSGPLO,0)),"^",7) Q:('$D(PSGMFOR)&(ND1="R"))  I $F("OCP",ND1)-1'>0,('$D(PSGMFOR)) S PSGPLC="OI" Q
 S ND=$G(^PS(55,PSGP,5,PSGPLO,2)) Q:($P(ND,"^")["PRN")&('$D(PSJPRN))  Q:$P(ND,"^")="PRN"
 S ST=$P(ND,"^",2) N RNDT S RNDT=$$LASTREN^PSJLMPRI(PSGP,+PSGPLO_"U")
 I RNDT N OSTOP S OSTOP=$P(RNDT,"^",4) I $D(PSGPENO) S ST=$S((((RNDT<OSTOP))!$G(PSJREN)):+OSTOP,1:+RNDT)
 I $G(PSJREN)&$G(PSJRNOS) S:PSJRNOS>$G(PSGDT) ST=PSJRNOS S:$G(PSGFD) $P(ND,"^",4)=PSGFD
 S PLSD=$P(ND,"^",4),TS=$P(ND,"^",5)
 S MN=$P(ND,"^",6),ND=$P(ND,"^") D:ND["PRN" SETMN I $S(ST'?7N1"."1N.E:1,1:PLSD'?7N1"."1N.E) S PSGPLC="OI" Q
 ;Quit if One Time order and dosage was given through "PRE-EXCHANGE".
 S PREX=$G(^PS(55,PSGP,5,PSGPLO,1,1,0)) I $$ONE^PSJBCMA(PSGP,PSGPLO_"U",$P(ND,"^",1))="O",$P(PREX,"^",12)'="",$P(PREX,"^",2)'="",$P(PREX,"^",2)'>$P(PREX,"^",12) Q
ENIV ;*** Entry to be called from ^PSGMIV (24 HOUR MAR IV).
 Q:ST'<PSGPLF  I ND1="O"!(ND1="OC")!(MN="O") S PSGPLC=PLSD'<PSGPLS S:ND1'["C"&PSGPLC PSGMAR($E(+$P(ST,".",2)_"0",1,2))="" Q
 I (TS'>0!("24"'[$L($P(TS,"-")))),MN="",ND'["@" S PSGPLC="OI" Q
 S CD=$S(PSGPLF>PLSD:PLSD,1:PSGPLF),OD=$S(ST>PSGPLS:ST,1:PSGPLS),MID=1 I ND["@"!(MN="D") G MWF
 I MN>1440,TS,'(MN#1440) G TSFMN
 I TS>0,"24"[$L($P(TS,"-")) S:PSGPLS>ST ST=PSGPLS G TS
 ;
MN ; if only minutes (MN) are found
 I MN'>0 S PSGPLC="OI" Q
 S (OD,X1)=PSGPLS,HM=MN,X2=ST D ^%DTC I X>1 S AM=X-1*1440\HM*HM D ADD S ST=X
 S (CML,X)=ST F I=0:1 S AM=HM*I,ST=CML D:AM ADD Q:X>CD!(CD=PLSD&(X'<CD))  I X'<OD S PSGPLC=PSGPLC+1,PSGMAR($E($P(X,".",2)_"0",1,2))=""
 S ST=CML Q
 ;
TSFMN ;if admin times exist and minutes#1440=0
 S X=$P(ST,"."),MID=MN\1440 F I=0:1 S X1=$P(ST,"."),X2=MID*I D:X2 C^%DTC Q:X'<CD  I X'<(PSGPLS\1) S ST=$S(PSGPLS\1=X:$S(PSGPLS#1<(ST#1):ST,1:PSGPLS),PSGPLS\1<X:ST,1:PSGPLS) G TS
 Q
 ;
TS ; admin times
 F Q=1:1 S XX=$P(TS,"-",Q) Q:XX=""!(("."_XX)'<(ST#1))
TS1 X:XX="" "S X1=ST\1,X2=MID D C^%DTC S ST=X,Q=1" F QQ=Q:1 S XX=$P(TS,"-",QQ) G:XX="" TS1 S ST=$P(ST,".")_"."_XX Q:ST>CD!(CD=PLSD&(ST'<CD))  S:PSGPLS'>ST PSGPLC=PSGPLC+1,PSGMAR($E(XX_"0",1,2))=""
 Q
 ;
MWF ; schedule in form of WD-WD-WD@TS
 S:ND["@" ND=$P(ND,"@") S:'TS TS=$E($P(ST,".",2)_"0000",1,4) S HCD=CD,X=$P(OD,".")
 S MN="-" I ND'["-",ND?.E1P.E F FQ=1:1:$L(ND) I $E(ND,FQ)?1P S MN=$E(ND,FQ) Q
 F FQ=0:1 S X1=$P(OD,"."),X2=FQ D:X2 C^%DTC Q:X>$P(HCD,".")  S CD=$S($P(HCD,".")>X:X_.24,1:HCD),ST=$S($P(OD,".")<X:X_.0001,1:OD) D DW^%DTC S X=X_"S" F FQ1=1:1:$L(ND,MN) I $P(X,$P(ND,MN,FQ1))="" D TS Q
 Q
 ;
ADD ; ST=start date/time   AM=minutes (+ or -)  X=new date/time
 S:'AM X=ST Q:'AM  S T=1 S:AM<0 T=-1,AM=-AM S X2=AM\1440,AM=AM-(X2*1440),H=AM\60,M=AM#60,HRS=+$E(ST_"00",9,10),MN=+$E(ST_"0000",11,12),X=ST\1
 I M S MN=MN+(M*T) S:MN>59 MN=MN-60,H=H+1 S:MN<0 MN=MN+60,H=H+1
 I H S HRS=HRS+(H*T) S:HRS>24!(HRS=24&MN) HRS=HRS-24,X2=X2+1 S:HRS<0 HRS=HRS+24,X2=X2+1
 I X2 S X1=$P(X,"."),X2=X2*T D C^%DTC
 S X=+(X_"."_$E(0,HRS<10)_HRS_$E(0,MN<10)_MN) K AM,H,HRS,M,MN,T Q
 ;
SETMN ; Set MN for PRN orders
 Q:($G(MN)]"")!($G(TS)]"")!(ND["Q0")  S MNFL=0,MN="",TS="" F XX=0:0 S XX=$O(^PS(51.1,"AC","PSJ",ND,XX)) Q:'XX!(MNFL)  D
 .S:$P($G(^PS(51.1,XX,0)),"^",3)'="" MN=$P($G(^(0)),"^",3),MNFL=1 S:$P($G(^(0)),"^",2)'="" TS=$P($G(^(0)),"^",2),MNFL=1 Q
 I 'MNFL,$E(ND,1,3)'="PRN" D
 .S PRND=$P(ND,"PRN") D:$E(PRND,$L(PRND))=" "  F XX=0:0 S XX=$O(^PS(51.1,"AC","PSJ",PRND,XX)) Q:'XX!(MNFL)  S:$P($G(^PS(51.1,XX,0)),"^",3)'="" MN=$P($G(^(0)),"^",3),MNFL=1 S:$P($G(^(0)),"^",2)'="" TS=$P($G(^(0)),"^",2),MNFL=1
 ..F  S PRND=$E(PRND,1,$L(PRND)-1) Q:$E(PRND,$L(PRND))'=" "
 I 'MNFL,$E(ND,1,3)="PRN" S PRND=$P(ND,"PRN",2) D:$E(PRND)=" "  F XX=0:0 S XX=$O(^PS(51.1,"AC","PSJ",PRND,XX)) Q:'XX!(MNFL)  S:$P($G(^PS(51.1,XX,0)),"^",3)'="" MN=$P($G(^(0)),"^",3),MNFL=1 S:$P($G(^(0)),"^",2)'="" TS=$P($G(^(0)),"^",2),MNFL=1
 .F  S PRND=$E(PRND,2,$L(PRND)) Q:$E(PRND)'=" "
 I 'MNFL D
 .I PRND["@" D DW S:$D(PRND) TS=$P(PRND,"@",2) Q
 .I $E(PRND,1,2)="AD" Q
 .I $E(PRND,1,3)="BID"!($E(PRND,1,3)="TID")!($E(PRND,1,3)="QID") S MN=1440/$F("BTQ",$E(PRND)) Q
 .S:$E(PRND)="Q" PRND=$E(PRND,2,99) S:'PRND PRND="1"_PRND S PRND1=+PRND,PRND=$P(PRND,+PRND,2),PRND2=0 S:PRND1<0 PRND1=-PRND1 S:$E(PRND)="X" PRND2=1,PRND=$E(PRND,2,99)
 .S MN=$S((PRND["D"&(PRND'["AD"))!(PRND["AM")!(PRND["PM")!((PRND["HS")&(PRND'["THS")):1440,((PRND["H")&(PRND'["TH")):60,PRND["AC"!(PRND["PC"):480,PRND["W":10080,PRND["M":40320,1:-1) I MN>0 S:PRND["QO" MN=MN*2 S MN=MN*PRND1 Q:MN>0
QUIT K XX,MNFL,PRND,PRND1,PRND2,QX,SDW,SWD,Z Q
 ;
DW ;
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=PRND,PRND=$P(PRND,"@",2) D ENCHK Q:'$D(PRND)  S PRND=$P(SDW,"@"),PRND(1)="-" I PRND?.E1P.E,PRND'["-" F QX=1:1:$L(PRND) I $E(PRND,QX)?1P S PRND(1)=$E(PRND,QX) Q
 F Q=1:1:$L(PRND,PRND(1)) K:SWD="" PRND Q:SWD=""  S Z=$P(PRND,PRND(1),Q) D DWC Q:'$D(PRND)
 K PRND(1) S:$D(PRND) PRND=SDW Q
DWC I $L(Z)<2 K PRND Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K PRND
 Q
 ;
ENCHK ;
 I $S($L($P(PRND,"-"))>4:1,$L(PRND)>119:1,$L(PRND)<2:1,PRND'>0:1,1:PRND'?.ANP) K PRND Q
 S PRND(1)=$P(PRND,"-") I PRND(1)'?2N,PRND(1)'?4N K PRND Q
 S PRND(1)=$L(PRND(1)) I PRND'["-",PRND>$E(2400,1,PRND(1)) K PRND Q
 F PRND(2)=2:1:$L(PRND,"-") S PRND(3)=$P(PRND,"-",PRND(2)) I $S($L(PRND(3))'=PRND(1):1,PRND(3)>$E(2400,1,PRND(1)):1,1:PRND(3)'>$P(PRND,"-",PRND(2)-1)) K PRND Q
 K:$D(PRND) PRND(1),PRND(2),PRND(3) Q
  
  
