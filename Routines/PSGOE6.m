PSGOE6 ;BIR/CML3-ORDER ENTRY THROUGH OE/RR ; 10/7/08 1:15pm
 ;;5.0; INPATIENT MEDICATIONS ;**3,7,39,45,65,58,81,156,134,179**;16 DEC 97;Build 45
 ;
 ; Reference to ^PS(50.7 supported by DBIA #2180.
 ; Reference to ^PS(51.1 is supported by DBIA #2177.
 ; Reference to ^PS(51.2 is supported by DBIA #2178.
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^DD(53.1 is supported by DBIA #2256.
 ; Reference to ^VA(200 is supported by DBIA #10060.
 ; Reference to ^DICN is supported by DBIA #10009.
 ;
 K PSGFOK S F1=53.1,PSGPR=$S($D(PSGOERR):PSJORPV,1:PSGOEPR),PSGMR=$S($P(PSGNEDFD,"^",2):$P(PSGNEDFD,"^",2),1:PSGOEDMR),PSGSCH=$P(PSGNEDFD,"^",4),(PSGOROE1,PSGSI,SDT,PSGMRN,PSGSM,PSGHSM,PSGUD,PSGSD,PSGFD,PSGSI,PSGNEFD,PSGNESD)=""
 S:PSGMR PSGMRN=$S('$P(PSGNEDFD,"^",2):"ORAL",'$D(^PS(51.2,PSGMR,0)):PSGMR,$P(^(0),"^")]"":$P(^(0),"^"),1:PSGMR) I PSGPR S PSGPRN=$P($G(^VA(200,PSGPR,0)),"^") S:PSGPRN="" PSGPRN=PSGPR
 S PSGST=$S($P(PSGNEDFD,"^",3)]"":$P(PSGNEDFD,"^",3),1:"C")
 ; Naked references in line below refer to ^PS(53.45,PSJSYSP
 K ^PS(53.45,PSJSYSP,1),^(2) I PSGDRG S ^(2,0)="^53.4502P^"_PSGDRG_"^1",^(1,0)=PSGDRG,^PS(53.45,PSJSYSP,2,"B",PSGDRG,1)=""
 ;
109 ; dosage ordered
 W !,"DOSAGE ORDERED: ",$S(PSGDO]"":PSGDO_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="" S X=PSGDO I X="" W $C(7),"  (Required)" G 109
 S PSGF2=109 I X="@" W $C(7),"  (Required)" G 109
 I X?1."?" S F1=53.1 D ENHLP^PSGOEM(53.1,109) G 109
 I $E(X)="^" D FF G:Y>0 @Y G 109
 I $E(X,$L(X))=" " F  S X=$E(X,1,$L(X)-1) Q:$E(X,$L(X))'=" "
 I $S(X?.E1C.E:1,$L(X)>20:1,X="":1,X["^":1,X?1.P:1,1:X=+X) W $C(7),"  ",$S(X?1.P!(X=""):"(Required)",1:"??") S X="?" D ENHLP^PSGOEM(53.1,109) G 109
 S PSGDO=X,PSGFOK(109)=""
 ;
3 ; med route
 W !,"MED ROUTE: ",$S(PSGMR:PSGMRN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="",PSGMR S X=PSGMRN I PSGMR'=PSGMRN,$D(^PS(51.2,PSGMR,0)) W "  "_$P(^(0),"^",3) S PSGFOK(3)="" G 26
 S PSGF2=3 I $S(X="@":1,X]"":0,1:'PSGMR) W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,3) G 3
 I X?1."?" D ENHLP^PSGOEM(53.1,3)
 I $E(X)="^" D FF G:Y>0 @Y G 3
 K DIC S DIC="^PS(51.2,",DIC(0)="EMQZ",DIC("S")="I $P(^(0),""^"",4)" D ^DIC K DIC I Y'>0 G 3
 S PSGMR=+Y,PSGMRN=Y(0,0),PSGFOK(3)=""
 ;
26 ; schedule
 W !,"SCHEDULE: ",$S(PSGSCH]"":PSGSCH_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 S:X="" X=PSGSCH S PSGF2=26 ; I "@"[X W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,26) G 26
 I X?1."?" D ENHLP^PSGOEM(53.1,26) G 26
 I $E(X)="^" D FF G:Y>0 @Y G 26
 I X="" S (PSGS0XT,PSGS0Y,PSGST)=""
 E  D EN^PSGS0 I '$D(X) W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(53.1,26) G 26
 S PSGSCH=X,(PSGFOK(26),PSGST)="",PSGOES=1 S:PSGS0XT="O" $P(PSGNEDFD,"^",3)="O",PSGST="O" D ^PSGNE3 K PSGOES
 ;
66 ; provider's comments
 ;
 ;
DONE ;
 I PSGOROE1 K Y W $C(7),"  ...order not entered..."
 K F,F0,F1,PSGF2,F3,PSGFOK,SDT Q
 ;
FF ; up-arrow to another field
 S Y=-1 I '$D(PSGFOK) W $C(7),"  ??" Q
 S X=$E(X,2,99) I X=+X S Y=$S($D(PSGFOK(X)):X,1:-1) W "  " W:Y>0 $$CODES2^PSIVUTL(53.1,X) W:Y'>0 $C(7),"??" Q
 K DIC S DIC="^DD(53.1,",DIC(0)="QEM",DIC("S")="I $D(PSGFOK(+Y))" D ^DIC K DIC S Y=+Y
 Q
 ;
DEL ;
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W "  <NOTHING DELETED>"
 Q
 ;
GTST(ON) ; Find schedule type for pending order.
 N PD,PDAP,ST,X,ST1 S ST=""
 S ST=$P($G(^PS(53.1,+ON,0)),"^",7)
 I $P($G(^PS(53.1,+ON,0)),U,24)="R" D
 .; naked ref below is from line above, ^PS(53.1,ON,0)
 .S X=$P(^(0),U,25) S ST=$S(X["N"!(X["P"):$P($G(^PS(53.1,+X,0)),U,7),X["V":"C",1:$P($G(^PS(55,PSGP,5,+X,0)),U,7))
 .I ST]"" S (PSGOST,PSGST)=ST,PSGSTN=$$ENSTN^PSGMI(ST) Q
 I ST'="" D
 . S ST1=""
 . S PD=+$G(^PS(53.1,+ON,.2)) S X=$G(^PS(50.7,PD,0)),ST1=$P(X,U,7)
 . I $G(ST1)="R" S ST="R"
 . K ST1
 I ST="" D
 . ;PSJ*5*156 - Don't allow backdoor to override intended schedule type from CPRS unless the default
 . ;            schedule type (if any) is "Fill on Request".
 . S PD=+$G(^PS(53.1,+ON,.2)) S X=$G(^PS(50.7,PD,0)),ST=$P(X,U,7)  ;see if there is a default schedule type.
 . I ST="R" Q  ;Fill on Request default schedule type will override incoming schedule type from CPRS
 . S ST=""  ;Reset to null in case default schedule type other than Fill on Request is defined.
 . D OTS I ST="O" Q
 . I PSGSCH="ON CALL"!(PSGSCH="ONCALL")!(PSGSCH="ON-CALL") S ST="OC" Q
 . I PSGSCH["PRN" S ST="P" Q
 . S ST="C"
 S (PSGOST,PSGST)=ST,PSGSTN=$$ENSTN^PSGMI(ST)
 Q
 ;PSJ*5*179;x-ref to "AC","PSJ"
OTS I PSGSCH]"" S X=+$O(^PS(51.1,"AC","PSJ",PSGSCH,0)) I $P($G(^PS(51.1,X,0)),"^",5)="O" S ST="O" Q
 I PSGSCH="TODAY"!(PSGSCH="NOW")!(PSGSCH="STAT")!(PSGSCH="ONCE")!(PSGSCH="ONE TIME")!(PSGSCH="ONE-TIME")!(PSGSCH="ONETIME")!(PSGSCH="1TIME")!(PSGSCH="1 TIME")!(PSGSCH="1-TIME") S ST="O"
 Q
