PSGOU ;BIR/CML3,MV-PROFILE UTILITIES ;19 SEP 96 / 3:59 PM
 ;;5.0; INPATIENT MEDICATIONS ;**34,110,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(51.1 is supported by DBIA# 2177
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;
ECHK ;
 D NOW^%DTC N PSGDT S PSGDT=% ;***Store PSGDT with seconds.
 S C="A",ON=O_"U" G:SD>PSGDT DS S ND=$G(^PS(55,PSGP,5,O,0)) G:$S($P(ND,"^",9)="":1,1:"DE"'[$P(ND,"^",9)) DS S ND4=$G(^(4))
 I ST'="O",SD'<PSGODT,$P(ND,"^",9)="E",$P(ND4,"^",16) G DS
 I ST="O",$P(ND,"^",9)'["D",$S('$P(ND4,"^",UDU):1,SD<PSGODT:0,1:$P(ND4,"^",16)) G DS
 I PSGOL="S",(SD>$P($G(PSJDCEXP),U,2)) S C="DF" G DS
 Q:PSGOL="S"  S C="O"
 ;
DS ;
 NEW DRUGNAME D DRGDISP^PSJLMUT1(PSGP,+O_"U",80,0,.DRUGNAME,1) S DRG=DRUGNAME(1)
 ;
SET ;
 I ON["P",$G(P("PRNTON"))]"",$G(PRNTON)=+P("PRNTON") Q
 I ON["P",$G(P("PRNTON"))]"" S PRNTON=+P("PRNTON"),ON=+P("PRNTON")
 S ^TMP("PSG",$J,C,ST,DRG_"^"_ON)=$G(NF)
 Q
 ;
ENS F S=0:0 R !!,"Sort by DATE or MEDICATION:  M// ",PSGOS:DTIME D SCHK Q:CHK
 Q
 ;
ENL ;
 F  W !!,"SHORT, LONG, or NO Profile?  ",$S('$D(PSJPDD):"SHORT",'PSJPDD:"SHORT",1:"LONG"),"// " R PSGOL:DTIME W:'$T $C(7) S:'$T PSGOL="^" Q:PSGOL="^"  D LCHK Q:"^SLN"[PSGOL&($L(PSGOL)=1)
 Q
 ;
SCHK ;
 I '$T!(PSGOS["^") S PSGOS="^",CHK=1 Q
 S CHK=0 D:PSGOS["?" SM Q:PSGOS["?"  I PSGOS="" S PSGOS="M",CHK=1 W "MEDICATION" Q
 F X="DATE","MEDICATION" I $P(X,PSGOS)="" W $P(X,PSGOS,2) S PSGOS=$E(PSGOS),CHK=1 Q
 W:'CHK $C(7),"  ??" Q
 ;
SM W !!?3,"Enter 'MEDICATION' (or 'M', or press the RETURN key to have this patient's   orders shown alphabetically by drug name.  Enter 'DATE' (or 'D') to have this   patient's orders shown by start date (the newest orders showing first)."
 W "  Enter  a '^' to not show this patient's orders." Q
 ;
LCHK ;
 I PSGOL?1."?" D LM Q
 I PSGOL="" S PSGOL=$S('$D(PSJPDD):"S",'PSJPDD:"S",1:"L") W $S('$D(PSJPDD):"  SHORT",'PSJPDD:"  SHORT",1:"  LONG") Q
 I PSGOL?.E1L.E F Q=1:1:$L(PSGOL) I $E(PSGOL,Q)?1L S PSGOL=$E(PSGOL,1,Q-1)_$C($A(PSGOL,Q)-32)_$E(PSGOL,Q+1,$L(PSGOL))
 F X="NO PROFILE","LONG","SHORT" I $P(X,PSGOL)="" W $P(X,PSGOL,2) S PSGOL=$E(PSGOL) Q
 W:'$T $C(7),"  ??" Q
 ;
LM W !!?3,"Enter 'SHORT' (or 'S', or press the RETURN key) to exclude this patient's",!,"discontinued and expired orders in the following profile.  Enter 'LONG' (or 'L') to include those orders."
 W "  Enter 'NO' (or 'N') to bypass the profile com-",!,"pletely.  Enter '^' if you wish to go no further with this patient." Q
 ;
ENU ; update status field to reflect expired orders, if necessary
 W !!,"...a few moments, I have some updating to do..."
ENUNM ;
 D NOW^%DTC S PSGDT=%
 S PSJDCEXP=$$RECDCEXP^PSJP()
 F PSGO2=+PSJPAD:0 S PSGO2=$O(^PS(55,PSGP,5,"AUS",PSGO2)) Q:'PSGO2  Q:PSGO2>PSGDT  F PSGO3=0:0 S PSGO3=$O(^PS(55,PSGP,5,"AUS",PSGO2,PSGO3)) Q:'PSGO3  S PSGO4=$G(^PS(55,PSGP,5,PSGO3,0)) D
 .I PSGO4]"",$S($E($G(PSGALO),1,2)="10":"AHR"[$E($P(PSGO4,"^",9)),1:"AR"[$E($P(PSGO4,"^",9))) D ENUH
 K PSGO1,PSGO2,PSGO3,PSGO4,UD Q
 ;
ENGORD ; get and sort orders
 D NOW^%DTC S PSGDT=%,X1=$P(%,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1),HDT=$$ENDTC^PSGMI(PSGDT),UDU=$S($P(PSJSYSU,";",3)>1:3,1:1) K ^TMP("PSG",$J)
 W:'$D(PSGPR) !!,"...a few moments, please..." D ENUNM
 F ST="C","O","OC","P","R" F SD=+PSJPAD:0 S SD=$O(^PS(55,PSGP,5,"AU",ST,SD)) Q:'SD  F O=0:0 S O=$O(^PS(55,PSGP,5,"AU",ST,SD,O)) Q:'O  D ECHK
 Q:$D(PSGONNV)
 NEW DRUGNAME
 N PRNTON F SD="I","N" S (PRNTON,O)=0 F  S O=$O(^PS(53.1,"AS",SD,PSGP,O)) Q:'O  S ON=+O_"P",ND=$G(^PS(53.1,O,0)) I $P(ND,"^",4)="U" D
 . S ST=$P(ND,"^",7),P("PRNTON")=$P($G(^PS(53.1,O,.2)),"^",8) S:ST="" ST="z"
 . D DRGDISP^PSJLMUT1(PSGP,+O_"P",80,0,.DRUGNAME,1) S DRG=DRUGNAME(1)
 . S C=$S(P("PRNTON")]"":"BD",1:"BA") D SET
 Q:+PSJSYSU'=3  S SD="P",O=0
 N PRNTON F  S (PRNTON,O)=$O(^PS(53.1,"AS",SD,PSGP,O)) Q:'O  S ON=+O_"P",ND=$G(^PS(53.1,O,0)) I $P(ND,"^",4)="U" D
 . S ST=$P(ND,"^",7),P("PRNTON")=$P($G(^PS(53.1,O,.2)),"^",8) S:ST="" ST="z"
 . D DRGDISP^PSJLMUT1(PSGP,+O_"P",80,0,.DRUGNAME,1) S DRG=DRUGNAME(1)
 . S C=$$CKPC^PSGOU(PSGP,$P(ND,U,25),O)
 . I C="CB",$P($G(^PS(53.1,O,.2)),U,4)="S" S C="CA"
 . I P("PRNTON")]"" S C="CD"
 . D SET
 Q
 ;
MAE ; change status to expired
ENUH ;
 S $P(^PS(55,PSGP,5,PSGO3,0),"^",9)="E",ORIFN=$P(PSGO4,"^",21) I ORIFN D EN1^PSJHL2(PSGP,"SC",PSGO3_"U")
 Q
 ;
CKPC(DFN,OLDON,NEWON) ; Compare old provider comments to new for speed finish.
 N X,Y,Q,QQ,PSGOEEWF,PSJFLAG
 I $P($G(^PS(53.1,+NEWON,0)),U,24)'="R" Q "CB"
 S PSJFLAG=0,PSGOEEWF="^PS(55,"_DFN_","_$S(OLDON["V":"""IV""",1:5)_","_+OLDON_","
 S (Q,QQ)=0 F  S Q=$O(^PS(53.1,NEWON,12,Q)) Q:'Q  S QQ=Q,X=$G(^(Q,0)),Y=$G(@(PSGOEEWF_"12,"_Q_",0)")) I X'=Y S PSJFLAG=1 Q
 I PSJFLAG!$O(@(PSGOEEWF_"12,"_QQ_")")) Q "CB"
 S (Q,QQ)=0 F  S Q=$O(@(PSGOEEWF_"12,"_Q_")")) Q:'Q  S QQ=Q,X=$G(^(Q,0)),Y=$G(^PS(53.1,NEWON,12,Q,0)) I X'=Y S PSJFLAG=1 Q
 I PSJFLAG!$O(^PS(53.1,+NEWON,12,QQ)) Q "CB"
 Q "CC"
 ;
ENRNAT(OWD,NWD,SC,OAT) ; Determine admin times for renewal orders.
 ;OWD=ORIGINAL W, NWD=NEW WD LOCATION, SC=SCHEDULE, OAT=ORDER ADMIN TIMES
 N OWAT,SCP,X,Y
 S OOAT=OAT,SCP=+$O(^PS(51.1,"APPSJ",+SC,0)),WAT=$P($G(^PS(51.1,SCP,1,+$G(OWD),0)),U,2)
 F X="WAT","OAT" F Y=1:1 Q:$L(@X)>240!($P(@X,"-",Y)="")  S $P(@X,"-",Y)=$P(@X,"-",Y)_$E("0000",1,4-$L($P(@X,"-",Y)))
 I OAT'=WAT Q OOAT
 S X=$P($G(^PS(51.1,+SCP,1,NWD,0)),U,2) I X Q X
 Q OOAT
