XUYDEV ;SFISC/KLD-Add DEVICE file #3.5 to PARAMETER ENTITY file;11/30/99
 ;;8.0;KERNEL;**135**;Nov 30, 1999
 ;
 N ABORT,ARER,ARERR,DA,DIC,DIR,DIE,DR,FDA,FDAIEN,HD,IEN,Y
 S HD="The Following Data Have Been Added To File #8989.518"
 S (ABORT,IEN)=0
 S FDA(8989.518,"?+1,",.01)="DEVICE"
 S FDA(8989.518,"?+1,",.02)="DEV"
 S FDA(8989.518,"?+1,",.03)="Device"
 I $D(^XTV(8989.518,3.5,0))'=1 D
 . S FDAIEN(1)="3.5"
 . D UPDATE^DIE(,"FDA","FDAIEN","ARER")
 E  D
 . D UPDATE^DIE(,"FDA",,"ARER")
 W:$G(IOF)'="" @IOF
 I $D(ARER) D  Q:ABORT
 . S ABORT=1
 . W $C(7)
 . W:$G(IOF)'="" @IOF
 . W !!,"An ERROR has occured",!
 . W $P(ARER("DIERR",1),"^")," - "
 . W $P(ARER("DIERR",1,"TEXT",1),"^")
 S IEN=$$FIND1^DIC(8989.518,,,"DEVICE",,,"ARERR")
 I IEN D  Q:ABORT
 . W $C(7)
 . W !!!,HD
 . W !,$$REPEAT^XLFSTR("=",$L(HD))
 . W !,$$GET1^DIQ(8989.518,IEN,.01,"E")
 . W !,$$GET1^DIQ(8989.518,IEN,.02,"E")
 . W !,$$GET1^DIQ(8989.518,IEN,.03,"E"),!!
 . N DIR
 . S DIR(0)="E" D ^DIR
 . S ABORT=1
 Q
