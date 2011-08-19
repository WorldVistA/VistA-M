GMRACMR2 ;HIRMFO/WAA-This routine will find all valid patient ;12/16/97  10:34
 ;;4.0;Adverse Reaction Tracking;**9**;Mar 29, 1996
EN1 ;Use ACRP APIs to gather appointment data
 Q:GMRASEL'["2"
 N GMTSQRY
 D OPEN^SDQ(.GMTSQRY)
 D INDEX^SDQ(.GMTSQRY,"DATE/TIME","SET")
 D DATE^SDQ(.GMTSQRY,GMRAST,GMRAED,"SET")
 D SCANCB^SDQ(.GMTSQRY,"D CB^GMRACMR2(Y,Y0)","SET")
 D ACTIVE^SDQ(.GMTSQRY,"TRUE","SET")
 D SCAN^SDQ(.GMTSQRY,"FORWARD")
 D CLOSE^SDQ(.GMTSQRY)
 K GMRAX,GMRADFN,GMRADATE
 Q
CB(GMTS,GMTS0) ;Callback execution, handles each entry from data set
 I $P(GMTS0,U,12)'=2&($P(GMTS0,U,12)'=8) Q  ;Only count inpatient and checked-out appts
 S GMRAX=$P(GMTS0,U,4),GMRADFN=$P(GMTS0,U,2),GMRADATE=$P(GMTS0,U) D SETPT^GMRACMR3
 Q
