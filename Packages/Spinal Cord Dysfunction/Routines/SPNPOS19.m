SPNPOS19 ;SD/WDE/Post action for patch 19; 1/16/2003
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;
EN ;
 S U="^"
 Q:$G(^DD(154.1,1003,0))'=""  ; early quit if patch 19 prev installed
 S SPNFD0=0 F  S SPNFD0=$O(^SPNL(154.1,SPNFD0)) Q:(SPNFD0="")!('+SPNFD0)  D
 .W "."
 .D SCORE  ;conver score type 5's to 11's
 .Q
RSTAT ;
 S SPNDFN=0 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:'+SPNDFN  D DOD,XMTDEL
 K ^DD(154,.04,5,1,0)
 K ^DD(154,.03,1,2)  ;delete left-over trigger
ZAP ;
 K SPNDFN,SPNFD0,SPNX,SPNY,SPNZ
 Q
SCORE ;Conver score type to new values
 S SPNX=""
 S SPNX=$P($G(^SPNL(154.1,SPNFD0,2)),U,17)  ;score type
 I SPNX="" Q
 I SPNX=5 S $P(^SPNL(154.1,SPNFD0,2),U,17)=11
 K SPNX
 Q
DOD ;
 ;date of death update
 D LOOP^SPNDODCK(SPNDFN) ; Update Reg Status based on DOD file 2
 D LOOP2^SPNDODCK(SPNDFN) ; Updating Reg Status
 Q
XMTDEL ;
 I $D(^SPNL(154,SPNDFN,"XMT")) K ^SPNL(154,SPNDFN,"XMT")
 Q
