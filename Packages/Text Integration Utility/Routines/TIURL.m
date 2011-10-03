TIURL ; SLC/JER - List Management Library ;2/21/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**88,100,224**;Jun 20, 1997;Build 7
 ; 11/14/00 Moved UPDATEID, etc to TIURL1
 ;
UPRBLD(TIUCHNG,ITEMS) ; Refreshes, updates, or rebuilds the list
 ;after various actions. Also restores video.
 ; Receives optional arrays TIUCHNG, ITEMS by ref.
 ; Checks TIUCHNG("RBLD"),TIUCHNG("UPDATE"), & TIUCHNG("REFRESH");
 ;does nothing if none of these is defined.
 ; Items in ITEMS list are updated (depending on TIUCHNG), and
 ;their video attributes are restored.
 N TIUI,TIUREC,TIUJ,RTN
 S RTN=$G(^TMP("TIUR",$J,"RTN"))
 ; -- Restore video attributes for selected items:
 ;    (Rebuild code, except for TIUROR, does its own video restore)
 I '$G(TIUCHNG("RBLD"))!(RTN="TIUROR") D
 . S TIUJ=0
 . F  S TIUJ=$O(ITEMS(TIUJ)) Q:'TIUJ  D
 . . Q:TIUJ=$P($G(TIUGLINK),U,2)  ; Don't restore midattach ID child
 . . D RESTORE^VALM10(TIUJ)
 ; -- If TIUROR screen needs changes, it is always
 ;    rebuilt, not updated:
 I RTN="TIUROR",$G(TIUCHNG("UPDATE")) S TIUCHNG("RBLD")=1
 ;VMP/ELR ADDED THE FOLLOWING 2 LINES IN PATCH 224
 I RTN="TIUR",$G(TIUCHNG("UPDATE")) S TIUCHNG("RBLD")=1
 I RTN="TIURM",$G(TIUCHNG("UPDATE")) S TIUCHNG("RBLD")=1
 ; -- Rebuild, Update, or Refresh list:
 ;    (In cases (e.g.browse) where more than one action
 ;    was performed, TIUCHNG("RBLD") may coexist w TIUCHNG("UPDATE"),
 ;    etc., so order is important.)
 I $G(TIUCHNG("RBLD")) D  Q
 . W !,"Rebuilding the list..."
 . I RTN="TIUROR" D RBLD^TIUROR Q
 . ; -- If not in 2b, pause for feedback ("Rebuilding",
 . ;    "Entry deleted", etc):
 . H 2
 . I RTN="TIURM" D RBLD^TIURM Q
 . I RTN="TIURPTTL" D RBLD^TIURPTTL Q
 . I RTN="TIURTITL" D RBLD^TIURTITL Q
 . I RTN="TIUR" D RBLD^TIUR
 I $G(TIUCHNG("UPDATE")),$D(ITEMS) D  Q
 . S TIUI=""
 . W !,"Updating the list..."
 . F  S TIUI=$O(ITEMS(TIUI)) Q:'TIUI  D
 . . D SETREC(TIUI,.TIUREC)
 . . ;VMP/ELR ADDED THE FOLLOWING LINE IN PATCH 224
 . . I $G(TIUREC)="" Q
 . . S ^TMP("TIUR",$J,TIUI,0)=TIUREC
 I $G(TIUCHNG("REFRESH")) D  Q
 . W !,"Refreshing the list..."
 Q
 ;
