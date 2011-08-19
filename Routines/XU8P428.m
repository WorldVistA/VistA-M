XU8P428 ;SFISC/SO- ADD 'UNKNOWN' TO STATE FILE;8:01 AM  17 Aug 2006
 ;;8.0;KERNEL;**428**;Jul 10, 1995;Build 4
 N XUMF S XUMF=1
 N IEN S IEN=0
 N ADD S ADD=1 ;1=Add 'UNKNOWN' to State File
 F  S IEN=$O(^DIC(5,IEN)) Q:'IEN  I $D(^DIC(5,IEN,0))#2 D
 . N X S X=^(0) ;See For loop line above
 . I $P(X,U,1)="UNKNOWN" D SEDIT S ADD=0 Q  ;Found State Name UNKNOWN
 . I $P(X,U,2)="UN" D SEDIT S ADD=0 Q  ;Found Abbreviation UN
 . I $P(X,U,3)=99 D SEDIT S ADD=0 Q  ;Found State Code 99
 . Q
 I 'ADD D COUNTY Q
ADD ; Add 'OTHER'
 N DIERR,FDA,ZERR
 S FDA(5,"+1,",.01)="UNKNOWN"
 S FDA(5,"+1,",1)="UN"
 S FDA(5,"+1,",2)=99
 S FDA(5,"+1,",2.1)="YES"
 S FDA(5,"+1,",2.2)="No"
 D UPDATE^DIE("E","FDA","","ZERR")
 D COUNTY
 Q
 ;
SEDIT ; Edit found State entry
 N DIERR,FDA,IENS,ZERR
 S IENS=IEN_","
 S FDA(5,IENS,.01)="UNKNOWN"
 S FDA(5,IENS,1)="UN"
 S FDA(5,IENS,2)=99
 S FDA(5,IENS,2.1)="YES"
 S FDA(5,IENS,2.2)="No"
 D FILE^DIE("E","FDA","ZERR")
 Q
 ;
COUNTY ;Edit County multiple and add to Country Code file
 N IEN S IEN=$O(^DIC(5,"B","UNKNOWN",0))
 N IENC S IENC=0
 S ADD=1 ;1=Add 'OTHER' to County multiple
 F  S IENC=$O(^DIC(5,IEN,1,IENC)) Q:'IENC  I $D(^DIC(5,IEN,1,IENC,0))#2 D
 . N X S X=^(0) ;See For loop line above
 . I $P(X,U,1)="OTHER" D CEDIT S ADD=0 Q  ;Found County Name OTHER
 . I $P(X,U,3)=999 D CEDIT S ADD=0 Q  ;Found County Code 999
 . ;Inactivate county
 . N DIERR,FDA,ZERR
 . S FDA(5.01,IENC_","_IEN_",",5)=$G(DT)
 . D FILE^DIE("","FDA","ZERR")
 . Q
 I 'ADD D E513 Q
 N DIERR,FDA,ZERR
 S FDA(5.01,"+1,"_IEN_",",.01)="OTHER"
 S FDA(5.01,"+1,"_IEN_",",2)=999
 D UPDATE^DIE("E","FDA","ZERR")
 D E513
 Q
 ;
CEDIT ;Edit County multiple
 N DIERR,FDA,ZERR
 S FDA(5.01,IENC_","_IEN_",",.01)="OTHER"
 S FDA(5.01,IENC_","_IEN_",",2)=99
 D FILE^DIE("E","FDA","ZERR")
 Q
 ;
E513 ; Add OTHER to file 5.13
 N DIERR,FDA,ZERR
 S FDA(5.13,"?+1,",.01)=99999
 S FDA(5.13,"?+1,",1)="OTHER"
 S FDA(5.13,"?+1,",2)="UNKNOWN"
 D UPDATE^DIE("E","FDA","ZERR")
 Q
