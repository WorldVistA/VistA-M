IBY650PO ;EDE/JWS - POST-INSTALL FOR IB*2.0*650 ;20-JAN-2021
 ;;2.0;INTEGRATED BILLING;**650**;20-JAN-21;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ;Entry Point
 N IBA
 S IBA(2)="IB*2*650 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D FIX
 S IBA(2)="IB*2*650 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
FIX ;fix orphaned 364 entries that are not in a final status
 N DA,D0,DR,DIE,DIC,IB399,IB364,IBOSTAT,IBSTATUS
 S IB399=0
 F  S IB399=$O(^IBA(364,"B",IB399)) Q:IB399=""  D
 . S IB364=$O(^IBA(364,"B",IB399,"A"),-1) I IB364="" Q
 . I '$O(^IBA(364,"B",IB399,IB364),-1) Q
 . S IBSTATUS=$P(^IBA(364,IB364,0),"^",3)
 . F  S IB364=$O(^IBA(364,"B",IB399,IB364),-1) Q:IB364=""  D
 .. S IBOSTAT=$P(^IBA(364,IB364,0),"^",3)
 .. I "CREZ"[IBOSTAT Q
 .. S DA=IB364 I DA="" Q
 .. S DR=".03////R;.12////"_IBOSTAT
 .. S DIE="^IBA(364,"
 .. D ^DIE
 Q
 ;
