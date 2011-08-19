ECXMOV ;ALB/JAP,BIR/DMA,PTD-Transfer and Discharge Extract ; 4/7/10 10:54am
 ;;3.0;DSS EXTRACTS;**8,24,33,39,41,42,46,65,84,107,105,128,127**;Dec 22, 1997;Build 36
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; start package specific extract
 N ECXDSC,W,WTO,X1,X2,X,ECXDPRPC,ECXDAPPC,ECDIS
 K ECXDD D FIELD^DID(405,.19,,"SPECIFIER","ECXDD")
 S ECPRO=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 S ECED=ECED+.3,QFLG=0
 F ECM=2,3 S ECARG="ATT"_ECM,ECD=ECSD1 D  Q:QFLG
 .F  S ECD=$O(^DGPM(ECARG,ECD)),ECDA=0 Q:('ECD)!(ECD>ECED)  D  Q:QFLG
 ..F  S ECDA=$O(^DGPM(ECARG,ECD,ECDA)) Q:'ECDA  D  Q:QFLG
 ...Q:'$D(^DGPM(ECDA,0))  S EC=^(0)
 ...S ECXDFN=+$P(EC,U,3),ECMT=$P(EC,U,18),ECXDATE=ECD
 ...K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,$P(ECXDATE,"."),"1;",.ECXPAT)
 ...I 'OK K ECXPAT Q
 ...S ECXPNM=ECXPAT("NAME"),ECXSSN=ECXPAT("SSN"),ECXMPI=ECXPAT("MPI")
 ...S ECTM=$$ECXTIME^ECXUTL(ECD)
 ...S WTO=$P(EC,U,6),ECXWTO=$P($G(^DIC(42,+WTO,44)),U)
 ...;
 ...;reset EC to admission movement and hold discharge movement ECX*128
 ...S ECCA=$P(EC,U,14),EC=$G(^DGPM(ECCA,0)),ECA=$P(EC,U) I EC="" D MAIL(ECDA) S QFLG=1 Q
 ...;
 ...;if date of previous xfer movement is greater than admit date,
 ...;then reset EC to that previous xfer movement
 ...S ECDL=9999999.9999999-ECD,ECDL=+$O(^DGPM("ATID2",ECXDFN,ECDL))
 ...S ECDAL=+$O(^DGPM("ATID2",ECXDFN,ECDL,0))
 ...I $D(^DGPM(ECDAL,0)),$P(^(0),U)>$P(EC,U) S EC=^(0)
 ...;
 ...I ECM=2 D
 ....;if transact=Transfer,ECD (time)=ASIH (7chars) and >0,set ECXDATE
 ....;to Admit DT/time before calling funct to get in/out stat & TS
 ....I $L($P(ECD,".",2))=7,+$E($P(ECD,".",2),7)>0 S ECXDATE=ECA
 ....S W=$P(EC,U,6)
 ...;
 ...I ECM=3 D
 ....;subtract 1 second from dischg DT so IN5^VADPT call (in ECXUTL2
 ....;API) will pick up discharge movmement record
 ....S ECXDATE=$$FMADD^XLFDT(ECXDATE,,,,-1)
 ....;set losing ward to ward at discharge
 ....N WARD S WARD=$$GET1^DIQ(405,ECDA,200)
 ....I WARD'="" S W=+$O(^DIC(42,"B",WARD,0))
 ...;
 ...;-Gets inpat/outpat status, DOM, Treating Spec (TS)
 ...S X=$$INP^ECXUTL2(ECXDFN,ECXDATE),ECXA=$P(X,U),ECXDOM=$P(X,U,10),ECXTS=$P(X,U,3)
 ...;
 ...S (ECXWRD,ECXFAC,ECXDSSD)=""
 ...I W'="" D
 ....S ECXWRD=$P($G(^DIC(42,W,44)),U),ECXFAC=$P($G(^DIC(42,W,0)),U,11)
 ....S ECXDSSD=$P($G(^ECX(727.4,W,0)),U,2)
 ...S ECDI=$S(ECM=2:"",1:$$ECXDATE^ECXUTL(ECD,ECXYM))
 ...S X1=ECD,X2=$P(EC,U) D ^%DTC S ECXLOS=X
 ...;
 ...;- Get discharge PC Team, Primary and Assoc Primary Provider
 ...S (ECXDPCT,ECXDPR,ECXDAPR,ECXDPRPC,ECXDAPPC)=""
 ...I ECM=3 D
 ....S ECXDSC=$$PRIMARY^ECXUTL2(ECXDFN,ECD)
 ....S ECXDPCT=$P(ECXDSC,U),ECXDPR=$P(ECXDSC,U,2),ECXDAPR=$P(ECXDSC,U,5),ECXDPRPC=$P(ECXDSC,U,3),ECXDAPPC=$P(ECXDSC,U,6)
 ....S ECDAPRNP=$P(ECXDSC,U,7),ECDPRNPI=$P(ECXDSC,U,4)
 ...;
 ...;Get production division ;p-46
 ...N ECXPDIV S ECXPDIV=$$GETDIV^ECXDEPT(ECXFAC) ;p-46 
 ...;- Observation patient indicator (YES/NO)
 ...S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 ...; 
 ... ; ******* - PATCH 127, ADD PATCAT CODE ********
 ...S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ...;- If no encounter number, don't file record
 ...S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECA,,ECXTS,ECXOBS,ECHEAD,,)
 ...D:ECXENC'="" FILE
 Q
 ;
