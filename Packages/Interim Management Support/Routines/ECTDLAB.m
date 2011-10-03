ECTDLAB ;B'ham ISC/PTD-Laboratory Workload ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^LRO(68)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Accession' File - #68 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^LRO(68,0)) W *7,!!,"'Accession' File - #68 has not been populated on your system.",!! S XQUIT="" Q
CTN W *7,!!?32,"*** CAUTION ***"
 W !?20,"Report is time consuming.  If printing to the",!?20,"screen, choose a limited date range.  Date",!?20,"and TIME may be entered.  If extended date",!?20,"range is chosen, please queue the report!",!?32,"***************",!!
DIP S DIC="^LRO(68,",BY="+.01;S2,++2,.01",FLDS="!2,!1,!.01;""# SPECIMENS"";C20,!11,!.01;""# TESTS"";C40",L=0
 S DHD="LAB WORKLOAD STATISTICS" D EN1^DIP
EXIT K %X,B,BY,DHD,DIC,FLDS,L
 Q
 ;
