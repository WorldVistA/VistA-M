PSGOEEW ;BIR/CML3-SHOW FIELDS FOR EDIT ;15 DEC 97 / 1:29 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**7,58,111**;16 DEC 97
 ;
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ;
EN1 ;
 S PSGORD=^TMP("PSJON",$J,PSGOE2)
 ;
EN2 ;
 N %X,%Y,AT,DO,DRGI,FD,FL,FQC,NF,PRI,SD,SIG,ST,STD,STT,X,Y
 ;S NF=$S(PSGORD["P":0,PSGORD["A":0,PSGORD["O":0,1:1) I NF,$D(^PS(53.1,+PSGORD,0)),$P(^(0),"^",19),$D(^PS(55,PSGP,5,$P(^(0),"^",19))) S PSGORD=$P(^PS(53.1,+PSGORD,0),"^",19)_"A",NF=0
 ;naked references below refer to the full reference in the indirection @(PSGOEEWF_"0")
 S OD=$G(@(PSGOEEWF_"0)")),AT=$G(^(2)),PSGEB=$P($G(^(4)),"^",7),PSGOSI=$G(^(6)),DO=$G(^(.2)),PSGOINST=$G(^(.3)),PSGOPD=$P(DO,"^"),PSGODO=$P(DO,"^",2)
 S PSGOPR=$P(OD,"^",2),PSGOMR=$P(OD,"^",3),PSGOSM=$P(OD,"^",5),PSGOHSM=$P(OD,"^",6),(PSGOST,ST)=$P(OD,"^",7),(PSGSTAT,STT)=$P(OD,"^",9),PSGOMRN=$S('PSGOMR:"",1:$P($G(^PS(51.2,PSGOMR,0)),"^")) S:PSGOMRN="" PSGOMRN=PSGOMR
 S PSGLI=$P(OD,U,16),PSGNEDFD=$P($$GTNEDFD^PSGOE7("U",PSGOPD),U),PSGOSCH=$P(AT,"^"),(PSGOSD,SD)=$P(AT,"^",2),(FD,PSGOFD)=$P(AT,"^",4),(FQC,PSGS0XT)=$P(AT,"^",6),(PSGOAT,PSGS0Y)=$P(AT,"^",5)
 ;I FQC="D",PSGOAT="" S PSGOAT=$E($P(SD,".",2)_"0000",1,4)
 S PRI=$S('PSGOPR:0,1:$P($G(^VA(200,PSGOPR,"PS")),"^",4)),DRGI=$S(PSGOPD'=+PSGOPD:0,1:+$G(^PSDRUG(+PSGOPD,"I"))) S:PRI PRI=DT'<PRI S:DRGI DRGI=DT'<DRGI
 S PDRG=PSGOPD,PSGOPDN=$S('PSGOPD:"",1:$$OINAME^PSJLMUTL(+PSGOPD)) S:PSGOPDN="" PSGOPDN=PSGOPD S PSGOPRN=$S('PSGOPR:"",1:$P($G(^VA(200,PSGOPR,0)),"^")) S:PSGOPRN="" PSGOPRN=PSGOPR ; I PSGOSI]"" S PSGOSI=$$ENSET^PSGSICHK(PSGOSI)
 S PSGEBN=$$ENNPN^PSGMI(PSGEB)
 S PSGSTAT=$S(STT="":"NOT FOUND",STT="RE":"REINSTATED",1:$P(STT_"^ACTIVE^DISCONTINUED^EXPIRED^HOLD^INCOMPLETE^NON-VERIFIED^PENDING^RENEWED^UNRELEASED","^",$F("ADEHINPRU",STT)))
 ;
SET ;
 S PSGOSTN=$$ENSTN^PSGMI(ST),(PSGOFDN,PSGOSDN)="" I SD S PSGOSDN=$$ENDD^PSGMI(SD)_"^"_$$ENDTC^PSGMI(SD)
 I FD S PSGOFDN=$$ENDD^PSGMI(FD)_"^"_$$ENDTC^PSGMI(FD)
 F X="PD","PDN","MR","MRN","ST","STN","SCH","SI","SD","SDN","FD","FDN","SM","HSM","PR","PRN","DO","AT" S @("PSG"_X)=@("PSGO"_X)
 K ^PS(53.45,PSJSYSP,1),^(2) S %X=PSGOEEWF_"3,",%Y="^PS(53.45,"_PSJSYSP_",1," D %XY^%RCR S %X=PSGOEEWF_"1,",%Y="^PS(53.45,"_PSJSYSP_",2," D %XY^%RCR
 S $P(^PS(53.45,PSJSYSP,2,0),"^",2)="53.4502P"
 Q
 ;
ENW ;
 N D,ND,Q,QQ
 W:$Y @IOF,! W " Patient: ",$P(PSGP(0),"^")," (",PSJPPID,")",?55,"Ht(cm): " W:PSJPHT["_" PSJPHT W:PSJPHT'["_" $J(PSJPHT,6,2)
 W " ",PSJPHTD,!?4,"Ward: ",PSJPWDN,?55,"Wt(kg): " W:PSJPWT["_" PSJPWT W:PSJPWT'["_" $J(PSJPWT,6,2) W " ",PSJPWTD,!,"Room-Bed: ",PSJPRB
 W !,"Order Status: ",PSGSTAT,?37,"Entered By: ",PSGEBN,!,"--------------------------------------------------------------------------------"
 W !?1,$S($D(PSGEFN(1)):$E(" *",PSGEFN(1)+1)_"(1)",1:"    "),?16,"Drug: ",PSGPDN
 W !?1,$S($D(PSGEFN(2)):$E(" *",PSGEFN(2)+1)_"(2)",1:"    "),?6,"Dosage Ordered: ",PSGDO,?46,$S($D(PSGEFN(12)):$E(" *",PSGEFN(12)+1)_"(12)",1:"     "),"     Start: ",$P(PSGSDN,"^",2)
 W !?1,$S($D(PSGEFN(3)):$E(" *",PSGEFN(3)+1)_"(3)",1:"    "),?11,"Med Route: ",PSGMRN,?46,$S($D(PSGEFN(13)):$E(" *",PSGEFN(13)+1)_"(13)",1:"     "),"      Stop: ",$P(PSGFDN,"^",2)
 W !?1,$S($D(PSGEFN(4)):$E(" *",PSGEFN(4)+1)_"(4)",1:"    "),?7,"Schedule Type: ",PSGSTN,?46,$S($D(PSGEFN(14)):$E(" *",PSGEFN(14)+1)_"(14)",1:"     "),"  Self Med: ",$P("NO^YES","^",PSGSM+1) I PSGSM,PSGHSM W "  (HS)"
 W !?1,$S($D(PSGEFN(5)):$E(" *",PSGEFN(5)+1)_"(5)",1:"    "),?12,"Schedule: ",PSGSCH
 W !?1,$S($D(PSGEFN(6)):$E(" *",PSGEFN(6)+1)_"(6)",1:"    "),?9,"Admin Times: ",PSGAT
 W !?1,$S($D(PSGEFN(7)):$E(" *",PSGEFN(7)+1)_"(7)",1:"    "),?12,"Provider: ",PSGPRN
 W !?1,$S($D(PSGEFN(8)):$E(" *",PSGEFN(8)+1)_"(8)",1:"    ")," Special Instructions: " I PSGSI]"" F Q=1:1:$L(PSGSI," ") S QQ=$P(PSGSI," ",Q) W:$L(QQ)+$X>79 !?28 W QQ," "
 W !!?1,$S($D(PSGEFN(9)):$E(" *",PSGEFN(9)+1)_"(9)",1:"    ")," Dispense Drug",?48,"U/D",?60,"Inactive Date",!,"-------------------------------------------------------------------------------"
 F Q=0:0 S Q=$O(^PS(53.45,PSJSYSP,2,Q)) Q:'Q  S ND=$G(^(Q,0)) D
 .S D=$P(ND,"^"),PSGID=$P(ND,"^",3) I PSGID S PSGID=$$ENDTC^PSGMI(PSGID)
 .S D=$S(D="":"NOT FOUND",'$D(^PSDRUG(D,0)):D,$P(^(0),"^")]"":$P(^(0),"^"),1:D_";PSDRUG(") W !?6,D,?48,$S($P(ND,"^",2):$P(ND,"^",2),1:1) W:PSGID ?60,PSGID
 W !!,$S($D(PSGEFN(10)):$E(" *",PSGEFN(10)+1)_"(10)",1:"     ")," Comments:" F Q=0:0 S Q=$O(^PS(53.45,PSJSYSP,1,Q)) Q:'Q  S Y=" "_$G(^(Q,0)) F Y1=2:1 S Y2=$P(Y," ",Y1) Q:Y2=""  W:$L(Y2)+$X>79 !?2 W " ",Y2
 ;W !!,$S($D(PSGEFN(11)):$E(" *",PSGEFN(11)+1)_"(11)",1:"     ")," Provider Comments:" F Q=0:0 S Q=$O(^PS(53.45,PSJSYSP,4,Q)) Q:'Q  W !?2,$G(^(Q,0))
 W !!,$S($D(PSGEFN(11)):$E(" *",PSGEFN(11)+1)_"(11)",1:"     ")," Provider Comments:"
 I $G(PSGORD) D
 .I $D(^PS(53.1,+PSGORD,12,1)) F Q=0:0 S Q=$O(^PS(53.1,+PSGORD,12,Q)) Q:'Q  W !?2,$G(^(Q,0)) Q
 .I $D(^PS(53.1,+PSGORD,6)) W !?2,$G(^(6))
 K Q,Y,Y1,Y2
 Q
 ;
ENKILL ;
 K PSGAT,PSGEB,PSGFD,PSGHSM,PSGNEFD,PSGNESD,PSGOEEF,PSGOEER,PSGOFD,PSGOHSM,PSGOMR,PSGOMRN,PSGOPD,PSGOPDN,PSGOPR,PSGOSCH,PSGOSD,PSGOSM,PSGOST,PSGPD,PSGPDN,PSGPR,PSGSD,PSGSM Q
HILIGHT ; 
 ;         
5 ;;3,46,34
7 ;;4,7,45
8 ;;8,5,80
10 ;;2,46,34
25 ;;3,46,34
26 ;;6,12,56
39 ;;6,9,71
40 ;;
66 ;;9,5,80
101 ;;1,6,74
109 ;;2,6,40
