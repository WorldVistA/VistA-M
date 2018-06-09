PXRMPNRP ;SLC/PKR - Edited Print Name report. ;03/26/2018
 ;;2.0;CLINICAL REMINDERS;**42**;Feb 04, 2005;Build 80
 ;==========================================
PNREP ;Produce a report of all reminder definitions whose Print Name was
 ;edited via the option PXRM DEF PRINT NAME EDIT.
 N BOP,FOUND,IEN,IND,JND,NAME,NL,TEMP,TEXT,TITLE
 S NAME="",NL=0
 F  S NAME=$O(^PXD(811.9,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.9,"B",NAME,""))
 . S (IND,FOUND)=0
 . F  S IND=+$O(^PXD(811.9,IEN,110,IND)) Q:IND=0  D
 .. S TEMP=$G(^PXD(811.9,IEN,110,IND,1,1,0))
 .. I TEMP'="The Print Name was edited\\" Q
 .. I NL>0 S NL=NL+1,TEXT(NL)=" "
 .. I FOUND=0 S NL=NL+1,TEXT(NL)="Reminder Definition: "_NAME_"  (IEN="_IEN_")",FOUND=1
 .. F JND=1:1:6 S NL=NL+1,TEXT(NL)=$P(^PXD(811.9,IEN,110,IND,1,JND,0),"\\",1)
 I NL=0 S NL=NL+1,TEXT(NL)="No entries were found."
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="" Q
 S TITLE="Edited Print Name Report"
 I BOP="B" D
 . N X
 . S X="IORESET"
 . D BROWSE^DDBR("TEXT","NR",TITLE)
 . D ENDR^%ZISS
 . W IORESET
 . D KILL^%ZISS
 I BOP="P" D GPRINT^PXRMUTIL("TEXT")
 Q
 ;
