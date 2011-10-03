ECXTRT ;ALB/JAP,BIR/DMA,CML,PTD-Treating Specialty Change Extract ;9/8/10  16:25
 ;;3.0;DSS EXTRACTS;**1,8,17,24,33,35,39,46,49,84,107,105,127**;Dec 22, 1997;Build 36
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; start package specific extract
 N LOC,SPC,TRT,WRD
 S QFLG=0
 K ECXDD D FIELD^DID(405,.19,,"SPECIFIER","ECXDD")
 S ECPRO=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 K ^TMP($J,"ECXTMP") S TRT=0
 F  S TRT=$O(^DIC(45.7,TRT)) Q:+TRT=0  S SPC=$P(^DIC(45.7,TRT,0),U,2),^TMP($J,"ECXTMP",TRT)=SPC
 S ECED=ECED+.3,ECD=ECSD1
 ;loop through type 6 movements to get treating specialty and provider changes
 F  S ECD=$O(^DGPM("ATT6",ECD)),ECDA=0 Q:('ECD)!(ECD>ECED)!(QFLG)  F  S ECDA=$O(^DGPM("ATT6",ECD,ECDA)) Q:'ECDA  D  Q:QFLG
 .I $D(^DGPM(ECDA,0)) S EC=^(0),ECXDFN=+$P(EC,U,3) D  Q:QFLG
 ..S ECXMVD1=$P(EC,U),WRD=$P(EC,U,6)
 ..;
 ..;- Call sets ECXA (In/Out indicator)
 ..Q:'$$PATDEM^ECXUTL2(ECXDFN,ECXMVD1,"1;",13)
 ..S ECMT=$P(EC,U,18),ECXADM=$P(EC,U,14),ECXADT=$P($G(^DGPM(ECXADM,0)),U)
 ..;skip the record if its the admission treat. spec. change for this episode of care
 ..Q:ECXADM=$P(EC,U,24)
 ..S (ECXLOS,ECXLOSA,ECXLOSP)="" S ECXDSSD=""
 ..K LOC D SETLOC(ECXDFN,ECXADM,ECPRO,.LOC)
 ..;get data for current (new) ts movement
 ..S ECD1=9999999.9999999-ECXMVD1
 ..D FINDLOC(ECD1,.LOC,.ECXSPCN,.ECXPRVN,.ECXATTN,.ECXMOVN,.ECXTRTN)
 ..Q:ECXSPCN=""
 ..S ECD2=$O(LOC(ECD1)) Q:ECD2=""
 ..S ECXMVD2=9999999.9999999-ECD2
 ..;get data for previous (losing) ts movement
 ..D FINDLOC(ECD2,.LOC,.ECXSPCL,.ECXPRVL,.ECXATTL,.ECXMOVL,.ECXTRTL)
 ..;if ts has changed, find los on losing ts
 ..D:ECXTRTL'=ECXTRTN PREVTRT^ECXTRT1(.LOC,ECD1,ECD2,ECXTRTL,.ECXLOS)
 ..;whether ts has changed or not, see if primary provider has changed
 ..;don't bother if there's no data on current primary provider or no change in provider
 ..D:(ECXPRVN'="")&(ECXPRVN'=ECXPRVL) PREVPRV^ECXTRT1(.LOC,ECD1,ECXPRVN,ECD2,.ECXPRVL,.ECXLOSP)
 ..;whether ts has changed or not, see if attending physician has changed
 ..;don't bother if there's no data on current attending physician or no change in attending
 ..D:(ECXATTN'="")&(ECXATTN'=ECXATTL) PREVATT^ECXTRT1(.LOC,ECD1,ECXATTN,ECD2,.ECXATTL,.ECXLOSA)
 ..S ECXDATE=$$ECXDATE^ECXUTL(ECXMVD1,ECXYM),ECXTIME=$$ECXTIME^ECXUTL(ECXMVD1)
 ..S ECXADMDT=$$ECXDATE^ECXUTL(ECXADT,ECXYM),ECXADMTM=$$ECXTIME^ECXUTL(ECXADT),ECXDCDT=""
 ..;- Production Division
 ..S ECXPDIV=""
 ..I ECXLOGIC>2003 S ECXPDIV=$S(WRD="":"",1:$$NPDIV(WRD))
 ..;
 ..;- Observation patient indicator (YES/NO)
 ..S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 ..;
 ..;- Chg outpat with movemnt/discharge to inpat (to comply w/existing business rule)
 ..I ECXA="O"&(ECXOBS="NO")&(ECXMVD1) S ECXA="I"
 ..; ******* - PATCH 127, ADD PATCAT CODE ********
 ..S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ..;
 ..;- Get providers person classes
 .. S ECXATLPC=$$PRVCLASS^ECXUTL($E(ECXATTL,2,999),ECXADT)
 .. S ECATLNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXATTL,2,999),ECXADT)
 .. S:+ECATLNPI'>0 ECATLNPI="" S ECATLNPI=$P(ECATLNPI,U)
 .. S ECXPRNPC=$$PRVCLASS^ECXUTL($E(ECXPRVN,2,999),ECXADT)
 .. S ECPRVNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXPRVN,2,999),ECXADT)
 .. S:+ECPRVNPI'>0 ECPRVNPI="" S ECPRVNPI=$P(ECPRVNPI,U)
 .. S ECXATNPC=$$PRVCLASS^ECXUTL($E(ECXATTN,2,999),ECXADT)
 .. S ECATTNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXATTN,2,999),ECXADT)
 .. S:+ECATTNPI'>0 ECATTNPI="" S ECATTNPI=$P(ECATTNPI,U)
 .. S ECXPRLPC=$$PRVCLASS^ECXUTL($E(ECXPRVL,2,999),ECXADT)
 .. S ECPRLNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXPRVL,2,999),ECXADT)
 .. S:+ECPRLNPI'>0 ECPRLNPI="" S ECPRLNPI=$P(ECPRLNPI,U)
 ..;
 ..;- If no encounter number, don't file record
 ..S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADT,,ECXTS,ECXOBS,ECHEAD,,)
 ..D:ECXENC'="" FILE^ECXTRT2
 ;for nhcu episodes with intervening asih stays, the los calculated here is not accurate,
 ;but it never has been; this is best solution within current extract framework;
 ;at discharge the los calculated for nhcu episodes will be the los since admission w/o asih los subtracted;
 ;
 ;loop through discharges to get last treating specialty
 S ECD=ECSD1
 F  S ECD=$O(^DGPM("ATT3",ECD)),ECDA=0 Q:'ECD  Q:ECD>ECED  F  S ECDA=$O(^DGPM("ATT3",ECD,ECDA)) Q:'ECDA  D  Q:QFLG
 .I $D(^DGPM(ECDA,0)) S EC=^(0),ECXDFN=+$P(EC,U,3) D  Q:QFLG
 ..S ECXMVD1=$P(EC,U),WRD=$P(EC,U,6)
 ..S (ECXDATE,ECXDCDT)=$$ECXDATE^ECXUTL(ECXMVD1,ECXYM),ECXTIME=$$ECXTIME^ECXUTL(ECXMVD1)
 ..I ECXDCDT'>0 S ECXDCDT=""
 ..S ECMT=$P(EC,U,18),ECXADM=$P(EC,U,14),ECXADT=$P($G(^DGPM(ECXADM,0)),U,1)
 ..S (ECXTRTN,ECXSPCN,ECXPRVN,ECXATTN)="" S (ECXLOS,ECXLOSA,ECXLOSP)="" S ECXDSSD=""
 ..K LOC D SETLOC(ECXDFN,ECXADM,ECPRO,.LOC)
 ..S ECD1=9999999.9999999-ECXMVD1
 ..;get ts change just before d/c
 ..S ECD2=$O(LOC(ECD1)),ECXMVD2=9999999.9999999-ECD2
 ..D FINDLOC(ECD2,.LOC,.ECXSPCL,.ECXPRVL,.ECXATTL,.ECXMOVL,.ECXTRTL)
 ..;
 ..;- Call sets ECXA (In/Out indicator) using date before discharge
 ..Q:'$$PATDEM^ECXUTL2(ECXDFN,ECXMVD2,"1;",13)
 ..S ECXADMDT=$$ECXDATE^ECXUTL(ECXADT,ECXYM),ECXADMTM=$$ECXTIME^ECXUTL(ECXADT)
 ..;if closest ts change is admission ts, cant go back any further
 ..S TRT=$O(LOC(ECD2,0)),REC=$O(LOC(ECD2,TRT,0))
 ..I REC=ECXADM D
 ...S X1=ECXMVD1,X2=ECXMVD2 D ^%DTC S ECXLOS=X
 ...I ECXPRVL'="" S X1=ECXMVD1,X2=ECXMVD2 D ^%DTC S ECXLOSP=X
 ...I ECXATTL'="" S X1=ECXMVD1,X2=ECXMVD2 D ^%DTC S ECXLOSA=X
 ..;otherwise, need to find when change to last ts occurred
 ..I REC'=ECXADM D
 ...D PREVTRT^ECXTRT1(.LOC,ECD1,ECD2,ECXTRTL,.ECXLOS)
 ...D PREVPRV^ECXTRT1(.LOC,ECD1,ECXPRVN,ECD2,.ECXPRVL,.ECXLOSP)
 ...D PREVATT^ECXTRT1(.LOC,ECD1,ECXATTN,ECD2,.ECXATTL,.ECXLOSA)
 ..S:ECXLOS>9999 ECXLOS=9999 S:ECXLOSA>9999 ECXLOSA=9999
 ..S:ECXLOSP>9999 ECXLOSP=9999
 ..;- Production Division
 ..S ECXPDIV=""
 ..I ECXLOGIC>2003 S ECXPDIV=$S(WRD="":"",1:$$NPDIV(WRD))
 ..;
 ..;- Observation patient indicator (YES/NO)
 ..S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 ..;
 ..;- Chg outpat with movemnt/discharge to inpat (to comply w/existing business rule)
 ..I ECXA="O"&(ECXOBS="NO")&(ECXMVD1) S ECXA="I"
 ..; ******* - PATCH 127, ADD PATCAT CODE ********
 ..S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ..;
 ..;- Get providers person classes
 .. S ECXATLPC=$$PRVCLASS^ECXUTL($E(ECXATTL,2,999),ECXADT)
 .. S ECATLNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXATTL,2,999),ECXADT)
 .. S:+ECATLNPI'>0 ECATLNPI="" S ECATLNPI=$P(ECATLNPI,U)
 .. S ECXPRNPC=$$PRVCLASS^ECXUTL($E(ECXPRVN,2,999),ECXADT)
 .. S ECPRVNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXPRVN,2,999),ECXADT)
 .. S:+ECPRVNPI'>0 ECPRVNPI="" S ECPRVNPI=$P(ECPRVNPI,U)
 .. S ECXATNPC=$$PRVCLASS^ECXUTL($E(ECXATTN,2,999),ECXADT)
 .. S ECATTNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXATTN,2,999),ECXADT)
 .. S:+ECATTNPI'>0 ECATTNPI="" S ECATTNPI=$P(ECATTNPI,U)
 .. S ECXPRLPC=$$PRVCLASS^ECXUTL($E(ECXPRVL,2,999),ECXADT)
 .. S ECPRLNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXPRVL,2,999),ECXADT)
 .. S:+ECPRLNPI'>0 ECPRLNPI="" S ECPRLNPI=$P(ECPRLNPI,U)
 ..;
 ..;- If no encounter number don't file record
 ..S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADT,,ECXTS,ECXOBS,ECHEAD,,)
 ..D:ECXENC'="" FILE^ECXTRT2
 D KPATDEM^ECXUTL2
 Q
 ;
