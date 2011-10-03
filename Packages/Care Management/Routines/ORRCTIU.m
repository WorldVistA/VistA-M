ORRCTIU ; SLC/JER - TIU data for CM ; 7/18/05 10:38
 ;;1.0;CARE MANAGEMENT;**2**;Jul 15, 2003
 ;
 ; This routine invokes IAs: 2322,2323,2834,2937,2944,2960,4175,4733
 ;
GETPTUNS(ORRCY,AUDUZ) ; Get pts w/documents that need user's signature
 ; Returns @ORRCY@(DFN,"DOC:"_TIUDA)=""
 ; [from ORRCDPT]
 N TITLE,GVN,ORT,TIUDA,ORDFN,ITR,ORRCASIG
 S TITLE=0,GVN=$NA(^TIU(8925,"AAU")),ORRCY=$NA(^TMP($J,"ORRCTIU")) K @ORRCY
 F  S TITLE=$O(@GVN@(AUDUZ,TITLE)) Q:+TITLE'>0  D
 . S ORT=0 F  S ORT=$O(@GVN@(AUDUZ,TITLE,5,ORT)) Q:+ORT'>0  D
 .. S TIUDA=0
 .. F  S TIUDA=$O(@GVN@(AUDUZ,TITLE,5,ORT,TIUDA)) Q:+TIUDA'>0  D
 ... S ORDFN=$P($G(^TIU(8925,TIUDA,0)),U,2) Q:+ORDFN'>0
 ... I $D(^TMP($J,"ORRCLST")),'$D(^TMP($J,"ORRCY",ORDFN)) Q  ;not on list
 ... I '+$$CANDO^TIULP(TIUDA,"SIGNATURE",AUDUZ) Q  ; user may not sign
 ... S @ORRCY@(ORDFN,"DOC:"_TIUDA)=""
 S TITLE=0,GVN=$NA(^TIU(8925,"ASUP"))
 F  S TITLE=$O(@GVN@(AUDUZ,TITLE)) Q:+TITLE'>0  D
 . N STATUS F STATUS=5,6 D
 .. S ORT=0 F  S ORT=$O(@GVN@(AUDUZ,TITLE,STATUS,ORT)) Q:+ORT'>0  D
 ... S TIUDA=0
 ... F  S TIUDA=$O(@GVN@(AUDUZ,TITLE,STATUS,ORT,TIUDA)) Q:+TIUDA'>0  D
 .... S ORDFN=$P($G(^TIU(8925,TIUDA,0)),U,2) Q:+ORDFN'>0
 .... I $D(^TMP($J,"ORRCLST")),'$D(^TMP($J,"ORRCY",ORDFN)) Q  ;not on list
 .... I '+$$CANDO^TIULP(TIUDA,$S(STATUS=5:"SIGNATURE",1:"COSIGNATURE"),AUDUZ) Q  ; user may not Sign/Cosign
 .... S @ORRCY@(ORDFN,"DOC:"_TIUDA)=""
 ; capture addl signer docs 
 K ^TMP("TIUSIGN",$J),^TMP("ORRCASIG",$J)
 S ORRCASIG="",ITR=0
 D NEEDSIG^TIULX(.ORRCASIG,AUDUZ)
 Q:'$D(@ORRCASIG)
 M ^TMP("ORRCASIG",$J)=@ORRCASIG
 F  S ITR=$O(^TMP("ORRCASIG",$J,ITR)) Q:'ITR  D
 . S TIUDA=^TMP("ORRCASIG",$J,ITR)
 . S ORDFN=$P($G(^TIU(8925,TIUDA,0)),U,2) Q:+ORDFN'>0
 . I $D(^TMP($J,"ORRCLST")),'$D(^TMP($J,"ORRCY",ORDFN)) Q  ;not on list?
 . I '+$$CANDO^TIULP(TIUDA,"SIGNATURE",AUDUZ) Q  ; user may not sign
 . S @ORRCY@(ORDFN,"DOC:"_TIUDA)=""
 K ^TMP("TIUSIGN",$J),^TMP("ORRCASIG",$J)
 Q
 ;
