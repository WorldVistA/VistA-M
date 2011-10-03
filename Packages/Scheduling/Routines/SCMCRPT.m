SCMCRPT ;BP/DMR - PCMM Intitution file check
 ;;5.3;Scheduling;**286**;AUG 13,1993
 ;
 S (INST,IEN,TEAM,TEST)=""
 F  S TEAM=$O(^SCTM(404.51,"B",TEAM)) Q:TEAM=""  D
 .S IEN="" F  S IEN=$O(^SCTM(404.51,"B",TEAM,IEN)) Q:IEN=""  D
 ..S INST="" S INST=$P($G(^SCTM(404.51,IEN,0)),"^",7)
 ..S TEST="" S TEST=$$GET1^DIQ(4,INST_",",11)
 ..IF TEST'["N" W !!,"Team "_TEAM_" points to an INSTITUTION that is not NATIONAL."
 ..Q
 K INST,IEN,TEAM,TEST