NPDIV(WRD) ;National Production Division
 N DIV
 S DIV=$$GET1^DIQ(42,WRD,.015,"I")
 Q $S(DIV="":"",1:$$GETDIV^ECXDEPT(DIV))
 ;
SETLOC(ECXDFN,ECXADM,ECXPRO,ECXLOC) ;setup the local array from the ATS index
 ; output
 ; ECXLOC = local array (passed by reference)
 ;
 N SUB3,SUB4,SUB5,SPC,PRV,ATT,MOV
 S SUB3=0
 F  S SUB3=$O(^DGPM("ATS",ECXDFN,ECXADM,SUB3)) Q:SUB3=""  D
 .S (SUB4,SUB5)=0
 .S SUB4=$O(^DGPM("ATS",ECXDFN,ECXADM,SUB3,SUB4))
 .S SUB5=$O(^DGPM("ATS",ECXDFN,ECXADM,SUB3,SUB4,SUB5))
 .S ECXLOC(SUB3,SUB4,SUB5)="",SPC=$G(^TMP($J,"ECXTMP",SUB4))
 .S DATA=$G(^DGPM(SUB5,0)),PRV=$P(DATA,U,8),ATT=$P(DATA,U,19)
 .S MOV=$P(DATA,U,14)
 .S:PRV]"" PRV=ECXPRO_PRV S:ATT]"" ATT=ECXPRO_ATT
 .S ECXLOC(SUB3,SUB4,SUB5)=SPC_U_PRV_U_ATT_U_MOV
 Q
 ;