FILE ;file the extract record
 ;node0
 ;fac ECXFAC^dfn ECXDFN^ssn ECXSSN^name ECXPNM^in/out ECXA^
 ;day (ECD)^^adm date (ECA)^disc date ECDI^mov # ECDA^
 ;type ECM^losing ward ECXWARD^treat spec ^los ECXLOS^^
 ;movement type ECMT^mov time ECTM^gaining ward ECXWTO^
 ;adm time (ECA)^^^
 ;node1
 ;mpi ECXMPI^dss dept ECXDSSD^dom ECXDOM^observ pat ind ECXOBS^
 ;encounter num ECXENC^disch prim prov ECXDPR^disch PC team ECXDPCT^
 ;disch assoc prim prov ECXDAPR^production division ECXPDIV
 ;^disch prov person class ECXDPRPC^disch assoc prov pe-
 ;rson person class^disch assoc pc prov npi ECDAPRNP^discharge pc provider npi ECDPRNPI
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_ECXFAC_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECD,ECXYM)_U_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECA,ECXYM)_U_ECDI_U_ECDA_U_ECM_U_ECXWRD_U
 S ECODE=ECODE_U_ECXLOS_U_U_ECMT_U_ECTM_U_ECXWTO_U
 S ECODE=ECODE_$$ECXTIME^ECXUTL(ECA)_U_U_U
 S ECODE1=ECXMPI_U_ECXDSSD_U_ECXDOM_U_ECXOBS_U_ECXENC_U_ECXDPR_U
 S ECODE1=ECODE1_ECXDPCT_U_ECXDAPR_U_ECXPDIV ;p-46 added ECXPDIV
 I ECXLOGIC>2005 S ECODE1=ECODE1_U_ECXDPRPC_U_ECXDAPPC
 I ECXLOGIC>2007 S ECODE1=ECODE1_U_$G(ECDAPRNP)_U_$G(ECDPRNPI)
 I ECXLOGIC>2010 S ECODE1=ECODE1_U_ECXPATCAT ;P-127 ADDED PATCAT
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="MOV"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
MAIL(ECXDA) ; 
 ; Created to send a message pointing to a bad record ECX*128
 ; Input - ECXDA is the PATIENT MOVEMENT (#405) record number for the discharge that has no admission 
 ; associated with it.  ECX*128
 N XMSUB,XMTEXT,XMY,MSGTEXT,LINENUM
 ;;Setup necessary variables to send the message
 S XMSUB="Movement Record Error - Please Fix"
 S XMTEXT="MSGTEXT("
 S XMY("G.DSS-MOVS@"_^XMB("NETNAME"))=""
 ;;Create the message to be sent
 S LINENUM=1
 S MSGTEXT(LINENUM)="The Transfer and Discharge Extract did not complete due to the error below"
 S LINENUM=LINENUM+1,MSGTEXT(LINENUM)="",LINENUM=LINENUM+1
 S MSGTEXT(LINENUM)="Discharge movement record "_ECXDA_" does not have an admission movement associated with it."
 S LINENUM=LINENUM+1,MSGTEXT(LINENUM)="",LINENUM=LINENUM+1
 S MSGTEXT(LINENUM)="This record needs to be fixed and the extract needs to be run again."
 S LINENUM=LINENUM+1,MSGTEXT(LINENUM)=""
 D ^XMD
 Q
