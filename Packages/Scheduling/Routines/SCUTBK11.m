SCUTBK11 ;ALB/SCK - Scheduling Broker Utilities; 2/2/96 ;9/7/96  17:28
 ;;5.3;Scheduling;**41,54,86,148,177,205,209,255,297**;AUG 13, 1993
 ;
 Q
PARSE(SC) ;
 S SCDFN=$G(SC("DFN"),"")
 S SCPIEN=$G(SC("PIEN"),"")
 S:$D(SC("TEAM")) SCTM=$G(SC("TEAM"))
 S:$D(SC("BEGIN")) SCDT("BEGIN")=$G(SC("BEGIN"))
 S:$D(SC("END")) SCDT("END")=$G(SC("END"))
 I $D(SC("END")) S SCDT("INCL")=0
 S SCFILE=$G(SC("FILE"))
 S SCIEN=$G(SC("IEN"))
 S SCFIELD=$G(SC("FIELD"))
 S SCVAL=$G(SC("VALUE"))
 Q
 ;
TMLST(SCDATA,SC) ;
 ;  -- Return a list of teams for a patient.  Pass in the DFN and
 ;     optionally a date range and/or a team purpose to restrict the
 ;     team look up.  Return only the team entry, strip out any other
 ;     array items.
 ;
 N DFN,SCDT,SCPURP,SCLIST,SCER1,SCOK,SCD
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S DFN=$G(SC("DFN"))
 S SCDT("BEGIN")=$G(SC("BEGIN"),"")
 I $L(SCDT("BEGIN"))>2 S SCDT("INCL")=$G(SC("INCL"),0)
 S SCDT("END")=$G(SC("END"),"")
 S SCPURP=$G(SC("PURP"),"")
 ;
 S SCOK=$$TMPT^SCAPMC3(DFN,"SCDT","","SCD","SCER1")
 ;
 S I=0 F  S I=$O(SCD(I)) Q:'I  S SCDATA(I)=SCD(I)
TMQ Q
 ;
FINDP(SCOUT,SCIN) ; patient lookup used by SC PATIENT LOOKUP rpc
 ; input:
 ;   SCIN("VALUE") = value to lookup
 ;     Lookup uses multiple index lookup of File #2
 ; output:
 ;   SCOUT = location of data = ^TMP("DILIST",$J,i,0)
 ;   for i=1:number of records returned: 
 ;    DFN^patient name^DOB^PID^DOD
 ;     1        2       3   4   5
 ;
 ;bp/cmf 205 original code next line
 ;D FIND^DIC(2,,".01;.03;.363;.09","MPS",SCIN("VALUE"),500)
 ;bp/cmf 205 change code next line
 ;oifo/swo 297 added .351 for DOD warning new functionality
 D FIND^DIC(2,,".01;.03;.363;.09;.351","PS",SCIN("VALUE"),300,"B^BS^BS5^SSN")
 I $G(DIERR) D CLEAN^DILF Q
 N SCOUNT S SCOUNT=+^TMP("DILIST",$J,0)
 N SC F SC=1:1:SCOUNT D
 . N NODE,SSN,DSSN,PLID
 . S NODE=^TMP("DILIST",$J,SC,0)
 . ;Apply DOB screen
 . S $P(NODE,U,3)=$$DOB^DPTLK1(+NODE)
 . ;Apply SSN screen
 . S SSN=$$SSN^DPTLK1(+NODE)
 . S DSSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,11)
 . S PLID=$P(NODE,U,4)
 . I $E(SSN,1,9)'?9N S (DSSN,PLID)=SSN
 . S $P(NODE,U,4)=$S($L(PLID)>5:PLID,1:DSSN)
 . ;Move screened data back into output global
 . ;oifo/swo 297 piece 6 is DOD field. Added for DOD warning
 . S ^TMP("DILIST",$J,SC,0)=$P(NODE,U,1,4)_U_$P(NODE,U,6)
 K ^TMP("DILIST",$J,0)
 K SCOUT S SCOUT="^TMP(""DILIST"","_$J_")"
 Q
