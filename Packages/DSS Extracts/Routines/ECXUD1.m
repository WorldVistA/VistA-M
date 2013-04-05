ECXUD1 ;ALB/JAP,BIR/DMA-Store Data from Unit Dose Package into 728.904 ; 26 Sep 95 / 12:44 PM
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;called from 2 unit dose routines - PSGPLF and PSGAMSA
 ;load UD data into an EC file for later extract to vendor
 N DA,DIK
 S X="ECXYUD1" X ^%ZOSF("TEST") I $T D ^ECXYUD1
 I '$D(^ECX(728.904)) Q
 L +^ECX(728.904,0):1 Q:'$T
 S EC=$O(^ECX(728.904,999999999),-1),EC=EC+1
 S ^ECX(728.904,EC,0)=EC_U_ECUD L -^ECX(728.904,0)
 S DA=EC,DIK="^ECX(728.904," D IX^DIK
 K EC
 Q
