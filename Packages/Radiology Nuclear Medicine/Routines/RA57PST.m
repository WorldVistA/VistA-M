RA57PST ;HIOFO/SWM-Post install ;12/20/04 12:55am
 ;;5.0;Radiology/Nuclear Medicine;**57**;Mar 16, 1998
 ; This is the post-install routine for patch RA*5.0*57
 ; It will loop thru file 79.2 and insert appropriate Dept Code
 ;
 ; This routine may be deleted after RA*5.0*57 is installed.
 ;
 ; Variable initialization.
 N RA1,RA2,RAFDA,RATXT,RAVAL,RAX
 S RATXT(1)=""
 S RATXT(2)="** File 79.2 IMAGING TYPE has been updated with Dept. Code for the PFSS project. **"
 S RA1=0
 ; Traverse the IMAGING TYPE FILE
 F  S RA1=$O(^RA(79.2,RA1)) Q:'RA1  I $D(^(RA1,0)) D
 . ; Gather the data from the zero node and extract the first 3 characters of the .01 (NAME) field.
 . S RA2=^RA(79.2,RA1,0),RAX=$E(RA2,1,3)
 . ; Inspect the extracted characters and assign a code number associated with that string.
 . S RAVAL=$S(RAX="GEN":"105",RAX="NUC":"109",RAX="ULT":"115",RAX="MAG":"151",RAX="CT ":"150",RAX="ANG":"152",RAX="CAR":"109",RAX="VAS":"421",RAX="MAM":"703",1:"")
 . S RAFDA(79.2,RA1_",",90)=RAVAL ; Dept Code is in field #90.
 . D FILE^DIE("K","RAFDA") ; Use filemans function to populate the field.
 . ; If there is an error returned set up special error text.
 . I $D(RAMSG) S RATXT(2)="** Error in updating file 79.2 IMAGING TYPE with Dept. Code for the PFSS project. **"
 . ; End of task loop
 . Q
 ; Display any message returned from the filing activity.
 D MES^XPDUTL(.RATXT)
 Q
