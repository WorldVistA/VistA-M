ECTSCAT ;B'ham ISC/PTD-AMIS 401 - Patient Care by Vet. Category ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^DG(391.1)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'AMIS Segment' File - #391.1 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^DG(391.1,0)) W *7,!!,"'AMIS Segment' File - #391.1 has not been populated on your system.",!! S XQUIT="" Q
DIP S DIC="^DG(391.1,",L=0,BY="50,50,+.01,+50,.01;S2,-@NAME",FLDS="50,50,.01,NAME;L25,&1;C42;""# APPL"",&2;C52;""HSP CR REC"",&8;C62;""OP CR REC"",((#2+#4+#6+#8)/#1)*100;R5;D1;C72;""ACPT RT"""
 S (FR,TO)="?,,",DHD="AMIS SEGMENT LIST" D EN1^DIP
EXIT K %X,B,BY,DHD,DIC,FLDS,FR,L,TO
 Q
 ;
