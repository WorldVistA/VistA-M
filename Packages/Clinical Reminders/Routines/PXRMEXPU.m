PXRMEXPU ;SLC/PKR - Utilities for packing and unpacking repository entries. ;12/07/2011
 ;;2.0;CLINICAL REMINDERS;**6,12,22**;Feb 04, 2005;Build 160
 ;==================================================
BTTABLE(DIQOUT,IENROOT,TTABLE) ;Build the DIQOUT to FDA iens translation table.
 N FILENUM,IENS,IENT,IND,UP
 S FILENUM=$O(DIQOUT(""))
 I FILENUM="" Q
 ;DBIA #2631
 S UP=$G(^DD(FILENUM,0,"UP"))
 ;Top level file in DIQOUT should not have an up node.
 I UP="" D
 . S IENS=$O(DIQOUT(FILENUM,"")),IND=+IENS
 . S TTABLE(FILENUM,IENS)="+"_IENS
 E  D  Q
 . W !,"BTTABLE^PXRMEXPU - DIQOUT problem, do not have correct top level"
 ;
 F  S FILENUM=$O(DIQOUT(FILENUM)) Q:FILENUM=""  D
 . S UP=$G(^DD(FILENUM,0,"UP"))
 . S IENS=""
 . F  S IENS=$O(DIQOUT(FILENUM,IENS)) Q:IENS=""  D
 .. S IND=IND+1
 .. S IENT=$P(IENS,",",2,99)
 .. S TTABLE(FILENUM,IENS)="+"_IND_","_TTABLE(UP,IENT)
 .. S IENROOT(IND)=$P(IENS,",",1)
 Q
 ;
 ;==================================================
