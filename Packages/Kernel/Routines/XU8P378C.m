XU8P378C ;OOIFO/SO- SET DD CHANGES FOR FILES 5, 5.12, & 5.13 ;6:21 AM  16 Nov 2005
 ;;8.0;KERNEL;**378**;Jul 10, 1995;Build 59
 ;
 ; Set DEL & LAYGO nodes for file 5
 S ^DD(5,.01,"DEL",1,0)="D EN^DDIOL(""Deletions are not allowed."","""",""!?5,$C(7)"") I 1"
 S ^DD(5,.01,"LAYGO",1,0)="D:'$G(XUMF) EN^DDIOL(""New State additions are not allowed."","""",""!?5,$C(7)"") I +$G(XUMF)"
 S ^DD(5,.01,"DT")=$G(DT)
 ;
 ; Set DEL & LAYGO nodes for sub-file 5.01
 S ^DD(5.01,.01,"DEL",1,0)="D EN^DDIOL(""Entries can only be Inactivated."","""",""!?5,$C(7)"") I 1"
 S ^DD(5.01,.01,"LAYGO",1,0)="D:'$G(XUMF) EN^DDIOL(""New County additions are not allowed."","""",""!?5,$C(7)"") I +$G(XUMF)"
 S ^DD(5,.01,"DT")=$G(DT)
 ;
 ; Set DEL node for file 5.12
 S ^DD(5.12,.01,"DEL",1,0)="D EN^DDIOL(""Entries can only be Inactivated."","""",""!?5,$C(7)"") I 1"
 S ^DD(5.12,.01,"DT")=$G(DT)
 ;
 ; Set Del & LAYGO nodes for file 5.13
 S ^DD(5.13,.01,"DEL",1,0)="D EN^DDIOL(""Entries can only be Inactivated."","""",""!?5,$C(7)"") I 1"
 S ^DD(5.13,.01,"LAYGO",1,0)="D:'$G(XUMF) EN^DDIOL(""New County Code additions are not allowed."","""",""!?5,$C(7)"") I +$G(XUMF)"
 S ^DD(5.13,.01,"DT")=$G(DT)
 ;
 Q
