PSGOE ;BIR/CML3-PROFILE AND ORDER ENTRY (MAIN DRIVER) ;24 Feb 99 / 10:40 AM
 ;;5.0;INPATIENT MEDICATIONS;**22,29,56,72,95,80,133,181,275,315**;16 DEC 97;Build 73
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PSSLOCK is supported by DBIA #2789
 ;
 ;N PSJNEW,PSGPTMP,PPAGE S PSJNEW=1
 ;
EN ;
 N PSJLK,PSJPROT,XQORS,VALMEVL,PSJSYSO D ENCV^PSGSETU Q:$D(XQUIT)
 S (PSGOL,PSGOP,PSGNEF,PSGOEAV,PSGPXN)="" I $P(PSJSYSU,";",2)&($P(PSJSYSU,";")'=3) S PSGION=ION D DDEV D ^%ZISC I DDEV="^" G DONE
 K PSGVBY L +^PS(53.45,PSJSYSP):1 E  D LOCKERR^PSJOE G DONE
 F  S (PSJLMCON,PSGPTMP)=0 D ENDPT^PSGP,HK Q:PSGP'>0  D   I PSJLK D UL^PSSLOCK(PSGP)
 .K ^TMP("PSJ",$J)
 .S PSJLK=$$L^PSSLOCK(PSGP,1) I 'PSJLK W !,$C(7),$P(PSJLK,U,2) Q
 .N NXTPT S NXTPT=0  ;NXTPT=1 indicates OE is complete for this patient
 .K PSJLMPRO S PSJLMCON=0
 .S PSJPROT=1,DFN=PSGP D EN^VALM("PSJ LM BRIEF PATIENT INFO")
 .F  Q:$G(NXTPT)  D
 ..K PSGRDTX
 ..I $G(PSJLMCON)!$G(PSJNEWOE) D
 ...S PSJOL=$S(",S,L,"[(","_$G(PSJOL)_","):PSJOL,1:"S")
 ...S PSJLMPRO=1,PSJLMCON=1,PSJNEWOE=0 D EN^VALM("PSJU LM OE")
 ..I $G(PSJNEWOE)!($G(VALMBCK)="Q") S PSJNEWOE=0 Q
 ..I $G(PSJLMCON)&$G(PSJLMPRO)&'$D(^TMP("PSJ",$J)) D  Q
 ...S PSJLMCON=0,PSJLMPRO=0 D EN^VALM("PSJ LM BRIEF PATIENT INFO")
 ...I $G(PSJNEWOE) S NXTPT=0 Q
 ...S NXTPT=1
 ..S NXTPT=1,PSJNEWOE=0 ; Go on to next patient
 .I $G(PSGPXN),$P(PSJSYSW0,U,29)]"" S PSGPXPT=PSGP D  K PSGPXPT S PSGPXN=0
 ..N DFN,PSGP S (PSGP,DFN)=PSGPXPT D ^PSGPER
 .D ENCV^PSGSETU
 K PSJLMPRO,^TMP("PSJPRO",$J),^TMP("PSJ",$J),^TMP("PSJON",$J)
 ;
DONE ;
 I PSGOP,$P(PSJSYSL,"^",2)]"" D ENQL^PSGLW
 I $D(PSJSYSO),PSGOP,$O(^PS(53.44,DUZ,1,PSGOP,1,0)) S PSGOEPOF="" D ^PSGOEPO
 K PSJEXCPT,PSJOCER,^TMP($J,"PSJPRE")
 K D0,DDEV,FQC,J,MRN,ND,ND2,PSGNEF,PSGNEFDO,PSGNESDO,PSGOE,PSGOEA,PSGOEAV,PSGOEDMR,PSGOENOF,PSGOEPOF,PSGOL,PSGOP,PSGPX,PSGTOL,PSGTOO,PSGUOW,PSJOPC,PSJORTOU,PSJORVP,PRI,PX,XX L -^PS(53.45,PSJSYSP)
 K PSGOEORF,ORIFN,ORETURN,PSJORL,PSJORPCL,PSJORPV,PSJNOO,DDH,DDN,DRGI,FQ,HF,I1,ND1,NF,PDRG,PSGACTO,PSGAL,PSGCANFL,PSGDA,PSGPEN,PSGPENWS,PSGY,ND2P1 ;*315
 G:$G(PSGPXN) ^PSGPER1 D ENKV^PSGSETU K ND1,PSG25,PSG26,PSGEB,PSBEBN,PSGNODE,PSGOAT,PSGSTAT,DDN,I2 Q
 Q
 ;
