ORWDXQ ; SLC/KCM - Utilities for Quick Orders;06:18 PM  27 Apr 1998
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,245**;Dec 17, 1997;Build 2
 ;
DLGNAME(VAL,INAME)      ; Return display name for a dialog (DELETE??)
 N IEN S IEN=$O(^ORD(101.41,"B",INAME,0))
 S VAL=$P($G(^ORD(101.41,IEN,5)),U,4)
 Q
DLGSAVE(VAL,CRC,DNAME,DGRP,RSP)    ; Return IEN of new or existing quick order
 N ROOT,NM,IEN
 S ROOT="ORWDQ "_CRC,VAL=0,IEN=+$O(^ORD(101.41,"B",ROOT,0))
 I IEN=0 D SAVENEW(.VAL,ROOT,DNAME,DGRP,.RSP) I 1
 E  I $$MATCH(IEN,DGRP,.RSP) S VAL=IEN I 1
 E  D
 . D UPDQNAME^ORCMEDT8(IEN)
 . S ROOT=$$ENSURNEW^ORCMEDT8(ROOT)
 . D SAVENEW(.VAL,ROOT,DNAME,DGRP,.RSP)
 Q
OLDELSE E  D  ; this creates other entries if CRC matches...
 . S NM=ROOT
 . F  S NM=$O(^ORD(101.41,"B",NM)) Q:$E(NM,1,$L(ROOT))'=ROOT  D
 . . S IEN=0 F  S IEN=$O(^ORD(101.41,"B",ROOT,0)) Q:IEN'>0  D  Q:VAL
 . . . I $$MATCH(IEN,DGRP,RSP) S VAL=IEN
 . . I 'VAL D                         ; new entry by same CRC (rare!)
 . . . F I=1:1 I '$D(^ORD(101.41,"B",ROOT_" "_I)) Q
 . . . D SAVENEW(VAL,ROOT_" "_I,DNAME,DGRP,RSP)
 Q
MATCH(IEN,DGRP,RSP)     ; Called by DLGSAVE
 ; Return true if the responses passed in match dialog
 I $P(^ORD(101.41,IEN,0),U,5)'=DGRP Q 0  ; display group must match
 N TST,RSLT,DLG,INST,VAL,I,J,L
 S RSLT=1 M TST=RSP
 S I=0 F  S I=$O(^ORD(101.41,IEN,6,I)) Q:'I  D  Q:'RSLT
 . S DLG=$P(^ORD(101.41,IEN,6,I,0),U,2),INST=$P(^(0),U,3)
 . S VAL="ORDIALOG(""WP"","_DLG_","_INST_")"
 . I $D(^ORD(101.41,IEN,6,I,1)) S VAL=^(1)
 . I '$D(TST(DLG,INST)) S RSLT=0 Q
 . I TST(DLG,INST)'=VAL S RSLT=0 Q
 . I $D(^ORD(101.41,IEN,6,I,2))>1 D  Q:'RSLT
 . . N A,B,JMAX
 . . S (J,L)=0 F  S L=$O(^ORD(101.41,IEN,6,I,2,L)) Q:'L  S J=J+1,A(J)=^(L,0)
 . . S JMAX=J
 . . S (J,L)=0 F  S L=$O(TST("WP",DLG,INST,L)) Q:'L  S J=J+1,B(J)=TST("WP",DLG,INST,L,0)
 . . I JMAX'=J S RSLT=0 Q
 . . S J=0 F  S J=$O(A(J)) Q:'J  S:A(J)'=$G(B(J)) RSLT=0  Q:'RSLT  K A(J),B(J)
 . . I ($D(A)>1)!($D(B)>1) S RSLT=0
 . . K TST("WP",DLG,INST)
 . K TST(DLG,INST)
 I $D(TST)>1 S RSLT=0
 Q RSLT
SAVENEW(ORQDLG,INM,DTX,DG,ORDIALOG)   ; Called by DLGSAVE
 ; save the entries in ORDIALOG as a new quick order
 ; INM=.01 name, DTX=display text, DGR=display group
 S ORQDLG=0,ORDIALOG=$$DEFDLG(DG) Q:'ORDIALOG
 D GETDLG1^ORCD(ORDIALOG)
 N FDA,FDAIEN,DIERR,ORDG
 S FDA(101.41,"+1,",.01)=INM
 S FDA(101.41,"+1,",2)=DTX
 S FDA(101.41,"+1,",4)="Q"
 S FDA(101.41,"+1,",5)=DG
 D UPDATE^DIE("","FDA","FDAIEN")
 S ORQDLG=FDAIEN(1)
 D SAVE^ORCMEDT1
 Q
