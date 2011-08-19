DITMU2(SUBFILE,GBL,FORM) ;SFISC/EDE(OHPRD)-RETURN SUBFILE GLOBAL REFERENCE ;
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
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
