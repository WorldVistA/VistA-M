YSCL122P ;ALB/RTW - NCC POST INSTALL;10 May 2019 16:19:28
 ;;5.01;MENTAL HEALTH;**122**;Dec 30, 1994;Build 112
 ; calls START^YSCLDIS to find clozapine patients in file #55
 ; registered more than 57 days ago that do not have a recent clozapine
 ; prescription or order, set them to discontinued and send a report to the NCC.
 ; the NCC software will maintain the file from this point
 ; Reference to ^DIE supported by DBIA #2053
 ; Reference to ^DIQ supported by DBIA #2056
 ; Reference to ^%DTC supported by DBIA #10000
START ;
 ;INITIALIZE ^XTMP("YSCLDEM") and ^XTMP("YSCLTRN")
 N DIE,DA,DR S DR="",DIE="^YSCL(603.03,",DA=1,U="^"
 I $$GET1^DIQ(8989.3,1,501,"I") S DR="3///0;"   ;S $P(^YSCL(603.03,1,0),"^",3)=0
 S DR=DR_"8///S.RUCLRXLAB@FO-HINES.DOMAIN.EXT;9///S.RUCLDEM@FO-HINES.DOMAIN.EXT;"
 S DR=DR_"10///G.CLOZAPINE DEBUG@FO-DALLAS.DOMAIN.EXT;11///G.CLOZAPINE DEBUG@FO-DALLAS.DOMAIN.EXT"
 D ^DIE
 N YSDTS S YSDTS("+366")=$$FMADD^XLFDT(DT,366),YSDTS("-one")=$$FMADD^XLFDT(DT,-1)
 F VAR="YSCLDEM","YSCLTRN" D
 . S ^XTMP(VAR,0)=YSDTS("+366")_U_DT_U_"CLOZAPINE DAILY ROLLUP DATA"_U_(YSDTS("-one")_".000001")
 D START^YSCLDIS
 Q
 ;
