PSGOE91 ;BIR/CML3-ACTIVE ORDER EDIT (CONT.) ; 8/4/10 7:07am
 ;;5.0;INPATIENT MEDICATIONS;**50,64,58,110,111,136,113,179,265**;16 DEC 97;Build 4
 ;
 ;Reference to ^PS(55 is supported by DBIA #2191.
 ;
41 ; admin times
 S MSG=0,PSGF2=41,ORIG=$G(PSGAT) S:PSGOEEF(PSGF2) BACK="41^PSGOE91"
 I $$ODD^PSGS0(PSGS0XT)!(PSGST="P")!$$PRNOK^PSGS0($G(PSGSCH)) G DONE
A41 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"ADMIN TIMES may not be edited for active complex orders." D PAUSE^VALM1
 W !,"ADMIN TIMES: "_$S(PSGAT:PSGAT_"// ",1:"") R X:DTIME I X="^"!('$T) W:'$T $C(7) S PSGOEE=0 S:X="^" (X,PSGAT)=ORIG G DONE
 I X="" S:$G(PSGAT) X=PSGAT
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A41
 I X="@" I (PSGS0XT="D")!(PSGSCH["@") I ((",P,R,OC,O,")'[(","_$G(PSGST)_",")) D  G A41
 .W $C(7),"  ??" S X="?" W:PSGS0XT="D"!(PSGSCH["@") !,"This is a 'DAY OF THE WEEK' schedule and MUST have admin times." D ENHLP^PSGOEM(55.06,41)
 I X="@" D DEL G:%'=1 A41 S PSGAT="",X=""
 I (PSGST="O")!($G(PSGST)="OC")!($G(PSGST)="P")!$$ODD^PSGS0($P(ZZND,"^",3))!($P(ZZND,"^",5)="O") I X="" S (PSGS0Y,PSGAT)=X G DONE
 I $G(PSGS0XT) I '$$ODD^PSGS0(PSGS0XT),$G(PSGST)'="P",$G(PSGST)'="OC",'$$PRNOK^PSGS0(PSGSCH) I ($G(PSGST)'="O") D TIMES I '$D(X) G A41
 I X?1."?" D ENHLP^PSGOEM(55.06,41) G A41
 D ENCHK^PSGS0 I '$D(X) W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(55.06,41) G A41
 S PSGOAT=PSGAT
 S (PSGS0Y,PSGAT)=X G DONE
 ;
8 ; special instructions
 S MSG=0,PSGF2=8 S:PSGOEEF(PSGF2) BACK="8^PSGOE91"
A8 I $G(PSGP),$G(PSGORD) I $$COMPLEX^PSJOE(PSGP,PSGORD) D
 . N X,Y,PARENT,P2ND S P2ND=$S(PSGORD["U":$G(^PS(55,PSGP,5,+PSGORD,.2)),1:$G(^PS(53.1,+PSGORD,.2))),PARENT=$P(P2ND,"^",8)
 . I PARENT D FULL^VALM1 W !!?5,"This order is part of a complex order. Please review the following ",!?5,"associated orders before changing this order." D CMPLX^PSJCOM1(PSGP,PARENT,PSGORD)
 N DIR S DIR(0)="FO^1:180^D ^PSGSICHK",DIR("A")="SPECIAL INSTRUCTIONS",DIR("??")="^D ENHLP^PSGOEM(55.06,8)" S:$G(PSGSI)]"" DIR("B")=$P(PSGSI,"^") D ^DIR I $D(DUOUT)!$D(DTOUT) S PSGOEE=0 G DONE
 I $E(X)=U D ENFF^PSGOE92 G:Y>0 @Y G A8
 I X="@",PSGSI="" W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(55.06,8) G A8
 I X="@" D DEL G:%'=1 A8 S PSGSI="" G DONE
 I Y="",PSGSI="" G DONE
 S PSGSI=$S(Y]"":Y,1:PSGSI),PSGSI=$$ENBCMA^PSJUTL("U") G DONE
 Q
 W !,"SPECIAL INSTRUCTIONS: "_$S(PSGSI]"":PSGSI_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="" S X=PSGSI I X="" G DONE
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A8
 I X="@",PSGSI="" W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(55.06,8) G A8
 I X="@" D DEL G:%'=1 A8 S PSGSI="" G DONE
 I X?1."?" D ENHLP^PSGOEM(55.06,8) G A8
 D ^PSGSICHK I '$D(X) W $C(7)," ??" S X="?" D ENHLP^PSGOEM(55.06,8) G A8
 S PSGSI=X G DONE
 ;
10 ; start date/time
 S MSG=0,PSGF2=10 S:PSGOEEF(PSGF2) BACK="10^PSGOE91"
A10 ;
 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Start Date/Time may not be edited for active complex orders." D PAUSE^VALM1
 K PSGSDX
 W !,"START DATE/TIME: "_$S($P(PSGSDN,"^")]"":$P(PSGSDN,"^")_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGSD W "  "_PSGSDN G DONE
 I X="P" D ENPREV^PSGDL W:'$D(X) $C(7) G:'$D(X) A10 S PSGSD=+X,PSGSDN=$$ENDD^PSGMI(PSGSD)_"^"_$$ENDTC^PSGMI(PSGSD) W "  ",$P(PSGSDN,"^") G DONE
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(55.06,10)
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A10
 NEW TMPX S TMPX=X,X1=PSGDT,X2=-7 D C^%DTC K %DT S %DT="ERTX",%DT(0)=X,X=TMPX D ^%DT K %DT I Y'>0 D ENHLP^PSGOEM(55.06,10) G A10
 I PSGFD<Y W $C(7),!?5,"*** THE START DATE CANNOT BE AFTER THE STOP DATE! ***",! S MSG=1 G A10
 S (PSGSDX,PSGSD)=+Y,PSGSDN=$$ENDD^PSGMI(PSGSD)_"^"_$$ENDTC^PSGMI(PSGSD) G DONE
 ;
34 ; stop date
 S MSG=0,PSGF2=34 S:PSGOEEF(PSGF2) BACK="34^PSGOE91"
A34 ;
 K PSGFDX
 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Stop Date/Time may not be edited for active complex orders." D PAUSE^VALM1
 W !,"STOP DATE/TIME: "_$S($P(PSGFDN,"^")]"":$P(PSGFDN,"^")_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGFD W "   "_$P(PSGFDN,"^") G W34
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A34
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(55.06,34)
 I X=+X,(X>0),(X'>2000000) G A34:'$$ENDL^PSGDL(PSGSCH,X) K PSGDLS S PSGDL=X W " ...dose limit..." D ENE^PSGDL
 K %DT S %DT="ERTX",%DT(0)=PSGSD D ^%DT K %DT G:Y'>0 A34 S (PSGFDX,PSGFD)=+Y,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)
W34 ;Compare to Start Date
 N Z,MSG
 D DOSE I $G(Z)]"",Z>$S($G(PSGFD):PSGFD,1:$G(PSGNEFD)) D  G A34
 . S MSG(1)="There is no administration time that falls between the Start Date/Time"
 . S MSG(2)="and the Stop Date/Time."
 . D EN^DDIOL(.MSG)
 I PSGFD<PSGDT W $C(7),!!?13,"*** WARNING! THE STOP DATE ENTERED IS IN THE PAST! ***",! S MSG=1
 ;
DONE ;
 ;Display Expected First Dose;BHW;PSJ*5*136
 ;BHW;PSJ*5*179; - Remove EFD call.  Added to PSGOEE.
 ;D EFDACT^PSJUTL
 I PSGOEE G:'PSGOEEF(PSGF2) @BACK S PSGOEE=PSGOEEF(PSGF2)
 K F,F0,F1,PSGF2,F3,PSG,SDT,ORIG Q
 ;
FF ; up-arrow to another field
 D ENFF^PSGOEM I Y>0,Y'=41,Y'=8,Y'=10,Y'=34 S Y=Y_"^PSGOE9"_$S("^109^13^3^7^26^"[("^"_Y_"^"):"",1:2) S:Y=2 FB=PSGF2_"^PSGOE91"
 Q
 ;
DEL ; delete entry
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W $C(7),"  <NOTHING DELETED>"
 Q
 ;
TIMES ;At least one admin time, not more than interval allows.
 I $G(PSGST)'="O",($G(PSGST)'="OC"),($G(PSGST)'="R") I X="" D EN^DDIOL("This order requires at least one administration time.") K X Q  ;No times
 N H,I,MAX
 I PSGSCH]"" I $D(^PS(51.1,"AC","PSJ",PSGSCH)) S H=+$O(^PS(51.1,"AC","PSJ",PSGSCH,0)) S I=$P($G(^PS(51.1,H,0)),"^",3)
 I $G(PSGST)="O",$L(X,"-")>1 D EN^DDIOL("This is a One Time Order. Only one administration time is permitted.") K X Q
 I $G(PSGST)="O" Q  ;Done validating One Time
 I +$G(I)=0 Q  ;No frequency - can not check frequency related items
 S MAX=1440/I
 I MAX<1,$L(X,"-")>1 D EN^DDIOL("This order requires one administration time.") K X Q
 I MAX'<1,$L(X,"-")>MAX D EN^DDIOL("The number of admin times entered is greater than indicated by the schedule.") K X Q  ;Too many times
 I MAX'<1,$L(X,"-")<MAX D EN^DDIOL("The number of admin times entered is fewer than indicated by the schedule.")  ;Too few times
 Q
 ;
DOSE ;Make certain at least one dose is given.
 N INFO,X
 S Z="",INFO=($S($G(PSGSD):PSGSD,1:$G(PSGNESD)))_U_($S($G(PSGFD):PSGFD,1:$G(PSGNEFD)))_U_($G(PSGSCH))_U_($G(PSGST))_U_($G(PSGDRG))_U_($G(PSGS0Y))
 Q:$G(PSGST)="OC"!($G(PSGST)="P")
 I '$L($G(PSGP)) N PSGP S PSGP=""
 S Z=$$ENQ^PSJORP2(PSGP,INFO)  ;Expected first dose.
 Q
