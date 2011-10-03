ECXLABO ;BIR/MAM,DMA,CML-Lab Extract for DSS (Old Version - W/O LMIP Codes); [ 11/22/96  5:28 PM ]
 ;;3.0;DSS EXTRACTS;**11**;Dec 22, 1997
V ;;2.0T11;DSS EXTRACTS;**24**;DEC 18,1996
 ;This routine was originally called ECXLAB1, as called from the DSS menu.  Now ECXLAB1 is the driver routine to call ECXLABO (old format) or ECXLABN (new format)
 D SETUP,^ECXTRAC
END D ^ECXKILL
 Q
START ; entry when queued
 S QFLG=0
 S ECED=ECED+.3
 K ECXDD D FIELD^DID(69.01,7,,"SPECIFIER","ECXDD") S ECPROF=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD ; provider points to
 S ECD=ECSD1 F  S ECD=$O(^LRO(69,ECD)),ECLRN=0 Q:'ECD  Q:ECD>ECED  F  S ECLRN=$O(^LRO(69,ECD,1,ECLRN)) Q:'ECLRN  I $D(^(ECLRN,0)) S EC1=^(0),ECDOC=ECPROF_$P(EC1,"^",6),ECLOC=$P(EC1,"^",9),EC=$G(^LR(+EC1,0)) I EC]"" D  Q:QFLG
 .S ECDT=$P(EC1,"^",5),ECTM=$$ECXTIME^ECXUTL(ECDT)
 .S (ECNA,ECSN,ECMN,ECTREAT,ECPTTM,ECPTPR)="",ECA=1
 .S ECF=$P(EC,"^",2),ECIFN=$P(EC,"^",3)
 .I ECF=2,$D(^DPT(ECIFN,0)) D
 ..S EC0=^(0),ECNA=$E($P($P(EC0,"^"),",")_"    ",1,4),ECSN=$P(EC0,"^",9) K VAIP S VAIP("D")=ECD,DFN=ECIFN D IN5^VADPT S ECMN=VAIP(1) I ECMN S ECA=3,ECTREAT=$P($G(^DIC(45.7,+VAIP(8),0)),"^",2)
 ..S ECPTTM=+$$OUTPTTM^ECXUTL3(DFN,ECDT)
 ..S:ECPTTM=0 ECPTTM=""
 ..S ECPTPR=+$$OUTPTPR^ECXUTL3(DFN,ECDT)
 ..S:ECPTPR=0 ECPTPR=""
 .K VAIP,VAERR
 .I ECF=67 S ECSN="000123456",ECNA="RFRL"
 .I ECF=67.1 S ECSN=888888888,ECNA="RSCH"
 .I ECNA]"" S J=0 F  S J=$O(^LRO(69,ECD,1,ECLRN,2,J)) Q:'J  S EC=$G(^(J,0)) I EC]"" S ECT=$P(EC,"^"),ECURG=$P(EC,"^",2),EC=+$P(EC,"^",4),ECACA=EC_"^"_$P($G(^LRO(68,EC,0)),"^",11) I EC D
 ..S ECODE=ECINST_"^"_ECIFN_"^"_ECSN_"^"_ECNA_"^"_ECA_"^"_$$ECXDATE^ECXUTL(ECD,ECXYM)_"^"_ECACA_"^"_ECT_"^"_ECURG_"^"_ECTREAT_"^"_ECLOC_"^"_ECDOC_"^"_ECMN_"^"_ECF_"^"_ECTM_"^^"_ECPTTM_"^"_ECPTPR_"^"
 ..;inst^patient (or thing) number^SSN (or equivalent)^name^in/out^day^accession area^abbreviation^test^urgency^treating spec^location^provider and file^
 ..;movement number^file^time^workload code^primary care team^primary care provider
 ..;(ECACA=acc area^abbreviation)
 ..S EC7=-$O(^ECX(ECFILE,"AINV","")) F  S EC7=EC7+1 Q:'$D(^ECX(ECFILE,EC7))
 ..S ^ECX(ECFILE,EC7,0)=EC7_"^"_EC23_"^"_ECODE,ECRN=ECRN+1 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 .I $D(ZTQUEUED),(ECRN>499),'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP S ECPACK="Laboratory",ECPIECE=1,ECRTN="START^ECXLABO",ECGRP="LAB",ECHEAD="LAB",ECFILE=727.813,ECVER=3
 Q
 ;
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
