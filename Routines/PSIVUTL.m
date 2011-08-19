PSIVUTL ;BIR/MLM-IV UTILITIES ;07 SEP 97 / 2:17 PM 
 ;;5.0;INPATIENT MEDICATIONS ;**69,58,81,85,110,133,181,263**;16 DEC 97;Build 51
 ;
 ; Reference to ^DD("DD" is supported by DBIA 10017.
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^DIC is supported by DBIA 10006.
 ; Reference to ^PS(51.1 is supported by DBIA 2177.
 ;
DRGSC(Y,PSJSCT) ; Called to set DIC("S") when selecting  Orderable Items.
 N OK,ND,NDU,NDI S OK=0
 S ND=$G(^PS(50.7,+Y,0))
 ;I $P(ND,U,3) S OK=$S('$P(ND,U,4):1,$P(ND,U,4)>DT:1,1:0)
 S OK=$S('$P(ND,U,4):1,$P(ND,U,4)>DT:1,1:0)
 Q OK
 ;
IVDRGSC(Y) ; Set DIC("S") for IV additive/solution selection.
 ; Naked reference below refers to full reference in Y, which is either ^PS(52.6, or ^PS(52.7
 N Y S Y="S X(1)=$G(^(0)),X(2)=$G(^(""I"")) I $S('X(2):1,X(2)>DT:1,1:0),$D(^PSDRUG(+$P(X(1),U,2),0)) S X(2)=$G(^(""I"")) I $S('+$P(X(1),U,11):0,'X(2):1,X(2)>DT:1,1:0)"
 Q Y
 ;
ENU(Y) ;Get IV additive strength.
 N X S X=$P(^PS(52.6,+Y,0),U,3),Y=$$CODES^PSIVUTL(X,52.6,2)
 Q Y
 ;
CODES(PSJCD,PSJF,PSJFLD) ; Get name from code. 
 ; PSJF = one of following files: ^PS(55, ^PS(53.1, ^PS(52.6
 D FIELD^DID(PSJF,PSJFLD,"","POINTER","PSJDD")
 S Y=$G(PSJDD("POINTER")) K PSJDD
 S Y=$P($P(";"_Y,";"_PSJCD_":",2),";")
 Q Y
 ;
CODES1(PSJCD,PSJF,PSJFLD)       ;Check to see if code is valid.
 ; PSJF = one of following files: ^PS(55, ^PS(53.1, ^PS(52.6
 D FIELD^DID(PSJF,PSJFLD,"","POINTER","PSJDD")
 I PSJDD("POINTER")'[PSJCD_":"  K PSJDD Q 0
 K PSJDD Q 1
 ;
CODES2(PSJF,PSJFLD)     ;Get field name
 ; PSJF = one of following files: ^PS(55, ^PS(53.1, ^PS(52.6
 D FIELD^DID(PSJF,PSJFLD,"","LABEL","PSJDD")
 Q PSJDD("LABEL")
 ;
GTPCI(Y) ; Set up "work" area for provider comments.
 N DIC,DINUM,DLAYGO,X S DIC="^PS(53.45,",DIC(0)="LNZ",DLAYGO=53.45,(DINUM,X)=+DUZ D ^DIC
 Q Y
 ;
WDTE(Y) ; Format and print date.
 I 'Y S Y="******"
 E  X ^DD("DD") S Y=$P(Y,"@")_" "_$P($P(Y,"@",2),":",1,2)
 Q Y
GTOT(Y) ; Get order type & protocol
 S P("OT")=$S(Y="A":"F",Y="H":"H",1:"I")
 I P("OT")="F" F DRGT="AD","SOL" F DRGI=0:0 S DRGI=$O(DRG(DRGT,DRGI)) Q:'DRGI  I '$P(DRG(DRGT,DRGI),U,5) S P("OT")="I" Q
 Q
 ;
PIV(ON) ; Display IV orders.
 N DRG,ON55,P,PSJORIFN,TYP,X,Y S TYP="?" I ON["V" D
 .S Y=$G(^PS(55,DFN,"IV",+ON,0)) F X=2,3,4,5,8,9,17,23,25 S P(X)=$P(Y,U,X)
 .S TYP=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I TYP'="O" S TYP="C"
 .S ON55=ON,P("OT")=$S(P(4)="A":"F",P(4)="H":"H",1:"I") D GTDRG^PSIVORFB,GTOT^PSIVUTL(P(4))
 .W $S($P($G(^PS(55,DFN,"IV",+ON,.2)),U,4)="D":" d",1:"  ")
 .S X=$G(^PS(55,DFN,"IV",+ON,4)) I +PSJSYSU,'+$P(X,U,$S(+PSJSYSU=3:4,1:++PSJSYSU)) W "->"
 I ON=+ON N O S O="" F  S O=$O(^PS(53.1,"ACX",ON,O)) Q:O=""  D
 . S (P(2),P(3))="",P(17)=$P($G(^PS(53.1,+O,0)),U,9),Y=$G(^(8)),P(4)=$P(Y,U),P(8)=$P(Y,U,5),P(9)=$P($G(^(2)),U) D GTDRG^PSIVORFA,GTOT^PSIVUTL(P(4)) D PIV(O_"P") W !
 I ON["P" S (P(2),P(3))="",P(17)=$P($G(^PS(53.1,+ON,0)),U,9),Y=$G(^(8)),P(4)=$P(Y,U),P(8)=$P(Y,U,5),P(9)=$P($G(^(2)),U) D GTDRG^PSIVORFA,GTOT^PSIVUTL(P(4)) I $E(P("OT"))="I" D  Q
 . NEW MARX,PSIVX D DRGDISP^PSJLMUT1(PSGP,+ON_"P",40,54,.MARX,0)
 . F PSIVX=0:0 S PSIVX=$O(MARX(PSIVX)) Q:'PSIVX  W @($S(PSIVX=1:"?9",1:"!?11")),MARX(PSIVX) D:PSIVX=1 PIV1
 NEW DRGX S DRGX=0 F  S DRGX=$O(DRG("AD",DRGX)) Q:'DRGX  D PIVAD
SOL ;
 NEW NAME
 S DRGX=0 F  S DRGX=$O(DRG("SOL",DRGX)) Q:'DRGX  D
 . D NAME(DRG("SOL",DRGX),39,.NAME,0)
 . W:($D(DRG("AD",1))!(DRGX>1)) ! W:DRGX=1 ?9,"in "
 . F X=0:0 S X=$O(NAME(X)) Q:'X  W ?12 W NAME(X) I X=1,DRGX=1,'$D(DRG("AD",1)) D PIV1
 Q
PIVAD ; Print IV Additives.
 NEW NAME,PSGX
 D NAME(DRG("AD",DRGX),39,.NAME,1)
 F PSGX=0:0 S PSGX=$O(NAME(PSGX)) Q:'PSGX  W:(DRGX'=1!(PSGX'=1)) ! W ?9,NAME(PSGX) I PSGX=1,DRGX=1 D PIV1
 Q
 ;
PIV1 ; Print Sched type, start/stop dates, and status.
 F X=2,3 S P(X)=$E($$ENDTC^PSGMI(P(X)),1,$S($D(PSJEXTP):8,1:5))
 I '$D(PSJEXTP) W ?50,TYP,?53,P(2),?60,P(3),?67,$S($G(P(25))]"":P(25),1:P(17)) Q
 W ?50,TYP,?53,P(2),?63,P(3),?73,$S($G(P(25))]"":P(25),1:P(17))
 Q
59 ; Validate the Infusion rate entered using IV Quick order code.
 N I F I=2,3,5,7,8,9,11,15,23 S P(I)=""
 S P(4)="A",P(8)=$P($G(^PS(57.1,PSJQO,1)),U,5)
 I $G(^PS(57.1,PSJQO,4,1,0)) S DRG("SOL",1)=^(0),DRG("SOL",0)=1
 I X["?" S F1=53.1,F2=59 D ENHLP^PSIVORC1 G 59
 I X]"" D ENI^PSIVSP S:$D(X) P(8)=X
 Q
WRTDRG(X,L)       ; Format and print drug name, strength and bottle no.
 N Y S Y=" "_$P(X,U,3) S:$P(X,U,4) Y=Y_" ("_$P(X,U,4)_")"
 Q $E($P(X,U,2),1,(L-$L(Y)))_Y
 ;
NAME(X,L,MARX,AD)        ; Format Additive display.
 ;INPUT : X=DRG("AD",DRG)  L=Display length   AD=for Additive(1/0)
 ;OUTPUT: AD(X)  if X=2 that means there is a second line to display
 N Y K MARX S Y=$P(X,U,3) S:(AD&($P(X,U,4)]"")) Y=Y_" ("_$P(X,U,4)_")"
 ;* S:'AD Y=Y_" "_$S(P(4)="P"!($G(P(23))="P")!$G(P(5)):P(9),1:$P(P(8),"@"))
 I 'AD!('$O(DRG("SOL",0))) D
 .I $G(PSJL)["  in" S Y=Y_" "_$S(P(4)="P"!($G(P(23))="P")!$G(P(5)):P(9),1:$P(P(8),"@")) Q
 .I $G(DRGX)]"",DRGX'>1 S Y=Y_"  "_$S(P(4)="P"!($G(P(23))="P")!$G(P(5)):P(9),1:$P(P(8),"@")) Q
 ;I ($L($P(X,U,2))+$L(Y)+1)>L S NAME(1)=$P(X,U,2),NAME(2)="   "_Y Q
 I ($L($P(X,U,2))+$L(Y)+1)>L D TXT^PSGMUTL($P(X,U,2)_" "_Y,L) S:AD MARX(2)="   "_MARX(2) Q
 S MARX(1)=$P(X,U,2)_" "_Y
 Q
 ;
INTERVAL(IVAR) ;
 N P,X,PSGOES M P=IVAR S X=$G(P(9)),PSGOES=1
 D EN^PSIVSP S IVAR(15)=$S($G(P(15)):P(15),1:1440)
 Q IVAR(15)
 ;
DOW(SCHED) ;
 Q:SCHED="" 0
 N P9,PSIVX,X S PSIVX=0 S P9=SCHED
 ; Use schedule validator
 S X=SCHED D DW^PSGS0 I $G(X)="" Q 0
 I +$O(^PS(51.1,"APPSJ",SCHED,0)) S PSIVX=1 S P9=$P(SCHED,"@") F X=1:1:$L(P9,"-") D  Q:'$G(PSIVX)
 . I '("MON,TUE,WED,THU,FRI,SAT,SUN"[$P(P9,"-",X)) S PSIVX=0 Q
 Q:PSIVX +PSIVX
 I '$D(^PS(51.1,"APPSJ",SCHED)) S PSIVX=1,P9=$P(SCHED,"@") F X=1:1:$L(P9,"-") D  Q:'$G(PSIVX)
 . I '(",MO,TU,WE,TH,FR,SA,SU,"[(","_$P(P9,"-",X)_",")) S PSIVX=0 Q
 Q +PSIVX
