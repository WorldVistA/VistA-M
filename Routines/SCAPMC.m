SCAPMC ;ALB/REW - Team API's ; 6/21/99 2:31pm
 ;;5.3;Scheduling;**41,177**;AUG 13, 1993
 ;;1.0
 ; ** This is the main calling routine for the PCMM (Managed Care) APIs
 ; ** More detailed comments are included with the called routines
 ;
 ;  (1) Position Lists
 ;  (2) Practitioner Lists
 ;  (3) Patient Lists
 ;  (4) Team Lists
 ;  (5) MailMan Message Recipient Lists
 ;  (6) Database Updates
 ;  (7) Other
 ;
 ;  ** Note: Most of these calls are not supported.  Calls supported
 ;           for all programmers are indicated as **SUPPORTED**
 ;
 ;  (1) ------------- Position Lists --------------------------------
TPPR(SC200,SCDATES,SCPURPA,SCROLEA,SCLIST,SCERR) ; -- positions for a practitioner
 Q $$TPPR^SCAPMC12(.SC200,.SCDATES,.SCPURPA,.SCROLEA,.SCLIST,.SCERR)
 ;
TPPT(DFN,SCDATES,SCPOSA,SCUSRA,SCPURPA,SCROLEA,SCYESCL,SCLIST,SCERR) ;  -- list of positions for a patient
 Q $$TPPT^SCAPMC23(.DFN,.SCDATES,.SCPOSA,.SCUSRA,.SCPURPA,.SCROLEA,.SCYESCL,.SCLIST,.SCERR)
TPCL(SC44,SCDATES,SCPOSA,SCUSRA,SCPURPA,SCROLEA,SCLIST,SCERR) ;  -- list of positions for a clinic
 Q $$TPCL^SCAPMC30(.SC44,.SCDATES,.SCPOSA,.SCUSRA,.SCPURPA,.SCROLEA,.SCLIST,.SCERR)
 ;
TPTM(SCTEAM,SCDATES,SCUSRA,SCROLEA,SCLIST,SCERR) ; -- positions for a team
 Q $$TPTM^SCAPMC24(.SCTEAM,.SCDATES,.SCUSRA,.SCROLEA,.SCLIST,.SCERR)
 ;
 ;  (2) ------------ Practitioner Lists ------------------------------
PRTM(SCTEAM,SCDATES,SCUSRA,SCROLEA,SCLIST,SCERR) ; -- practitioners for team **SUPPORTED**
 Q $$PRTM^SCAPMC1(.SCTEAM,.SCDATES,.SCUSRA,.SCROLEA,.SCLIST,.SCERR)
 ;
PRTP(SCTP,SCDATES,SCLIST,SCERR,SCPRCPTR,SCALLHIS) ; -- list practitioners for position
 Q $$PRTP^SCAPMC8(.SCTP,.SCDATES,.SCLIST,.SCERR,.SCPRCPTR,.SCALLHIS)
 ;
PRTPC(SCTP,SCDATES,SCLIST,SCERR,SCALLHIS,ADJDATE) ;Call PRTP and convert
 ;returned array from Provider/Preceptor to PROV-P, PROV-U, PREC.
 Q $$PRTPC^SCAPMC8C(.SCTP,.SCDATES,.SCLIST,.SCERR,.SCALLHIS,.ADJDATE)
 ;
PRCL(SC44,SCDATES,SCPOSA,SCUSRA,SCROLEA,SCLIST,SCERR) ; -- list of practitioners for clinic  **SUPPORTED**
 Q $$PRCL^SCAPMC9(.SC44,.SCDATES,.SCPOSA,.SCUSRA,.SCROLEA,.SCLIST,.SCERR)
 ;
PRPT(DFN,SCDATES,SCPOSA,SCUSRA,SCROLEA,SCPURPA,SCLIST,SCERR) ; -- practs for patient **SUPPORTED**
 Q $$PRPT^SCAPMC10(.DFN,.SCDATES,.SCPOSA,.SCUSRA,.SCROLEA,.SCPURPA,.SCLIST,.SCERR)
 ;
 ;  (3) -------------Patient Lists -------------------------------
