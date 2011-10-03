GMRCDDX ;SLC/DLT - AC cross-referenc logic for 123.5, field .01 ;11/3/97 11:21 
 ;;3.0;CONSULT/REQUEST TRACKING;**1,6**;DEC 27, 1997
SETAC ;Logic to set the heirarchy alphabetic cross reference on the menu item
 ;multiple based on the child-parent relationships in file 123.5
 ;The ACP cross-reference is used to find cross-reference entries that
 ;need to have the AC alphabetic cross-reference updated.
 ;The value in X will be used to create a new AC cross-reference.
 ; GMRCC=Child Service ien
 ; GMRCP=Parent Service ien
 ; GMRCE=Entry in Parent Sub-service multiple
 ;
 N GMRCC,GMRCP,GMRCE
 S GMRCC=DA,GMRCP=0
 F  S GMRCP=$O(^GMR(123.5,"APC",GMRCC,GMRCP)) Q:'GMRCP  D
 . S GMRCE=$O(^GMR(123.5,"APC",GMRCC,GMRCP,0)) Q:'GMRCE
 . S ^GMR(123.5,GMRCP,10,"AC",$E(X,1,63),GMRCE)=""
 . Q
 Q
KILLAC ;Logic to kill the AC cross-reference entry with the name defined in
 ;the value of x.
 N GMRCC,GMRCP,GMRCE
 S GMRCC=DA,GMRCP=0
 F  S GMRCP=$O(^GMR(123.5,"APC",GMRCC,GMRCP)) Q:'GMRCP  D
 . S GMRCE=$O(^GMR(123.5,"APC",GMRCC,GMRCP,0)) Q:'GMRCE
 . K ^GMR(123.5,GMRCP,10,"AC",$E(X,1,63),GMRCE)
 . Q
 Q
