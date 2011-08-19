PSIVORFE ;BIR/MLM-IV FLUID ORDER ENTRY FOR OE/RR FRONT DOOR. ;26 NOV 97 / 9:55 AM 
 ;;5.0; INPATIENT MEDICATIONS ;**58,81,110**;16 DEC 97
 ;
 ; Reference to ^VA(200 is supported by DBIA 10060.
 ;
EN ; Entry pt. to create new IV Fluid order.
 S PSJORNP=$G(ORNP) D PS^PSIVOREN Q:PSJORPF  F  D NEWORD Q:DONE
 D DONE^PSIVORA1
 Q
 ;
NEWORD ; Create new IV Fluid order.
 D SETUP S EDIT=58,PSIVOK="" D EDIT^PSIVEDT I '$D(DRG("SOL")) S DONE=1 Q
 ; Removed reference to tag 66 of PSIVEDT-backdoor Pharm Prov comments
 S EDIT="57^59",PSIVOK=58 D EDIT^PSIVEDT Q:DONE
 K DA,DIC,ON,P("OLDON") W !!,"...transcribing this order..." D ENGNN^PSGOETO S ON=DA D PUT531^PSIVORFA L -^PS(53.1,+ON) W !
 Q
 ;
GTFLDS ;Ask field no.s to be edited.
 N PSGEFN F X=1:1:$L(EDIT,U) S PSGEFN(X)=$P(EDIT,U,X)_U_$S($P(EDIT,U,X)=999:"Edit OE/RR Fields",1:$$CODES2^PSIVUTL(53.1,$P(EDIT,U,X)))
 S Y=$P($G(XQORNOD(0)),"=",2)
 S PSGEFN=1_":"_$L(EDIT,U),PSJDTYP=$E(PSIVAC,1) D:Y="" ENEFA^PSGON K PSJDTYP I '$G(Y) S:PSIVAC="OE" DONE=1 S PSJEDFLG=1 Q
 S X=EDIT,EDIT="" F X1=1:1:$L(Y,",") S:$P(X,U,$P(Y,",",X1)) $P(EDIT,"^",X1)=$P(X,U,$P(Y,",",X1))
 N PSIVRENW S PSIVRENW=1
 D EDIT^PSIVEDT
 K PSIVRENW
 Q
 ;
SET ; Set variables needed to create/update orders in the ORDERS file (100).
 Q
 ;*** NO LONGER NEEDED IN 5.0
 N DRGT,PLN,X K OREVENT,ORETURN,ORSTRT,ORSTOP,ORTX
 S ORL=$$ENORL^PSJUTL($G(VAIN(4)))
 S ORLOG=P("LOG"),ORSTRT=P(2),OREVENT=$S('P(3):"",1:P(3)_";E"),ORSTOP=P(3),ORNP=+P(6),P("OT")=$S(P(4)="A":"F",P(4)="H":"H",1:"I")
 D GTOT^PSIVUTL(P(4)) ;* S ORPCL=$P(P("OT"),U,2)
 ;* S Y=P(17),ORSTS=$S("AO"[Y:6,Y="E":7,Y="H":3,Y="D":1,Y="U":11,1:5),ORVP=DFN_";DPT(",ORPK=+ON_$S(ORSTS=5:"P",ORSTS=11:"P",1:"V")
SORTX ;Set up ORTX(.
 Q
 ;*** NO LONGER NEEDED IN 5.0
 I $E(P("OT"))="H" D
 .S ORTX(1)="* TPN * in ",PLN=2 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  S ORTX(PLN)=$S($P($G(DRG("SOL",X)),U,2)]"":$P(DRG("SOL",X),U,2),1:"*NF*"),PLN=PLN+1
 .S ORTX(PLN)=$S(P(8)]"":P(8),1:P(9)),PLN=PLN+1
 I $E(P("OT"))="F" D ORTXF
 I $E(P("OT"))="I" S ORTX(1)=$P(P("PD"),U,2),ORTX(2)="Give: "_$P(P("MR"),U,2)_" "_$S(P(9)]"":P(9),1:P(8)),PLN=3
 S ORTX(1)=$S($G(P("FRES"))="R":"RENEWED -",$G(P("RES"))="R":"RENEWAL -",1:"")_ORTX(1)
 ;I $D(^PS(53.45,+$G(PSIVUP),4)) F PC=0:0 S PC=$O(^PS(53.45,PSIVUP,4,PC)) Q:'PC  S ORTX(PLN)=$G(^PS(53.45,PSIVUP,4,PC,0)),PLN=PLN+1
 Q
 ;
ORTXF ; Set up ORTX( for Fluids.
 Q
 ;*** NO LONGER NEEDED IN 5.0
 N SOLF
 S PLN=1 F DRGT="AD","SOL" F DRGI=0:0 S DRGI=$O(DRG(DRGT,DRGI)) Q:'DRGI  D
 .S ORTX(PLN)=$S($P(DRG(DRGT,DRGI),U,2)="":"*NF*",1:$P(DRG(DRGT,DRGI),U,2)_" "_$P(DRG(DRGT,DRGI),U,3)),PLN=PLN+1 I DRGT="SOL",('$G(SOLF)) S ORTX(PLN-1)="in "_ORTX(PLN-1),SOLF=1
 S ORTX(PLN)=$S(P(8)]"":P(8),1:P(9)),PLN=PLN+1
 Q
 ;
SETUP ; Initialize variables.
 K DRG D NEWENT S DRGN="" F X=2,3,5,7,8,9,11,15,23,"AD","DO","IVRM","MR","NEWON","PC","PD","OLDON","OPI","REM","REN","SI","SOL","SYRS" S P(X)=""
 S PSJORSTS=11,P("OT")="F^",P("RES")="N",P(4)="A",P(17)="U",Y=$G(^VA(200,+PSJORNP,0)),P(6)=+PSJORNP_U_$P(Y,U)
 ;; S PSJORSTS=11,P("OT")="F^"_$O(^ORD(101,"B","PSJI OR PAT FLUID OE",0))_";ORD(101,",P("RES")="N",P(4)="A",P(17)="U",Y=$G(^VA(200,+PSJORNP,0)),P(6)=+PSJORNP_U_$P(Y,U)
 Q
 ;
NEWENT ; Get login date/entry code for new order
 S P("LOG")=$$DATE^PSJUTL2(),P("CLRK")=DUZ_U_$P($G(^VA(200,DUZ,0)),U)
 Q