LISTUNS(ORY,ORUSR,ORPAT) ; -- Get list of unsigned documents for ORPAT by ORUSR
 ; 
 Q
 ;
TEXT(ORY,DOC) ; -- Return text of DOCs in
 ; @ORY@(#) = Item=ID^Title^Date IN HL7 format
 ;          = Text=line of document text
 N ORN,ORI,ORRCY,TIUDA,TIUY,TIUI,TIUX
 S ORN=0,ORY=$NA(^TMP($J,"ORRCDOC")) K @ORY
 S ORI="" F  S ORI=$O(DOC(ORI)) Q:ORI=""  D
 . S TIUDA=+$P(DOC(ORI),":",2) D TGET^TIUSRVR1(.ORRCY,TIUDA)
 . M TIUY=ORRCY
 . S TIUX=$$RESOLVE^TIUSRVLO(TIUDA)
 . S ORN=ORN+1,@ORY@(ORN)="Item=DOC:"_TIUDA_U_$P(TIUX,U)_U_$P($$FMTHL7^XLFDT($P(TIUX,U,2)),"-")_U_$$REQENC(TIUDA)
 . S TIUI=0 F  S TIUI=$O(@TIUY@(TIUI)) Q:TIUI<1  S ORN=ORN+1,@ORY@(ORN)="Text="_@TIUY@(TIUI)
 Q
 ;
REQENC(TIUDA)   ; -- Determine whether encounter data is needed
 N ORRD0,ORRD12,ORSVC,ORRY,ORRDP,ORRCSA,ORASK,ORRPRIMD,DATANEED,ORROPT,LST,ORRPRIME,ORRCLST,ORRCDP,ORRCASK
 S ORRD0=$G(^TIU(8925,TIUDA,0)),ORRD12=$G(^(12)),ORRY="false"
 S (ORROPT,DATANEED)=0
 ; Load existing encounter info
 D PCE4NOTE^ORWPCE3(.ORRCLST,TIUDA,+$P(ORRD0,U,2))
 ; identify primary provider
 S ORRPRIMD=$$GETPRIMD(TIUDA,ORRD12,.ORRCLST)
 M LST=ORRCLST
 ; determine whether "Data Needed"
 ; 1. if encdt > today quit false
 I +$P(ORRD0,U,7)>(DT_".235959") G CHKASK
 ; 2. if service category '= "A", "I", or "T" quit false
 S ORSVC=$P(ORRD0,U,13)
 I '$S(ORSVC="A":1,ORSVC="I":1,ORSVC="T":1,1:0) G CHKASK
 S ORROPT=1
 ; if TIU doc param SUPPRESS DX/CPT ON ENTRY is true, quit false
 D DOCPRM^TIULC1(+ORRD0,.ORRCDP)
 M ORRDP=ORRCDP
 I +$P(ORRDP(0),U,14) G CHKASK
 ; if stand-alone visit, quit true
 D HASVISIT^ORWPCE(.ORRCSA,TIUDA,+$P(ORRD0,U,2),+$P(ORRD12,U,11),+$P(ORRD0,U,7))
 I ORRCSA<1 S DATANEED=1 G CHKASK
 ; if TIU doc param ASK DX/CPT ON ALL OPT VISITS is true, quit true
 I +$P(ORRDP(0),U,16) S DATANEED=1 G CHKASK
CHKASK I +DATANEED S DATANEED=$$CHKPCE(TIUDA,.ORRCLST,$P(ORRD0,U,2),$P(ORRD12,U,11))
 M LST=ORRCLST
 D ASKPCE^ORWPCE2(.ORRCASK,DUZ,+$P(ORRD12,U,11))
 M ORASK=ORRCASK
 ; if Never or Disable, quit false
 I $S(ORASK=6:1,ORASK=7:1,1:0) S ORRY="false" G REQENCX
 ; if Always, quit true
 I ORASK=5 S ORRY="true" G REQENCX
 ; if Data Needed, quit true
 I ORASK=3,+DATANEED S ORRY="true" G REQENCX
 ; if Outpatient, quit true
 I ORASK=4,+ORROPT S ORRY="true" G REQENCX
 ; If we don't know who the primary encounter provider is, and we need to know, we
 ; must go to the chart to sign the note - so we treat it the same as if they are primary
 I ORRPRIMD=0 S ORRPRIME=1
 E  S ORRPRIME=+(DUZ=ORRPRIMD)
 ; if Primary/Data Needed, quit true
 I ORASK=0,ORRPRIME,+DATANEED S ORRY="true" G REQENCX
 ; if Primary/Outpatient, quit true
 I ORASK=1,ORRPRIME,+ORROPT S ORRY="true" G REQENCX
 ; if Primary Always, quit true
 I ORASK=2,ORRPRIME S ORRY="true" G REQENCX
REQENCX Q ORRY
 ;
CHKPCE(TIUDA,LST,PTNT,LOC)    ; Look for existing PCE data
 N ENCDT,ORI,CPT,COUNT,MAX,ICD,CODE,SUB,EXPNEED,EXP,RESULT,SCREQ,DOCPARM
 N ORRCSREQ,ORRCDOCP
 S (CPT,ICD,ORI,EXPNEED,EXP,RESULT,COUNT)=0
 S MAX=2
 S ENCDT=$P($P(LST(1),U,4),";",2)
 D SCSEL^ORWPCE(.ORRCSREQ,PTNT,ENCDT,LOC,"")
 M SCREQ=ORRCSREQ
 D DOCPARM^TIUSRVP1(.ORRCDOCP,TIUDA,0)
 M DOCPARM=ORRCDOCP
 I +$P(DOCPARM(0),U,15)=1 S EXPNEED=1,MAX=8
 F  S ORI=$O(LST(ORI)) Q:+ORI'>0  D  Q:(COUNT'<MAX)
 . S CODE=$P(LST(ORI),U)
 . I CODE="POV",'ICD S ICD=1,COUNT=COUNT+1
 . I CODE="CPT",'CPT S CPT=1,COUNT=COUNT+1
 . I EXPNEED,CODE="VST" D
 . . N VAL,IDX
 . . S SUB=$P(LST(ORI),U,2),VAL=$P(LST(ORI),U,3)
 . . S IDX=$S(SUB="SC":1,SUB="AO":2,SUB="IR":3,SUB="EC":4,SUB="MST":5,SUB="HNC":6,1:0)
 . . I IDX>0 S COUNT=COUNT+1 I VAL'="" S $P(SCREQ,";",IDX)=0
 I 'ICD Q 1
 I 'CPT Q 1
 F ORI=1:1:6 D  Q:RESULT=1
 . I $P($P(SCREQ,";",ORI),U,1) S RESULT=1
 Q RESULT
