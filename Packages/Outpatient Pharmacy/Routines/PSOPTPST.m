PSOPTPST ;BIR/DSD - Post Patient Selection Action ;07/25/96
 ;;7.0;OUTPATIENT PHARMACY;**7,71,88,146,157,143,225**;DEC 1997;Build 29
 ;External reference to SDCO22 supported by DBIA 1579
 ;External reference to IBE(350.1,"ANEW" supported by DBIA 592
 ;External reference to PS(55 supported by DBIA 2228
 ;External reference to IBARX supported by DBIA 125
 ;External reference to $$GETSHAD^DGUTL3 supported by DBIA 4462
START S PSOQFLG=0
 D GET ; Gets data from Patient file
 D DEAD G:PSOQFLG END ; Checks to see if patient still alive
 G:$G(PSOFROM("PTLKUP"))']"" END ; skips questions if not called by RX data entry
 D INP G:PSOQFLG END ;Checks to see if inpatient and whether to continue
 D CNH G:PSOQFLG END ; Checks to see if nursing home patient
 D ELIG ; Checks eligibility
 D:$G(DUZ("AG"))="V" COPAY ; Deals with copay
 D ADDRESS ; Display address information
 D:$G(^PS(55,PSODFN,1))]"" REMARKS ; Displays narrative about patient
END D EOJ
 Q
 ;----------------------------------------------------------
GET K DIC,DR,DIQ S DIC=2,DA=PSODFN,DR=".1;.172;.351;.361;148",DIQ="PSOPTPST"
 D EN^DIQ1 K DIC,DA,DR,DIQ
 Q
 ;
DEAD ;
 I $G(PSOPTPST(2,PSODFN,.351))]"" S (PSODEATH,PSOQFLG)=1 S SSN=$P(^DPT(PSODFN,0),"^",9) W !?10,$C(7),PSORX("NAME")_" ("_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_") DIED "_PSOPTPST(2,PSODFN,.351),! S:$G(POERR) POERR("DEAD")=1 D
 .;I '$O(^PS(55,PSODFN,"P","A",DT)) Q
 .S ACOM="Date of Death "_PSOPTPST(2,PSODFN,.351)_".",ZTRTN="CAN^PSOCAN3",ZTDESC="Outpatient Pharmacy Autocancel Due to Death of Patient",ZTSAVE("ACOM")="",ZTSAVE("PSODFN")="",ZTSAVE("PSODEATH")=""
 .S ZTIO="",PSOCLC=DUZ,ZTSAVE("PSOCLC")="",ZTDTH=$H D ^%ZTLOAD K ACOM,ZTSK,PSODEATH
 Q
 ;
INP I '$G(PSOXFLG),'$G(PSOFIN),$G(PSOPTPST(2,PSODFN,.1))]"" S PSOXFLG=1,SSN=$P(^DPT(PSODFN,0),"^",9) W !!?10,$C(7),PSORX("NAME")_" ("_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_")" K SSN
 I $G(PSOPTPST(2,PSODFN,.1))]"" W !?10,$C(7),"Patient is an Inpatient on Ward "_PSOPTPST(2,PSODFN,.1)_" !!" D DIR
 Q
TPB ;
 N PSOTPSSN
 I '$G(PSODFN) Q
 I $D(^PS(52.91,PSODFN,0)) I '$P(^PS(52.91,PSODFN,0),"^",3)!($P(^(0),"^",3)>DT) D
 .S PSOTPSSN=$P($G(^DPT(PSODFN,0)),"^",9)
 .I $G(PSOFIN)!($G(MEDP)) D
 ..I $G(MEDP) W !!?10,$C(7),$P($G(^DPT(PSODFN,0)),"^")_" ("_$E(PSOTPSSN,1,3)_"-"_$E(PSOTPSSN,4,5)_"-"_$E(PSOTPSSN,6,9)_")" Q
 ..I $G(PSOFIN) I $G(PSOPTPST(2,PSODFN,148))="YES"!($G(PSOPTPST(2,PSODFN,.1))]"") W !!?10,$C(7),$P($G(^DPT(PSODFN,0)),"^")_" ("_$E(PSOTPSSN,1,3)_"-"_$E(PSOTPSSN,4,5)_"-"_$E(PSOTPSSN,6,9)_")"
 .I '$G(PSOFIN),'$G(MEDP) W !
 .W !?10,"Patient is eligible for the Transitional Pharmacy Benefit!!" D DIR
 Q
 ;
