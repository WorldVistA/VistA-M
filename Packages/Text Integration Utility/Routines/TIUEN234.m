TIUEN234 ; SLC/MAM - Environment Check Rtn for TIU*1*234 ; 12/11/07
 ;;1.0;Text Integration Utilities;**234**;Jun 20, 1997;Build 6
 ; External References
 ;   ICR 3409  ^USR(8930,"B"
 ;   ICR 1544 WHOIS2^USRLM
MAIN ; Check environment.  If AMEND classes not found, abort install.
 N TIUOK S TIUOK=0
 N TIUCLS,TIULST S TIUCLS=+$O(^USR(8930,"B","CHIEF, MIS",""))
 I TIUCLS>0 D  I +TIUOK G MAINX
 . D WHOIS2^USRLM("TIULST",TIUCLS)
 . I $P(TIULST(0),U,3)>0 S TIUOK=1
 N TIUCLS,TIULST S TIUCLS=+$O(^USR(8930,"B","CHIEF, HIM",""))
 I TIUCLS>0 D  I +TIUOK G MAINX
 . D WHOIS2^USRLM("TIULST",TIUCLS)
 . I $P(TIULST(0),U,3)>0 S TIUOK=1
 N TIUCLS,TIULST S TIUCLS=+$O(^USR(8930,"B","PRIVACY ACT OFFICER",""))
 I TIUCLS>0 D  I TIUOK G MAINX
 . D WHOIS2^USRLM("TIULST",TIUCLS)
 . I $P(TIULST(0),U,3)>0 S TIUOK=1
 S XPDABORT=1
 W !,"  Documents cannot be amended except by members of class CHIEF, MIS,"
 W !,"CHIEF, HIM, or PRIVACY ACT OFFICER. (Classes must be named exactly as listed.)"
 W !,"  I can't find any users in these classes. Please check with the person who"
 W !,"maintains User Classes at your site."
 W !,"  Aborting install."
MAINX ;
 I TIUOK W !,"  User Classes look ok."
 Q
 ;
