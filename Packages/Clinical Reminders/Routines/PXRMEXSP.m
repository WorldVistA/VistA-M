PXRMEXSP ;SLC/AGP - Auto packed utility. ;Jun 10, 2024@11:55:28
 ;;2.0;CLINICAL REMINDERS;**85,87**;Feb 04, 2005;Build 35
 ;
TESTER ;
 N DESCTXT,EXNAME,INPUTS,NOTINLM
 S INPUTS(811.9,"VA-WH PAP SMEAR SCREENING")=""
 S INPUTS(811.9,"ZZVA-WH PAP SMEAR REVIEW RESULTS")=""
 S INPUTS(801.41,"VA-WH PAP SMEAR SCREENING")=""
 S INPUTS(801.41,"ZZVA-WH PAP SMEAR REVIEW RESULTS")=""
 S DESCTXT(1)="Exchange file built when patch PXRM*2.0*81"
 S DESCTXT(2)="was installed on "_$$FMTE^XLFDT($$NOW^XLFDT())
 S NOTINLM=1,EXNAME="PXRM*2.0*81 AUTOMATIC BACKUP"
 D CRE(EXNAME,.INPUTS,.DESCTXT,NOTINLM)
 Q
 ;
 ;==========================
BACKUP(IEN) ;
 N DIR,DESCTXT,EXNAME,FAIL,FILES,INPUTS,LIST,NAME,Y
 S NAME=$P($G(^PXD(811.8,IEN,0)),U)
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Back up selected files"
 D ^DIR
 I +Y'=1 Q
 D FILELIST^PXRMEXFILELIST(.FILES,0)
 S FAIL=0
 D PROC120^PXRMEXRP(.LIST,.FILES,IEN,.FAIL) I FAIL=1 W !,"Could not backup exchange entry "_NAME H 2 Q
 M INPUTS=LIST("FILES")
 S EXNAME=$S($L(NAME)<55:NAME_" (BACKUP)",1:$E(NAME,1,54)_" (BACKUP)")
 D CRE(EXNAME,.INPUTS,.DESCTXT,0)
 Q
 ;
 ;==========================
BLDDESC(TMPIND,DESCTXT) ;If multiple entries have been selected
 ;then initialize the description with the selected list.
 N IND,NL,NOUT,TEXT,TEXTOUT
 S NL=+$O(DESCTXT(""))+1
 D FORMAT^PXRMTEXT(1,70,NL,.DESCTXT,.NOUT,.TEXTOUT)
 K ^TMP(TMPIND,$J,"DESC")
 F IND=1:1:NOUT  S ^TMP(TMPIND,$J,"DESC",1,IND,0)=TEXTOUT(IND)
 Q
 ;
BLDFSEL(SELLIST,FILELST,INPUTS) ;
 N ERROR,FN,ID,IEN,NUMF
 S FN=0,ERROR=0
 F  S FN=$O(INPUTS(FN)) Q:FN'>0!(ERROR=1)  D
 .S NUMF=0
 .S ID="" F  S ID=$O(INPUTS(FN,ID)) Q:ID=""!(ERROR=1)  D
 .. S IEN=$S(+ID>0:+ID,1:$$EXISTS^PXRMEXIU(FN,ID))
 .. I IEN=0 S ERROR=1 Q
 .. S NUMF=NUMF+1
 .. S SELLIST(FN,NUMF)=IEN
 .. S SELLIST(FN,"IEN",NUMF)=NUMF
 I ERROR=1 Q 0
 Q 1
 ;
 ;==========================
