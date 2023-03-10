SDD0 ;SF/GFT,ALB/BOK,JSH,LDB - REMAP A CLINIC ;26 JAN 84  3:00 pm
 ;;5.3;Scheduling;**167,401,529,674,726,753,775,780**;Aug 13, 1993;Build 17
SETX ;
 N SDDIV
 S SDDIV=$P($G(SD0),"^",15) Q:SDDIV=""
 I '$D(VAUTD(SDDIV)),VAUTD=0 Q
 Q:'$D(^SC(SC,"SL"))  S SDSL=^("SL"),SL=+^("SL"),X=$P(SDSL,U,3),STARTDAY=$S($L(X):X,1:8),X=$P(SDSL,U,6),HSI=$S('X:4,X<3:8/X,1:2),SI=$S(X:X,1:4),SDSI=SI
 S:SI=1 SI=4 S:SI=2 SI=4 S SDSOH=$S($P(SDSL,U,8)']"":0,1:1)
 K SDIN,SDRE,SDRE1 N SDNODE I $D(^SC(SC,"I")) S SDIN=+^("I"),SDRE=+$P(^("I"),"^",2),Y=SDRE D DTS^SDUTL S SDRE1=Y
 N SDX,SDIEN,SDBEG,SDDOW,SDBEGO,SDBEGZ ;New variables for SD*5.3*674 and SD*5.3*726 changes
 ;Set beginning date to use for indefinite clinic availabilities
 F SDX=0:1:6 S SDDOW(SDX,9999999)="" ;SD*5.3*674
 S SDBEGO="" F SDDAY=0:1:6 S SDCNT=0 F  S SDCNT=$O(^SC(+SC,"T"_SDDAY,SDCNT)) Q:'SDCNT  S SDBEGO=SDBEGO_U_SDCNT
 S SDX=0 F  S SDX=$O(^SC(SC,"T",SDX)) Q:'SDX!(SDX>ENDDATE)  S SDBEGZ=$O(^SC(+SC,"T"_$$DOW^XLFDT(SDX,1),9999999),-1) D  ;Add SDBEGZ to check for duplicate OST entry
 .I '$D(^SC(SC,"OST",SDX))!(SDBEGO[SDX)!(SDBEGZ=0)!($G(^SC(+SC,"T"_$$DOW^XLFDT(SDX,1),9999999))=""&(SDBEGZ>0)) S SDBEG=$G(^SC(SC,"T",SDX,0),SDX) S SDDOW($$DOW^XLFDT(SDBEG,1),SDBEG)="" ;SD*5.3*674 and SD*5.3*726
 F DATE=$$FMADD^XLFDT(SDBD,-1):0 S X1=DATE,X2=1 N X D C^%DTC S DATE=X S SDNODE=$D(^SC(SC,"ST",DATE)) Q:DATE'>0!(DATE>SDED)  I $S('$D(SDIN):1,'SDIN:1,SDIN>DATE:1,SDRE'>DATE&(SDRE):1,1:0) K SM,SDHOL D CHECK  ;changed 1st part of For loop SD*529
 Q
CHECK S X=DATE D DW^%DTC S DAY=$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR",U,Y+1),DOW=Y
 D APPT I $D(^SC(SC,"ST",DATE,1)),^(1)'[$E(DAY,1,2)&(^(1)["]") S MSG="Bogus clinic day"_$S(SDAPPT:"- Appts!",1:"") D PRNT
 I $D(^SC(SC,"ST",DATE,1)),^(1)["CANCEL"!($E(^(1),$F(^(1),"["),999)?."X") S MSG="Cancelled" D PRNT Q
 I $D(^HOLIDAY(DATE,0)),'SDSOH S SDHOL=1,X=$P(^(0),U,2) G HOLIDAY:'SDAPPT,Z:SDAPPT
 K ^SC(SC,"ST",DATE) S SS=+$O(^SC(SC,"T"_DOW,DATE)),SB=STARTDAY-1/100,STR="{}&%?#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz"
 I $D(^SC(SC,"OST",DATE,1)),^(1)]"" S (X,DR)=DATE D DOW^SDM0 S DOW=Y,SM=^SC(SC,"OST",DATE,1),SS=0 G:'SDAPPT OVR G I
 G Z:'$D(^SC(SC,"T"_DOW,SS,1)) I ^(1)="" S MSG="no master pattern for this day" D:SDNODE PRNT Q
 S DH=^(1),X=DATE G FIX ;NAKED REFERENCE ^SC(IFN,"T"_DOW,DATE,1)
HOLIDAY S ^SC(SC,"ST",DATE,1)="   "_$E(DATE,6,7)_"    "_X,^(0)=DATE
 D EN^SDTMPHLC(SC,DATE,,"C",X) ;780