GETPRIMD(TIUDA,ORRD12,LST)    ; Get the Primary Provider
 N ORRY,ORI,ORMDEF,TIUSPRM,ORRCSPRM
 S (ORI,ORRY)=0
 D SITEPARM^TIUSRVP1(.ORRCSPRM) M TIUSPRM=ORRCSPRM
 ; 1. Check for the provider in the encounter, if it exists.
 F  S ORI=$O(LST(ORI)) Q:+ORI'>0  D  Q:+ORRY
 . I $P(LST(ORI),U)="PRV",+$P(LST(ORI),U,6) S ORRY=$P(LST(ORI),U,2)
 ; 2. check for the default primary as specified in TIU
 I 'ORRY D  ;DEFDOC^TIUSRVP1(.ORMDEF,$P(ORRD12,U,11),DUZ,$P(ORRD0,U,7),TIUDA) S ORRY=+ORMDEF
 . I +$P(TIUSPRM,U,8)=1 S ORRY=$$DFLTDOC^TIUPXAPI($P(ORRD12,U,11)) I +ORRY'=DUZ S ORRY=0
 Q ORRY
SIGN(ORY,LIST) ; -- Apply signature to documents in LIST(#)=DOC:##
 ; RPC = ORRC UNSIGNED DOCS SIGN
 Q
