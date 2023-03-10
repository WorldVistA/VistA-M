SDTMPUTL ;BAH/DRF - TELEHEALTH UTILITY FUNCTIONS;Aug 4, 2022
 ;;5.3;Scheduling;**821**;Aug 13, 1993;Build 9
 ;
 ; Integration Agreement #7348 - Access to #728.441
 ;
 Q
 ;
CHAR4DSC(CHAR4) ;Return the CHAR4 Description
 ;
 ;Input:  CHAR4 from file #728.44 in external format
 ;
 ;Output: CHAR4 description from #728.441 (IA #7348)
 ;
 N CHAR4IEN
 I $G(CHAR4)="" Q ""
 S CHAR4IEN=$O(^ECX(728.441,"B",CHAR4,"")) I CHAR4IEN="" Q ""
 Q $$GET1^DIQ(728.441,CHAR4IEN,1)
