PSGLOI ;BIR/CML3 - ORDER INFO (AND PRINT) FOR LABELS ;30 Apr 98 / 4:41 PM
 ;;5.0;INPATIENT MEDICATIONS;**7,44,58,110,111,138,197**;16 DEC 97;Build 3
 ;
 ;Reference to ^PS(51.2 is supported by DBIA 2178.
 ;Reference to ^PSD(58.8 is supported by DBIA 2283.
 ;Reference to ^PSI(58.1 is supported by DBIA 2284.
 ;Reference to ^PS(55 supported by DBIA #2191.
 ;
ENOI ;
 S F="^PS("_$S(PSGORD["N":"53.1,",PSGORD["P":"53.1,",1:"55,"_PSGOP_",5,")_+PSGORD_","
 ; the quit below corrects an error if the Order has been moved to 55
 Q:'$D(@(F_"0)"))
 S ND=$G(@(F_"0)")),PSGLPR=$P(ND,"^",2),PSGLMR=$P(ND,"^",3),PSGLST=$P(ND,"^",7),PSGLSTAT=$P(ND,"^",9),PSGLTD=$P(ND,"^",12),PSGLOD=$P(ND,"^",14),PSGLSM=$S('$P(ND,"^",5):0,$P(ND,"^",6):1,1:2),NG=$P(ND,"^",22)
 S ND=$G(@(F_".2)")),PSGLDRG=$P(ND,"^"),PSGLDDA=+ND,PSGLDO=$P(ND,"^",2)
 S PSGCLN=$S(F[53.1:$G(@(F_"""DSS"")")),1:$G(@(F_"8)"))) I PSGCLN]"" S PSGLWDN=$P(^SC($P(PSGCLN,"^"),0),"^")
 ;
SET ;
 ; naked references below refer to full reference inside indirection @(F_"2)" for either file 53.1 or 55
 K PSGLAT S ND=$G(@(F_"2)")),(PSGLSSD,PSGLSD)=$P(ND,"^",2),(PSGLFFD,PSGLFD)=$P(ND,"^",4),PSGLAT=$P(ND,"^",5),PSGLMN=$P(ND,"^",6),PSGLSCH=$P(ND,"^"),ND=$G(^(7)),PSGLDT=+ND,PSGLR=$P(ND,"^",2)
 I PSGLST'="R",PSGLMN="D",PSGLAT="" S PSGLAT=$E($P(PSGLSD,".",2)_"0000",1,4)
 I PSGLAT,PSGLSCH["@" S PSGLSCH=$P(PSGLSCH,"@")
 S (PSGLAT(0),X)=0 I PSGLFD]"",PSGLFD'>PSGDT S (PSGLAT(0),X)=5,(PSGLAT(1),PSGLAT(2),PSGLAT(4),PSGLAT(5))="****",PSGLAT(3)=$S(PSGLSTAT["D":"DC'D",1:"EX'D")
 E  I $S(PSGLSTAT="P":1,PSGLSTAT="U":1,PSGLST="OC":1,PSGLST="P":1,1:PSGLSCH["PRN") S PSGLAT=""
 E  I PSGLAT S PSGLAT(0)=$L(PSGLAT,"-"),X=0 D
 .F Q=1:1:5 S PSGLAT(Q)=""
 .S Q=PSGLAT(0),Y=PSGLAT I Q=1 S PSGLAT(3)=$P(Y,"-") Q
 .I Q=2 S PSGLAT(1)=$P(Y,"-"),PSGLAT(5)=$P(Y,"-",2) Q
 .I Q=3 S PSGLAT(1)=$P(Y,"-"),PSGLAT(3)=$P(Y,"-",2),PSGLAT(5)=$P(Y,"-",3) Q
 .F Q=1:1:PSGLAT(0) S X=X+1,PSGLAT(X)=$P(PSGLAT,"-",Q) I PSGLAT(0)<4 S X=X+1 S:Q<5 PSGLAT(X)=""
 I X<5 F Q=X+1:1:5 S:'$G(PSGLAT(Q)) PSGLAT(Q)=""
 I $G(DFN),$G(PSGORD) N PSGLREN S PSGLREN=+$$LASTREN^PSJLMPRI(DFN,PSGORD)
 S ND=$G(@(F_"4)")),PSGLRN=+ND,PSGLRPH=+$P(ND,"^",3) N PSGLRNDT S PSGLRNDT=$P(ND,"^",2) I PSGLRNDT,$G(PSGLREN) I $G(PSGLREN)>PSGLRNDT S PSGLRN=0
 S:+$G(PSGLREN) PSGLREN=$$ENDTC^PSGMI(PSGLREN)
 I NG S PSGLSI="*** NOT TO BE GIVEN ***"
 E  S PSGLSI=$P($G(@(F_"6)")),"^") S:PSGLSI]"" PSGLSI=$$ENSET^PSGSICHK(PSGLSI)
 ; naked references below refer to full reference inside indirection @(F_"2)" for either file 53.1 or 55
 I PSGLSI="",$P(@(F_"0)"),U,9)="P",$O(@(F_"12,0)")) S X=0 F  S X=$O(@(F_"12,"_X_")")) Q:'X  S Z=$G(^(X,0)),Y=$L(PSGLSI) S:Y+$L(Z)'>179 PSGLSI=PSGLSI_Z_" " I Y+$L(Z)>179 S PSGLSI="SEE PROVIDER COMMENTS" Q
 S PSGLDT=$$ENDTC^PSGMI(PSGLDT),PSGLOD=$E($$ENDTC^PSGMI(PSGLOD),1,5)
 I PSGLSTAT="P"!(PSGLSTAT="U") S PSGLSD="           ",PSGLFD="    ",PSGLST=" "
 E  S PSGLSD=$$ENDTC1^PSGMI(PSGLSD),PSGLSD=$E(PSGLSD,1,5)_$E(PSGLSD,9,14),PSGLFD=$$ENDTC1^PSGMI(PSGLFD)
 S:'PSGLRN PSGLRN="_____" I PSGLRN,$D(^VA(200,+PSGLRN,0))#2 S X=^(0),X=$S($P(X,"^",2)]"":$P(X,"^",2),1:$P(X,"^")),PSGLRN=$S(X'[",":X,1:$E(X,$F(X,","))_$E(X))
 S:'PSGLRPH PSGLRPH="_____" I PSGLRPH,$D(^VA(200,+PSGLRPH,0))#2 S X=^(0),X=$S($P(X,"^",2)]"":$P(X,"^",2),1:$P(X,"^")),PSGLRPH=$S(X'[",":X,1:$E(X,$F(X,","))_$E(X))
 I $P($G(^PS(51.2,+PSGLMR,0)),"^")]"" S PSGLMR=$E($S($P(^(0),"^",3)]"":$P(^(0),"^",3),1:$P(^(0),"^")),1,5)
 I $P($G(^VA(200,+PSGLPR,0)),"^")]"" S PSGLPR=$P(^(0),"^")
 S Q=32-$L(PSGLDO)-$L(PSGLMR) I $L(PSGLSCH)>Q S PSGLSCH=$E(PSGLSCH,1,Q-3)_"..."
 NEW DRUGNAME
 D DRGDISP^PSJLMUT1(DFN,$S(PSGORD["A":+PSGORD_"U",PSGORD["U":+PSGORD_"U",1:+PSGORD_"P"),40,34,.DRUGNAME,0)
 ; naked references below refer to full reference inside indirection @(F_"2)" for either file 53.1 or 55
 N PSGNOW D NOW^%DTC S PSGNOW=% S (PSGLNF,PSGLWS)=0 F X=0:0 S X=$O(@(F_"1,"_X_")")) Q:'X!(PSGLWS)  S Y=$G(^(X,0)) I $P(Y,U,3)>PSGNOW!'$P(Y,U,3) S PSGLWS=$S($D(^PSI(58.1,"D",+Y,+PSGLWD)):1,$D(^PSD(58.8,"D",+Y,+PSGLWD)):1,1:0)
 I $D(PSGLSTOP) Q
 ;
ENP ;
 I PSGLSD["     ",+$G(@(F_"4)")) S X="P E N D I N G"
 E  S X=$S(+$G(PSGLREN):PSGLREN,1:PSGLSD)_" |"_PSGLFD
 W $C(13),?1,PSGLOD," |",X,?36,"(",PSGLBS5,")",?42,"|",PSGLAT(1),?52,PSGLPN,?88,$J($S(PSGLRB]"":PSGLRB,1:"*NF*"),12)
 F X=0:0 S X=$O(DRUGNAME(X)) Q:'X  D
 . I X=1 W !?1,DRUGNAME(X),?42,PSGLST,?43,"|",PSGLAT(2),?52,PSGLSSN,?70,PSGLDOB,"  (",PSGLAGE,")",?85,$J($S(PSGLTM]"":PSGLTM,1:"NOT FOUND"),15)
 . I X=2 W !?1,DRUGNAME(X),?43,"|",PSGLAT(3),?52,PSGLSEX,?65,"DX: ",PSGLDX
 . S L=X+1
 . I L=5,PSGLSI]"" W "See next label for continuation" D NXTLNE W !,?1
 . I X>2 W !?1,DRUGNAME(X) D NXTLNE
 I L=5,PSGLSI]"" W "See next label for continuation" D NXTLNE W !,?1
 F Y=1:1:$L(PSGLSI," ") S Y1=$P(PSGLSI," ",Y) D
 .I $L(Y1)>42 F  Q:$L(Y1)<42  D
 ..S LEN=43-$X W $E(Y1,1,LEN) S Y1=$E(Y1,LEN+1,255) D NXTLNE
 ..I L#5=0 W "See next label for continuation" D NXTLNE W !,?1
 .I ($X+$L(Y1))>42 D NXTLNE I L#5=0 W "See next label for continuation" D NXTLNE W !,?1
 .W Y1," "
 D:PSGLSI]"" NXTLNE
 I $D(PSGLAT(L+1)) F  Q:'$D(PSGLAT(L+1))  D
 .I L#5=0 W ?1,"See next label for continuation" D NXTLNE W ! Q
 .D NXTLNE
 I L#5>0 F  Q:L#5=0  D NXTLNE
 W $E("WS",1,PSGLWS*2) W:PSGLSM ?4,$E("HSM",PSGLSM,3) W ?8,$E("NF",1,PSGLNF*2),?24,"RPH:",PSGLRPH,?33," RN:",PSGLRN D NXTLNE
 W !
 Q
 ;
NXTLNE ; Print info to right of drug
 W ?43,"|",$G(PSGLAT(L))
 I L=4 D
 .N Y S Y=PSGLR W ?52 W:+$G(PSGLREN)!(PSGLSD) $S(+$G(PSGLREN):PSGLREN,1:PSGLSD),?77,$S(Y="NR":"RENEWAL ",Y["N":"NEW ",1:""),"ORDER "
 .W $S(Y="E":"EDITED",Y="DE":"DC'ED (EDIT)",Y["D":"DISCONTINUED",Y="NE":"(EDIT)",PSGLR="H1":"ON HOLD",PSGLR="H0":"OFF OF HOLD",PSGLR="RE":"REINSTATED",1:"")
 .I PSGLFFD]"",PSGLFFD'>PSGDT,PSGLR'["D" W " (EXPIRED)"
 W:L=5 ?52,$S(PSGLWGN]"":$E(PSGLWGN,1,21),1:"NOT FOUND"),?79,$J($S(PSGLWDN]"":$E(PSGLWDN,1,21),1:"NOT FOUND"),21)
 W !,?1 S L=L+1
 Q
ENKV ;*** Kill var created from this routine
 K PSGDT,PSGLAGE,PSGLAT,PSGLBS5,PSGLDDA,PSGLDO,PSGLDOB,PSGLDRG,PSGLDT,PSGLDX,PSGLFD,PSGLFFD,PSGLMN,PSGLMR,PSGLNF,PSGLOD,PSGLPN
 K PSGLPR,PSGLR,PSGLRB,PSGLRN,PSGLRPH,PSGLSCH,PSGLSD,PSGLSEX,PSGLSI,PSGLSM,PSGLSSD,PSGLSSN,PSGLST
 K PSGLSTAT,PSGLSTOP,PSGLTD,PSGLTM,PSGLWD,PSGLWDN,PSGLWGN,PSGLWS,PSGNOW,PSGOP,PSGORD
 Q
