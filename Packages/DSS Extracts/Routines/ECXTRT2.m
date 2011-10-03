ECXTRT2 ;ALB/JAP,BIR/DMA,CML,PTD-Treating Specialty Change Extract ;9/8/10  16:34
 ;;3.0;DSS EXTRACTS;**105,127**;Dec 22, 1997;Build 36
 ;
FILE ;file the extract record
 ;node0
 ;^dfn^ssn^name^i/o (ECXA)^date^product^adm date^d/c date^
 ;mov#^type^new ts^losing ts^losing ts los^
 ;losing attending^movement type^time^adm time^new provider^
 ;new attending^losing provider
 ;node1
 ;mpi^dss dept^placeholder^placeholder^placeholder^
 ;placeholder^losing attending los^losing provider los^dom^
 ;observ pat ind^encounter num
 ;^losing attending physician npi^losing prim ward provider npi^
 ;new attending physician npi^new primary ward provider npi
 ;^product division code^losing attending physician PC^new primary ward
 ;provider pc^new attending physician pc^losing primary ward prov pc^
 ;new attending physician npi^new primary ward provider npi^PATCAT
 ;
 ;convert specialties to PTF Codes for transmission
 ;
 N ECXDATA
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXSPCN,.ECXDATA)
 S ECXSPCN=$G(ECXDATA(7))
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXSPCL,.ECXDATA)
 S ECXSPCL=$G(ECXDATA(7))
 ;done
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U_ECXDATE_U_U
 S ECODE=ECODE_ECXADMDT_U_ECXDCDT_U_ECDA_U_6_U_ECXSPCN_U_ECXSPCL_U
 S ECODE=ECODE_ECXLOS_U_ECXATTL_U_ECMT_U_ECXTIME_U_ECXADMTM_U_ECXPRVN_U
 S ECODE=ECODE_ECXATTN_U_ECXPRVL_U
 S ECODE1=ECXMPI_U_ECXDSSD_U_U_U_U_U
 S ECODE1=ECODE1_ECXLOSA_U_ECXLOSP_U_ECXDOM_U_ECXOBS_U_ECXENC_U_ECXPDIV
 I ECXLOGIC>2005 S ECODE1=ECODE1_U_ECXATLPC_U_ECXPRNPC_U_ECXATNPC_U_ECXPRLPC
 I ECXLOGIC>2007 S ECODE1=ECODE1_U_ECATLNPI_U_ECPRLNPI_U_ECATTNPI_U_ECPRVNPI
 I ECXLOGIC>2010 S ECODE1=ECODE1_U_ECXPATCAT
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
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