HK ; Housekeeping (a nice COBOL term)
 S PSGOENOF=0 I +PSJSYSU=1 D NOW^%DTC F Q=%:0 Q:PSGOENOF  S Q=$O(^PS(55,PSGP,5,"AUS",Q)) Q:'Q  F QQ=0:0 S QQ=$O(^PS(55,PSGP,5,"AUS",Q,QQ)) Q:'QQ  I $D(^PS(55,PSGP,5,QQ,4)),$P(^(4),"^",10) S PSGOENOF=1 Q
 I PSGOP,PSGOP'=PSGP D
 .N PSJACPF,PSJACNWP,PSJPWD,PSJSYSL,PSJSYSW,PSJSYSW0,DFN,VAIN,VAERR S DFN=PSGOP
 .D INP^VADPT S PSJPWD=+VAIN(4) I PSJPWD S PSJACPF=10 D WP^PSJAC D:$P(PSJSYSL,"^",2)]"" ENQL^PSGLW
 I $D(PSJSYSO),PSGOP,PSGOP'=PSGP S PSGOEPOF="" D ^PSGOEPO
 S:PSGP>0 PSJORVP=PSGP_";DPT(",PSJORL=$$ENORL^PSJUTL(PSJPWD),PSGOP=PSGP,X=""
 Q
 ;
ORSU ; Oe/Rr Set-Up ;Not used anymore
 Q
 ;
DDEV ;
 F  S POP=1 R !!,"Select Device to print ORDERS (10-1158): ",DDEV:DTIME W:'$T $C(7) S:'$T DDEV="^" Q:DDEV="^"!(DDEV=".")  D:DDEV?1."?" DDH K %ZIS,IO("Q") S %ZIS="NQ",IOP=DDEV D ^%ZIS Q:'POP
 S:DDEV="^" %=-1 Q:POP  I $E(IOST)'="P"!(PSGION=ION) W $C(7),!!?2,"The device you have selected is not a printer.  You must select a printer." W:PSGION=ION !,"You cannot print the orders to your terminal." G DDEV
 S PSJSYSO=ION_"^"_IO W:$S(DDEV=" ":1,$L(DDEV)'<$L(ION):0,1:DDEV=$E(ION,1,$L(DDEV))) $S(DDEV=" ":"  "_ION,1:$E(ION,$L(DDEV)+1,$L(ION)))
 F Q=0:0 S Q=$O(^PS(53.44,DUZ,1,Q)) Q:'Q  I $O(^(Q,1,0)) Q
 Q:'Q  W !!?2,"You have unprinted orders.  If you do not print them now, you will not be",!,"able to print them from here later."
 F  W !!,"Do you want to print them now" S %=1 D YN^DICN Q:%  W !!?2,"Enter 'YES' to print the orders now.  If you enter 'NO', you will not be",!,"able to print them from here later.  (Enter '^' to exit this option.)"
 Q:%<0  I %=1 S PSGOEPOF="A" D ^PSGOEPO S %=0 Q
 S DA=DUZ,DIK="^PS(53.44," D ^DIK S %=0 Q
 ;
DDH ;
 W !!?2,"Select a device to print each patient's orders (VA Form 10-1158) after you",!,"have entered them.  If you do not select a device, no orders will print." Q
 ;
CHUCK ; This appears to be an ancient test tag - not called from any file or other routine.
 D ENCV^PSGSETU Q:$D(XQUIT)  R !!,"PSJSYSU: ",PSJSYSU:DTIME S:'$T PSJSYSU="^" I "^"'[PSJSYSU G EN
 Q
