SROQ0 ;BIR/ADM - QUARTERLY REPORT (CONTINUED) ;08/25/2011
 ;;3.0;Surgery;**62,70,77,50,95,123,129,153,174,176**;24 Jun 93;Build 8
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
QTR D CHECK I '$D(X) D HELP
 K SRX,SRY
 Q
CHECK I $L(X)'=6!(X'["-") K X Q
 I $P(X,"-",2)?1N,"1243"'[$P(X,"-",2) K X Q
 I X'?4N1"-"1N K X Q
 S SRX=$P(X,"-") I SRX<1996!(SRX>2030) K X Q
 S SRY=$P(X,"-",2) I "1234"'[SRY K X Q
 S X=SRX_SRY
 Q
HELP K SRHELP S SRHELP(1)="",SRHELP(2)="Answer must be in format: FISCAL YEAR-QUARTER",SRHELP(3)="",SRHELP(4)="NOTE: A hyphen (-) must separate FISCAL YEAR and QUARTER. The FISCAL"
 S SRHELP(5)="      YEAR must be in the range 1996 to 2030. QUARTER must be a",SRHELP(6)="      number (1, 2, 3 or 4).",SRHELP(7)="" D EN^DDIOL(.SRHELP) K SRHELP
 Q
