PSIVORFA ;BIR/MLM - FILE/RETRIEVE ORDERS IN 53.1 ;Jun 17, 2020@15:41:25
 ;;5.0;INPATIENT MEDICATIONS;**4,7,18,28,50,71,58,91,80,110,111,134,225,267,275,279,259,399**;16 DEC 97;Build 64
 ;
 ; Reference to ^PS(51.1 supported by DBIA 2177.
 ; Reference to ^PS(51.2 supported by DBIA 2178.
 ; Reference to ^PS(52.7 supported by DBIA 2173.
 ; Reference to ^PS(52.6 supported by DBIA 1231.
 ;
GT531(DFN,ON,PSJAPI) ; Retrieve order data from 53.1 and place into local array
 ;
 ; PSJAPI - If being called from background job, PSJAPI=1.
 NEW PSGOES S PSGOES=1
 F X="CUM","LF","LFA","LF","PRNTON" S P(X)=""
 S Y=$G(^PS(53.1,+ON,0)),P(17)=$P(Y,U,9),P("LOG")=$P(Y,U,16),(P(21),P("21FLG"),PSJORIFN)=$P(Y,U,21)
 S P("RES")=$P(Y,U,24),P("OLDON")=$P(Y,U,25),P("NEWON")=$P(Y,U,26),P("FRES")=$P(Y,U,27)
 S P("MR")=$P(Y,U,3),P(6)=+$P(Y,U,2),Y=$G(^VA(200,+P(6),0)),$P(P(6),U,2)=$P(Y,U),Y=$G(^PS(51.2,+P("MR"),0)),$P(P("MR"),U,2)=$S($P(Y,U,3)]"":$P(Y,U,3),1:$P(Y,U))
 S Y=$G(^PS(53.1,+ON,.2)),P("PD")=$S(+Y:$P(Y,U)_U_$$OIDF^PSJLMUT1(+Y),1:""),P("DO")=$P(Y,U,2),P("NAT")=$P(Y,U,3),P("PRY")=$P(Y,U,4),(PSJCOM,P("PRNTON"))=$P(Y,U,8)
 S P("INS")=$G(^PS(53.1,+ON,.3)),P("IND")=$G(^PS(53.1,+ON,18)) ;*399-IND
 I $G(^PS(53.1,+ON,4))]"" S P("NINIT")=$P(^(4),U),P("NINITDT")=$P(^(4),U,2)
 NEW NAME S NAME=""
 I $D(^PS(53.1,+ON,1,1)) D DD^PSJLMUT1("^PS(53.1,+ON,",.NAME)
 S:$P(^PS(53.1,+ON,0),U,4)="U" P("INS")=P("INS")_$S(P("INS")]"":" of ",1:"")_NAME  ;Only display instructions for unit dose orders
 S P("APPT")=$G(^PS(53.1,+ON,"DSS")),P("CLIN")=$P(P("APPT"),"^"),P("APPT")=$P(P("APPT"),"^",2)
 S Y=$G(^PS(53.1,+ON,2)),P(9)=$P(Y,U),P(11)=$P(Y,U,5),P(15)=$S($P(Y,U,6)'="":$P(Y,U,6),$G(PSGS0XT)'="":PSGS0XT,$P($G(ZZND),"^",3)'="":$P(ZZND,"^",3),1:""),P(2)=$P(Y,U,2),P(3)=$P(Y,U,4)
 S Y=$G(^PS(53.1,+ON,4)),P("CLRK")=$P(Y,U,7)_U_$P($G(^VA(200,+$P(Y,U,7),0)),U),P("REN")=$P(Y,U,9),X=P(9)
 I $P($G(^PS(53.1,+ON,0)),U,7)="P",(P(9)'["PRN") S P(9)=P(9)_" PRN"
 K PSGST,XT
 ;PSJ*5*225 remove 1440 default
 I P(9)]"",P(9)'["PRN",(P(11)="") D  S P(15)=$S($G(XT)]""&'+$G(XT):XT,+$G(XT)>0:XT,$G(PSGS0XT):PSGS0XT,1:1440),P(11)=Y
 . I $O(^PS(51.1,"APPSJ",P(9),0)) D DIC^PSGORS0 Q
 . I '$O(^PS(51.1,"APPSJ",P(9),0)) N NOECH,PSGSCH S NOECH=1 D EN^PSIVSP
 S Y=$G(^PS(53.1,+ON,8)),P(4)=$P(Y,U),P(23)=$P(Y,U,2),P("SYRS")=$P(Y,U,3),P(5)=$P(Y,U,4),P(8)=$P(Y,U,5),P(7)=$P(Y,U,7),P("IVRM")=$P(Y,U,8)
 I ($G(^PS(53.1,+ON,17))?1.N) S P("NUMLBL")=$G(^(17))
 I '$G(P("NUMLBL")) S P("NUMLBL")=$P($G(P(8)),"@",2)
 N PSJABBIN S PSJABBIN=$P(P(8),"@") I PSJABBIN]"" D
 .Q:(P(8)?1"INFUSE OVER "1.N1" MINUTES")
 .D EXPINF^PSIVEDT1(.PSJABBIN,1) S P(8)=PSJABBIN_$S($G(P("NUMLBL"))?1.N:"@"_P("NUMLBL"),1:"")
 S P(4)=$S(P(4)'="":P(4),$G(PSIVTYPE):PSIVTYPE,1:"")
 S:'P("IVRM")&($D(PSIVSN)) P("IVRM")=+PSIVSN S Y=$G(^PS(59.5,+P("IVRM"),0)),$P(P("IVRM"),U,2)=$P(Y,U),Y=$G(^PS(53.1,+ON,9)),P("REM")=$P(Y,U),P("OPI")=$P(Y,U,2,3)
 S P("DTYP")=$S(P(4)="":0,P(4)="P"!(P(23)="P")!(P(5)):1,P(4)="H":2,1:3)
 S P("PACT")=$G(^PS(53.1,+ON,"A",1,0))
 D GTDRG,GTOT^PSIVUTL(P(4)) D:'$D(PSJLABEL) GTPC(ON)
 N ND2P5 S ND2P5=$G(^PS(53.1,+ON,2.5)) D
 .S P("DUR")=$P(ND2P5,"^",2)
 .S P("LIMIT")=$P(ND2P5,"^",4)
 .S P("IVCAT")=$P(ND2P5,"^",5)
 N LONGOPI S LONGOPI=$$GETOPI^PSJBCMA5(DFN,ON,$S($G(PSJAPI):1,1:""))
 Q
GTDRG ;
 K DRG F X="AD","SOL" S FIL=$S(X="AD":52.6,1:52.7) F Y=0:0 S Y=$O(^PS(53.1,+ON,X,Y)) Q:'Y  D
 .S (DRGI,DRG(X,0))=$G(DRG(X,0))+1,DRG=$G(^PS(53.1,+ON,X,Y,0)),ND=$G(^PS(FIL,+DRG,0)),DRGN=$P(ND,U),DRG(X,+DRGI)=+DRG_U_$P(ND,U)_U_$P(DRG,U,2)_U_$P(DRG,U,3)_U_$P(ND,U,13)_U_$P(ND,U,11)
 Q
 ;
GTPC(ON) ; Retrieve Provider Comments and create "scratch" fields to edit
 Q
 ;
PUT531 ; Move data in local variables to 53.1
 S:'$D(P(9)) P(9)=$G(PSGSCH)
 S ND(0)=+ON_U_+P(6)_U_$S(+P("MR"):+P("MR"),1:"")_U_$P(P("OT"),U)_U_U_U_"C",$P(ND(0),U,9)=P(17),$P(ND(0),U,21)=$G(P(21))
 S $P(ND(0),U,14,16)=P("LOG")_U_DFN_U_P("LOG"),$P(ND(0),U,24,26)=$G(P("RES"))_U_$G(P("OLDON"))_U_$G(P("NEWON"))
 S ND(2)=P(9)_U_P(2)_U_U_P(3)_U_P(11)_U_$S($G(P(15))'="":P(15),$G(PSGS0XT)'="":PSGS0XT,$P($G(ZZND),"^",3)'="":$P(ZZND,"^",3),1:""),$P(ND(4),U,7,9)=+P("CLRK")_U_U_P("REN")
 S ND(8)=P(4)_U_P(23)_U_P("SYRS")_U_P(5)_U_P(8)_"^^"_P(7)_"^"_+P("IVRM"),ND(9)=$S($L(P("REM")_P("OPI")):P("REM")_U_P("OPI"),1:"") S $P(ND(4),U,1,2)=$G(P("NINIT"))_U_$G(P("NINITDT"))
 S:+$G(P("CLIN")) $P(^PS(53.1,+ON,"DSS"),"^")=P("CLIN")
 S:+$G(P("APPT")) $P(^PS(53.1,+ON,"DSS"),"^",2)=P("APPT")
 S:$G(P("LIMIT"))]"" $P(^PS(53.1,+ON,2.5),"^",4)=P("LIMIT")
 I $G(PSJORD)["V"!($G(PSJORD)["P") I $G(^PS(53.1,+ON,2.5))="" N DUR S DUR=$$GETDUR^PSJLIVMD(DFN,+PSJORD,$S((PSJORD["P"):"P",1:"IV"),1) I DUR]"" D
 .I $G(IVLIMIT) S $P(^PS(53.1,+ON,2.5),"^",4)=DUR K IVLIMIT Q
 .S $P(^PS(53.1,+ON,2.5),"^",2)=DUR
 F X=0,2,4,8,9 S ^PS(53.1,+ON,X)=ND(X)
 I $G(P("NUMLBL"))?1.N!($G(P("NUMLBL"))="") S $P(^PS(53.1,+ON,17),"^")=$G(P("NUMLBL"))
 S PSIVCAT=$$IVCAT^PSJHLU(DFN,ON,.P) S:PSIVCAT]"" $P(^PS(53.1,+ON,2.5),"^",5)=PSIVCAT K PSIVCAT
 S:'+$G(^PS(53.1,+ON,.2)) $P(^(.2),U,1,3)=+P("PD")_U_P("DO")_U_$G(P("NAT"))
 F DRGT="AD","SOL" D:$D(DRG(DRGT)) PTD531
 K DA,DIK S PSGS0Y=P(11),PSGS0XT=P(15),DA=+ON,DIK="^PS(53.1," D IX^DIK K DA,DIK,PSGS0Y,PSGS0XT,ND,^PS(53.1,"AS","P",DFN,+ON)
 K:P(17)="A" ^PS(53.1,"AS","N",DFN,+ON)
 S:P(15)="D" $P(^PS(53.1,+ON,2),U,6)="D"
 S:$D(P("IND")) ^PS(53.1,+ON,18)=P("IND") ;*399-IND
 I $G(PSJINFIN) K PSJINFIN I $D(^PS(53.45,+$G(PSJSYSP),6)),'$D(^PS(53.1,+ON,"A")),'$D(^PS(53.1,+ON,16)) S PSJINFIN=2
 I $G(PSJSYSP) D
 .I '$D(^PS(53.45,+PSJSYSP,6)) I $G(PSJORD)["V"!($G(PSJORD)["P") I '$D(^PS(53.1,+ON,16)) N I S I=$$GETOPI^PSJBCMA5(DFN,PSJORD)
 .I $D(^PS(53.45,+PSJSYSP,6)) D FILEOPI^PSJBCMA5(DFN,ON)
 Q
 ;
UPD100 ; Update order data in file 100
 D:'$D(PSJIVORF) ORPARM^PSIVOREN Q:'PSJIVORF
 S PSJORL=$$ENORL^PSJUTL($G(VAIN(4))) D SET^PSIVORFE
 Q
 ;
PTD531 ; Move drug data from local array into 53.1
 K ^PS(53.1,+ON,DRGT) S ^PS(53.1,+ON,DRGT,0)=$S(DRGT="AD":"^53.157^0^0",1:"^53.158^0^0")
 F X=0:0 S X=$O(DRG(DRGT,X)) Q:'X  D
 .S X1=$P(DRG(DRGT,X),U),Y=^PS(53.1,+ON,DRGT,0),$P(Y,U,3)=$P(Y,U,3)+1,DRG=$P(Y,U,3),$P(Y,U,4)=$P(Y,U,4)+1
 .S ^PS(53.1,+ON,DRGT,0)=Y,Y=+X1_U_$P(DRG(DRGT,X),U,3) S:DRGT="AD" $P(Y,U,3)=$P(DRG(DRGT,X),U,4) S ^PS(53.1,+ON,DRGT,+DRG,0)=Y
 Q
