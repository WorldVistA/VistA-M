PXRMP4EC ; SLC/PKR - PXRM*2.0*4 environment check. ;03/15/2005
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;===============================================================
ENVCHK ;Perform an environment check. Look for any reminders still using
 ;old-style MRD. Do not install if any are found.
 N NL,TEXT
 D FOMRD(.NL)
 I NL>2 S XPDABORT=1
 I $G(XPDABORT) D
 . S TEXT(1)="Patch PXRM*2*4 cannot be installed because some reminders are still using"
 . S TEXT(2)="the old-style MRD. A message is being sent to the  reminders mailgroup that"
 . S TEXT(3)="lists the reminders still using the old-style MRD. Please replace the old-style"
 . S TEXT(4)="MRD with a function finding."
 . D EN^DDIOL(.TEXT)
 E  D
 . S TEXTI(1)="Environment check passed, ok to install patch PXRM*2*4"
 . D EN^DDIOL(.TEXT)
 Q
 ;
 ;===============================================================
FOMRD(NL) ;Flag all definitions using the old-style MRD.
 N CPCL,IEN,NAME,XMSUB
 K ^TMP("PXRMXMZ",$J)
 S XMSUB="Old-style MRD obsolete"
 S ^TMP("PXRMXMZ",$J,1,0)="The following reminder definitions use the old-style MRD function;"
 S ^TMP("PXRMXMZ",$J,2,0)="please change them to use a function finding."
 S NL=2
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S CPCL=$G(^PXD(811.9,IEN,30))
 . I CPCL'["MRD" Q
 . S NAME=$P(^PXD(811.9,IEN,0),U,1)
 . S NL=NL+1
 . S ^TMP("PXRMXMZ",$J,NL,0)=" "
 . S NL=NL+1
 . S ^TMP("PXRMXMZ",$J,NL,0)="Reminder: "_NAME_", ien - "_IEN
 . S NL=NL+1
 . S ^TMP("PXRMXMZ",$J,NL,0)="Custom cohort logic: "_CPCL
 I NL=2 K ^TMP("PXRMXMZ",$J) Q
 D SEND^PXRMMSG(XMSUB)
 Q
 ;
