RGMTUT02 ;BIR/CML-MPI/PD Compile and Correct Data Validation Data for Local Sites (CON'T) ;07/30/02
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**20,37,41**;30 Apr 99
 ;
 ;Reference to ^DPT("AICN" & ^DPT("AICNL" supported by IA #2070
 ;Reference to $$SETLOC MPIF001 supported by IA #2705
 ;Reference to EDIT^VAFCPTED supported by IA #2784
 ;
 Q
 ;
REIND ;Correct any existing xref problems:
 ;patch RG*1.0*41 only removed code - specifically the check to see if the REIND has already run that day
 ; - missing SSN xref (only if they have a local or national ICN)
 ; - missing AICN xref
 ; - missing AICNL xref and field Locally assigned ICN
 ;Also get counts of national ICNs, Local ICNs and NO ICNs
 ;
 ;NOSSN = number of patients missing an SSN xref (only if they have a local or national ICN)
 ;NOAICN = number of patients missing an AICN xref
 ;NOAICNL = number of patients missing an AICNL xref
 ;NICNCNT = number of patients with a national ICN
 ;LICNCNT = number of patients with a local ICN
 ;NOICNCNT = number of patients no ICN
 ;
 K ^XTMP("RGMT","UT01","REIND")
 S (NOSSN,NOAICN,NOAICNL,NICNCNT,LICNCNT,NOICNCNT,DFNCNT)=0
 F TYPE="MISSING SSN XREF","MISSING AICN XREF","MISSING AICNL XREF","NATIONAL ICN COUNT","LOCAL ICN COUNT","NO ICN COUNT" D
 .S ^XTMP("RGMT","UT01","REIND",TYPE)=0
 ;
 S SITE=$P($$SITE^VASITE(),"^",3)
 ;
 I '$D(RGHLMQ) D
 .W !!,"Checking for:"
 .W !,"Missing ""SSN"" xrefs in ^DPT"
 .W !,"Missing ""AICN"" xrefs in ^DPT"
 .W !,"Missing ""AICNL"" xrefs in ^DPT"
 .W !,"Counts on total National ICNs"
 .W !,"Counts on total Local ICNs"
 .W !,"Counts on total patients without ICNs"
 ;
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S DFNCNT=DFNCNT+1 S MNODE=$G(^DPT(DFN,"MPI")) D
 .I '$D(RGHLMQ),'(DFNCNT#10000) W !,DFN
 .I MNODE="" S NOICNCNT=NOICNCNT+1 Q
 .S ICN=$P(MNODE,"^") I ICN="" S NOICNCNT=NOICNCNT+1 Q
 .S SSN=$P($G(^DPT(DFN,0)),"^",9)
 .I $G(SSN),'$D(^DPT("SSN",SSN,DFN)) S NOSSN=NOSSN+1 D
 ..; if SSN xref exists for a different patient, send exception and quit
 ..; otherwise, edit the field to set the xref
 ..I $D(^DPT("SSN",SSN)) D  Q
 ...D EXC^RGHLLOG(210,"SSN xref does not exist for patient DFN #"_DFN_" for SSN "_SSN_". This SSN appears to exist for a different patient.",DFN)
 ..I $L(SSN)>8 K ARR S ARR(2,.09)=SSN D EDIT^VAFCPTED(DFN,"ARR(2)",".09")
 .I '$D(^DPT("AICN",ICN,DFN)) S NOAICN=NOAICN+1,^DPT("AICN",ICN,DFN)=""
 .I $E(ICN,1,3)'=SITE S NICNCNT=NICNCNT+1 Q
 .I $E(ICN,1,3)=SITE D
 ..S LICNCNT=LICNCNT+1
 ..I '$D(^DPT("AICNL",1,DFN)) S LOCAL=$$SETLOC^MPIF001(DFN,1),^DPT("AICNL",1,DFN)="",NOAICNL=NOAICNL+1
 ;
 ;
 S ^XTMP("RGMT","UT01","REIND","MISSING SSN XREF")=NOSSN
 S ^XTMP("RGMT","UT01","REIND","MISSING AICN XREF")=NOAICN
 S ^XTMP("RGMT","UT01","REIND","MISSING AICNL XREF")=NOAICNL
 S ^XTMP("RGMT","UT01","REIND","NATIONAL ICN COUNT")=NICNCNT
 S ^XTMP("RGMT","UT01","REIND","LOCAL ICN COUNT")=LICNCNT
 S ^XTMP("RGMT","UT01","REIND","NO ICN COUNT")=NOICNCNT
 ;
 I '$D(RGHLMQ) D
 .W !!,"Results:"
 .W !?3,"Missing SSN xrefs created  :",?41,$J(NOSSN,7)
 .W !?3,"Missing AICN xrefs created :",?41,$J(NOAICN,7)
 .W !?3,"Missing AICNL xrefs created:",?41,$J(NOAICNL,7)
 .W !?3,"Total DFNs processed   : ",$J(DFNCNT,8)
 .W !?6,"Total National ICNs : ",$J(NICNCNT,8)
 .W !?6,"Total Local ICNs    : ",$J(LICNCNT,8)
 .W !?6,"Total without ICNs  : ",$J(NOICNCNT,8)
 .W !!,"(List global ^XTMP(""RGMT"",""UT01"",""REIND"" for data.)"
 ;
 K ARR,CURDT,DFN,DFNCNT,ICN,LICNCNT,LOCAL,MNODE,NICNCNT,NOAICN,NOAICNL,NOICNCNT,NOSSN,SITE,SSN,TYPE
 Q
