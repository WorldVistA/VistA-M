ECXSCX ;ALB/JAP,BIR/DMA,CML,PTD-Clinic Extract ; 02/06/97 10:24 [ 03/26/97  2:10 PM ]
 ;;3.0;DSS EXTRACTS;**1,3,11,8,13,14,28**;Dec 22, 1997
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;entry point
 N QFLG,TIU
 ;get ien for tiu in file #839.7
 S DIC="^PX(839.7,",DIC(0)="X",X="TEXT INTEGRATION UTILITIES" D ^DIC S TIU=0 S:+Y>0 TIU=+Y K DIC,Y
 K ^TMP("ECXS",$J) S ECXMISS=10,ECED=ECED+.3 S SC=0,QFLG=0
 ;scheduled appts. and appended ekgs: loop through the file (#44)
 F  S SC=$O(^SC(SC)) Q:('SC)!(QFLG)  I $D(^(SC,0)) S EC=^(0) I $P(EC,U,3)="C" S ECSU=$P(EC,U,15) S:'ECSU ECSU=1 D FEEDER^ECXSCX1(SC,ECSD1,.P1,.P2,.P3,.ECST) I ECST'=6 S ECD=ECSD1 D  Q:QFLG
 .F  S ECD=$O(^SC(SC,"S",ECD)) Q:'ECD  Q:ECD>ECED  Q:QFLG  S ECDA=0 F  S ECDA=$O(^SC(SC,"S",ECD,1,ECDA)) Q:'ECDA  I $D(^(ECDA,0)) D  Q:QFLG
 ..;for each patient appointment in the date range (skip cancellations), examine the APPOINTMENT multiple in the PATIENT file (#2)
 ..I $S('$D(^SC(SC,"S",ECD,1,ECDA,"C")):1,1:$P(^("C"),U,3)]"") S PTADT=^(0),DFN=$P(PTADT,U) I $D(^DPT(+DFN,0)),$P(PTADT,U,9)="",$P($G(^DPT(DFN,"S",ECD,0)),U,2)'["C" D
 ...D PAT,AOIRPOW^ECXUTL(DFN,.ECXAIP)
 ...S ECL=$P(PTADT,U,2),ECL=$$RJ^XLFSTR(ECL,3,0),ECOB=$G(^SC(SC,"S",ECD,1,ECDA,"OB"))]""
 ...;don't continue with record creation if the clinic appointment can't be found in subfile 2.98
 ...Q:'$D(^DPT(DFN,"S",ECD,0))  Q:$P(^DPT(DFN,"S",ECD,0),U)'=SC
 ...K EC2 S EC2=^DPT(DFN,"S",ECD,0) S ECN=$S($P(EC2,U,2)="N":"N",$P(EC2,U,2)="NA":"N",$P(EC2,U,2)="NT":"Q",1:"0")
 ...S ECIEN=$P(EC2,U,20),ECEKG=$P(EC2,U,5)
 ...I ECST'=3 S ECFD=P1_P2_ECL_P3_ECN,ECO1=ECO1_U_ECFD_U_ECOB_U_SC D API,FILE
 ...I ECST=3 S ECFD=P1_"000"_ECL_P3_ECN,ECO1=ECO1_U_ECFD_U_ECOB_U_SC D API,FILE
 ...I ECST=3 S ECFD=P2_"000"_ECL_P3_ECN,ECO1=ECO1_U_ECFD_U_ECOB_U_SC D API,FILE
 ...;check for appended visits for EKG (107); if regular appt. is a no-show, append is a no-show
 ...Q:'ECEKG  D
 ....S $P(ECODE,U,10,12)="1070000280000"_ECN_U_U
 ....S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 ....S $P(ECODE,U,1)=EC7
 ....D FILE2
 ;Dispositions, stand-alones, and appended lab and x-ray: loop through the file (#409.68) for date range
 S ECD=ECSD1
 F  S ECD=$O(^SCE("B",ECD)) Q:'ECD!(ECD>ECED)  S ECIEN=0 D  Q:QFLG
 .F  S ECIEN=$O(^SCE("B",ECD,ECIEN)) Q:'ECIEN  D  Q:QFLG
 ..;quit if no outpatient encounter zero node
 ..Q:'$D(^SCE(ECIEN,0))
 ..;fd=1>x-ray or lab record, fd=2>disposition, fd=0>stand-alone visit
 ..S FD=0,NCNTR=^SCE(ECIEN,0),STOP=$P($G(^DIC(40.7,+$P(NCNTR,U,3),0)),U,2)
 ..S ENELG=$P($G(^DIC(8,+$P(NCNTR,U,13),0)),U,9) I ENELG S ENELG=$C(ENELG+64)
 ..;quit if no clinic stop code for encounter
 ..Q:'STOP
 ..;clinic stop code equals 105 (x-ray) or 108 (lab)
 ..I (STOP=105)!(STOP=108) S FD=1 D BLD Q
 ..;quit if encounter not stop code addition or disposition
 ..I ($P(NCNTR,U,8)'=2),($P(NCNTR,U,8)'=3) Q
 ..;originating process type equals disposition
 ..I $P(NCNTR,U,8)=3 S FD=2 D BLD Q
 ..;else originating process type equals stop code addition (stand-alone)
 ..;quit if there is a parent encounter pointer.
 ..Q:$P($G(NCNTR),U,6)
 ..D BLD
 ;send missing clinic msg if needed
 D:$D(^TMP("ECXS",$J)) EN^ECXSCX1
 K EC,EC1,EC2,ECA,ECCPT,ECCSC,ECD,ECDA,ECEKG,ECFD,ECICD,ECIEN,ECL,ECMN,ECN,ECO1,ECO2,ECOB,ECODE,ECPROV,ECPTPR,ECPTTM,ECREC,ECSC,ECST,ECSU,ECTS,ECVAL,ECVIS
 K C,CPT,DFN,ELIG,P1,P11,P2,P3,PTADT,SC,VAERR,VAIP,SEX,ADDR,STATE,CNTY,ENELG,PAYOR,SAI,ENR,MST,MSTEI
 Q
 ;
BLD ;build record from outpatient encounter
 S DFN=+$P(NCNTR,U,2),LOC=$P(NCNTR,U,4),ECSU=1 S:LOC ECSU=$P(^SC(LOC,0),U,15)
 Q:'$D(^DPT(DFN,0))
 D PAT,AOIRPOW^ECXUTL(DFN,.ECXAIP)
 S P1=$$RJ^XLFSTR(STOP,3,0),P2="000",P3="0000",ECST=1
 ;for x-ray and lab
 I FD=1 S ECO1=ECO1_U_P1_P2_"02800000"_U_U D API,FILE Q
 ;for dispositions
 I FD=2 S ECO1=ECO1_U_P1_"47906000000"_U_U D API,FILE Q
 ;for stand-alone visits
 I FD=0,LOC,$D(^SC(LOC,0)) D
 .S SC=LOC,APTLEN=29
 .D FEEDER^ECXSCX1(SC,ECD,.P1,.P2,.P3,.ECST)
 .I ECST'=6 D
 ..D API
 ..I $D(^TMP("PXKENC",$J,ECVIS,"VST",ECVIS,812)) D
 ...S ECXSRCE=$P(^TMP("PXKENC",$J,ECVIS,"VST",ECVIS,812),U,3)
 ...I ECXSRCE=TIU S APTLEN=+$P($G(^SC(SC,"SL")),U,1) S:APTLEN=0 APTLEN=29
 ..S APTLEN=$TR($J(APTLEN,3)," ","0")
 ..S ECO1=ECO1_U_P1_P2_APTLEN_P3_"0"_U_U_SC
 ..D FILE
 Q
 ;
FILE ;finish record setup
 ;node0
 ;facility^dfn^ssn^name^in/out status^day^feeder key^overbook^sc^mov #^treat spec^time^primary care team^
 ;primary care provider^provider^CPT code^ICD-9 code^dob^eligibility^vet^race^
 ;ao status^ao visit^ir status^ir visit^pow status^pow location^provider person class
 ;node1
 ;mpi^dss dept^sex^zip+4^pc provider npi^provider npi^encounter elig^mst status^mst indicator
 ;cpt2^cpt3^cpt4^cpt5^cpt6^cpt7^cpt8^cpt9^cpt10^cpt11^sharing payor^sharing insurance^enr location^state^county^pc prov person class
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23
 S ECODE=ECODE_U_ECO1
 S $P(ECODE,U,8)=ECA,ECODE=ECODE_U_ECMN_U_ECTS_U_$$ECXTIME^ECXUTL(ECD)_U_ECPTTM_U_ECPTPR_U_ECPROV_U_ECCPT_U_ECICD
 S ECODE=ECODE_U_$$ECXDOB^ECXUTL(DOB)_U_ELIG_U_VET_U_RACE
 S ECODE=ECODE_U_ECXAIP("AO")_U_ECVAO_U_ECXAIP("IR")_U_ECVIR_U_ECXAIP("POW")_U_ECXAIP("POWL")_U_ECXPRPC
 S CPT="" F C=2:1:11 S CPT=CPT_CPT(C) I C<11 S CPT=CPT_U
 S ECODE1=U_U_SEX_U_ZIP_U_U_U_ENELG_U_MST_U_MSTEI_U_CPT_U_PAYOR_U_SAI_U_ENR_U_STATE_U_CNTY_U_ECCLAS
 D CUT^ECXSCX1(.ECODE,.ECODE1)
 D FILE2
 Q
 ;
FILE2 ;file record
 N DA,DIK
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 I $D(ZTQUEUED),ECRN>499,'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="CLI"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
PAT ;patient file data
 N VAPA
 S EC1=^DPT(DFN,0)
 S ECO1=ECSU_U_DFN_U_$P(EC1,U,9)_U_$E($P($P(EC1,U),",")_"    ",1,4)_U_U_$$ECXDATE^ECXUTL(ECD,ECXYM)
 S ELIG=$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),U,9) I ELIG S ELIG=$C(ELIG+64)
 S SEX=$P(EC1,U,2),DOB=$P(EC1,U,3),VET=$P($G(^DPT(DFN,"VET")),U),RACE=$P($G(^DIC(10,+$P(EC1,U,6),0)),U,2)
 D ADD^VADPT
 S STATE=VAPA(5),CNTY=VAPA(7),ZIP=$P(VAPA(11),U,2)
 S STATE=$P($G(^DIC(5,+STATE,0)),U,3),CNTY=$P($G(^DIC(5,+STATE,1,+CNTY,0)),U,3)
 S ENR=$P($G(^DPT(DFN,"ENR")),U,2) I ENR D
 .S DIC="^DIC(4,",DA=ENR,DR="99;",DIQ(0)="I",DIQ="ENR"
 .D EN^DIQ1 S ENR=ENR(4,ENR,99,"I")
 .K DIC,DIQ,DA,DR
 S (MST,MSTEI)=""
 ;get visn 19 sharing agreement data
 D VISN19^ECXUTL2(DFN,.PAYOR,.SAI)
 Q
API ;call external utilities
 ;determine in/out status and primary care
 N X,PROV
 F C=2:1:11 S CPT(C)=""
 S X=$$INP^ECXUTL2(DFN,ECD),ECA=$P(X,U,1),ECMN=$P(X,U,2),ECTS=$P(X,U,3)
 S X=$$PRIMARY^ECXUTL2(DFN,ECD),ECPTTM=$P(X,U,1),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3)
 ;call pce api for cpt code, diagnosis/provider designated as primary
 S ENELG="",ECPROV="",ECXPRPC="",ECCPT=99199,ECICD=799.9,ECVAO="",ECVIR=""
 I 'ECIEN Q
 I ECIEN D
 .S ECVIS=+$P($G(^SCE(ECIEN,0)),U,5)
 .S ENELG=+$P($G(^SCE(ECIEN,0)),U,13),ENELG=$P($G(^DIC(8,ENELG,0)),U,9)
 .I ENELG S ENELG=$C(ENELG+64)
 I 'ECVIS Q
 I ECVIS D ENCEVENT^PXAPI(ECVIS)
 I $O(^TMP("PXKENC",$J,ECVIS,""))']"" Q
 ;get icd9 code; else use 799.9
 I $O(^TMP("PXKENC",$J,ECVIS,"POV",0)) D
 .S (ECREC,ECVAL)=0
 .F  S ECREC=$O(^TMP("PXKENC",$J,ECVIS,"POV",ECREC)) Q:'ECREC  S:($P(^TMP("PXKENC",$J,ECVIS,"POV",ECREC,0),U,12)="P") ECVAL=+^(0) Q:$P(^TMP("PXKENC",$J,ECVIS,"POV",ECREC,0),U,12)="P"
 .I 'ECVAL S ECREC=$O(^TMP("PXKENC",$J,ECVIS,"POV",0)) I ECREC S ECVAL=+^(ECREC,0)
 .I ECVAL S ECICD=$P($G(^ICD9(ECVAL,0)),U)
 ;get first provider designated as primary; if no primary, then get first physician provider; if no physician, then get first provider; if no "prv" array nodes, use null.
 I $O(^TMP("PXKENC",$J,ECVIS,"PRV",0)) D
 .S (ECREC,ECVAL)=0
 .F  S ECREC=$O(^TMP("PXKENC",$J,ECVIS,"PRV",ECREC)) Q:'ECREC  S:($P(^TMP("PXKENC",$J,ECVIS,"PRV",ECREC,0),U,4)="P") ECVAL=+^(0) Q:$P(^TMP("PXKENC",$J,ECVIS,"PRV",ECREC,0),U,4)="P"
 .I ECVAL S ECPROV=ECVAL,ECXPRPC=$$PRVCLASS^ECXUTL(ECPROV,ECD)
 .I 'ECVAL S ECREC=0 D
 ..F  S ECREC=$O(^TMP("PXKENC",$J,ECVIS,"PRV",ECREC)) Q:'ECREC  D  Q:ECVAL
 ...S ECVAL=+^TMP("PXKENC",$J,ECVIS,"PRV",ECREC,0) Q:'ECVAL
 ...S ECXPRPC=$$PRVCLASS^ECXUTL(ECVAL,ECD) Q:ECXPRPC=""
 ...S NUM=$E(ECXPRPC,2,7) S:(NUM<110000)!(NUM>119999) ECVAL=0,ECXPRPC=""
 ...I ECVAL S ECPROV=ECVAL
 .I 'ECVAL D
 ..S ECREC=$O(^TMP("PXKENC",$J,ECVIS,"PRV",0)) Q:'ECREC  S ECVAL=+^(ECREC,0)
 ..I ECVAL S ECPROV=ECVAL,ECXPRPC=$$PRVCLASS^ECXUTL(ECPROV,ECD)
 .S:ECPROV]"" ECPROV="2"_ECPROV
 ;get cpt code for ien
 I $O(^TMP("PXKENC",$J,ECVIS,"CPT",0)) D
 .S (ECREC,ECVAL)=0
 .;if there's a primary provider, get a cpt associated with that provider
 .I ECPROV]"" D
 ..S PROV=$E(ECPROV,2,99)
 ..F  S ECREC=$O(^TMP("PXKENC",$J,ECVIS,"CPT",ECREC)) Q:'ECREC  D  Q:ECVAL
 ...I $D(^TMP("PXKENC",$J,ECVIS,"CPT",ECREC,12)) S:$P(^(12),U,4)=PROV ECVAL=+^TMP("PXKENC",$J,ECVIS,"CPT",ECREC,0)
 ...I ECVAL D
 ....S ECCPT=$P($G(^ICPT(ECVAL,0)),U)
 ...;get rid of the cpt record
 ...K ^TMP("PXKENC",$J,ECVIS,"CPT",ECREC)
 .I ECVAL=0 S ECREC=+$O(^TMP("PXKENC",$J,ECVIS,"CPT",0)) I ECREC S ECVAL=+^(ECREC,0)
 .I ECVAL D
 ..S ECCPT=$P($G(^ICPT(ECVAL,0)),U)
 ..;get rid of the cpt record
 ..K ^TMP("PXKENC",$J,ECVIS,"CPT",ECREC)
 .;get remaining cpt codes
 .S ECREC=0,C=2
 .F  S ECREC=$O(^TMP("PXKENC",$J,ECVIS,"CPT",ECREC)) Q:'ECREC!(C>11)  D
 ..S ECVAL=+^TMP("PXKENC",$J,ECVIS,"CPT",ECREC,0)
 ..I ECVAL S CPT(C)=$P($G(^ICPT(ECVAL,0)),U),C=C+1
 ;ao and ir
 S (ECVAO,ECVIR)=""
 I $D(^TMP("PXKENC",$J,ECVIS,"VST",ECVIS,800)) D
 .S ECVAO=$P(^(800),U,2),ECVIR=$P(^(800),U,3)
 .S:ECVAO="0" ECVAO="N" S:ECVIR=0 ECVIR="N"
 .S:ECVAO="1" ECVAO="Y" S:ECVIR=1 ECVIR="Y"
 Q
 ;
QUE ;entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
