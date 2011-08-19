ECXDENT ;ALB/JAP,BIR/DMA,PTD-Dental Extract for DSS ; [ 11/22/96  5:23 PM ]
 ;;3.0;DSS EXTRACTS;**11,8,13,24,33,39,46**;Dec 22, 1997
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;start package specific extract
 N DATA,X,Y
 K ECXDD D FIELD^DID(220.5,.01,,"SPECIFIER","ECXDD")
 S ECPRO=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 S ECED=ECED+.3,ECD=ECSD1,QFLG=0
 F  S ECD=$O(^DENT(221,"B",ECD)),ECXJ=0 Q:('ECD)!(ECD>ECED)!(QFLG)  D
 .F  S ECXJ=$O(^DENT(221,"B",ECD,ECXJ)) Q:'ECXJ  D  Q:QFLG
 ..Q:'$D(^DENT(221,ECXJ,0)) 
 ..S DATA=^DENT(221,ECXJ,0),$P(DATA,U,50)="" D STUFF
 Q
STUFF ;get data
 K ECXPAT
 S ECXDFN=+$P(DATA,U,4),OK=$$PAT^ECXUTL3(ECXDFN,$P(ECD,"."),"1;",.ECXPAT)
 Q:'OK
 S ECXPNM=ECXPAT("NAME"),ECXSSN=ECXPAT("SSN"),ECXMPI=ECXPAT("MPI")
 S X=$$INP^ECXUTL2(ECXDFN,ECD),ECXA=$P(X,U),ECXMN=$P(X,U,2)
 S ECXTS=$P(X,U,3),ECXDOM=$P(X,U,10),ECXADMDT=$P(X,U,4)
 S ECDEN=$P(DATA,U,3),ECDEN=$P($G(^DENT(220.5,ECDEN,0)),U)
 S:ECDEN]"" ECDEN=ECPRO_ECDEN S ECDENNPI=""
 S X=$$PRIMARY^ECXUTL2(ECXDFN,$P(ECD,"."),ECPRO)
 S ECPTTM=$P(X,U,1),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3),ECPTNPI=$P(X,U,4)
 S ECASPR=$P(X,U,5),ECCLAS2=$P(X,U,6),ECASNPI=$P(X,U,7)
 ;use of dss department delayed S ECXDSSD=$$DEN^ECXDEPT($P(DATA,U,40))
 S ECXDSSD=""
 ;
 ;- Observation patient indicator (YES/NO)
 S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 ;
 ;- If no encounter number don't file record
 S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,$P(DATA,U),ECXTS,ECXOBS,ECHEAD,,)
 D:ECXENC'="" FILE
 Q
 ;
FILE ;file record
 ;node0
 ;inst^dfn^ssn^name^in/out ECXA^day^provider^screen/complete^admin proc^
 ;x-rays ex^x-rays int^prophy natural^prophy denture^op room^
 ;neoplasm malig^
 ;neoplasm removed^biopsy/smear^fracture^pat category^other sig surg^
 ;surface restored^root canal^periodontal quads (surg)^
 ;perio quads (root plane)^
 ;patient ed^spot check exam^indiv crowns^posts & cores^
 ;fixed partials (abut)^fixed partials (pont)^removable partials^
 ;complete dentures^prosthetic repair^
 ;splints & spec procs^extractions^surg extractions^other sig treatment^
 ;div^completion/termination^interdisc consult^evaluation^
 ;pre-auth 2nd opinion^
 ;spot check discrepancy^mov #^treat spec^primary care team^
 ;primary care provider^time
 ;node1
 ;mpi^dss dept^provider npi^pc provider npi^pc prov person class^
 ;assoc pc prov^assoc pc prov person class^assoc pc prov npi^
 ;dom ECXDOM^observ pat ind ECXOBS^encounter num ECXENC^
 ;production division
 ;
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U
 S ECODE=ECODE_$P(DATA,U,40)_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL($P(DATA,U),ECXYM)_U_ECDEN_U
 S ECODE=ECODE_$P(DATA,U,7,9)_U_$P(DATA,U,11,20)_U_$P(DATA,U,22,38)_U
 S ECODE=ECODE_$P(DATA,U,40,45)_U_ECXMN_U_ECXTS_U
 S ECODE=ECODE_ECPTTM_U_ECPTPR_U_$$ECXTIME^ECXUTL($P(DATA,U))_U
 S ECODE1=ECXMPI_U_ECXDSSD_U_ECDENNPI_U_ECPTNPI_U_ECCLAS_U_ECASPR_U
 S ECODE1=ECODE1_ECCLAS2_U_ECASNPI_U_ECXDOM_U_ECXOBS_U_ECXENC_U_$P(DATA,U,40) ;p-46 added U_$P(DATA,U,40)
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="DEN"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
