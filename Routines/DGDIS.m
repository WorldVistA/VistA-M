DGDIS ;ALB/JDS - DISPOSITION A REGISTRATION ; 8/6/04 3:17pm
 ;;5.3;Registration;**108,121,161,151,459,604**;Aug 13, 1993
 ;
 D LO^DGUTL
GETL S L=^DG(43,1,0),DISL=+$P(L,"^",7) S:DISL=0 DISL=24 N SDISHDL
FIND W !! S DIC("A")="Disposition PATIENT: ",DIC="^DPT(",DIC(0)="AEQMZ",DIC("S")="I $D(^DPT(""ADA"",1,+Y))" D ^DIC K DIC("S"),DIC("A") G Q:Y'>0 S (DA,DFN,DGDFN)=+Y
 S I=+$O(^DPT(DA,"DIS",0)),L=$S($D(^(I,0)):^(0),1:""),(DA,DFN1,DGDFN1)=I,SDL=L ;I $P(L,"^",6)?7N.E!(L="") W !!,"There are no open registrations to disposition for this patient.",!!,*7,*7 K DA,DFN1 G FIND
DP W !!,"LOG DATE",?20,"TYPE OF BENEFIT APPLIED FOR",! F I=1:1:47 W "-"
 S L2=";"_$P(^DD(2.101,2,0),"^",3),L3=";"_$P(L,"^",3)_":"
 W !,$$FMTE^XLFDT($E($P(L,U),1,12),"5Z"),?20,$P($P(L2,L3,2),";",1)
 S DGODSND=L
