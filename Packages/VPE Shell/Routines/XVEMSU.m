XVEMSU ;DJB/VSHL**Util - PURGE,KERNSAVE,RESSYM ;2017-08-16  10:45 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in USEZERO (c) 2016 Sam Habiel
 ;
USEZERO ;After executing code, reuse device 0
 I $G(XVV("IO"))="" U 0 Q
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMSU,UNWIND^XVEMSY"
 U XVV("IO")
 Q
ERROR ;Error trap for RESET
 U 0 W $C(7),!!?1,"---------> VSHELL ALERT!"
 W !!?1,"VShell is having trouble USEing device 0. This can happen when the"
 W !?1,"following 3 conditions exist:"
 W !?5,"1. The VShell global is being translated"
 W !?5,"2. You have sessions of VShell running on more than one volume group"
 W !?5,"3. Both sessions have the same $J number but different IO devices"
 W !!?1,"The fix is to log off one volume group and then log back in under"
 W !?1,"a different $J number.",!
 Q
PURGE ;Purge ^XVEMS("%") scratch area
 I $G(%1)'>0 D PURGEMSG Q
 NEW X
 S X="" F  S X=$O(^XVEMS("%",X)) Q:X=""  I X'=($J_$G(^XVEMS("SY"))) D
 . I $G(^XVEMS("%",X))']"" KILL ^(X) Q
 . I $D(^XVEMS("%",X)),(+$H-(+^(X)))>%1 KILL ^XVEMS("%",X) W !?2,"^XVEMS(""%"",",X,") deleted.."
 Q
PURGEMSG ;Message if no parameter is passed
 W $C(7),!?1,"The VSHELL has it's own ""scratch"" global area that is deleted when you"
 W !?1,"HALT. If you HALT unintentionally, these nodes may not be deleted. PUR"
 W !?1,"will delete these older nodes."
 W !!?1,"PUR requires a parameter for the number of days to preserve. You'll want"
 W !?1,"to preserve enough days to cover everyone currently logged into the VSHELL."
 W !!?1,"Ex: ..PUR 7     Deletes all ^XVEMS(""%"") nodes older than 7 days.",!
 Q
 ;===================================================================
KERNSAVE ;Save Symbol Table and ^XUTL("XQ",$J) for Kernel users
 Q:'$D(XQY0)  Q:'$D(^XUSEC(0))
 NEW %,%X,%Y,X,Y
 I $D(^%ZOSF("UCI")) X ^%ZOSF("UCI") S ^XVEMS("%",$J_$G(^XVEMS("SY")),"KRNUCI")=Y
 Q:'$D(^XUTL("XQ",$J))
 S %X="^XUTL(""XQ"",$J,",%Y="^XVEMS(""%"","""_$J_$G(^XVEMS("SY"))_""",""XUTL"","
 D %XY^%RCR,SAVSYM
 Q
SAVSYM ;Save symbol table.
 Q:'$$EXIST^XVEMKU("%ZOSV")
 S X="^XVEMS(""%"","""_$J_$G(^XVEMS("SY"))_""",""SYMTAB""," D DOLRO^%ZOSV
 Q
RESSYM ;Restore symbol table.
 NEW %HLD,%PC,%REF,%VAR
 KILL (XVVSHC) ;Clear symbol table
 S %REF="^XVEMS(""%"","""_$J_$G(^XVEMS("SY"))_""",""SYMTAB"")"
 S %HLD="""%"","""_$J_$G(^XVEMS("SY"))_""",""SYMTAB"","
 F  S %REF=$Q(@%REF) Q:%REF=""!(%REF'[%HLD)  D  ;
 . F %PC=1:1:10 Q:$P(%REF,",",%PC)["SYMTAB"  ;%PC varies with translation
 . S %VAR=$P(%REF,",",(%PC+1)),%VAR=$P(%VAR,"""",2) ;Strip quotes
 . I $P(%REF,",",(%PC+2))]""  S %VAR=%VAR_"("_$P(%REF,",",(%PC+2),99)
 . I $E(%VAR,1)="%"!($E(%VAR,1,3)="XVV") Q
 . S @%VAR=@%REF
 Q
