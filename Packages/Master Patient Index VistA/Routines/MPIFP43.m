MPIFP43 ;BIR/PTD-MPIF*1*43 PATCH POST INSTALL ROUTINE ;10/12/05
 ;;1.0; MASTER PATIENT INDEX VISTA ;**43**;30 Apr 99
 ;
 ;Reference to ^DPT("AICNL", supported by IA #2070
 ;
POST ;Reset the "AICNL" cross-reference to null so that existing entries
 ;will be reprocessed by the Local/Missing ICN Resolution job.
 D BMES^XPDUTL("     >> Reviewing the 'AICNL' cross-reference.")
 I '$D(^DPT("AICNL",1)) D MES^XPDUTL("     >> No 'AICNL' cross-reference to reset.") Q
 N CNT,DFN
 S (DFN,CNT)=0
 F  S DFN=$O(^DPT("AICNL",1,DFN)) Q:DFN=""  D
 .S ^DPT("AICNL",1,DFN)="",CNT=CNT+1
 D MES^XPDUTL("     >> Reset "_CNT_" 'AICNL' cross-references.")
 Q
