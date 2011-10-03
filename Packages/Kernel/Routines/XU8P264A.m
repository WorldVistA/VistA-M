XU8P264A ;OAK-BP/BDT ;PERSON CLASS CODE UNDATE; [12/4/02 12:24pm]
 ;;8.0;KERNEL;**264**; Jul 10, 1995
 ;;This routine updates Person Class file
 ;- Add sixty new entries.
 ;- Inactivate two existing entries.
START ;Print message about post-install
 N XUA,XU1,XUDATA,DAYINAC
 S DAYINAC=DT
 S XUA(1)="",XUA(2)=">>>XU*8*264 Post-Install...",XUA(3)=""
 D MES^XPDUTL(.XUA)
 ;loop through DATA^XUP264
 F XU1=1:1 S XUDATA=$P($T(DATA+XU1^XU8P264),";",4,99) Q:XUDATA="$END$"  X $$ADD(XU1+674,XUDATA)
 ;call function INAC to inactivate entries 180 and 659
 X $$INAC(180,DAYINAC)
 X $$INAC(659,DAYINAC)
 S XUA(1)="",XUA(2)=">>>XU*8*264 Post-Install complete..",XUA(3)=""
 D MES^XPDUTL(.XUA)
 Q
 ;
ADD(X,Y) ;add new entries.
 I ^USC(8932.1,X,0)'=Y S ^USC(8932.1,X,0)=Y W "-"
 Q ""
 ;
INAC(X,Y) ;inactivate an entries
 N XUA
 L +^USC(8932.1,X,0):10 I '$T D  Q
 .S XUA(1)="",XUA(2)=">>>Record # "_X_" locked at time of patch installation. Could not inactivate." D MES^XPDUTL(.XUA)
 S $P(^USC(8932.1,X,0),"^",4)="i"
 S $P(^USC(8932.1,X,0),"^",5)=Y
 L -^USC(8932.1,X,0) Q ""
