XVEMRUS ;DJB/VRR**Rtn Selector ;2019-08-09  4:25 PM
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Mumps V1 routine selection (tag 20) Sam Habiel (c) 2017
 ; GT.M/YottaDB routine selection (tag 19) David Wicksell (c) 2019
 ;
SELECT ;
 NEW FLAGQ,QUIT
 KILL ^UTILITY($J)
 I $D(XVSIMERR) S $EC=",U-SIM-ERROR,"
 S FLAGQ=0
 D INIT G:FLAGQ EX
 D @$S($D(^%ZOSF("RSEL")):"ZOSF",1:XVV("OS"))
EX ;
 Q
ZOSF ;Use ^%ZOSF("RSEL")
 NEW %,X
 X ^%ZOSF("RSEL")
 Q
2 ;Rtn Select for DSM Mumps
 D ^%RSEL
 Q
8 ;Rtn Select for MSM Mumps
 D INT^%RSEL
 Q
9 ;Rtn Select for DataTree Mumps
 NEW RTN
 KILL ^%RSET($J)
 W $$^%rselect
 I $O(^%RSET($J,""))="" Q
 S RTN=""
 F  S RTN=$O(^%RSET($J,RTN)) Q:RTN=""  S ^UTILITY($J,RTN)=""
 KILL ^%RSET($J)
 Q
16 ;Rtn Select for VAX DSM Mumps
 NEW %UTILITY
 D ^%RSEL Q:$O(%UTILITY(""))=""
 S RTN=""
 F  S RTN=$O(%UTILITY(RTN)) Q:RTN=""  S ^UTILITY($J,RTN)=""
 Q
18 ;Rtn Select for OpenM
 KILL ^UTILITY($J)
 I $L($T(KERNEL^%RSET)) D KERNEL^%RSET KILL %ST Q  ;VA Kernel rtn
 NEW %JO,%UR,%R
 S %JO=$J,%UR="^ROUTINE",%R=0 D ROU^%RSET
 Q
19 ;Rtn Select for YottaDB/GT.M
 K ^UTILITY($J)
 D ^%RSEL
 S X="" F  S X=$O(%ZR(X)) Q:X=""  S ^UTILITY($J,X)=""
 K %ZR
 Q
20 ;Rtn Select for MV1
 KILL ^UTILITY($J)
 D ^%ZRSEL
 M ^UTILITY($J)=^%UTILITY($J,"ROUTINE")
 K ^%UTILITY($J)
 QUIT
INIT ;
 I '$D(^%ZOSF("RSEL")),$G(XVV("OS"))="" D OS^XVEMKY
 Q
