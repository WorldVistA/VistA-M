XVEMDY ;DJB/VEDD**Init,Partition,Branching,Error ;2017-08-15  12:25 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
INIT ;
 S:'$D(FLAGH) FLAGH=0
 ;If PRINTING="YES", Print option in Main Menu will be enabled.
 S PRINTING="NO" I $D(^%ZIS(1)),$D(^%ZIS(2)) S PRINTING="YES"
 I '$D(XVV("OS")) D OS^XVEMKY Q:FLAGQ
 I '$D(XVV("$ZE")) D ZE^XVEMKY1
 D INIT^XVEMKY
 I $D(XVV("TRMON"))#2=0 D TRMREAD^XVEMKY1
 Q
VGL1 ;Global Lister called from Main Menu
 I $G(FLAGVPE)["VRR" D  S FLAGG=1 Q
 . W $C(7),"   You can't call VGL when VRR is running."
 I $G(FLAGVPE)["VGL" D  S FLAGG=1 Q
 . W $C(7),"   You are already running VGL."
 I '$$EXIST^XVEMKU("XVEMG") D  S FLAGG=1 Q
 . W $C(7),"   You don't have the 'Acme Global Lister' Routines."
 I $G(DUZ(0))'["@",$G(DUZ(0))'["#" D  S FLAGG=1 Q
 . W $C(7),"   You don't have access. See Help option."
 D VGLRUN Q
VGL2 ;Global Lister called from 'Fld Global Location' option
 I $G(FLAGVPE)["VRR" D  D PAUSE^XVEMKC(2) Q
 . W $C(7),!!?1,"You can't call VGL when VRR is running."
 I $G(FLAGVPE)["VGL" D  D PAUSE^XVEMKC(2) Q
 . W $C(7),!!?1,"You are already running VGL."
 I '$$EXIST^XVEMKU("XVEMG") D  D PAUSE^XVEMKC(2) Q
 . W $C(7),!!?1,"You don't have the 'Acme Global Lister' Routines."
 I $G(DUZ(0))'["@",$G(DUZ(0))'["#" D  D PAUSE^XVEMKC(2) Q
 . W $C(7),!!?1,"You don't have access. See Help option in Main Menu."
 D VGLRUN Q
VGLRUN ;Run the Acme Global Lister
 I FLAGP D PRINT^XVEMDPR ;Shut off printing
 W !?1,"VGL - VGlobal Lister"
 D SYMTAB^XVEMKST("C","VEDD",1) ;Clear symbol table
 D ^XVEMG
 D SYMTAB^XVEMKST("R","VEDD",1) ;Restore symbol table
 S FLAGQ=1
 Q
ERROR ;Error trap.
 NEW ZE
 S @("ZE="_XVV("$ZE"))
 S FLAGE=1 KILL ^TMP("XVV","VEDD",$J)
 I ZE["<INRPT>" W !!?1,"....Interrupted.",!! Q
 D ERRMSG^XVEMKU1("VEDD")
 I $G(FLAGVPE)["VGL"!($G(FLAGVPE)["VRR") D PAUSE^XVEMKU(2)
 Q
