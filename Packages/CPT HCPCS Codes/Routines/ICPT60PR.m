ICPT60PR ;ALB/ABR - ICPT Pre-init Driver; 3/25/97
 ;;6.0;CPT/HCPCS;;May 19, 1997
 ;
EN ; This routine will delete the DD and data for files #81 thru 81.5
 ;
 D BMES^XPDUTL("Both the data and data dictionary will be deleted for the following files:")
 D MES^XPDUTL("81 - CPT; 81.1 - CPT CATEGORY; 81.2 - CPT COPYRIGHT; and 81.3 - CPT MODIFIER")
 D BMES^XPDUTL("Files 81.4 - CPT MODIFIER CATEGORY and 81.5 - CPT SOURCE will be")
 D MES^XPDUTL("permanently deleted with this release.")
 ;
 D DELDD
 D DEL81
 D BMES^XPDUTL("... File data and DD deletions complete.")
 Q
 ;
DELDD ;  Delete DD'S, data for files 81.1-81.3
 N DIU
 S DIU="^DIC(81.1,",DIU(0)="" D EN^DIU2 K DIU
 D BMES^XPDUTL("File #81.1, CPT CATEGORY, has been deleted")
 S DIU="^DIC(81.2,",DIU(0)="" D EN^DIU2 K DIU
 D MES^XPDUTL("File #81.2, CPT COPYRIGHT has been deleted")
 S DIU="^DIC(81.3,",DIU(0)="" D EN^DIU2 K DIU
 D MES^XPDUTL("File #81.3, CPT MODIFIER has been deleted")
 S DIU="^DIC(81.4,",DIU(0)="" D EN^DIU2 K DIU
 D MES^XPDUTL("File #81.4, CPT MODIFIER CATEGORY has been permanently deleted.")
 S DIU="^DIC(81.5,",DIU(0)="" D EN^DIU2 K DIU
 D MES^XPDUTL("File #81.5, CPT SOURCE has been permanently deleted.")
 Q
 ;
DEL81 ; Delete DD, Data for file 81 - CPT
 N X,ICPTZ,XPDIDTOT
 S XPDIDTOT=14000 ; # of entries in old CPT file
 D BMES^XPDUTL(">>> Deleting data and data dictionary for file #81, CPT...")
 ; delete DD for 81
 S DIU="^ICPT(",DIU(0)="" D EN^DIU2 K DIU
 ; delete data for 81 - leave 0-node to facilitate protection,
 ; global placement
 S X=0 F ICPTZ=1:1 S X=$O(^ICPT(X)) Q:X=""  K ^ICPT(X) I '(ICPTZ#280) D UPDATE^XPDID(ICPTZ)
 Q
 ;
