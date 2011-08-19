SPNPOS22 ;SD/CM/Post action for patch 22; 6/29/2004
 ;;2.0;Spinal Cord Dysfunction;**22**;01/02/1997
EN ;
 S U="^"
RSTAT ;
 S SPNDFN=0 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:'+SPNDFN  D XMTDEL
 K ^DD(154,.04,5,1,0)
 K ^DD(154,.03,1,2)  ;delete left-over trigger
ZAP ;
 K SPNDFN
 Q
XMTDEL ;
 I $D(^SPNL(154,SPNDFN,"XMT")) K ^SPNL(154,SPNDFN,"XMT")
 Q