ANS ;
 ;** DG*5.3*108; Eligibility Code and Period of Service Checks follow
 W !! S DR="1;2;2.1;13;5//NOW;D CHT^DGDIS;8"_$S(DUZ'="":";9////"_DUZ,1:""),DIE="^DPT("_DFN_",""DIS"",",DA(1)=DFN,DP=2.101 D ^DIE I $S('$D(^DPT(DFN,"DIS",DA,0)):1,'$P(^(0),"^",6):1,1:0) G DEL
 N DGPOSX,DGELIGX,DGSTRX
 S DGELIGX=$S('$D(^DPT(DFN,.36)):1,$P(^(.36),"^",1)']"":1,1:0)
 S DGPOSX=$S('$D(^DPT(DFN,.32)):1,$P(^(.32),"^",3)']"":1,1:0)
 I (DGELIGX)&(DGPOSX) W !!,"Primary Eligibility Code and Period of Service are unspecified." K DGPOSX,DGELIGX,DGSTRX G DEL
 I (DGELIGX)&('DGPOSX) W !!,"Primary Eligibility Code is unspecified." K DGPOSX,DGELIGX,DGSTRX G DEL
 I ('DGELIGX)&(DGPOSX) W !!,"Period of Service is unspecified." K DGPOSX,DGELIGX,DGSTRX G DEL
 ;S DGXXXD=0 D EL^DGREGE
DISP W ! S DIC="^DIC(37,",DIC(0)="AEQMZ",DIC("A")="Select the type of disposition: ",DIC("S")="I '$P(^(0),""^"",10)" D ^DIC K DIC("A"),DIC("B") I Y'>0 G DEL:X?1"^".E W !!,"A disposition must be entered to continue.",!!,*7,*7 G DISP
 D ODS
 S DR="" I $P(Y(0),"^",1)["INELIG" S DIE("NO^")="",DR="2.1;"
 S DR=DR_"S:'DGODS Y=6;11500.01////1;11500.02////^S X=$S(DGODSE>0:DGODSE,1:"""");"
 S DR=DR_"6///"_(+Y),DISP=+Y,DA=DFN1,DP=2.101,DA(1)=DFN D ^DIE K DIE("NO^") S DDT=$S($D(^DPT(DFN,"DIS",DA,0)):^(0),1:""),DGDIV=+$P(DDT,"^",4),DDT=$P(DDT,"^",6) S:'DGDIV DGDIV=""
 I $P(^DG(43,1,0),U,30) S %ZIS="N",IOP="HOME" D ^%ZIS I $D(IOS),IOS,$D(^%ZIS(1,+IOS,99)),$D(^%ZIS(1,+^(99),0)) S Y=$P(^(0),U,1),DGIO(10)=Y
 S X=$S($D(^DG(40.8,+DGDIV,"DEV")):^("DEV"),1:"1^1^1") S:'$D(DGIO(10)) DGIO(10)=$S($P(X,U,1)]"":$P(X,U,1),1:1)
 S DFN=DGDFN,DFN1=DGDFN1,DGXXXD=0,DIE="^DPT("_DFN_",""DIS""," D EL^DGREGE
 D MT
 D EN1^DGEN(DFN) ;enrollment
 W !!,"***** Registration dispositioned *****",!!,*7
 D VALIDATE(DFN,DFN1) ; -- call c/o validator
 D ACT
 K DGDFN1,DGDOM,DGHEM,DGKAAS,DGL,DGNHCU,DGW,MASD,MASDEV,PARA,POP
DONE D Q G FIND
 ;
Q K %H,%Y,C,D0,D1,DG1,DGA1,DGDFN1,DGL,DGT,DQ,I1,SD321,SDDIV,SDL,VA,VAROOT,Z,DGDFN,DIC,DGIO,DDT,DISP,DGDIV,DA,DR,DFN,DFN1,L,I,Y,X,DIE,DIC,DP
 K DGODS,DGODSND,SDISDEL Q
 ;
CHT S L=^DPT(DA(1),"DIS",DA,0),DGL=0,L2=+$P(L,"^",6),(L1,X)=+L D H^%DTC S LL1=%H,X=L2 D H^%DTC S LL2=%H
 S X1=L1#1*10000,X2=L2#1*10000 S:LL2-LL1 X2=X2+(LL2-LL1*2400\1) S X3=X2\100-(X1\100),X2=X2#100,X1=X1#100 S:X1'<X2 X2=X2+60,X3=X3-1
 S Y=$S(DUZ'="":9,1:0) S:X3'<DISL Y=8,DGL=1 Q
 ;
DEL S L=$S($D(^DPT(DFN,"DIS",DFN1,0)):^(0),1:0),X=$P(L,U,6) I X S $P(^(0),U,6)="" F I=0:0 S I=$O(^DD(2.101,5,1,I)) Q:'I  X ^(I,2)
 I $P($G(^DPT(DFN,"DIS",DFN1,0)),"^",18) D EN^SDCODEL(+$P(^(0),"^",18),1,$G(SDISHDL))
 D Q W !!,"* Disposition deleted *",!!,*7,*7 G FIND
 ;
ODS ;if operation desert shield admission, create an entry in the ODS ADMISSIONS file
 N DIE,DGDISTYP
 S DGODS=0,DGDISTYP=+Y
 I $P(Y(0),"^",1)["ADMIT"!($P(Y(0),"^",1)["ADMISSION"&($P(Y(0),"^",1)'["SCHEDULED")) Q  ;don't store dispositions to admit
 N Y D PT^DGYZODS I 'DGODS Q
 S A1B2FL=11500.4,A1B2DT=+DGODSND D ADD^A1B2UTL S (DA,DGODSE)=+Y
 S DIE="^A1B2(11500.4,",DR=".02////^S X=DGODS;.05////^S X=DGDISTYP;" D ^DIE
 K DIE,DA Q
 ;
MT ;Check if user requires a means test.  Ask user if s/he wants to
 ;proceed if one is required.
 N DGREQF
 D EN^DGMTR
 I $P($$MTS^DGMTU(DFN),U,2)="R" D EDT^DGMTU(DFN,DT)
 Q
 ;
ACT ;Execute Program Action
 N DFN1
 S DGDFN=DFN I $D(^DIC(37,DISP,"P")),^("P")]"" X ^("P")
 Q
 ;
BEFORE(DFN,SDDT,SDEVT,SDISHDL) ; -- set 'before' vars for opt evt drv
 ; -- use tag for NEWing
 N DA,DFN1,DGDFN,DGDFN1,DGODSND
 D BEFORE^SDAMEVT3(.DFN,.SDDT,.SDEVT,.SDISHDL)
 Q
 ;
EVT(DFN,SDDT,SDEVT,SDISHDL) ; -- opt evt drv
 ; -- use tag for NEWing
 N DIV,DFN1,DGDFN,SDL,DGDIV,DISP,SD321,SDDIV,I,DGDFN1,DGDOM,DGHEM,DGKAAS,DGL,DGNHCU,DGW,MASD,MASDEV,PARA,POP
 D EVT^SDAMEVT3(.DFN,.SDDT,.SDEVT,.SDISHDL)
 Q
 ;
VALIDATE(DFN,DFN1) ; -- c/o validator
 ; -- use tag for NEWing
 N DIV,DGDFN,SDL,DGDIV,DISP,SD321,SDDIV,I,DGDFN1,DGDOM,DGHEM,DGKAAS,DGL,DGNHCU,DGW,MASD,MASDEV,PARA,POP
 ;
 N DGDIS0,DGOE,DGOE0,DGVST
 S DGDIS0=$G(^DPT(+DFN,"DIS",+DFN1,0))
 I "^0^1^"[(U_$P(DGDIS0,"^",2)_U) D
 . ;
 . ; -- get encounter
 . S DGOE=+$P(DGDIS0,U,18)
 . IF 'DGOE Q
 . ;
 . ; -- get encounter and visit
 . S DGOE0=$$GETOE^SDOE(DGOE)
 . S DGVST=+$P(DGOE0,U,5)
 . IF 'DGVST Q
 . ;
 . ; -- validate disposition
 . D FINAL^SCDXHLDR(DGVST)
 Q
