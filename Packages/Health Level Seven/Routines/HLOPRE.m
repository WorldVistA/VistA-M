HLOPRE ;ALB/CJM-Pre-install check for HLO patches ;07/17/2007
 ;;1.6;HEALTH LEVEL SEVEN;**134,136,137,138**;Oct 13, 1995;Build 34
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CHECK ;
 ;
 N WORK
 L +^HLTMP("PROCESS MANAGER"):0
 I '$T D ABORT Q
 D CHKDEAD^HLOPROC1(.WORK)
 I $O(^HLTMP("HL7 RUNNING PROCESSES",""))'="" D ABORT
 L -^HLTMP("PROCESS MANAGER")
 Q
ABORT ;
 S XPDABORT=1
 D BMES^XPDUTL("HLO processes are still running and prevent this installation from completing")
 Q