CRE(EXNAME,INPUTS,DESCTXT,NOTINLM) ;Pack a reminder component and store it in the repository.
 N CMPLIST,CNT,DIEN,DERRFND,DERRMSG,EFNAME,ERROR,FAIL,FAILTYPE,FILELST
 N OUTPUT,POA,RANK,SERROR,SELLIST,SUCCESS,TMPIND,USELIST
 S TMPIND="PXRMEXPR"
 K ^TMP(TMPIND,$J)
 D FILELIST^PXRMEXFILELIST(.FILELST,1)
 D PACKORD^PXRMEXFILELIST(.RANK)
 I '$$BLDFSEL(.SELLIST,.FILELST,.INPUTS) Q
 ;
 K VALMHDR
 I '$D(SELLIST) Q
 ;Save the user's selections.
 M USELIST=SELLIST
 ;Process the selected list to build a complete list of components
 ;to be packed.
 D CMPLIST^PXRMEXPD(.CMPLIST,.SELLIST,.FILELST,.ERROR)
 I ERROR K ^TMP(TMPIND,$J) Q
 S NOTINLM=$G(NOTINLM)
 I '$$DEF(.SELLIST,TMPIND,NOTINLM) Q
 I '$$TERM(.SELLIST,TMPIND,NOTINLM) Q
 I '$$DIALOG(.SELLIST,TMPIND,NOTINLM) Q
 ;
 ;Create the header information.
 S EFNAME=$S($G(EXNAME)'="":EXNAME,1:"")
 S NOTINLM=$G(NOTINLM)
 D HEADER(TMPIND,.USELIST,.SELLIST,.RANK,EXNAME,.DESCTXT)
 I EXNAME=-1 Q
 ;
 ;Order the component list.
 D ORDER^PXRMEXPD(.CMPLIST,.RANK,.POA)
 ;Pack the list
 D PACK^PXRMEXPD(.CMPLIST,.POA,TMPIND,.SELLIST,.SERROR)
 I SERROR K ^TMP(TMPIND,$J) Q
 D STOREPR^PXRMEXU2(.SUCCESS,EXNAME,TMPIND,.SELLIST)
 K ^TMP(TMPIND,$J)
 I SUCCESS D
 . I +$G(NOTINLM) D BMES^XPDUTL(EFNAME_" was saved in the Exchange File.") Q
 . S VALMHDR(1)=EFNAME_" was saved in the Exchange File."
 . D BLDLIST^PXRMEXLC(1)
 E  D
 . I +$G(NOTINLM) D  Q
 ..D BMES^XPDUTL("Creation of Exchange File entry "_EFNAME)
 ..D BMES^XPDUTL("failed; it was not saved!")
 . S VALMHDR(1)="Creation of Exchange File entry "_EFNAME
 . S VALMHDR(2)="failed; it was not saved!"
 Q
 ;
DEF(SELLIST,TMPIND,NOTINLM) ;Check reminder definitions for errors.
 N DIEN,FAIL,IDX,OK,OUTPUT
 S FAIL=0
 I $D(SELLIST(811.9)) D  I FAIL K ^TMP(TMPIND,$J) Q 0
 .;Check each reminder definition.
 . I 'NOTINLM W !!,"Checking reminder definition(s) for errors."
 . S IDX=0
 . F  S IDX=$O(SELLIST(811.9,"IEN",IDX)) Q:IDX'>0  D
 .. S DIEN=+$G(SELLIST(811.9,IDX)) I DIEN=0 Q
 .. I 'NOTINLM W !!,"Checking reminder definition "_$P(^PXD(811.9,DIEN,0),U,1)
 .. K OUTPUT
 .. S OK=$$DEF^PXRMICHK(DIEN,.OUTPUT,$S(NOTINLM=1:0,1:1))
 .. I OK=0 S FAIL=1
 I NOTINLM Q $S(FAIL=1:0,1:1)
 I FAIL=0 W !!,"No fatal reminder definition problems were found, packing will continue."
 I FAIL=1 W !!,"Cannot create the packed file, please correct the above fatal error(s)."
 H 3
 Q 1
 ;
DIALOG(SELLIST,TMPIND,NOTINLM) ;Check reminder dialogs for errors
 N CNT,DIEN,FAIL,IDX,OUTPUT,FAILTYPE
 S FAIL=0
 K OUTPUT
 I $D(SELLIST(801.41)) D  I FAIL="F" K ^TMP(TMPIND,$J) Q 0
 .I 'NOTINLM W !!,"Checking reminder dialog(s) for errors."
 . S IDX=0
 .;Check individual reminder dialogs
 . F  S IDX=$O(SELLIST(801.41,"IEN",IDX)) Q:IDX'>0  D
 .. S DIEN=+$G(SELLIST(801.41,IDX)) I DIEN=0 Q
 .. I FAIL=0 W "."
 .. S FAILTYPE=$$RETARR^PXRMDLRP(DIEN,.OUTPUT) Q:'$D(OUTPUT)
 .. I FAILTYPE="F" S FAIL="F"
 .. I FAILTYPE="W",FAIL=0 S FAIL="W"
 .. I 'NOTINLM D
 ... W !!,$S(FAILTYPE="W":"**WARNING**",FAILTYPE="F":"**FATAL ERROR**",1:"")
 ... S CNT=0 F  S CNT=$O(OUTPUT(CNT)) Q:CNT'>0  W !,OUTPUT(CNT)
 .. K OUTPUT
 .;
 I NOTINLM Q $S(FAIL=1:0,1:1)
 I FAIL=0 W !!,"No fatal dialog problems were found, packing will continue."
 I FAIL="F" W !!,"Cannot create the packed file, please correct the above fatal error(s)."
 H 3
 Q 1
 ;
 ;==========================
HEADER(TMPIND,USELLIST,SELLIST,RANK,EFNAME,DESCTXT) ;Create the Exchange file header
 ;information.
 ;Save the source information and the passed in description text.
 D PUTSRC^PXRMEXPD("",EFNAME,TMPIND)
 D BLDDESC(TMPIND,.DESCTXT)
 ;Add the packing attributes.
 D PATTR^PXRMEXPD(TMPIND)
 Q
 ;
TERM(SELLIST,TMPIND,NOTINLM) ;Check reminder terms for errors.
 N DIEN,FAIL,IDX,OK,OUTPUT
 S FAIL=0
 I $D(SELLIST(811.5)) D  I FAIL K ^TMP(TMPIND,$J) Q 0
 .;Check each reminder term.
 . I 'NOTINLM W !!,"Checking reminder term(s) for errors."
 . S IDX=0
 . F  S IDX=$O(SELLIST(811.5,"IEN",IDX)) Q:IDX'>0  D
 .. S DIEN=+$G(SELLIST(811.5,IDX)) I DIEN=0 Q
 .. I 'NOTINLM W !!,"Checking reminder term "_$P(^PXRMD(811.5,DIEN,0),U,1)
 .. K OUTPUT
 .. S OK=$$TERM^PXRMICK1(DIEN,.OUTPUT,$S(NOTINLM=1:0,1:1))
 .. I OK=0 S FAIL=1
 I NOTINLM Q $S(FAIL=1:0,1:1)
 I FAIL=0 W !!,"No fatal reminder term problems were found, packing will continue."
 I FAIL=1 W !!,"Cannot create the packed file, please correct the above fatal error(s)."
 H 3
 Q $S(FAIL=1:0,1:1)
 ;
