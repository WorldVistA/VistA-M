XVSK ; Paideia/SMH - VPE 'Kill' logic ;2017-08-16  10:56 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; (c) 2010-2016 Sam Habiel
 ; Notes: Corresponds to ^XVEMS("ZK")
ZK1 ;
EN ; Kill ^XVEMS("%") on exit ;ZK1
 D:'$D(XVV("ID"))!('$D(XVV("OS"))) RESET^XVSS
 D XUTL,CTRLC,SYMTAB,KILL
 QUIT
 ;
ZK2 ;
XUTL ; Move XUTL back to where it belongs ;ZK2
 Q:'$D(^XVEMS("%",$J_$G(^XVEMS("SY")),"XUTL"))
 KILL ^XUTL("XQ",$J)
 M ^XUTL("XQ",$J)=^XVEMS("%",$J_$G(^XVEMS("SY")),"XUTL") ;/smh
 QUIT
 ;
ZK4 ;
NOZU ; Prevent exit via ZU ;ZK4
 I $D(^XUSEC(0)),",D ^ZU,DO ^ZU,d ^zu,do ^zu,d ^ZU,do ^ZU,"[(","_XVVSHC_",") D
 . S XVVSHC=""
 . W $C(7),!!?2,"HALT out of VSHELL before calling ^ZU.",!
 QUIT
 ;
ZK6 ;
CTRLC ; Disable Ctrl-C if called from the Kernel (i.e. menu option) ;ZK6
 I $D(^XVEMS("%",$J_$G(^XVEMS("SY")),"KRNUCI")) D NOBRK^XVEMKY2
 QUIT
 ;
ZK7 ;
SYMTAB ; Restore Symbol Table (only applicable if called from menu option ;ZK7)
 I $D(^XVEMS("%",$J_$G(^XVEMS("SY")),"SYMTAB")) D RESSYM^XVEMSU
 QUIT
 ;
ZK9 ;
KILL ; The Kill, finally; ZK9
 KILL ^XVEMS("%",$J_$G(^XVEMS("SY")))
 QUIT
 ; ---------------------------------------
 ;UNUSED CODE
ZK3 ; In case we have different UCI's
 N U1,U2
 D ZK8
 I U1]"",U2]"",U1'=U2 D
 . S XVVSHC="NO EXIT"
 . W $C(7),!!?2,"VA KERNEL menu option active."
 . W !?2,"Move to UCI '",U2,"' to HALT."
 . W !
 QUIT
 ;
ZK8 ; Set U1 and U2; U1 = current system; U2= Sign-in system
 S U1=$G(^XVEMS("CLH","UCI",XVV("ID")_$G(^XVEMS("SY"))))
 S U2=$G(^XVEMS("%",$J_$G(^XVEMS("SY")),"KRNUCI"))
 QUIT
 ;
