ECUD1 ;BIR/DMA-Store data from unit dose package into 728.904 ; 26 Sep 95 / 12:44 PM
 ;;3.0;DSS EXTRACTS;;Dec 22, 1997
 ;called from 2 unit dose routines - PSGPLF and PSGAMSA
 ;load UD data into an EC file for later extract to vendor
 ;
 I '$D(^ECX(728.904)) Q
 L +^ECX(728.904,0):1 Q:'$T
 N DA,DIK
 S EC=-$O(^ECX(728.904,"AINV","")) F  S EC=EC+1 Q:'$D(^ECX(728.904,EC))
 S ^ECX(728.904,EC,0)=EC_"^"_ECUD L -^ECX(728.904,0)
 S DA=EC,DIK="^ECX(728.904," D IX^DIK
 K EC Q
