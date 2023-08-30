PSGOE42 ;BIR/CML - REGULAR ORDER ENTRY (CONT.) ;Feb 02, 2022
 ;;5.0;INPATIENT MEDICATIONS ;**366,327,399,372**;16 DEC 97;Build 153
 ;
 ; Reference to $$SDEA^XUSER supported by DBIA #2343
 ;
1 I $G(PSGCLOZ) K PSGCLOZ Q  ;NCC remediation *327/RJS QUIT IF STOP DATE HAS BEEN MODIFIED AND PROCESS
 S:'$G(PSGPR) PSGPR=0 S:'$D(PSGPRN) PSGPRN=""  ; must have provider info
 ; provider
 ;*372-cs schedule check
 N PSJDEA,PSDEA,PDEA,PSPPKG S (PSDEA,PDEA)=""
 I $G(PSGPDRG)]"" D  G:PDEA A1
 .S PSPPKG=$S(PSJPROT=1:"U",PSJPROT=3:"UI",1:"") Q:PSPPKG=""
 .S PSJDEA=$$OIDEA^PSSOPKI(PSGPDRG,PSPPKG),PSDEA=$P(PSJDEA,";",2)
 .I PSDEA>1,PSDEA<6 S PDEA=1
 I '$G(PSJSYSU) S PSTMPI=PSGPR,PSTMPN=PSGPRN G A1
 I $S(+PSJSYSU=3:0,1:$P(PSJSYSU,";",2)) G:$P(PSJSYSW0,"^",24) 5 G DONE
 S PSTMPI=PSGPR,PSTMPN=PSGPRN
A1 ;
 ;*366 - check provider credentials
 I PSGPR N PSJACT S PSJACT=$$ACTPRO^PSGOE1(PSGPR) S:'PSJACT PSGPR=0,PSGPRN=""
 W !,"PROVIDER: ",$S(PSGPR:PSGPRN_"// ",1:"") R X:DTIME I X="^" W $C(7) S PSGOROE1=1 G DONE
 I $S(X="":'PSGPR,1:X="@") W $C(7),"  (Required)" S X="?",PSGF2=1 D ENHLP^PSGOEM(53.1,1) G 1
 I X="",PSGPR S X=PSGPRN I PSGPR'=PSGPRN,$$GET1^DIQ(200,PSGPR,53.1,"I") W "    "_$$GET1^DIQ(200,PSGPR,53.2)_"    "_$$GET1^DIQ(200,PSGPR,53.3) S PSGFOK(1)="" G A2
 S PSGF2=1 I X?1."?" D ENHLP^PSGOEM(53.1,1)
 I $E(X)="^" D FF G:Y>0 @Y G 1
 K DIC S DIC="^VA(200,",DIC(0)="EMQZ",DIC("S")="I $$ACTPRO^PSGOE1(+Y)" D ^DIC K DIC I Y'>0 G 1
 S PSGPR=+Y,PSGPRN=$P(Y(0,0),"^"),PSGFOK(1)=""
A2 ;; START NCC T4 MODS >> 327*RJS
 I $$ISCLOZ^PSJCLOZ(,,,,PSGDRG) D
 .S ANQX=0 D PROVCHK^PSJCLOZ(PSGPR) ;(PSGP,PSGDRG)
 .I ANQX=0 K PSTMPN,PSTMPI
 I $G(ANQX) S PSGPR=PSTMPI,PSGPRN=PSTMPN W ! K ANQX G A1
 ;; END NCC T4 MODS << 327*RJS
 ;*372-cs schedule check
 I PDEA S PDEA=$$SDEA^XUSER(,+PSGPR,PSDEA,,"I") I (PDEA=1)!(PDEA=2)!(+PDEA=4) D  G A1
 .W !,"Provider not authorized to prescribe medications in Federal Schedule "_PSDEA_".",!,"Please contact the provider.",!
5 ; self med
 I '$P(PSJSYSW0,"^",24) G DONE
A5 W !,"SELF MED: " W:PSGSM]"" $P("NO^YES","^",PSGSM+1),"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I "01"[X,$L(X)<2 S:PSGSM=""&(X]"") PSGSM=X W:PSGSM]"" "  (",$P("NO^YES","^",PSGSM+1),")" G DONE
 I X="@" W:PSGSM="" $C(7),"  ??" G:PSGSM="" A5 D DEL G:%'=1 A5 S (PSGSM,PSGHSM)="" G DONE
 S PSGF2=5 I X?1"^".E D FF G:Y>0 @Y G A5
 I X?1."?" S PSGF2=5 D ENHLP^PSGOEM(53.1,5) G A5
 D YN I  S PSGSM=$E(X)="Y",PSGFOK(5)="" G 6:PSGSM,DONE
 W $C(7) D ENHLP^PSGOEM(53.1,5) G A5
 ;
