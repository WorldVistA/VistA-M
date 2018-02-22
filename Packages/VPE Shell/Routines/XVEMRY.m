XVEMRY ;DJB/VRR**Init,Branching,Error ;2017-08-15  4:37 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; VGL,RSE changes (c) Sam Habiel 2016
 ;
INIT ;Initialize variables
 NEW X,Y
 S VRRS=$S($G(VRRS)="":1,1:(VRRS+1)) ;VRRS=# of pgms you are viewing
 D INIT^XVEMKY Q:$G(FLAGVPE)["VRR"
 I $D(XVV("OS"))#2=0 D OS^XVEMKY Q:FLAGQ
 I $D(XVV("$ZE"))#2=0 D ZE^XVEMKY1
 I $D(XVV("TRMON"))#2=0 D TRMREAD^XVEMKY1
 D REVVID^XVEMKY2
 D BS^XVEMKY1
 D SCRNVAR^XVEMKY2
 D BLANK^XVEMKY3
 D WRAP^XVEMKY2 W @(XVVS("NOWRAP"))
 Q
VGL ;Run the VGlobal Lister
 I $G(VRRS)>2 D  D PAUSE^XVEMKC(1) Q
 . W $C(7),!?1,"You can't call VGL if you've branched to more than 2 programs."
 I '$$EXIST^XVEMKU("XVEMG") D  D PAUSE^XVEMKC(1) Q
 . W $C(7),!?1,"You don't have the 'VGlobal Lister' Routines."
 D SYMTAB^XVEMKST("C","VRR",VRRS) ;Clear symbol table
 D ^XVEMG X XVVS("RM0")
 D SYMTAB^XVEMKST("R","VRR",VRRS) ;Restore symbol table
 Q
VEDD ;Call VEDD, VElectronic Data Dictionary
 I $G(VRRS)>2 D  D PAUSE^XVEMKC(1) Q
 . W $C(7),!?1,"You can't call VEDD if you've branched to more than 2 programs."
 I '$$EXIST^XVEMKU("XVEMD") D  D PAUSE^XVEMKC(1) Q
 . W $C(7),!?1,"You don't have the 'VElectronic Data Dictionary' Routines."
 D SYMTAB^XVEMKST("C","VRR",VRRS) ;Clear symbol table
 D DIR^XVEMD X XVVS("RM0")
 D SYMTAB^XVEMKST("R","VRR",VRRS) ;Restore symbol table
 Q
RSE ;Search Routine for string(s)
 D ^XVEMRSS
 Q
ERROR ;Error trap.
 NEW ZE
 S @("ZE="_XVV("$ZE"))
 I ZE["<INRPT>" W !!?1,"....Interrupted.",!!
 E  D ERRMSG^XVEMKU1("VRR")
 D PAUSE^XVEMKU(2)
 S:$G(VRRS)'>0 VRRS=1 G EX^XVEMR
 Q
ERROR1 ;Error trap
 I $D(XVV("TRMOFF")) X XVV("TRMOFF")
 I $D(XVV("EON")) X XVV("EON")
 D ENDSCR^XVEMKT2
 D ERRMSG^XVEMKU1("VRR"),PAUSE^XVEMKU(2)
 D REDRAW1^XVEMRU
 Q
