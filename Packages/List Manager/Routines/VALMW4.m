VALMW4 ; ALB/MJK - Create STUB routine;04:07 PM  16 Dec 1992
 ;;1;List Manager;;Aug 13, 1993
 ;
EN(VALMIFN) ; -- stub builder
 N VALMSYS,VALMNS,VALMROU,VALMAX
 S U="^",DTIME=600 K ^UTILITY($J)
 I '$$DUZ^VALMW3() G ENQ
 S VALMSYS=$$OS^VALMW3() I VALMSYS="" G ENQ
 W !!,">>> The system will create a stub routine..."
 S VALMROU=$$ROU^VALMW3() I VALMROU="" G ENQ
 S VALMAX=5000 ;$$MAX^VALMW3() I 'VALMAX G ENQ
 W !!!,">>> Building '",VALMROU,"' stub routine..."
 D BLD,FILE(.VALMROU),TEMP
ENQ Q
 ;
TEMP ; -- set defaults
 S DIE="^SD(409.61,",DA=VALMIFN,DR="[VALM NEW ENTRY DEFAULTS]" D ^DIE
 K DR,DA,DIE
 Q
 ;
BLD ; -- build utility
 N VALMLN,VALMNAME
 S VALMLN=0
 S VALMNAME=$P($G(^SD(409.61,VALMIFN,0)),U)
 D SET("EN ; -- main entry point for "_VALMNAME)
 D SET(" D EN^VALM("""_VALMNAME_""")")
 D SET(" Q")
 D SET(" ;")
 D SET("HDR ; -- header code")
 D SET(" S VALMHDR(1)=""This is a test header for "_VALMNAME_".""")
 D SET(" S VALMHDR(2)=""This is the second line""")
 D SET(" Q")
 D SET(" ;")
 D SET("INIT ; -- init variables and list array")
 D SET(" F LINE=1:1:30 D SET^VALM10(LINE,LINE_""     Line number ""_LINE)")
 D SET(" S VALMCNT=30")
 D SET(" Q")
 D SET(" ;")
 D SET("HELP ; -- help code")
 D SET(" S X=""?"" D DISP^XQORM1 W !!")
 D SET(" Q")
 D SET(" ;")
 D SET("EXIT ; -- exit code")
 D SET(" Q")
 D SET(" ;")
 D SET("EXPND ; -- expand code")
 D SET(" Q")
 D SET(" ;")
 Q
 ;
SET(X) ; -- set line utility
 S VALMLN=VALMLN+1,^UTILITY($J,VALMLN,0)=X W "."
 Q
 ;
FILE(VALMROU) ; -- file routines
 N %H,VALMDATE,VALMNUM,VALMLN
 S %H=+$H D YX^%DTC
 S VALMDATE=$E(Y,5,6)_"-"_$E(Y,1,3)_"-"_$E(Y,9,12)
 S VALMNUM="",VALMLN=0
 F  D SAVE(.VALMROU,.VALMNUM,.VALMLN,.VALMDATE) Q:VALMLN=""  S VALMNUM=VALMNUM+1
 Q
 ;
SAVE(VALMROU,VALMNUM,VALMLN,VALMDATE) ; -- save to routine
 N LINE,SIZE
 K ^UTILITY($J,0) S ^(0,1)=VALMROU_VALMNUM_" ; ; "_VALMDATE,^(1.1)=" ;; ;",SIZE=0
 F LINE=2:1 S VALMLN=$O(^UTILITY($J,VALMLN)) Q:VALMLN=""  S ^UTILITY($J,0,LINE)=^(VALMLN,0),SIZE=$L(^(LINE))+SIZE I $E(^(LINE),1,2)'=" .",SIZE+700>VALMAX Q
 I VALMLN,$O(^UTILITY($J,VALMLN)) S ^UTILITY($J,0,LINE+1)=" G "_VALMROU_(VALMNUM+1)
 S X=VALMROU_VALMNUM X ^DD("OS",VALMSYS,"ZS") W !,X_" has been filed..."
 Q
 ;
