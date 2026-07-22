MAGIP385 ;WOIFO/JBM/DWM - Install code for MAG*3.0*385; 21 April 2026
 ;;3.0;IMAGING;**385**;Mar 19, 2002;Build 10
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; Supported IA #10141 reference $$BMES^XPDUTL function call
 ; Supported IA #2053 reference FILE^DIE
 ;
 ; There are no environment checks here but the MAGIP379 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK,OUT,IEN,MAGFDA,ERR,MAGMSG
 D CLEAR^MAGUERR(1)
 ;
 ; ------------------------------------------------------------------
 D DISPURL ; #2006.1 Imaging Site Parameter file - Display URL update
 ; ------------------------------------------------------------------
 D NETLOC ; #2005.2 Network Location - VistA Site Service update
 ; ------------------------------------------------------------------
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;
DISPURL ; #2006.1 Imaging Site Parameter file - Display Help URL update
 ;  Adding VDL link for the Clinical Display User Manual
 N IEN,URL
 S URL="https://www.domain.ext/vdl/documents/Clinical/Vista_Imaging_Sys/MAG_Display_User_Manual.pdf"
 S IEN=0 F  S IEN=$O(^MAG(2006.1,IEN)) Q:'IEN  D
 . S $P(^MAG(2006.1,IEN,"HELPD"),U)=URL
 . Q
 Q
 ;
NETLOC ; #2005.2 Network Location - VistA Site Service update
 ;  Update to 'https:' & remove port number (if needed)
 ;
 N UP,IEN,FILE,FIELD,IENS,PHYREF,X,Y,HYP,SERV,NUM,MAGFDA,DIERR,MAGERR
 ;
 ; Obtain VistA Site Service IEN value in #2005.2
 S UP=0,IEN=$$FIND1^DIC(2005.2,"","X","VISTASITESERVICE","B") D  Q:'IEN
 . Q:IEN
 . I IEN=0 W !!,"No VISTASITESERVICE entry found in file #2005.2",!! Q
 . W !!,"ERROR - unable to obtain #2005.2 IEN for VISTASITESERVICE",!!
 . Q
 ;
 ; Physical Reference - field #1
 S FILE=2005.2,FIELD=1,IENS=IEN
 S PHYREF=$$GET1^DIQ(FILE,IENS,FIELD) I $D(DIERR)!(PHYREF="") D  Q
 . W !!,"ERROR - unable to obtain PHYSICAL REFERENCE field "
 . W "value for VISTASITESERVICE",!!
 . Q
 ;
 ; Hyper Text Transfer Protocol - update to 'https:' (if needed)
 S X=$P(PHYREF,"/"),Y=$$LOWER(X) S HYP=Y K X,Y
 I HYP="http:" S HYP="https:",$P(PHYREF,"/")=HYP,UP=1
 ;
 ; Port Number - remove if present
 I $L(PHYREF,":")>2 D
 . S SERV=$P(PHYREF,"/",3),NUM=$F(SERV,":")-2
 . S SERV=$E(SERV,1,NUM),$P(PHYREF,"/",3)=SERV,UP=1
 . Q
 ;
 ; Update #2005.2 VistA Site Service entry (if needed)
 I UP=0 D  Q
 . W !!,"No update to the VistA Site Service entry needed"
 . Q
 I UP=1 D
 . L +^MAG(2005.2,IENS):1E9
 . K MAGFDA,DIERR,MAGERR S MAGFDA(2005.2,IENS_",",1)=PHYREF
 . D FILE^DIE("","MAGFDA","MAGERR")
 . I $D(DIERR) D
 .. W !!,"ERROR - unable to update #2005.2 entry for VISTASITESERVICE",!!
 .. Q
 . I '$D(DIERR) D
 .. W !!,"VistA Site Service field 'Physical Reference' updated:"
 .. W !,PHYREF,!!
 .. Q
 . K MAGFDA,DIERR,MAGERR
 . L -^MAG(2005.2,IENS)
 . Q
 Q
 ;
LOWER(X) ; Translate to Lowercase
 N Y
 S Y=$TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 Q Y
