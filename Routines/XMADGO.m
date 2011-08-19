XMADGO ;ISC-SF/GMB-Start Background Message Delivery ;04/17/2002  07:25
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP
 ;
 ; Entry points (DBIA 10068):
 ; ZTSK     Start tasks to deliver messages in local delivery queues
ZTSK ; Start Background Delivery Processes
 G ZTSK^XMKPLQ
 Q