Z S MSG=$S($D(SDHOL)&SDAPPT:"- Appts!",'SDSOH&$D(SDHOL):"- Inserted",1:"") I MSG]"" S MSG=X_MSG D PRNT
 Q
END K %,%DT,DATE,DAY,DH,DOW,DR,DR1,HSI,I,P,POP,S,SB,SC,SDAPPT,SDAPPT1,SDBD,SDNM,SDED,SDHOL,SD0,SDIN,SDRE,SDRE1,SDSAVX,SDSL,SDSOH,SI,SM,SS,SD,SCI,SCC,ST,STARTDAY,STR,X,MSG,Y,YP,PG,DGVAR,DGPGM,VAUTD,VAUTC,SDU,BEGDATE,ENDDATE D CLOSE^DGUTQ Q
FIX ;DH=PATTERN  X=DATE
 D SM G:('SDAPPT&('$D(^SC(SC,"S",DR,"MES")))) OVR ;SD*5.3*753, add check for canceled appointments
I S I=DR#1-SB*100,I=I#1*SI\.6+(I\1*SI)*2,S=$E(SM,I,999),SM=$E(SM,1,I-1)
 I $D(^SC(SC,"S",DR,"MES")) D CAN S X=SDSAVX K SDSAVX S DR=+$O(^SC(SC,"S",DR)) G:DR\1=X I G OVR
 F Y=0:0 S Y=$O(^SC(SC,"S",DR,1,Y)) Q:Y'>0  I $P(^(Y,0),"^",9)'["C",((+$E($P(DR,".",2)_"000",1,4)>=($S($P($G(^SC(SC,"SL")),U,3)>0:+$P(^SC(SC,"SL"),U,3)_"00",1:800)))) D  ;Ignore appts prior to Begin time, SD*5.3*726
 .S SDSL=$P(^SC(SC,"S",DR,1,Y,0),U,2)/SL*(SL\(60/SDSI))*HSI-HSI F I=0:HSI:SDSL S ST=$E(S,I+2) S:ST="" ST=" " S S=$E(S,1,I+2-1)_$S("{}&%?#"[ST:ST,1:$E(STR,$F(STR,ST)-2))_$E(S,I+3,999) ;SD*5.3*775 - Correct overbooks >10
 S SM=SM_S,DR=$O(^SC(SC,"S",DR)) I DR\1=X G I
OVR I $L(SM)>SM,(X>=$O(SDDOW($$DOW^XLFDT(X,1),(X+1)),-1)&($O(SDDOW($$DOW^XLFDT(X,1),(X+1)),-1)))!($D(^SC(SC,"OST",X))) S ^SC(SC,"ST",X,0)=X,^(1)=SM S:SS'>0 ^(9)=SC ;Verify indefinite schedule after start date, SD*5.3*674
 G Z
SM S SM=$P("SU^MO^TU^WE^TH^FR^SA",U,DOW+1)_" "_$E(X,6,7)_$J("",SI+SI-6)_DH_$J("",64-$L(DH)) Q
APPT S DR=+$O(^SC(SC,"S",DATE)),SDAPPT=0 I DR>(DATE_.9) S DR=DATE Q
 F DR1=DATE:0 S DR1=$O(^SC(SC,"S",DR1)) Q:DR1'>0!(DR1>(DATE+1))!(SDAPPT)  S:$D(^(DR1,"MES")) SDAPPT=1 F SDAPPT1=0:0 S SDAPPT1=$O(^SC(SC,"S",DR1,1,SDAPPT1)) Q:SDAPPT1'>0  I $D(^(SDAPPT1,0)) S SDAPPT=$S($P(^(0),"^",9)="C":0,1:1) Q:SDAPPT
 Q
CAN S SDSAVX=X Q:'$D(^SC(SC,"SDCAN",DR,0))  S X=$E($P(DR,".",2)_"0000",1,4),I=SM_S D TT S ST=%,X=$P(^SC(SC,"SDCAN",DR,0),"^",2) D TT S I=I_$J("",%-$L(I)),Y=""
 F X=0:2:% S S=$E(I,X+SI+SI),P=$S(X<ST:S_$E(I,X+1+SI+SI),X=%:$S(Y="[":Y,1:S)_$E(I,X+1+SI+SI),1:$S(Y="["&(X=ST):"]",1:"X")_"X"),Y=$S(S="]":"",S="[":S,1:Y),I=$E(I,1,X-1+SI+SI)_P_$E(I,X+2+SI+SI,999)
 N SDIF S:'$F(I,"[") SDIF=$F(I,"X"),I=$E(I,1,(SDIF-2))_"["_$E(I,SDIF,999) ;SD*5.3*753 - Ensure "[" if all appointments canceled
 S SM=I Q
TT S %=$E(X,3,4),%=X\100-STARTDAY*SI+(%*SI\60)*2 Q
PRNT U IO S YP=YP+1 D:YP>(IOSL-4) ESC^SDD W !,$E(SDNM,1,25),?27,$E(DAY,1,3)_" " S Y=DATE D DT^DIO2 W ?45,MSG Q
ESC S SDU=0 I $E(IOST,1,2)="C-" W *7 R ESC:DTIME S:U=ESC SDU=1
