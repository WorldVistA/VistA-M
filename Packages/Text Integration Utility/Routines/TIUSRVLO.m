TIUSRVLO ;SLC/JER - Server fns - lists for CPRS ;Apr 06, 2021@11:27:34
 ;;1.0;TEXT INTEGRATION UTILITIES;**1,15,19,63,108,122,181,194,211,268,287,339**;Jun 20, 1997;Build 39
 ;
 ; AWCMCPR1        DBIA #4325
 ;
NOTES(TIUY,DFN,EARLY,LATE,PERSON,SEQUENCE) ; Get notes
 N TIUPREF,TIUOCC S TIUPREF=$$PERSPRF^TIULE(DUZ)
 S TIUOCC=$P(TIUPREF,U,10),PERSON=$S(+$G(PERSON):+$G(PERSON),1:+$G(DUZ))
 S SEQUENCE=$S($G(SEQUENCE)]"":$G(SEQUENCE),1:"D")
 D CONTEXT(.TIUY,3,1,DFN,$G(EARLY),$G(LATE),PERSON,TIUOCC,SEQUENCE)
 Q
SUMMARY(TIUY,DFN,EARLY,LATE) ; Get Summaries
 N TIUPREF,TIUOCC S TIUPREF=$$PERSPRF^TIULE(DUZ)
 S TIUOCC=$P(TIUPREF,U,10),PERSON=$S(+$G(PERSON):+$G(PERSON),1:+$G(DUZ))
 S SEQUENCE=$S($G(SEQUENCE)]"":$G(SEQUENCE),1:"D")
 D CONTEXT(.TIUY,244,1,DFN,$G(EARLY),$G(LATE),PERSON,TIUOCC,SEQUENCE)
 Q