FINDLOC(ECXTSD,ECXLOC,ECXSPC,ECXPRV,ECXATT,ECXMOV,ECXTRT) ;find local array node for current ts movement
 ;   input
 ;   ECXTSD = inverse date/time for current ts movement; required
 ;   ECXLOC = local array; passed by reference; required
 ;   output; data from record contained in MOVE
 ;   ECXSPC = piece 1 of LOC (passed by reference)
 ;   ECXPRV = piece 2 of LOC concatenated to PRO (passed by reference)
 ;   ECXATT = piece 3 of LOC concatenated to PRO (passed by reference)
 ;   ECXMOV = piece 4 of LOC (passed by reference)
 ;   ECXTRT = pointer to file #45.7
 ;
 N SUB3,SUB4,SUB5,LOC
 S (ECXSPC,ECXPRV,ECXATT,ECXMOV)=""
 S SUB3=ECXTSD
 I $D(ECXLOC(SUB3)) D
 .S SUB4=$O(ECXLOC(SUB3,0)),SUB5=$O(ECXLOC(SUB3,SUB4,0))
 .S LOC=ECXLOC(SUB3,SUB4,SUB5),ECXTRT=SUB4,ECXSPC=$P(LOC,U)
 .S ECXPRV=$P(LOC,U,2),ECXATT=$P(LOC,U,3),ECXMOV=$P(LOC,U,4)
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="TRT"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL
 Q
