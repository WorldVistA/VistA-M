PSGVW ;BIR/CML3-EXPANDED VIEW OF AN ORDER ;17 SEP 97 /  1:41 PM
 ;;5.0; INPATIENT MEDICATIONS ;**50,58,85,80,104,110**;16 DEC 97
 ;
 ; Reference to ^PS(50.7 is supported by DBIA# 2180.
 ; Reference to ^PS(51.2 is supported by DBIA# 2178.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ES^ORX8 is supported by DBIA# 3632.
 ;
EN1 ;
 S PSGORD=^TMP("PSJON",$J,PSGOE2)
 ;
EN2 ;
 I PSGORD=+PSGORD N PSGO,PSGO1 S PSGO=PSGORD,PSGO1=0 F  S PSGO1=$O(^PS(53.1,"ACX",PSGO,PSGO1)) Q:'PSGO1  Q:$G(PSGOEA)["^"  S PSGORD=PSGO1_"P" D  S PSGORD=""
 . D EN21 K CONT D  Q:$G(PSGOEA)["^"
 .. W !!,"Press RETURN to continue or '^' to exit: " R CONT:DTIME W @IOF S:CONT["^" PSGOEA="^",PSGPR=1,PSJPR=1
 I PSGORD="" S PSGOEA="^" Q
EN21 ;
 K ^PS(53.45,PSJSYSP,2)
 N ESIG,PSJ21
 S NF=$S(PSGORD["P":1,PSGORD["N":1,1:0)
 S (FL,Y)="",$P(FL,"-",71)="",F="^PS("_$S(NF:"53.1,",1:"55,"_PSGP_",5,")_+PSGORD_","
 S PN=$G(PSGP(0)) S:PN="" PN=$P($G(^DPT(PSGP,0)),"^")
 ; the naked reference on the line below refers to the full reference created by indirect reference to F_ON, where F may refer to ^PS(53.1 or the IV or UD multiple ^PS(55
 S OD=$G(@(F_"0)")),STAT=$P(OD,U,9),PSJ21=$P(OD,U,21),PDRG=$G(^(.2)),INS=$G(^(.3)),AT=$G(^(2)),ND4=$G(^(4)),EB=$P(ND4,"^",7) S:'NF XU=$G(^(5)) S X=$P($G(^(6)),"^"),SIG=$G(^(6.5)),DO=$G(^(1,1,0))
 S PR=$P(OD,"^",2),MR=$P(OD,"^",3),SM=$P(OD,"^",5),HSM=$P(OD,"^",6),SCT=$S(PSGORD'["P":$P(OD,"^",7),1:""),ST=$P(OD,"^",9),(PSGLI,LID)=$P(OD,"^",16),OD=$P(OD,"^",14),DO=$P(PDRG,"^",2),ESIG=$P(PDRG,"^",3),PDRG=+PDRG
L S SCH=$P(AT,"^"),STD=$S(STAT'["P":$P(AT,"^",2),1:""),FD=$S(STAT'["P":$P(AT,"^",4),1:""),FQC=$P(AT,"^",6),AT=$P(AT,"^",5) I FQC="D",AT="" S AT=$E($P(STD,".",2)_"0000",1,4)
 S PRI=$S('PR:0,1:$P($G(^VA(200,PR,"PS")),"^",4)),DRGI=$S('PDRG:0,1:$P($G(^PS(50.7,PDRG,0)),"^",4)),PR=$$ENNPN^PSGMI(PR) S:PRI PRI=PRI'>DT S:DRGI DRGI=DRGI'>DT
 I PSJ21]"",$L($T(ES^ORX8)) N ESIG1 S ESIG1=$$ES^ORX8(+PSJ21_";1") S:ESIG1=1 ESIG="ES"
 S PR=PR_$S(ESIG]"":" ["_$$LOW^XLFSTR(ESIG)_"]",1:"")
 S DRG=$$OIDF^PSJLMUT1(+PDRG) S SI=$S(X]"":$$ENSET^PSGSICHK(X),1:"")
 F Q="FD","LID","OD","STD" S @Q=$$ENDTC^PSGMI(@Q)
 Q:$D(PSJLM)
 ;
WRT ;
 Q:($G(@(F_"0)"))="")
 W !! W:'$D(PSGVWA) ?5,FL,! W "Patient: ",PN
 W ?47,"Status: " I ST["D" W "DISCONTINUED",$S(ST["E":" (EDIT)",ST["R":" (RENEWAL)",1:"")
 E  W $S(ST="E":"EXPIRED",$P($G(@(F_"0)")),U,27)="R":"RENEWED",ST="":"NOT FOUND",ST="RE":"REINSTATED",1:$P(ST_"^ACTIVE^HOLD^INCOMPLETE^NON-VERIFIED^PENDING^UNRELEASED","^",$F("AHINPU",ST)))
 W !,"Orderable Item: ",DRG
 W !?2,"Instructions: ",INS
 W !,"Dosage Ordered: ",DO
 S PSJDUR="" I $G(PSGRDTX) S PSJDUR=$$FMTDUR^PSJLIVMD($P($G(PSGRDTX),U,2))
 I $G(PSGORD),($G(PSJDUR)="") S P=$S(PSGORD["U":5,1:-1) S PSJDUR=$$GETDUR^PSJLIVMD(PSGP,+PSGORD,P)
 W !?6,"Duration: ",PSJDUR
 W ?48,"Start: ",STD
 W !?5,"Med Route: ",$S(MR:$S($D(^PS(51.2,+MR,0)):$P(^(0),"^")_$S($P(^(0),"^",3)]"":" ("_$P(^(0),"^",3)_")",1:""),1:MR),1:"NOT FOUND")
 N RNDT,PSGLRN S PSGLRN=$$LASTREN^PSJLMPRI(PSGP,PSGORD) I PSGLRN S RNDT=$$ENDTC^PSGMI(+PSGLRN) W ?46,"Renewed: ",RNDT
 W !,$$BCMALG^PSJUTL2(PSGP,PSGORD)
 W ?49,"Stop: ",FD
 I $G(PSGORD),($G(PSJDUR)="") S P=$S(PSGORD["U":5,1:-1) S PSJDUR=$$GETDUR^PSJLIVMD(PSGP,+PSGORD,P)
 W !?1,"Schedule Type: ",$$ENSTN^PSGMI(SCT)
 W !?6,"Schedule: ",$S(SCH="":"NOT FOUND",$L(SCH)>27:$E(SCH,1,24)_"...",1:SCH)
 W !?3,$S(AT&("P"'[SCT):"Admin Times: "_AT,1:"(No Admin Times)"),!?6,"Provider: ",PR
 I SI]"" W !,"Special Instructions: " F Q=1:1:$L(SI," ") S QQ=$P(SI," ",Q) W:$L(QQ)+$X>79 !?2 W QQ," "
 W !?48,"Units",?56,"Units",?64,"Inactive",!," Dispense Drugs",?43,"U/D",?48,"Disp'd",?56,"Ret'd",?64,"Date",!,FL,$E(FL,1,10)
 ; the naked reference on the line below refers to the full reference created by indirect reference to F_ON, where F may refer to ^PS(53.1 or the IV or UD multiple ^PS(55
 F X=0:0 S X=$O(@(F_"1,"_X_")")) Q:'X  S DRG=$G(^(X,0)) I DRG]"" D  ;
 .S UD=$P(DRG,"^",2),D=$P(DRG,"^",6)+$P(DRG,"^",10)+$P(DRG,"^",12),R=+$P(DRG,"^",7),Y=$P(DRG,"^",3),DRG=$P(DRG,"^") I Y S Y=$E($$ENDTC^PSGMI(Y),1,8)
 .W !?1,$$ENDDN^PSGMI(DRG),?43,$S(UD:UD,1:1),?48,D,?56,R W:Y ?64,Y Q
 ; the naked reference on the two lines below refers to the full reference created by indirect reference to F_ON, where F may refer to ^PS(53.1 or the IV or UD multiple ^PS(55
 I $O(@(F_"12,0)")) W !!,"Provider Comments:" F Q=0:0 S Q=$O(@(F_"12,"_Q_")")) Q:'Q  N Y S Y=^(Q,0) W !,Y
 I $O(@(F_"3,0)")) W !!,"Comments:" F Q=0:0 S Q=$O(@(F_"3,"_Q_")")) Q:'Q  W !,^(Q,0)
ACTFLG W ! S AT="",Y="12,13,D,18,19,H1,22,23,H0,15,16,R" F X=1:3:12 I $P(ND4,"^",$P(Y,",",X)),$P(ND4,"^",$P(Y,",",X+1)) S AT=$P(Y,",",X+2) Q
 I AT="",'$P(ND4,"^",$S($P(PSJSYSU,";",3)>1:3,1:1)) S AT="V"_$S($P(ND4,"^",18):"H1",$P(ND4,"^",22):"H0",$P(ND4,"^",15):"R",1:"")
 W:AT]"" !,"ORDER ",$S(AT["V":"NOT VERIFIED"_$S($P(AT,"V",2)="":"",1:" ("_$S(AT["H1":"ON HOLD",AT["H0":"OFF HOLD",1:"RENEWAL")_")"),1:"MARKED TO BE "_$S(AT["D":"CANCELLED",AT["H1":"PLACED ON HOLD",AT["H0":"TAKEN OFF OF HOLD",1:"RENEWED"))
 I AT'["V",AT["H1",$D(^PS(55,PSGP,5.1)) S AT=^(5.1) I $P(AT,"^",7),$P(AT,"^",10)]"" W "  (",$P(AT,"^",10),")"
 W !,"Self Med: " I SM W "SELF MED" W:HSM "  (HOSPITAL SUPPLIED)"
 I 'SM&('HSM) W "NO"
 W !!,"Entry By: ",$$ENNPN^PSGMI(EB),?52,"Entry Date: ",LID
 I $G(PSGLRN) W !,"Renewed By: "_$$ENNPN^PSGMI($P(PSGLRN,"^",2))
 W:DRGI !!?3,"(THE ORDERABLE ITEM IS CURRENTLY LISTED AS INACTIVE.)" I PRI W:'DRGI ! W !?3,"(PROVIDER IS CURRENTLY LISTED AS INACTIVE.)"
 ;
DONE ;
 K AND,D,DRG1,DRG2,AT,DO,DRG,EB,F,FD,FL,HSM,INS,LID,MR,ND4,OD,PN,PR,PSGID,PSGOD,R,SCH,SCT,SI,SIG,SM,ST,STD,UD,X,XU,Y Q
 Q
