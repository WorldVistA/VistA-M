SCAPMR21        ;ALB/REW/PDR - Position Reasignment ; AUG 1998
 ;;5.3;Scheduling;**148,157**;AUG 13, 1993
 ;
ACPTATP(DFNA,SCTPTO,SCTPFRM,SCFIELDA,SCACT,SCERR,SCYESTM,SCMAINA,SCNEWTP,SCNEWTM,SCOLDTP,SCBADTP) ;list of patients to a position (pt TP assgn - #404.43 and possibly #404.42
 ; input: 
 ;    DFNA    = is the literal value of a patient array (e.g. "scpt"
 ;              there is at least one scpt(dfn)="" defined
 ;    SCTPTO  = IEN of Position reasigned "to" ptr to 404.57
 ;    SCTPFRM = IEN of position reasigned "from" ptr to 404.57
 ;    SCNEWTP = Subset of DFNA that was NEWLY assigned to a Position
 ;    SCNEWTM = Subset of DFNA that was NEWLY assigned to a Team
 ;    SCOLDTP = Subset of DFNA that was already assigned to Position
 ;    SCBADTP = Subset of DFNA that was NOT assigned to Position
 ; output: Count of Patients (New or Old) assigned to Position
 N DFN,SCCNT,SCX,SCNOMAIL,FASIEN
 S SCNOMAIL=1
 S SCCNT=0
 S DFN=0
 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 . S FASIEN=@DFNA@(DFN) ; get the "FROM" position Assignment
 . S SCX=$$ACPTTP^SCRPMPSP(.DFN,.SCTPTO,.SCFIELDA,.SCACT,FASIEN,SCERR,.SCYESTM,"SCMAIN")
 . ;  SCX = ien of 404.43^new?^404.42 ien (new entries only)^new?
 . IF $P(SCX,U,2) D  ;newly assigned
 .. S SCCNT=SCCNT+1
 .. S @SCNEWTP@(DFN)=+SCX   ;scnewtp
 .. S:$P(SCX,U,4) @SCNEWTM@(DFN)=$P(SCX,U,3)  ;scnewtm
 . IF $P(SCX,U,1)&('$P(SCX,U,2)) D  ;old
 .. S SCCNT=SCCNT+1
 .. S @SCOLDTP@(DFN)=+SCX
 . IF 'SCX D
 .. S @SCBADTP@(DFN)=$P(SCX,U,5)
 K SCNOMAIL
 ;D MAILLST^SCMCTPM(SCTPTO,.SCADDFLD,DT,.SCNEWTP,.SCOLDTP,.SCBADTP)
 D MAILLST^SCMRTPM(SCTPTO,.SCADDFLD,DT,.SCBADTP,SCTPFRM) ; report errors only
 Q SCCNT
 ;
