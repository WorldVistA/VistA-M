GMPLY42 ;ISL/TC - Post-install for GMPL*2.0*42 ;05/21/14  07:26
 ;;2.0;Problem List;**42**;Aug 25,1994;Build 46
 ;
PRE ; Pre-install subroutine
 ;Remove the old data dictionary for the PROBLEM File (#9000011)
 N DIU
 D BMES^XPDUTL(" Removing old Problem File data dictionary.")
 S DIU(0)=""
 S DIU=9000011
 D EN^DIU2
 D MES^XPDUTL(" Data dictionary for file #9000011 removed...")
 Q
POST ; Post-install subroutine
 N GMPLTXT,I,GMPLOPT
 S GMPLTXT="This option has been disabled due to the Problem List SNOMED CT implementation."
 F I=1:1:4  D
 . S GMPLOPT=$S(I=1:"GMPL BUILD ENC FORM LIST",I=2:"GMPL USER LOOK-UP FILTER",I=3:"GMPL USER LOOK-UP DISPLAY",1:"GMPL USER LOOK-UP VOCABULARY")
 . D BMES^XPDUTL(" Disabling menu option "_GMPLOPT_".")
 . D OUT^XPDMENU(GMPLOPT,GMPLTXT)
 . Q
 Q