CONTEXT(TIUY,CLASS,CONTEXT,DFN,EARLY,LATE,PERSON,OCCLIM,SEQUENCE,SHOWADD,INCUND,SHOW,TIUIEN) ; main
 ; --- Call with:  TIUY     - RETURN ARRAY pass by reference
 ;                 CLASS    - Pointer to TIU DOCUMENT DEFINITION #8925.1
 ;                 CONTEXT  - 1=All Signed (by PT),
 ;                          - 2="Unsigned (by PT&(AUTHOR!TANSCRIBER))
 ;                          - 3="Uncosigned (by PT&EXPECTED COSIGNER
 ;                          - 4="Signed notes (by PT&selected author)
 ;                          - 5="Signed notes (by PT&date range)
 ;                 DFN      - Pointer to Patient (#2)
 ;                [EARLY]   - FM date/time to begin search
 ;                [LATE]    - FM date/time to end search
 ;                [PERSON]  - Pointer to file 200 (DUZ if not passed)
 ;                [OCCLIM]  - Occurrence Limit (optional)
 ;                [SEQUENCE]- "A"=ascending (Regular date/time)
 ;                          - "D"=descending (Reverse date/time) (dflt)
 ;                [INCUND]  - Boolean: include undictated & untranscribed
 ;                 SHOW     - Boolean: Return "0^SHOW MORE" in return
 ;                            array when additional notes available for
 ;                            context of 1 or 5 when occurrence limit
 ;                            prevents all notes from displaying
 ;                 TIUIEN   - Starting TIU IEN for additional return
 ;                            when "SHOW MORE" was received in previous
 ;                            return array (LATE date/time will be set
 ;                            to Reference date of this TIU document)
 ;
 S TIUY=$NA(^TMP("TIUR",$J))
 K @TIUY
 I $G(CONTEXT)'>0 Q
 I $G(CLASS)'>0 Q
 I $G(CONTEXT)=1 D STRT1^AWCMCPR1 ; TIU*1.0*181
 S:+$G(EARLY)'>0!(+$G(CONTEXT)=1) EARLY=0
 S:+$G(LATE)'>0!(+$G(CONTEXT)=1) LATE=5000000
 I EARLY>LATE D SWAP(.EARLY,.LATE)
 I +$G(TIUIEN)>0,(CONTEXT=1!(CONTEXT=5)) S LATE=$P($G(^TIU(8925,+TIUIEN,13)),U,1) I EARLY>LATE Q
 I $L(LATE,".")=1 D EXPRANGE(.EARLY,.LATE)
 S:+$G(PERSON)'>0 PERSON=DUZ
 S:$G(SEQUENCE)']"" SEQUENCE="D"
 S:+$G(OCCLIM)'>0 OCCLIM=9999999
 S DFN=+$G(DFN)
 S EARLY=9999999-EARLY,LATE=9999999-LATE ; CHANGE TO REVERSE DATES
 ;
 I CONTEXT=1!(CONTEXT=5) D  G CTXQ
 . D ACLPT(.TIUY,CLASS,DFN,LATE,EARLY,OCCLIM,SEQUENCE,+$G(SHOW),$G(TIUIEN))
 ;
 I CONTEXT=2 D  G CTXQ
 . I DFN>0 D  Q
 . . D ACLAU(.TIUY,CLASS,PERSON,DFN,LATE,EARLY,SEQUENCE,$G(INCUND))
 . F  S DFN=$O(^TIU(8925,"ACLAU",CLASS,PERSON,DFN)) Q:DFN'>0  D ACLAU(.TIUY,CLASS,PERSON,DFN,LATE,EARLY,SEQUENCE,$G(INCUND))
 ;
 I CONTEXT=3 D  G CTXQ
 . I DFN>0 D  Q
 . . D ACLEC(.TIUY,CLASS,PERSON,DFN,LATE,EARLY,SEQUENCE)
 . F  S DFN=$O(^TIU(8925,"ACLEC",CLASS,PERSON,DFN)) Q:DFN'>0  D ACLEC(.TIUY,CLASS,PERSON,DFN,LATE,EARLY,SEQUENCE)
 ;
 I CONTEXT=4 D  G CTXQ
 . I DFN>0 D  Q
 . . D APTCL^TIUSRVLP(.TIUY,CLASS,PERSON,DFN,LATE,EARLY,SEQUENCE)
 . F  S DFN=$O(^TIU(8925,"APTCL",DFN)) Q:DFN'>0  D APTCL^TIUSRVLP(.TIUY,CLASS,PERSON,DFN,LATE,EARLY,SEQUENCE)
 ;
CTXQ ;
 K @TIUY@("INDX")
 I $D(AWCSTRT) D END^AWCMCPR1 ; TIU*1.0*181
 Q
 ;
SWAP(TIUX,TIUY) ; Swap variables
 N TIUTMP S TIUTMP=TIUX,TIUX=TIUY,TIUY=TIUTMP
 Q
 ;
EXPRANGE(TIUX,TIUY) ; Expand range when same for early & late
 I TIUX=DT S TIUY=$$NOW^XLFDT I 1
 E  S TIUY=TIUY_"."_2359
 Q
 ;
ACLPT(TIUY,CLASS,DFN,TIME1,TIME2,OCCLIM,SEQUENCE,SHOW,TIUIEN) ; Signed, by patient
 N DATTIM,DA,LSTDA,NGD,PRVRTNDT,ROOT,STRTDT,TIUI,TIUJ,TIUP,OCCLIM2
 S (LSTDA,NGD,STRTDT)=0
 I +TIUIEN>0 D
 . S NGD=1
 . S STRTDT=9999999-TIME1
 . S PRVRTNDT=0
 S OCCLIM2=OCCLIM,OCCLIM=OCCLIM+1
 S ROOT=$NA(^TIU(8925,"ACLPT",CLASS,DFN)),TIUJ=0
 S DATTIM=TIME1-.0000001
 F  S DATTIM=$O(@ROOT@(DATTIM)) Q:$S(+DATTIM'>0:1,+DATTIM>TIME2:1,+$G(TIUJ)'<OCCLIM:1,1:0)  D  Q:+$G(TIUJ)'<OCCLIM
 . S DA=0 F  S DA=$O(@ROOT@(DATTIM,DA)) Q:DA'>0  Q:+$G(TIUJ)'<OCCLIM  D
 . . I NGD=1 D  Q  ;If grabbing additional entries, don't return any before the one sent in or the sent in one as the starting point
 . . . I DA=TIUIEN D  ;Reached starting point, everything after is valid to return
 . . . . S NGD=0
 . . . . S PRVRTNDT=9999999-DATTIM
 . . . . Q
 . . . Q
 . . ;Added first condition to following line for interdisciplinary notes - need addenda
 . . I +$G(SHOWADD)=0,(+$G(^TIU(8925,+DA,0))=81) Q
 . . I +$G(^TIU(8925,+DA,0))'>0 K @ROOT@(DATTIM,DA) Q
 . . ; Selectively filter DELETED or RETRACTED records
 . . I +$P($G(^TIU(8925,DA,0)),U,5)>13,'+$$CANDO^TIULP(DA,"VIEW",DUZ) Q
 . . I +$D(@TIUY@("INDX",DA)) S LSTDA=DA Q
 . . I TIUJ'<OCCLIM2 S OCCLIM=OCCLIM2 Q
 . . S LSTDA=DA
 . . S TIUI=$S(SEQUENCE="D":+$G(TIUI)+1,1:+$G(TIUI)-1)
 . . S @TIUY@(TIUI)=DA_U_$$RESOLVE(DA)
 . . I '+$D(@TIUY@("INDX",+$P($G(^TIU(8925,+DA,0)),U,6))),'+$D(@TIUY@("INDX",+$G(^TIU(8925,+DA,21)))) S TIUJ=+$G(TIUJ)+1
 . . S @TIUY@("INDX",DA,TIUI)=""
 . . Q:+$G(SHOWADD)=0
 . . S TIUP=+$$HASDAD^TIUSRVLI(DA) I TIUP D  D SETDAD^TIUSRVLI(.TIUY,DA,.TIUI,1)
 . . . N TIUPT
 . . . S TIUPT=$P($G(^TIU(8925,+DA,0)),"^",6)
 . . . I TIUPT]"",'$D(^TIU(8925,"DAD",TIUPT,DA)) S ^TIU(8925,"DAD",TIUPT,DA)=""
 . . . I TIUPT="" S TIUPT=$G(^TIU(8925,+DA,21))
 . . . I '$D(^TIU(8925,TIUPT,0)) S $P(@TIUY@(TIUI),"^",16)=1,$P(@TIUY@(TIUI),"^",14)=1 Q
 . . I +$$HASKIDS^TIUSRVLI(DA) D
 . . . ;ADD IF PREVIOUS RETURN THEN REMOVE ENTRY CODE
 . . . D SETKIDS^TIUSRVLI(.TIUY,DA,.TIUI,1)
 I +TIUIEN>0 D RESEQ^TIUSRVLI(.TIUY,.TIUI)
 I +SHOW>0,+DATTIM>0,+DATTIM'>TIME2,+$G(TIUJ)'<OCCLIM D
 . S DA=LSTDA ;+$G(@TIUY@(TIUI))
 . S TIUI=$S(SEQUENCE="D":+$G(TIUI)+1,1:+$G(TIUI)-1)
 . N LSTDT S LSTDT=+$G(^TIU(8925,+DA,13)) I LSTDT'>0 S LSTDT=""
 . S @TIUY@(TIUI)=DA_"^SHOW MORE^"_LSTDT_"^^^^^^^^^^^"_$S(+$G(CONTEXT):CONTEXT,1:1)_"^"
 Q
 ;
