PSGOE41 ;BIR/CML3-REGULAR ORDER ENTRY (CONT.) ;09 JAN 97 / 9:13 AM 
 ;;5.0;INPATIENT MEDICATIONS;**50,63,64,69,58,111,136,113,267**;16 DEC 97;Build 158
 ;
 ; Reference to ^DICN is supported by DBIA 10009.
 ; Reference to %DT is supported by DBIA 10003.
 ; Reference to %DTC is supported by DBIA 10000.
 ; Reference to ^PS(51.1 is supported by DBIA 2177.
 ;
39 ; admin times
 G:$P(PSGNEDFD,"^",3)="P"!($P(PSGNEDFD,"^",3)="OC") 8
 I $$ODD^PSGS0(PSGS0XT) G 8
 W !,"ADMIN TIMES: "_$S(PSGS0Y:PSGS0Y_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="",PSGS0Y]"" S X=PSGS0Y
 I X="",$G(PSGS0XT)="D" I $L(PSGSCH,"@")=2,$P(PSGSCH,"@",2) S (PSGAT,PSGS0Y)=$P(PSGSCH,"@",2) G 8
 I X?1."?" D ENHLP^PSGOEM(53.1,39) G 39
 I X="@" D DEL G:%'=1 39 S (PSGFOK(39),PSGS0Y)="" G 39
 S PSGF2=39 I $E(X)="^" D FF G:Y>0 @Y G 39
 I (PSGS0XT="D")&('$G(X)!(X["@"&($P($G(X),"@",2)))) I ((",P,R,")'[(","_$G(PSGST)_",")) D  G 39
 . W $C(7),"  ??" S X="?" W !,"This is a 'DAY OF THE WEEK' schedule and MUST have admin times." D ENHLP^PSGOEM(53.1,39)
 I $G(PSGS0XT)'="D",$G(PSGS0XT)'="P",$G(PSGS0XT)'="OC" D TIMES I '$D(X) G 39
 I $G(PSGS0XT)="O",X="" S (PSGAT,PSGS0Y)=X,PSGFOK(39)="" G 8
 D ENCHK^PSGS0 I '$D(X) W $C(7),"  ??" G 39
 S (PSGAT,PSGS0Y)=X,PSGFOK(39)=""
 ;
8 ; special instructions
 S PSGSI=$$EDITSI^PSJBCMA5($G(PSGP),$G(PSGORD))
 S PSGF2=8 I $E(X)="^" D FF G:Y>0 @Y G 8
 I X="@",PSGSI="" W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(53.1,8) G 8
 I X="@" D DEL G:%'=1 8 S (PSGFOK(8),PSGSI)="" G:'$G(PSGOE3) 10
 I X?1."?" D ENHLP^PSGOEM(53.1,8) G 8
 S PSGSI=$S((PSGSI>0&(PSGSI<3)):$G(^PS(53.45,+PSJSYSP,5,1,0))_" "_$G(^PS(53.45,+PSJSYSP,5,2,0)),PSGSI>2:"Instructions too long. See Order View or BCMA for full text",1:"")
 I PSGSI]"" S PSGSI=$$ENBCMA^PSJUTL("U"),PSGFOK(8)=""
 Q:$G(PSGOE3)
10 ; start date/time
 D ^PSGNE3
 S:'$D(PSGNESDO) PSGNESDO=$$ENDD^PSGMI(PSGNESD) S PSGSD=PSGNESDO
A10 W !,"START DATE/TIME: "_PSGSD_"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="",PSGNESD W "  "_PSGSD G O25
 I X="P" D ENPREV^PSGDL W:'$D(X) $C(7) G:'$D(X) A10 S PSGNESD=+X,PSGSD=$$ENDD^PSGMI(+X) W "  ",PSGSD G O25
 S PSGF2=10 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,10)
 I $E(X)="^" D FF G:Y>0 @Y G A10
 NEW TMPX S TMPX=X,X1=PSGDT,X2=-7 D C^%DTC K %DT S %DT="ERTX",%DT(0)=X,X=TMPX D ^%DT K %DT I Y'>0 D ENHLP^PSGOEM(53.1,10) G A10
 S PSGNESD=+Y,PSGSD=$$ENDD^PSGMI(+Y),(PSGNEFD,PSGFD)=""
 ;
