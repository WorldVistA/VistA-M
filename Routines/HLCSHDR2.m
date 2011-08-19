HLCSHDR2 ;CIOFO-SF/JC Enhanced message headers ;07/28/99  15:02
 ;;1.6;HEALTH LEVEL SEVEN;**57**;Oct 13, 1995
 ;OUTBOUND-CALLED BY HLCSHDR1 (TCP ONLY)
 ;         CALLED BY HLCSHDR
 ;
GEN ;If enabled, stuff INSTITUTION and DOMAIN in facility field of header
 S HLCS=$E(EC,1)
 ;get site parameters
 S HLPARAM=$$PARAM^HLCS2,HLDOM=$P(HLPARAM,U,2),HLINST=$P(HLPARAM,U,6),HLPROD=$P(HLPARAM,U,3)
 Q
EP ;Get required sending facility
 ;get LOCAL SERVER LINK info from Domain entry (HL7 site params)
 I $G(SERFAC)="" S SERFAC=HLINST_HLCS_HLDOM_HLCS_"DNS"
 Q
S ;update receiving facility with domain pointer in 870
 I $G(CLNTFAC)="" D
 .I $G(LOGLINK)]"" S HLOGLINK=LOGLINK
 .;I no logical link defined, use local site params
 .I $G(HLOGLINK)="" D  Q
 ..S CLNTFAC=HLINST_HLCS_HLDOM_HLCS_"DNS"
 .D LINK(HLOGLINK)
 .S CLNTFAC=HLCINS_HLCS_HLCDOM_HLCS_"DNS"
 Q
LINK(HLLINK) ;Returns HL7 link info from file 870
 S (HLCSTCP,HLIP,HLCINS,HLCDOM)=""
 I 'HLLINK,HLLINK]"" D
 .S HLLINK=$O(^HLCS(870,"B",HLLINK,0))
 S (HLCINS,HLCDOM)="Unknown"
 S HLCINS=$P(^HLCS(870,HLLINK,0),U,2)
 S HLCDOM=$P(^HLCS(870,HLLINK,0),U,7)
 I HLCINS S HLCINS=$P($G(^DIC(4,HLCINS,99)),U)
 I HLCDOM S HLCDOM=$P(^DIC(4.2,HLCDOM,0),U)
 ;
 Q
