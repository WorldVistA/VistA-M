XU8P317 ;BP-OAK/BDT - PERSON CLASS MODIFIED; 8/19/03 5:33am
 ;;8.0;KERNEL;**317**;Jul 10, 1995
 ;Inactivate records 24 and 25.
 ;Edit CLASSIFICATION field for records 144 and 145.
 ;Edit SPECIALTY CODE field for records 144 and 145
 ;
 N FDA
 D INACT(24),INACT(25)
CL S FDA(8932.1,"144,",1)="Resident, Allopathic (includes Interns, Residents, Fellows)" D FILE^DIE("","FDA","ZZERR")
 S FDA(8932.1,"145,",1)="Resident, Osteopathic (includes Interns, Residents, Fellows)" D FILE^DIE("","FDA","ZZERR")
SC S FDA(8932.1,"144,",8)="01" D FILE^DIE("","FDA","ZZERR")
 S FDA(8932.1,"145,",8)="01" D FILE^DIE("","FDA","ZZERR")
 Q
 ;
INACT(X) ;
 N XUA
 L +^USC(8932.1,X,0):10 I '$T D  Q
 .S XUA(1)="",XUA(2)=">>>Record # "_X_" locked at time of patch installaion. Could not inactivate." D MES^XPDUTL(.XUA)
 S $P(^USC(8932.1,X,0),"^",4)="i"
 S $P(^USC(8932.1,X,0),"^",5)=DT
 L -^USC(8932.1,X,0)
 Q
