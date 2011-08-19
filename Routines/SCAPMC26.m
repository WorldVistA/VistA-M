SCAPMC26 ;ALB/REW - API: Patients in a Clinic ; December 1, 1995 [12/21/98 4:30pm]
 ;;5.3;Scheduling;**41,157**;AUG 13, 1993
 ;
PTCL(SC44,SCDATES,SCLIST,SCERR) ; patients in a clinic
 ; Input:
 ;  SC44 - Pointer to Hospital Location File #44
 ;  SCDATES- Date array (begin, end, incl)
 ;  SCLIST - Name of output array
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J
 ; Output:
 ;  SCLIST() = array of practitioners (users) - pointers to file #200
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       DFN - Ptr to Patient File (#2)
 ;                 2       Patient Name (External)
 ;                 3       null
 ;                 4       Activation Date
 ;                 5       Discharge Date
 ;                 6       '1' - for merge reasons with other pt lists
 ;                 7       sc44
 ;
 ;  SCERR()  = Array of DIALOG file messages(errors) .
 ;  @SCERR(0)= Number of error(s), UNDEFINED if no errors
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;   Returned: 1 if ok, 0 if error
 ;
ST N DFN,SCOK,SCCL,SCCLDT
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCBEGIN,SCEND,SCINCL,SCDTS
 ; -- initialize control variables
 S SCOK=1
 G:'$$OKDATA CLTPQ
 ;S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  IF $D(^DPT(DFN,"DE","B",SC44)) S SCCL=$O(^DPT(DFN,"DE","B",SC44,0)) D
 S SCCLDT=0
 F  S SCCLDT=$O(^DPT("AEB1",SC44,SCCLDT)) Q:'SCCLDT  D
 .S DFN=0
 .F  S DFN=$O(^DPT("AEB1",SC44,SCCLDT,DFN)) Q:'DFN  D
 ..Q:$D(^TMP("SCMC",$J,"EXCLUDE PT","SCPTA",DFN))
 ..;;bp/cmf 2981008
 ..;;modified code begin
 ..S SCCL=$O(^DPT("AEB1",SC44,SCCLDT,DFN,0))
 ..Q:'SCCL
 ..S SCX=$O(^DPT("AEB1",SC44,SCCLDT,DFN,SCCL,0))
 ..Q:'SCX
 ..S SCNODE=$G(^DPT(DFN,"DE",SCCL,1,SCX,0))
 ..I $$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,$P($P(SCNODE,U,1),"."),$P(SCNODE,U,3)) D
 ...S SCN=$G(@SCLIST@(0),0)+1
 ...S @SCLIST@(0)=SCN
 ...S @SCLIST@(SCN)=DFN_U_$P($G(^DPT(DFN,0)),U,1)_U_U_$P(SCNODE,U,1)_U_$P(SCNODE,U,3)_U_"1"_U_SC44_U_$P($G(^DPT(DFN,.36)),U,3)
 ...Q
 ..S @SCLIST@("SC PTCL",DFN,SCX,SCN)=""
 ..Q
 .Q
 ;;..modified code end
 ;;..original code begin
 ;;..Q:$D(@SCLIST@("SC PTCL",DFN))
 ;;..S SCCL=0
 ;;..F  S SCCL=$O(^DPT(DFN,"DE","B",SC44,SCCL)) Q:'SCCL  D
 ;;...S SCX=0 F  S SCX=$O(^DPT(DFN,"DE",SCCL,1,SCX)) Q:'SCX  S SCNODE=^(SCX,0) D
 ;;....IF $$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,$P(SCNODE,U,1),$P(SCNODE,U,3)) D
 ;;.....Q:$D(@SCLIST@("SC PTCL",DFN))
 ;;.....S SCN=$G(@SCLIST@(0),0)+1
 ;;.....S @SCLIST@(0)=SCN
 ;;.....S @SCLIST@(SCN)=DFN_U_$P($G(^DPT(DFN,0)),U,1)_U_U_$P(SCNODE,U,1)_U_$P(SCNODE,U,3)_U_"1"_U_SC44_U_$P($G(^DPT(DFN,.36)),U,3)
 ;;....S @SCLIST@("SC PTCL",DFN,SCX,SCN)=""
 ;;original code end
 ;;bp/cmf 2981008
CLTPQ Q $G(@SCERR@(0))<1
 ;
OKDATA() ;check/setup variables - return 1 if ok; 0 if error
 N SCOK
 S SCOK=1
 S (SCN,SCESEQ,SCLSEQ)=0
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^SC(+$G(SC44),0)) D  S SCOK=0
 . S SCPARM("CLINIC")=$G(SC44,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 IF '$L($G(SCLIST)) D  S SCOK=0
 . S SCPARM("OUTPUT ARRAY")=$G(SCLIST,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
 ;
PTCLBR(SC44,SCTM,SCDATES) ;for PCMM use only!! returns list to ^tmp($j,'scclpt'
 ;   SC44 - Clinic we're adding to team
 ;   SCTM - EXCLUDES Patients assigned to SCTM Team during time period
 ;   SCDATES - Standard Date array
 ;   Returns: $j if successful & at least one entry, 0 if error or none
 ;  Warning: Kills ^tmp($j,'scclpt') before it runs & ^tmp('scmc',$j,'exclude pt') after it runs
 N SCCLERR,SCX,SCXX
 K ^TMP($J,"SCCLPT")
 S SCXX=$$PTTM^SCAPMC(SCTM,.SCDATES,"^TMP(""SCMC"",$J,""EXCLUDE PT"")","SCCLERR")
 S SCX=$$PTCL(.SC44,.SCDATES,"^TMP($J,""SCCLPT"")","SCCLERR")
 K ^TMP("SCMC",$J,"EXCLUDE PT")
 Q $S('SCX:0,('$G(^TMP($J,"SCCLPT",0))):0,1:$J)
 ;
PTCLBRTP(SC44,SCTP,SCDATES) ;for PCMM use only!! returns list to ^tmp($j,'scclpt'
 ;   SC44 - Clinic we're adding to team
 ;   SCTP - EXCLUDES Patients assigned to SCTP Position during scdates
 ;   SCDATES - Standard Date array
 ;   Returns: $j if successful & at least one entry, 0 if error or none
 ;  Warning: Kills ^tmp($j,'scclpt') before it runs
 N SCCLERR,SCX,SCXX
 K ^TMP($J,"SCCLPT")
 S SCXX=$$PTTP^SCAPMC(SCTP,.SCDATES,"^TMP(""SCMC"",$J,""EXCLUDE PT"")","SCCLERR")
 S SCX=$$PTCL(.SC44,.SCDATES,"^TMP($J,""SCCLPT"")","SCCLERR")
 K ^TMP("SCMC",$J,"EXCLUDE PT")
 Q $S('SCX:0,('$G(^TMP($J,"SCCLPT",0))):0,1:$J)
 ;
