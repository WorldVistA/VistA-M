PSIVUTL1 ;BIR/MLM-IV UTILITIES ; 2/2/09 9:17am
 ;;5.0; INPATIENT MEDICATIONS ;**58,81,111,134,218**;16 DEC 97;Build 2
 ;
 ; Reference to ^PS(50.7 is supported by DBIA 2180
 ; Reference to ^PS(51.2 is supported by DBIA 2178
 ; Reference to ^PS(52.6 is supported by DBIA 1231
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191
 ;
DRGSC(Y,PSJSCT) ; Called to set DIC("S") when selecting orderable item.
 N OK,ND,NDU,NDI S OK=0 ;* I '$D(^PSDRUG("AP",+Y)) K PSJSCT Q 0
 S ND=$G(^PS(50.7,+Y,0))
 I $P(ND,U,3) S OK=$S('$P(ND,U,4):1,$P(ND,U,4)>DT:1,1:0)
 Q OK
 ;
IVDRGSC(Y) ; Set DIC("S") for IV additive/solution selection.
 ; Naked reference below refers to full reference in Y, which is either ^PS(52.6, or ^PS(52.7
 N Y S Y="S X(1)=$G(^(0)),X(2)=$G(^(""I"")) I $S('X(2):1,X(2)>DT:1,1:0),$D(^PSDRUG(+$P(X(1),U,2),0)) S X(2)=$G(^(""I"")) I $S('X(2):1,X(2)>DT:1,1:0)"
 Q Y
 ;
ENU(Y) ;Get IV additive strength.
 N X S X=$P(^PS(52.6,+Y,0),U,3),Y=$$CODES^PSIVUTL(X,52.6,2)
 Q Y
 ;
CODES(X,Y) ; Get name from code.
 S Y=$P($P(";"_$P(Y,U,3),";"_X_":",2),";")
 Q Y
 ;
GTPCI(Y) ; Set up "work" area for provider comments.
 N DIC,DINUM,DLAYGO,X S DIC="^PS(53.45,",DIC(0)="LNZ",DLAYGO=53.45,(DINUM,X)=+DUZ D ^DIC
 Q Y
 ;
WDTE(Y) ; Format and print date.
 I 'Y S Y="******"
 E  X ^DD("DD") S Y=$P(Y,"@")_" "_$P($P(Y,"@",2),":",1,2)
 Q Y
GTOT(DFN,ON) ; Get order type for display.
 N DRGT,DRGI,Y
 S X=$P($G(^PS(55,DFN,"IV",ON,0)),U,4)
 S Y=$S(X="A":"F",X="H":"H",1:"I")
 I Y="F" F DRGT="AD","SOL" F DRGI=0:0 S DRGI=$O(^PS(55,DFN,"IV",+ON,DRGT,DRGI)) Q:'DRGI  I '$P($G(^PS(55,DFN,"IV",+ON,DRGT,DRGI)),U,5) S Y="I" Q
 Q Y
 ;
PIV(ON) ; Display IV orders.
 N DRG,ON55,P,PSJORIFN,TYP,X,Y S TYP="?" I ON["V" D
 .S Y=$G(^PS(55,DFN,"IV",+ON,0)) F X=2,3,4,5,8,9,17,23 S P(X)=$P(Y,U,X)
 .S TYP=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I TYP'="O" S TYP="C"
 .S ON55=ON,P("OT")=$S(P(4)="A":"F",P(4)="H":"H",1:"I") D GTDRG^PSIVORFB,GTOT^PSIVUTL(P(4))
 I ON'["V" S (P(2),P(3))="",P(17)=$P($G(^PS(53.1,+ON,0)),U,9),Y=$G(^(8)),P(4)=$P(Y,U),P(8)=$P(Y,U,5),P(9)=$P($G(^(2)),U) D GTDRG^PSIVORFA,GTOT^PSIVUTL(P(4)) I $E(P("OT"))="I"  D  Q
 .S P("PD")=$P($$DRUGNAME^PSJLMUTL(PSGP,ON),"^"),P("DO")=$S($P(DN,"^",2)=.2:$P($G(^PS(55,PSGP,5,+PSJO,.2)),"^",2),1:$G(^PS(55,PSGP,5,+PSJO,.3))),P("DO")=$P(P("DO"),"^")
 .S Y=$G(^PS(53.1,+ON,.2)),P("MR")=$P($G(^PS(53.1,+ON,0)),U,3)_U_$P($G(^PS(51.2,+$P($G(^PS(53.1,+ON,0)),U,3),0)),U,3)
 .W ?9,P("PD") D PIV1 W !?11,"Give: ",P("DO")," ",$P(P("MR"),U,2)," ",$S(P(9)]"":P(9),1:P(8))
 S DRG=0 F  S DRG=$O(DRG("AD",DRG)) Q:'DRG  D PIVAD
SOL ;
 NEW NAME
 S DRG=0 F  S DRG=$O(DRG("SOL",DRG)) Q:'DRG  D
 . D NAME(DRG("SOL",DRG),39,.NAME,0)
 . W ! W:DRG=1 ?9,"in "
 . F X=0:0 S X=$O(NAME(X)) Q:'X  W ?12 W NAME(X) I X=1,DRG=1,'$D(DRG("AD",1)) D PIV1
 Q
PIVAD ; Print IV Additives.
 NEW NAME
 D NAME(DRG("AD",DRG),39,.NAME,1)
 F X=0:0 S X=$O(NAME(X)) Q:'X  W:DRG'=1 ! W ?9,NAME(X) I X=1,DRG=1 D PIV1
 Q
 ;
PIV1 ; Print Sched type, start/stop dates, and status.
 F X=2,3 S P(X)=$E($$ENDTC^PSGMI(P(X)),1,$S($D(PSJEXTP):8,1:5))
 I '$D(PSJEXTP) W ?50,TYP,?53,P(2),?60,P(3),?67,P(17) Q
 W ?50,TYP,?53,P(2),?63,P(3),?73,P(17)
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
NAME(X,L,NAME,AD)        ; Format Additive display.
 ;INPUT : X=DRG("AD",DRG)  L=Display length   AD=for Addtive(1/0)
 ;OUTPUT: AD(X)  if X=2 that means there is a second line to display
 K NAME
 NEW Y S Y=$P(X,U,3) S:(AD&$P(X,U,4)) Y=Y_" ("_$P(X,U,4)_")"
 S:'AD Y=Y_" "_$S(P(4)="P"!($G(P(23))="P")!$G(P(5)):P(9),1:$P(P(8),"@"))
 I ($L($P(X,U,2))+$L(Y)+1)>L S NAME(1)=$P(X,U,2),NAME(2)="   "_Y Q
 S NAME(1)=$P(X,U,2)_" "_Y
 Q
 ;
CNVTOM(RATE,TVOL) ; Convert volume to minutes
 ; Input:
 ;   RATE - Infusion Rate
 ;   TVOL - Volume being infused, EX: m100 (100 Milliliters) or l5 (5 Liters)
 ; Output:
 ;   MINS - Minutes required to infuse volume
 N DAYS,ML,MLSHR
 ; Get rate in terms of mils per hour
 I 'RATE Q 0
 I RATE<1 S RATE=1
 S TVOL=$S($E(TVOL)="m":$E(TVOL,2,9),$E(TVOL)="l":$E(TVOL,2,9)*1000,1:0) Q:'TVOL 0
 ; Find IV duration in minutes
 S MINS=(TVOL/RATE)*60
 Q MINS
 ;
GETMIN(LIM,DFN,PSJORD,DAYS) ;
 N F,DDLX
 I LIM!(LIM=0) Q LIM
 S F=$S(PSJORD["P":"^PS(53.1,+PSJORD,",PSJORD["V":"^PS(55,DFN,""IV"",+PSJORD,",1:"")
 N RATE S RATE=$S(PSJORD["P":+$P($G(@(F_"8)")),"^",5),PSJORD["V":+$P($G(@(F_"0)")),"^",8),1:0)
 I (",l,m,")[(","_$E(LIM)_",") D
 .I RATE D
 ..I RATE<1 S RATE=1
 ..S MIN=$$CNVTOM(RATE,LIM) I MIN S LIM=MIN
 .I 'RATE N SOL,SOLVOL,DOSVOL,DUR,STOP,OIX,X S (SOLVOL,DOSVOL)="" D
 ..S SOL=0 F  S SOL=$O(@(F_"""SOL"",SOL)")) Q:'SOL  D
 ...S SOLVOL=$P(@(F_"""SOL"",SOL,0)"),"^",2) I SOLVOL S DOSVOL=DOSVOL+SOLVOL
 ..;PSJ*5*218 Prevent divide by zero
 ..I $G(DOSVOL) S DDLX=$S($E(LIM)["l":(($E(LIM,2,99)*1000)/DOSVOL),1:($E(LIM,2,99)/DOSVOL))_"L"
 I (",a,")[(","_$E(LIM)_",") S DDLX=$E(LIM,2,99)_"L"
 I $G(DDLX)>0 D
 .N STOP,LASTD S DAYS="",STOP=""
 .S OIX=$P($G(@(F_".2)")),"^") S:(DDLX<1) DDLX="1L" S LASTD=$$DOSES^PSIVCAL(DDLX,.P)
 .I LASTD,$G(P(2)) S DAYS=$$FMDIFF^XLFDT(LASTD,P(2),2) I DAYS>0 S DAYS=DAYS/86400
 .I DAYS>0 S LIM=DAYS*1440
 I (",h,d,")[(","_$E(LIM)_",") S LIM=$S($E(LIM)="d":(1440*$E(LIM,2,99)),1:(60*$E(LIM,2,99))) Q
 Q LIM
