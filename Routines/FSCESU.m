FSCESU ;SLC/STAFF-NOIS Edit Status Utility ;10/17/96  15:35
 ;;1.1;NOIS;;Sep 06, 1998
 ;
STATCALL(CALL) ; $$(call) -> status #^status abrev^status^sup #^dev #
 N DEV,SUP
 S SUP=$P($G(^FSCD("CALL",CALL,0)),U,2),DEV=$P($G(^(0)),U,17)
 Q $$STAT(SUP,DEV)_U_SUP_U_DEV
 ;
STAT(SUP,DEV) ; $$(status, ref status) -> status #^status abbrev^status
 I 'SUP Q ""
 I SUP=1 Q "1^O^OPEN"
 I SUP=2 Q "2^C^CLOSED"
 I DEV=1 Q "3^R^REFERRED"
 I SUP=4 Q "4^V^VENDOR"
 I DEV=5 Q "5^E^REFER TO EP"
 I DEV=6 Q "6^P^AWAITING PATCH"
 I DEV=7 Q "7^N^NEXT RELEASE"
 I DEV=8 Q "8^F^FUTURE RELEASE"
 I DEV=9 Q "9^W^REFER TO VACO"
 I SUP=10 Q "10^I^IMPLEMENTATION"
 I SUP=99 Q "99^X^CANCELLED"
 Q ""
