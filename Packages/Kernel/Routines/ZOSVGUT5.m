ZOSVGUT5 ; OSE/SMH - Unit Tests for GT.M VistA Port;2019-12-27  4:28 PM
 ;;8.0;KERNEL;**10004,10005,10006**;;Build 6
 ;
 ; (c) Sam Habiel 2018-2019
 ; Licensed under Apache 2.0
 ;
 D EN^%ut($t(+0),3)
 QUIT
 ;
STARTUP ;
 ; ZEXCEPT: %UTSIMERR1
 K %UTSIMERR1
 QUIT 
 ;
SHUTDOWN ;
 ; ZEXCEPT: %UTSIMERR1
 QUIT
 ;
ZTMGRSET ; @TEST ZTMGRSET Rename Routines ; *10005*
 N IOP S IOP="NULL" D ^%ZIS U IO
 D PATCH^ZTMGRSET(10005)
 D ^%ZISC
 D CHKTF^%ut($T(+2^%ZOSV)[10005)
 QUIT
 ;
EC ; @TEST $$EC^%ZOSV ; *10004*
 N EC
 N V S V=$name(^PS(222,333,444,555,666,777,888))
 D
 . N $ET,$ES S $ET="S EC=$$EC^%ZOSV,$EC="""" D UNWIND^ZU"
 . I @V
 D CHKTF^%ut($P(EC,",",4)["GVUNDEF")
 QUIT
 ;
ZSY ; @TEST RUN ZSY with lsof in sbin ; *10004*
 N IOP S IOP="NULL" D ^%ZIS U IO
 D ^ZSY
 D ^%ZISC
 D SUCCEED^%ut
 QUIT
 ;
ACTJ ; @TEST Use of $T +0 ; *10004*
 D CHKTF^%ut($$ACTJ^%ZOSV)
 QUIT
 ;
PATCH ; @TEST $$PATCH^XPDUTL, which prv accepted only 3 digits (10004 & 10005)
 ; 10005 is an overlay for *672
 D CHKTF^%ut($$PATCH^XPDUTL("XU*8.0*10001"))
 QUIT
 ;
MAXREC ; @TEST $$MAXREC^%ZISH - $T +0 ; *10004
 ; ZEXCEPT: %UTSIMERR1
 D CHKTF^%ut($$MAXREC^%ZISH("^DD"))
 D CHKTF^%ut($$MAXREC^%ZISH($NA(^TMP("SAM",$J))))
 S %UTSIMERR1=1
 N % S %=$$FTG^%ZISH("/usr/include","stdlib.h",$NA(^TMP($J,1,0)),2,"VVV")
 D CHKEQ^%ut(%,0)
 K %UTSIMERR1
 N % S %=$$FTG^%ZISH("/usr/include","stdlib.h",$NA(^TMP($J,1,0)),2,"VVV")
 D CHKEQ^%ut(%,1)
 QUIT
 ;
BL ; @TEST $$BL^%ZOSV ; 10005
 D CHKTF^%ut($$BL^%ZOSV("中文"),6)
 QUIT
 ;
BE ; @TEST $$BE^%ZOSV ; 10005
 N C S C=$$BE^%ZOSV("中文",1,1)
 D CHKEQ^%ut($$BL^%ZOSV(C),1)
 QUIT
 ;
ENV ; @TEST $$ENV^%ZOSV ; 10005
 N PATH S PATH=$$ENV^%ZOSV("PATH")
 D CHKTF^%ut(PATH'="")
 QUIT
 ;
XTROU ;;
 ;;ZOSVGUT6
