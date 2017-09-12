HLOP146 ;ALB/CJM-Pre & Post install ;06/04/2009
 ;;1.6;HEALTH LEVEL SEVEN;**146**;Oct 13, 1995;Build 16
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
POST ;post-install
 N OPTION
 F OPTION="HLO OUTBOUND DELETE","HLO SEQUENCE DELETE" D DELSYN(OPTION)
 Q
DELSYN(OPTION) ;delete options QD synonym
 S DA(1)=$O(^ORD(101,"B",OPTION,0))
 Q:'DA(1)
 S DA=$O(^ORD(101,DA(1),2,"B","QD",0))
 Q:'DA
 I $$DELETE^HLOASUB1(101.02,.DA)
 Q