6 ; hospital supplied self med
 W !,"HOSPITAL SUPPLIED SELF MED: " W:PSGHSM]"" $P("NO^YES","^",PSGHSM+1),"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I "01"[X,$L(X)<2 S:PSGHSM=""&(X]"") PSGHSM=X W:PSGHSM]"" "  (",$P("NO^YES","^",PSGHSM+1),")" G DONE
 I X="@" W:PSGHSM="" $C(7),"  ??" G:PSGHSM="" 6 D DEL G:%'=1 6 S PSGHSM="" G DONE
 S PSGF2=6 I X?1"^".E D FF G:Y>0 @Y G 6
 I X?1."?" D ENHLP^PSGOEM(53.1,6) G 6
 D YN I  S PSGHSM=$E(X)="Y" G DONE
 W $C(7) S PSGF2=6 D ENHLP^PSGOEM(53.1,6) G 6
 Q
 ;
DONE ;
 K F,F0,F1,PSGF2,F3,PSG,SDT Q
 ;
FF ; up-arrow to another field
 D ENFF^PSGOEM I Y>0,Y'=1,Y'=5 S Y=Y_"^PSGOE4"_$S("^109^13^3^7^26^"[("^"_Y_"^"):"",1:1)
 Q
 ;
DEL ; delete entry
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W $C(7),"  <NOTHING DELETED>"
 Q
 ;
YN ; yes/no as a set of codes
 I X'?.U F Y=1:1:$L(X) I $E(X,Y)?1L S X=$E(X,1,Y-1)_$C($A(X,Y)-32)_$E(X,Y+1,$L(X))
 F Y="NO","YES" I $P(Y,X)="" W $P(Y,X,2) Q
 Q
 ;
2 ; dispense drug multiple
 I PSGDRG,'$D(^PS(53.45,PSJSYSP,2)) S ^(2,0)="^53.4502P^1^1",^(1,0)=PSGDRG_"^"_PSGUD
 K DA,DR S DIE="^PS(53.45,",DA=PSJSYSP,DR=2,DR(2,53.4502)=$S($G(PSGFOK(13)):.02,1:".01;.02") D ^DIE
 I '$O(^PS(53.45,PSJSYSP,2,0)) W $C(7),!!,"WARNING: This order must have at least one dispense drug before pharmacy can",!?9,"verify it!"
 I $G(PSGFOK(13)) Q
 G @FB
 ;
IND(OI) ;*399-IND
INDA ;
 N INDLST,DIR,SEL,I,INDCAT,CHK,CNT K DUOUT,DTOUT,DIROUT,DIRUT
 S (CHK,CNT)=0,PSGF2=132
 I '$G(OI) S Y=99,PSGIND="" G CIND
 D INDCATN^PSS50P7(OI,"PSJDIND")
 I '$O(^TMP($J,"PSJDIND",0)) S Y=99 G CIND
 S (SEL,I)="" F  S I=$O(^TMP($J,"PSJDIND",I)) Q:'I  D
 . S INDCAT=$P($G(^TMP($J,"PSJDIND",I)),"^")
 . I $G(PSGIND)]"",INDCAT=PSGIND S CHK=1
 . S CNT=CNT+1,INDLST(CNT)=INDCAT,DIR("L",CNT)="  "_CNT_"   "_INDCAT S:CNT=1 SEL=CNT_":"_INDCAT S:CNT>1 SEL=SEL_";"_CNT_":"_INDCAT
 W !,"INDICATION:"
 S DIR(0)="SO^"_SEL_";99:Free Text entry",DIR("A")="Select INDICATION from the list"
 S DIR("L")="  99  Free Text entry"
 S:CHK DIR("B")=PSGIND S:'CHK&(PSGIND]"") DIR("B")=99
 S DIR("?")="This field contains the Indication For Use and must be 3-40 characters in length"
 D ^DIR
 I X="^"!($G(DTOUT))!($G(DIROUT)) S:'$G(PSGOEE) PSGOROE1=1 Q
 I Y=99 S:CHK PSGIND="" G CIND
 I X="@",$G(PSGIND)]"" D DEL G:%'=1 INDA S PSGIND="" Q
 I X="@" S PSGIND="" G INDA
 S PSGFOK(132)=""
 S:Y>0 PSGIND=Y(0)
 Q
