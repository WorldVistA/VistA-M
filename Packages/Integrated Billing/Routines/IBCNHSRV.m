IBCNHSRV ;ALB/ZEB - HL7 Receiver for NIF transmissions ;03-OCT-14
 ;;2.0;INTEGRATED BILLING;**519**;21-MAR-94;Build 56
 ;;Per VA Directive 6402, this routine should not be modified.
 ;**Program Description**
 ;  This program will process incoming requests for NIF Batch Queries
 ; Call at tags only
 Q
SERVER ; Entry point for server option to kick off batch query
 ; ID of triggering message is in assumed variable XMZ
 ; Call to XMXAPI covered by IA #2729
 ; Call to XMXUTIL2 covered by IA #2736
 N IBXMZ,IBRUNDT,X,Y,DIE,DR,DA
 S IBXMZ=$G(XMZ)
 Q:IBXMZ=""  ;message does't actually exist
 ; only trigger the query if message has "TRIGGER BATCH QUERY" in the subject
 D:$$SUBJ^XMXUTIL2($G(^XMB(3.9,IBXMZ,0)))["TRIGGER BATCH QUERY"
 . D EXT^IBCNHUT2  ; Kick off batch query
 . ;disable menu option as we only need each site to do this once
 . N DIC,%,%H,%I D NOW^%DTC S Y=%  ;Y is now internal form of current date/time
 . D DD^%DT  ;replaces Y with external date
 . S IBRUNDT="One-time use only; used on "_$P(Y,"@",1)_"."
 . N Y
 . S DIC="^DIC(19,",DIC(0)="LS" S X="IBCNH HPID NIF BATCH QUERY" D ^DIC
 . I Y'=-1 S DIE=DIC,DA=+Y,DR="2///^S X=IBRUNDT" K DIC D ^DIE
 N ZTREQ
 D ZAPSERV^XMXAPI("S.IBCNH HPID NIF BATCH QUERY",IBXMZ)
 S ZTREQ="@"
 Q
 ;
