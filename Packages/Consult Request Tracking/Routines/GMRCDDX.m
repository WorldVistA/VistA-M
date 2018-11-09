GMRCDDX ;SLC/DLT - AC cross-referenc logic for 123.5, field .01 ; 8/20/18 4:54pm
 ;;3.0;CONSULT/REQUEST TRACKING;**1,6,104**;DEC 27, 1997;Build 9
 ;
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
CHKDEL(DA) ;Logic to check if user can delete entries from file 123.5.
 ;1. Check to ensure the SUICIDE HOTLINE entry is never deleted.
 ;2. If we have an APC cross reference we will force the user to
 ;   remove the child-parent relationship before deleting the parent.
 ;
 ;Varibles used:
 ; GMRCC=Child Service ien
 ; GMRCP=Parent Service ien
 ; GMRCE=Entry in Parent Sub-service multiple
 ; GMRCNC=Noded count for user message
 ; GMRCMSG=User message
 ; GMRCNAME=Name of Parent Service
 ;
 ;ICRs used:
 ; IA# 10142 EN^DDIOL
 ;
 N GMRCC,GMRCP,GMRCE,GMRCNC,GMRCMSG,GMRCNAME
 S GMRCC=DA,GMRCP=0,GMRCNC=1,(GMRCMSG,GMRCNAME)=""
 I $P(^GMR(123.5,GMRCC,0),U)="SUICIDE HOTLINE" Q "...Mandatory Entry.  Please see GMRC*3.0*57 for details..."
 I $D(^GMR(123.5,"APC",GMRCC)) D  Q " "
 . S GMRCMSG(1)="This entry cannot be deleted until it is removed as a sub-service of:"
 . F  S GMRCP=$O(^GMR(123.5,"APC",GMRCC,GMRCP)) D  Q:'+GMRCP
 .. I '+GMRCP Q
 .. S GMRCNC=GMRCNC+1
 .. S GMRCNAME=$P(^GMR(123.5,GMRCP,0),U)
 .. S GMRCMSG(GMRCNC)=GMRCNAME
 .. S GMRCMSG(GMRCNC,"F")="!?5"
 . D EN^DDIOL(.GMRCMSG)
 Q ""