ACLAU(TIUY,CLASS,AUTHOR,DFN,TIME1,TIME2,SEQUENCE,INCUND) ; Unsigned
 N DATTIM,DA,ROOT,TIUI
 S ROOT=$NA(^TIU(8925,"ACLAU",CLASS,AUTHOR,DFN))
 S DATTIM=TIME1-.0000001
 F  S DATTIM=$O(@ROOT@(DATTIM)) Q:DATTIM'>0!(DATTIM>TIME2)  D
 . S DA=0 F  S DA=$O(@ROOT@(DATTIM,DA)) Q:DA'>0  D
 . . I +$G(^TIU(8925,+DA,0))'>0 K @ROOT@(DATTIM,DA) Q
 . . I +$P($G(^TIU(8925,DA,0)),U,5)>6 K @ROOT@(DATTIM,DA) Q
 . . S TIUI=$S(SEQUENCE="D":+$G(TIUI)+1,1:+$G(TIUI)-1)
 . . Q:+$D(@TIUY@("INDX",DA))
 . . ; Selectively filter DELETED or RETRACTED records
 . . I +$P($G(^TIU(8925,DA,0)),U,5)>13,'+$$CANDO^TIULP(DA,"VIEW",DUZ) Q
 . . S @TIUY@(TIUI)=DA_U_$$RESOLVE(DA)
 . . S @TIUY@("INDX",DA,TIUI)=""
 . . Q:+$G(SHOWADD)=0
 . . S TIUP=+$$HASDAD^TIUSRVLI(DA) I TIUP D  D SETDAD^TIUSRVLI(.TIUY,DA,.TIUI,0)
 . . . N TIUPT
 . . . S TIUPT=$P($G(^TIU(8925,+DA,0)),"^",6)
 . . . I TIUPT]"",'$D(^TIU(8925,"DAD",TIUPT,DA)) S ^TIU(8925,"DAD",TIUPT,DA)=""
 . . . I TIUPT="" S TIUPT=$G(^TIU(8925,+DA,21))
 . . . I '$D(^TIU(8925,TIUPT,0)) S $P(@TIUY@(TIUI),"^",16)=1,$P(@TIUY@(TIUI),"^",14)=2 Q
 . . I +$$HASKIDS^TIUSRVLI(DA) D SETKIDS^TIUSRVLI(.TIUY,DA,.TIUI,0)
 I +$G(INCUND) D GETUND^TIUSRVLI(.TIUY,CLASS,DFN,TIME1,TIME2,.TIUI,SEQUENCE)
 Q
 ;
