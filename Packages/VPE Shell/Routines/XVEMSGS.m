XVEMSGS ;DJB/VSHL**VShell Global - System QWIKs ;2017-08-15  4:54 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; QWIKs E, VRR, ZR modified (c) 2016 Sam Habiel
 ;
SYSTEM ;Load the System QWIKs
 NEW I,QWIK,TYPE,TXT,VEN
 KILL ^XVEMS("QS")
 S ^XVEMS("QS")="System QWIK COMMANDs"
 S ^XVEMS("QU")="User QWIK COMMANDs"
 F I=1:1 S TXT=$T(QWIK+I) Q:$P(TXT,";",3)="***"  S QWIK=$P(TXT,";",3),TYPE=$P(TXT,";",4) D
 . I TYPE="D" S ^XVEMS("QS",QWIK,"DSC")=$P(TXT,";",5,999)
 . I TYPE="C" S ^XVEMS("QS",QWIK)=$P(TXT,";",5,999) ;Code
 . I TYPE?1.N S ^XVEMS("QS",QWIK,TYPE)=$P(TXT,";",5,999) ;Vendor specific code
 Q
 ;
QWIK ;System QWIK Commands
 ;;ASCII;D;ASCII Table^^3
 ;;ASCII;C;D ASCII^XVEMST
 ;;CAL;D;Calendar Display^%1=Number of Starting Month^3
 ;;CAL;C;D CALENDAR^XVEMST
 ;;CLH;D;Resequence Command Line History^^2
 ;;CLH;C;D CLH^XVEMSY1
 ;;DIC;D;Fileman DIC Look-up Template^^4
 ;;DIC;C;D DICCALL^XVEMSU1
 ;;DTMVT;D;Reset VT-100 in DataTree^^2
 ;;DTMVT;C;Q:XVV("OS")'=9  Q:XVV("IO")'=1  U 1:VT=1
 ;;E;D;Routine Editor^%1=Rtn Name^3
 ;;E;C;D ^XVSE
 ;;FMC;D;Fileman Calls^^4
 ;;FMC;C;D ^XVEMSF
 ;;FMTI;D;Fileman Input Template Display^^4
 ;;FMTI;C;D DIET^XVEMSU1
 ;;FMTP;D;Fileman Print Template Display^^4
 ;;FMTP;C;D DIPT^XVEMSU1
 ;;FMTS;D;Fileman Sort Template Display^^4
 ;;FMTS;C;D DIBT^XVEMSU1
 ;;KEY;D;Display Escape Sequence for any Key^^3
 ;;KEY;C;D KEY^XVEMSU1
 ;;LBRY;D;Routine Library^%1=ON/OFF %2=Module (L/V)^3
 ;;LBRY;C;D ^XVEMRLM
 ;;LF;D;VA KERNEL Library Functions^^4
 ;;LF;C;D ^XVEMSL
 ;;NOTES;D;VPE Programmer Notes^^3
 ;;NOTES;C;D HELP^XVEMKT("NOTES")
 ;;PARAM;D;System Parameters^^2
 ;;PARAM;C;D ^XVEMSP
 ;;PUR;D;Purge VShell Temp Storage Area - XVEMS("%")^%1=Number of days to preserve^2
 ;;PUR;C;D PURGE^XVEMSU
 ;;PURVGL;D;Purge Command Line History (VGL)^^2
 ;;PURVGL;C;KILL ^XVEMS("CLH",XVV("ID"),"VGL")
 ;;PURVRR;D;Purge Command Line History (VRR)^^2
 ;;PURVRR;C;KILL ^XVEMS("CLH",XVV("ID"),"VRR")
 ;;PURVEDD;D;Purge Command Line History (VEDD)^^2
 ;;PURVEDD;C;KILL ^XVEMS("CLH",XVV("ID"),"VEDD")
 ;;PURVSHL;D;Purge Command Line History (VShell)^^2
 ;;PURVSHL;C;KILL ^XVEMS("CLH",XVV("ID"),"VSHL")
 ;;QB;D;Assign QWIK to Display Box^^1
 ;;QB;C;D BOX^XVEMSQU
 ;;QC;D;Copy a QWIK^^1
 ;;QC;C;D COPY^XVEMSQU
 ;;QD;D;Delete a QWIK^^1
 ;;QD;C;D DELETE^XVEMSQU
 ;;QE;D;Add/Edit a QWIK^^1
 ;;QE;C;S XVVSHC="<TAB>" D ^XVEMSQ
 ;;QL1;D;List User QWIKs & Description^^1
 ;;QL1;C;S XVVSHC="<F1-1>" D ^XVEMSQ
 ;;QL2;D;List User QWIKs & Code^^1
 ;;QL2;C;S XVVSHC="<F1-2>" D ^XVEMSQ
 ;;QL3;D;List System QWIKs & Description^^1
 ;;QL3;C;S XVVSHC="<F1-3>" D ^XVEMSQ
 ;;QL4;D;List System QWIKs & Code^^1
 ;;QL4;C;S XVVSHC="<F1-4>" D ^XVEMSQ
 ;;QSAVE;D;Save/Restore User QWIKs^^1
 ;;QSAVE;C;D SAVE^XVEMSS
 ;;QV;D;Add Vendor Specific Code^^1
 ;;QV;C;D VENDOR^XVEMSQV
 ;;QVL;D;List Vendor Specific Code^^1
 ;;QVL;C;D VENLIST^XVEMSQW
 ;;UL;D;List Users DUZ/ID^^2
 ;;UL;C;D LIST^XVEMSID
 ;;VEDD;D;VElectronic Data Dictionary^^3
 ;;VEDD;C;D PARAM^XVEMD(%1,%2,%3)
 ;;VER;D;VShell Version Information^^2
 ;;VER;C;D VERSION^XVEMSU2
 ;;VGL;D;VGlobal Lister^^3
 ;;VGL;C;D PARAM^XVEMG(%1)
 ;;VRR;D;VRoutine Reader^^3
 ;;VRR;C;D PARAM^XVEMR(%1,%2)
 ;;XQH;D;Help Text for Kernel Menu Options^%1=Kernel Menu Option^4
 ;;XQH;C;D XQH^XVEMST
 ;;ZD;D;KILL variables whose names start with these letters^%1=letters %2=letters ...^3
 ;;ZD;C;D ^XVEMSD
 ;;ZI;D;ZInsert a Routine^^3
 ;;ZI;C;D ^XVEMSI
 ;;ZP;D;ZPrint a Routine^%1=Rtn Name^3
 ;;ZP;C;D ZPRINT^XVEMSU2
 ;;ZR;D;ZRemove 1 to 9 Routines^%1=Rtn Name  %2=Rtn Name ...^3
 ;;ZR;C;D ZREMOVE^XVEMSU2()
 ;;ZW;D;ZWrite Symbol Table^%1=Starting letter^3
 ;;ZW;C;D WRITE^XVEMSPS(%1)
 ;;***
