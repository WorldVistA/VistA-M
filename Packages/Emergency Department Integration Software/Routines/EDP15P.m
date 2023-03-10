EDP15P ;PHI/WAR - Close ambulance patients with LOC 0  ; 1/27/21 10:23am
 ;;2.0;EMERGENCY DEPARTMENT;**15**;JAN 13, 2021;Build 4
 ;
 Q
 ;
INIT ; Remove ambulance patients with LOC=0 then regular patients.
 N BED,LOG,EDPSITE,AREA
 S EDPSITE="" F  S EDPSITE=$O(^EDP(230,"AL",EDPSITE)) Q:'EDPSITE  D
 .S AREA="" F  S AREA=$O(^EDP(230,"AL",EDPSITE,AREA)) Q:'AREA  D
 ..S BED="" F  S BED=$O(^EDP(230,"AL",EDPSITE,AREA,BED)) Q:BED>0  D
 ...S LOG=0 F  S LOG=$O(^EDP(230,"AL",EDPSITE,AREA,BED,LOG)) Q:'LOG  D
 ....I $P($G(^EDP(230,LOG,0)),U,4)'="(ambulance en route)" Q
 ....D CLREC
 ....D COMMENT
 D RMVPAT
 Q
RMVPAT ; Remove LOC=0 patients older than 5 days.
 N BED,LOG,EDPSITE,AREA
 S EDPSITE="" F  S EDPSITE=$O(^EDP(230,"AL",EDPSITE)) Q:'EDPSITE  D
 .S AREA="" F  S AREA=$O(^EDP(230,"AL",EDPSITE,AREA)) Q:'AREA  D
 ..S BED="" F  S BED=$O(^EDP(230,"AL",EDPSITE,AREA,BED)) Q:BED>0  D
 ...S LOG=0 F  S LOG=$O(^EDP(230,"AL",EDPSITE,AREA,BED,LOG)) Q:'LOG  D
 ....I $$FMDIFF^XLFDT($$NOW^XLFDT(),$P($G(^EDP(230,LOG,0)),U,1),1)<5 Q
 ....D CLREC
 ....D COMMENT
 Q
CLREC ; Set CLOSED field to "Yes".
 N DIE,DA,DR
 S DIE="^EDP(230,",DA=LOG,DR=".07///1"
 D ^DIE
 Q
COMMENT ; Update disposition comment with patch number.
 N DIE,DA,DR
 S DIE="^EDP(230,",DA=LOG,DR="3.8///Entered in error. EDP*2*15"
 D ^DIE
 Q
