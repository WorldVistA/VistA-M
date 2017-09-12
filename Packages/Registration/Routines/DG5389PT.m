DG5389PT ;ALB/CM POSTINIT ;04/26/96
 ;;5.3;Registration;**89**;Aug 13, 1993
 ;
 ;This routine will convert the current WARD field entries to be a
 ;variable pointer entry.
 ;
EN ;
 N MES,ENTRY,X
 S ENTRY=0
 D MES^XPDUTL("Starting Post Init Conversion")
 F  S ENTRY=$O(^DG(45.9,ENTRY)) Q:(ENTRY'?.N)!(ENTRY="")  D
 . S X=$P($G(^DG(45.9,ENTRY,"R")),"^")
 . Q:+X=0  ; no pointer value
 . I $P(X,";",2)="" S $P(^DG(45.9,ENTRY,"R"),"^")=+X_";DIC(42,"
 D MES^XPDUTL("Completed Post Init Conversion")
 Q
