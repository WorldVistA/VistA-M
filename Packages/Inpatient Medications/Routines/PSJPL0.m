PSJPL0 ;BIR/CML3-GETS UNITS COUNT FOR MDWS. ;07 Jul 98 / 4:02 PM
 ;;5.0; INPATIENT MEDICATIONS ;**34**;16 DEC 97
 ;
 ;Reference to ^PS(55 is supported by DBIA 2191
 ;
EN ;
 K PSGMAR S (PSGPLC,PSJPLC)=0 N ST D RUN
 ;
DONE K HCD,HM,I,J,PSGD,PLSD,CD,M,MID,MN,ND,ND1,OD,QD1,QD2,QQ,TS,UD,WDT,WS,WS1,X,X1,X2 Q
 ;
RUN ; quit if fill on request prn or stop date not found
 S ND1=$P($G(^PS(55,PSGP,5,PSGPLO,0)),"^",7) Q:('$D(PSGMFOR)&(ND1="R"))  I $F("OCP",ND1)-1'>0,('$D(PSGMFOR)) S PSGPLC="OI" Q
 S ND=$G(^PS(55,PSGP,5,PSGPLO,2)) Q:$P(ND,"^")["PRN"  S ST=$P(ND,"^",2),PLSD=$P(ND,"^",4),TS=$P(ND,"^",5),MN=$P(ND,"^",6),ND=$P(ND,"^") I $S(ST'?7N1"."1N.E:1,1:PLSD'?7N1"."1N.E) S PSGPLC="OI" Q
ENIV ;*** Entry to be called from ^PSGMIV (24 HOUR MAR IV).
 Q:ST'<PSGPLF  I ND1="O"!(ND1="OC")!(MN="O") S PSGPLC=PLSD'<PSGPLS S:ND1'["C"&PSGPLC PSGMAR(+ST)="" Q
 I (TS'>0!("24"'[$L($P(TS,"-")))),MN="",ND'["@" S PSGPLC="OI" Q
 S CD=$S(PSGPLF>PLSD:PLSD,1:PSGPLF),OD=$S(ST>PSGPLS:ST,1:PSGPLS),MID=1 I ND["@"!(MN="D") G MWF
 I MN>1440,TS,'(MN#1440) G TSFMN
 I TS>0,"24"[$L($P(TS,"-")) S:PSGPLS>ST ST=PSGPLS G TS
 ;
MN ; if only minutes (MN) are found
 I MN'>0 S PSJPLC=1 Q
 S (OD,X1)=PSGPLS,HM=MN,X2=ST D ^%DTC I X>1 S AM=X-1*1440\HM*HM D ADD S ST=X
 S (CML,X)=ST F I=0:1 S AM=HM*I,ST=CML D:AM ADD Q:X>CD!(CD=PLSD&(X'<CD))  I X'<OD S PSGPLC=PSGPLC+1,PSGMAR(+X)=""
 S ST=CML Q
 ;
TSFMN ;if admin times exist and minutes#1440=0
 S X=$P(ST,"."),MID=MN\1440 F I=0:1 S X1=$P(ST,"."),X2=MID*I D:X2 C^%DTC Q:X'<CD  I X'<(PSGPLS\1) S ST=$S(PSGPLS\1=X:$S(PSGPLS#1<(ST#1):ST,1:PSGPLS),PSGPLS\1<X:ST,1:PSGPLS) G TS
 Q
 ;
TS ; admin times
 F Q=1:1 S XX=$P(TS,"-",Q) Q:XX=""!(("."_XX)'<(ST#1))
TS1 X:XX="" "S X1=ST\1,X2=MID D C^%DTC S ST=X,Q=1" F QQ=Q:1 S XX=$P(TS,"-",QQ) G:XX="" TS1 S ST=$P(ST,".")_"."_XX Q:ST>CD!(CD=PLSD&(ST'<CD))  S:PSGPLS'>ST PSGPLC=PSGPLC+1,PSGMAR(+ST)=""
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
