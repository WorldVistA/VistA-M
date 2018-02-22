XVEMGY ;DJB/VGL**Init,Partition,Branching,Error ;2017-08-15  12:49 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
INIT ;Initialize variables
 S GLS=$S($G(GLS)=1:GLS+1,1:1) ;GLS is the current session number.
 S ^XVEMS("%",$J_$G(^XVEMS("SY")),"GLS")=GLS ;Protect GLS variable
 S ZDELIM=$C(127)_$C(124) ;Commas
 S ZDELIM1=$C(127)_$C(126) ;Spaces
 S ZDELIM2=$C(127)_$C(64) ;Colons
 I $D(XVV("OS"))#2=0 D OS^XVEMKY Q:FLAGQ
 I $D(XVV("$ZE"))#2=0 D ZE^XVEMKY1
 I $D(XVV("TRMON"))#2=0 D TRMREAD^XVEMKY1
 D REVVID^XVEMKY2
 D INIT^XVEMKY
 Q
VEDD ;Call VEDD, VElectronic Data Dictionary
 I $G(FLAGVPE)["VEDD" D  D PAUSE Q
 . W $C(7),!?1,"You are already running VEDD."
 I GLS>1 D  D PAUSE Q
 . W $C(7),!?1,"You may not call VEDD from an Alternate session."
 I $T(^XVEMD)']"" D  D PAUSE Q
 . W $C(7),!?1,"You do not have ^XVEMD routine on your system."
 I $G(FLAGVPE)["VRR" D  D PAUSE Q
 . W $C(7),!?1,"You can't call VEDD when VRR is running."
 I '$$EXIST^XVEMKU("XVEMD") D  D PAUSE Q
 . W $C(7),!?1,"You don't have the 'VEDD' routines."
 D SYMTAB^XVEMKST("C","VGL",GLS) ;Clear symbol table
 D ^XVEMD
 D SYMTAB^XVEMKST("R","VGL",GLS) ;Restore symbol table
 Q
PAUSE ;Pause screen
 Q:$E($G(XVVIOST),1,2)="P-"  D PAUSE^XVEMKU(2)
 Q
ERROR ;Normal error trap.
 NEW ZE
 S @("ZE="_XVV("$ZE"))
 I '$D(GLS) S GLS=$G(^XVEMS("%",$J_$G(^XVEMS("SY")),"GLS"))
 KILL ^TMP("XVV","IG"_GLS,$J)
 KILL ^TMP("XVV","VGL"_GLS,$J),^TMP("XVV",$J)
 S GLS=GLS-1
 S ^XVEMS("%",$J_$G(^XVEMS("SY")),"GLS")=GLS
 I $G(XVVT("STATUS"))["START" D ENDSCR^XVEMKT2 ;Reset scroll region back to full screen
 S FLAGQ=1 I ZE["<INRPT>" W !!?1,"....Interrupted.",!! Q
 D ERRMSG^XVEMKU1("VGL")
 I $G(FLAGVPE)["VEDD"!($G(FLAGVPE)["VRR") D PAUSE^XVEMKU(2)
 Q
ERROR1 ;Error Trap when testing validity of CODE.
 W $C(7),!!?5,"There is an error in your code. Remember, you must set $T with"
 W !?5,"an IF statement.",!
 G CODE1^XVEMGO
