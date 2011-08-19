HLOP143 ;ALB/CJM-Pre & Post install ;06/16/2009
 ;;1.6;HEALTH LEVEL SEVEN;**143**;Oct 13, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PRE ;
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