PSLST(SCDATA,SC) ;
 ;
 ;  - Returns a array of positions that show the person currently
 ;    assigned to the position, the preceptor for that position,
 ;    for the patient is assigned to.
 ;
 ;    Pass in the Patient's DFN
 ;    To restrict to specific entries, pass in the following:
 ;      Beginning and Ending Date Range 
 ;      A specific Team Position
 ;      A Specific User entry (8930)
 ;      A specific Team Purpose.  (Read SCAPMC23 for how it exclude
 ;        a specific team purpose.
 ;      A specific role
 ;      Flag whether to include patients associated by enrollement
 ;    
 N SCDT,SCD,SCER1,SCDFN,SCPRP,SCPST,SCRLE,SCIND,SCUSR,SCTM,SCDTE
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 D PARSE(.SC)
 S SCDTE=$G(SCDT("BEGIN"))
 ;
 S CNT=0
 K ^TMP($J,"PSLST")
 S SCOK=$$TPPT^SCAPMC(SCDFN,.SCDT,"","","","","","SCD","SCER1")
 S I=0 F  S I=$O(SCD(I)) Q:'I  D
 . I $D(SCTM) D
 .. Q:$P(SCD(I),U,3)'=SCTM
 .. S ^TMP($J,"PSLST",I)=$P($G(SCD(I)),U,3)_U_$P($G(SCD(I)),U,4)_U_$P($G(SCD(I)),U,1,2)_U_$P($G(SCD(I)),U,7,8)
 . ;
 . I '$D(SCTM) D
 .. S ^TMP($J,"PSLST",I)=$P($G(SCD(I)),U,3)_U_$P($G(SCD(I)),U,4)_U_$P($G(SCD(I)),U,1,2)_U_$P($G(SCD(I)),U,7,8)
 ;
 S CNT=0
 S I=""
 F  S I=$O(^TMP($J,"PSLST",I)) Q:'I  D
 . S:'$D(SCDTE) SCDTE=DT
 . S SCPIEN=$P($G(^TMP($J,"PSLST",I)),U,3)
 . S SCDATA(CNT)=^TMP($J,"PSLST",I)_U_$$PSMBR(SCPIEN,SCDTE)_U_+$P($G(^SCPT(404.43,$P($G(^TMP($J,"PSLST",I)),U,2),0)),U,5)_U_+$P($G(^SCTM(404.57,SCPIEN,0)),U,4)
 . S CNT=CNT+1
 K ^TMP($J,"PSLST")
 ;
PSLTQ Q
 ;
PSMBR(SCPIEN,SCPDT) ;
 ;
 N SCPRCP,SCMBR,SCPP
 ;
 S SCMBR=$$GETPRTP^SCAPMCU2(SCPIEN,SCPDT)
 S SCMBR=$S(+SCMBR>0:SCMBR,1:U)
 S SCPP=$$OKPREC2^SCMCLK(SCPIEN,SCPDT)
 S SCPRCP=$S(+SCPP>0:SCPP,1:U)
 Q SCMBR_U_SCPRCP
 ;
VFILE(SCOK,SC) ;
 N SCFILE,SCIEN,SCFIELD,SCVAL,SCFDA,SCMSG
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=1
 D PARSE(.SC)
 S SCFDA(SCFILE,""_SCIEN_","_"",SCFIELD)=SCVAL
 ;
 D FILE^DIE("K","SCFDA","SCMSG")
 ;
 I $D(SCMSG("DIERR")) D
 . S SCOK=0
 Q
 ;
SECKEY(SCOK,SCKEY) ;
 ;
 D CHK^SCUTBK
 ;
 S SCOK=$D(^XUSEC(SCKEY,DUZ))
 Q
 ;
PSALST(SCDATA,SC) ;
 ;
 ;  - Returns a array of positions that show the person currently
 ;    assigned to the position, the preceptor for that position,
 ;    for the patient is assigned to.
 ;
 ;    Pass in the Patient's DFN
 ;    To restrict to specific entries, pass in the following:
 ;      Beginning and Ending Date Range 
 ;      A specific Team Position
 ;      A Specific User entry (8930)
 ;      A specific Team Purpose.  (Read SCAPMC23 for how it exclude
 ;        a specific team purpose.
 ;      A specific role
 ;      Flag whether to include patients associated by enrollement
 ;    
 N SCDT,SCD,SCER1,SCDFN,SCPRP,SCPST,SCRLE,SCIND,SCUSR,SCTM,SCDTE,SCPTTMA
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 D PARSE(.SC)
 S SCPTTMA=$G(SC("TEAMASSIGN")) ;NEW JLU
 S SCDTE=$G(SCDT("BEGIN"),DT)   ;bp/cmf 177 added DT for gui
 ;
 S CNT=0
 K ^TMP($J,"PSLST")
 S SCOK=$$TPPT^SCAPMC(SCDFN,.SCDT,"","","","","","SCD","SCER1")
 S I=0 F  S I=$O(SCD(I)) Q:'I  D
 .Q:$P(SCD(I),U,11)'=SCPTTMA
 .S ^TMP($J,"PSLST",I)=$P($G(SCD(I)),U,3)_U_$P($G(SCD(I)),U,4)_U_$P($G(SCD(I)),U,1,2)_U_$P($G(SCD(I)),U,7,8)
 ;
 S CNT=0
 S I=""
 F  S I=$O(^TMP($J,"PSLST",I)) Q:'I  D
 . S:'$D(SCDTE) SCDTE=DT
 . S SCPIEN=$P($G(^TMP($J,"PSLST",I)),U,3)
 . S SCDATA(CNT)=^TMP($J,"PSLST",I)_U_$$PSMBR(SCPIEN,SCDTE)_U_+$P($G(^SCPT(404.43,$P($G(^TMP($J,"PSLST",I)),U,2),0)),U,5)_U_+$P($G(^SCTM(404.57,SCPIEN,0)),U,4)
 . S CNT=CNT+1
 K ^TMP($J,"PSLST")
 ;
PSALSTQ Q
