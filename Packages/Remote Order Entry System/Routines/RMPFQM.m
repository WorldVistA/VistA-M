RMPFQM ;DDC/KAW-LOAD DDC MESSAGES [ 04/01/98  12:26 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**2,10,11,16**;JUN 16, 1995
 ;;Reference to ^XMB(3.9) supported by DBIA #247
 S MD=$P($P(^XMB(3.9,XMZ,0),U,1),"GOV-",2),CT=1,XQSTXT(CT)=" "
 S CT=CT+1,XQSTXT(CT)="                              ROES ORDER UPDATES"
 S CT=CT+1,XQSTXT(CT)=" "
 S CT=CT+1,XQSTXT(CT)="      PATIENT          TYPE   STATUS             ITEM(S)               SHIP BY"
 S CT=CT+1,XQSTXT(CT)="--------------------  ------  ------  ------------------------------ ----------"
 S CT=CT+1,XQSTXT(CT)=" "
 F IR=1:1 X XMREC Q:XMER=-1  D LOAD^RMPFQM1 Q:XMER=-1
END K XMZ,S0,MD,NM,SX,RMPFX,X,DIC,DA,DA(1),DLAYGO,X,Y,IX,A,VADM,VA,VAERR
 K RMPFQUT,RMPFHAT,ZTSK,IN,I,X,Y,Z Q
 K %,%DT,%Y,%Z,K,RMPFY,XMDUZ,XMK Q
