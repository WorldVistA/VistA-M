HLOP139 ;ALB/CJM-Pre & Post install ;10/27/2008
 ;;1.6;HEALTH LEVEL SEVEN;**139**;Oct 13, 1995;Build 11
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
 ;
POST ;
 N PROC,IEN
 F PROC="CLIENT MESSAGE UPDATES","SET SEARCH X-REF" D
 .S IEN=$O(^HLD(779.3,"B",PROC,0)) Q:'IEN  I $P(^HLD(779.3,IEN,0),"^",3)<1 S $P(^HLD(779.3,IEN,0),"^",3)=1 W !,"CHANGED:",PROC
 Q
