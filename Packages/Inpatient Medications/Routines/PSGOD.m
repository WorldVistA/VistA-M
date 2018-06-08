PSGOD ;BIR/CML3 - CREATES NEW ORDER FROM OLD ONE ;22 SEP 97 / 2:56 PM 
 ;;5.0;INPATIENT MEDICATIONS;**67,58,111,133,181,286,281,315,338,256,347**;16 DEC 97;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
 ;*286 - Do not allow copied Unit Dose orders for outpatients
 D INP^VADPT I 'VAIN(4) W !,"You cannot copy Unit Dose orders for this patient!" H 2 Q
 I $P($G(^PS(55,PSGP,5,+PSJORD,0)),"^",22) D  Q
 .W !,"This order is marked 'Not To Be Given' and can't be copied!" H 2
 F  W !!,"Do you want to copy this order" S %=2 D YN^DICN Q:%  D CH
 G:%'=1 DONE
 ;
 W !!,"...copying..." N OLDON
 K PSGORQF
 N PSGPDRG,Q
 NEW PSJOLDNM
 S PSGOEPR=$P($G(^PS(55,PSGP,5.1)),"^",2),OLDON=PSGORD,Q=""
 K PSGODN S F=$S(PSGORD["P":"^PS(53.1,"_+PSGORD_",",1:"^PS(55,"_PSGP_",5,"_+PSGORD_",") F N=0,.2,2,2.1,6 S PSGODN(N)=$G(@(F_N_")"))
 S PSGPR=$P(PSGODN(0),"^",2),PSGMR=$P(PSGODN(0),"^",3),PSGSM=$P(PSGODN(0),"^",5),PSGHSM=$P(PSGODN(0),"^",6),PSGST=$P(PSGODN(0),"^",7)
 S PSGPDRG=+PSGODN(.2),PSGDO=$P(PSGODN(.2),"^",2)
 ;*315
 S:$G(PSGODN(2.1))]"" PSGDUR=+PSGODN(2.1),PSGRMVT=$P(PSGODN(2.1),U,2),PSGRMV=$P(PSGODN(2.1),U,3),PSGRF=$P(PSGODN(2.1),U,4)
 S PSGSI=PSGODN(6)
 ; The naked reference below refers to the full reference inside indirection to ^PS(55,PSGP,5,+PSGORD, or ^PS(55,PSGP,"IV",+PSGORD, or ^PS(53.1,+PSGORD
 S PSGODN(3)=0 F Q=0:0 S Q=$O(@(F_"3,"_Q_")")) Q:'Q  I $D(^(Q,0)) S PSGODN(3,Q)=^(0),PSGODN(3)=PSGODN(3)+1 S ^PS(53.45,PSJSYSP,1,Q,0)=^(0)
 ;S:PSGODN(12)>0 ^PS(53.45,PSJSYSP,4,0)="^53.4504" S:PSGODN(3)>0 ^PS(53.45,PSJSYSP,1,0)="^53.4501"
 S:PSGODN(3)>0 ^PS(53.45,PSJSYSP,1,0)="^53.4501"
 ; The naked reference below refers to the full reference inside indirection to ^PS(55,PSGP,5,+PSGORD, or ^PS(55,PSGP,"IV",+PSGORD, or ^PS(53.1,+PSGORD  
 ;338
 N PSGK5345 S PSGK5345=0
 S (PSGODN(1),Q)=0 F  S Q=$O(@(F_"1,"_Q_")")) Q:'Q  S ND=$G(^(Q,0)) I ND D
 .I '$P(ND,"^",3),'PSGK5345 S PSGODN(1)=PSGODN(1)+1,PSGODN(1,PSGODN(1))=$P(ND,"^",1,2) S ^PS(53.45,PSJSYSP,2,PSGODN(1),0)=^(0)
 .I '$P(ND,"^",3),PSGK5345 S PSGODN(1,PSGODN(1))=$P(ND,"^",1,2) S ^PS(53.45,PSJSYSP,2,PSGODN(1),0)=^(0) S PSGODN(1)=PSGODN(1)+1,PSGK5345=0 K ^PS(53.45,PSJSYSP,2,PSGODN(1),0)
 .I $P(ND,"^",3) S PSGODN(1)=PSGODN(1)+1 K ^PS(53.45,PSJSYSP,2,PSGODN(1),0) S PSGK5345=1
 K PSGK5345
 S PSGS0Y=$P(PSGODN(2),"^",5),PSGS0XT=$P(PSGODN(2),"^",6),PSGNESD="",PSGSCH=$P(PSGODN(2),U)
 ;PSJ*5*256
 S PSJOLDNM("ORD_SCHD")=PSGSCH
 I $$CHKSCHD^PSJMISC2(.PSJOLDNM) W !!,"Order not copied." D PAUSE^VALM1 K PSJOLDNM G ORIG
 S:$G(PSJOLDNM("NEW_SCHD"))]"" PSGSCH=PSJOLDNM("NEW_SCHD") K PSJOLDNM
 S PSGODF=1,PSGNEDFD=$P($$GTNEDFD^PSGOE7("U",+PSGPDRG),U)_"^^"_PSGST_"^"_PSGSCH
 W "." D ^PSGNE3
 K PSGEFN,PSGOEEF,PSGOEE,PSGOEOS S PSGEFN="1:13" F X=1:1:13 S PSGEFN(X)=""
 S PSGPDN=$$OINAME^PSJLMUTL(PSGPDRG),PSGOINST="",PSGSDN=$$ENDD^PSGMI(PSGNESD)_U_$$ENDTC^PSGMI(PSGNESD),PSGFDN=$$ENDD^PSGMI(PSGNEFD)_U_$$ENDTC^PSGMI(PSGNEFD)
 S PSGAT=PSGS0Y,PSGEBN=DUZ,PSGLIN=$$ENDD^PSGMI(PSGDT)_U_$$ENDTC^PSGMI(PSGDT),PSGEBN=$$ENNPN^PSGMI(DUZ),PSGSTAT=$S(PSGOEAV:"ACTIVE",1:"NON-VERIFIED")
 W "." D CHK^PSGOEV("^^"_PSGMR_"^^^^"_PSGST,PSGPDRG_U_PSGDO,PSGSCH_U_PSGNESD_"^^"_PSGNEFD)
 I $G(PSGSCH)]"" D
 .N X S X=PSGSCH N SWD,SDW,XABB,QX D ENOS^PSGS0 I $G(X)=""!$G(PSJNSS) S CHK=1 K PSJNSS Q
 .I $G(PSGAT)="",$G(PSGS0Y) S PSGAT=PSGS0Y
 .I $G(PSGAT),($G(PSGS0Y)="") S PSGS0Y=PSGAT
 .I $G(PSGS0XT)="D",$G(PSGS0Y)="" S CHK=1 D  K PSJNSS
 ..W ! K DIR S DIR(0)="FOA",DIR("A")="   WARNING - Admin times are required for DAY OF WEEK schedules    " D ^DIR K DIR
 S PSGSD=PSGNESD,PSGFD=PSGNEFD
 K PSJACEPT S VALMBCK="Q" D:$D(Y) EN^VALM("PSJU LM ACCEPT")
 I $G(PSJACEPT)=1 D OC S:$D(PSGORQF) PSJACEPT=0 S:$G(PSJACEPT)=1 VALMBCK="",PSJNOO=$$ENNOO^PSJUTL5("N")
 I '$G(PSJACEPT)!($G(PSJNOO)<0) W:'$G(PSJCOFLG) !!,"Order not copied." D PAUSE^VALM1:'$G(PSJCOFLG) G ORIG    ;PSJCOFLG set in PSODGAL1 for allergies
 S PSGNESD=PSGSD,PSGNEFD=PSGFD
 K PSGOEE D ^PSGOETO S PSJORD=PSGORD I PSGOEAV D
 .I '$D(PSGOEE),+PSJSYSU=3 D EN^PSGPEN(PSGORD)
 .D SETOC^PSJNEWOC(PSGORD) ;RTC 178789 Store allergy if auto vf is on
 D GETUD^PSJLMGUD(PSGP,PSGORD),ENSFE^PSGOEE0(PSGP,PSGORD),^PSGOE1,EN^VALM("PSJ LM UD ACTION")
 ;RTC 178789 - store allery if not verified the newly copied order
 I ($G(PSGORD)["P"),($P($G(^PS(53.1,+PSGORD,0)),U,9)="N"),($G(PSJOCFG)="COPY UD") D SETOC^PSJNEWOC(PSGORD)
 ;
 S PSGCANFL=0,(PSGORD,PSJORD)=OLDON W !!,"You are finished with the new order.",!,"The following ACTION prompt is for the original order."
 K DIR S DIR(0)="E" D ^DIR K DIR
ORIG ;Redisplay original order
 D GETUD^PSJLMGUD(PSGP,OLDON),INIT^PSJLMUDE(PSGP,OLDON)
DONE ;
 K %,%H,%I,DA,F,N,PSGODN,PSGODF,PSGS0XT,PSGS0Y,PSGNESD,PSGTOL,PSGTOO,PSGUOW,X,Y,^PS(53.45,PSJSYSP,1),^PS(53.45,PSJSYSP,2)
 K PSGPR,PSGMR,PSGSM,PSGHSM,PSGST,PSGPDRG,PSGDO,PSGNEDFD,PSGSCH,PSGNEFD
 Q
 ;
CH ;
 W !!?2,"Answer 'YES' to have a new, non-verified order created for this patient,",!,"using the information from this order.  (The START and STOP dates will be",!,"recalculated.)  Enter 'NO' (or '^') to stop now." Q
 ;
WH ;
 W !!?2,"Answer 'YES' to take action on this new order.  Enter 'NO' (or '^') to return",!,"to the original order now." Q
 ;
OC ;Perform order checks
 NEW PSJDD,X,PSJALLGY
 ;*286 - Order checks on current dispense drugs
 F X=0:0 S X=$O(^PS(53.45,PSJSYSP,2,X)) Q:'X  D
 . S PSJDD=$G(^PS(53.45,PSJSYSP,2,X,0))
 . I +PSJDD S PSJALLGY(+PSJDD)=""
 ;S X=+$O(PSGODN(1,0)) Q:'X  S PSJDD=+$G(PSGODN(1,X)) Q:'PSJDD
 S PSJDD=+$O(PSJALLGY(0)) Q:'PSJDD
 D FULL^VALM1
 D ENDDC^PSGSICHK($G(PSGP),PSJDD) Q:$D(PSGORQF)
 D IN^PSJOCDS($G(PSGORD),"UD",PSJDD)
 Q
