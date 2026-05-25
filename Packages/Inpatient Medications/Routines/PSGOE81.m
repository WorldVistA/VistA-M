PSGOE81 ;BIR/CML - NON-VERIFIED ORDER EDIT (CONT.) ;May 03, 2023@17:45
 ;;5.0;INPATIENT MEDICATIONS;**26,50,64,58,82,110,111,136,113,267,315,334,373,366,327,441,451,454,455**;16 DEC 97;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;Reference to ^PS(50.7 in ICR #2180
 ;Reference to ^PS(51.1 in ICR #2177
 ;
39 ; admin times
 N PSGDOA
 S MSG=0,PSGF2=39 S:PSGOEEF(PSGF2) BACK="39^PSGOE81",ORIG=$G(PSGAT),PSGDOA=$G(PSGDUR)
A39 ;*315 next 2 lines
 I (PSGST="P")!$$PRNOK^PSGS0($G(PSGSCH)) G DONE
 I $$ODD^PSGS0(PSGS0XT) D PSGDUR G DONE
 W !,"ADMIN TIMES: "_$S(PSGAT:PSGAT_"// ",1:"") R X:DTIME I X="^"!('$T) W:'$T $C(7) S PSGOEE=0 S:X="^" (X,PSGAT)=$G(ORIG),PSGDUR="" G DONE ;*315
 I X="" S:(($G(PSGS0XT)="D")&'$G(PSGS0Y)) PSGOEE=0 S:$G(PSGAT) X=PSGAT,PSGNOHI=1 ;*315 If admin time default was taken then don't highlight admin time.
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A39
 I X=" "!(X?1."?") D ENHLP^PSGOEM(53.1,39) G A39
 I PSGS0XT="D"&'$G(X) I ((",P,R,")'[(","_$G(PSGST)_",")) D  G A39
 .W $C(7),"  ??" S X="?" W !,"This is a 'DAY OF THE WEEK' schedule and MUST have admin times." D ENHLP^PSGOEM(53.1,39)
 I X="@" D DEL G:%'=1 A39 S PSGAT="",X=""
 I $G(PSGS0XT),'$$ODD^PSGS0(PSGS0XT),$G(PSGS0XT)'="P",$G(PSGS0XT)'="OC",'$$PRNOK^PSGS0(PSGSCH),($G(PSGST)'="O") D TIMES G:'$D(X) A39 D PSGDUR G:'$D(X) A39 G:$G(X)="^" DONE ;*315
 I (($G(PSGST)="O")!($G(PSGST)="OC")),X="" D  G DONE
 .S (PSGS0Y,PSGAT)=X
 .I (($G(PSGRF))&($G(PSGST)="O")) N PSGRO S (PSGRO,PSGOEEF(25))=1,PSGOEEF(39)=1 D 25
 .Q
 D ENCHK^PSGS0 I '$D(X) W $C(7) G A39
 S PSGOAT=PSGAT
 S (PSGS0Y,PSGAT)=X G DONE
 ;
8 ; special instructions
 S MSG=0,PSGF2=8 S:PSGOEEF(PSGF2) BACK="8^PSGOE81"
A8 ; special instructions
 S PSGSI=$$EDITSI^PSJBCMA5($G(PSGP),$G(PSGORD)) I $G(PSGP),$G(PSGORD) I '$$DIFFSI^PSJBCMA5(PSGP,PSGORD) S PSGOEE=0 G DONE
 S PSGSI=$S((PSGSI>0&(PSGSI<4)):$G(^PS(53.45,+PSJSYSP,5,1,0))_" "_$G(^PS(53.45,+PSJSYSP,5,2,0)),PSGSI>3:"Instructions too long. See Order View or BCMA for full text",1:"")
 S:PSGSI=" " PSGSI="" I PSGSI]"" S PSGSI=$$ENBCMA^PSJUTL("U") G DONE
 Q
 ;
10 ; start date/time edit
 S MSG=0,PSGF2=10 S:PSGOEEF(PSGF2) BACK="10^PSGOE81"
A10 ; start date/time edit
 S PSGSDEDT=1 ; This variable indicates a Manual Edit of the Start/Date Time.
 K PSGSDX N DUR,DURMIN,TMPFD
 I $G(PSGORD)["P",$G(PSGP) I $$LASTREN^PSJLMPRI(PSGP,PSGORD) D  Q
 .W !?5,"Start Date may not be edited at this point. " D PAUSE^VALM1
 W !,"START DATE/TIME: "_$S($P(PSGSDN,"^")]"":$P(PSGSDN,"^")_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGSD W "  "_$P(PSGSDN,"^") G DONE
 I X="P" D ENPREV^PSGDL W:'$D(X) $C(7) G:'$D(X) A10 D  G DONE
 .S PSGSD=+X,PSGSDN=$$ENDD^PSGMI(PSGSD)_"^"_$$ENDTC^PSGMI(PSGSD)
 .W "  ",$P(PSGSDN,"^")
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,10)
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A10
 NEW TMPX S TMPX=X,X1=+$G(PSGLI),X2=-7 D C^%DTC K %DT S %DT="ERTX",%DT(0)=X,X=TMPX
 D ^%DT K %DT I Y'>0 D ENHLP^PSGOEM(53.1,10) G A10
 I PSGFD<Y D  G A10
 .W $C(7),!?5,"*** THE START DATE CANNOT BE AFTER THE STOP DATE! ***",! S MSG=1
 ; RBD PSJ*5*373 Soft stop when Start Date more than 7 days after Order's LOGIN DATE
 S X1=+$G(PSGLI),X2=+7 D C^%DTC
 I +Y>X W !!,$C(7),"Start date/time should not be entered for more than 7 days after the",!,"order's LOGIN DATE.",! K DIR D WAIT^VALM1
 N X1,X2,DIFF,PSGEMRG,PSGBACK,CLOZFLG S X1=PSGFD,X2=Y D ^%DTC S DIFF=X
 I $G(PSGORD) S CLOZFLG=$$ISCLOZ^PSJCLOZ(+PSGORD) I 1
 E  S CLOZFLG=$$ISCLOZ^PSJCLOZ(,,,,PSGDRG)
 ;S PSGEMRG=$S($$GET1^DIQ(55,DFN,53)?2U5N:1,1:0),PSGBACK=0
 S PSGEMRG=0,PSGBACK=0
 I ($$GET1^DIQ(55,DFN,53)?2U5N),($P($G(^XTMP("PSJ4D-"_DFN,0)),"^",1))>$$HTFM^XLFDT($H,1) S PSGEMRG=1
 I PSGEMRG,$G(CLOZFLG),DIFF>4 D  G A10   ; Emergency Registration period not to exceed 4 days
 .W !!?13,"*** EMERGENCY SUPPLY NOT TO EXCEED 4 DAYS! ***",!
 I 'PSGEMRG,$G(CLOZFLG) D  G:PSGBACK A10
 .N CLOZPAT,X2 D CLOZPAT^PSJCLOZ
 .S X2=$S($P($G(ANQDATA),"^",3)=9:4,$G(CLOZPAT)=2:28,$G(CLOZPAT)=1:14,$G(CLOZPAT)=0:7,1:90)
 .I DIFF>X2 W !!,"*** SUPPLY PERIOD NOT TO EXCEED "_X2_" DAYS! ***",! S PSGBACK=1
 ;S (PSGSDX,PSGSD,PSGNESD)=+Y,PSGSDN=$$ENDD^PSGMI(PSGSD)_"^"_$$ENDTC^PSGMI(PSGSD)  ;373
 S (PSGSDX,PSGSD,PSGNESD)=+Y,PSGSDN=$$ENDD^PSGMI(PSGSD)_"^"_$$ENDTC2^PSGMI(PSGSD)  ;373
 I $G(PSGORD)["P",$G(PSGP) S DUR=$$GETDUR^PSJLIVMD(PSGP,+PSGORD,"P",1) I DUR]"" S DURMIN=$$DURMIN^PSJLIVMD(DUR) I DURMIN D
 . ;S TMPFD=$$FMADD^XLFDT(PSGSD,,,DURMIN) K:(TMPFD<PSGSD) TMPFD I $G(TMPFD) S PSGFD=TMPFD,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)  ;373
 . S TMPFD=$$FMADD^XLFDT(PSGSD,,,DURMIN) K:(TMPFD<PSGSD) TMPFD I $G(TMPFD) S PSGFD=TMPFD,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC2^PSGMI(PSGFD)  ;373
 G DONE
 ;
25 ; stop date
 S MSG=0,PSGF2=25 S:PSGOEEF(PSGF2) BACK="25^PSGOE81"
A25 ;
 ;; START NCC REMEDIATION RJS*327
 N CLOZFLG,CLOZPAT
 I $G(PSGORD) S CLOZFLG=$$ISCLOZ^PSJCLOZ(+PSGORD) I 1
 E  S CLOZFLG=$$ISCLOZ^PSJCLOZ(,,,,PSGDRG)
 I $G(CLOZFLG) N CLOZPAT,PSGDRG S PSGDRG=$P(CLOZFLG,U,2) D CLOZPAT^PSJCLOZ
 I $G(CLOZFLG) N PSGOLDED,PSGFDNOLD S PSGOLDED=PSGFD,PSGFDNOLD=PSGFDN
 ;; END NCC REMEDIATION RJS*327
 N MSG,PSGTMPST S PSGTMPST=$G(PSGST) S:'+$G(PSGRF) PSGRF=+$$GET1^DIQ(50.7,$G(PSGPDRG),12,"I") ;*315 One time orders for MRR's require message to instruct pharmacists
 I $$FIND1^DIC(51.1,,"X",$G(PSGSCH)) D
 . S:PSGTMPST=($G(PSGST)="R") PSGST=$$GET1^DIQ(51.1,$$FIND1^DIC(51.1,,"X",$G(PSGSCH)),5,"I") ;Handle "Fill on Request"
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
 K PSGFDX N PSGEMRG
 I $D(PSGFDORG) S PSGFDN=PSGFDORG,PSGFD=PSGFDORX
 I '$D(PSGFDORG) N PSGFDORG,PSGFDORX S PSGFDORG=PSGFDN,PSGFDORX=PSGFD
 W !,"STOP DATE/TIME: "_$S($P(PSGFDN,"^")]"":$P(PSGFDN,"^")_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGFD S X=$P(PSGFDN,"^")
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A25
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,25)
 I X=+X,(X>0),(X'>2000000) G A25:'$$ENDL^PSGDL(PSGSCH,X) K PSGDLS S PSGDL=X W " ...dose limit..." D ENE^PSGDL
 K %DT S %DT="ERTX",%DT(0)=PSGSD D ^%DT K %DT I Y'>0 W $C(7),!!?13,"*** WARNING! INVALID STOP DATE OR PRIOR TO START DATE! ***",! G A25
 ; RBD PSJ*5*373 Hard stop when Stop Date more than 367 days after Start Date
 S X1=+Y,X2=PSGSD D ^%DTC
 I X>367 W $C(7),!!?13,"*** STOP DATE cannot be more than 367 days from START DATE ***",! G A25
 ;S (PSGFDX,PSGFD,PSGNEFD)=+Y,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)  ;373
 S (PSGFDX,PSGFD,PSGNEFD)=+Y,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC2^PSGMI(PSGFD)  ;373
 ;/RJS Begin changes for emergency registration of clozapine patient Set end date to start date + 4 days at midnight.
 N PSGGTF S PSGGTF=0
 I ($$GET1^DIQ(55,DFN,53)?1U6N)!($$GET1^DIQ(55,DFN,53)?2U5N),$G(CLOZFLG) D  G:PSGGTF A25  ;def 418867 RJS*327
 .I $P($G(^XTMP("PSJ4D-"_DFN,0)),"^",1)>$$HTFM^XLFDT($H,1) D
 ..N X1,X2 S X1=+Y,X2=PSGSD D ^%DTC
 ..S PSGEMRG=1 Q:X'>4
 ..I X>4 D
 ...W !!?13,"*** EMERGENCY SUPPLY NOT TO EXCEED 4 DAYS! ***",!
 ...S $P(PSGFD,".",2)=2359,X1=PSGSD,X2=4 D C^%DTC S PSGFD=X
 ...S $P(PSGFDN,"^",1)=$$ENDD^PSGMI(PSGFD),$P(PSGFDN,"^",2)=PSGFD
 ...S PSGGTF=1
 ;/RJS End changes for emergency registration of clozapine patient Set end date to start date + 4 days at midnight.
 ;/RJS Begin verify that stop date does not exceed maximum days supply based on lab frequency
A255 I '$G(PSGEMRG),$G(CLOZFLG) N PSGBACK D  G:$G(PSGBACK) A25
 .N PSGCFLG S PSGCFLG=1
 .N X,X1,X2
 .S X2=$S($P($G(ANQDATA),"^",3)=9:4,$G(CLOZPAT)=2:28,$G(CLOZPAT)=1:14,$G(CLOZPAT)=0:7,1:90)
 .S X1=+Y D
 ..N X2 S X2=PSGSD D ^%DTC S X1=PSGSD
 .I X>X2 W !!,"*** STOP DATE/TIME NOT TO EXCEED "_X2_" DAYS! ***",! S PSGBACK=1 Q
 K:($G(PSGEMRG)) PSGEMRG
 ;/RJS End verify that stop date does not exceed maximum days supply based on lab frequency.
 ;; END NCC REMEDIATION RJS*327
 S (PSGFDX,PSGFD,PSGNEFD)=+Y,PSGFDN=$$ENDD^PSGMI(PSGFD)_"^"_$$ENDTC^PSGMI(PSGFD)
W25 ;
 N Z,MSG
 D DOSE I $G(Z)]"",Z>PSGNEFD D  G A25
 . S MSG(1)="There is no administration time that falls between the Start Date/Time"
 . S MSG(2)="and the Stop Date/Time."
 . D EN^DDIOL(.MSG)
 I PSGFD<PSGDT W $C(7),!!?13,"*** WARNING! THE STOP DATE ENTERED IS IN THE PAST! ***",! S MSG=1
 Q:+$G(PSGRO)
 ;
DONE ;
 ;Display Expected First Dose;BHW;PSJ*5*136
 D EFDNV^PSJUTL
 I PSGOEE G:'$G(PSGOEEF(PSGF2)) @BACK S PSGOEE=PSGOEEF(PSGF2)     ;P451
 D:+$G(PSGDUR) VERTIMES ;*315
 K ORIG,PSGOLDED,PSGNEFDOLD,PSGFDNOLD
 S:'+$G(PSGRF) PSGRF=+$$GET1^DIQ(50.7,$G(PSGPDRG),12,"I")
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
 ;P454 messages to the user
 I $D(X) D  Q:'$G(X)
 . I (X'["-") D
 . . I (X'?2N),(X'?4N) W !,"ADMIN TIMES must be entered in a 2 or 4 digit numeric format" K X Q
 . E  D
 . . N LEN,TOT,CHK S LEN=$L($P(X,"-"))
 . . F TOT=1:1:$L(X,"-") S CHK=$P(X,"-",TOT) Q:CHK=""  I ((CHK'?2N)&(CHK'?4N))!(LEN'=$L(CHK)) W !,"All ADMIN TIMES must be the same 2 or 4 digit numeric format" W !,"(i.e. 09-13 or 0900-1300)" K X Q
 S MAX=1440/I
 I MAX<1,$L(X,"-")>1 D EN^DDIOL("This order requires one administration time.") K X Q
 I MAX'<1,$L(X,"-")>MAX D EN^DDIOL("The number of admin times entered is greater than indicated by the schedule.") K X Q  ;Too many times
 I MAX'<1,$L(X,"-")<MAX D EN^DDIOL("The number of admin times entered is fewer than indicated by the schedule.") Q  ;Too few times ;P455 remove K
 Q
 ;
DOSE ;Make certain at least one dose is given.
 N INFO,X
 S Z="",INFO=$S($G(PSGNESD):PSGNESD,1:$G(PSGSD))_U_($G(PSGNEFD))_U_($G(PSGSCH))_U_($G(PSGST))_U_($G(PSGDRG))_U_($G(PSGS0Y))
 Q:$G(PSGST)="OC"!($G(PSGST)="P")
 I '$L($G(PSGP)) N PSGP S PSGP=""
 S Z=$$ENQ^PSJORP2(PSGP,INFO)  ;Expected first dose.
 Q
 ;
 ;*315 new tags
PSGDUR ; Prompt for Removal times if admin times are on 24hr rotations and Site Params are enabled.
 ; check parameter files for removal criteria quit if removal rotation not enabled (<2)
 ; if enabled determine type (hard vers soft stop)
 ;0 = no removal (current cap/tab functionality)
 ;1 = removal at next admin (current patch functionality)
 ;2 = removal prior to next admin; soft stop (pharmacist optional prompt to designate duration of administration
 ;3 = removal prior to next admin; hard stop (pharmacist required prompt to designate duration of administration)
 ; prompt for removal if = 2 then allow skip, if = 3 then force entry
 ;
 S PSGRF=+$$GET1^DIQ(50.7,$G(PSGPDRG),12,"I") Q:((PSGRF<2)!($G(PSGST)="O")!($G(PSGST)="P")!($G(PSGST)="OC"))  ; no removal flag or no removal rotation
 Q:$G(PSGS0XT)>1440  ; Duration of Administration valid only for 24 hours - subject to change in future.
 N RP,PSGIDF,WMSG,PSGDERR S (PSGIDF,PSGDERR)=0 S:$G(PSGDUR)>0 RP=(PSGDUR/60) S:"BID,TID,QID"[$G(PSGSCH) PSGIDF=1  ; Use separate validation for Times per day type orders
 S PSGF2=39
 W !,"DURATION OF ADMINISTRATION (HRS): "_$S($G(RP):RP_"// ",1:"") R RP:DTIME I RP="^"!'$T W:'$T $C(7) S PSGDUR=$G(PSGDOA),X="^",PSGOEE=0 Q
 I RP="" S:$G(PSGDUR)>0 RP=($G(PSGDUR)/60)
 I RP="",$G(PSGS0XT)="D",$L(PSGSCH,"@")=2,$P(PSGSCH,"@",2) S (PSGAT,PSGRMVT)=$P(PSGSCH,"@",2) G 8
 I RP="@",PSGRF'=3 D DEL G:%'=1 PSGDUR S (PSGS0Y,PSGDUR,PSGRMVT)="",PSGRMV=-1 S:+$$GET1^DIQ(53.1,+$G(PSGORD),137) (PSGDUR,PSGRMV,PSGRMVT)="@" Q
 I (RP'=""),(RP'="@"),($E(RP)'="^"),($E(RP)'="?") S:(RP'?1N.2N)!(+(RP)<1) RP="?"
 I RP?1."?" D DURHLP^PSGOEM(RP,PSGRF) G PSGDUR
 I $E(RP)="^" D FF G:Y>0 @Y G PSGDUR
 I (+RP>0),'PSGIDF D  I PSGRMV<1 K PSGMRV G PSGDUR ; exclude BID,TID or QID schedules
 .S PSGDUR=(RP*60),PSGRMV=$G(PSGS0XT)-PSGDUR
 .I PSGRMV<1 W !,"DURATION OF ADMINISTRATION MATCHES OR EXCEEDS ORDER FREQUENCY" S RP="",PSGDERR=1 K PSGDUR ;,PSGRMV G PSGDUR
 .Q
 Q:$G(PSGDERR)=1
 I PSGRF=3,(+RP<1) W $C(7),!,"ENTRY IS REQUIRED" S RP="" G PSGDUR
 I PSGRF=2,(+RP<1) D
 .W !,"You have not entered Duration of Administration for this medication order, "
 .W !,"therefore the BCMA user will not be prompted to remove the medication prior "
 .W !,"to the next Admin Time."
 .S PSGRMV=-1,RP=0
 .Q
 I PSGIDF,(+RP>0) D  ;Only for TPD schedules
 .N F,P,PSGARR
 .S PSGADT=$S($G(PSGDUR)=-1:X,$G(PSGAT):PSGAT,$G(PSGS0Y):PSGS0Y,1:""),PSGS0Y=PSGADT
 .S PSGARR=$L($G(PSGADT),"-")
 .F P=1:1:PSGARR D
 ..S PSGARR(P)=($P(PSGADT,"-",P)/100) S:(P>1) F(P)=PSGARR(P)-PSGARR(P-1)
 ..I $G(F(P)),($G(F(P))'=RP) S WMSG=1_U_"Duration of Administration does not correspond to one or more",WMSG(1)="of this order's scheduled Administration Times!"
 ..Q
 .Q
 S:(+RP>0) PSGDUR=(RP*60)
 W:(+RP>0) ?60,RP," HOURS"
 D:$G(WMSG) EN^DDIOL($P(WMSG,U,2)),EN^DDIOL(WMSG(1))
 Q
 ;
VERTIMES ; Redisplay Admin and Removal times
 S PSGRF=+$$GET1^DIQ(50.7,$G(PSGPDRG),12,"I") Q:(PSGRF<2)!($G(PSGST)="O")
 N PSGADT,PSGRARR,PSGAARR
 ;If we have a frequency and this is odd type order then we need to start calculations with order start time.
 I $G(PSGS0XT),$G(PSGNESD),+$G(PSGDUR),$G(PSGAT)="" D  Q
 .N L
 .S (PSGAARR,PSGRARR)=1,PSGADT=$P($P(PSGNESD,U,1),".",2),L=$L(PSGADT)
 .S PSGRARR(1)=(((((PSGADT*60)+PSGDUR)/60)#24)*100) S:PSGRARR(1)=0 PSGRARR(1)=2400 S:$L(PSGRARR(1))=3 PSGRARR(1)="0"_PSGRARR(1)
 .S PSGRARR(1)=$E(PSGRARR(1),1,L)_"(R)"
 .S PSGAARR(1)=PSGADT,PSGAARR(1)=$E(PSGAARR(1),1,L)_"(A)"
 .D WRITE
 .Q
 ;
 S (PSGRARR,PSGAARR)=$S($G(PSGAT):$L(PSGAT,"-"),1:$L(PSGS0Y,"-"))
 N P,L
 F P=1:1:PSGRARR D
 .S PSGADT=$S($G(PSGAT):$P(PSGAT,"-",P),1:$P(PSGS0Y,"-",P)),L=$L(PSGADT)
 .S PSGADT=$S($L(PSGADT)=4:PSGADT/100,1:PSGADT*1)
 .S PSGRARR(P)=(((((PSGADT*60)+PSGDUR)/60)#24)*100) S:PSGRARR(P)=0 PSGRARR(P)=2400 S:$L(PSGRARR(P))=3 PSGRARR(P)="0"_PSGRARR(P)
 .S PSGRARR(P)=$E(PSGRARR(P),1,L)_"(R)"
 .S PSGAARR(P)=(PSGADT*100) S:$L(PSGAARR(P))=3 PSGAARR(P)="0"_PSGAARR(P)
 .S PSGAARR(P)=$E(PSGAARR(P),1,L)_"(A)"
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
 ;PSJ*5.0*441: Add DIR to N string.
 N Y,DIR
 S DIR("A")="Is this correct",DIR(0)="Y" D ^DIR I $D(DUOUT)!$D(DTOUT) W:'$T $C(7) S PSGOEE=0 K PSGDUR G DONE
 I 'Y K X S PSGDUR=-1 G A39
 N P S P=1,PSGRMVT=$P(PSGRARR(P),"(",1)
 F  S P=$O(PSGRARR(P)) Q:P=""  D
 .S PSGRMVT=PSGRMVT_"-"_$P(PSGRARR(P),"(",1)
 .Q
 Q
 ;