PTTM(SCTEAM,SCDATES,SCLIST,SCERR) ; -- list of patients for team **SUPPORTED**
 Q $$PTTM^SCAPMC2(.SCTEAM,.SCDATES,.SCLIST,.SCERR)
 ;
PTTP(SCTP,SCDATES,SCLIST,SCERR) ; -- list of patients for a position
 Q $$PTTP^SCAPMC11(.SCTP,.SCDATES,.SCLIST,.SCERR)
 ;
PTPR(SC200,SCDATES,SCPURPA,SCROLEA,SCLIST,SCERR,SCYESCL) ; -- list patients for a pract
 Q $$PTPR^SCAPMC14(.SC200,.SCDATES,.SCPURPA,.SCROLEA,.SCLIST,.SCERR,.SCYESCL)
 ;
PTCL(SC44,SCDATES,SCLIST,SCERR) ; -- list of patients for a clinic
 Q $$PTCL^SCAPMC26(.SC44,.SCDATES,.SCLIST,.SCERR)
 ;
PTST(SCST,SCDATES,SCMAXCNT,SCLIST,SCERR,MORE) ; -- list of patients with a IEN of 40.7
 Q $$PTST^SCAPMC27(.SCST,.SCDATES,.SCMAXCNT,.SCLIST,.SCERR,.MORE)
 ;
PTAP(SCCL,SCDATES,SCMAXCNT,SCLIST,SCERR,MORE) ; -- list of patients with an appointment in a given clinic
 Q $$PTAP^SCAPMC28(.SCCL,.SCDATES,.SCMAXCNT,.SCLIST,.SCERR,.MORE)
 ;
 ;  (4) ------------Team Lists ----------------------------------
TMPT(DFN,SCDATES,SCPURPA,SCLIST,SCERR) ; -- list of teams for a patient **SUPPORTED**
 Q $$TMPT^SCAPMC3(.DFN,.SCDATES,.SCPURPA,.SCLIST,.SCERR)
 ;
TMINST(SCINST,SCDATES,SCPURPA,SCLIST,SCERR) ; -- teams for institution
 Q $$TMINST^SCAPMC4(.SCINST,.SCDATES,.SCPURPA,.SCLIST,.SCERR)
 ;
TMAU(SCAU,SCDATES,SCPURPA,SCLIST,SCERR) ; -- list of teams for autolink
 Q $$TMAU^SCAPMC5(.SCAU,.SCDATES,.SCPURPA,.SCLIST,.SCERR)
 ;
TMPR(SC200,SCDATES,SCPURPA,SCLIST,SCERR) ; -- teams for a practitioner
 Q $$TMPR^SCAPMC13(.SC200,.SCDATES,.SCPURPA,.SCLIST,.SCERR)
 ;
 ; (5) ------------ MailMan Message Recipients ----------------
MSGDTH(DFN,SCTEAMA,SCDATES,SCYESCL,SCLIST,SCERR) ; users getting death message
 Q $$MSGPT^SCAPMC25(1,.DFN,.SCTEAMA,.SCDATES,.SCYESCL,.SCLIST,.SCERR)
 ;
MSGINPT(DFN,SCTEAMA,SCDATES,SCYESCL,SCLIST,SCERR) ; users getting inpatient msg
 Q $$MSGPT^SCAPMC25(2,.DFN,.SCTEAMA,.SCDATES,.SCYESCL,.SCLIST,.SCERR)
 ;
MSGTEAM(DFN,SCTEAMA,SCDATES,SCYESCL,SCLIST,SCERR) ; users getting team update msg
 Q $$MSGPT^SCAPMC25(3,.DFN,.SCTEAMA,.SCDATES,.SCYESCL,.SCLIST,.SCERR)
 ;
MSGCONS(DFN,SCTEAMA,SCDATES,SCYESCL,SCLIST,SCERR) ; users getting consult message
 Q $$MSGPT^SCAPMC25(4,.DFN,.SCTEAMA,.SCDATES,.SCYESCL,.SCLIST,.SCERR)
 ;
 ; (6) ------------- Database Updates ---------------------------
