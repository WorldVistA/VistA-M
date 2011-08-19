USRLFF ;SLC/PKR - User Class file functions and proc's ;2/19/98
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**3**;Jun 20, 1997
 ;This is a library of file functions, mainly for other packages that
 ;need to access ASU data.
 ;======================================================================
EVNTPTR(EVENT) ;Return pointer to event EVENT in the USR ACTION file.
 Q +$O(^USR(8930.8,"B",EVENT,0))
 ;
 ;======================================================================
EVNTVERB(IEN) ;Return the verb for event with ien of IEN.
 Q $P($G(^USR(8930.8,IEN,0)),U,5)
 ;
 ;======================================================================
HASAS(IEN) ;Return true if entry IEN has Authorizations/Subscriptions.
 I $D(^USR(8930.1,"B",IEN)) Q 1
 E  Q 0
 ;
 ;======================================================================
USRCLASS(IEN) ;Return the 0 node of USR CLASS.
 Q $G(^USR(8930,IEN,0))
 ;
 ;======================================================================
USRROLE(ROLE) ;Return the IEN of role ROLE in the USR ROLE file.
 Q +$O(^USR(8930.2,"B",ROLE,0))
 ;
