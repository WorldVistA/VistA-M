%ZIS2 ;SFISC/AC,RWF -- DEVICE HANDLER (CHECKS) ;11/08/2011
 ;;8.0;KERNEL;**69,104,112,118,136,241,440,546,585**;JUL 10, 1995;Build 22
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
L2 ;Entry point from %ZIS1, %E holds the IEN value
 I $D(DTOUT)!$D(DUOUT) K %ZISHP,%ZISHPOP Q
CHECK ;Get IO check for secondary $I
 K %ZISCPU N %Z2,%ZFQ
 S POP=0,%Z=^%ZIS(1,%E,0),%Z2=$S(%ZIS("PRI")=1:"",1:$G(^%ZIS(1,%E,2))) ;Get Primary and secondary IO.
 S IO=$S(%ZIS("PRI")=1:$P(%Z,"^",2),$L($P(%Z2,"^")):$P(%Z2,"^"),1:$P(%Z,"^",2)) ;
 S %Z90=$G(^(90)),%Z95=$G(^(95)),%ZTIME=$G(^("TIME")),%ZTYPE=$G(^("TYPE"))
 I '$$QUECHK Q
 I %ZTYPE="RES" S %ZISRL=+$P(%Z1,"^",10) G T
VTRM I %ZTYPE="VTRM",'('$D(IO("Q"))&(%A=%H)) W:'$D(IOP)&'$D(%ZISHP) *7,"  [YOU CAN NOT SELECT A VIRTUAL TERMINAL]" S POP=1 ;Virtual Terminal Check
 S:%ZTYPE="VTRM"&'$D(IO("Q"))&(%A=%H) IO=$I
 ;
SLAVE I $D(IO("Q")),$P(%Z,"^",2)=0,$P(%Z,"^",8)']"" W:'$D(IOP) *7,!?10,"  [SLAVE device NOT set up for queuing]" S POP=1 G T
 ;
 ;
 ;**P585 START CJM
PQ ;Check (if not queueing to secondary system) that print queue is established and available
 I %ZTYPE="PQ",%ZISB!'$P($G(^XTV(8989.3,1,0)),"^",5),(%ZIS'["T"),'$$QEXIST^ZISPQ(%E) D  G T
 .S POP=1
 .W:'$D(IOP) *7,!?10,"  [The Print Queue does not exist]"
 ;**P585 END CJM
 ;
OCPU D OTHCPU("DEVICE")
 ;
OOS G T:POP
 ;Out Of Service Check
 I %Z90,$D(DT)#2,%Z90'>DT S POP=1 I '$D(IOP),'$D(%ZISHP) W *7,"  [Out of Service]"
 ;
