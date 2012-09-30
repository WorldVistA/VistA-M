DIPR41 ;SFISC/SO- PRE INSTALL ROUTINE FOR PATCH DI*22.0*41 ;6/20/00  14:05
 ;;22.0;VA FileMan;**41**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Add two new entries to LANGUAGE file, 12 GREEK, 18 HEBREW
 ;
EN N DIIFDA,DIIEN
 I '$D(^DI(.85,12,0)) D
 . S DIIFDA(.85,"+1,",.01)=12,DIIFDA(.85,"+1,",1)="GREEK"
 . S DIIEN(1)=12
 . D UPDATE^DIE("","DIIFDA","DIIEN") Q
 I '$D(^DI(.85,18,0)) D
 . S DIIFDA(.85,"+1,",.01)=18,DIIFDA(.85,"+1,",1)="HEBREW"
 . S DIIEN(1)=18
 . D UPDATE^DIE("","DIIFDA","DIIEN") Q
 Q
