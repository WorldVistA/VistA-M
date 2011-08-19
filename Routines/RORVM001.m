RORVM001 ;HCIOFO/SG - MAINTENANCE OPTIONS ; 1/23/06 11:39am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** DECODE SSN
DECODSSN ;
 Q:'$$ACCESS^RORDD(798)
 N EXIT,DA,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S EXIT=0
 S DIR(0)="FO^9:13"
 S DIR("A")="Coded SSN"
 S DIR("?")="Enter a coded Social Security Number."
 F  D  Q:EXIT
 . D ^DIR
 . I $G(Y)=""  S EXIT=1  Q
 . S X=$$XOR^RORUTL03(Y)
 . W ?30,"SSN: "_X
 . W:X'?9N.1A " ??"
 ;---
 Q
 ;
 ;***** REBUILDS THE "ACL" CROSS-REFERENCE (USER ACCESS)
 ; OPTION: [RORMNT ACL REINDEX]
RNDXACL ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,X,Y
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you want to reindex the ACL cross-reference"
 D BLD^DIALOG(7980000.007,,,"DIR(""?"")","S")
 D ^DIR
 I $G(Y)  D  W !!,"Done."
 . S X=$$RNDXACL^RORUTL11()
 Q
