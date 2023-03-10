LR544A ;SLC/JNM - LAB ANATOMIC PATHOLOGY UPDATE ;Apr 05,2021@14:48
 ;;5.2;LAB SERVICE;**544**;Feb 14, 1996;Build 23
 Q
 ; Integration Agreement - Direct read of ^ORD(101.43 - IA#2835
 ;
POST ; Post install for LR*5.2*544
 N TOTAL S TOTAL=0
 D MES("Updating Anatomic Pathology Dialog Definitions..."),MES("")
 D SPECS,RENAL,MISC
 D MES(""),MES(TOTAL_" Anatomic Pathology Definitions Updated")
 Q
 ;
SPECS ; do specimen updates
 N I,STR,OINAME,SPECNAME,IEN,SPEC,FIELD,FLDIEN,BEFORE,AFTER,FIEN,IDX,DONE,FDA,IENS,ADD,TXT
 F I=1:1 S STR=$P($T(SPECIMENS+I),";;",2) Q:STR=""  D
 . I $P(STR,";",1)="NEW" S ADD=1,$P(STR,";",1,2)=$P(STR,";",2)
 . E  S ADD=0
 . S OINAME=$P(STR,";",1),SPECNAME=$P(STR,";",2),FIELD=$P(STR,";",3),BEFORE=$P(STR,";",4),AFTER=$P(STR,";",5)
 . S IEN=$O(^ORD(101.43,"B",OINAME,0))
 . S SPEC=$O(^LAB(61,"B",SPECNAME,0))
 . I (IEN'>0)!(SPEC'>0) Q
 . I ADD D  Q
 .. I $D(^LAB(69.73,IEN,3,SPEC)) Q
 .. K FDA,IENS,^TMP("DIERR",$J)
 .. S FDA(69.733,"+1,"_IEN_",",.01)=SPECNAME
 .. S FDA(69.733,"+1,"_IEN_",",2.1)="TRUE"
 .. S FDA(69.733,"+1,"_IEN_",",2.2)="AP SPECIMEN"
 .. D UPDATE^DIE("E","FDA","IENS")
 .. D REPORT("Added "_OINAME_" "_SPECNAME)
 .. I SPEC'=$G(IENS(1)) Q
 .. K FDA,IENS,^TMP("DIERR",$J)
 .. S FDA(69.7331,"+1,"_SPEC_","_IEN_",",.01)=FIELD
 .. S FDA(69.7331,"+1,"_SPEC_","_IEN_",",.04)=BEFORE
 .. D UPDATE^DIE("E","FDA","IENS")
 .. D REPORT("Added "_OINAME_" "_SPECNAME_" "_FIELD)
 .. S FIEN=$G(IENS(1)) Q:'FIEN
 .. K FDA,IENS,^TMP("DIERR",$J)
 .. S FDA(69.73311,"+1,"_FIEN_","_SPEC_","_IEN_",",.01)=BEFORE
 .. D UPDATE^DIE("","FDA","IENS")
 .. D REPORT("Added "_OINAME_" "_SPECNAME_" "_FIELD_" "_BEFORE)
 . I '$D(^LAB(69.73,IEN,3,SPEC,1)) Q
 . S (DONE,FIEN)=0 F  S FIEN=$O(^LAB(69.73,IEN,3,SPEC,1,FIEN)) Q:'FIEN!DONE  D
 .. I $P($G(^LAB(69.73,IEN,3,SPEC,1,FIEN,0)),U,1)'=FIELD Q
 .. S IDX=0 F  S IDX=$O(^LAB(69.73,IEN,3,SPEC,1,FIEN,1,IDX)) Q:'IDX!DONE  D
 ... I $P($G(^LAB(69.73,IEN,3,SPEC,1,FIEN,1,IDX,0)),U,1)'=BEFORE Q
 ... K FDA,^TMP("DIERR",$J)
 ... S FDA(69.73311,IDX_","_FIEN_","_SPEC_","_IEN_",",.01)=AFTER
 ... D FILE^DIE("","FDA")
 ... I AFTER="@" S TXT="Deleted ",AFTER=""
 ... E  S TXT="Updated ",AFTER=" to "_AFTER
 ... D REPORT(TXT_OINAME_" "_SPECNAME_" "_FIELD_" "_BEFORE_AFTER)
 ... S DONE=1
 Q
 ;
REPORT(MSG) ; Report Errors
 I $D(^TMP("DIERR",$J)) D  I 1
 . D MES("The following errors occurred trying to")
 . I $E(MSG,1,7)="Updated" S $E(MSG,1,7)="  update"
 . I $E(MSG,1,5)="Added" S $E(MSG,1,5)="  add"
 . I $E(MSG,1,7)="Deleted" S $E(MSG,1,7)="  delete"
 . D MES(MSG) K MSG
 . D MSG^DIALOG("AE",.MSG)
 E  S TOTAL=TOTAL+1
 D MES(.MSG)
 Q
 ;
MES(STR) ;
 N S2,I
 I $L(STR)>79 D
 . F I=80:-1:1 Q:$E(STR,I,I)=" "
 . S S2=$E(STR,I+1,999),STR=$E(STR,1,I-1)
 . D MES(STR) S STR="  "_S2 K S2
 D MES^XPDUTL(.STR)
 Q
 ;
GETPAGE(STR,IEN,PAGE) ; Get 101.43 IEN from pieve 1 of STR, and Page Ien from 2nd piece of STR
 N OINAME,PAGENAME,P,DONE
 S PAGE=0,OINAME=$P(STR,U),PAGENAME=$P(STR,U,2)
 S IEN=$O(^ORD(101.43,"B",OINAME,0)) ; IA#2835
 I IEN D
 . S (DONE,P)=0 F  S P=$O(^LAB(69.73,IEN,2,P)) Q:('P)!DONE  D
 .. I $P($G(^LAB(69.73,IEN,2,P,0)),U,2)=PAGENAME S PAGE=P,DONE=1
 Q
 ;
GETBLOCK(BLOCK,IEN,PAGE) ; Find a block IEN within the specified page
 N BIEN,DONE
 S (DONE,BIEN)=0 F  S BIEN=$O(^LAB(69.73,IEN,2,PAGE,1,BIEN)) Q:('BIEN)!DONE  D
 . I $P($G(^LAB(69.73,IEN,2,PAGE,1,BIEN,0)),U)=BLOCK S DONE=BIEN
 Q DONE
 ;
RENAL ; Update Renal Biopsy
 N IEN,PAGE,BLOCK,FDA,IENS,TEST,PAGENAME,BLOCKNAME,VALUE,NEWBLOCKNAME
 S TEST="RENAL BIOPSY",PAGENAME="Clinical History"
 D GETPAGE(TEST_U_PAGENAME,.IEN,.PAGE)
 I ('IEN)!('PAGE) Q
 S BLOCKNAME="Special Requests (click all that apply)"
 S BLOCK=$$GETBLOCK(BLOCKNAME,IEN,PAGE)
 I BLOCK D
 . K FDA,^TMP("DIERR",$J)
 . S FDA(69.7321,BLOCK_","_PAGE_","_IEN_",",.01)="@"
 . D FILE^DIE("","FDA")
 . D REPORT("Deleted "_TEST_" "_PAGENAME_" "_BLOCKNAME)
 K FDA,IENS,^TMP("DIERR",$J)
 S BLOCKNAME="Request Type"
 I $$GETBLOCK(BLOCKNAME,IEN,PAGE)=0 D
 . S FDA(69.7321,"+1,"_PAGE_","_IEN_",",.01)=BLOCKNAME
 . S FDA(69.7321,"+1,"_PAGE_","_IEN_",",.02)="TRUE"
 . D UPDATE^DIE("E","FDA","IENS")
 . D REPORT("Added "_TEST_" "_PAGENAME_" "_BLOCKNAME)
 . S BLOCK=$G(IENS(1)) I BLOCK D
 .. K FDA,IENS,^TMP("DIERR",$J)
 .. S VALUE="Neoplastic"
 .. S FDA(69.73211,"+1,"_BLOCK_","_PAGE_","_IEN_",",.01)=VALUE
 .. D UPDATE^DIE("E","FDA","IENS")
 .. D REPORT("Added "_TEST_" "_PAGENAME_" "_BLOCKNAME_" "_VALUE)
 .. K FDA,IENS,^TMP("DIERR",$J)
 .. S VALUE="Medical"
 .. S FDA(69.73211,"+1,"_BLOCK_","_PAGE_","_IEN_",",.01)=VALUE
 .. D UPDATE^DIE("E","FDA","IENS")
 .. D REPORT("Added "_TEST_" "_PAGENAME_" "_BLOCKNAME_" "_VALUE)
 S BLOCKNAME="Indication for biopsy"
 S BLOCK=$$GETBLOCK(BLOCKNAME,IEN,PAGE)
 I BLOCK D
 . K FDA,^TMP("DIERR",$J)
 . S NEWBLOCKNAME="Indication for Biopsy"
 . S FDA(69.7321,BLOCK_","_PAGE_","_IEN_",",.01)=NEWBLOCKNAME
 . S FDA(69.7321,BLOCK_","_PAGE_","_IEN_",",.03)="TRUE"
 . D FILE^DIE("E","FDA")
 . D REPORT("Updated "_TEST_" "_PAGENAME_" "_BLOCKNAME_" to "_NEWBLOCKNAME)
 . K FDA,IENS,^TMP("DIERR",$J)
 . S VALUE="Renal mass"
 . S FDA(69.73211,"+1,"_BLOCK_","_PAGE_","_IEN_",",.01)=VALUE
 . D UPDATE^DIE("E","FDA","IENS")
 . D REPORT("Added "_TEST_" "_PAGENAME_" "_NEWBLOCKNAME_" "_VALUE)
 Q
 ;
MISC ; Update URINE Collection Type / On Urology,Prostate, Clinical History, change "Increased PSA" to "Elevated PSA"
 N IEN,OINAME,IDX,DONE,FDA,PAGE,PAGENAME,BLOCK,DONE,BEFORE,AFTER
 S OINAME="URINE"
 S IEN=$O(^ORD(101.43,"B",OINAME,0))
 I IEN D
 . S (IDX,DONE)=0 F  S IDX=$O(^LAB(69.73,IEN,1,IDX)) Q:('IDX)!(DONE)  D
 .. I $P($G(^LAB(69.73,IEN,1,IDX,0)),U,1,2)="OPCTY^1" D
 ... K FDA,^TMP("DIERR",$J)
 ... S FDA(69.731,IDX_","_IEN_",",.02)="@"
 ... D FILE^DIE("","FDA")
 ... D REPORT("Deleted "_OINAME_" COLLECTION TYPE HIDE property")
 ... S DONE=1
 S OINAME="UROLOGY,PROSTATE",PAGENAME="Clinical History"
 D GETPAGE(OINAME_U_PAGENAME,.IEN,.PAGE)
 I ('IEN)!('PAGE) Q
 S BLOCK=$$GETBLOCK(" ",IEN,PAGE)
 I 'BLOCK Q
 S BEFORE="Increased PSA",AFTER="Elevated PSA"
 S (IDX,DONE)=0 F  S IDX=$O(^LAB(69.73,IEN,2,PAGE,1,BLOCK,1,IDX)) Q:'IDX!DONE  D
 . I $P($G(^LAB(69.73,IEN,2,PAGE,1,BLOCK,1,IDX,0)),U,1)'=BEFORE Q
 . K FDA,^TMP("DIERR",$J)
 . S FDA(69.73211,IDX_","_BLOCK_","_PAGE_","_IEN_",",.01)=AFTER
 . D FILE^DIE("","FDA")
 . D REPORT("Updated "_OINAME_" "_PAGENAME_" "_BEFORE_" to "_AFTER)
 Q
 ;
SPECIMENS ;
 ;;BRONCHIAL BIOPSY;BRONCHUS;Stations;Station 2;Station  2
 ;;BRONCHIAL BIOPSY;BRONCHUS;Stations;Station 4;Station  4
 ;;BRONCHIAL BIOPSY;BRONCHUS;Stations;Station 7;Station  7
 ;;FINE NEEDLE ASPIRATE;THYROID GLAND;Specimen Type;Needle Washing;Aspirate and Fixative
 ;;GASTROINTESTINAL ENDOSCOPY;APPENDIX;Technique;Hot biopsy;Hot Biopsy
 ;;GASTROINTESTINAL ENDOSCOPY;LYMPH NODE;Technique;Hot biopsy;Hot Biopsy
 ;;GYNECOLOGY (PAP SMEAR);CERVICAL CYTOLOGIC MATERIAL;Specimen Type;Slide;@
 ;;NEW;GYNECOLOGY (PAP SMEAR);VAGINAL-CERVICAL CYTOLOGIC MATERIAL;Specimen Type;Thin Prep/Liquid based
 ;;
