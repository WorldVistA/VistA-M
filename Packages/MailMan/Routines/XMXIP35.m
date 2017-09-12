XMXIP35 ;ISC-SF/GMB-Closes ALL domains "RC-<??>.GC.DOMAIN.EXT" ;08/30/2005 14:57
 ;;8.0;MailMan;**35**;Jun 28, 2002
 Q
 ;
EN ; Post install entry point for patch XM*8*35
 ; Change the value of the FLAGS field (#1) in the DOMAIN file (#4.2)
 ; to "C"lose for all domains of the form "RC-<something>.GC.DOMAIN.EXT".
 N DD,DO,DA,DIE,DR,XMI
 I $G(U)="" S U="^"
 S DIE="^DIC(4.2,",DR="1///C"
 S XMI="RC-"
 F  S XMI=$O(^DIC(4.2,"B",XMI)) Q:XMI=""!($E(XMI,1,3)'="RC-")  D
 . I $P(XMI,".",2,4)'="GC.DOMAIN.EXT" Q  ; Incorrect domain format
 . S DA=$O(^DIC(4.2,"B",XMI,0))
 . I $P(^DIC(4.2,DA,0),U,2)="C" Q  ; Domain is already closed
 . D ^DIE
 ;
 Q
