PXAPIOE ;ALB/MJK,ESW - Supported References for ACRP ; 12/5/02 11:27am
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**39,73,108**;Aug 12, 1996
 ;
 ;
CPT(PXVIEN,PXERR) ; -- at least one cpt for visit??
 ;
 N PXOK
 S PXOK=0
 ;
 ; -- do validation checks
 IF '$$VALVST(PXVIEN,$G(PXERR)) G CPTQ
 ;
 S PXOK=($O(^AUPNVCPT("AD",PXVIEN,0))>0)
CPTQ Q PXOK
 ;
 ;
GETCPT(PXVIEN,PXCPT,PXERR) ; -- get cpt's for visit
 ;
 ; -- do validation checks
 IF '$$VALVST(PXVIEN,$G(PXERR)) G GETCPTQ
 ;
 N I,CNT S (I,CNT)=0 F  S I=$O(^AUPNVCPT("AD",PXVIEN,I)) Q:'I  D
 . IF $D(^AUPNVCPT(I,0)) S @PXCPT@(I)=^(0),CNT=CNT+1
 S @PXCPT=CNT
GETCPTQ Q
 ;
CPTARR(PXVIEN,PXCPT,PXERR) ;+API to return all CPT data for a visit.
 N IEN,CNT
 S (IEN,CNT)=0
 Q:'$$VALVST(PXVIEN,$G(PXERR))
 F  S IEN=$O(^AUPNVCPT("AD",PXVIEN,IEN)) Q:'IEN  D
 . Q:'$D(^AUPNVCPT(IEN))
 . M @PXCPT@(IEN)=^AUPNVCPT(IEN)
 . S CNT=CNT+1
 S @PXCPT=CNT
 Q
 ;
DX(PXVIEN,PXERR) ; -- at least one dx for visit??
 ;
 N PXOK
 S PXOK=0
 ;
 ; -- do validation checks
 IF '$$VALVST(PXVIEN,$G(PXERR)) G DXQ
 ;
 S PXOK=($O(^AUPNVPOV("AD",PXVIEN,0))>0)
DXQ Q PXOK
 ;
 ;
GETDX(PXVIEN,PXDX,PXERR) ; -- get dx's for visit
 ;
 ; -- do validation checks
 IF '$$VALVST(PXVIEN,$G(PXERR)) G GETDXQ
 ;
 N I,CNT S (I,CNT)=0 F  S I=$O(^AUPNVPOV("AD",PXVIEN,I)) Q:'I  D
 . IF $D(^AUPNVPOV(I,0)) S @PXDX@(I)=^(0),CNT=CNT+1
 S @PXDX=CNT
GETDXQ Q
 ;
 ;
PRV(PXVIEN,PXERR) ; -- at least one provider for visit?
 ;
 N PXOK
 S PXOK=0
 ;
 ; -- do validation checks
 IF '$$VALVST(PXVIEN,$G(PXERR)) G PRVQ
 S PXOK=($O(^AUPNVPRV("AD",PXVIEN,0))>0)
PRVQ Q PXOK
 ;
 ;
GETPRV(PXVIEN,PXPRV,PXERR) ; -- get provider's for visit;108
 ;
 ; -- do validation checks
 IF '$$VALVST(PXVIEN,$G(PXERR)) G GETPRVQ
 ;
 ;PX*1*108;look for duplicates to exclude them
 N I,CNT,PR,PRS,PS,PP,PRV
 S (I,CNT)=0 F  S I=$O(^AUPNVPRV("AD",PXVIEN,I)) Q:'I  D
 .IF $D(^AUPNVPRV(I,0)) D
 ..S @PXPRV@(I)=^(0),PR=+@PXPRV@(I),PS=$P(@PXPRV@(I),U,4)
 ..IF PS="P" D
 ...I 'CNT S PRV=PR,CNT=1 Q
 ...I PR=PRV K @PXPRV@(I)
 ..I PS="S" S PRS(PR,I)=""
 S PR="" F  S PR=$O(PRS(PR)) Q:PR=""  S I="" D
 .F PP=1:1 S I=$O(PRS(PR,I)) Q:I=""  D
 ..I PR=$G(PRV) K @PXPRV@(I) Q
 ..I PP>1 K @PXPRV@(I)
 ..E  S CNT=CNT+1
 S @PXPRV=CNT