CNH I $G(MEDP),$G(PSOPTPST(2,PSODFN,148))="YES",$G(PSOPTPST(2,PSODFN,.1))']"" D
 .S SSN=$P(^DPT(PSODFN,0),"^",9) W !!?10,$C(7),PSORX("NAME")_" ("_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_")" K SSN
 K PSORX("CNH") I $G(PSOPTPST(2,PSODFN,148))="YES" W !?10,$C(7),"Patient is in a Contract Nursing Home !!" D DIR S:'$G(PSOQFLG) PSORX("CNH")=1
 Q
 ;
ELIG I $G(PSOPTPST(2,PSODFN,.361))]"",$G(PSOPTPST(2,PSODFN,.172))'="I" W !,"MAS Eligibility: "_PSOPTPST(2,PSODFN,.361)
 S DFN=PSODFN D RE^PSODEM
 Q
 ;
COPAY K PSOBILL,PSOCPAY S DFN=PSODFN,(X,PSOPTIB)=$P($G(^PS(59,+PSOSITE,"IB")),"^")_"^"_PSODFN D XTYPE^IBARX
 I '$D(^IBE(350.1,"ANEW",+PSOPTIB,1,1)) S PSOQFLG=1 D  K PSOPTIB Q
 .W $C(7),!!,"There is a problem with the IB SERVICE/SECTION entry in your Pharmacy Site File."
 .W !,"You will not be able to enter any new prescriptions until this is corrected!",!
 S (ACTYP,BL)="",(PSOBILL,PSOCPAY)=0 I +Y=-1 W !,"ERROR IN COPAY ELIGIBILITY ENCOUNTERED." G COPAYX
COPAY1 S ACTYP=$O(Y(ACTYP)) G:'ACTYP COPAYX F III=0:0 S BL=$O(Y(ACTYP,BL)) Q:BL=""  I BL>0 S PSOBILL=BL,PSOCPAY=BL_"^"_Y(ACTYP,BL)
 G COPAY1
COPAYX K X,Y,ACTYP,BL,III,PSOPTIB
 ;I $G(PSOBILL) 
 D QST
 Q
 ;
ADDRESS N DFN S (DA,DFN)=PSODFN D ADD^VADPT K DFN,PSOI,DA,DR
 Q
 ;
REMARKS S PSOX=$G(^PS(55,PSODFN,1)) W !!,?5
 F PSOI=1:1 Q:$P(PSOX," ",PSOI,900)=""  W:$X+$L($P(PSOX," ",PSOI))+$L(" ")>IOM !?5 W $P(PSOX," ",PSOI)_" "
 K PSOX,PSOI
 Q
 ;
DIR K DIR W !
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do You Want To Continue" D ^DIR K DIR
 S:'Y PSOQFLG=1 K X,Y,DIRUT,DTOUT,DUOUT
 Q
 ;
EOJ K:PSOQFLG PSORX("CNH") K PSOPTPST,VAPA
 Q
QST ;Ask new questions for Copay
 I '$$DT^PSOMLLDT Q
 K PSOIBQS
 I $G(PSOBILL) S PSOIBQS(PSODFN,"SC")=""
 S PSOIBQS(PSODFN,"SC>50")=""
 I +$P($$CVEDT^DGCV(PSODFN),"^",3) S PSOIBQS(PSODFN,"CV")=""
 I $$AO^SDCO22(PSODFN) S PSOIBQS(PSODFN,"VEH")=""
 I $$IR^SDCO22(PSODFN) S PSOIBQS(PSODFN,"RAD")=""
 I $$EC^SDCO22(PSODFN) S PSOIBQS(PSODFN,"PGW")=""
 I $L($T(GETSHAD^DGUTL3)) S:$$GETSHAD^DGUTL3(PSODFN)=1 PSOIBQS(PSODFN,"SHAD")=""
 I $P($$GETSTAT^DGMSTAPI(PSODFN),"^",2)="Y" S PSOIBQS(PSODFN,"MST")=""
 I $T(GETCUR^DGNTAPI)]"" N PSONCP,PSONCPX S PSONCPX=$$GETCUR^DGNTAPI(PSODFN,"PSONCP") I $P($G(PSONCP("IND")),"^")="Y" S PSOIBQS(PSODFN,"HNC")=""
 Q
