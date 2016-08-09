PSIVEDRG ;BIR/MLM-ENTER/EDIT DRUGS FOR IV ORDER ;16 Mar 99 / 2:14 PM
 ;;5.0;INPATIENT MEDICATIONS ;**21,33,50,65,74,84,128,147,181,263,281,313**;16 DEC 97;Build 26
 ;
 ; References to ^PS(52.6 supported by DBIA# 1231.
 ; References to ^PS(52.7 supported by DBIA# 2173.
 ; Reference to EN^PSOORDRG supported by DBIA# 2190.
 ; Reference to ^TMP("PSODAOC",$J supported by DBIA #6071.
 ;
DRG ; Edit Additive/Solution data
 N DRGOC K PSGORQF ;If PSGORQF=1 abort order after order check.
 K PSIVOLD S DRG(2)="" I $D(DRG(DRGT)) S DRGI=+$O(DRG(DRGT,0)) I DRGI S PSIVOLD=1 D SETDRG
DRG1 ;
 Q:$G(PSGORQF)
 I $G(X)="?" K DUOUT
 D FULL^VALM1
 W !,"Select ",DRGTN,": "
 I DRGT=$G(PSIVOI),($G(PSIVOI("DILIST",0))>1) D GTADSOL Q
 W:DRG(2)]"" DRG(2),"//" R X:DTIME S:'$T X="^" S:X=U DONE=1 I X["^"!(X=""&(DRG(2)="")) D CHKSCMNT Q
DRG1A I X="" W !,DRGTN,": ",DRG(2),"//" R X:DTIME S:'$T X="^" D:X="^" CHKSCMNT Q:X="^"  I X="" S Y=1 D DRG3 G:DRGT="AD"!($G(P(4))="H") DRG1 Q
 I X="@",DRG(2)]"" D DEL G:%'=1 DRG1A K DRG(DRGT,DRGI),^TMP("PSODAOC",$J) S DRGI=+$O(DRG(DRGT,0)) S:'DRGI DRG(DRGT,0)=0 D SETDRG G DRG1
 I X["???",($E(P("OT"))="M"),(PSIVAC["C") D ORFLDS^PSIVEDT1 G DRG1
 I X'["?" S %=0 D:$D(DRG(DRGT)) CHK G:%=1 DRG1A D DRG2 Q:$G(Y)>0&($G(P(4))'="H"&(DRGT="SOL"))  G DRG1
 I $D(DRG(DRGT)) W !,"This order includes the following ",DRGTN,"S:",! D
 . F Y=0:0 S Y=$O(DRG(DRGT,Y)) Q:'Y  D
 . . W !,$P(DRG(DRGT,Y),U,2)
 . . W:DRGT="AD" ?40,"Additive Strength: ",$S($$GET1^DIQ(52.6,+$G(DRG(DRGT,Y)),19):$$GET1^DIQ(52.6,+$G(DRG(DRGT,Y)),19)_" "_$$GET1^DIQ(52.6,+$G(DRG(DRGT,Y)),2),1:"N/A")
 W !!,"YOU MAY ENTER A NEW ",DRGTN,", IF YOU WISH",! D GTSCRN(X) S DIC(0)="EQM" D ^DIC K DIC G DRG1
 Q
 ;
SETDRG ; Put Drug data into DRG(x).
 F X=1:1:6 S DRG(X)=$P(DRG(DRGT,DRGI),U,X)
 S X="" I DRG(2)="",DRG(1) S DRG(2)="*** Undefined ***"
 Q
DRG2 ;
 D GTSCRN(X) N PSIVX S PSIVX=X,DIC(0)="EQMZ" D ^DIC K DIC Q:Y<0
 S PSJIVIEN=+Y
 N PSJNF D NFIV^PSJDIN($S(DRGT="AD":52.6,1:52.7),+PSJIVIEN,.PSJNF)
 W PSJNF("NF")
 S PSIVNEW=1,DRGTMP=+Y_U_$P(Y(0),U)_U_$S(DRGT="SOL":$P(Y(0),U,3),1:"")_U_U_$P(Y(0),U,13)_U_$P(Y(0),U,11)
 I '$D(ON55) N ON55 S ON55=ON
 D ORDERCHK(DFN,ON55,1) I $G(PSGORQF) S X=U,DONE=1 Q
 D DINIV^PSJDIN($S(DRGT="AD":52.6,1:52.7),+DRGTMP)
 S (DRG(DRGT,0),DRGI)=$G(DRG(DRGT,0))+1,DRG(DRGT,DRGI)=DRGTMP K PSIVOLD
 I (PSIVAC="PN"!(PSIVAC="CF")),(DRGT="AD"),$D(^PS(52.6,"C",PSIVX,+DRGTMP)) D ^PSIVQUI Q:$G(PSIVSTR)="QUICK CODE"!$G(PSGORQF)
DRG3 ;
 D:DRG(2)]"" DINIV^PSJDIN(FIL,+DRG(1))
 D SETDRG
 I DRGT="AD" S X=$P($G(^PS(FIL,+DRG(1),0)),U,3) W !!,"(The units of strength for this additive are in ",$$ENU^PSIVUTL(DRG(1)),")"
AMT ;
 I DRGT="SOL",'$G(PSIVOLD),($G(P(4))_$G(P(23))'["S") G DRG4
1 ; Strength/Volume
 W !,$S(DRGT="AD":"Strength: ",1:"Volume: ") W:+DRG(3) DRG(3),"//" R X:DTIME S:'$T X="^" Q:X="^"  G:X=""&DRG(3) 2 I X="" W $C(7),$S(DRGT="AD":"Strength",1:"Volume")," is REQUIRED!" G 1
 D:$D(X) IT G:'$D(X)!($G(X)["?") AMT S DRG(3)=X I X="" D FIELD^DID($S(DRGT="AD":53.157,1:53.158),1,"","XECUTABLE HELP","PSJEX") X PSJEX("XECUTABLE HELP") K PSJEX G AMT
2 ;
 I DRGT="AD",$G(P("DTYP"))>1,P(4)'="S",P(23)'="S" K DIR S DIR(0)="53.157,2" S:DRG(4)]"" DIR("B")=DRG(4) D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S:X="@" DRG(4)="" S:Y DRG(4)=Y
