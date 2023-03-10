FOIAPRD	;Replace the Source in all Reminder Exchange entries with Packer,Reminder at FOIA.
 N IEN,SOURCE
 S IEN=0
 F  S IEN=+$O(^PXD(811.8,IEN)) Q:IEN=0  D
 . S SOURCE="PACKER,REMINDER at FOIA"
 . S $P(^PXD(811.8,IEN,0),U,2)=SOURCE
 . S ^PXD(811.8,IEN,100,7,0)="<USER>PACKER,REMINDER</USER>"
 . S ^PXD(811.8,IEN,100,8,0)="<SITE>FOIA</SITE>"
 . I ^PXD(811.8,IEN,110,1,0)["Source:" S ^PXD(811.8,IEN,110,1,0)="Source:      "_SOURCE
 . I ^PXD(811.8,IEN,110,2,0)["Source:" S ^PXD(811.8,IEN,110,2,0)="Source:      "_SOURCE
 . K ^PXD(811.8,IEN,130)
 Q
 ;
