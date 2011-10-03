ECXSETU1 ;BIR/DMA,CML,PTD-Get Movements and Treating Speciality for Setup ; [ 01/10/97  4:34 PM ]
 ;;3.0;DSS EXTRACTS;**8,24**;Dec 22, 1997
EN ;entry point
 ;get movements
 S ECFILE=727.821,ECRN=0,QFLG=0
 F DFN=0:0 S DFN=$O(^TMP($J,DFN)) Q:'DFN  F ECCA=0:0 S ECCA=$O(^TMP($J,DFN,ECCA)) Q:'ECCA  S ECM=$O(^DGPM("APMV",DFN,ECCA,ECD0)) I ECM S ECDA=$O(^(ECM,0)) I ECDA,ECDA'=ECCA,$D(^DGPM(+ECDA,0)) S EC=^(0),DFN=+$P(EC,U,3) D  Q:QFLG
 .Q:'$D(^DPT(DFN,0))  S D0=^DPT(DFN,0),ECDAT=ECED,ECTM=$E($P(ECDAT,".",2)_"000000",1,6),ECXYM=$$ECXYM^ECXUTL(ECDAT),ECMT=$P(EC,U,18),ECMT=$S(ECMT<22:ECMT,ECMT<25:4,ECMT=25:3,ECMT=26:2,1:ECMT)
 .;from absence becomes transfer, from auth to unauth becomes to unauth
 .;from unauth to auth becomes to auth
 .S WTO=$P(EC,U,6),WTO=$P($G(^DIC(42,+WTO,44)),U)
 .S ECCA=$P(EC,U,14),EC=^DGPM(ECCA,0),ECA=$E($P(EC,U),".")
 .;use admit as previous transfer
 .S W=$P(EC,U,6),FAC=$P($G(^DIC(42,+W,0)),U,11),W=$P($G(^DIC(42,+W,44)),U)
 .S ECODE=FAC_U_DFN_U_$P(D0,U,9)_U_$E($P($P(D0,U),",")_"    ",1,4)_"^3^"_$$ECXDATE^ECXUTL(ECD,ECXYM)_U
 .S ECA=$P($G(^DGPM(+$P(EC,U,14),0)),U)
 .S X1=ECD,X2=$P(EC,U) D ^%DTC S LOS=X
 .S ECODE=ECODE_U_$$ECXDATE^ECXUTL(ECA,ECXYM)_"^^"_ECDA_"^2^"_W_"^^"_LOS_"^^"_ECMT_U_ECTM_U_WTO_U_$$ECXTIME^ECXUTL(ECA)_"^^"
 .;fac^dfn^ssn^name^in/out^day^^adm date^disc date^mov #^type^losing ward^treat spec ^los^attending physician^movement type^mov time^gaining ward^adm time
 .S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 .S ^ECX(ECFILE,EC7,0)=EC7_U_ECXYM_U_U_ECODE,ECRN=ECRN+1
 .S $P(^ECX(ECFILE,EC7,1),U,2)=""
 .S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 .I $D(ZTQUEUED),ECRN>499,'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 S ECLAST=$O(^ECX(ECFILE,999999999),-1),ECTOTAL=$P(^ECX(ECFILE,0),U,4)+ECRN,$P(^(0),U,3,4)=ECLAST_U_ECTOTAL K ECLAST,ECTOTAL
 I QFLG S ZTSTOP=1 Q
 ;
 ;get treating specialty
 S ECFILE=727.822,ECRN=0,QFLG=0
 F DFN=0:0 S DFN=$O(^TMP($J,DFN)) Q:'DFN  F ECCA=0:0 S ECCA=$O(^TMP($J,DFN,ECCA)) Q:'ECCA  S ECM=$O(^DGPM("ATS",DFN,ECCA,ECD0)) I ECM S EC=$O(^(ECM,0)),ECDA=+$O(^(+EC,0)) I $D(^DGPM(ECDA,0)) S EC=^(0) D  Q:QFLG
 .Q:'$D(^DPT(DFN,0))  S D0=^(0),ECMT=$P(EC,U,18),ECDAT=ECED,ECTM=$E($P(ECDAT,".",2)_"000000",1,6),ECXYM=$$ECXYM^ECXUTL(ECDAT)
 .S ECA=^DGPM($P(EC,U,14),0),EC=ECA
 .S X1=ECD,(ECA,X2)=$P(EC,U) D ^%DTC S LOS=X
 .S ECTRT="" F ECDA=ECCA:1:ECCA+10 S EC=$G(^DGPM(ECDA,0)) I $P(EC,U,14)=ECCA,$P(EC,U,2)=6 S ECTRT=$P($G(^DIC(45.7,+$P(EC,U,9),0)),U,2) Q
 .;get treating specialty associated with admission
 .S ECODE=U_DFN_U_$P(D0,U,9)_U_$E($P($P(D0,U),",")_"    ",1,4)_"^3^"_$$ECXDATE^ECXUTL(ECD,ECXYM)_"^^"_$$ECXDATE^ECXUTL(ECA,ECXYM)_"^^"_ECDA_"^6^^"_ECTRT_U_LOS
 .S ECODE=ECODE_U_ECPRO_$P(EC,U,19)_U_ECMT_U_ECTM_U_$$ECXTIME^ECXUTL(+ECA)_"^^^"
 .;fac^dfn^ssn^name^i/o^day^product^adm date^dis date^mov#^type^gaining ward^treat spec^duration^attending physician^movement type^trt time^adm time
 .S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 .S ^ECX(ECFILE,EC7,0)=EC7_U_ECXYM_U_U_ECODE,ECRN=ECRN+1
 .S $P(^ECX(ECFILE,EC7,1),U,8)=""
 .S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 .I $D(ZTQUEUED),ECRN>499,'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 S ECLAST=$O(^ECX(ECFILE,999999999),-1),ECTOTAL=$P(^ECX(ECFILE,0),U,4)+ECRN,$P(^(0),U,3,4)=ECLAST_U_ECTOTAL K ECLAST,ECTOTAL
 I QFLG S ZTSTOP=1 Q
 ;