DEFDLG(DG)    ; Return IEN of default dialog for display group
 N DLG,DAD S DLG=+$P($G(^ORD(100.98,DG,0)),U,4)
 I 'DLG S DAD=$O(^ORD(100.98,"AD",DG,0)) I DAD S DLG=$$DEFDLG(DAD)
 Q DLG
GETQLST(LST,DGRP,PRE)        ; Return quick list for a display group
 N LVW,ILST,I,X0
 S PRE=$G(PRE),ILST=0
 D QV4DG^ORWUL(.LVW,DGRP) S LVW=+LVW Q:'LVW
 S I=0 F  S I=$O(^ORD(101.44,LVW,10,I)) Q:'I  D
 . S X0=$G(^ORD(101.44,LVW,10,I,0))
 . I $P($G(^ORD(101.41,+X0,0)),U,3)]"" Q  ; quick order is disabled
 . S ILST=ILST+1,LST(ILST)=PRE_X0
 Q
 ;N DNAM,DLG,I,ILST,X
 ;S ILST=0,X="ORWDQ "_$S(+DGRP:$P(^ORD(100.98,DGRP,0),U,3),1:DGRP),PRE=$G(PRE)
 ;D GETLST^XPAR(.TMP,"ALL",X,"N")
 ;S I=0 F  S I=$O(TMP(I)) Q:'I  S DLG=+TMP(I) I +DLG D
 ;. S DNAM=$$GET^XPAR(DUZ_";VA(200,","ORWDQ DISPLAY NAME",DLG,"I")
 ;. I '$L(DNAM) S DNAM=$P(^ORD(101.41,DLG,0),U,2)
 ;. I $P($G(^ORD(101.41,DLG,0)),U,3)]"" Q  ; quick order is disabled
 ;. S ILST=ILST+1,LST(ILST)=PRE_DLG_U_DNAM
 ;Q
PUTQLST(VAL,DG,QLST)  ; Save quick list
 N PNM
 S PNM="ORWDQ USR"_DUZ_" "_$P(^ORD(100.98,DG,0),U,3)
 D QVSAVE^ORWUL(.VAL,PNM,.QLST)
 D EN^XPAR(DUZ_";VA(200,","ORWDQ QUICK VIEW","`"_DG,PNM)
 Q
 ;N PNM,USER,I,DLG,QNM,CUR
 ;S PNM="ORWDQ "_$P(^ORD(100.98,DG,0),U,3),USER=DUZ_";VA(200,"
 ;D NDEL^XPAR(USER,PNM) ; remove all instances for this quick list
 ;S I=0 F  S I=$O(QLST(I)) Q:'I  D ADD^XPAR(USER,PNM,I,"`"_+QLST(I))
 ;S I=0 F  S I=$O(QLST(I)) Q:'I  D
 ;. S DLG=+QLST(I),QNM=$P(QLST(I),U,2)
 ;. S CUR=$$GET^XPAR(USER,"ORWDQ DISPLAY NAME",DLG,"I")
 ;. I QNM=CUR Q
 ;. I CUR="",(QNM=$P($G(^ORD(101.41,DLG,0)),U,2)) Q
 ;. D EN^XPAR(USER,"ORWDQ DISPLAY NAME","`"_DLG,QNM)
 ;Q
GETQNAM(VAL,CRC)    ; Return current quick name
 N ROOT S ROOT="ORWDQ "_CRC,VAL=""
 I '$D(^ORD(101.41,"B",ROOT)) Q
 S DLG=$O(^ORD(101.41,"B",ROOT,0))
 ; S VAL=$$GET^XPAR(DUZ_";VA(200,","ORWDQ DISPLAY NAME",DLG,"I")
 I '$L(VAL) S VAL=$P($G(^ORD(101.41,DLG,0)),U,2)
 Q
PUTQNAM(VAL,DLG,QNAM)   ; Save display name for a quick order dialog
 ; see if DLG used QNAM as display text (quit if so)
 ; otherwise save in ORWDQ DISPLAY NAME
 Q
