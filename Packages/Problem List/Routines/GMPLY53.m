GMPLY53 ;ISP/TC - Post Install Routine for GMPL*2.0*53;08/27/2020
 ;;2.0;Problem List;**53**;Aug 25, 1994;Build 159
 ;
POST ; Post-install subroutine
 D BMES^XPDUTL("  Scanning Problem Selection lists for problems with inactive codes...")
 D CSVPEP^GMPLBLCK
 ;Remove the incorrect Provider Narrative screen.
 ;ICR #6256
 K ^DD(9000011,.05,12)
 K ^DD(9000011,.05,12.1)
 Q
 ;
