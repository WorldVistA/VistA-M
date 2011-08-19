RGEQ ;BHM/RGY,DKM-Queue processor ;17-Feb-98
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
EN(TYPE,STUB) ;
 ;This routine creates stub event queue entries which are later processed
 ;by the Event Queue Daemon.  The Event Queue Daemon then creates and
 ;broadcasts HL7 messages.
 ;
 ; Input: Required Variables
 ;
 ;  TYPE - data class (Ex. "CH" for CHemistry)
 ;  STUB - event stub (Ex. 91;7048784.917679;238
 ;           translated LRDFN;Inverse date  ;data name)
 ;
 I $$SEND^RGJUSITE=0 Q
 S ^RGEQ(TYPE,STUB)=""
 Q
