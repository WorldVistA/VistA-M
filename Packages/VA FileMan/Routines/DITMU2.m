DITMU2 ;SFISC/EDE(OHPRD)-RETURN SUBFILE GLOBAL REFERENCE ;2015-01-03  10:14 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; Given a subfile number and global reference form, this routine
 ; will return the global reference for a subfile in the form
 ; specified.
 ;
 ; FORM is optional but if passed should equal 1 or 2.  If FORM is
 ; not passed the default form will be 1.
 ;
 ;     FORM = 1 will be in the form ^GBL(DA(2),11,DA(1),11,DA,
 ;     FORM = 2 will be in the form ^GBL(D0,11,D1,11,D2,
 ;
 ; Formal list:
 ;
 ; 1) SUBFILE = subfile number (call by value)
 ; 2) GBL     = global reference (call by reference)
 ; 3) FORM    = global reference form (call by value)
 ;
 ; *** NO ERROR CHECKING DONE ***
 ;
EN(SUBFILE,GBL,FORM) ;
START ;
 NEW FIELD,I,LVL,NODE,PARENT
 S GBL="",LVL=1
 D BACKUP
 S GBL=^DIC(PARENT,0,"GL")
 I $G(FORM)=2 D  S GBL=GBL_"D"_(I+1)_"," I 1
 . F I=0:1 S GBL=GBL_"D"_I_","_NODE(99-LVL)_",",LVL=LVL-1 Q:LVL=0
 . Q
 E  D  S GBL=GBL_"DA,"
 . F LVL=LVL:-1:0 Q:LVL=0  S GBL=GBL_"DA("_LVL_"),"_NODE(99-LVL)_","
 . Q
 Q
 ;
BACKUP ; BACKUP TREE (CALLED RECURSIVELY)
 S PARENT=^DD(SUBFILE,0,"UP")
 S FIELD=$O(^DD(PARENT,"SB",SUBFILE,""))
 S NODE(99-LVL)=$P($P(^DD(PARENT,FIELD,0),"^",4),";",1) S:NODE(99-LVL)'=+NODE(99-LVL) NODE(99-LVL)=""""_NODE(99-LVL)_""""
 I $D(^DD(PARENT,0,"UP")) S SUBFILE=PARENT,LVL=LVL+1 D BACKUP ; Recurse
 Q
