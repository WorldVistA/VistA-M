DVBANT21 ;ALB/JLU;pending 21 day certificate;9/15/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN ;the main entry point
 D HDR
 S DVBTYPE=$$TYPE()
 I DVBTYPE'=1 DO
 .I DVBTYPE="B" D BOTH
 .I DVBTYPE="N" D NOTICE
 .I DVBTYPE="C" D CERTIF
 .S L=0,DIC="^DVB(396,",(FR,TO)=""
 .D EN1^DIP
 .K L,DIC,FR,TO,BY,FLDS
 .Q
 D KILL
 Q
 ;
KILL K DVBTYPE,DUOUT,DTOUT
 Q
 ;
HDR ;issues an initial form feed
 S VAR(1,0)="0,0,0,0,1^"
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
TYPE() ;gets from the user what type of report they are interested in.
 N DVBOUT
 S DIR(0)="SM^N:Notice of Discharge;C:21 Day Certificate;B:Both"
 S DIR("A")="Select the desired report"
 D ^DIR
 K DIR
 I $D(DUOUT)!($D(DTOUT)) S DVBOUT=1
 I Y="" S DVBOUT=1
 I "NCB"[Y S DVBOUT=Y
 E  S DVBOUT=1
 Q DVBOUT
 ;
NOTICE ;sets up the templates for the notice of discharge reports.
 S (FLDS,BY)="[DVBA NOTICE OF DISCHARGE]"
 Q
 ;
BOTH ;sets up the templates for both the notice of discharge and 21 day cert
 S (FLDS,BY)="[DVBA NOT/DIS-21 DAY CERT CHECK]"
 Q
 ;
CERTIF ;sets up the templates for the 21 day certificate
 S (FLDS,BY)="[DVBA 21 DAY CERT]"
 Q
