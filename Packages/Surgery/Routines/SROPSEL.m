SROPSEL ;B'HAM ISC/MAM - SELECT CASE ; [ 01/10/04  2:22 PM ]
 ;;3.0; Surgery ;**121,125**;24 Jun 93
 D ID Q:SRSOUT=1
 S DFN=+Y D DEM^VADPT
 Q
ID S SRNOPE=0,SRSEL=1 K DIR
 S DIR("?",1)="     To lookup by patient, enter patient name or patient ID.  To lookup by"
 S DIR("?",2)="     surgical case/assessment number, enter the number preceded by ""#"","
 S DIR("?")="     e.g., for case 12345 enter ""#12345"" (no spaces)."
 S DIR("A")="Select Patient: ",DIR(0)="FOA" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S SRSOUT=1 Q
 I $E(X)="#" S Y=$E(X,2,$L(X)),SRSEL=2 D  G:SRNOPE ID Q
 .I 'Y S SRSOUT=1 Q
 .S SROP=Y,Y=$G(^SRF(Y,0)) I '+Y W !!," "_SROP_" is an invalid entry. Please try again." W ! S SRNOPE=1 Q
 K DIC S X=Y,DIC=2,DIC(0)="QEM" D ^DIC K DIC
 G:Y<0 ID I $D(DUOUT)!$D(DIRUT) S SRSOUT=1
 Q
