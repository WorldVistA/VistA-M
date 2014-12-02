ONCSRV ;Hines OIFO/RVD - SERVER ROUTINE FOR ONCOLOGY ; 5/10/2013
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;DBIA # 10072 - for routine REMSBMSG^XMA1C
 ;
 N ONCDS1,ONCDS2,ONCDT1,ONCDT2,ONCIIA,ONCSRDAT,XMRGONC1,ONCMSG,ONCUSS,ONCUSSNA,ONC0I,ONC0J
 D NOW^%DTC
 ;
 X XMREC S XMRGONC1=XMRG
 S ONCIIA=0
XMR ;
 X XMREC
 S ONCSRDAT(ONCIIA)=XMRG
 S ONCIIA=ONCIIA+1
 I (XMRG="END")!(XMRG="") G SNDC
 G XMR
 ;
SNDC ;Send confirmation message to Mail Server Recipient in file #160.1
 S XMDUZ=.5
 D REC  ;get recipient from site parameter.
 S XMSUB="Oncology Server Activation for "_$P($$SITE^VASITE,U,2)
 S ONCMSG(1)="The Oncology Server was activated today by the Oncology Office.  "
 S ONCMSG(2)="Please note if data was processed correctly..."
 S ONCMSG(3)=""
 s ONCMSG(4)="Server message is: "_XMRGONC1
 S ONCMSG(5)=""
 S ONCMSG(6)="This was activated by "_$P(XMFROM,"@",1)
 S ONCMSG(7)=""
 S XMTEXT="ONCMSG("
 D ^XMD
 K XMTEXT,ONCMSG
USS ;check if valid mail server user
 S ONCUSS=0
 F ONC0I=0:0 S ONC0I=$O(^ONCO(160.1,ONC0I)) Q:ONC0I'>0  D
 .F ONC0J=0:0 S ONC0J=$O(^ONCO(160.1,ONC0I,"SEU",ONC0J)) Q:ONC0J'>0  D
 ..S ONCUSSNA=$P($G(^ONCO(160.1,ONC0I,"SEU",ONC0J,0)),U,1)
 ..S:XMFROM[ONCUSSNA ONCUSS=1
 I ONCUSS=0 G INV  ;invalid mail server user.
 ;
PROC ;process the content of the message
 N ONCRC
 ;update server address
 ;production server- S XMRGONC1="SERVER*http://127.0.0.1:1757/cgi_bin/oncsrv.exe"
 I $P(XMRGONC1,"*",1)="SERVER" S ONCRC=$$UPDCSURL^ONCSAPIU($P(XMRGONC1,"*",2)) G EXIT
 ;timeliness report
 ;example of the message
 ;TIMELINESS*/1/1/2010*12/31/1012*YES*YES
 I XMRGONC1["TIMELINESS" G ^ONCSRVTM
 ;update file 160.16, example below
 ;it be NEW, UPDATE, DELETE or RULES.
 ;160.16*UPDATE*1*2555 where: 1=ien of 160,16( can be 1, 2 or 3), 2555 = field
 ;0#*^contains of node 0
 ;1#*^contains of node 1
 ;2#*^contains of node 2
 ;3#*^
 I $P(XMRGONC1,"*",1)=160.16 G 16016^ONCSRV01
 ;process Registry report for Today
 ;example REGISTRY*TODAY
 I XMRGONC1["REGISTRY" G ^ONCSRVRP
 I $P(XMRGONC1,"*",1)="MAIL SERVER" D MSE  ;update mail server user and recipient
 ;update file 165.5 for future patch
 ;I $P(XMRGONC1,"*",1)=165.5 G 1655^ONCSRV01
 G EXIT
 ;
MSE ;update mail server
 ;MAIL SERVER*VALID USER*RECIPIENT mail address
 ;MAIL SERVER*USER1*test.user@domain.ext
 N ONCMSRE,ONCMSUS,DIC,DA,DR,DIE,Y
 S IEN=0,DIC(0)="L"
 F  S IEN=$O(^ONCO(160.1,IEN))  Q:IEN'>0  D
 .S DA(1)=IEN,(DIE,DIC)="^ONCO(160.1,DA(1),""SEU"","
 .S ONCMSRE=$P(XMRGONC1,"*",3),ONCMSUS=$P(XMRGONC1,"*",2)
 .I '$D(^ONCO(160.1,IEN,"SEU","B",ONCMSUS)) D
 ..S DIC("DR")="2///^S X=ONCMSRE",X=ONCMSUS D FILE^DICN
 .I $D(^ONCO(160.1,IEN,"SEU","B",ONCMSUS)) D
 ..S DA=$O(^ONCO(160.1,IEN,"SEU","B",ONCMSUS,0))
 ..S DR="2///^S X=ONCMSRE" D ^DIE
 Q
 ;
REC ;get mail recipient
 F ONC0I=0:0 S ONC0I=$O(^ONCO(160.1,ONC0I)) Q:ONC0I'>0  D
 .F ONC0J=0:0 S ONC0J=$O(^ONCO(160.1,ONC0I,"SEU",ONC0J)) Q:ONC0J'>0  D
 ..S ONCUSSNA=$P($G(^ONCO(160.1,ONC0I,"SEU",ONC0J,0)),U,2)
 ..S XMY(ONCUSSNA)=""
 Q
 ;add additional extract here if needed
 ;D EXT^ONCSRV02
 ;
INV ;message due to invalid user
 S XMDUZ=.5
 D REC  ;get recipients from site parameter file
 S XMSUB="Oncology Invalid User Activation for "_$P($$SITE^VASITE,U,2)
 S ONCMSG(1)="The Oncology Server was activated today by an invalid user.  "
 S ONCMSG(2)=""
 S ONCMSG(3)="This was activated by "_XMFROM
 S XMTEXT="ONCMSG("
 D ^XMD
 K XMTEXT,ONCMSG
 ;
EXIT ;common exit point
 S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C
 K ONCDAT1,ONCDAT2,ONCDT1,XMRG,XMSUB,ONCRC
 K ONCDET,ONCDOR1,ONCDORS,ONCDORW,ONCDS1,ONCDS2,ONCDT2,ONCMSG
 K ONCPIP1,ONCPIP2,XMDUZ,XMFROM,XMREC,XMSER,XMTEXT,XMY,XMZ,XQMSG,XQSOP,Y
 Q
 ;END
