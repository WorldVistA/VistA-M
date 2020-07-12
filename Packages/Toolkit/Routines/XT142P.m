XT142P ;OIFO-BP/BT - parameters ENTITY file ; 03/06/2019
 ;;7.3;TOOLKIT;**142**;Apr 25, 1995;Build 10
 ;Per VHA Directive 6402, this routine should not be modified
 Q
 ;-------------------------------------------------
ADD ;
 N ABORT,ARER,ARERR,DA,DIC,DIR,DIE,DR,FDA,FDAIEN,HD,IEN,Y
 S HD="The Following Data Have Been Added To File #8989.518"
 S (ABORT,IEN)=0
 S FDA(8989.518,"?+1,",.01)="CLINIC STOP"
 S FDA(8989.518,"?+1,",.02)="CST"
 S FDA(8989.518,"?+1,",.03)="Clinic Stop"
 I $D(^XTV(8989.518,40.7,0))'=1 D
 . S FDAIEN(1)="40.7"
 . D UPDATE^DIE(,"FDA","FDAIEN","ARER")
 E  D
 . D UPDATE^DIE(,"FDA",,"ARER")
 I $D(ARER) D  Q:ABORT
 . S ABORT=1
 . D BMES^XPDUTL($C(7))
 . D BMES^XPDUTL("")
 . D BMES^XPDUTL("An ERROR has occured")
 . D BMES^XPDUTL($P(ARER("DIERR",1),"^")," - ")
 . D BMES^XPDUTL($P(ARER("DIERR",1,"TEXT",1),"^"))
 S IEN=$$FIND1^DIC(8989.518,,,"CLINIC STOP",,,"ARERR")
 I IEN D  Q:ABORT
 . D BMES^XPDUTL("")
 . D MES^XPDUTL(HD)
 . D MES^XPDUTL($$REPEAT^XLFSTR("=",$L(HD)))
 . D MES^XPDUTL($$GET1^DIQ(8989.518,IEN,.01,"E"))
 . D MES^XPDUTL($$GET1^DIQ(8989.518,IEN,.02,"E"))
 . D MES^XPDUTL($$GET1^DIQ(8989.518,IEN,.03,"E"))
 . D MES^XPDUTL("")
 . S ABORT=1
 Q
 ;
POST ;
 D ADD
 Q
