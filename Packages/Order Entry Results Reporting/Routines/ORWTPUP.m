ORWTPUP ; SLC/STAFF Personal Preference - Utility Parameters ;5/22/00  09:59
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85**;Oct 24, 2000
 ;
PDLKUP(NAME) ; $$(parameter definition name) -> ien
 I '$L(NAME) Q 0
 Q +$O(^XTV(8989.51,"B",NAME,0))
 ;
PDSET(PARAM,CODES) ; return set of codes from domain value of parameter
 N CODE,NODE,NUM K CODES
 I PARAM'=+PARAM S PARAM=$$PDLKUP(PARAM)
 I 'PARAM Q
 S NODE=$G(^XTV(8989.51,+PARAM,1))
 I $P(NODE,U)'="S" Q
 S NODE=$P(NODE,U,2)
 F NUM=1:1 S CODE=$P(NODE,";",NUM) Q:'$L(CODE)  D
 .S CODES(NUM)=$P(CODE,":")_U_$P(CODE,":",2)
 Q
