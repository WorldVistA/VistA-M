XDRPREI ;SFISC/VYD - DELETE FILE 15 AND 15.1 DD ;07/12/93  15:07
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;This preinit routine will delete data dictionaries for file 15 and
 ;15.1.  It is primarily intended for IHS.
 N XDRAGNCY,DIU
 S XDRAGNCY=$P($G(^XMB(1,1,0)),U,8) ;get the agency code
 D:"V"'[XDRAGNCY  ;continue if not a VA site
 .S DIU(0)="" F DIU="^VA(15,","^VA(15.1," D EN^DIU2
 Q
