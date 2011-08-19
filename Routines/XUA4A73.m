XUA4A73 ;BP-OAK/BDT - Person Class Input Transform;2/13/07
 ;;8.0;KERNEL;**450**;Jul 10, 1995;Build 4
 Q
ENT(DA,X) ;
 N XUA,XUIEN,XUEFFDT
 S XUA=$G(^VA(200,DA(1),"USC1",DA,0))  ;get information
 S XUIEN=$P(XUA,"^"),XUEFFDT=$P(XUA,"^",2)
 N XUB,XUSTAT,XUDATE
 S XUB=$$PSC(XUIEN) ;get status from Person Class file.
 S XUSTAT=$P(XUB,"^"),XUDATE=$P(XUB,"^",2)
 I XUEFFDT>X Q ""
 I XUSTAT="i",X>XUDATE Q ""
 Q 1
 ;
PSC(XUIEN) ; Get Status and Expiration Date for Person Class XUIEN
 I +XUIEN'=XUIEN Q "^"
 I +XUIEN'>0 Q "^"
 N XUDATA
 S XUDATA=$G(^USC(8932.1,XUIEN,0))
 Q $P(XUDATA,"^",4,5)
