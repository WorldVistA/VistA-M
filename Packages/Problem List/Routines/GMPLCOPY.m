GMPLCOPY ;ISP/TC - Copy Problem Selection Lists/Categories ;09/21/16  09:03
 ;;2.0;Problem List;**49**;Aug 25, 1994;Build 43
 ;
 ;=====================================================
SETCLDLM(GMPFLNM,GMPIEN,GMPCLASS) ;Set the class field to GMPCLASS and update Date Last Modified
 N GMPIENS,GMPFDA,GMPMSG,GMPFLD
 S GMPIENS=GMPIEN_","
 S GMPFLD=$S(GMPFLNM="125":".04",GMPFLNM="125.11":".03")
 S GMPFDA(GMPFLNM,GMPIENS,GMPFLD)=GMPCLASS
 S GMPFDA(GMPFLNM,GMPIENS,.02)=$$DT^XLFDT
 D FILE^DIE("K","GMPFDA","GMPMSG")
 I $D(GMPMSG) D AWRITE("GMPMSG")
 Q
 ;
 ;=====================================================
COPY(GMPPRMPT,GMPROOT,GMPWHAT,GMPVAL) ;Copy an entry of GMPROOT into a new entry.
 N DIROUT,DTOUT,DUOUT
 F  D GETORIG Q:$D(DIROUT)  Q:$D(DTOUT)
 Q
 ;
 ;=====================================================
COPYCAT(GMPVAL) ;Copy a selection list category.
 N GMPPRMPT,GMPROOT,GMPWHAT
 S GMPWHAT="category"
 S GMPROOT="^GMPL(125.11,"
 S GMPPRMPT="Select the category to copy: "
 D COPY(GMPPRMPT,GMPROOT,GMPWHAT,.GMPVAL)
 Q
 ;
 ;=====================================================
COPYLIST ;Copy a selection list.
 N GMPPRMPT,GMPROOT,GMPWHAT
 S GMPWHAT="selection list"
 S GMPROOT="^GMPL(125,"
 S GMPPRMPT="Select the list to copy: "
 D COPY(GMPPRMPT,GMPROOT,GMPWHAT)
 Q
 ;
 ;=====================================================
DELETE(DIK,DA) ;Delete the entry just added.
 D ^DIK
 W !!,"New entry not created due to invalid name!",!
 Q
 ;
 ;=====================================================
GETFOIEN(GMPROOT) ;Return the first open IEN in GMPROOT. This should be called
 ;after a call to SETSTART.
 N GMPENTRY,GMPNIEN,GMPOIEN
 S GMPENTRY=GMPROOT_0_")"
 S GMPOIEN=+$P(@GMPENTRY,U,3)
 S GMPENTRY=GMPROOT_GMPOIEN_")"
 F  S GMPNIEN=$O(@GMPENTRY) Q:+(GMPNIEN-GMPOIEN)>1  Q:+GMPNIEN'>0  S GMPOIEN=GMPNIEN,GMPENTRY=GMPROOT_GMPNIEN_")"
 Q GMPOIEN+1
 ;
 ;=====================================================
GETORIG  ;Look-up logic to get and copy source entry to destination.
 N DIC,GMPIENN,GMPIENO,Y
 S DIC=GMPROOT,DIC(0)="AEMQ",DIC("A")=GMPPRMPT
 W !
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S DIROUT="" Q
 S GMPIENO=$P(Y,U,1)
 I GMPIENO=-1 S DIROUT="" Q
 D GETORIGC(GMPIENO,.GMPIENN,GMPROOT,GMPWHAT,.GMPVAL)
 Q
 ;
