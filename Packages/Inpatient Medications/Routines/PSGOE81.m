PSGOE81 ;BIR/CML3-NON-VERIFIED ORDER EDIT (CONT.) ; 7/20/12 12:43am
 ;;5.0;INPATIENT MEDICATIONS;**26,50,64,58,82,110,111,136,113,267**;16 DEC 97;Build 158
 ;
39 ; admin times
 S MSG=0,PSGF2=39 S:PSGOEEF(PSGF2) BACK="39^PSGOE81",ORIG=$G(PSGAT)
A39 I $$ODD^PSGS0(PSGS0XT)!(PSGST="P")!$$PRNOK^PSGS0($G(PSGSCH)) G DONE
 W !,"ADMIN TIMES: "_$S(PSGAT:PSGAT_"// ",1:"") R X:DTIME I X="^"!('$T) W:'$T $C(7) S PSGOEE=0 S:X="^" (X,PSGAT)=ORIG G DONE
 I X="" S:(($G(PSGS0XT)="D")&'PSGS0Y) PSGOEE=0 S:$G(PSGAT) X=PSGAT
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A39
 I X=" "!(X?1."?") D ENHLP^PSGOEM(53.1,39) G A39
 I PSGS0XT="D"&'$G(X) I ((",P,R,")'[(","_$G(PSGST)_",")) D  G A39
 .W $C(7),"  ??" S X="?" W !,"This is a 'DAY OF THE WEEK' schedule and MUST have admin times." D ENHLP^PSGOEM(53.1,39)
 I X="@" D DEL G:%'=1 A39 S PSGAT="",X=""
 I $G(PSGS0XT),'$$ODD^PSGS0(PSGS0XT),$G(PSGS0XT)'="P",$G(PSGS0XT)'="OC",'$$PRNOK^PSGS0(PSGSCH),($G(PSGST)'="O") D TIMES I '$D(X) G A39
 I (($G(PSGST)="O")!($G(PSGST)="OC")) I (X="") S (PSGAT,PSGS0Y)=X G DONE
 D ENCHK^PSGS0 I '$D(X) W $C(7) G A39
 S PSGOAT=PSGAT
 S (PSGS0Y,PSGAT)=X G DONE
 ;
8 ; special instructions
 S MSG=0,PSGF2=8 S:PSGOEEF(PSGF2) BACK="8^PSGOE81"
A8 ; special instructions
 ;I $E($G(X))=U D ENFF^PSGOE82 G:Y>0 @Y G A8
 S PSGSI=$$EDITSI^PSJBCMA5($G(PSGP),$G(PSGORD)) I $G(PSGP),$G(PSGORD) I '$$DIFFSI^PSJBCMA5(PSGP,PSGORD) S PSGOEE=0 G DONE
 S PSGSI=$S((PSGSI>0&(PSGSI<4)):$G(^PS(53.45,+PSJSYSP,5,1,0))_" "_$G(^PS(53.45,+PSJSYSP,5,2,0)),PSGSI>3:"Instructions too long. See Order View or BCMA for full text",1:"")
 I PSGSI]"" S PSGSI=$$ENBCMA^PSJUTL("U") G DONE
 Q
 ;
10 ; start date/time
 S MSG=0,PSGF2=10 S:PSGOEEF(PSGF2) BACK="10^PSGOE81"
A10 ; start date/time
 K PSGSDX N DUR,DURMIN,TMPFD
 I $G(PSGORD)["P",$G(PSGP) I $$LASTREN^PSJLMPRI(PSGP,PSGORD) D  Q
 . W !?5,"Start Date may not be edited at this point. " D PAUSE^VALM1
 W !,"START DATE/TIME: "_$S($P(PSGSDN,"^")]"":$P(PSGSDN,"^")_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGSD W "  "_$P(PSGSDN,"^") G DONE
 I X="P" D ENPREV^PSGDL W:'$D(X) $C(7) G:'$D(X) A10 S PSGSD=+X,PSGSDN=$$ENDD^PSGMI(PSGSD)_"^"_$$ENDTC^PSGMI(PSGSD) W "  ",$P(PSGSDN,"^") G DONE
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,10)
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A10
 NEW TMPX S TMPX=X,X1=+$G(PSGLI),X2=-7 D C^%DTC K %DT S %DT="ERTX",%DT(0)=X,X=TMPX D ^%DT K %DT I Y'>0 D ENHLP^PSGOEM(53.1,10) G A10
 I PSGFD<Y W $C(7),!?5,"*** THE START DATE CANNOT BE AFTER THE STOP DATE! ***",! S MSG=1 G A10
 S (PSGSDX,PSGSD,PSGNESD)=+Y,PSGSDN=$$ENDD^PSGMI(PSGSD)_"^"_$$ENDTC^PSGMI(PSGSD)
 I $G(PSGORD)["P",$G(PSGP) S DUR=$$GETDUR^PSJLIVMD(PSGP,+PSGORD,"P",1) I DUR]"" S DURMIN=$$DURMIN^PSJLIVMD(DUR) I DURMIN D
 . S TMPFD=$$FMADD^XLFDT(PSGSD,,,DURMIN) K:(TMPFD<PSGSD) TMPFD I $G(TMPFD) S PSGFD=TMPFD,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)
 G DONE
 ;
25 ; stop date
 S MSG=0,PSGF2=25 S:PSGOEEF(PSGF2) BACK="25^PSGOE81"
A25 ;
 K PSGFDX
 W !,"STOP DATE/TIME: "_$S($P(PSGFDN,"^")]"":$P(PSGFDN,"^")_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGFD S X=$P(PSGFDN,"^") ;W "   "_$P(PSGFDN,"^")
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A25
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,25)
 I X=+X,(X>0),(X'>2000000) G A25:'$$ENDL^PSGDL(PSGSCH,X) K PSGDLS S PSGDL=X W " ...dose limit..." D ENE^PSGDL
 K %DT S %DT="ERTX",%DT(0)=PSGSD D ^%DT K %DT G:Y'>0 A25 S (PSGFDX,PSGFD,PSGNEFD)=+Y,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)
W25 ;
 N Z,MSG
 D DOSE I $G(Z)]"",Z>PSGNEFD D  G A25
 . S MSG(1)="There is no administration time that falls between the Start Date/Time"
 . S MSG(2)="and the Stop Date/Time."
 . D EN^DDIOL(.MSG)
 I PSGFD<PSGDT W $C(7),!!?13,"*** WARNING! THE STOP DATE ENTERED IS IN THE PAST! ***",! S MSG=1
 ;