O25 ;
 S PSGFOK(10)="" I $P(PSGNEDFD,"^",3)="O" S PSGNEFD=$$ENOSD^PSJDCU(PSJSYSW0,PSGNESD,PSGP) I PSGNEFD]"" S PSGFD=$$ENDD^PSGMI(PSGNEFD)
 ;
25 ; stop date
 Q:$G(PSGOE3)
 I 'PSGNEFD D ENFD^PSGNE3(PSGDT) S PSGFD=PSGNEFDO
A25 W !,"STOP DATE/TIME: "_$S(PSGFD]"":PSGFD_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="",PSGNEFD W "   "_PSGFD S PSGFOK(25)=""  G W25
 S PSGF2=25 I $E(X)="^" D FF G:Y>0 @Y G A25
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,25)
 I X=+X,(X>0),(X'>2000000) G A25:'$$ENDL^PSGDL(PSGSCH,X) K PSGDLS S PSGDL=X W " ...dose limit..." D EN1^PSGDL
 K %DT S %DT="ERTX",%DT(0)=PSGNESD D ^%DT K %DT G:Y'>0 A25 S PSGNEFD=+Y,PSGFD=$$ENDD^PSGMI(+Y),PSGFOK(25)=""
W25 ;
 N Z
 D DOSE I $G(Z)]"",Z>PSGNEFD D  G A25
 . W !,"There must be an admin time that falls between the Start Date/Time"
 . W !,"and the Stop Date/Time."
 I PSGNEFD<PSGDT W $C(7),!!?13,"*** WARNING! THE STOP DATE ENTERED IS IN THE PAST! ***",!
 D EFDNEW^PSJUTL  ;Display Expected First Dose;BHW;PSJ*5*136
NEXT ;
 G 1^PSGOE42
 ;
DONE ;
 I PSGOROE1 K Y W $C(7),"  ...order not entered..."
 K F,F0,F1,PSGF2,F3,PSG,SDT Q
 ;
FF ; up-arrow to another field
 D ENFF^PSGOEM I Y>0,Y'=39,Y'=8,Y'=10,Y'=25 S Y=Y_"^PSGOE4"_$S("^109^13^3^7^26^"[("^"_Y_"^"):"",1:2) S:$P(Y,U)=2 FB=PSGF2_"^PSGOE41"
 Q
 ;
DEL ; delete entry
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W $C(7),"  <NOTHING DELETED>"
 Q
TIMES    ;At least one admin time, not more than interval allows.
 I $G(PSGS0XT)'="O",X="" W !,"This order requires at least one administration time." K X Q  ;No times
 N H,I,MAX
 I PSGSCH]"" I $D(^PS(51.1,"AC","PSJ",PSGSCH)) S H=+$O(^PS(51.1,"AC","PSJ",PSGSCH,0)) S I=$P($G(^PS(51.1,H,0)),"^",3)
 I $G(PSGST)="O",$L(X,"-")>1 W !,"This is a One Time Order - only one admin time is permitted." K X Q
 I $G(PSGST)="O" Q  ;Done validating One Time
 I +$G(I)=0 Q  ;No frequency - can not check frequency related items
 S MAX=1440/I
 I MAX<1 D  Q
 . I $L(X,"-")'=1 W !,"This order requires one admin time." K X Q
 I MAX'<1,$L(X,"-")>MAX W !,"The number of admin times entered is greater than indicated by the schedule." K X Q  ;Too many times
 I MAX'<1,$L(X,"-")<MAX W !,"The number of admin times entered is fewer than indicated by the schedule."  ;Too few times
 Q
DOSE ;Make certain at least one dose is given.
 Q:$G(PSGST)="OC"!($G(PSGST)="P")
 N INFO,X
 S Z="",INFO=($G(PSGNESD))_U_($G(PSGNEFD))_U_($G(PSGSCH))_U_($G(PSGST))_U_($G(PSGDRG))_U_($G(PSGS0Y))
 I '$L($G(PSGP)) N PSGP S PSGP=""
 S Z=$$ENQ^PSJORP2(PSGP,INFO)  ;Expected first dose.
 Q
