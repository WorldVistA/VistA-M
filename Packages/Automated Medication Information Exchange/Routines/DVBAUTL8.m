DVBAUTL8 ;ALB/GTS-AMIE 7131 UTILITIES ;8 DEC 94
 ;;2.7;AMIE;**5**;Apr 10, 1995
 ;
NEWCHK ;** Check for the addition of a report to 7131
 ;**  This tag is called from DIVUPDT^DVBAUTL2.  It checks for a new
 ;**   report division and sets up the DR string if the reports Division
 ;**   and Transfer Date fields need to be updated.  NEWCHK is called if
 ;**   the report array status piece has a status of 'P' (Pending)
 ;
 I $D(DVBANEW) D SETDR^DVBAUTL7 ;**New 7131 - update Div/Tran Dte flds
 I '$D(DVBANEW) DO  ;**Edit 7131 - If report added, update Div/Tran Dte
 .I LPPCE=1,($P(NODE6,U,9)="") D SETDR^DVBAUTL7
 .I LPPCE=2,($P(NODE6,U,11)="") D SETDR^DVBAUTL7
 .I LPPCE=3,($P(NODE6,U,13)="") D SETDR^DVBAUTL7
 .I LPPCE=4,($P(NODE6,U,15)="") D SETDR^DVBAUTL7
 .I LPPCE=5,($P(NODE6,U,17)="") D SETDR^DVBAUTL7
 .I LPPCE=6,($P(NODE6,U,19)="") D SETDR^DVBAUTL7
 .I LPPCE=7,($P(NODE6,U,21)="") D SETDR^DVBAUTL7
 .I LPPCE=8,($P(NODE6,U,23)="") D SETDR^DVBAUTL7
 .I LPPCE=9,($P(NODE6,U,7)="") D SETDR^DVBAUTL7
 .I LPPCE=10,($P(NODE6,U,28)="") D SETDR^DVBAUTL7
 Q
 ;
CLRCHK ;** Edit 7131 - Check for deselection of report
 ;**  This tag is called from DIVUPDT^DVBAUTL2.  It checks for the
 ;**   deselection of a report on a previously entered 7131.  If a
 ;**   report has been deselected, the Division and Tran Date fields
 ;**   are cleared.
 ;
 I '$D(DVBANEW) DO
 .I LPPCE=1,($P(NODE6,U,9)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=2,($P(NODE6,U,11)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=3,($P(NODE6,U,13)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=4,($P(NODE6,U,15)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=5,($P(NODE6,U,17)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=6,($P(NODE6,U,19)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=7,($P(NODE6,U,21)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=8,($P(NODE6,U,23)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=9,($P(NODE6,U,7)'="") D CLEARDR^DVBAUTL7
 .I LPPCE=10,($P(NODE6,U,28)'="") D CLEARDR^DVBAUTL7
 Q
 ;
ASIHALRT ;**Warn user of ASIH admission
 S VAR(1,0)="1,0,0,2,0^The admission you selected is an ASIH admission."
 S VAR(2,0)="0,0,0,1,0^This means the veteran was admitted from a Nursing"
 S VAR(3,0)="0,0,0,1,0^ Home or Domiciliary.  It is suggested that you"
 S VAR(4,0)="0,0,0,1,0^ review the veteran's claim folder before requesting"
 S VAR(5,0)="0,0,0,1:1,0^ a 7131."
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