DONE ;
 ;Display Expected First Dose;BHW;PSJ*5*136
 D EFDNV^PSJUTL
 I PSGOEE G:'PSGOEEF(PSGF2) @BACK S PSGOEE=PSGOEEF(PSGF2)
 K ORIG
 Q
 ;
FF ; up-arrow to another field
 D ENFF^PSGOEM I Y>0,Y'=39,Y'=8,Y'=10,Y'=25 S Y=Y_"^PSGOE8"_$S("^109^13^3^7^26^"[("^"_Y_"^"):"",1:2) S:Y=2 FB=PSGF2_"^PSGOE81"
 Q
 ;
DEL ; delete entry
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W $C(7),"  <NOTHING DELETED>"
 Q
 ;
TIMES ;At least one admin time, not more than interval allows.
 I ($G(PSGS0XT)'="O"),($G(PSGST)'="OC"),'$$PRNOK^PSGS0(PSGSCH) I X="" D EN^DDIOL("This order requires at least one administration time.") K X Q  ;No times
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
 S Z="",INFO=$S($G(PSGNESD):PSGNESD,1:$G(PSGSD))_U_($G(PSGNEFD))_U_($G(PSGSCH))_U_($G(PSGST))_U_($G(PSGDRG))_U_($G(PSGS0Y))
 Q:$G(PSGST)="OC"!($G(PSGST)="P")
 I '$L($G(PSGP)) N PSGP S PSGP=""
 S Z=$$ENQ^PSJORP2(PSGP,INFO)  ;Expected first dose.
 Q
