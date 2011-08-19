NURAAU5 ;HIRMFO/FT-Check if every MAS Ward has a Nursing Location ;1/7/97  11:41
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
 ;
EN1 ; called from NURAAU0 - the Nursing Acuity option
 ; sends a mail message to G.NURS-ADP group if MAS Ward does not have
 ; a corresponding Nursing Location.
 K NURSTEXT
 S NURSTEXT(1)="The following MAS Wards do not have corresponding NURSING Locations."
 S NURSTEXT(2)="Use the 'Nursing Location File, Edit' option to correct this problem."
 S NURSTEXT(3)=" "
 S NURSLINE=3
 F NURSY=0:0 S NURSY=$O(^DIC(42,NURSY)) Q:NURSY'>0  S X=$P(^DIC(42,NURSY,0),"^",1) D MATCHUP
 I NURSLINE>3 D MAIL
 K NURSBAD,NURSLINE,NURSTEXT,NURSX,NURSY,NURSZLOC
 K X,XMDUZ,XMSUB,XMTEXT,XMY
 Q
MATCHUP ; matchup MAS Wards and Nursing Locations
 S NURSX=$O(^DIC(42,"B",X,"")),NURSBAD=1 I NURSX'="" F NURSZLOC=0:0 S NURSZLOC=$O(^NURSF(211.4,"C",NURSX,NURSZLOC)) Q:NURSZLOC'>0  I $S('$D(^NURSF(211.4,NURSZLOC,"I")):1,$P(^("I"),"^")="A":1,1:0) S NURSBAD=0
 K NURSX,NURSZLOC
 I NURSBAD S NURSLINE=NURSLINE+1,NURSTEXT(NURSLINE)=X
 Q
MAIL ; send a mail message listing MAS Wards without Nursing Locations to
 ; Nursing mail group
 S XMY("G.NURS-ADP")=""
 S XMDUZ=.5
 S XMTEXT="NURSTEXT("
 S XMSUB="MAS Wards with no Nursing Locations"
 S XMDUN="Nursing Acuity Option"
 D ^XMD
 Q
