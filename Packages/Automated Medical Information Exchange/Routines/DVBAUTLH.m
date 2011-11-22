DVBAUTLH ;ALB/JLU;executable help statements;10/28/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;this routine contains the executable help statements for the AMIE
 ;fields when needed.
PURGE ;
 N DVBAH
 S DVBAH(1,0)="0,0,0,1,0^This parameter can be adjusted to allow the site to keep 2507 requests"
 S DVBAH(2,0)="0,0,0,1,0^for up to 999 days.  The site can not select to retain the requests"
 S DVBAH(3,0)="0,0,0,1,0^for less than 120 days.  Selection of a number of days between"
 S DVBAH(4,0)="0,0,0,1:2,0^120 and 999 is the allowable response."
 D WR^DVBAUTL4("DVBAH")
 Q
