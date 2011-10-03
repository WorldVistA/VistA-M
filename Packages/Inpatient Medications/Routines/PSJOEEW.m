PSJOEEW ;BIR/CML3-SHOW INPATIENT FIELDS FOR EDIT ;17 SEP 97 /  1:41 PM
 ;;5.0; INPATIENT MEDICATIONS ;**81**;16 DEC 97
 ;
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ; Reference to ^VA(200 is supported by DBIA 10060.
 ;
EN1 ;
 S PSGORD=^TMP("PSJON",$J,PSGOE2)
 ;
EN2 ;
 N %X,%Y,AT,DO,DRGI,FL,FQC,NF,OD,PRI,SIG,ST,STD,STT,X,Y K ^PS(53.45,PSJSYSP,1),^(2),^(4) I PSGORD["V" D EN3,SET Q
 S NF=$S(PSGORD["A":0,1:1) I NF,$D(^PS(53.1,+PSGORD,0)),$P(^(0),"^",19),$D(^PS(55,PSGP,5,$P(^(0),"^",19))) S PSGORD=$P(^PS(53.1,+PSGORD,0),"^",19)_"A",NF=0
 S Y="",PSGOEEWF="^PS("_$S(NF:"53.1,",1:"55,"_PSGP_",5,")_+PSGORD_","
 ; naked ref below refers to line above
 S OD=$G(@(PSGOEEWF_"0)")),AT=$G(^(2)),PSGEB=$P($G(^(4)),"^",7),PSGOSI=$P($G(^(6)),"^"),SIG=$G(^(6.5)),DO=$G(^(.2)),PSGOPD=$P(DO,"^"),PSGODO=$P(DO,"^",2)
 S PSGOPR=$$PRCHK^PSJORUT2(DUZ) S:'PSGOPR PSGOPR=$P(OD,U,2)
 S PSGOMR=$P(OD,"^",3),PSGOSM=$P(OD,"^",5),PSGOHSM=$P(OD,"^",6),(PSGOST,ST)=$P(OD,"^",7),(PSGSTAT,STT)=$P(OD,"^",9),PSGLID=$P(OD,"^",16)
 S PSGNEDFD=$P($$GTNEDFD^PSGOE7("UI",PSGOPD),U)
 S PSGOSCH=$P(AT,"^"),PSGOSD=$P(AT,"^",2),PSGOFD=$P(AT,"^",4),(FQC,PSGS0XT)=$P(AT,"^",6),PSGOAT=$P(AT,"^",5)
 I FQC="D",PSGOAT="" S PSGOAT=$E($P(STD,".",2)_"0000",1,4)
 S PRI=$S('PSGOPR:0,1:$P($G(^VA(200,PSGOPR,"PS")),"^",4)),DRGI=$S(PSGOPD'=+PSGOPD:0,1:+$G(^PSDRUG(+PSGOPD,"I"))) S:PRI PRI=DT'<PRI S:DRGI DRGI=DT'<DRGI
 S PSGSTAT=$S(STT="":"NOT FOUND",STT["D":"DISCONTINUED"_$S(STT["R":" (RENEWAL)",1:" (EDIT)"),STT="R":$S(NF:"RELEASED",1:"RENEWED"),STT="RE":"REINSTATED",1:STT)
 I STT=PSGSTAT S PSGSTAT=$P(STT_"^ACTIVE^EXPIRED^HOLD^INCOMPLETE^NON-VERIFIED^PENDING^UNRELEASED","^",$F("AEHINPU",STT))
 S %X=PSGOEEWF_"3,",%Y="^PS(53.45,"_PSJSYSP_",1," D %XY^%RCR S %X=PSGOEEWF_"1,",%Y="^PS(53.45,"_PSJSYSP_",2," D %XY^%RCR S %X=PSGOEEWF_"12,",%Y="^PS(53.45,"_PSJSYSP_",4," D %XY^%RCR
 S $P(^PS(53.45,PSJSYSP,2,0),"^",2)="53.4502P"
 ;
SET ;
 I $S($D(PSGOEF):0,1:PSGORD["U") S (PSGOFD,PSGOSD,PSGOST,ST)=""
 S PSGOSTN=$$ENSTN^PSGMI(ST),(PSGOFDN,PSGOSDN)="" I PSGOSD S PSGOSDN=$$ENDD^PSGMI(PSGOSD)_"^"_$$ENDTC^PSGMI(PSGOSD)
 I PSGOFD S PSGOFDN=$$ENDD^PSGMI(PSGOFD)_"^"_$$ENDTC^PSGMI(PSGOFD)
 S PSGOPDN=$S('PSGOPD:"",1:$P($G(^PS(50.7,PSGOPD,0)),"^")) S:PSGOPDN="" PSGOPDN=PSGOPD S PSGOPRN=$S('PSGOPR:"",1:$P($G(^VA(200,PSGOPR,0)),"^")) S:PSGOPRN="" PSGOPRN=PSGOPR
 S PSGLID=$$ENDTC^PSGMI(PSGLID),PSGEBN=$$ENNPN^PSGMI(PSGEB),PSGOMRN=$S('PSGOMR:"",1:$P($G(^PS(51.2,PSGOMR,0)),"^")) S:PSGOMRN="" PSGOMRN=PSGOMR
 F X="PD","PDN","MR","MRN","ST","STN","SCH","SI","SD","SDN","FD","FDN","SM","HSM","PR","PRN","DO","AT" S @("PSG"_X)=$G(@("PSGO"_X))
 Q
 ;
EN3 ;
 S PSGOEEWF="^PS(55,"_PSGP_",""IV"",",ND=$G(^PS(55,PSGP,"IV",+PSGORD,0)),ND2=$G(^(2)),ND6=$G(^(.2))
 S PSGOSD=$P(ND,"^",2),PSGOFD=$P(ND,"^",3),PSGOPR=$$PRCHK^PSJORUT2(DUZ)
 S:'PSGOPR PSGOPR=$P(ND,"^",6) S PSGOSCH=$P(ND,"^",9),(PSGOAT,PSGS0Y)=$P(ND,"^",11),PSGS0XT=$P(ND,"^",15),PSGSTAT=$$CODES^PSIVUTL($P(ND,U,17),55.01,100)
 S PSGLID=$P(ND2,"^"),PSGEB=$P(ND2,"^",3)
 S PSGOPD=$P(ND6,"^"),PSGODO=$P(ND6,"^",2),PSGOMR=$P(ND6,"^",3)
 S (PSGOST,PSGST,ST)=$S(PSGOSD=PSGOFD:"O",1:"C"),(PSGSM,PSGHSM,PSGNEDFD)="" S:PSGST="O" PSGS0XT="O"
 K ^PS(53.45,PSJSYSP,4) S %X=PSGOEEWF_+PSGORD_",5,",%Y="^PS(53.45,"_PSJSYSP_",4," D %XY^%RCR
 Q
 ;
ENW ;
 N D,ND,Q,QQ
 W:$Y @IOF,! W " Patient: ",$P(PSGP(0),"^")," (",PSJPPID,")",?55,"Ht(cm): " W:PSJPHT["_" PSJPHT W:PSJPHT'["_" $J(PSJPHT,6,2)
 W " ",PSJPHTD,!?4,"Ward: ",PSJPWDN,?55,"Wt(kg): " W:PSJPWT["_" PSJPWT W:PSJPWT'["_" $J(PSJPWT,6,2) W " ",PSJPWTD,!,"Room-Bed: ",PSJPRB
 W !?5,"Entered: ",PSGLID,"  By: ",PSGEBN,!,"Order Status: ",PSGSTAT,!,"--------------------------------------------------------------------------------"
 S Q=$G(PSJORUR) W !?1,$S(Q:"    ",$D(PSGEFN(1)):$E(" *",PSGEFN(1)+1)_"(1)",1:"    "),?19,"Drug: ",PSGPDN
 W !?1,$S(Q:"    ",$D(PSGEFN(2)):$E(" *",PSGEFN(2)+1)_"(2)",1:"    "),?9,"Dosage Ordered: ",PSGDO
 W !?1,$S(Q:"    ",$D(PSGEFN(3)):$E(" *",PSGEFN(3)+1)_"(3)",1:"    "),?14,"Med Route: ",PSGMRN
 W !?1,$S(Q:"    ",$D(PSGEFN(4)):$E(" *",PSGEFN(4)+1)_"(4)",1:"    "),?15,"Schedule: ",PSGSCH
 W !?1,$S(Q:"(1)",$D(PSGEFN(5)):$E(" *",PSGEFN(5)+1)_"(5)",1:"    "),?15,"Provider: ",PSGPRN
 W !!?1,$S(Q:"(2)",$D(PSGEFN(6)):$E(" *",PSGEFN(6)+1)_"(6)",1:"     ")," Provider Comments:" F Q=0:0 S Q=$O(^PS(53.45,PSJSYSP,4,Q)) Q:'Q  N Y,Y2 S Y=" "_$G(^(Q,0)) F KKA=2:1 S Y2=$P(Y," ",KKA) Q:Y2=""  W:$L(Y2)+$X>79 !?7 W " ",Y2
 K KKA
 Q
