LEX2102P ;SLC/PKR - LEX*2.0*102 Pre/Post Install ;08/18/2015
 ;;2.0;LEXICON UTILITY;**102**;Sep 23, 1996;Build 20
 Q
 ;
PRE ; Pre-Install
 ;If the DD exists remove it and the data.
 I $$VFILE^DILFD(757.5)=0 Q
 D MES^XPDUTL("Deleting #757.5 data dictionary and data.")
 N DIU
 S DIU=757.5,DIU(0)="D"
 D EN^DIU2
 Q
 ;
