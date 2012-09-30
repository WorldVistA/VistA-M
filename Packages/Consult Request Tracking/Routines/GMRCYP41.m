GMRCYP41 ;SLC/JFR - PRE/POST INSTALL FOR GMRC*3*41; 2/4/05 13:29
 ;;3.0;CONSULT/REQUEST TRACKING;**41**;DEC 27, 1997
 ;
 ; This routine invokes one-time IA #4605
 ;
 Q
PRE ; pre-install
 ; This pre-install will delete the "AE", "AE1" and "AE2" MUMPS
 ; cross-references on the REQUEST/CONSULTATION (#123) file
 ; and replace them with a new-style index "AE" during the install
 ; that will have the same format as the prior "AE" cross-reference.
 ; This will insure greater reliability in the setting and
 ; killing of the "AE" cross-reference.
 ;
 N GMRCAE,GMRCAE1,GMRCAE2,IDX
 S (GMRCAE,GMRCAE1,GMRCAE2)=0
 K ^GMR(123,"AE") ; kill off all existing data
 S IDX=0
 F  S IDX=$O(^DD(123,1,1,IDX)) Q:'IDX  D
 . Q:$P($G(^DD(123,1,1,IDX,0)),U,2)'="AE"
 . S GMRCAE=IDX
 . D DELIX^DDMOD(123,1,GMRCAE)
 . S IDX=" " ;quit the loop
 . Q
 S IDX=0
 F  S IDX=$O(^DD(123,3,1,IDX)) Q:'IDX  D
 . Q:$P($G(^DD(123,3,1,IDX,0)),U,2)'="AE1"
 . S GMRCAE1=IDX
 . D DELIX^DDMOD(123,3,GMRCAE1)
 . S IDX=" " ; quit the loop
 . Q
 S IDX=0
 F  S IDX=$O(^DD(123,8,1,IDX)) Q:'IDX  D
 . Q:$P($G(^DD(123,8,1,IDX,0)),U,2)'="AE2"
 . S GMRCAE2=IDX
 . D DELIX^DDMOD(123,8,GMRCAE2)
 . S IDX=" " ; quit the loop
 . Q
 Q
 ;
POST ; post-install to create and build new "AE" index
 N GMRCXR,GMRCRES,GMRCOUT
 S GMRCXR("FILE")=123
 S GMRCXR("NAME")="AE"
 S GMRCXR("TYPE")="R"
 S GMRCXR("USE")="S"
 S GMRCXR("EXECUTION")="R"
 S GMRCXR("ACTIVITY")="IR"
 S GMRCXR("SHORT DESCR")="Index by SERVICE, STATUS, DATE OF REQUEST"
 S GMRCXR("DESCR",1)="This cross reference is used for services to see all consults by service,"
 S GMRCXR("DESCR",2)="OE/RR status and Date of Request."
 S GMRCXR("VAL",1)=1
 S GMRCXR("VAL",1,"SUBSCRIPT")=1
 S GMRCXR("VAL",1,"LENGTH")=5
 S GMRCXR("VAL",1,"COLLATION")="F"
 S GMRCXR("VAL",2)=8
 S GMRCXR("VAL",2,"SUBSCRIPT")=2
 S GMRCXR("VAL",2,"LENGTH")=5
 S GMRCXR("VAL",2,"COLLATION")="F"
 S GMRCXR("VAL",3)=3
 S GMRCXR("VAL",3,"SUBSCRIPT")=3
 S GMRCXR("VAL",3,"LENGTH")=20
 S GMRCXR("VAL",3,"COLLATION")="F"
 S GMRCXR("VAL",3,"XFORM FOR STORAGE")="S X=9999999-X"
 D CREIXN^DDMOD(.GMRCXR,"S",.GMRCRES,"GMRCOUT")
 Q
