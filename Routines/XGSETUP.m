XGSETUP ;SFISC/VYD - setup KWAPI environment ;03/16/95  13:29
 ;;8.0;KERNEL;;Jul 10, 1995
PREP ;prepare graphics environment. Can be called multiple times.
 N %,X
 S U="^",C=","
 D CLEAN2
 S XG255=$C(255)
 S XGPAD=$J("",IOM)
 D:'$D(XGATRSET)!('$D(XGEMPATR))!('$D(XGCURATR))!('$D(IORESET)) ATR
 D:'$D(^XUTL("XGATR")) ATRTABLE
 F %=0:1:IOSL-1 D
 . S XGSCRN(%,0)=XGPAD
 . S XGSCRN(%,1)=$TR(XGPAD," ",XGEMPATR)
 D ADJUST^XGSW(0,0,IOSL-1,IOM-1,"XGSCRN")  ;store "COORDS" node
 S XGSCRN("ORDER",0)=$C(1)
 W IORESET,IOCUOFF,IOKPAM,@IOF
 S XGCURATR=XGEMPATR
 X ^%ZOSF("EOFF")
 S X=0 X ^%ZOSF("RM")
 D INIT^XGKB("*") ;turn on escape processing
 S $X=0,$Y=0 ;S ($X,$Y)=0 ;DTM 4.3 choked here
 Q
 ;
 ;
KWAPI ;K-WAPI specific setup
 N %
 S (XGOLDFCS,XGNEWFCS)=""
 S XGFLAG("ABORT")=0 ;flag if 1 will stop processing of a gadget
 S XGFLAG("PAINT")=21 ;initialize paint flag
 S XGESEQ="1000000^0" ;event_stack_level^event_sequence_counter unique
 S XGMENU="" ;flag if not empty indicates that user went or is in menu
 S XGUFCTR("PIXEL","X")=0.125
 S XGUFCTR("PIXEL","Y")=0.05
 S XGUFCTR("CHAR","X")=1
 S XGUFCTR("CHAR","Y")=1
 ;
 ;------------set up DISPLAY with defaults
 S ^TMP("XGD",$J,$PD,"PLATFORM")="ZEMULATION,KERNEL "_$$VERSION^XPDUTL("XU")
 S:'$D(^TMP("XGD",$J,$PD,"FOCUS")) ^("FOCUS")=""
 S:'$D(^TMP("XGD",$J,$PD,"UNITS")) ^("UNITS")="PIXEL"
 ;
 ;------------load key-actions
 D ACTION^XGKB("KP0","D KP0^XGJUMP")        ;menubar
 D ACTION^XGKB("F10","D KP0^XGJUMP")        ;menubar
 D ACTION^XGKB("CR","D CR^XGJUMP")
 D ACTION^XGKB("^C","D CTRLC^XGJUMP")       ;break the program
 D ACTION^XGKB("^R","D CTRLR^XGJUMP")       ;window resize
 D ACTION^XGKB("^V","D CTRLV^XGJUMP")       ;window move
 D ACTION^XGKB("^W","D CTRLW^XGJUMP")       ;window select window
 D ACTION^XGKB("^Z","D CTRLZ^XGJUMP")       ;window close
 D ACTION^XGKB("^\","D CTRLBSL^XGJUMP")     ;window control menu
 D ACTION^XGKB("TAB","D TAB^XGJUMP")        ;next gadget
 D ACTION^XGKB("PF4","D PF4^XGJUMP")        ;previous gadget
 ;
 ;------------ set up a window control menu
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",1)="&Restore"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",2)="&Move"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",2,"EVENT","SELECT")="MOVE^XGWCTRL"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",2,"ACCELERATOR")="^V"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",3)="&Size"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",3,"EVENT","SELECT")="RESIZE^XGWCTRL"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",4)="Mi&nimize"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",5)="Ma&ximize"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",5,"SEPARATOR")=1
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",6)="&Close"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",6,"EVENT","SELECT")="CLOSE^XGWCTRL"
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",6,"SEPARATOR")=1
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",7)="S&witch To..."
 S ^TMP("XGUTIL",$J,"~XGWM","CHOICE",7,"EVENT","SELECT")="CTRLW^XGJUMP"
 ;
 ;------------ put up wall paper and save it as 1st window
 ;D GRID^XGFDEMO
 ;D ^XGWALL
 ;M ^TMP("XGS",$J,$C(1))=XGSCRN
 D WINSAVE^XGWIN($C(1),0,0,IOSL,IOM)
 Q
 ;
ATR ;setup screen/graphic params. load attribute array
 ;  this should usually run once at login
 N X
 I ^%ZOSF("OS")["DTM" U $I:VT=1 ;if DTM change to VT220 emulation
 D HOME^%ZIS,GSET^%ZISS
 S X="IOBOFF;IOBON;IODWL;IOINHI;IOINORM;IOKPAM;IOKPNM;IORESET;IORVOFF;IORVON;IOSWL;IOUON;IOUOFF" D ENDR^%ZISS
 S IORESET=$C(27)_"[0m"_IOG0 ;turn off all attr. diff from stnd IORESET
 S IOCUOFF=$C(27)_"[?25l",IOCUON=$C(27)_"[?25h" ;cursor on, cursor off
 S XGATRSET(8)=U_IORESET,XGATRSET(2)=IOBOFF_U_IOBON
 S XGATRSET(3)=IOINORM_U_IOINHI,XGATRSET(4)=IORVOFF_U_IORVON
 S XGATRSET(5)=IOSWL_U_IODWL,XGATRSET(6)=IOG0_U_IOG1
 S XGATRSET(7)=IOUOFF_U_IOUON
 S (XGCURATR,XGEMPATR)=$C(1)
 Q
 ;
ATRTABLE ;setup ^XUTL("XGATR" attr letter to ESC code conversion table
 N %
 F %=1:1:255 S ^XUTL("XGATR",$C(%))=$$ESC^XGSA($C(%))
 Q
 ;
CLEAN ;clean up KWAPI variables, screen/graphic parameters
 ;this tag does universal clean up.  It should be called at the end of all K-WAPI sessions.
 X ^%ZOSF("EON") ; turn echo on
 S X=IOM X ^%ZOSF("RM") ;restore right margin for proper wrapping
 W IOCUON_IOKPNM_IORESET ; cursor on, number mode, reset terminal
 D EXIT^XGKB ;     turn off escape processing
 D KILL^%ZISS,GKILL^%ZISS
 K XGATRSET,XGCURATR,XGEMPATR,XGKEYMAP,XGSPCIAL,XGPAD,XG255
 K IOCUON,IOCUOFF
 K XGWIN,XGEVNT,XGDI
CLEAN2 ;other than fall through, this is called from PREP
 K ^TMP("XGE",$J),^TMP("XGD",$J),^TMP("XGS",$J),^TMP("XGW",$J)
 K ^TMP("XGUTIL",$J),^TMP("XGKEY",$J) ;kill utility and key-action table
 K XGMENU,XGSCRN,XGWT,XGWL,XGWB,XGWR,XGTRACE,XGOLDFCS,XGNEWFCS
 K XGW,XGG,XGID,XGMENU,XGFLAG,XGUFCTR,XGDEFBTN,XGNEXTG,XGWAIT
 Q
