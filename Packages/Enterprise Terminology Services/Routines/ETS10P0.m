ETS10P0 ;O-OIFO/FM23 - LOINC ETS*1.0*0 Post install ;01/31/2017
 ;;1.0;Enterprise Terminology Services;;Mar 20, 2017;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ;This will reindex 364.1 for the updated indexes
 ;
 D BMES^XPDUTL(" Post-install for ETS*1.0*0 Starting.")
 ;
 D PRD^DILFD(129.1,"2.52^3150629")   ;Update the Package Revision History with the version and date
 ;
 D BMES^XPDUTL(" Post-install for ETS*1.0*0 Complete.")
 ;
 Q
 ;
