SCAPMCU4 ;ALB/REW - TEAM API UTILITIES ; 30 Mar 96
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
RESTPT(DFN,SCDATE,SCRPA) ;is pt a restricted consult pt?
 ;   DFN - ien to PATIENT File
 ;   SCATE - Date of interest - default=DT
 ;   SCRPA - literal value of desired restrict patients array
 ;       e.g. scrpa=xx results in xx(sctm)=teamname
 ;   Returned: [1 if yes, 0 if no, -1 if error]
 ; 
 N SCRPDTS,SCOK,SCRPLIST,SCRPERR,SCTM,SCTP,SCYES,SCTMNM,SCNDX,SCND
 S SCYES=0
 S SCRPDTS("BEGIN")=SCDATE
 S SCRPDTS("END")=SCDATE
 S SCRPDTS("INCL")=0
 S SCOK=$$TMPT^SCAPMC(DFN,"SCRPDTS",,"SCRPLIST","SCRPERR")
 IF $G(SCRPLIST(0)) D
 .F SCNDX=1:1:+$G(SCRPLIST(0)) D
 ..S SCND=SCRPLIST(SCNDX)
 ..S SCTM=+SCND
 ..S SCTMNM=$P(SCND,U,2)
 ..S SCPTTM=$P(SCND,U,3)
 ..; restrict from 404.51 (TEAM) file entry??
 ..IF $P($G(^SCTM(404.51,+SCTM,0)),U,13) D
 ...S SCYES=1
 ...S:$L(SCTMNM) @SCRPA@(SCTM)=SCTMNM
 ..; restring from 404.42 (PATIENT TEAM) file entry??
 ..IF $P($G(^SCPT(404.42,+SCPTTM,0)),U,10) D
 ...S SCYES=1
 ...S:$L(SCTMNM) @SCRPA@(SCTM)=SCTMNM
 Q $S($D(SCRPERR):-1,1:SCYES)
