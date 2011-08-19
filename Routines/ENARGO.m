ENARGO ;(WIRMFO)/JED,SAB-MOVE ARCHIVE GLOBAL TO STORAGE MEDIA ;4.29.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 Q
A ; Archive global to media
 ; called by ENAR1
 ; input
 ;   ENGBL  - global subscript in ^ENAR to be archived (e.g. 6919.1)
 ;   ENTIME - date/time of archive session (internal format)
 ;   ENERR  - error message text (should be 0 for no error)
 ; output
 ;   ENERR  - error message text or 0 when no error
 D DT^DICRW
 ;
 S ENHFSM="W",ENHFSIO="" D ARDEV I ENERR'=0 G OUT
 I IOT="MT" D MTSETUP I ENERR'=0 G CLOUT
 I IOT="MT" D MTCHECK I ENERR'=0 G CLOUT
 I IOT="MT" X ENWPROT I Y D  G A
 . D CLOSE
 . W $C(7),!!,"But your tape is write protected!!" D MSG
 ;
 U IO(0) W !,"Beginning output"
 ; determine header info
 S ENHD(1)=$$FMTE^XLFDT(ENTIME)
 S ENHD(2)=$P(^ENAR(ENGBL,0),"^",1)_", ID# "_$P(^(-1),",",3)_", "_$P(^(0),"^",3)_" RECORDS SAVED"
 S ENHD(3)="^ENAR("_ENGBL_",-1)"
 S ENHD(4)=@ENHD(3)
 ; write data to archive device
 U IO S ENSTART=$P($H,",",2)
 ; - write header info
 W ENHD(1) W:IOT'="MT" ! W ENHD(2) W:IOT'="MT" !
 ; - write nodes and content of nodes
 S ENX="^ENAR("_ENGBL_")",ENC=0
 F  S ENX=$Q(@ENX) Q:ENX=""  Q:$QS(ENX,1)'=ENGBL  D
 . W ENX W:IOT'="MT" ! W @ENX W:IOT'="MT" !
 . S ENC=ENC+1 I '(ENC#100) U IO(0) W "." U IO
 ; - write footer info
 W "**EOF**" W:IOT'="MT" ! W "**EOF**" W:IOT'="MT" !
 U IO(0)
 W !,"Elapsed time: ",$J($P($H,",",2)-ENSTART/60,6,2)," minutes.",!
 ;
 S DIR(0)="Y",DIR("A")="Archive complete, care to verify",DIR("B")="YES"
 S DIR("?",1)="This process reads archived records and compares them to"
 S DIR("?",2)="the source global."
 S DIR("?",3)=" "
 S DIR("?")="Enter YES or No"
 D ^DIR K DIR
 I 'Y S ENERR="VERIFY DECLINED" K ^ENAR(ENGBL,"LOCK") G CLOUT
 ;
 S DIR(0)="SB^F:FULL;H:HEADER-ONLY"
 S DIR("A")="Select type of verify to perform",DIR("B")="FULL"
 S DIR("?",3)="FULL - Every record is read from the archive media and"
 S DIR("?",4)="  compared to the source global."
 S DIR("?",1)="HEADER-ONLY - The header data (4 lines) is read from the"
 S DIR("?",2)="  archive media and compared to expected values."
 S DIR("?",5)=" "
 S DIR("?")="Enter H or F"
 D ^DIR K DIR I $D(DIRUT) S ENERR="USER VERIFY ABORT" G CLOUT
 S ENVT=Y
 ;
