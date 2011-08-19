FBCH78 ;AISC/DMK-SETS UP 7078/AUTHORIZATION FOR CONTRACT HOSPITAL ;08/07/02
 ;;3.5;FEE BASIS;**43,103**;JAN 30, 1995;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S DIC("S")="I $P(^(0),U,15)=3&($P(^(0),U,12)=""Y"")" D ASKV^FBCHREQ G END:$E(X)="^"!($E(X)="")!('$D(FBDA))
 I $P(^FBAA(162.2,FBDA,0),"^",17)]"" W !!,*7,"There already is a 7078 set up for this request.",!,"The number is ",$P(^FB7078($P(^FBAA(162.2,FBDA,0),"^",17),0),"^")," .",! G END
EN S FBVEN=$P(^FBAA(162.2,FBDA,0),"^",2)_";FBAAV(",FBVET=$P(^(0),"^",4),FBFRDT=$P(^(0),"^",5),FBFRDT=FBFRDT\1,FBDOA=$S($P(^(0),"^",19):$P(^(0),"^",19)\1,1:""),FBDXS=$P(^(0),"^",6)
 ;FB*3.5*103 ;added FBRP
 S FBRP=$P($G(^FBAA(162.2,FBDA,2)),"^") K DA
 W !! S %DT="APEX",%DT("A")="AUTHORIZATION TO DATE: " D ^%DT K %DT G END:X="^" S FBTODT=$S(X="":"",1:Y)
 I FBTODT]"",FBFRDT>FBTODT W !!,*7,?5,"Authorization To Date must be after Authorization From Date!",! G EN
 W !! S %DT="APEX",%DT("A")="DATE OF DISCHARGE: ",%DT("B")=$$DATX^FBAAUTL(FBTODT) D ^%DT K %DT G END:X="^" S FBDOD=$S(X="":"",1:Y)
 I FBDOD]"",FBTODT>FBDOD W !!,*7,?5,"Date of Discharge must not be earlier than the Authorization To Date!",! G EN
 S DIR(0)="162.4,5",DIR("A")="ADMITTING AUTHORITY" D ^DIR K DIR
 G END:$D(DIRUT) S FBADMIT=+Y
 S DIR(0)="162.4,6" D ^DIR K DIR
 G END:$D(DIRUT) S FBEST=+Y
FBPDIS I FBTODT="" S DIR(0)="162.4,12" D ^DIR K DIR G END:$D(DUOUT),END:$D(DTOUT),NULL^FBCH780:X="" S FBPDIS=+Y
 ;
ASKPT I FBTODT]"" S DIR(0)="SAO^00:SURGICAL;10:MEDICAL;86:PSYCHIATRY",DIR("A")="BEDSECTION/TREATING SPECIALTY: ",DIR("?")="^D HELP^FBCH780" D ^DIR K DIR D NOUP^FBCHCD:$D(DIRUT) G ASKPT:$D(DIRUT) S FBPT=Y
7078 S PRCS("A")="Select Obligation Number: ",PRCS("TYPE")="FB" D EN1^PRCS58 G:Y=-1 NOGOOD S (X,FBCHOB)=$P(Y,"^",2) K PRCS("A") S PRCS("TYPE")="FB" D EN1^PRCSUT31 G:Y="" NOGOOD S FB7078=$P(FBCHOB,"-",2)_"."_Y S FBSEQ=Y
 S DIC="^FB7078(",DIC(0)="LQ",DLAYGO=162.4,X=""""_FB7078_"""" D ^DIC G:Y<0 PROB S (DA,FBAA78)=+Y
 S DIE="^FBAA(162.2,",DA=FBDA,DR="16////^S X=FBAA78" D ^DIE K DIE,DIC,DA,DR
SET78 S DIE="^FB7078(",DA=FBAA78,DR="[FBCH ENTER 7078]" D ^DIE K DIC,DIE,DR,DA
 D ^FBCH780 I $G(FBOUT) W !!,*7,"...deleting 7078." D DEL G END
 I +Y=0 W !!,*7,Y,!,"...deleting 7078.  Use 'Set-up a 7078' after adjusting 1358.",! D DEL G END
 K DIE,DIC,DA
 I $G(FBVET) S:'$G(DFN) DFN=FBVET D PTF^FBCH780
 G SHOW:FBTODT=""
AUTH D HOME^%ZIS
 D:'$D(FBSITE(1)) SITEP^FBAAUTL Q:FBPOP  S FBPSA=$S($P(FBSITE(1),"^",3)="":"",$D(^DIC(4,$P(FBSITE(1),"^",3),0)):$P(^(0),"^"),1:"")
 S FBVEN=$P(FBVEN,";")
 I '$D(^FBAAA(FBVET,0)) L +^FBAAA(FBVET) K DD,DO S (X,DINUM)=FBVET,DIC="^FBAAA(",DIC(0)="LM",DLAYGO=161 D FILE^DICN L -^FBAAA(FBVET) G:Y<0 END
 S:'$D(^FBAAA(FBVET,1,0)) ^(0)="^161.01D^^"
 K DE,DQ,DR,DIE,DLAYGO
FBDCHG S DIR(0)="161.01,.06" D ^DIR K DIR G END:$D(DTOUT),END:$D(DUOUT) D NULL1^FBCH780:X="" G FBDCHG:X="" S FBDCHG=+Y
FBPUR S FBTYPE=6,DIR(0)="161.01,.07" D ^DIR K DIR S FBPUR=+Y
 G END:$D(DTOUT),END:$D(DUOUT)
