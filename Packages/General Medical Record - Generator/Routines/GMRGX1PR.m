GMRGX1PR ;HIRMFO/RM-PREINIT FOR PATCH GMRG*3*1 ;5/3/96
 ;;3.0;Text Generator;**1**;Jan 24, 1996
 ; This routine will do the following:
 ;  1)  Put four Nursing options out of order while patch is loading
 ;
 D OOS("Installing patch GMRG*3*1")
 Q
OOS(NURMSG) ; options out-of-service
 ; NURMSG = text ==> option is put out-of-service
 ; NURMSG = null ==> option is back in service
 N NUROPT,NURX S NURX=1
 F  S NUROPT=$T(OPTIONS+NURX) Q:$P(NUROPT,";",3)=""  D
 .S NUROPT=$P(NUROPT,";",3),NURX=NURX+1
 .D OUT^XPDMENU(NUROPT,NURMSG)
 .Q
 Q
OPTIONS ; options list
 ;;NURCPE-CARE
 ;;NURCPE-EVAL
 ;;NURCPP-CARE
 ;;NURCPP-EVAL
 ;;;
 Q
