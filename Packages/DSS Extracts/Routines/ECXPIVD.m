ECXPIVD ;ALB/JAP,BIR/DMA,CML,PTD-Extract from IV STATS File (#50.8) ; [ 12/05/96  10:41 AM ]
 ;;3.0;DSS EXTRACTS;**10,11,8,13,24,33**;Dec 22, 1997
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; start package specific extract
 N X
 S QFLG=0
 S ECED=ECED+.3
 K ^TMP($J)
 S ECIV=0 F  S ECIV=$O(^PS(50.8,ECIV)),ECD=ECSD1 Q:'ECIV  F  S ECD=$O(^PS(50.8,ECIV,2,ECD)) Q:'ECD  Q:ECD>ECED  K ^TMP($J) D  Q:QFLG
 .;go thru AC crossreference to get pointers to 52.6 and 52.7
 .F ECJ=52.6,52.7 S ECK=0 F  S ECK=$O(^PS(50.8,ECIV,2,ECD,2,"AC",ECJ,ECK)),ECL=0 Q:'ECK  F   S ECL=$O(^PS(50.8,ECIV,2,ECD,2,"AC",ECJ,ECK,ECL)) Q:'ECL  S ^TMP($J,ECL,ECK)=""
 .S ECI=0 F  S ECI=$O(^PS(50.8,ECIV,2,ECD,2,ECI)) Q:'ECI  I $D(^(ECI,0)) S ECC=$P(^(0),U,5),ECF=+$P(^(0),U,7),ECDRG=+$O(^TMP($J,ECI,0)),EC50=+$P($G(^PS(ECF,ECDRG,0)),U,2) D  Q:QFLG
 ..S ECCAT=$P($G(^PSDRUG(EC50,0)),U,2),ECNDC=$P($G(^(2)),U,4),ECNDF=$G(^("ND")),ECINV=$P(^(0),U,3),ECINV=$S(ECINV["I":"I",1:"")
 ..S ECNFC=$$RJ^XLFSTR($P(ECNDC,"-"),6,0)_$$RJ^XLFSTR($P(ECNDC,"-",2),4,0)_$$RJ^XLFSTR($P(ECNDC,"-",3),2,0),ECNFC=$TR(ECNFC,"*",0)
 ..S P1=$P(ECNDF,U),P3=$P(ECNDF,U,3)
 ..S X="PSNAPIS" X ^%ZOSF("TEST") I $T S ECNFC=$$DSS^PSNAPIS(P1,P3,ECXYM)_ECNFC
 ..I $L(ECNFC)=12 S ECNFC=$$RJ^XLFSTR(P1,4,0)_$$RJ^XLFSTR(P3,3,0)_ECNFC
 ..S ECDFN=0 F  S ECDFN=$O(^PS(50.8,ECIV,2,ECD,2,ECI,1,ECDFN)) Q:'ECDFN  I $D(^(ECDFN,0)) S EC=^(0),ECQ=$P(EC,U,2)-$P(EC,U,3)-$P(EC,U,6),ECCS=ECQ*ECC,ECW=$P(EC,U,5) I ECQ D  Q:QFLG
 ...I $D(^DPT(ECDFN,0)) S EC1=^(0),(ECWD,ECMN,ECTS,ECADM,ECXDSSI,ECXDSSD)="" D
 ....K ECXPAT S OK=$$PAT^ECXUTL3(ECDFN,$P(ECD,"."),"1;",.ECXPAT)
 ....Q:'OK
 ....S ECXPNM=ECXPAT("NAME"),ECXSSN=ECXPAT("SSN"),ECXMPI=ECXPAT("MPI")
 ....S X=$$PRIMARY^ECXUTL2(ECDFN,$P(ECD,"."))
 ....S ECPTTM=$P(X,U,1),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3),ECPTNPI=$P(X,U,4),ECASPR=$P(X,U,5),ECCLAS2=$P(X,U,6),ECASNPI=$P(X,U,7)
 ....I ECW=.5 S ECWD="CLI"
 ....I ECW<.5 S ECWD=$P($G(^DIC(42,+ECW,44)),U)
 ....S X=$$INP^ECXUTL2(DFN,ECD),ECXA=$P(X,U),ECMN=$P(X,U,2)
 ....S ECTS=$P(X,U,3),ECADM=$P(X,U,4),ECXDOM=$P(X,U,10)
 ....D FILE K P1,P3
 Q
 ;
FILE ;file record
 ;node0
 ;fac^dfn^ssn^name^i/o (ECXA)^day^va class^qty^ward^
 ;cost^movement #^treat spec^ndc^investigational^
 ;iv dispensing fee^new feeder key^total doses^
 ;primary care team^primary care provider^
 ;ivp time^adm date^adm time^dss identifier
 ;node1
 ;mpi^dss dept^pc provider npi^pc prov person class^assoc pc provider^
 ;assoc pc prov person class^assoc pc prov npi^dom^extended outpatient
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_ECINST_U_ECDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECD,ECXYM)_U_ECCAT_U_ECQ_U
 S ECODE=ECODE_ECWD_U_ECCS_U_ECMN_U_ECTS_U_ECNDC_U
 S ECODE=ECODE_ECINV_U_U_U_U_U
 S ECODE=ECODE_ECPTTM_U_ECPTPR_U_"000000"_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECADM,ECXYM)_U_$$ECXTIME^ECXUTL(ECADM)_U
 S ECODE=ECODE_ECXDSSI_U
 ;if this is an outpatient, send null for admission date and
 ; "000000" for admission time
 I ECW=.5 S $P(ECODE,U,24)="",$P(ECODE,U,25)="000000"
 S ECODE1=ECXMPI_U_ECXDSSD_U_ECPTNPI_U_ECCLAS_U_ECASPR_U_ECCLAS2_U
 S ECODE1=ECODE1_ECASNPI_U_ECXDOM_U_$G(ECXEOI)
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),ECRN>499,'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="IVP"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 ;variables ecver and ecrtn will be reset in routine ecxtrac
 ; if appropriate
 S ECVER=3
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
