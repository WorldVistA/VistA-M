XQP46INI ;SEA/LUKE - Post init for patch XU*8.0*46 ;04/27/98  12:27
 ;;8.0;Kernel;**46**;APR 14, 1998
 ;Post installation routine for KIDS patch XU*8.0*46
 ;
 ;Add Synonym "OPED" to XQOPED option in the XUMAINT menu
 N XQMEN,XQOP,XQORD
 S XQMEN=$O(^DIC(19,"B","XUMAINT",0))
 S XQOP=$O(^DIC(19,"B","XQOPED",0))
 S XQORD=$O(^DIC(19,XQMEN,10,"B",XQOP,0))
 I +^DIC(19,XQMEN,10,XQORD,0)=XQOP D
 .S $P(^DIC(19,XQMEN,10,XQORD,0),U,2)="OPED"
 .S ^DIC(19,XQMEN,10,"C","OPED",XQORD)=""
 .Q
 Q