CLDIQOUT(DIQOUT) ;Clean up DIQOUT remove null entries and change .01's
 ;to the resolved form.
 N IENS,INTERNAL,FIELD,FILENUM,LINE
 N PLEN,PREFIX,PTRTO,ROOT,TYPE,WPLCNT,VLIST,VPTRLIST
 S FILENUM=""
 F  S FILENUM=$O(DIQOUT(FILENUM)) Q:FILENUM=""  D
 . K TYPE,VPTRLIST
 . S IENS=""
 . F  S IENS=$O(DIQOUT(FILENUM,IENS)) Q:IENS=""  D
 .. S FIELD=""
 .. F  S FIELD=$O(DIQOUT(FILENUM,IENS,FIELD)) Q:FIELD=""  D
 ...;If there is no data then don't keep this entry.
 ... I DIQOUT(FILENUM,IENS,FIELD)="" K DIQOUT(FILENUM,IENS,FIELD) Q
 ...;Get the field type, if it is a variable-pointer then set up
 ...;the resolved form.
 ... I '$D(TYPE(FILENUM,FIELD)) S TYPE(FILENUM,FIELD)=$$GET1^DID(FILENUM,FIELD,"","TYPE")
 ... S PTRTO=$S(TYPE(FILENUM,FIELD)="POINTER":$$GET1^DID(FILENUM,FIELD,"","POINTER"),1:"")
 ... ;Check if this pointer is ok to transport.
 ... I '$$PTROK(PTRTO) K DIQOUT(FILENUM,IENS,FIELD) Q
 ...;If the field's type is COMPUTED then don't transport it.
 ... I TYPE(FILENUM,FIELD)="COMPUTED" K DIQOUT(FILENUM,IENS,FIELD) Q
 ... I TYPE(FILENUM,FIELD)="VARIABLE-POINTER" D
 .... I '$D(VPTRLIST(FILENUM,FIELD)) D
 ..... K VLIST
 ..... D BLDRLIST^PXRMVPTR(FILENUM,FIELD,.VLIST)
 ..... M VPTRLIST(FILENUM,FIELD)=VLIST
 .... S INTERNAL=$$GET1^DIQ(FILENUM,IENS,FIELD,"I")
 .... S (PTRTO,ROOT)=$P(INTERNAL,";",2)
 .... S PREFIX=$P(VPTRLIST(FILENUM,FIELD,ROOT),U,4)_"."
 .... S PLEN=$L(PREFIX)
 .... I $E(DIQOUT(FILENUM,IENS,FIELD),1,PLEN)'=PREFIX S DIQOUT(FILENUM,IENS,FIELD)=PREFIX_DIQOUT(FILENUM,IENS,FIELD)
 ... I TYPE(FILENUM,FIELD)="WORD-PROCESSING" D
 .... S (LINE,WPLCNT)=0
 .... F  S LINE=$O(DIQOUT(FILENUM,IENS,FIELD,LINE)) Q:LINE=""  D
 ..... S WPLCNT=WPLCNT+1
 .... I WPLCNT>0 S DIQOUT(FILENUM,IENS,FIELD)="WP-start~"_WPLCNT
 .... E  K DIQOUT(FILENUM,IENS,FIELD)
 ...;For fields that point to files 80 and 80.1 we have to append a space
 ...;so FileMan can resolve the pointers when installing a component.
 ... I PTRTO["ICD" S DIQOUT(FILENUM,IENS,FIELD)=DIQOUT(FILENUM,IENS,FIELD)_" "
 Q
 ;
 ;==================================================
CONTOFDA(DIQOUT,IENROOT) ;Convert the iens from the form
 ;returned by GETS^DIQ to the FDA laygo form used by UPDATE^DIE.
 ;DIQOUT contains the GETS^DIQ output. If any of the fields are
 ;variable pointers change them to the resolved form.
 N IENS,IENSA,FIELD,FILENUM,TTABLE,TYPE
 ;Clean up DIQOUT remove null entries and change .01's to the resolved
 ;form.
 D CLDIQOUT(.DIQOUT)
 ;Convert the iens to the adding FDA form.
 D BTTABLE(.DIQOUT,.IENROOT,.TTABLE)
 S FILENUM=""
 F  S FILENUM=$O(DIQOUT(FILENUM)) Q:FILENUM=""  D
 . S IENS=""
 . F  S IENS=$O(DIQOUT(FILENUM,IENS)) Q:IENS=""  D
 .. S IENSA=TTABLE(FILENUM,IENS)
 .. S FIELD=""
 .. F  S FIELD=$O(DIQOUT(FILENUM,IENS,FIELD)) Q:FIELD=""  D
 ... M DIQOUT(FILENUM,IENSA,FIELD)=DIQOUT(FILENUM,IENS,FIELD)
 .. K DIQOUT(FILENUM,IENS)
 Q
 ;
 ;==================================================
PTROK(PTR) ;Return true if items associated with this pointer are
 ;ok to transport. Note the form of the pointer is that returned
 ;by GET1^DID(FILENUM,FIELD,"","POINTER").
 I PTR="USR(8930," Q 0
 I PTR="VA(200," Q 0
 Q 1
 ;
 ;==================================================
RMEH(FILENUM,DIQOUT,NOSTUB) ;Clear the edit history from all reminder files.
 ;Leave a stub so it can be filled in when the file is installed.
 I (FILENUM<800)!(FILENUM>811.9) Q
 N IENS,SFN,TARGET
 ;Edit History is stored in node 110 for all files, get the
 ;subfile number.
 D FIELD^DID(FILENUM,110,"","SPECIFIER","TARGET")
 S SFN=+$G(TARGET("SPECIFIER"))
 I SFN=0 Q
 ;Clean out the history.
 S IENS=""
 F  S IENS=$O(DIQOUT(SFN,IENS)) Q:IENS=""  K DIQOUT(SFN,IENS)
 ;Create a stub for the install.
 I $G(NOSTUB) Q
 S IENS="1,"_$O(DIQOUT(FILENUM,""))
 S DIQOUT(SFN,IENS,.01)=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S DIQOUT(SFN,IENS,1)=$$GET1^DIQ(200,DUZ,.01)
 S DIQOUT(SFN,IENS,2)="DIQOUT("_SFN_","_IENS_"2)"
 S DIQOUT(SFN,IENS,2,1)="Exchange Stub"
 Q
 ;
 ;==================================================
UPDATE(SUCCESS,FDA,FDAIEN) ;Call to add new entries to the repository.
 N MSG
 ;Try to eliminate gaps in the repository.
 S $P(^PXD(811.8,0),U,3)=0
 D UPDATE^DIE("E","FDA","FDAIEN","MSG")
 I $D(MSG) D
 . N DATE,RNAME
 . S SUCCESS=0
 . W !,"The update failed, UPDATE^DIE returned the following error message:"
 . D AWRITE^PXRMUTIL("MSG")
 . S RNAME=FDA(811.8,"+1,",.01)
 . S DATE=FDA(811.8,"+1,",.03)
 . W !!,"Exchange File entry ",RNAME," date packed ",DATE," did not get stored!"
 . W !,"Examine the above error message for the reason.",!
 . H 2
 E  S SUCCESS=1
 Q
 ;
