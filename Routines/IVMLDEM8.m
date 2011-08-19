IVMLDEM8 ;ALB/SEK - IVM DEMOGRAPHIC DELETE FIELDS (CON'T) ; 04-APR-96
 ;;2.0;INCOME VERIFICATION MATCH;**5,10**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; - called by IVMLDEM4 for non-uploadable demographic fields
 ;
 ;   list manager returned entry # of field to be deleted (fifth
 ;   subscript of tmp global  - ivment4)
 ;   since primary eligibility code could have >1 entry
 ;   and line # will not be the same as entry #
 ;   must get line # (fourth subscript of tmp global - ivmlinen) 
 ;
DF N IVMAR,IVMARC,IVMEND,IVMEGC,IVMLINEN
 S (IVMEND,IVMEGC,IVMLINEN)=0
 F  S IVMLINEN=$O(^TMP(IVMARRAY,$J,"IDX",IVMLINEN)) Q:'IVMLINEN  D  Q:IVMEND
 .S IVMINDEX=$G(^TMP(IVMARRAY,$J,"IDX",IVMLINEN,IVMENT4)) Q:IVMINDEX']""
 .I $P(IVMINDEX,"^",7)'=.361 S IVMEND=1 Q  ; not primary elig code
 .S IVMEGC=IVMEGC+1,IVMAR(IVMEGC)=IVMINDEX
 ;
 ; - primary eligibility code field
 I IVMEGC D  Q
 .S $P(IVMINDEX,"^",8)="PRIMARY ELIGIBILITY CODE"
 .D SURE Q:IVMOUT!('IVMSURE)
 .F IVMARC=1:1:IVMEGC S IVMINDEX=IVMAR(IVMARC) D
 ..D DEL
 .W "completed."
 ;
 ; - check to see if selection is an address field
 S IVMADDR=$$ADDR^IVMLDEM7(+IVMINDEX,$P(IVMINDEX,"^",2),$P(IVMINDEX,"^",3),$P(IVMINDEX,"^",4),IVMPPICK)
 Q:IVMADDR
 ;
 ; - not address or primary eligibility code field
 ;
 D SURE Q:IVMOUT!('IVMSURE)
 D DEL
 W "completed."
 Q
 ;
SURE ; - ask user if they are sure they want to delete field
 D RUSURE^IVMLDEMU($P(IVMINDEX,"^",8),"delete") Q:IVMOUT!('IVMSURE)
 ;
 W !,"Deleting "_$P(IVMINDEX,"^",8)_" field from the list... "
 Q
 ;
DEL ;- remove entry from file (#301.5)
 D DELENT^IVMLDEMU($P(IVMINDEX,"^",2),$P(IVMINDEX,"^",3),$P(IVMINDEX,"^",4))
 Q
