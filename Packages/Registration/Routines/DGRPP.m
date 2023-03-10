DGRPP ;ALB/MRL,AEG,LBD,ASF,LEG,RN - REGISTRATION SCREEN PROCESSOR ;Apr 05, 2020@15:16
 ;;5.3;Registration;**92,147,343,404,397,489,689,688,828,797,871,997,1014,1040,1027**;Aug 13, 1993;Build 70
 ;
 ;DGRPS    : Screen to edit
 ;DGRPSEL  : If screen 9 (income screening) set to allowable selections
 ;           (V=Veteran, S=Spouse, D=Dependents)
 ;DGRPSELT : If screen 9, type selected (V, S, or D or all if none specified)
 ;DGRPAN   : Selectable items on screen for edit (user input)
 ;DGRPANP  : Selectable items for print on page footer - i.e. 1-3
 ;DGRPANN  : Selected item(s) extrapolated (screen_item)
 ;
 ;
EN ;
 D:'$$BEGUPLD^DGENUPL3(DFN)
 .D UNLOCK^DGENPTA1(DFN)
 .D CKUPLOAD^DGENUPL3(DFN)
 .I $$LOCK^DGENPTA1(DFN)
 D ENDUPLD^DGENUPL3(DFN)
 ; DG*5.3*1040 - If timed out, clean screen with W @IOF, use variable DGRPOUT to track timeout and exit
 I $D(DTOUT)!(+$G(DGTMOT)) S DGRPOUT=1 W @IOF,!!! G QQ
 ;jam; Patch DG*5.3*997 - include screen 11.5 group 1 to be editable when in View Reg option (DGRPV=1)
 D Q1,WHICH^DGRPP1 W ! K DGRP S DGRPAN="" F I=1:1:$L(DGRPVV(DGRPS)) I $S('DGRPV:1,DGRPS=6:I=1!(I=2)!(I=3),DGRPS=11:I=5,DGRPS=11.5:I=1!(I=2),1:0) S:'$E(DGRPVV(DGRPS),I) DGRPAN=DGRPAN_I_"," ;LEG; DG*5.3*1014 added I=2 for <11.5>
 D STR^DGRPP1 F I=$Y:1:20 W !
 ; remove COPY option DG*5.3*688
 I ("8^9"[DGRPS),($G(DGEFDT)'=DT) S Z="E" D W W "=ENTER new "_(DGISYR+1)_" data,"
 S Z="<RET>" D W W " to ",$S(DGRPS<DGRPLAST:"CONTINUE",1:"QUIT"),", "
 I DGRPAN]"" S Z=DGRPANP D W D
 . I '$G(DGRPV) W " or " S Z="ALL" D W
 . ; jam; DG*5.3*997 - add screen 11.5 to allow group 1 to be expanded in View Reg option - DGRPV=1)
 . W " to "_$S('$G(DGRPV):"EDIT, ",DGRPS=6!(DGRPS=11)!(DGRPS=11.5):"EXPAND, ",1:"")
 S DGRPOUT=0,Z="^N" D W W " for screen N or " S Z="'^'" D W W " to QUIT" I DGRPSEL=""!(DGRPVV(9)'["0")!+$G(DGRPV) W ": "
 I DGRPSEL]"" D MOREHLP^DGRPP1
 G:$E(IOST,1,2)="P-" NEXT  ;RGB/VM 4/28/10 Just go to next screen for non-interactive jobs
 R DGRPANN:DTIME S:'$T DGRPOUT=1 I DGRPANN']"",'DGRPOUT G NEXT
 ; DG*5.3*1040 - If timed out, clean screen with W @IOF, use variable DGRPOUT to track timeout and exit
 I +$G(DGRPOUT) W @IOF,!!! G QQ
 I $E(DGRPANN)="E",$G(DGNOBUCK),("8^9"[DGRPS) D
 .S DGNOCOPY=1
 . ; remove COPY option DG*5.3*688
 .S DGRPANN=U_DGRPS,DGRPVV(9)="000",DGRPVV(8)="00",DGIAINEW=1
JUMP ;
 G:DGRPANN="^" Q  G JUMP^DGRPP1:DGRPANN?1"^".N.".".N.".".N I DGRPOUT!(DGRPANN?1"^".E) G Q
 S (DGRPANN,X)=$$UPPER^DGUTL(DGRPANN)
 I $E(DGRPANN)="A" S X=DGRPANN,Z="^ALL" D IN^DGHELP I %'=-1 S DGRPANN=DGRPANP
 ;LEG; DG*5.3*997 ; add screen 11.5
 I DGRPANN'?1N.E D ^DGRPH G:DGRPS'=1.1&(DGRPS'=11.5) @("^DGRP"_DGRPS)  G:DGRPS=1.1 ^DGRPCADD  G:DGRPS=11.5 ^DGRP11A
 S DGDR="" F I=1:1 S DGCH=$P(DGRPANN,",",I) Q:DGCH']""!($L(DGCH)>5)  D CHOICE
 I DGDR']"" D ^DGRPH S X=DGRPS G SCRX
 D ^DGRPE G QQ:'$D(^DPT(DFN,0)) S X=DGRPS G SCRX
Q I 'DGELVER D:$S(DGRPOUT:0,'$D(DGRPV):0,'DGRPV:1,1:0) LT^DGRPP1
 K DGDEP,DGINC,DGINR,DGMTC,DGMTED,DGREL,DGTOT,DGSP
 K DGCH,DGGTOT,DGIRI,DGPRI,DGRPSE1,DGNOCOPY
 D SENSCHK
 ;DG*5.3*1027 Setting default values for DGDONE and DGDONE2 used in DGRPC 
 N DGDONE,DGDONE2 S DGDONE=0,DGDONE2=0
 I 'DGRPV S DGEDCN=1 D ^DGRPC K DGEDCN
QQ K DGRPNA,DGRPS,DGRPTYPE,DGRPU,DGRPV,DGRPVV,DGRPW,DGVI,DGVO,DGRPCM,DGELVER,DGRPLAST
Q1 K %DT,C,DGA,DGA1,DGA2,DGAD,DGDR,DGRP,DGRPAG,DGRPAN,DGRPANN,DGRPANP,DGRPD,DGRPSEL,DGRPSELT,DGRPVR,DGRPX,DGAAC
 ; DG*5.3*1040 - clean-up variable DGTMOT
 K DIRUT,DUOUT,DTOUT,DGTMOT
 K DIC,I,I1,I2,I3,J,X,X1,X2,X3,Y,Z,Z1 I $D(DFN)#2,DFN]"" S:$D(^DPT(DFN,0)) DA=DFN
 Q
 ;
SENSCHK ; check whether patient record should be made sensitive
 N ELIG,FLAG,X
 S ELIG=0,FLAG=0
 I '$D(^DPT($G(DFN),0)) Q  ; patient not defined
 I $D(^DGSL(38.1,DFN,0)) Q  ; patient already in dg security log file
 S X=$S($D(^DPT(DFN,"TYPE")):+^("TYPE"),1:"") I $D(^DG(391,+X,0)),$P(^(0),"^",4) D SEC Q:FLAG
 F  S ELIG=$O(^DPT(DFN,"E",ELIG)) Q:'ELIG  D  Q:FLAG
 . S X=$G(^DIC(8,ELIG,0))
 . I $P(X,"^",12) D SEC
 Q
 ;
SEC ;if patient type says make record sensitive, add to security log file
 K DD,DO S DIC="^DGSL(38.1,",(X,DINUM)=DFN,DIC(0)="L",DIC("DR")="2///1;3////"_DUZ_";4///NOW;" D FILE^DICN
 I $D(^DGSL(38.1,DFN,0)) W !!,"===> Record has been classified as sensitive." S FLAG=1
 K DIC,X,DINUM,DA,DD,DO,Y
 Q
 ;
CHOICE ;parse out which items were selected for edit
 ;
 ;DGCH=choice to be parsed (either number or number-number)
 ;
 N DGFL S DGFL=0
 I DGCH["-" Q:DGCH'?1.2N1"-"1.2N!($P(DGCH,"-",2)>17)  F J=$P(DGCH,"-",1):1:$P(DGCH,"-",2) I DGRPAN[(J_",") D:(DGRPS=9) SCR9 I 'DGFL S DGDR=DGDR_(DGRPS*100+J)_","
 I DGCH'["-",DGCH?1.2N,(DGRPAN[(DGCH_",")) S DGDR=DGDR_(DGRPS*100+DGCH)_","
 Q
 ;
NEXT ;find next available screen...goto
 I DGRPS=DGRPLAST G Q ;last screen and return...quit
 S X=DGRPLAST
 F I=DGRPS+1:1 S J=$E(DGRPVV,I) Q:J']""  I 'J S X=I Q
 I DGRPS=1 S X=1.1
 ;LEG; DG*5.3*997; added screen 11.5
 I DGRPS=11 S X=11.5
 I DGRPS=11.5 S X=12
SCRX ;goto screen X
 I X[".",X'=1.1,X'=11.5 S X=$P(X,".",1) ;ASF; DG*5.3*997 ; Added screen 11.5
 G:X=1.1 ^DGRPCADD
 ;ASF; DG*5.3*997; add condition for 11.5
 G:X=11.5 ^DGRP11A
 G:(X'=1.1)&(X'=11.5) @("^DGRP"_X) ;goto next available screen;
W ;write highlighted text on screen (if parameter on)
 I IOST="C-QUME",$L(DGVI)'=2 W Z
 E  W @DGVI,Z,@DGVO
 Q
 ;
SCR9 ; see if MT is completed.  Allow only selective editing if so
 I 'DGMTC Q
 I '$D(DGRPSELT) S:DGMTC=1 DGFL=1 Q  ;if no non-mt dependents
 I DGRPSELT="S",$D(DGMTC("S")) Q
 I DGRPSELT="D",$D(DGMTC("D")) Q
 S DGFL=1
 Q