DRG4 ;
 F X=1:1:6 S $P(DRG(DRGT,DRGI),U,X)=DRG(X)
 S DRG(2)=""
 Q
 ;
CHKSCMNT ;
 I $$SEECMENT() W !!,"*** One or more additives has 'See Comments' in the Bottle field.",!,"    Please correct.",!!
 Q
SEECMENT() ;
 ;Return 1 if DRG array still contain "See Comments"
 N PSIVDRGI,PSIVDRG0,PSIVFLG
 S PSIVFLG=0
 F PSIVDRGI=0:0 S PSIVDRGI=$O(DRG("AD",PSIVDRGI)) Q:'PSIVDRGI  Q:PSIVFLG  D
 . S PSIVDRG0=$G(DRG("AD",PSIVDRGI))
 . I $P(PSIVDRG0,U,4)="See Comments" S PSIVFLG=1
 Q PSIVFLG
GTSCRN(PSIVX) ;Set DIC("S") if MD OE or matching drug has already been selected.
 D:"?"[PSIVX HOLDHDR^PSJOE
 S X=PSIVX
 K DA,DIC S DIC=FIL,DIC("S")=$$IVDRGSC^PSIVUTL
 I $E(PSIVAC)'="P",($P(P("OT"),U)="F") S X(1)=" I $P(X(1),U,13)",DIC("S")=$G(DIC("S"))_$S(DRGT="AD":X(1),$E(PSIVAC)="O":X(1),1:"")
 Q
 ;
IT ; Input Transform for Strength/Volume.
 I X?1.N,$L(X)>20 S X="?"
 I X["?" W $C(7) S F1=53.15_$S(DRGT="AD":7,1:8),F2=1 D ENHLP^PSIVORC1 Q
 I DRGT="AD" K:X'?.6N0.1".".8N!('X) X I $D(X) S:(X<1)&($P(X,".")'=0) X=0_X S X=X_" "_$$ENU^PSIVUTL(DRG(1)) W "   ",X Q
 I $D(X) K:X=""!(X'?.N0.1".".N)!(X>9999)!(X<.01) X I $D(X) S:(X<1)&($P(X,".")'=0) X=0_X S X=X_" ML" W "   ",X
 W:'$D(X) $C(7),"??"
 Q
 ;
ORDERCHK(DFN,ON,X) ; Do order check
 ;* If X is define, include the DRG(X) to the order check
 ;This module is no longer used as of PSJ*5*181
 Q
 I X M:$D(DRG) DRGOC(ON)=DRG
 N TMPDRG,X,XX,Y,PSIVNEW,PSGDRG,PSGDRGN,PSJDD,PSGP
 D SAVEDRG(.TMPDRG,.DRG) ;Store DRG array in TMPDRG array
 S PSIVNEW=1,PSGDRGN=$P($G(DRGTMP),U,2)
 S (PSJDD,PSGDRG)=$P(^PS(FIL,+DRGTMP,0),U,2),PSGP=DFN
 I FIL="52.6"  D ENDDC^PSGSICHK(DFN,PSGDRG)
 I FIL="52.7" D
 . D EN^PSOORDRG(DFN,PSGDRG)
 . N INTERVEN,PSJIREQ,PSJRXREQ S Y=1,(PSJIREQ,PSJRXREQ,INTERVEN,X)=""
 . S DFN=PSGP K PSJPDRG
 . D IVSOL^PSGSICHK
 D SAVEDRG(.DRG,.TMPDRG) ;Restore DRG array from TMPDRG array
 D ENSTOP^PSIVCAL
 Q
SAVEDRG(NEW,OLD)   ;Store/restore DRG array.
 K NEW
 S:$G(OLD) NEW=OLD
 F X=0:0 S X=$O(OLD(X)) Q:'X  S NEW(X)=OLD(X)
 F XX="AD","SOL" D
 . I $D(OLD(XX,0))#10=1 S NEW(XX,0)=OLD(XX,0)
 . F X=0:0 S X=$O(OLD(XX,X)) Q:'X  S NEW(XX,X)=OLD(XX,X)
 Q
 ;
CHK ; Check if drug is already part of order
 N DDONE,I,TDRG,TDRGP,J F TDRG=0:0 S TDRG=$O(DRG(DRGT,TDRG)) Q:'TDRG!$G(DDONE)  D
 .I $$UPPER^VALM1($E($P(DRG(DRGT,+TDRG),U,2),1,$L(X)))=$$UPPER^VALM1(X) W $P($$UPPER^VALM1($P(DRG(DRGT,+TDRG),U,2)),$$UPPER^VALM1(X),2) D ASKCHK Q
 .S TDRGP=$P(DRG(DRGT,TDRG),U) F J=0:0 S J=$O(^PS(FIL,TDRGP,3,J)) Q:'J!$G(DDONE)  I $$UPPER^VALM1($E($P(^PS(FIL,TDRGP,3,J,0),U),1,$L(X)))=$$UPPER^VALM1(X) D  D ASKCHK Q
 ..W $P($$UPPER^VALM1($P(^PS(FIL,TDRGP,3,J,0),U)),$$UPPER^VALM1(X),2)," ",$P(DRG(DRGT,TDRG),U,2)
 Q
 ;
ASKCHK ; Do you want a drug that was previously selected.
 S I=DRG(DRGT,TDRG) W " ",$S($P(I,U,4):" ("_$P(I,U,4)_")",1:""),!,"...OK" S %=1 D YN^DICN
 I %=1 S X="",DRGI=TDRG,(DDONE,PSIVOLD)=1 D SETDRG Q
 W !,X
 Q
 ;
DEL ;
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN S X="" I %'=1 W "  <NOTHING DELETED>"
 Q
GTADSOL ;Prompt for an ad/sol if there were multiple ad/sol matched to an OI
 ;PSIVOI array is defined in GTIVDRG^PSIVORC2
 N DIR,ND,X,Y
 S DIR(0)="LA^1:"_+PSIVOI("DILIST",0)
 S DIR("?")="Please select "_$S(PSIVOI="AD":"an Additive or Quick Code",1:"a Solution")_" from the list"
 F X=0:0 S X=$O(PSIVOI("DILIST",X)) Q:'X  D
 . S DIR("A",X)="  "_X_"  "_$S($P(PSIVOI("DILIST",X,0),U,4)="QC":"  - "_$P(PSIVOI("DILIST",X,0),U,2)_" -",1:$P(PSIVOI("DILIST",X,0),U,2))
 . S DIR("A",X)=DIR("A",X)_$S(PSIVOI="SOL":"          "_$P(PSIVOI("DILIST",X,0),U,3),1:"")
 . S DIR("A",X)=DIR("A",X)_$S(PSIVOI="AD":"          Additive Strength: "_$S($P(PSIVOI("DILIST",X,0),U,4)'="":$P(PSIVOI("DILIST",X,0),U,4)_" "_$P(PSIVOI("DILIST",X,0),U,3),1:"N/A"),1:"")
 S DIR("A")="Select (1 - "_+PSIVOI("DILIST",0)_"): "
 D ^DIR
 I +Y D
 . N PSIVOIND S PSIVOIND=PSIVOI("DILIST",+Y,0)
 . W "  "_$P(PSIVOIND,U,2)_$S(PSIVOI="SOL":"  "_$P(PSIVOIND,U,3),1:"")
 . S ND=$G(^PS($S(PSIVOI="AD":52.6,1:52.7),+PSIVOIND,0))
 . S DRG(PSIVOI,0)=1
 . S DRG(PSIVOI,1)=+PSIVOIND_U_$P(ND,U)_U_$S(PSIVOI="SOL":$P(ND,U,3),1:"")_U_U_$P(ND,U,13)_U_$P(ND,U,11)
 . S DRGI=1 D SETDRG
 . I $P(PSIVOI("DILIST",+Y,0),U,4)="QC",DRGT="AD",$D(^PS(52.6,"C",$P(PSIVOI("DILIST",+Y,0),U,2),+PSIVOI("DILIST",+Y,0))) D   Q:$G(PSIVSTR)="QUICK CODE"!$G(PSGORQF)
 .. S (X,PSIVX)=$P(PSIVOI("DILIST",+Y,0),U,2),(PSJIVIEN,Y)=+PSIVOI("DILIST",+Y,0) D
 ... N PSJNF D NFIV^PSJDIN(52.6,+PSJIVIEN,.PSJNF) W PSJNF("NF")
 ... S DRGTMP=DRG(DRGT,1)
 ... I '$D(ON55) N ON55 S ON55=ON
 ... D ORDERCHK(DFN,ON55,1) I $G(PSGORQF) S X=U,DONE=1 Q
 ... D DINIV^PSJDIN(52.6,+DRGTMP)
 ... D ^PSIVQUI
 . I $P(PSIVOI("DILIST",+Y,0),U,4)'="QC" S DRGTMP=DRG(DRGT,1) D ORDERCHK(DFN,ON55,1) I $G(PSGORQF) S X=U,DONE=1 Q
 . I PSIVOI="AD" D
 .. N FIL S FIL=52.6 D DRG3
 K PSIVOI
 Q