CIND ;
 I Y=99 N I,J,IND,DA D  G:$G(Y)=99 CIND
 . K X,Y,DIRUT,DTOUT,DUOUT,DIROUT,DIR
 . S:$G(PSGIND)]"" DIR("B")=PSGIND
 . S DIR(0)="53.1,132",DIR("A")="INDICATION" D ^DIR
 . I X="^"!($G(DTOUT))!($G(DIROUT)) S:'$G(PSGOEE) PSGOROE1=1 Q
 . I X="@",$G(PSGIND)]"" D DEL G:%'=1 INDA S PSGIND="" Q
 . I X="@" S PSGIND="" G INDA
 . I $L(X," ")=1,$L(X)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED WITHOUT SPACES.",! S Y=99 Q
 . S IND="" F I=1:1:$L(X," ") Q:I=""  S J=$P(X," ",I) D  I '$D(X) S Y=99 Q
 . .I $L(J)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED BETWEEN SPACES.",! K X Q
 . .S:J]"" IND=$S($G(IND)]"":IND_" ",1:"")_J
 . Q:$G(Y)=99
 . S PSGIND=$$ENLU^PSGMI(IND)
 . S PSGFOK(132)=""
 Q
 ;
 ;do we have any changes for indication?
 ;compare indication passed in PSJNEWVL parameter with value stored in the field (#132) of the file (#53.1) with the IEN=+PSJORD
DIFFIND(PSJDFN,PSJORD,PSJNEWVL) ;
 ; PSJDFN = IEN of #2 (not required for non-verified orders)
 ; PSJORD = IEN of #53.1/55 + indication like "P","U","V", example = "4033P"
 ; PSJNEWVL the new value after editing
 ; returns:
 ; piece #1 
 ;   1=different than the previous value
 ;   0=no changes
 ;  -1=new record, no previous values
 ; piece #2 = value before editing if any (current value in DB)
 ; piece #3 = new value
 N CURRVAL S CURRVAL=""
 N STATUS S STATUS=0
 S PSJNEWVL=$G(PSJNEWVL)
 ; if this is non-verified order
 I PSJORD["P" D  Q STATUS_U_$G(CURRVAL)_U_PSJNEWVL
 . ;if node does not exist then return -1
 . I '$D(^PS(53.1,+PSJORD,18)) S STATUS=-1,CURRVAL="" Q
 . S CURRVAL=$$GET1^DIQ(53.1,+PSJORD,132,"E")
 . S STATUS=$S(PSJNEWVL=CURRVAL:0,1:1)
 ; if this is Unit Dose verified order
 I PSJORD["U",+$G(PSJDFN) D  Q STATUS_U_$G(CURRVAL)_U_PSJNEWVL
 . ;if node does not exist then return -1
 . I '$D(^PS(55,+PSJDFN,5,+PSJORD,18)) S STATUS=-1,CURRVAL="" Q
 . S CURRVAL=$$GET1^DIQ(55.06,+PSJORD_","_+PSJDFN_",",141)
 . S STATUS=$S(PSJNEWVL=CURRVAL:0,1:1)
 Q 0  ; there is no difference by default