VRF ; Verify
 ; rewind (or close and reopen) device
 W !,"Please wait while I rewind (or reopen) the archive device."
 S Y=$S("^MT^HFS^SDP^"[(U_IOT_U):$$REWIND^%ZIS(IO,IOT,IOPAR),1:0)
 I 'Y D CLOSE S IOP=ENION,ENHFSM="R" D ARDEV G:ENERR'=0 OUT
 I IOT="MT" D MTCHECK I ENERR'=0 G CLOUT
 ;
 S ENREDO=0,ENSTART=$P($H,",",2)
 D VHDR G:ENREDO VRF I ENERR'=0 G CLOUT
 I ENVT="F" D VREC G:ENREDO VRF I ENERR'=0 G CLOUT
 ;
 D CLOSE
 W !,"Elapsed time: ",$J($P($H,",",2)-ENSTART/60,6,2)," minutes."
 K ^ENAR(ENGBL,"LOCK")
 G OUT
 ;
VHDR ; verify header
 U IO(0) W !!,"Verifying Header..."
 U IO R ENX(1):15,ENX(2):15,ENX(3):15,ENX(4):15
 U IO(0)
 F ENI=1:1:4 Q:ENX(ENI)'=ENHD(ENI)
 I ENX(ENI)'=ENHD(ENI) D
 . W $C(7),!!,"Expected: ",ENHD(ENI),!,"Found: ",ENX(ENI)
 . S DIR(0)="Y",DIR("A")="Try again",DIR("B")="YES"
 . D ^DIR K DIR I Y S ENREDO=1 Q
 . S ENERR="BAD HEADER VERIFY"
 I ENX(ENI)=ENHD(ENI) W "Header OK"
 Q
 ;
VREC ; verify records
 U IO(0) W !,"Continuing with full verify"
 S (ENC,ENC("VERR"))=0
 U IO
 F  R ENX:15,ENX(1):15 Q:ENX="**EOF**"  D:ENX(1)'=@ENX  Q:ENC("VERR")>5  S ENC=ENC+1 I '(ENC#100) U IO(0) W "." U IO
 . U IO(0)
 . S ENC("VERR")=ENC("VERR")+1
 . W $C(7),!,"WARNING: ",ENX,!,"Expected: ",@ENX,!,"Found: ",ENX(1)
 . I ENC("VERR")'>5 W !!,"continuing"
 . U IO
 U IO(0)
 I ENC("VERR")>5 D
 . W $C(7),!,"Sorry, the verify doesn't look good"
 . S DIR(0)="Y",DIR("A")="Try again",DIR("B")="YES"
 . D ^DIR K DIR I Y S ENREDO=1 Q
 . S ENERR="BAD VERIFY"
 Q
 ;
CLOUT ; Close archive device and exit
 D CLOSE
OUT ; Exit
 K ENBOT,ENC,ENEOT,ENHD,ENHFSIO,ENHFSM,ENI,ENION,ENMTERR
 K ENONLINE,ENR,ENREDO,ENREW,ENSTART,ENVT,ENWPROT,ENX
 K DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
MSG W !,"Press <RETURN> to continue" R ENR:DTIME S:'$T ENR="^" Q
 ;
ARDEV ; Select and open archival device
 ; called from ENARGO, ENARGR
 ; input
 ;   ENHFSM - host file access mode ('W'rite-only or 'R'ead-only)
 ;   ENERR  - error message text (should be 0 for no error)
 ;   IOP    - (optional) name of device to use
 ;   ENHFSIO - (optional) name of host file to open
 ; output
 ;   ENERR  - 0 or error message text
 ;   ENION  - ION of selected device
 ;   ENHFSIO - name of host file opened (only defined when IOT="HFS")
 I '$D(IOP) W $C(7),!!,"If using tape, please load ",$S(ENHFSM="W":"WRITE ENABLED ",ENHFSM="R":"WRITE PROTECTED ",1:""),"tape and bring on-line now",!
 S %ZIS("A")="ARCHIVAL DEVICE: ",%ZIS("B")="",%ZIS("HFSMODE")=ENHFSM
 I $G(ENHFSIO)]"" S %ZIS("HFSNAME")=ENHFSIO
 S %ZIS("S")="I ""^VTRM^TRM^""'[(U_$G(^(""TYPE""))_U)"
 D ^%ZIS I POP S ENERR="ARCHIVAL DEVICE NOT SELECTED" Q
 S ENION=ION
 S ENHFSIO=$S(IOT="HFS":IO,1:"")
 Q
 ;
CLOSE ; Close archival device
 ; called from ENARGO, ENARGR
 D ^%ZISC
 Q
 ;
MTSETUP ; Mag Tape Variables Setup
 ; called from ENARGO, ENARGR
 I '$D(^%ZOSF("MAGTAPE"))!('$D(^("EOT")))!('$D(^("MTBOT")))!('$D(^("MTERR")))!('$D(^("MTONLINE")))!('$D(^("MTWPROT"))) S ENERR="YOUR %ZOSF GLOBAL NODES FOR MAGTAPE ARE NOT SET UP.  CANNOT PROCEED." Q
 X ^%ZOSF("MAGTAPE") S ENREW=%MT("REW") K %MT
 S ENEOT=^%ZOSF("EOT"),ENBOT=^%ZOSF("MTBOT")
 S ENMTERR=^%ZOSF("MTERR"),ENONLINE=^%ZOSF("MTONLINE")
 S ENWPROT=^%ZOSF("MTWPROT")
 Q
 ;
MTCHECK ; Mag Tape Check
 ; called from ENARGO, ENARGR
 ; Checks if Mag Tape is online and rewind if at BOT
 U IO X ENONLINE G:Y MTC1
 U IO(0) W !,"Tape off-line, please make ready" D MSG
 I ENR="^" S ENERR="USER INTERUPT @TAPE STATUS" Q
 G MTCHECK
MTC1 U IO X ENBOT Q:Y
 U IO(0) W !,"Rewinding tape" U IO W @ENREW
 Q
 ;ENARGO