ACLEC(TIUY,CLASS,EXCOSIGN,DFN,TIME1,TIME2,SEQUENCE) ; Uncosigned
 N DATTIM,DA,ROOT,TIUI
 S ROOT=$NA(^TIU(8925,"ACLEC",CLASS,EXCOSIGN,DFN))
 S DATTIM=TIME1-.0000001
 F  S DATTIM=$O(@ROOT@(DATTIM)) Q:DATTIM'>0!(DATTIM>TIME2)  D
 . S DA=0 F  S DA=$O(@ROOT@(DATTIM,DA)) Q:DA'>0  D
 . . I +$G(^TIU(8925,+DA,0))'>0 K @ROOT@(DATTIM,DA) Q
 . . S TIUI=$S(SEQUENCE="D":+$G(TIUI)+1,1:+$G(TIUI)-1)
 . . Q:+$D(@TIUY@("INDX",DA))
 . . ; Selectively filter DELETED or RETRACTED records
 . . I +$P($G(^TIU(8925,DA,0)),U,5)>13,'+$$CANDO^TIULP(DA,"VIEW",DUZ) Q
 . . S @TIUY@(TIUI)=DA_U_$$RESOLVE(DA)
 . . S @TIUY@("INDX",DA,TIUI)=""
 . . Q:+$G(SHOWADD)=0
 . . S TIUP=+$$HASDAD^TIUSRVLI(DA) I TIUP D  D SETDAD^TIUSRVLI(.TIUY,DA,.TIUI,0)
 . . . N TIUPT
 . . . S TIUPT=$P($G(^TIU(8925,+DA,0)),"^",6)
 . . . I TIUPT]"",'$D(^TIU(8925,"DAD",TIUPT,DA)) S ^TIU(8925,"DAD",TIUPT,DA)=""
 . . . I TIUPT="" S TIUPT=$G(^TIU(8925,+DA,21))
 . . . I '$D(^TIU(8925,TIUPT,0)) S $P(@TIUY@(TIUI),"^",16)=1,$P(@TIUY@(TIUI),"^",14)=3 Q
 . . I +$$HASKIDS^TIUSRVLI(DA) D SETKIDS^TIUSRVLI(.TIUY,DA,.TIUI,0)
 Q
 ;
