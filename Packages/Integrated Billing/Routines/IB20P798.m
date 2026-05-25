IB20P798 ;ALB/CNF - POST INIT;11/14/2024
 ;;2.0;INTEGRATED BILLING;**798**;21-MAR-94;Build 25
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q   ; Call from tag
 ;
POST ; Post Executable for IB*2.0*798
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*798 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 D AECME
 S IBA(1)="",IBA(2)="    IB*2*798 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
AECME ; Create index AECME from index AG
 D MES^XPDUTL("  - Creating AECME index in file BILL/CLAIMS #399")
 M ^DGCR(399,"AECME")=^DGCR(399,"AG")  ; Merge AG index into AECME index, Initially both will be the same
 D MES^XPDUTL("  - AECME index in file BILL/CLAIMS #399 is created")
 Q
 ;