FBPSA S DIR(0)="161.01,101" D ^DIR K DIR G END:$D(DTOUT),END:$D(DUOUT) D NULL1^FBCH780:X="" G FBPSA:X="" S FBPSA=+Y
 ;file entry in authorization multiple of file 161
 S DIC="^FBAAA("_FBVET_",1,",DIC(0)="LM",DLAYGO=161,DA(1)=FBVET,X=FBFRDT K DD,DO D FILE^DICN G:Y<0 END S DA=+Y,DIE("NO^")="" ;DA(1)=FBVET
 S FB78=FBAA78_";FB7078("
 ;FB*3.5*103 ;added FBRP
 S DIE=DIC,DR=".02////^S X=FBTODT;.03////^S X=6;100////^S X=DUZ;1////^S X=""YES"";.055////^S X=FB78;.06////^S X=FBDCHG;S FBTYPE=6;.04////^S X=FBVEN;.065////^S X=FBPT;101////^S X=FBPSA"
 S:$G(FBRP)]"" DR=DR_";104////^S X=FBRP"
 S DR=DR_";.095////^S X=1"
 S DR(1,161.01,1)="I $D(^FB7078(FBAA78,1,0)) S ^FBAAA(DA(1),1,DA,2,0)=^(0) F FBI=1:1 Q:'$D(^FB7078(FBAA78,1,FBI,0))  I $D(^(0)) S ^FBAAA(DA(1),1,DA,2,FBI,0)=^(0);.07////^S X=FBPUR;.08///^S X=FBDXS;.096;.097//^S X=""N"""
 D ^DIE K DIE,DR
 S (DIC,DIE)="^FB7078(",DA=FBAA78,DR="9///^S X=""C"";12///^S X=""@""" D ^DIE K DR,DIE,DA,X
SHOW W !! S DA=FBAA78,DR="0;1",DIC="^FB7078(" D EN^DIQ
 ;
 ;FB*3.5*103 ;added FBRP
END K D,DA,DIC,DIE,DIR,DLAYGO,DR,FBDA,FB7078,FBAA78,FBPT,FBTYPE,FBVEN,FBZ,FBVET,FBFRDT,FBTODT,J,S,POP,X,Y,DFN,FBCHOB,FBCOMM,FBDFN,FBEST,FBI,FBLENT,FBMENT,FBNAME,FBSEQ,FBSSN,FBSW,I,K,PRC,VAL,FB,FBFLG,ZZ,FBPSA,FBSITE,FB78,FBOUT
 K FBDCHG,FBPUR,FBPDIS,FBADMIT,FBDXS,A,D0,D1,X1,DIRUT,DTOUT,DUOUT,FBDOA,FBDOD,FBPOP,FBZZ,ZZZ,PRCSCPAN,FBRP
 Q
PROB W !!,"The reference number did not get set up with the",!,"IFCAP software. Contact your package coordinator." G END
NOGOOD S DIR(0)="Y",DIR("A")="Obligation number selected is invalid or you are not a control point user in the IFCAP package!  Try again",DIR("B")="YES" D ^DIR K DIR G END:$D(DIRUT)!'Y,7078
 ;
OUTP ;ENTRY TO DISPLAY A 7078
 ;FB*3.5*103 ; Display the 0 node fields with computed REFERRING PROVIDER NPI, then 1 node fields
 S DIC="^FB7078(",DIC(0)="AEQM",D="D",DIC("A")="Select Patient: " D IX^DIC
 G END:X=""!(X="^")
 S (DA,FBDA)=+Y,DR="0",DIQ(0)="C" W !! D EN^DIQ K DIQ(0)
 S DA=FBDA,DR="1" D EN^DIQ
 I $$DISCH^FBCH780(FBDA)]"" W ?2,"DISCHARGE TYPE: ",$$DISCH^FBCH780(FBDA),!
 G OUTP
 ;
REFNPI(IEN200,IEN162P4,CHKAUTH) ;FB*3.5*103
 ; a new function that returns the REFERRING PROVIDER NPI if it is Active and the provider has authorized use of the NPI
 ; If is used in both a Fileman function and in other FB routines.
 ;
 ; Input
 ; IEN200 - IEN to file 200 if known
 ; IEN162P4 (optional) - IEN to File 162.4 (if ref prov is not known)
 ; CHKAUTH (optional) - Flag on whether to Chek Authorization in file 200
 ;
 ; Output
 ; A valid/active NPI if one can be determined.  Otherwise, nada.
 ;
 ; If neither IEN is passed in, there is no NPI coming out
 I $G(IEN200)<1,$G(IEN162P4)<1 Q ""
 ;
 ; If there is no referrring provider IEN passed in, try getting it from the IEN from 162.4 (VA FORM 10-7078)
 ; return nothing if you can't
 I $G(IEN200)<1 S IEN200=$$GET1^DIQ(162.4,IEN162P4_",",15,"I") Q:$G(IEN200)<1 ""
 ;
 ; Now that we have an IEN to 200 see if we need authorization and have to display/print NPI
 ; If the return value is less than 1, then we don't have permission or it was not a valid IEN.
 ; IA#5070
 I $G(CHKAUTH) Q:+$$GETRLNPI^XUSNPI(IEN200)<1 ""
 ;
 ; Go get the NPI for this IEN
 N NPI S NPI=$$NPI^XUSNPI("Individual_ID",IEN200)
 ;
 ; Make sure it is a valid/Active NPI
 I +NPI<1!($P(NPI,U,3)="Inactive") Q ""
 Q +NPI
 ;
DEL S DA=FBAA78,DIK="^FB7078(" D ^DIK K DIK S DA=$O(^FBAA(162.2,"AM",+FBAA78,0)) I DA S DIE="^FBAA(162.2,",DR="16///@" D ^DIE