SETREC(LINENO,TIUREC,PFIXFLAG) ; Update line LINENO with [new prefix], new flds
 ; Combined fields so that SETREC works for MIS as well as
 ;CLINICIAN LM templates
 ; PFIXFLAG=1: update prefix (as well as other flds).
 ; New prefix is for unexpanded state of line.
 N DIC,DIQ,DA,DR,TIUR,ADT,DDT,LCT,AUT,AMD,EDT,SDT,TIULST4
 N MOM,DOC,MISEDT,ITEMNODE
 S ITEMNODE=^TMP("TIURIDX",$J,LINENO)
 S DA=+$P(ITEMNODE,U,2)
 S DIQ="TIUR",DIC=8925,DIQ(0)="IE"
 S DR=".01;.02;.05;.07;.08;.1;1202;1204;1208;1209;1301;1307;1501;1507"
 D EN^DIQ1 Q:$D(TIUR)'>9
 S DOC=$$PNAME^TIULC1(+TIUR(8925,DA,.01,"I"))
 I DOC="Addendum" D
 . S MOM=+$P(^TIU(8925,DA,0),U,6)
 . S DOC=DOC_" to "_$$PNAME^TIULC1(+$G(^TIU(8925,MOM,0)))
 S TIULST4=$E($P($G(^DPT(TIUR(8925,DA,.02,"I"),0)),U,9),6,9)
 S TIULST4="("_$E(TIUR(8925,DA,.02,"E"))_TIULST4_")"
 S ADT=$$DATE^TIULS(TIUR(8925,DA,.07,"I"),"MM/DD/YY")
 S DDT=$$DATE^TIULS(TIUR(8925,DA,.08,"I"),"MM/DD/YY")
 S AMD=$$NAME^TIULS(TIUR(8925,DA,1208,"E"),"LAST, FI MI")
 S AUT=$$NAME^TIULS(TIUR(8925,DA,1202,"E"),"LAST, FI MI")
 S EDT=$$DATE^TIULS(TIUR(8925,DA,1301,"I"),"MM/DD/YY")
 S MISEDT=$$DATE^TIULS(TIUR(8925,DA,1307,"I"),"MM/DD/YY")
 S SDT=$S(+TIUR(8925,DA,1507,"I"):TIUR(8925,DA,1507,"I"),TIUR(8925,DA,.05,"I")'<7:+TIUR(8925,DA,1501,"I"),1:"")
 S SDT=$$DATE^TIULS(SDT,"MM/DD/YY")
 S LCT=$G(TIUR(8925,DA,.1,"E"))
 ; -- Set prefix_patient/title into ^TMP("TIUR",$J,LINENO,0),
 ;    then into TIUREC: --
 I $G(PFIXFLAG) D SETPT^TIURL1(LINENO)
 S TIUREC=^TMP("TIUR",$J,LINENO,0)
 ; -- Set other fields into TIUREC: --
 S TIUREC=$$SETFLD^VALM1(LINENO,TIUREC,"NUMBER")
 S TIUREC=$$SETFLD^VALM1($$LOWER^TIULS(TIUR(8925,DA,.05,"E")),TIUREC,"STATUS")
 S TIUREC=$$SETFLD^VALM1(TIULST4,TIUREC,"LAST I/LAST 4")
 S TIUREC=$$SETFLD^VALM1(DOC,TIUREC,"DOCUMENT TYPE")
 S:$D(VALMDDF("ADMISSION DATE")) TIUREC=$$SETFLD^VALM1(ADT,TIUREC,"ADMISSION DATE")
 S:$D(VALMDDF("DISCH DATE")) TIUREC=$$SETFLD^VALM1(AMD,TIUREC,"DISCH DATE")
 S:$D(VALMDDF("DICT DATE")) TIUREC=$$SETFLD^VALM1(MISEDT,TIUREC,"DICT DATE")
 S:$D(VALMDDF("LINE COUNT")) TIUREC=$$SETFLD^VALM1(LCT,TIUREC,"LINE COUNT")
 S:$D(VALMDDF("REF DATE")) TIUREC=$$SETFLD^VALM1(EDT,TIUREC,"REF DATE")
 S:$D(VALMDDF("SIG DATE")) TIUREC=$$SETFLD^VALM1(SDT,TIUREC,"SIG DATE")
 S TIUREC=$$SETFLD^VALM1(AUT,TIUREC,"AUTHOR")
 S:$D(VALMDDF("COSIGNER")) TIUREC=$$SETFLD^VALM1(AMD,TIUREC,"COSIGNER")
 S:$D(VALMDDF("ATTENDING")) TIUREC=$$SETFLD^VALM1(AMD,TIUREC,"ATTENDING")
 S ^TMP("TIUR",$J,LINENO,0)=TIUREC
 Q