GETPRVQ Q
 ;
 ;
VALVST(PXVIEN,PXERR) ; -- validate visit ien input
 ;
 ; -- do checks
 IF PXVIEN,$D(^AUPNVSIT(PXVIEN,0)) Q 1
 ;
 ; -- build error msg
 N PXIN,PXOUT
 S PXIN("ID")=PXVIEN
 S PXOUT("ID")=PXVIEN
 D BLD^DIALOG(1509000.001,.PXIN,.PXOUT,$G(PXERR),"F")
 Q 0
 ;
 ;
POST ; -- post error action logic
 ;ZW DO
 ;ZW DIPI
 ;ZW DIPE
 Q
 ;
 ;
PDX(VSTPOV,RANK) ; -- set primary dx for V POV entry
 ;
 N VSTRT,VSTSEQ
 N VSTIEN,X
 ;
 ; -- set up structures
 D INIT(.VSTRT,.VSTSEQ)
 ;
 ; -- set up visit
 S X=$G(^AUPNVPOV(VSTPOV,0))
 S VSTIEN=+$P(X,U,3)
 D VNODES(VSTIEN,VSTRT,VSTSEQ)
 ;
 ; -- set up dx
 D DXNODES(VSTPOV,VSTRT,VSTSEQ)
 S $P(@VSTRT@("POV",1,0,"AFTER"),U,12)=RANK
 ;
 ; -- file change and kill
 D FINAL(VSTRT)
 Q
 ;
 ;
PCLASS(VSTPRV) ; -- set provider class for V PRV entry
 ;
 N VSTRT,VSTSEQ
 N VSTIEN,X
 ;
 ; -- set up structures
 D INIT(.VSTRT,.VSTSEQ)
 ;
 ; -- set up visit
 S X=$G(^AUPNVPRV(VSTPRV,0))
 S VSTIEN=+$P(X,U,3)
 D VNODES(VSTIEN,VSTRT,VSTSEQ)
 ;
 ; -- set up provider ; pxkmain will automatically set class
 D PRVNODES(VSTPRV,VSTRT,VSTSEQ)
 ;
 ; -- file change and kill
 D FINAL(VSTRT)
 Q
 ;
 ;
INIT(VSTRT,VSTSEQ) ; -- set up structures
 S VSTRT=$NA(^TMP("PXK",$J))
 S VSTSEQ=1
 K @VSTRT
 S @VSTRT@("SOR")=$O(^PX(839.7,"B","PIMS",0))
 Q
 ;
 ;
FINAL(VSTRT) ; -- file data and clean up
 N PXKNOEVT
 S PXKNOEVT=1
 D EN1^PXKMAIN
 K @VSTRT
 Q
 ;
 ;
VNODES(VSTIEN,VSTRT,VSTSEQ) ; -- get visit nodes
 N NODE,X
 S @VSTRT@("VST",VSTSEQ,"IEN")=VSTIEN
 F NODE=0,21,150,800,811,812 D
 . S X=$G(^AUPNVSIT(VSTIEN,NODE))
 . S @VSTRT@("VST",VSTSEQ,NODE,"BEFORE")=X
 . S @VSTRT@("VST",VSTSEQ,NODE,"AFTER")=X
 Q
 ;
 ;
DXNODES(VSTPOV,VSTRT,VSTSEQ) ; -- get dx nodes
 N NODE,X
 S @VSTRT@("POV",VSTSEQ,"IEN")=VSTPOV
 F NODE=0,12,812 D
 . S X=$G(^AUPNVPOV(VSTPOV,NODE))
 . S @VSTRT@("POV",VSTSEQ,NODE,"BEFORE")=X
 . S @VSTRT@("POV",VSTSEQ,NODE,"AFTER")=X
 Q
 ;
 ;
PRVNODES(VSTPRV,VSTRT,VSTSEQ) ; -- get provider nodes
 N NODE,X
 S @VSTRT@("PRV",VSTSEQ,"IEN")=VSTPRV
 F NODE=0,12,812 D
 . S X=$G(^AUPNVPRV(VSTPRV,NODE))
 . S @VSTRT@("PRV",VSTSEQ,NODE,"BEFORE")=X
 . S @VSTRT@("PRV",VSTSEQ,NODE,"AFTER")=X
 Q
 ;
