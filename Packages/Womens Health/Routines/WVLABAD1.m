WVLABAD1 ;HCIOFO/FT-LAB/WOMEN'S HEALTH LINK (cont.) ;4/6/99  12:33
 ;;1.0;WOMEN'S HEALTH;**6**;Sep 30, 1998
 ;
FIND ; Try to associate an incoming lab test entry with an existing WH
 ; procedure that has no link to a lab accession # to avoid duplicates.
 ; Called from WVLABADD.
 ; Input variables needed:
 ;    DFN - patient ien
 ; WVPROC - ien of WV Procedure Type (790.2)
 ; WVDATE - date portion of date of lab test
 ;
 ; First, loop through Date of Procedure x-ref
 N WVDTECHK,WVDATE0,WVFLAG,WVIEN,WVLOOP,WVNODE0,WVNODE2
 S WVDATE0=$P(WVDATE,".",1)
 S WVDTECHK=WVDATE0_".999999",WVFLAG=0,WVLOOP=WVDATE0-.000001
 F  S WVLOOP=$O(^WV(790.1,"D",WVLOOP)) Q:'WVLOOP!(WVLOOP>WVDTECHK)!(WVFLAG)  S WVIEN=0 F  S WVIEN=$O(^WV(790.1,"D",WVLOOP,WVIEN)) Q:'WVIEN!(WVFLAG)  D
 .S WVNODE0=$G(^WV(790.1,WVIEN,0)) Q:WVNODE0=""
 .S WVNODE2=$G(^WV(790.1,WVIEN,2))
 .Q:$P(WVNODE2,U,17)]""  ;already has a lab test link
 .Q:$P(WVNODE0,U,2)'=DFN  ;not the same patient
 .Q:$P(WVNODE0,U,4)'=WVPROC  ;not the same procedure
 .D LINK
 .S WVFLAG=1 ;flag that link is made to an existing record, so quit loop
 .Q
 Q
LINK ; Update values in existing entry including lab accession# link.
 ; Input variables needed:
 ;  WVNODE - zero node of a File 790.08 entry.
 ; WVNODE0 - zero node of a File 790.1 entry
 ;   WVIEN - File 790.1 ien
 Q:$G(WVNODE)=""  Q:'$G(WVIEN)
 N DIE,DA,DR
 S DIE="^WV(790.1,",DA=WVIEN
 ; fill in missing data where possible.
 S DR="2.17////"_$P(WVNODE,U,1) ;lab accession#
 S DR=DR_";2.18////"_$P(WVNODE,U,36) ;lab data file (#63) ien
 S DR=DR_";2.19////"_$P(WVNODE,U,37) ;lab inverse date/time
 S DR=DR_";2.2////"_$P(WVNODE,U,38) ;lab subscript (CY or SP)
 I $P(WVNODE0,U,7)="",$P(WVNODE,U,7)]"" S DR=DR_";.07////"_$P(WVNODE,U,7) ;provider
 I $P(WVNODE0,U,10)="",$G(DUZ(2))]"" S DR=DR_";.1////"_$G(DUZ(2)) ;facility
 I $P(WVNODE0,U,11)="",$P(WVNODE,U,11)]"" S DR=DR_";.11////"_$P(WVNODE,U,11) ;location
 D ^DIE
 Q
