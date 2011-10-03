PSJO2 ;BIRC/CML3,PR-INPATIENT ORDERS - PRINT ;17 SEP 97 /  1:41 PM
 ;;5.0; INPATIENT MEDICATIONS ;**58**;16 DEC 97
 ;
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSI(58.1 is supported by DBIA 2284.
 ;
 F  S PSJC=$O(^UTILITY("PSG",$J,PSJC)) Q:PSJC=""  D TF F PSJST="C","O","OC","P","R","z" S PSJDRG="" F  S PSJDRG=$O(^UTILITY("PSG",$J,PSJC,PSJST,PSJDRG)) Q:PSJDRG=""  S NF=^(PSJDRG) D:$Y+4>IOSL NP G:PSJNP["^" DONE D P
 I PSJTD,$S('$D(PSGPRP):1,1:PSGPRP="P") D BOT
 ;
DONE ;
 I $S('$D(PSGPRP):1,1:PSGPRP="P") K ^UTILITY("PSG",$J)
 S PSGON=PSJON K:'$D(PSGVBW) PSGODT K C,PSJTD,DO,DOB,PSJDRG,F,GIVE,HDT,LN2,NF,ND,PSJNP,O,ON,PG,PSGID,PSGOD,RF,RTE,SCH,SD,SLS,SM,SSN,PSJST,TF,PSJU,V,WD,WDP,WS,WT Q
 ;
P ; data printed here
 S O=$P(PSJDRG,"^",2),DN=$P(PSJDRG,"^"),PSJON=PSJON+1 S:'PSJTD ^TMP("PSJON",$J,PSJON)=O_PSJC W !,$J(PSJON,4),?5
 I C["A" S ND=$S($D(^PS(55,PSGP,5,O,4)):^(4),1:""),V='$P(ND,"^",PSJU) ; $S(PSJSYSU:PSJSYSU,1:1))
 I  W $S(ND="":" ",$P(ND,"^",12):"D",$P(ND,"^",18)&($P(ND,"^",19)!V):"H",$P(ND,"^",22)&($P(ND,"^",23)!V):"H",$P(ND,"^",15)&($P(ND,"^",16)!V):"R",1:" ") W:V "->"
 I C["N" W $S('$D(^PS(53.1,O,4)):" ",$P(^(4),"^",12):"D",1:" "),$S(PSJSYSU:"->",1:"")
 S ND=$G(@(PSJF_O_",0)")),SCH=$G(^(2)),Y=$P($G(^(6)),"^"),DO=$G(^(.1)) I Y]"" S Y=$$ENSET^PSGSICHK(Y)
 S RTE=$P(ND,"^",3),SM=$S('$P(ND,"^",5):0,$P(ND,"^",6):1,1:2),X=$S($P(ND,"^",9)]"":$P(ND,"^",9),1:"NF")_$E("*",$P(ND,"^",20)),PSGID=$P(SCH,"^",2),SD=$P(SCH,"^",4),SCH=$P(SCH,"^")
 I C'["N",$P(ND,"^",22) S GIVE="*** NOT TO BE GIVEN ***"
 E  S RTE=$S('RTE:"N/F",'$D(^PS(51.2,RTE,0)):RTE,$P(^(0),"^",3)]"":$P(^(0),"^",3),$P(^(0),"^")]"":$P(^(0),"^"),1:RTE),GIVE="Give: "_$S($P(DO,"^",2)]"":$P(DO,"^",2)_" ",1:"")_" "_RTE_" "_$S(SCH]"":SCH,1:"SCHEDULE NOT FOUND")
 S WS=$S(DO&PSGPWD:$D(^PSI(58.1,"D",+DO,PSGPWD)),1:0)
 W ?9,$S(DN'="z":DN,1:"NOT FOUND"),?50,$S(PSJST'="z":PSJST,1:"?"),?53,$E($$ENDTC^PSGMI(PSGID),1,5),?60,$E($$ENDTC^PSGMI(SD),1,5),?67,X I NF!WS!SM W ?71 W:NF "NF " W:WS "WS " W:SM $E("HSM",SM,3)
 W !?11,GIVE I Y]"" W !?10 F X=1:1:$L(Y," ") S V=$P(Y," ",X) W:$L(V)+$X>77 !?10 W V_" "
 Q
 ;
PIV ; print IV order
 ;
TF ;
 Q:PSJC["N"&'PSJTF  S PSJLN2=PSJSLS_$S(PSJC["A":" - - - A C T I V E - - -",PSJC["N":" N O N - V E R I F I E D",1:" - N O N - A C T I V E -")_PSJSLS W:$D(^UTILITY("PSG",$J,PSJC)) !,PSJLN2
 S PSJF="^PS("_$S(PSJC'["N":"55,"_PSGP_",5,",1:"53.1,") S:PSJC["N" TF=0 Q
 ;
NP I PSJON,'PSJTD W $C(7) R !," `^' TO QUIT ",PSJNP:DTIME W:'$T $C(7) S:'$T PSJNP="^" W:PSJNP'["^" $C(13),"                     ",$C(13),# Q
 I PSJON,PSJTD D BOT
 ;
HEADER ; print new page, name, ssn, dob, and ward
 S PSJPG=PSJPG+1,PSGOD=$$ENDTC^PSGMI(PSGPAD)
 W @IOF,! W:$D(PSGPR) ?22,"U N I T   D O S E   P R O F I L E" W ?64,HDT,! W:$D(PSGPR) PSJSLS,PSJSLS,$E(PSJSLS,1,24),! W ?1,$P(PSGP(0),"^"),?34,"  Ward: ",$S(PSGPWDN]"":PSGPWDN,1:"* NF *") W:$D(PSGPR) ?75-$L(PSJPG),"Pg: ",PG-$D(PSGVWA)
 W !?7,"PID: ",PSJPPID,?30,"WEIGHT(kg): ",PSJPWT,?48,"Sex: ",$P(PSJPSEX,"^",2),?61,"Admitted: ",$E(PSGOD,1,8),!?7,"DOB: ",DOB_"  ("_AGE_")",?30,"Height(cm): ",PSJPHT
 S PSGID=$S(PSGPDD:PSGPDD,1:PSGPTD) I PSGID W ?$S(PSGPDD:59,1:53),$S(PSGPDD:"Discharged: ",1:"Last transferred: "),$E($$ENDTC^PSGMI(PSGID),1,8)
 W !?8,"Dx: ",$S(PSGPDX]"":PSGPDX,1:"* NF *"),?69-$L(RB),"Room-Bed: ",RB,!?1,"Reactions:" D ENRCT^PSGAPP I $D(^PS(55,PSGP,5.1)),$P(^(5.1),"^",7) W $C(7),!!?21,"** PATIENT'S ORDERS PLACED ON HOLD **"
 I '$D(PSGVWA),$S('$D(PSGPRP):1,1:PSGPRP'="E") W !!," No.",?19,"Drug",?50,"ST Start  Stop  Status/Info"
 W:PSJPG>1 !,PSJLN2 Q
 ;
BOT ; print name, ssn, and dob on bottom of page
 F Q=$Y:1:IOSL-4 W !
 W !,?2,$P(PSGP(0),"^"),?40,SSN,?60,DOB Q
