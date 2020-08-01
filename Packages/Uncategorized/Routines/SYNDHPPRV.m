SYNDHPPRV ; Set up provider NPI in file 200
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;
 ;
CTRL ;
 S FN=200,N=0,NPI=999000000
 F  S N=$O(^VA(FN,N)) Q:+N=0  D
 .Q:$$GET1^DIQ(FN,N_",","NPI")'=""
 .S NPI=$I(NPI)
 .S NPIWCD=NPI_$$CKDIGIT^XUSNPI(NPI)
 .N FDA
 .S FDA(FN,N_",","NPI")=NPIWCD
 .D FILE^DIE("","FDA")
 .W !,N,"   -   ",NPIWCD
 Q