GETORIGC(GMPIENO,GMPIENN,GMPROOT,GMPWHAT,GMPVAL) ;
 N DA,DIC,DIE,DIK,DIR,DIRUT,GMPFDA,GMPFLDLN,GMPFILE
 N GMPIENS,GMPMSG,GMPNAME,GMPORGNM,X,Y,GMPL0
 S DIC=GMPROOT
 ;Set the starting place for additions.
 D SETSTART(DIC)
 S GMPIENN=$$GETFOIEN(GMPROOT)
 D MERGE(GMPIENN,GMPIENO,GMPROOT)
 ;
 ;Get the new name.
 S GMPORGNM=$P(@(GMPROOT_GMPIENO_",0)"),U,1)
 S GMPFILE=+$P(@(GMPROOT_"0)"),U,2)
 S GMPFLDLN=$$GET1^DID(GMPFILE,.01,"","FIELD LENGTH")
 S DIR(0)="F"_U_"3:"_GMPFLDLN_U_"K:(X?.N)!'(X'?1P.E) X"
 S DIR("A")="PLEASE ENTER A UNIQUE NAME"
GETNAM D ^DIR
 I $D(DIRUT) D DELETE(GMPROOT,GMPIENN) Q
 S GMPNAME=Y
 ;
 ;Make sure the new name is valid.
 I '$$VNAME^GMPLINTR(GMPNAME) G GETNAM
 ;
 ;Change to the new name.
 S GMPIENS=GMPIENN_","
 S GMPFDA(GMPFILE,GMPIENS,.01)=GMPNAME
 K GMPMSG
 D FILE^DIE("","GMPFDA","GMPMSG")
 ;Check to make sure the name was not a duplicate.
 I $G(GMPMSG("DIERR",1))=740 D  G GETNAM
 . W !,GMPNAME," is not a unique name!"
 ;Change the class to local and update Date Last Modified.
 D SETCLDLM(GMPFILE,GMPIENN,"L")
 ;
 ;Reindex the cross-references.
 S DIK=GMPROOT,DA=GMPIENN
 D IX^DIK
 ;
 S GMPL0=$G(@(GMPROOT_GMPIENN_",0)"))
 S GMPVAL=GMPIENN_U_GMPL0
 W !!,"The original "_GMPWHAT_" "_GMPORGNM_" has been copied into "_GMPNAME_"." H 1
 Q
 ;
 ;=====================================================
MERGE(GMPIENN,GMPIENO,GMPROOT) ;Use MERGE to copy GMPROOT(GMPIENO into GMPROOT(GMPIENN.
 N GMPDEST,GMPSRCE
 S GMPDEST=GMPROOT_GMPIENN_")"
 ;Lock the file before merging.
 L +@GMPDEST:DILOCKTM
 S GMPSRCE=GMPROOT_GMPIENO_")"
 M @GMPDEST=@GMPSRCE
 ;Unlock the file
 L -@GMPDEST
 Q
 ;
 ;=====================================================
SETSTART(GMPROOT) ;Set the starting value to add new entries. Start
 ;at the begining so empty spaces are filled in.
 N GMPCUR,GMPENTRY
 S GMPENTRY=GMPROOT_"0)"
 S $P(@GMPENTRY,U,3)=1
 Q
 ;
 ;=================================
AWRITE(GMPREF) ;Write all the descendants of the array reference, including the
 ;array. REF is the starting array reference, for example A or
 ;^TMP("PXRM",$J).
 N GMPDONE,GMPIND,GMPLEN,GMPLN,GMPPRT,GMPROOT,GMPSTRT,GMPTMP,GMPTXT
 I GMPREF="" Q
 S GMPLN=0
 S GMPPRT=$P(GMPREF,")",1)
 ;Build the root so we can tell when we are done.
 S GMPTMP=$NA(@GMPREF)
 S GMPROOT=$P(GMPTMP,")",1)
 S GMPREF=$Q(@GMPREF)
 I GMPREF'[GMPROOT Q
 S GMPDONE=0
 F  Q:(GMPREF="")!(GMPDONE)  D
 . S GMPSTRT=$F(GMPREF,GMPROOT)
 . S GMPLEN=$L(GMPREF)
 . S GMPIND=$E(GMPREF,GMPSTRT,GMPLEN)
 . S GMPLN=GMPLN+1,GMPTXT(GMPLN)=GMPPRT_GMPIND_"="_@GMPREF
 . S GMPREF=$Q(@GMPREF)
 . I GMPREF'[GMPROOT S GMPDONE=1
 D MES^XPDUTL(.GMPTXT)
 Q
 ;
