XMA11 ;(WASH ISC)/CAP/THM-Edit message info only ;04/17/2002  07:09
 ;;8.0;MailMan;;Jun 28, 2002
 ;
 ; Entry point (DBIA ?):
 ; INFO   Interactive change a message's 'information only' field.
INFO(DA) ; Change Information Only Status
 N DIE,DR
 S DIE=3.9,DR="1.97"
 D ^DIE
 Q 0
