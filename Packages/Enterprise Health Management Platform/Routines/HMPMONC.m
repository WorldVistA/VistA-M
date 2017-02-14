HMPMONC ;asmr-ven/toad-dashboard: auto-update rate ;2016-06-29 13:57Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine HMPMONC
 ;
 ; primary development
 ;
 ; primary developer: Frederick D. S. Marshall (toad)
 ; original author: Raymond Hsu (hsu)
 ; original org: U.S. Department of Veterans Affairs (va)
 ; prime contractor ASM Research (asmr)
 ; development org: VISTA Expertise Network (ven)
 ;
 ; 2015-11-02/2016-02-29 va/hsu: develop auto-refresh feature, first
 ; in routine HMPDJFSM, then in HMPDBMN.
 ;
 ; 2016-03-18/04-06 asmr-ven/toad: created routine HMPMONC from rate
 ; subroutines C, $$RATE, SETSYS, and SETPKG^HMPMOND, which in turn
 ; were created from Team Krypton's subroutines in HMPMONDB; change
 ; options HMPMON SET SYS DASHBOARD RATE and HMPMON SET PKG
 ; DASHBOARD RATE to invoke moved subroutines; fix org & history.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-28/29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; fix "; lookup by prefiX" in SETPKG;
 ; restore EOR line; fix old bug in SETPKG's call to TED^XPAREDIT.
 ;
 ;
 ; contents
 ;
 ; C: dashboard action: change auto-update rate
 ; $$RATE = auto-update rate
 ; SETSYS: option hmpmon set sys dashboard rate
 ; SETPKG: option hmpmon set pkg dashboard rate
 ;
 ;
 ; to do
 ;
 ; convert hard-coded text to Dialog file entries
 ; replace writes with new writer that can reroute output to arrays
 ; create unit tests
 ; change call to top into call to unit tests
 ;
 ;
C ; dashboard action: change auto-update rate
 ;ven/toad;private;procedure;clean;dialog;sac
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   TED^XPAREDIT: use template to edit parameter
 ;   $$RATE = resulting dashboard auto-update rate
 ; input:
 ;   input from the current device's user
 ; output:
 ;   HMPRATE = new auto-update rate [pass-by-symbol-table]
 ;   HMPEOP = 0 to suppress end-of-page prompt [p-b-s-t]
 ;   issue prompt to current device's user
 ; examples:
 ;   [develop examples]
 ;
 new HMPFLAG set HMPFLAG="AB"
 new HMPTEMPL set HMPTEMPL="HMPMON DASHBOARD USR"
 new HMPNTITY set HMPNTITY=DUZ_";VA(200,"
 do TED^XPAREDIT(HMPTEMPL,HMPFLAG,HMPNTITY)
 ;
 set HMPRATE=$$RATE ; set new auto-update rate
 ;
 set HMPEOP=0 ; suppress OPTION^HMPMON's end-of-page prompt
 ; (because TED^XPAREDIT just did one)
 ;
 quit  ; end of C
 ;
 ;
RATE() ; auto-update rate
 ;ven/toad;private;function;clean;silent;sac
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   $$GET^XPAR = parameter value
 ; input: none
 ; output = current auto-update rate
 ; examples:
 ;   [develop examples]
 ;
 new ENTITY set ENTITY="ALL" ; apply all parameters, prioritized
 new PARAM set PARAM="HMPMON DASHBOARD UPDATE" ; param name
 new INSTANCE set INSTANCE=1 ; there's only one per entity
 new FORMAT set FORMAT="I" ; internal, the only format
 new RATE ; auto-update rate
 set RATE=$$GET^XPAR(ENTITY,PARAM,INSTANCE,FORMAT) ; get parameter
 if RATE="" do  ; if parameter value is missing
 . set RATE=DTIME ; default to user time-out rate
 . quit
 ;
 quit RATE ; return auto-update rate
 ;
 ;
SETSYS ; option hmpmon set sys dashboard rate
 ;ven/toad;private;procedure;clean;dialog;sac
 ; called by:
 ;   Menuman
 ; calls:
 ;   $$GET1^DIQ = get current system ien
 ;   TED^XPAREDIT: use template to edit parameter
 ; input:
 ;   input from the current device's user
 ; output:
 ;   parameter hmpmon dashboard update updated for system
 ;   issue prompt to current device's user
 ; examples:
 ;   [develop examples]
 ;
 new HMPSYSN do  ; get current system #
 . new HMPFILE set HMPFILE=8989.3 ; kernel system parameters
 . new HMPREC set HMPREC="1," ; only one entry in file, always #1
 . new HMPFIELD set HMPFIELD=.01 ; domain name
 . new HMPFLAG set HMPFLAG="I" ; internal format
 . set HMPSYSN=$$GET1^DIQ(HMPFILE,HMPREC,HMPFIELD,HMPFLAG) ; get field
 . quit
 new HMPSYS set HMPSYS=HMPSYSN_";DIC(4.2," ; entity = system
 new HMPTEMPL set HMPTEMPL="HMPMON DASHBOARD SYS"
 new HMPFLAG set HMPFLAG="AB"
 do TED^XPAREDIT(HMPTEMPL,HMPFLAG,HMPSYS)
 ;
 quit  ; end of SETSYS
 ;
 ;
SETPKG ; option hmpmon set pkg dashboard rate
 ;ven/toad;private;procedure;clean;dialog;sac
 ; called by:
 ;   Menuman
 ; calls:
 ;   $$FIND1^DIC = find ien of ehmp application
 ;   TED^XPAREDIT: use template to edit parameter
 ; input:
 ;   input from the current device's user
 ; output:
 ;   parameter hmpmon dashboard update updated for package
 ;   issue prompt to current device's user
 ; examples:
 ;   [develop examples]
 ;
 ; this option should only be used by the ehmp primary developers
 ;
 new HMPKGN do  ; find package # for ehmp
 . new HMPFILE set HMPFILE=9.4 ; package
 . new HMPREFIX set HMPREFIX="HMP" ; field prefix (1)
 . new HMPFLAG set HMPFLAG="QX" ; quick, exact
 . new HMPINDEX set HMPINDEX="C" ; lookup by prefix
 . set HMPKGN=$$FIND1^DIC(HMPFILE,,HMPFLAG,HMPREFIX,HMPINDEX)
 . quit
 new HMPKG set HMPKG=HMPKGN_";DIC(9.4," ; entity = package
 new HMPTEMPL set HMPTEMPL="HMPMON DASHBOARD PKG"
 new HMPFLAG set HMPFLAG="AB"
 do TED^XPAREDIT(HMPTEMPL,HMPFLAG,HMPKG)
 ;
 quit  ; end of SETPKG
 ;
 ;
EOR ; end of routine HMPMONC
