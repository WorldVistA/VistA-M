XVEMSG ;DJB/VSHL**Global Loader ;2017-08-16  12:06 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Heavily refactored by David Wicksell and then Sam Habiel to remove all
 ;  references to code in globals.
 ; (c) David Wicksell 2010-2011
 ; (c) Sam Habiel 2010,2016
 ;
 Q
ALL ;Load entire ^XVEMS global
 NEW I,RTN,TAG,TXT
 D INIT
 D SY
 ;
 ;Build System QWIKs
 D ^XVEMSGS
 D ^XVEMSGT
 D ^XVEMSGU
 ;
 ;Load ZOSF nodes
 ;D ^XVEMSGR
 ;
 ;Load Help and other text
 D TEXT^XVEMSGH
 Q
 ;
 ;
 ;
SY ;Use to guarantee unique subscript - $J_$G(^XVEMS("SY"))
 ;Necessary because not all systems support $SY.
 S ^XVEMS("SY")=""
 ;Set error trap to test if vendor supports $SY
 D  ;
 . N $ESTACK,$ETRAP S $ETRAP="S $EC="""""
 . I $SY]"" S ^XVEMS("SY")="-"_$SY
 Q
 ;
INIT ;
 S U="^"
 S ^XVEMS("%")="Scratch area"
 S ^XVEMS("CLH")="Command line history"
 S ^XVEMS("ID")="User IDs"
 S ^XVEMS("PARAM")="Shell parameters"
 Q
 ;
ERROR ;
 Q
