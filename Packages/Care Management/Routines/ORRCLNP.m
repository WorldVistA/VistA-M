ORRCLNP ; SLC/JER - Person functions for CM ; 9/23/04 14:30
 ;;1.0;CARE MANAGEMENT;**1**;Jul 15, 2003
EMAIL(USER) ; e-mail address
 Q $$NETNAME^XMXUTIL(USER)
NAME(USER) ; Person Name
 Q $$NAME^XUSER(USER)
SSNL4(USER) ; SSN Last4
 N ORRCY
 S ORRCY=$$GET1^DIQ(200,USER,9)
 Q $S(+ORRCY:$E(ORRCY,6,10),1:ORRCY)
SEX(USER) ; Person SEX
 Q $$GET1^DIQ(200,USER,4,"I")
PROVIDER(USER) ; Boolean fn: is user a provider
 Q $S(+$D(^XUSEC("PROVIDER",USER)):1,+$$ISA^USRLM(USER,"PROVIDER"):1,1:0)
 ;
SYS(PROD) ;RPC to determine if current system is PROD or TEST
 ; **Requires XU*8.0*284
 ;
 ; Input: NONE
 ; Output: returned in PROD
 ;      1 if production system
 ;      0 if not production system
 ;
 S PROD=+$$PROD^XUPROD
 Q
