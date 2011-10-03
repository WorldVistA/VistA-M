SDM2 ;SF/GFT - MAKE APPOINTMENT ; 07 Jan 2000  6:30 PM
 ;;5.3;Scheduling;**32,132,168,356,434,467,478**;Aug 13, 1993
 ;
 ;SD/467 - call EWL to open its entry if matching appointment is canceled
 W *7,!,"PATIENT ALREADY HAS APPOINTMENT "
 N SDATA,SDCMHDL ; for evt dvr
 I $D(^DPT(DFN,"S",SD,0)),$P(^(0),"^",2)'["C" S S=SD,I=+^(0) D FLEN W "(",APL," MINUTES) THEN" D IN,PROT G:$D(SDPROT) ^SDM1 R ".",!,"  DO YOU WANT TO CANCEL IT? ",X:DTIME S X=$$UP^XLFSTR(X) D:X?1"Y".A STAT G CAN:X?1"Y".A W "??",*7 G ^SDM1
SDAY S %=1 W "ON THE SAME DAY (" D AT,IN W ") ...OK" D YN^DICN I '% W !,"RESPOND YES OR NO",!,"PATIENT ALREADY HAS APPOINTMENT " G SDAY
 G ^SDM1:(%-1),PRECAN^SDM1
 ;
CAN Q:'$D(^SC(I,"SL"))  S SCI=I,DIV=$S($P(^SC(I,0),"^",15)]"":" "_$P(^(0),"^",15),1:" 1") I $D(^DPT("ASDPSD","C",DIV,I,S,DFN)) K ^(DFN)
 S SD17=$P(^DPT(DFN,"S",S,0),"^") K ^SC("ARAD",I,S,DFN) S (DA,SDSY)=0 F SDSX=0:0 S SDSX=$O(^SC(I,"S",S,1,SDSX)) Q:'SDSX  Q:'$D(^(SDSX,0))  D C Q:SDSY&(DA)
 I $D(^DPT("ASDPSD","B",DIV,$P(S,"."),DFN)) D CK1
 G OUT:'SDSY S SL1=$P(^SC(I,"S",S,1,SDSY,0),U,2) I DA,'$D(^("OB")) K ^SC(I,"S",S,1,DA,"OB")
 S SDRT="D",SDTTM=SD,SDPL=SDSY,SDSC=I D RT^SDUTL
 I I'=SC D
 .W !
 .I $$BADADR^DGUTL3(DFN)>0 D  Q
 ..W !!,"**BAD ADDRESS INDICATOR FOR THIS PATIENT. NO LETTER WILL BE PRINTED.**",!!
 .S DIR("A")="DO YOU WISH TO PRINT LETTERS FOR THE CANCELLED APPOINTMENT"
 .S DIR("A",1)="THIS IS THE ONLY OPPORTUNITY.",DIR("B")="YES"
 .S DIR(0)="Y" D ^DIR W ! K DIR
 .Q:(Y'=1)
 .N SDWH,A,SC,SDCL S SDWH="P",A=+DFN,SDCL(1)=I_"^"_S N DFN
 .S %ZIS("A")="Device for cancellation letter: ",%ZIS("B")=""
 .N I,S,SDHX,SDP
 .D ^%ZIS Q:POP  U IO
 .D SDLET^SDCNP1A
 .D ^%ZISC
 N SCSNOD,SCLNK,SCSRV,SCGMR,SCSTPCOD
 S SCSNOD=^SC(I,"S",S,1,SDSY,0),SCLNK=$P($G(^SC(I,"S",S,1,SDSY,"CONS")),U),SDADM="" S:'$D(STPCOD) STPCOD=$P($G(^SC(I,0)),U,7) K TMPD ;SD/478
 I SCLNK'="" K ^SC("AWAS1",SCLNK) S SCSRV=$P($G(^GMR(123,SCLNK,0)),U,5),SCGMR=0 F  S SCGMR=$O(^GMR(123.5,SCSRV,688,SCGMR)) Q:'+SCGMR  S SCSTPCOD=$P(^GMR(123.5,SCSRV,688,SCGMR,0),U) I STPCOD=SCSTPCOD D
 .S TMP=1 S:'$D(CNSLTLNK) CNSLTLNK=SCLNK Q  ;SD/478
 K ^SC(I,"S",S,1,SDSY)
 I '$D(^SC(I,"ST",$P(SD,"."),1)) G OUT
 S SD1(1)=^SC(I,"SL"),SD1=$P(SD1(1),"^",3),SB1=$S(SD1:SD1,1:8)-1/100,SD1=$P(SD1(1),"^",6),HSI1=$S(SD1:SD1,1:4),SI1=$S(SD1="":4,SD1<3:4,SD1:SD1,1:4),SDDIF1=$S(HSI1<3:8/HSI1,1:2) K SD1
 S S=^SC(I,"ST",$P(SD,"."),1),SDQ=SD#1-SB1*100,ST=SDQ#1*SI1\.6+($P(SDQ,".")*SI1),SS=SL1*HSI1/60
 I SDQ'<1 F I=ST+ST:SDDIF1 S SDQ=$E(STR,$F(STR,$E(S,I+1))) Q:SDQ=""  S S=$E(S,1,I)_SDQ_$E(S,I+2,999),SS=SS-1 Q:SS'>0
 S ^(1)=S K SL1,SB1,SDDIF1,HSI1,SI1,SDQ ;NAKED REFERENCE - ^SC(IFN,"ST",Date,1)
OUT D EVT Q:$D(SDNSF)  D CANCEL^SDCNSLT W *7,!,"APPOINTMENT IN ",$P(^SC(SCI,0),"^",1)," CANCELLED!" S X=SD D DOW^SDM1 W !,"APPOINTMENT NOW BEING MADE IN ",$P(^SC(SC,0),"^",1) K SCI G S^SDM1  ;SD/478
 ;
C I +^SC(I,"S",S,1,SDSX,0)=DFN,$P(^(0),"^",9)'["C" S SDSY=SDSX Q
 Q:'$D(^("OB"))!DA  S:^("OB")?1"O".E DA=SDSX Q  ;NAKED REFERENCE - ^SC(IFN,"S",Date,1,SDSX,"OB")
 ;
AT W "AT ",$E(S_0,9,10),":",$E(S_"000",11,12) Q
IN W:SC-I&$D(^SC(I,0)) " IN ",$P(^(0),U,1) Q
PROT K SDPROT
 I $D(^SC(I,"SDPROT")),$P(^("SDPROT"),U)="Y",'$D(^SC(I,"SDPRIV",DUZ)) D  Q
 .W !!,*7,">>> Access to ",$$CNAM(I)," is prohibited!"
 .W !,"    Only users with a special code may access this clinic.",!
 .S SDPROT=""
 ;
 I $$CODT^SDCOU(DFN,SD,I) D  Q
 .W !?5,*7,">>> A check out date has been entered for this appointment!"
 .W !?5,"    Please enter another date and time.   Thank you.",!
 .S SDPROT=""
 Q
 ;
CNAM(SDCL) ;Return clinic name
 ;Input: SDCL=clinic ien
 N SDX
 S SDX=$P($G(^SC(+SDCL,0)),U)
 Q $S($L(SDX):SDX,1:"this clinic")
 ;
FLEN S APL="" I $D(^SC(I,"S",SD)) F ZL=0:0 S ZL=$O(^SC(I,"S",SD,1,ZL)) Q:ZL=""  I +^(ZL,0)=DFN S APL=$P(^SC(I,"S",SD,1,ZL,0),"^",2)
 Q
 ;
DISP G ^SDM1 ; LINE TAG IS NO LONGER USED
 ;W !?4 K S F SDQ=Y:0 S SDQ=$N(^SC(SC,"S",SDQ)) Q:Y+1<SDQ!(SDQ<0)  F I=0:0 S I=$N(^SC(SC,"S",SDQ,1,I)) Q:I'>0  Q:'$D(^(I,0))  S ST=$S($P(^(0),U,4)="":"BLANK",1:"'"_$E($P(^(0),U,4),1,28)_"'"),S(ST)=$S($D(S(ST)):S(ST)+1,1:1)
 ;I '$D(S) W "NO APPNT'S SCHEDULED YET" G ^SDM1
 ;W "'OTHER' TYPES ALREADY SCHEDULED:   ",!
 ;S S=0 F I=0:1 S S=$N(S(S)) G ^SDM1:S=-1 W:$X+$L(S)>72 ! W S,": ",S(S),"     "
CK1 S SDZ=0 F SD1=$P(S,"."):0 S SD1=$O(^DPT(DFN,"S",SD1)) Q:'SD1!((SD1\1)'=(S\1))  I $P(^(SD1,0),"^",2)'["C",$P(^(0),"^",2)'["N" S SDZ=1 Q
 Q:SDZ  F SD1=2,4 I $D(^SC("AAS",SD1,$P(S,"."),DFN)) S SDZ=1 Q
 Q:SDZ  IF $D(^SCE(+$$EXAE^SDOE(DFN,S\1,S\1),0)) S SDX=1
 Q:SDZ  K ^DPT("ASDPSD","B",DIV,$P(S,"."),DFN) Q
STAT N X S SDCMHDL=$$HANDLE^SDAMEVT(1) D BEFORE^SDAMEVT(.SDATA,DFN,SD,I,"",SDCMHDL),NOW^%DTC
 S $P(^DPT(DFN,"S",SD,0),"^",2)="C",$P(^(0),"^",14)=$E(%,1,12) S:$D(DUZ) $P(^(0),"^",12)=DUZ S ^DPT("ASDCN",+^(0),SD,DFN)=""
 K ^TMP("SDWLREB",$J),^TMP($J,"SDWLPL") N SC S SC=+^DPT(DFN,"S",SD,0) D OPENEWL^SDWLREB(DFN,SD,SC,0) K ^TMP($J,"SDWLP")
 I $D(^TMP("SDWLREB",$J)) D MESS^SDWLREB ; SD/467
 Q
 ;
EVT ; -- separate tag if need to NEW vars
 ; -- cancel event
 D CANCEL^SDAMEVT(.SDATA,DFN,SDTTM,SDSC,SDPL,0,SDCMHDL)
 Q
