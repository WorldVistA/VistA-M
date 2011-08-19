PSJCOMV ;BIR/CML3-FINISH COMPLEX IV ORDERS ENTERED THROUGH OE/RR ;02 Feb 2001  12:20 PM
 ;;5.0; INPATIENT MEDICATIONS ;**110,127**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^%DTC is supported by DBIA 10000..
 ; Reference to ^DIR is supported by DBIA 10026.
 ;
 ;
IV ; Move IV data in local variables to ^TMP
 Q:'PSJCOM  Q:ON'["P"
 M ^TMP("PSJCOM",$J,+ON)=^PS(53.1,+ON)
 S P(17)="N"
 ;I PSIVCHG D NEWIV Q
 K ND S ND(0)=+ON_U_+P(6)_U_$S(+P("MR"):+P("MR"),1:"")_U_$P(P("OT"),U)_U_U_U_"C",$P(ND(0),U,9)=P(17),$P(ND(0),U,21)=$G(P(21))
 S $P(ND(0),U,14,16)=P("LOG")_U_DFN_U_P("LOG"),$P(ND(0),U,24,26)=$G(P("RES"))_U_$G(P("OLDON"))_U_$G(P("NEWON")) S ND(2)=P(9)_U_P(2)_U_U_P(3)_U_P(11)_U_P(15),$P(ND(4),U,7,9)=+P("CLRK")_U_U_P("REN")
 S ND(8)=P(4)_U_P(23)_U_P("SYRS")_U_P(5)_U_P(8)_"^^"_P(7),ND(9)=$S($L(P("REM")_P("OPI")):P("REM")_U_P("OPI"),1:"")
 S:+$G(P("CLIN")) ^TMP("PSJCOM",$J,+ON,"DSS")=P("CLIN")
 F X=0,2,4,8,9 S ^TMP("PSJCOM",$J,+ON,X)=ND(X)
 S:'+$G(^TMP("PSJCOM",$J,+ON,.2)) $P(^(.2),U,1,3)=+P("PD")_U_P("DO")_U_$G(P("NAT"))
 F DRGT="AD","SOL" D:$D(DRG(DRGT)) PTD531
 ;K DA,DIK S PSGS0Y=P(11),PSGS0XT=P(15),DA=+ON,DIK="^PS(53.1," D IX^DIK K DA,DIK,PSGS0Y,PSGS0XT,ND,^PS(53.1,"AS","P",DFN,+ON)
 ;K:P(17)="A" ^PS(53.1,"AS","N",DFN,+ON)
 I '+$P(PSJSYSP0,"^",9) D NEWNVAL^PSJCOM(ON,$S(+PSJSYSU=3:22005,1:22000))
 I +PSJSYSU=3,+$P(PSJSYSP0,U,9) D VFYIV Q
 I +PSJSYSU=1,+$P(PSJSYSP0,U,9),$G(PSJIRNF) D VFYIV
 I $G(PSIVENO),($P(^PS(53.1,+PSJORD,0),U,9)="N") D EN^VALM("PSJ LM IV INPT ACTIVE")
 Q
 ;
VFYIV ;
 Q:'PSJCOM
 I '$D(^TMP("PSJCOM",$J,+ON)) M ^TMP("PSJCOM",$J,+ON)=^PS(53.1,+ON) D
 . N CHILD,ORDER S ORDER=0 F  S ORDER=$O(^PS(53.1,"ACX",PSJCOM,ORDER)) Q:'ORDER  D
 .. I '$D(^TMP("PSJCOM",$J,+ORDER)) M ^TMP("PSJCOM",$J,+ORDER)=^PS(53.1,+ORDER)
 I ON["P" D
 . S P(17)="A"
 . S PSGORDP=ON ;Used in ACTLOG to update activity log in ^TMP
 . NEW PSGX S PSGX=$S($D(^TMP("PSJCOM2",$J,+ON,2.5)):$G(^TMP("PSJCOM2",$J,+ON,2.5)),1:$G(^TMP("PSJCOM2",$J,+ON,2.5))),PSGRSD=$P(PSGX,U),PSGRFD=$P(PSGX,U,3)
 . S:$D(^TMP("PSJCOM2",$J,+ON,0)) $P(^TMP("PSJCOM2",$J,+ON,0),"^",9)=P(17) S:'$D(^TMP("PSJCOM2",$J,+ON,0)) $P(^TMP("PSJCOM",$J,+ON,0),"^",9)=P(17) W "." ;D ^PSGOT
 D NEWNVAL^PSJCOM(ON,(PSJSYSU*10+22000)) W "."
 S VND4=$S('$D(^TMP("PSJCOM2",$J,+ON)):$G(^TMP("PSJCOM",$J,+ON,4)),1:$G(^TMP("PSJCOM2",$J,+ON,4)))
 S VND2P5=$$GETDUR^PSJLIVMD(DFN,ON,$E(ON,$L(ON)),1) I VND2P5]"" D
 . S:'$D(^TMP("PSJCOM2",$J,+ON)) ^TMP("PSJCOM",$J,+ON,2.5)="^"_VND2P5 Q
 . S:$D(^TMP("PSJCOM2",$J,+ON)) ^TMP("PSJCOM2",$J,+ON,2.5)="^"_VND2P5
 I $G(PSGRSD) D
 . S PSGRSD=$$ENDTC^PSGMI(PSGRSD) D NEWNVAL^PSJCOM(ON,6090,"Requested Start Date",PSGRSD)
 . S PSGRFD=$$ENDTC^PSGMI(PSGRFD) D NEWNVAL^PSJCOM(ON,6090,"Requested Stop Date",PSGRFD)
 K PSGRSD,PSGRFD,PSGALFN
 NEW X S X=0 I $G(PSGONF),(+$G(PSGODDD(1))'<+$G(PSGONF)) S X=1
 I +PSJSYSU=3,ON'["O",$S(X:0,'$P(VND4,"^",16):1,1:$P(VND4,"^",15)) ; D EN^PSGPEN(+ON)
 S:'$P(VND4,U,+PSJSYSU=3+9) $P(VND4,U,+PSJSYSU=3+9)=+$P(VND4,U,+PSJSYSU=3+9)
 S:$P(VND4,"^",15)&'$P(VND4,"^",16) $P(VND4,"^",15)="" S:$P(VND4,"^",18)&'$P(VND4,"^",19) $P(VND4,"^",18)="" S:$P(VND4,"^",22)&'$P(VND4,"^",23) $P(VND4,"^",22)="" S $P(VND4,"^",PSJSYSU,PSJSYSU+1)=DUZ_"^"_PSGDT,^TMP("PSJCOM",$J,+ON,4)=VND4
 S:'$D(^TMP("PSJCOM2",$J,+ON)) ^TMP("PSJCOM",$J,+ON,4)=VND4 S:$D(^TMP("PSJCOM2",$J,+ON)) ^TMP("PSJCOM2",$J,+ON,4)=VND4
 W:'$D(PSJSPEED) ! W !,"ORDER VERIFIED.",!
 I '$D(PSJSPEED) K DIR S DIR(0)="E" D ^DIR K DIR
 S VALMBCK="Q"
 S ^TMP("PSJCOM",$J)="A" S:$D(^TMP("PSJCOM2",$J,+ON)) ^TMP("PSJCOM2",$J)="A" Q
 ;
PTD531 ; Move drug data from local array into ^TMP
 K ^TMP("PSJCOM",$J,DRGT) S ^TMP("PSJCOM",$J,+ON,DRGT,0)=$S(DRGT="AD":"^53.157^0^0",1:"^53.158^0^0")
 F X=0:0 S X=$O(DRG(DRGT,X)) Q:'X  D
 .S X1=$P(DRG(DRGT,X),U),Y=^TMP("PSJCOM",$J,+ON,DRGT,0),$P(Y,U,3)=$P(Y,U,3)+1,DRG=$P(Y,U,3),$P(Y,U,4)=$P(Y,U,4)+1
 .S ^TMP("PSJCOM",$J,+ON,DRGT,0)=Y,Y=+X1_U_$P(DRG(DRGT,X),U,3) S:DRGT="AD" $P(Y,U,3)=$P(DRG(DRGT,X),U,4) S ^TMP("PSJCOM",$J,+ON,DRGT,+DRG,0)=Y
 Q
 ;
NEWIV ;Create new IV order in appropriate file format
 M ^TMP("PSJCOM2",$J,+ON)=^PS(53.1,+ON)
 S $P(^TMP("PSJCOM",$J,+ON,0),"^",9)="DE",P("OLDON")=+ON_"P",P("RES")="E"
 I +$P(PSJSYSP0,U,9) D NEWAIV Q
 S ND(0)=+ON_U_+P(6)_U_$S(+P("MR"):+P("MR"),1:"")_U_$P(P("OT"),U)_U_U_U_"C",$P(ND(0),U,9)=P(17),$P(ND(0),U,21)=$G(P(21))
 S $P(ND(0),U,14,16)=P("LOG")_U_DFN_U_P("LOG"),$P(ND(0),U,24,26)=$G(P("RES"))_U_$G(P("OLDON"))_U_$G(P("NEWON")) S ND(2)=P(9)_U_P(2)_U_U_P(3)_U_P(11)_U_P(15),$P(ND(4),U,7,9)=+P("CLRK")_U_U_P("REN")
 S ND(8)=P(4)_U_P(23)_U_P("SYRS")_U_P(5)_U_P(8)_"^^"_P(7),ND(9)=$S($L(P("REM")_P("OPI")):P("REM")_U_P("OPI"),1:"")
 S:+$G(P("CLIN")) ^TMP("PSJCOM2",$J,+ON,"DSS")=P("CLIN")
 F X=0,2,4,8,9 S ^TMP("PSJCOM2",$J,+ON,X)=ND(X)
 S:'+$G(^TMP("PSJCOM2",$J,+ON,.2)) $P(^(.2),U,1,3)=+P("PD")_U_P("DO")_U_$G(P("NAT"))
 I $G(P("PRNTON"))]"" S $P(^TMP("PSJCOM2",$J,+ON,.2),"^",8)=$G(P("PRNTON"))
 F DRGT="AD","SOL" D:$D(DRG(DRGT)) PTD5312
 ;K DA,DIK S PSGS0Y=P(11),PSGS0XT=P(15),DA=+ON,DIK="^PS(53.1," D IX^DIK K DA,DIK,PSGS0Y,PSGS0XT,ND,^PS(53.1,"AS","P",DFN,+ON)
 ;K:P(17)="A" ^PS(53.1,"AS","N",DFN,+ON)
 D EN^VALM("PSJ LM IV INPT ACTIVE")
 Q
 ;
PTD5312 ; Move drug data from local array into ^TMP
 K ^TMP("PSJCOM2",$J,DRGT) S ^TMP("PSJCOM2",$J,+ON,DRGT,0)=$S(DRGT="AD":"^53.157^0^0",1:"^53.158^0^0")
 F X=0:0 S X=$O(DRG(DRGT,X)) Q:'X  D
 .S X1=$P(DRG(DRGT,X),U),Y=^TMP("PSJCOM2",$J,+ON,DRGT,0),$P(Y,U,3)=$P(Y,U,3)+1,DRG=$P(Y,U,3),$P(Y,U,4)=$P(Y,U,4)+1
 .S ^TMP("PSJCOM2",$J,+ON,DRGT,0)=Y,Y=+X1_U_$P(DRG(DRGT,X),U,3) S:DRGT="AD" $P(Y,U,3)=$P(DRG(DRGT,X),U,4) S ^TMP("PSJCOM2",$J,+ON,DRGT,+DRG,0)=Y
 Q
 ;
NEWAIV ;Creates new IV order in the file 55 format
 N DA,DIK,ND,PSIVACT
 I '$D(PSGDT) D NOW^%DTC S PSGDT=+$E(%,1,12)
 S:'$D(P(21)) (P(21),P("21FLG"))="" S ND(0)=+ON,P(22)=$S(VAIN(4):+VAIN(4),1:.5) F X=2:1:23 I $D(P(X)) S $P(ND(0),U,X)=P(X)
 S ND(.3)=$G(P("INS"))
 S $P(ND(0),U,17)="A",ND(1)=P("REM"),ND(3)=P("OPI"),ND(.2)=$P($G(P("PD")),U)_U_$G(P("DO"))_U_+P("MR")_U_$G(P("PRY"))_U_$G(P("NAT"))_U_U_U_$G(P("PRNTON"))
 F X=0,1,3,.2,.3 S ^TMP("PSJCOM2",$J,+ON,X)=ND(X)
 S $P(^TMP("PSJCOM2",$J,+ON,2),U,1,4)=P("LOG")_U_+P("IVRM")_U_U_P("SYRS"),$P(^(2),U,8,10)=P("RES")_U_$G(P("FRES"))_U_$S($G(VAIN(4)):+VAIN(4),1:"")
 ;S X=^PS(55,DFN,0) I $P(X,"^",7)="" S $P(X,"^",7)=$P($P(P("LOG"),"^"),"."),$P(X,"^",8)="A",^(0)=X
 S $P(^TMP("PSJCOM2",$J,+ON,2),U,11)=+P("CLRK")
 S:+$G(P("CLIN")) ^TMP("PSJCOM2",$J,+ON,"DSS")=P("CLIN")
 S:+$G(P("NINIT")) ^TMP("PSJCOM2",$J,+ON,4)=P("NINIT")_U_P("NINITDT")
 I +PSJSYSU=3 S $P(^TMP("PSJCOM2",$J,+ON,4),"^",4)=DUZ,$P(^TMP("PSJCOM2",$J,+ON,4),"^",5)=PSGDT,$P(^TMP("PSJCOM2",$J,+ON,4),"^",9)=1
 I +PSJSYSU=1 S $P(^TMP("PSJCOM2",$J,+ON,4),"^",10)=1
 ;S:'$D(PSIVUP) PSIVUP=+$$GTPCI^PSIVUTL K ^PS(55,DFN,"IV",+ON55,5) I $O(^PS(53.45,PSIVUP,4,0)) S %X="^PS(53.45,"_PSIVUP_",4,",%Y="^PS(55,"_DFN_",""IV"","_+ON55_",5," D %XY^%RCR
 F DRGT="AD","SOL" D PUTD55
 ;K DA,DIK S DA(1)=DFN,DA=+ON55,DIK="^PS(55,"_DA(1)_",""IV"",",PSIVACT=1 D IX^DIK
 Q
 ;
PUTD55 ; Move drug data from local array into 55
 K ^TMP("PSJCOM2",$J,+ON,DRGT) S ^TMP("PSJCOM2",$J,+ON,DRGT,0)=$S(DRGT="AD":"^55.02PA",1:"^55.11IPA")
 F X=0:0 S X=$O(DRG(DRGT,X)) Q:'X  D
 .S Y=^TMP("PSJCOM2",$J,+ON,DRGT,0),$P(Y,U,3)=$P(Y,U,3)+1,DRG=$P(Y,U,3),$P(Y,U,4)=$P(Y,U,4)+1
 .S ^TMP("PSJCOM2",$J,+ON,DRGT,0)=Y,Y=$P(DRG(DRGT,X),U)_U_$P(DRG(DRGT,X),U,3) S:DRGT="AD" $P(Y,U,3)=$P(DRG(DRGT,X),U,4) S ^TMP("PSJCOM2",$J,+ON,DRGT,+DRG,0)=Y
 Q
