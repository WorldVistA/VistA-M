IVMCM1 ;ALB/SEK,BRM,TDM - DCD INCOME TESTS UPLOAD DRIVER ; 2/9/06 1:57pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,49,71,115**;21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; this routine will call routines to upload means/copay/LTC test and
 ; income screening sent by the IVM Center (DCD).  the calling routine
 ; validated segment sequence.  entries will be added/modified in the
 ; following means test and patient files:
 ;
 ;       PATIENT RELATION (#408.12)
 ;       INCOME PERSON (#408.13)
 ;       INDIVIDUAL ANNUAL INCOME (#408.21)
 ;       INCOME RELATION (#408.22)
 ;       ANNUAL MEANS TEST (#408.31)
 ;       MEANS TEST CHANGES (#408.41)
 ;       PATIENT (#2)
 ;
 ; input:
 ;
 ; IVMTYPE test type 1-means 2-copay 3-income screening 4-LTC
 ; IVMMTIEN IEN of replaced test (408.31)
 ; IVMFLGC  # of dependent children
 ; IVMMTDT  dt of test
 ; DGLY income year
 ;
 ; ^TMP($J,"IVMCM",  contains data sent by IVM Center
 ;   3rd node "PIDV"
 ;            "ZICV"
 ;            "ZIRV"
 ;            "ZDPS"
 ;            "ZICS"
 ;            "ZIRS"
 ;           {"ZDPC",N
 ;            "ZICC",N
 ;            "ZIRC",N
 ;           }
 ;           {"ZDPIS",N}        Inactive Spouse Entries
 ;           {"ZDPIC",N}        Inactive Child Entries
 ;            "ZMT1"
 ;            "ZMT2"
 ;            "ZMT4"
 ;            "ZBT"  
 ;
 S:'$D(DUZ) DUZ=.5
 ;
 ; subscript of array IVMAR is 408.12 ien transmitted by IVM Center
 ; or created by upload. IVMAR2 is the array used to check for dup SSNs
 K IVMAR,IVMAR2
 ;
 ; New Edit Checks
 N IVMERR,OK2UPLD S IVMERR="",OK2UPLD=1
 D EN^IVMCMF(.IVMERR),PROB^IVMCMFB(,.IVMERR,0) Q:'OK2UPLD
 ;
 ; IVMHADJ indicates means test hardship/adjudication
 ; 1-adj 2-hardship 3-pending adj 0-not adj/hard
 I IVMTYPE=1 D
 .S IVMSEG=$G(^TMP($J,"IVMCM","ZMT1"))
 .S IVMHADJ=$S($P(IVMSEG,"^",13):2,$P(IVMSEG,"^",6)]"":1,$P(IVMSEG,"^",3)="P":3,1:0)
 ;
 S:IVMTYPE=3 DGMTI=""
 ;
 ; add new annual means test file (408.31) stub for Means test,
 ; RX Copay test, or Long Term Care test
 I "^1^2^4^"[("^"_IVMTYPE_"^") D
 .;
 .; input   DGMTDT (.01) dt of test
 .;         DFN (.02) Patient IEN
 .;         DGMTYPT (.19) type of test
 .; output  DGMTI annual means test IEN
 .S DGMTDT=IVMMTDT,DGMTYPT=IVMTYPE
 .D ADD^DGMTA
 .;
 .; change primary income test for year?
 .S DA=DGMTI,DIE="^DGMT(408.31,",DR="2////0"
 .D ^DIE K DA,DIE,DR
 ;
 D NEWVET^IVMCM3 Q:$D(IVMFERR)  ; if no entry in patient relation file for vet add
 ;
 ; get patient relation ien (#408.12) for vet, spouse, & child
 S IVMREQU=$P($G(^DG(408.32,+$P($G(^DGMT(408.31,IVMMTIEN,0)),"^",3),0)),"^",2)
 D GETREL^DGMTU11(DFN,"VSC",DGLY,$S($G(IVMMTIEN)&(IVMREQU'="R"):IVMMTIEN,1:0))
 ;
 ; add dependent(s) to income person file (408.13)
 ;
 ; add spouse if not in 408.13
 S IVMSPCHV="S" ; spouse/child/vet indicator
 S IVMSEG=$G(^TMP($J,"IVMCM","ZDPS")) ; spouse ZDP segment
 D INPIEN^IVMCM2
 Q:$D(IVMFERR)
 ;
 I IVMFLG5 G ADDCHILD ; entry not added - goto add children
 ;
 ; add entry to patient relation file (408.12)
 D EN^IVMCM3
 Q:$D(IVMFERR)
 ;
ADDS21 ; add spouse entry to individual annual income file (408.21)
 S IVMSEG=$G(^TMP($J,"IVMCM","ZICS")) ; spouse ZIC segment
 D EN^IVMCM4
 Q:$D(IVMFERR)
 ;
 ; add spouse entry to income relation file (408.22)
 S IVMSEG=$G(^TMP($J,"IVMCM","ZIRS")) ; spouse ZIR segment
 D EN^IVMCM5
 Q:$D(IVMFERR)
 ;
ADDCHILD ; add children if not in 408.13
 S IVMSPCHV="C" ; spouse/child/vet indicator
 I 'IVMFLGC G ADDV21 ; no dependent children 
 F IVMCTR3=1:1:IVMFLGC D  Q:$D(IVMFERR)
 .S IVMSEG=$G(^TMP($J,"IVMCM","ZDPC",IVMCTR3)) ; child ZDP segment
 .D INPIEN^IVMCM2
 .Q:$D(IVMFERR)
 .;
 .; add child entry to patient relation file (408.12)
 .D EN^IVMCM3
 .Q:$D(IVMFERR)
 .;
ADDC21 .; add child entry to individual annual income file (408.21)
 .S IVMSEG=$G(^TMP($J,"IVMCM","ZICC",IVMCTR3)) ; child ZIC segment
 .D EN^IVMCM4
 .Q:$D(IVMFERR)
 .;
 .; add entry to income relation file (408.22)
 .S IVMSEG=$G(^TMP($J,"IVMCM","ZIRC",IVMCTR3)) ; child ZIR segment
 .D EN^IVMCM5
 .Q:$D(IVMFERR)
 .Q
 Q:$D(IVMFERR)
 ;
ADDV21 ; add vet entry to individual annual income file (408.21)
 ; get vet patient relation ien
 S DGPRI=+$G(DGREL("V"))
 S IVMSEG=$G(^TMP($J,"IVMCM","ZICV")) ; vet ZIC segment
 S IVMSPCHV="V" ; spouse/child/vet indicator
 D EN^IVMCM4
 Q:$D(IVMFERR)
 S DGVINI=DGINI ; vet individual annual income ien
 ;
 ; add vet entry to income relation file (408.22)
 S IVMSEG=$G(^TMP($J,"IVMCM","ZIRV")) ; vet ZIR segment
 D EN^IVMCM5
 Q:$D(IVMFERR)
 S DGVIRI=DGIRI ; vet income relation ien
 ;
ADDINACT ; Process inactive ZDP's (ZDPIS & ZDPID entries)
 N ISEG,ICTR,IVMIDT,X,DA
 F ISEG="ZDPIS","ZDPIC" D  Q:$D(IVMFERR)
 . S ICTR=0
 . F  S ICTR=$O(^TMP($J,"IVMCM",ISEG,ICTR)) Q:(ICTR="")!($D(IVMFERR))  D
 . . S IVMSEG=$G(^TMP($J,"IVMCM",ISEG,ICTR)) Q:IVMSEG=""
 . . S IVMIDT=+$P(IVMSEG,"^",11)        ;dep inactivation date
 . . I $L(IVMIDT)<8 D  Q
 . . . S IVMTEXT(6)="Invalid dependent inactivation date"
 . . . D PROB^IVMCMC(IVMTEXT(6))
 . . . D ERRBULL^IVMPREC7,MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 . . . S IVMFERR=""
 . . S IVMIDT=$$FMDATE^HLFNC(IVMIDT)
 . . D INPIEN^IVMCM2 Q:$D(IVMFERR)           ;add if not in 408.13
 . . I IVMFLG2 D NEWPR^IVMCM3 Q:$D(IVMFERR)  ;add if not in 408.12
 . . S X=IVMIDT                              ;inactivation date
 . . S DA(1)=+DGPRI                          ;dependent 408.12 ien
 . . D INACT1^IVMCM5                         ;inactivate dependent
 ;
COMPLETE ; complete means test, copay test, or Long Term Care test
 ;
 D EN^IVMCM6
 ;
 ; cleanup
 K DGINI,DGIRI,DGMTDT,DGMTI,DGMTYPT,DGPRI,DGREL,DGVINI,DGVIRI
 K IVMAR,IVMCEB,IVMCTR3,IVMFERR,IVMFLG1
 K IVMFLG2,IVMFLG5,IVMHADJ,IVMMTB,IVMPRN
 K IVMRELN,IVMRELO,IVMREQU,IVMSEG,IVMSPCHV,IVMX
 Q
 ;
LTC ; transmission contains a long term care test (type 4)
 ;
 Q:'$P($G(^TMP($J,"IVMCM","ZMT4")),HLFS,2)
 I "^1^2^"[("^"_$G(IVMTYPE)_"^") N IVMTYPE
 S IVMTYPE=4,IVMFUTR=0
 S IVMMTDT=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT4")),HLFS,2))
 S TMSTAMP=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT4")),HLFS,25))
 S SOURCE=$P($G(^TMP($J,"IVMCM","ZMT4")),HLFS,22)
 S IVMLAST=$$LST^DGMTU(DFN,$E(IVMMTDT,1,3)_1231,4)
 S IVMMTIEN=+IVMLAST  ;last LTC test
 ;deletion indicator sent?
 I $P($G(^TMP($J,"IVMCM","ZMT4")),HLFS,3)=HLQ D  Q
 .Q:('IVMMTIEN)
 .S NODE0=$G(^DGMT(408.31,IVMMTIEN,0))
 .I $$EN^IVMCMD(IVMMTIEN) D
 ..S RET=$$LST^DGMTU(DFN,DT,IVMTYPE)
 ..S CODE=$S(($E($P(RET,"^",2),1,3)=$E(DT,1,3)):$P(RET,"^",4),1:"")
 ..D ADD^IVMCMB(DFN,IVMTYPE,"DELETE LONG TERM CARE TEST",+$G(NODE0),$$GETCODE^DGMTH($P(NODE0,"^",3)),CODE)
 ;
 ;check date/time last edited, test date and source - if they match current test then this is a duplicate and does not need to be uploaded
 N NODE0,NODE2
 S NODE2=$G(^DGMT(408.31,IVMMTIEN,2)),NODE0=$G(^(0))
 I TMSTAMP,TMSTAMP=$P(NODE2,"^",2),IVMMTDT=$P(NODE0,"^"),SOURCE=$P(NODE2,"^",5) Q
 ;
 D DELTYPE^IVMCMD(DFN,IVMMTDT,4)
 I $P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,2)!($P($G(^TMP($J,"IVMCM","ZMT2")),HLFS,2)) D  Q
 .S DGMTDT=IVMMTDT,DGMTYPT=IVMTYPE
 .D ADD^DGMTA
 .D COMPLETE^IVMCM1
 D EN^IVMCM1
 Q
