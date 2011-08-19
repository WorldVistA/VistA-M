TIUQRYL ; SLC/JER - Library calls for Query ;11-OCT-2002 16:56
 ;;1.0;TEXT INTEGRATION UTILITIES;**150**;Jun 20, 1997
RESOLVE(TIUY,DA,QRY,PATIENT) ; Resolve to external data
 N TIUR0,TIUR12,TIUR13,TIUR14,TIUR17,TIUR150
 N IDPARENT,DOC
 S TIUR0=$G(^TIU(8925,+DA,0)),TIUR12=$G(^TIU(8925,+DA,12))
 S TIUR13=$G(^TIU(8925,+DA,13)),TIUR14=$G(^(14)),TIUR17=$G(^(17))
 S TIUR150=$G(^TIU(8925,+DA,150))
 S IDPARENT=+$G(^TIU(8925,+DA,21))
 M @TIUY@("DOC:"_DA)=PATIENT
 S (DOC,@TIUY@("DOC:"_DA,"Document.Title"))=$$PNAME^TIULC1(+TIUR0)
 S:DOC="Addendum" @TIUY@("DOC:"_DA,"Document.Title")=DOC_" to "_$$PNAME^TIULC1(+$G(^TIU(8925,+$P(TIUR0,U,6),0)))
 ; ** If prefix becomes an issue, remove comments and finish implementation **
 ; If IDNotes (TIU*1.0*100) installed, use $$PREFIX^TIULA2 to evaluate
 ; which prefix to use:
 ; - keep prefix display in earlier CPRS versions and LM
 ; - omit in newer TreeView versions
 ;I $L($T(PREFIX^TIULA2)) D  I 1
 ;. S PREFIX=$$PREFIX^TIULA2(DA,1)  ; 1=include ID Child indicator
 ;. I PREFIX["<" S IDSORT=$$IDSORT^TIUSRVLO(DA)
 ;. I +$G(SHOWADD)=0 S DOC=PREFIX_DOC
 ; otherwise, only show addendum indicator (+)
 ; - keep prefix display in earlier CPRS versions and LM
 ; - omit in newer TreeView versions
 ;E  D
 ;. I +$$HASADDEN^TIULC1(DA) S PREFIX="+ "
 ;. I +$G(SHOWADD)=0,(+$$HASADDEN^TIULC1(DA)) S DOC=PREFIX_DOC
 ;I +$$URGENCY^TIURM(+DA)=1 S DOC=$S(DOC["+":"*",1:"* ")_DOC
 ; **
 S @TIUY@("DOC:"_DA,"Document.Reference")=+TIUR13
 S @TIUY@("DOC:"_DA,"Document.Status")=$$LOWER^TIULS($P($G(^TIU(8925.6,+$P(TIUR0,U,5),0)),U))
 S @TIUY@("DOC:"_DA,"Document.Author")=$S(+$P(TIUR12,U,2):$$PERSNAME^TIULC1($P(TIUR12,U,2)),1:"")
 S @TIUY@("DOC:"_DA,"Document.Cosigner")=$S(+$P(TIUR12,U,8):$$PERSNAME^TIULC1($P(TIUR12,U,8)),1:"")
 Q
 ;
SETDAD(TIUY,DA,QRY,PATIENT) ; Set parent in return array
 N DADA,TIUD0,TIUD21
 ; Exclude components
 Q:'+$$ISDOC(DA)
 S TIUD0=$G(^TIU(8925,DA,0)),TIUD21=$G(^(21))
 S DADA=$S(+$P(TIUD0,U,6):+$P(TIUD0,U,6),+TIUD21:+TIUD21,1:0)
 Q:+DADA'>0
 Q:+$D(@TIUY@("INDX",DADA))
 Q:+$D(^TIU(8925,DADA,0))=0
 D RESOLVE(TIUY,DADA,.QRY,.PATIENT)
 S @TIUY@("INDX",DADA)=""
 I +$G(SHOWADD) D SETKIDS(TIUY,DADA,.QRY,.PATIENT)
 I +$$HASDAD^TIUSRVLI(DADA) D SETDAD(TIUY,DADA,.QRY,.PATIENT)
 Q
 ;
SETKIDS(TIUY,DA,QRY,PATIENT) ; Set children in return array
 N KIDA S KIDA=0
 ; Begin with addenda
 F  S KIDA=$O(^TIU(8925,"DAD",DA,KIDA)) Q:+KIDA'>0  D
 . Q:'+$$ISDOC(KIDA)
 . Q:+$D(@TIUY@("INDX",KIDA))
 . D RESOLVE(TIUY,KIDA,.QRY,.PATIENT)
 . S @TIUY@("INDX",KIDA)=""
 ; Next do ID entries
 S KIDA=0
 F  S KIDA=$O(^TIU(8925,"GDAD",DA,KIDA)) Q:+KIDA'>0  D
 . Q:+$D(@TIUY@("INDX",KIDA))
 . D RESOLVE(TIUY,KIDA,.QRY,.PATIENT)
 . S @TIUY@("INDX",KIDA)=""
 . I +$$HASKIDS^TIUSRVLI(KIDA) D SETKIDS(TIUY,KIDA,.QRY,.PATIENT)
 Q
ISDOC(DA) ; Evaluate whether a given record is a document
 N TIUY,TIUTYP
 S TIUTYP=+$G(^TIU(8925,DA,0))
 S TIUY=$S($P($G(^TIU(8925.1,+TIUTYP,0)),U,4)="DOC":1,1:0)
 Q TIUY