ACPTTM(DFN,SCTM,SCFIELDA,SCACT,SCERR) ;add a patient to a team (pt tm assgn - #404.42
 Q $$ACPTTM^SCAPMC6(.DFN,.SCTM,.SCFIELDA,.SCACT,.SCERR)
 ;
INPTTM(DFN,SCPTTM,SCINACT,SCERR) ;inactivate patient from a team.
 ;                        pt tm assgn - #404.42.
 Q $$INPTTM^SCAPMC7(.DFN,.SCPTTM,.SCINACT,.SCERR)
 ;
ACTMNM(SCTMNM,SCFIELDA,SCMAINA,SCEFF,SCERR) ; -- change team status (add if need be) using name
 Q $$ACTMNM^SCAPMC15(.SCTMNM,.SCFIELDA,.SCMAINA,.SCEFF,.SCERR)
 ;
ACTM(SCTM,SCFIELDA,SCEFF,SCERR) ; change team status using ien
 Q $$ACTM^SCAPMC15(.SCTM,.SCFIELDA,.SCEFF,.SCERR)
 ;
ACTPNM(SCTPNM,SCTMNM,SCFIELDA,SCMAINA,SCEFF,SCERR) ; -- change position status (add if need be)
 Q $$ACTPNM^SCAPMC17(.SCTPNM,.SCTMNM,.SCFIELDA,.SCMAINA,.SCEFF,.SCERR)
 ;
ACTP(SCTP,SCFIELDA,SCEFF,SCERR) ; change position status using ien
 Q $$ACTP^SCAPMC17(.SCTP,.SCFIELDA,.SCEFF,.SCERR)
 ;
ACPRTP(SC200,SCTP,SCFIELDA,SCEFF,SCERR) ; change practitioner-position assignment
 Q $$ACPRTP^SCAPMC19(.SC200,.SCTP,.SCFIELDA,.SCEFF,.SCERR)
 ;
ACPTTP(DFN,SCTP,SCFIELDA,SCACT,SCERR,SCYESTM,SCMAINA) ; -- assign patient to position
 Q $$ACPTTP^SCAPMC21(.DFN,.SCTP,.SCFIELDA,.SCACT,.SCERR,.SCYESTM,.SCMAINA)
 ;
INPTTP(DFN,SCPTTPA,SCINACT,SCERR) ;inactivate patient from a position.
 ;                         pt tm pos assgn - #404.43.
 Q $$INPTTP^SCAPMC22(.DFN,.SCPTTPA,.SCINACT,.SCERR)
 ;
 ;  (7) -------------Other -------------------------------
CLPT(DFN,SCDATES,SCTEAMA,SCLIST,SCERR) ;clinics for patient
 ;
 Q $$CLPT^SCAPMC29(.DFN,.SCDATES,.SCTEAMA,.SCLIST,.SCERR)
 ;
INSTPCTM(DFN,SCEFF) ;return institution & team for pt's pc team **SUPPORTED **
 Q $$INSTPCTM^SCMCTMU(.DFN,.SCEFF)
 ;
PRPTTP(PTTMPOS,SCDATES,SCLIST,SCERR,SCALLHIS,ADJDATE) ;Get provider array
 ;for a Patient Team Position Assignment (404.43).
 Q $$PRPTTP^SCAPMC33(.PTTMPOS,.SCDATES,.SCLIST,.SCERR,.SCALLHIS,.ADJDATE)
 ;
PRPTTPC(PTTMPOS,SCDATES,SCLIST,SCERR,SCALLHIS,ADJDATE) ;
 ;Call PRPTTP and convert returned array from Prov/Prec to PCP/AP.
 Q $$PRPTTPC^SCAPMC34(.PTTMPOS,.SCDATES,.SCLIST,.SCERR,.SCALLHIS,.ADJDATE)
 ;
PROV(PTTMPOS,SCDATE,SCTYPE,SCPIECE) ;Return a single node/piece for AP/PCP.
 Q $$PROV^SCAPMC34(.PTTMPOS,.SCDATE,.SCTYPE,.SCPIECE)
