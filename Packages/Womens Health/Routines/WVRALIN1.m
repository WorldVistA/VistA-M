WVRALIN1 ;HCIOFO/FT-RAD/NM-WOMEN'S HEALTH LINK (cont.) ;2/18/00  10:58
 ;;1.0;WOMEN'S HEALTH;**5,10**;Sep 30, 1998
 ;
FIND ; Try to associate an incoming RAD/NM entry with an existing WH
 ; procedure that has no link to RAD/NM entry.
 ; Called from WVRALINK.
 ; Input variables needed:
 ;    DFN - patient ien
 ; WVPROC - ien of WV Procedure Type (790.2)
 ; WVDATE - date portion of date of rad/nm procedure
 ;
 ; First, loop through Date of Procedure x-ref
 N WVDTECHK,WVFLAG,WVIEN,WVLOOP,WVNODE
 S WVDTECHK=WVDATE_".999999",WVFLAG=0,WVLOOP=WVDATE-.000001
 F  S WVLOOP=$O(^WV(790.1,"D",WVLOOP)) Q:'WVLOOP!(WVLOOP>WVDTECHK)!(WVFLAG)  S WVIEN=0 F  S WVIEN=$O(^WV(790.1,"D",WVLOOP,WVIEN)) Q:'WVIEN!(WVFLAG)  D
 .S WVNODE=$G(^WV(790.1,WVIEN,0)) Q:WVNODE=""
 .Q:$P(WVNODE,U,15)]""  ;already has a rad/nm link
 .Q:$P(WVNODE,U,2)'=DFN  ;not the same patient
 .Q:$P(WVNODE,U,4)'=WVPROC  ;not the same procedure
 .D LINK
 .S WVFLAG=1 ;flag that link is made to an existing record, so quit loop
 .Q
 Q
LINK ; Update values in existing entry including day-case # link.
 ; Input variables needed:
 ;  WVNODE - zero node of a File 790.1 entry.
 ;   WVIEN - File 790.1 ien
 Q:$G(WVNODE)=""  Q:'$G(WVIEN)
 N DIE,DA,DR
 S DIE="^WV(790.1,",DA=WVIEN
 ; fill in missing data where possible.
 S DR=".15////"_WVCASE ;radiology mam case# (i.e., link to RAD/NM entry)
 I $P(WVNODE,U,5)="",$G(WVBWDX)]"" S DR=DR_";.05////"_WVBWDX ;result/dx
 I $P(WVNODE,U,7)="",$G(WVPROV)]"" S DR=DR_";.07////"_WVPROV ;provider
 I $P(WVNODE,U,9)="",$G(WVMOD)]"" S DR=DR_";.09////"_WVMOD ;modifier
 I $P(WVNODE,U,10)="",$G(DUZ(2))]"" S DR=DR_";.1////"_DUZ(2) ;facility
 I $P(WVNODE,U,11)="",$G(WVLOC)]"" S DR=DR_";.11////"_WVLOC ;location
 I $P(WVNODE,U,35)="",$G(WVCREDIT)]"" S DR=DR_";.35////"_WVCREDIT ;rad/nm credit method
 D ^DIE
 Q
VNVEC() ; Veteran/Non-Veteran/Eligibility Code check
 ; DFN must be defined
 ; Returns 1 - veteran
 ;             include all non-vets flag set to YES
 ;             non-vet patient's eligibility code is on list to track 
 N WVALL,WVLOOP,X,Y
 I $E($$VET^WVUTL1A(DFN))="Y" Q 1  ;veteran
 S WVALL=$P($G(^WV(790.02,DUZ(2),0)),U,25) ;include all non-vets
 I WVALL=1!(WVALL="") Q 1  ;1=YES
 S WVLOOP=+$$ELIG^WVUTL9(DFN) ;internal^external elig code
 I 'WVLOOP Q 0  ;no eligibility code
 I $D(^WV(790.02,DUZ(2),5,WVLOOP)) Q 1  ;code is on list to be tracked
 Q 0
 ;