ACLSB(TIUY,CLASS,SIGNEDBY,DFN,TIME1,TIME2,SEQUENCE) ; Signed, by author
 N DATTIM,DA,ROOT,TIUI
 S ROOT=$NA(^TIU(8925,"ACLSB",CLASS,SIGNEDBY,DFN))
 S DATTIM=TIME1-.0000001
 F  S DATTIM=$O(@ROOT@(DATTIM)) Q:DATTIM'>0!(DATTIM>TIME2)  D
 . S DA=0 F  S DA=$O(@ROOT@(DATTIM,DA)) Q:DA'>0  D
 . . I +$G(^TIU(8925,+DA,0))'>0 K @ROOT@(DATTIM,DA) Q
 . . S TIUI=$S(SEQUENCE="D":+$G(TIUI)+1,1:+$G(TIUI)-1)
 . . Q:+$D(@TIUY@("INDX",DA))
 . . ; Selectively filter DELETED or RETRACTED records
 . . I +$P($G(^TIU(8925,DA,0)),U,5)>13,'+$$CANDO^TIULP(DA,"VIEW",DUZ) Q
 . . S @TIUY@(TIUI)=DA_U_$$RESOLVE(DA)
 . . S @TIUY@("INDX",DA,TIUI)=""
 . . Q:+$G(SHOWADD)=0
 . . I +$$HASDAD^TIUSRVLI(DA) D
 . . . S TIUP=+$$HASDAD^TIUSRVLI(DA) I TIUP D  D SETDAD^TIUSRVLI(.TIUY,DA,.TIUI,0)
 . . . N TIUPT
 . . . S TIUPT=$P($G(^TIU(8925,+DA,0)),"^",6)
 . . . I TIUPT]"",'$D(^TIU(8925,"DAD",TIUPT,DA)) S ^TIU(8925,"DAD",TIUPT,DA)=""
 . . . I TIUPT="" S TIUPT=$G(^TIU(8925,+DA,21))
 . . . I '$D(^TIU(8925,TIUPT,0)) S $P(@TIUY@(TIUI),"^",16)=1,$P(@TIUY@(TIUI),"^",14)=1 Q
 . . I +$$HASKIDS^TIUSRVLI(DA) D SETKIDS^TIUSRVLI(.TIUY,DA,.TIUI,0)
 Q
 ;
