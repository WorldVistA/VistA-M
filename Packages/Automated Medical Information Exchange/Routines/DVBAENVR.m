DVBAENVR ;ALB/JLU;environment check routine.;10/17/94
 ;;2.7;AMIE;;Apr 10, 1995
EN ;the main entry point of the enviroment check routine.
 N VAR,DVBA
 S VAR(1,0)="0,0,0,2,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 I '$D(DUZ)#2 DO  Q
 .S VAR(1,0)="1,0,0,1:2,0^DUZ must be set to a valid user to run this init."
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 I '$D(DUZ(0)) DO  Q
 .S VAR(1,0)="1,0,0,1:2,0^DUZ(0) must be defined"
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 I DUZ(0)'="@" DO  Q
 .S VAR(1,0)="1,0,0,1:2,0^DUZ(0) must be equal to '@'"
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
EN1 ;around the normal DUZ checks
 ;FM CHECK
 S DVBA=$$VERSION^XPDUTL("VA FILEMAN")
 I +DVBA<20 DO  Q
 .S VAR(1,0)="1,0,0,1,0^Your site seems to be running a version of FileMan that is less than 20."
 .S VAR(2,0)="0,0,0,1:2,0^Please investigate the version of FileMan."
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 ;KERNEL CHECK
 S DVBA=$$VERSION^XPDUTL("XU")
 I +DVBA<7.1 DO  Q
 .S VAR(1,0)="1,0,0,1,0^Your site seems to be running a version of Kernel that is less than 7.1"
 .S VAR(2,0)="0,0,0,1:2,0^Please investigate the version of Kernel."
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 ;MAILMAN CHECK
 S DVBA=$$VERSION^XPDUTL("XM")
 I +DVBA<7.1 DO  Q
 .S VAR(1,0)="1,0,0,1,0^Your site seems to be running a version of MailMan that is less than 7.1"
 .S VAR(2,0)="0,0,0,1:2,0^Please investigate the version of MailMan."
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 ;KERNEL TOOL KIT
 S DVBA=$$VERSION^XPDUTL("XT")
 I +DVBA<7.2 DO  Q
 .S VAR(1,0)="1,0,0,1,0^Your site seems to be running a version of Kernel Tool Kit less than 7.2."
 .S VAR(2,0)="0,0,0,1:2,0^Please investigate the version of Kernel Tool Kit."
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 ;LAB
 S DVBA=$$VERSION^XPDUTL("LR")
 I +DVBA<5.0 DO  Q
 .S VAR(1,0)="1,0,0,1,0^Your site seems to be running a version of LAB. less than 5.0."
 .S VAR(2,0)="0,0,0,1:2,0^Please investigate the version of LAB."
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 ;PIMS CHECK
 S DVBA=$$VERSION^XPDUTL("REGISTRATION")
 I +DVBA<5.3 DO  Q
 .S VAR(1,0)="1,0,0,1,0^Your site seems to be running a version of PIMS less than 5.3."
 .S VAR(2,0)="0,0,0,1:2,0^Please investigate the version of PIMS."
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 ;HINQ check
 S DVBA=$$VERSION^XPDUTL("HINQ")
 I +DVBA<4.0 DO  Q
 .S VAR(1,0)="1,0,0,1,0^Your site seems to be running a version of HINQ less than 4.0."
 .S VAR(2,0)="0,0,0,1:2,0^Please investigate the version of HINQ."
 .D WR^DVBAUTL4("VAR")
 .K VAR,DIFQ
 .Q
 ;
 S VAR(1,0)="0,0,0,2,0^Environment check completed OK!"
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
