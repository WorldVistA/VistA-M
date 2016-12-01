PSGOE91 ;BIR/CML3-ACTIVE ORDER EDIT (CONT.) ; 8/4/10 7:07am
 ;;5.0;INPATIENT MEDICATIONS;**50,64,58,110,111,136,113,179,265,267,285,315**;16 DEC 97;Build 73
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^PS(50.7 is supported by DBIA# 2180
 ; Reference to ^PS(51.1 is supported by DBIA 2177.
 ;
41 ; admin times
 ;S MSG=0,PSGF2=41,ORIG=$G(PSGAT) S:PSGOEEF(PSGF2) BACK="41^PSGOE91"
 ;*315 next 5 lines
 N PSGDOA
 S MSG=0,PSGF2=41,ORIG=$G(PSGAT),PSGDOA=$G(PSGDUR) S:PSGOEEF(PSGF2) BACK="41^PSGOE91"
 I (PSGST="P")!$$PRNOK^PSGS0($G(PSGSCH)) G DONE
 I $$ODD^PSGS0(PSGS0XT) D PSGDUR G DONE
A41 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"ADMIN TIMES may not be edited for active complex orders." D PAUSE^VALM1
 W !,"ADMIN TIMES: "_$S(PSGAT:PSGAT_"// ",1:"") R X:DTIME I X="^"!('$T) W:'$T $C(7) S PSGOEE=0 S:X="^" (X,PSGAT)=$G(ORIG),PSGDUR="" G DONE
 I X="" S:$G(PSGAT) X=PSGAT,PSGNOHI=1 ;*315 If admin time default was taken then don't highlight admin time.
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A41
 I X="@" I (PSGS0XT="D")!(PSGSCH["@") I ((",P,R,OC,O,")'[(","_$G(PSGST)_",")) D  G A41
 .W $C(7),"  ??" S X="?" W:PSGS0XT="D"!(PSGSCH["@") !,"This is a 'DAY OF THE WEEK' schedule and MUST have admin times." D ENHLP^PSGOEM(55.06,41)
 I X="@" D DEL G:%'=1 A41 S PSGAT="",X=""
 I ((PSGST="O")!($G(PSGST)="OC")!($G(PSGST)="P")!$$ODD^PSGS0($P($G(ZZND),"^",3))!($P($G(ZZND),"^",5)="O")),X="" D  G DONE
 . S (PSGS0Y,PSGAT)=X
 . I (($G(PSGRF))&($G(PSGST)="O")) N PSGRO S PSGOEEF(34)=1,PSGOEEF(41)=1,PSGRO=1 D 34
 .Q
 I $G(PSGS0XT) I '$$ODD^PSGS0(PSGS0XT),$G(PSGST)'="P",$G(PSGST)'="OC",'$$PRNOK^PSGS0(PSGSCH) I ($G(PSGST)'="O") D TIMES G:'$D(X) A41 D PSGDUR G:'$D(X) A41 G:$G(X)="^" DONE ;*315
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
 I $E(X)=U D ENFF^PSGOE92 G:Y>0 @Y G A8
 S PSGSI=$$EDITSI^PSJBCMA5($G(PSGP),$G(PSGORD)) I $G(PSGP),$G(PSGORD) I '$$DIFFSI^PSJBCMA5(PSGP,PSGORD) S PSGOEE=0 G DONE
 S PSGSI=$S((PSGSI>0&(PSGSI<4)):$G(^PS(53.45,+PSJSYSP,5,1,0))_" "_$G(^PS(53.45,+PSJSYSP,5,2,0)),PSGSI>3:"Instructions too long. See Order View or BCMA for full text.",1:"")
 S:PSGSI=" " PSGSI="" I PSGSI]"" S PSGSI=$$ENBCMA^PSJUTL("U") G DONE
 Q
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
 N MSG,PSGTMPST S PSGTMPST=$G(PSGST) S:'+$G(PSGRF) PSGRF=$P($G(^PS(50.7,$G(PSGPDRG),4),0),U,1) ;*315 One time orders for MRR's require message to instruct pharmacists
 I +$G(PSGRF),$D(^PS(51.1,"AC","PSJ",$G(PSGSCH))) D
 . S:PSGTMPST=($G(PSGST)="R") PSGST=$P($G(^PS(51.1,$O(^PS(51.1,"AC","PSJ",$G(PSGSCH),"")),0)),"^",5) ;Handle "Fill on Request"
 .Q
 I $G(PSGTMPST)="O",+$G(PSGRF) S (PSGFDN,PSGFD)="" D 
 . I +$G(PSGRF)=1 S MSG(1)="This NOW order has an Orderable Item for which a removal is required" D
 .. S MSG(2)=" at the next administration."
 .. S MSG(3)="The Stop DATE/TIME entered should be the next anticipated administration for the medication.",MSG(3,"F")="!"
 ..Q
 . I +$G(PSGRF)=2 S MSG(1)="This NOW order has an Orderable Item for which a removal period is optional",MSG(1,"F")="!!" D
 .. S MSG(2)="prior to the next administration.",MSG(2,"F")="!"
 .. S MSG(3)="If Early Removal is needed, enter Removal Time in Stop DATE/TIME field.",MSG(3,"F")="!"
 .. S MSG(4)="If an Early Removal is not required, the Stop DATE/TIME entered"
 .. S MSG(5)="should be the next anticipated administration for the medication.",MSG(5,"F")="!"
 ..Q
 . I +$G(PSGRF)=3 S MSG(1)="This NOW order has an Orderable Item that requires a removal period prior",MSG(1,"F")="!!" D
 .. S MSG(2)=" to the next administration.",MSG(2,"F")="!"
 .. S MSG(3)="Please Enter the Stop DATE/TIME to reflect the Removal Time for this medication.",MSG(3,"F")="!"
 ..Q
 . D EN^DDIOL(.MSG)
 .Q
 W !,"STOP DATE/TIME: "_$S($P(PSGFDN,"^")]"":$P(PSGFDN,"^")_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGFD W "   "_$P(PSGFDN,"^") G W34
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A34
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(55.06,34)
 I X=+X,(X>0),(X'>2000000) G A34:'$$ENDL^PSGDL(PSGSCH,X) K PSGDLS S PSGDL=X W " ...dose limit..." D ENE^PSGDL
 K %DT S %DT="ERTX",%DT(0)=PSGSD D ^%DT K %DT I Y'>0 W $C(7),!!?13,"*** WARNING! INVALID STOP DATE OR PRIOR TO START DATE! ***",! G A34
 S (PSGFDX,PSGFD)=+Y,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)
W34 ;Compare to Start Date
 N Z,MSG
 D DOSE I $G(Z)]"",Z>$S($G(PSGFD):PSGFD,1:$G(PSGNEFD)) D  G A34
 . S MSG(1)="There is no administration time that falls between the Start Date/Time"
 . S MSG(2)="and the Stop Date/Time."
 . D EN^DDIOL(.MSG)
 I PSGFD<PSGDT W $C(7),!!?13,"*** WARNING! THE STOP DATE ENTERED IS IN THE PAST! ***",! S MSG=1
 Q:+$G(PSGRO)
 ;
DONE ;
 ;Display Expected First Dose;BHW;PSJ*5*136
 ;BHW;PSJ*5*179; - Remove EFD call.  Added to PSGOEE.
 I PSGOEE G:'PSGOEEF(PSGF2) @BACK S PSGOEE=PSGOEEF(PSGF2)
 D:+$G(PSGDUR) VERTIMES ;*315
 S:'+$G(PSGRF) PSGRF=$P($G(^PS(50.7,$G(PSGPDRG),4),0),U,1)
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
 ;*315 New tags
PSGDUR ; Prompt for Removal times if admin times are on 24hr rotations and Site Params are enabled.
 ; check parameter files for removal criteria quit if removal rotation not enabled (<2)
 ; if enabled determine type (hard vers soft stop)
 ;0 = no removal (current cap/tab functionality)
 ;1 = removal at next admin (current patch functionality)
 ;2 = removal prior to next admin; soft stop (pharmacist optional prompt to designate duration of administration
 ;3 = removal prior to next admin; hard stop (pharmacist required prompt to designate duration of administration)
 ; prompt for removal if = 2 then allow skip, if = 3 then force entry
 ;
 S PSGRF=$P($G(^PS(50.7,$G(PSGPDRG),4),0),U,1) Q:((PSGRF<2)!($G(PSGST)="O")!($G(PSGST)="P")!($G(PSGST)="OC"))  ; no removal flag or no removal rotation
 Q:$G(PSGS0XT)>1440  ; Duration of Administration valid only for 24 hours - subject to change in future.
 N RP,PSGIDF,WMSG,PSGDERR S (PSGIDF,PSGDERR)=0 S:$G(PSGDUR)>0 RP=(PSGDUR/60) S:"BID,TID,QID"[$G(PSGSCH) PSGIDF=1  ; Use separate validation for Times per day type orders
 S PSGF2=41
 W !,"DURATION OF ADMINISTRATION (HRS): "_$S($G(RP):RP_"// ",1:"") R RP:DTIME I RP="^"!'$T W:'$T $C(7) S PSGDUR=$G(PSGDOA),X="^",PSGOEE=0 Q
 I RP="" S:$G(PSGDUR)>0 RP=($G(PSGDUR)/60)
 I RP="",$G(PSGS0XT)="D",$L(PSGSCH,"@")=2,$P(PSGSCH,"@",2) S (PSGAT,PSGRMVT)=$P(PSGSCH,"@",2) G 8
 I RP="@",PSGRF'=3 D DEL G:%'=1 PSGDUR S PSGS0Y="",(PSGDUR,PSGRMVT)="@",PSGRMV=-1 Q
 S:(RP'="")&(RP'="@")&(+(RP)<1)&(($E(RP,1))'="?")&(RP'?1N.2N) RP="?" I RP?1."?" D DURHLP^PSGOEM(RP,PSGRF) G PSGDUR
 I $E(RP)="^" D FF G:Y>0 @Y G PSGDUR
 I (+RP>0),'PSGIDF D  ; exclude BID,TID or QID schedules
 . S PSGDUR=(RP*60),PSGRMV=$G(PSGS0XT)-PSGDUR
 . I PSGRMV<1 W !,"DURATION OF ADMINISTRATION MATCHES OR EXCEEDS ORDER FREQUENCY" S RP="",PSGDERR=1 K PSGDUR,PSGRMV G PSGDUR Q
 .Q
 Q:$G(PSGDERR)=1
 I PSGRF=3,(+RP<1) W $C(7),!,"ENTRY IS REQUIRED" S RP="" G PSGDUR
 I PSGRF=2,(+RP<1) D
 . W !,"You have not entered Duration of Administration for this medication order, "
 . W !,"therefore the BCMA user will not be prompted to remove the medication prior "
 . W !,"to the next Admin Time."
 . S PSGRMV=-1,RP=0
 .Q
 I PSGIDF,(+RP>0) D  ;Only for TPD schedules
 . N F,P,PSGARR
 . S PSGADT=$S($G(PSGDUR)=-1:X,$G(PSGS0Y):PSGS0Y,$G(PSGAT):PSGAT,1:""),PSGS0Y=PSGADT
 . S PSGARR=$L($G(PSGADT),"-")
 . F P=1:1:PSGARR D
 .. S PSGARR(P)=($P(PSGADT,"-",P)/100) S:(P>1) F(P)=PSGARR(P)-PSGARR(P-1)
 .. I $G(F(P)),($G(F(P))'=RP) S WMSG=1_U_"Duration of Administration does not correspond to one or more",WMSG(1)="of this order's scheduled Administration Times!"
 ..Q
 .Q
 S:(+RP>0) PSGDUR=(RP*60)
 W:(+RP>0) ?60,RP," HOURS"
 D:$G(WMSG) EN^DDIOL($P(WMSG,U,2)),EN^DDIOL(WMSG(1))
 Q
 ;
VERTIMES ; Redisplay Admin and Removal times *315
 S PSGRF=$P($G(^PS(50.7,$G(PSGPDRG),4),0),U,1) Q:(PSGRF<2)!($G(PSGST)="O")
 N PSGADT,PSGRARR,PSGAARR
 ;If we have a frequency and this is odd type order then we need to start calculations with order start time.
 I $G(PSGS0XT),$G(PSGNESD),+$G(PSGDUR),$G(PSGAT)="" D  Q
 . N L
 . S (PSGAARR,PSGRARR)=1,PSGADT=$P($P(PSGNESD,U,1),".",2),L=$L(PSGADT)
 . S PSGRARR(1)=(((((PSGADT*60)+PSGDUR)/60)#24)*100) S:PSGRARR(1)=0 PSGRARR(1)=2400 S:$L(PSGRARR(1))=3 PSGRARR(1)="0"_PSGRARR(1)
 . S PSGRARR(1)=$E(PSGRARR(1),1,L)_"(R)"
 . S PSGAARR(1)=PSGADT,PSGAARR(1)=$E(PSGAARR(1),1,L)_"(A)"
  . D WRITE
 .Q
 ;
 S (PSGRARR,PSGAARR)=$S($G(PSGAT):$L(PSGAT,"-"),1:$L(PSGS0Y,"-"))
 N P,L
 F P=1:1:PSGRARR D
 . S PSGADT=$S($G(PSGAT):$P(PSGAT,"-",P),1:$P(PSGS0Y,"-",P)),L=$L(PSGADT)
 . S PSGADT=$S($L(PSGADT)=4:PSGADT/100,1:PSGADT*1)
 . S PSGRARR(P)=(((((PSGADT*60)+PSGDUR)/60)#24)*100) S:PSGRARR(P)=0 PSGRARR(P)=2400 S:$L(PSGRARR(P))=3 PSGRARR(P)="0"_PSGRARR(P)
 . S PSGRARR(P)=$E(PSGRARR(P),1,L)_"(R)"
 . S PSGAARR(P)=(PSGADT*100) S:$L(PSGAARR(P))=3 PSGAARR(P)="0"_PSGAARR(P)
 . S PSGAARR(P)=$E(PSGAARR(P),1,L)_"(A)"
 .Q
 D WRITE
 Q
 ;
WRITE ;
 W !!,"Verify Admin and removal times",!
 W !,"(A)DMINISTRATION -(R)EMOVAL TIMES"
 W !,"___________________________________________________________________________",!
 F P=1:1:PSGAARR W PSGAARR(P)_"-"_PSGRARR(P)  W:P'=PSGAARR " , "
 D ASK
 Q
 ;
ASK ;
 N Y
 S DIR("A")="Is this correct",DIR(0)="Y" D ^DIR I $D(DUOUT)!$D(DTOUT) W:'$T $C(7) S PSGOEE=0 K PSGDUR G DONE
 I 'Y K X S PSGDUR=-1,PSGFOK(8)="" G A41
 N P S P=1,PSGRMVT=$P(PSGRARR(P),"(",1)
 F  S P=$O(PSGRARR(P)) Q:P=""  D
 . S PSGRMVT=PSGRMVT_"-"_$P(PSGRARR(P),"(",1)
 .Q
 Q
 ;