PTIME G T:POP!(IO=$I)!(IO=0)
 ;Prohibitted Time Check
 S %A=$P(%ZTIME,"^") I %ZISB,$L(%A) D  I POP,'$D(IOP),'$D(%ZISHP) W *7,"  [ACCESS PROHIBITED "_%A_"]" ;AT THIS TIME]"
 . N %C,%L,%H ;%C is current time, %L is lower limit, %H is upper limit
 . S %C=$P($H,",",2),%C=%C\60#60+(%C\3600*100),%H=$P(%A,"-",2),%L=+%A
 . I $S(%H'<%L:(%C'>%H&(%C'<%L)),1:(%C'<%L!(%C'>%H))) S POP=1
 . Q
DUZ I 'POP D SEC ;Security Check
 ;
T ;
 ;
TMPVAR K IO("S") S %ZISIOS=%E S:IO=0 IO=$I,IO("S")=%H
 S %ZISOPAR=$$IOPAR(%E,"IOPAR")
 S %ZISUPAR=$$IOPAR(%E,"IOUPAR"),%ZISTO=+$P(%ZTIME,"^",2)
 ;Slave Device
 I $D(IO("S")) D  I POP Q
 . S IO=$S(%ZIS["S":$P($G(^%ZIS(1,+$P(%Z,"^",8),0)),"^",2),1:IO)
 . I %ZIS["S",IO]"" S %H=+$P(%Z,"^",8),IO("S")=%H,IO(0)=IO
 . S IO("S")=$S($G(^XUTL("XQ",$J,"IOST(0)")):^("IOST(0)"),1:$G(^%ZIS(1,%H,"SUBTYPE")))
 . S:IO="" POP=1
 . Q
 S %A=+$G(^%ZIS(1,%E,"SUBTYPE")),%ZISTP=0 ;%A is pointer to subtype
 I %E=%H,%ZTYPE["TRM" D  I 1
 . I $D(^XUTL("XQ",$J,"IOST(0)")) D  ;Use home
 . . S %A=+^XUTL("XQ",$J,"IOST(0)"),%Z91="",%ZISTP=1
 . . F %ZISI="IOM","IOF","IOSL","IOBS","IOXY" S %Z91=%Z91_$G(^XUTL("XQ",$J,%ZISI))_"^"
 . E  S %=$$LNPRTSUB^%ZISUTL I %>0 S %A=%,%Z91=""
 E  S %Z91=$P($G(^%ZIS(2,%A,1)),"^",1,4),$P(%Z91,"^",5)=$G(^("XY"))
 ;
 D ST^%ZIS3(%ZISTP) S:%ZIS["U" USIO=$P(%Z91,"^",1,4)
T2 I POP S:%ZIS'["T" IO="" Q
 ;Removed HG from next line.
 ;**P585 START CJM
 ;G ^%ZIS3:"^MTRM^VTRM^TRM^SPL^MT^SDP^HFS^RES^OTH^BAR^IMPC^CHAN^"[("^"_%ZTYPE_"^") ;Jump to next part
 G ^%ZIS3:"^MTRM^VTRM^TRM^SPL^MT^SDP^HFS^RES^OTH^BAR^IMPC^CHAN^PQ^"[("^"_%ZTYPE_"^") ;Jump to next part
 ;**P585 END CJM
 S POP=1 Q
 ;
QUECHK() ;Return 1 if OK
 S %ZFQ=$P(%Z,"^",12) ;5.5 =QUEUING 0:ALLOWED;1:FORCED;2:NOT ALLOWED;
 ;Forced Queuing, Don't check if %ZIS["N"
 S:%ZIS["Q"&'$D(ZTQUEUED)&(%ZFQ=1!$D(XQNOGO)) %ZISB=0,IO("Q")=1
 I %ZFQ=1,(%ZIS'["Q")&(%ZIS'["N"),'$D(ZTQUEUED) D  Q 0
 . W:'$D(IOP) !,"Sorry, QUEUING is required for this device."
 . S POP=1
 . Q
 ;Or Queuing NOT allowed
 I %ZFQ=2 S %ZIS=$TR(%ZIS,"Q") I $D(IO("Q")) D  Q 0
 . W:'$D(IOP) !,"Queuing NOT ALLOWED on this device"
 . S POP=1 K:$D(IOP) IO("Q")
 . Q
 Q 1
 ;
OTHCPU(%1) ;%1 should be either DEVICE or HUNT GROUP
 N %2,X,Y,%ZISMSG S %ZISMSG=0
 F %2="CPU","VOLUME SET" D
 .I %2="VOLUME SET" S X=$P($P(%Z,"^",9),":"),Y=%ZISV
 .E  D GETENV^%ZOSV S X=$P($P(%Z,"^",9),":",2),Y=$P($P(Y,"^",4),":",2)
 .I X=Y!(X="") Q:%1="DEVICE"  D  Q  ;Other Vol Set/Cpu Check
 ..S %ZISHG(0)=%E,%ZISHG=$P(%Z,"^")
 ..I %ZISB S POP=1
 ..E  S IO=" "
 .I %2="VOLUME SET" S $P(%ZISCPU,":")=X
 .E  S $P(%ZISCPU,":",2)=X
 .I %1="HUNT GROUP" K %ZISHG(0)
 .I %ZIS["Q" S IO("Q")=1,%ZISB=0 S:%1="HUNT GROUP" IO=" "
 .E  I %ZISB&(%ZTYPE="TRM"&($D(%ZISHG(0))&(%ZIS'["D"))) S POP=1
 .E  W:'$D(IOP)&'%ZISMSG *7,"  ["_%1_" is on another "_%2_" ('"_X_"')]",! S POP=1,%ZISMSG=1
 Q
IOPAR(%DA,%N) ;Return I/O parameter
 Q $S($L($G(%ZIS(%N))):%ZIS(%N),1:$G(^%ZIS(1,%DA,%N)))
 ;
SEC ;Do Security check
 I %Z95]"" S %X=$G(DUZ(0)) I %X'="@" S POP=1 F %A=1:1:$L(%X) I %Z95[$E(%X,%A) S POP=0 Q
 I POP,'$D(IOP),'$D(%ZISHP) W *7,"  [Access Prohibited]"
 Q
 ;
 ;
 ;
 ;
 ;