RESOLVE(DA) ; Resolve to external data
 N DOC,LOC,PT,AUT,EDT,TIUPT,TIULST4,TIUREC,TIUR0,TIUR12,TIUR13,TIUR14
 N TIUR17,STATUS,EDTCNT,LOCTYP,TIUADT,TIUDDT,PREFIX,IDPARENT,IDSORT
 S PREFIX=""
 S TIUR0=$G(^TIU(8925,+DA,0)),TIUR12=$G(^TIU(8925,+DA,12))
 S TIUR13=$G(^TIU(8925,+DA,13)),TIUR14=$G(^(14)),TIUR17=$G(^(17))
 S IDPARENT=+$G(^TIU(8925,+DA,21))
 S TIUPT=$G(^DPT(+$P(TIUR0,U,2),0))
 S DOC=$TR($$PNAME^TIULC1(+TIUR0),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S DOC=$$PNAME^TIULC1(+TIUR0)
 I DOC="Addendum" S DOC=DOC_" to "_$$PNAME^TIULC1(+$G(^TIU(8925,+$P(TIUR0,U,6),0)))
 ;
 ; If IDNotes (TIU*1.0*100) installed, use $$PREFIX^TIULA2 to evaluate
 ; which prefix to use:
 ; - keep prefix display in earlier CPRS versions and LM
 ; - omit in newer TreeView versions
 I $L($T(PREFIX^TIULA2)) D  I 1
 . S PREFIX=$$PREFIX^TIULA2(DA,1)  ; 1=include ID Child indicator
 . I PREFIX["<" S IDSORT=$$IDSORT(DA)
 . I +$G(SHOWADD)=0 S DOC=PREFIX_DOC
 ; otherwise, only show addendum indicator (+)
 ; - keep prefix display in earlier CPRS versions and LM
 ; - omit in newer TreeView versions
 E  D
 . I +$$HASADDEN^TIULC1(DA) S PREFIX="+ "
 . I +$G(SHOWADD)=0,(+$$HASADDEN^TIULC1(DA)) S DOC=PREFIX_DOC
 I +$$URGENCY^TIURM(+DA)=1 S DOC=$S(DOC["+":"*",1:"* ")_DOC
 S STATUS=$$LOWER^TIULS($P($G(^TIU(8925.6,+$P(TIUR0,U,5),0)),U))
 S LOC=$G(^SC(+$P(TIUR12,U,5),0)),LOCTYP=$P(LOC,U,3),LOC=$P(LOC,U)
 S TIUADT=$S(LOCTYP="W":"Adm: ",1:"Visit: ")_$$DATE^TIULS($P(TIUR0,U,7),"MM/DD/YY")
 S TIUDDT=$S(+$P(TIUR0,U,8):"Dis: ",1:"")_$$DATE^TIULS($P(TIUR0,U,8),"MM/DD/YY")
 I +$G(SHOWADD)>0 S TIUADT=TIUADT_";"_$P(TIUR0,U,7),TIUDDT=TIUDDT_";"_$P(TIUR0,U,8)
 S PT=$$NAME^TIULS($P(TIUPT,U),"LAST, FIRST MI")
 S TIULST4=$E($P(TIUPT,U,9),6,9)
 S TIULST4="("_$E(PT)_TIULST4_")"
 S AUT=+$P(TIUR12,U,2)
 S AUT=AUT_";"_$$SIGNAME^TIULS(+$P(TIUR12,U,2))_";"_$$GET1^DIQ(200,AUT,.01)
 S EDT=+TIUR13,EDTCNT=+$G(EDTCNT)+1
 S TIUREC=DOC_U_EDT_U_PT_" "_TIULST4_U_AUT_U_LOC_U_STATUS_U_TIUADT_U_TIUDDT_U_$P(TIUR14,U,5)_U_$$IMGCNT(DA)_U
 S TIUREC=TIUREC_$S($L(TIUR17):$E(TIUR17,1,(255-$L(TIUREC)))_U,1:U)
 S TIUREC=TIUREC_$P(PREFIX," ")_U
 S TIUREC=TIUREC_$S(+TIUR0=81:+$P(TIUR0,U,6),+IDPARENT:IDPARENT,+$G(CONTEXT):CONTEXT,1:1)_U_$G(IDSORT)
 Q $G(TIUREC)
IMGCNT(TIUDA) ; Get the number of images associated with a document
 N IMGDA,TIUI S (IMGDA,TIUI)=0
 F  S IMGDA=$O(^TIU(8925.91,"ADI",TIUDA,IMGDA)) Q:+IMGDA'>0  D
 . S TIUI=TIUI+1
 Q TIUI
IDSORT(TIUDA) ; Get ID Sort indicator when appropriate
 N TIUDPRM
 D DOCPRM^TIULC1(+$G(^TIU(8925,+TIUDA,0)),.TIUDPRM)
 Q +$P(TIUDPRM(0),U,18)