LOAD ; into files 727.802, 727.808 and 727.818
 S ECCNT=0,ECVER=7
 I $$S^%ZTLOAD S ZTSTOP=1 K ^TMP($J) Q
 S ECFR=727.82,ECFILE=727.802,ECPACK="Admission (setup)",ECHEAD="ADM",ECGRP="ADMS",ECYM="" D MOVE
 I $$S^%ZTLOAD S ZTSTOP=1 K ^TMP($J) Q
 S ECFR=727.821,ECFILE=727.808,ECPACK="Movement (setup)",ECHEAD="MOV",ECGRP="MOVS",ECYM="" D MOVE
 I $$S^%ZTLOAD S ZTSTOP=1 K ^TMP($J) Q
 S ECFR=727.822,ECFILE=727.817,ECPACK="Treating specialty change (setup)",ECHEAD="TRT",ECGRP="TREAT",ECYM="" D MOVE
 S ^ECX(728,1,"S")=DT ;clear running flag set done date
 K XMY S Y=$$HTE^XLFDT($H)
 S XMDUZ="DSS SYSTEM",XMSUB="SETUP EXTRACT FOR DSS",XMY("G.DSS-ADMS@"_^XMB("NETNAME"))=""
 S ECM(1)="The DSS setup extract completed on "_$P(Y,"@")_" at "_$P(Y,"@",2),ECM(2)="A total of "_ECCNT_" extract file entries were created."
 S XMTEXT="ECM(" D ^XMD
 S ZTREQ="@" K ^TMP($J)
 Q
 ;
MOVE ;
 F  S ECYM=$O(^ECX(ECFR,"AM",ECYM)) Q:ECYM=""  D UP727 D
 .F EC0=0:0 S EC0=$O(^ECX(ECFR,"AM",ECYM,EC0)) Q:'EC0  S ECD=^ECX(ECFR,EC0,0),$P(ECD,U,3)=EC3 D
 ..S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 ..S ^ECX(ECFILE,EC7,0)=EC7_U_$P(ECD,U,2,200),ECRN=ECRN+1 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 ..S ^ECX(ECFILE,EC7,1)=^ECX(ECFR,EC0,1)
 ..S DIK="^ECX("_ECFR_",",DA=EC0 D ^DIK
 ..S ECCNT=ECCNT+1
 .S $P(^ECX(727,EC3,0),U,6)=ECRN
 .S ECLAST=$O(^ECX(ECFILE,999999999),-1),ECTOTAL=$P(^ECX(ECFILE,0),U,4)+ECRN,$P(^(0),U,3,4)=ECLAST_U_ECTOTAL K ECLAST,ECTOTAL
 Q
 ;
UP727 ;update file #727
 S EC=$P(^ECX(727,0),U,3)+1,$P(^(0),U,3,4)=EC_U_EC
 S ^ECX(727,EC,0)=EC_U_DT_U_ECPACK_U_ECED_U_ECED
 S ^ECX(727,EC,"HEAD")=ECHEAD
 S ^ECX(727,EC,"FILE")=ECFILE
 S ^ECX(727,EC,"GRP")=ECGRP,^ECX(727,EC,"DIV")=ECINST
 S DA=EC,DIK="^ECX(727," D IX^DIK K DA,DIK
 S ECRN=0,EC3=EC
 Q
