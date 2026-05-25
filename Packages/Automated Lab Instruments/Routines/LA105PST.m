LA105PST ;NMG/HDSO - POST-INSTALL ROUTINE; Dec 13, 2024@12:16
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**105**;Sep 27, 1994;Build 2
 ;
 Q
 ;
EN ;
 N FDA
 S FDA(62.485,110_",",1)="Msg #|1|, No valid provider (|2|) found for order."
 D FILE^DIE(,"FDA","")
 S FDA(62.485,110_",",2)="S LA7TXT(1)=$G(LA76249),LA7TXT(2)=$S('$G(LRXPRAC):""None"",1:LRXPRAC_""^""_$$NAME^XUSER(LRXPRAC,""F""))"
 D FILE^DIE(,"FDA","")
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post-install has modified error 110 in file 62.485. ***",80))
 Q
 ;
