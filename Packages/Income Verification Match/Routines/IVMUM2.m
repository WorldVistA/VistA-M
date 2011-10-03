IVMUM2 ;ALB/SEK - ADD NEW DEPENDENT TO INCOME PERSON FILE ; 12 MAY 94
 ;;2.0;INCOME VERIFICATION MATCH;**1,17**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; this routine will add entries to INCOME PERSON file (408.13) for
 ; new dependents (spouse/children).  if IVM demo data (name, dob, 
 ; ssn, sex) is different than VAMC data, 408.13 will be changed to
 ; contain the IVM data.  the MEANS TEST CHANGES file (408.41) will
 ; contain both values.
 ;
 ; current year is date of means test.
 ; income year is calendar year before date of means test.
 ; meant test status is based on income year data.
 ;
INPIEN ; get INCOME PERSON IEN
 ; if PATIENT RELATION IEN not in ZDP
 ;    add dependent to INCOME PERSON file if dependent not found
 ;    dependent found if dob, sex, & relationship (408.12) match
 ;
 ;     Input    DFN     IEN of file #2
 ;              IVMSEG  dependent's ZDP segment
 ;
 ; ivmflg1=1 have 408.13 ien when exit (found or added)
 ; ivmflg2=1 dep record must be added to 408.12
 ; ivmflg5=1 spouse ZDP incomplete(not dependent) - always spouse records
 S (IVMFLG1,IVMFLG2,IVMFLG5)=0
 S DGPRI=$P(IVMSEG,"^",7) ; ien of patient relation file
 ;
 S IVMNM=$$FMNAME^HLFNC($P(IVMSEG,"^",2)),IVMSEX=$P(IVMSEG,"^",3),IVMDOB=$$FMDATE^HLFNC($P(IVMSEG,"^",4)),IVMSSN=$P(IVMSEG,"^",5)
 S IVMEFFDT=$$FMDATE^HLFNC($P(IVMSEG,"^",9)),IVMRELN=$P(IVMSEG,"^",6)
 ;
 I IVMSPCHV="S"&((IVMNM']"")!(IVMSEX']"")!(IVMDOB']"")) S IVMFLG5=1 Q
 I 'DGPRI G NOIEN
 ;
 ; if ien of patient relation file (dgpri) transmitted by IVM Center
 ; and found in 408.12, get ien of income person.  if IVM demo data
 ; is different, change in 408.13 & add to 408.41
 ; ivmprn is 0 node of 408.12
 ; dgipi is ien of 408.13
 S IVMPRN=$G(^DGPR(408.12,+DGPRI,0))
 I IVMPRN]"" D GETIPI Q:$D(IVMFERR)  S DGIPI=+$P($P(IVMPRN,"^",3),";"),IVMFLG1=1,IVMRELO=$P(IVMPRN,"^",2) D AUDITP^IVMUM9,AUDIT^IVMUM9 Q
 ;
NOIEN ; ien of patient relation file is not transmitted or transmitted and
 ; not found
 ; check if dependent in income person file
 ; if dependent not found in 408.13, setup ivmstr =  0 node of 408.13
 ; subscript of array IVMAR is ien of 408.12 transmitted by IVM Center or
 ; created or found by upload.
 ;
 S DGPRI=0 F  S DGPRI=$O(^DGPR(408.12,"B",DFN,DGPRI)) Q:'DGPRI  D  Q:IVMFLG1!($D(IVMFERR))
 .D GETIP
 .Q:$D(IVMFERR)!($D(IVMAR(DGPRI)))!(IVMRELO=1)
 .I IVMSEX=IVMSEX13&(IVMDOB=IVMDOB13)&(IVMRELN=IVMRELO) S IVMFLG1=1,IVMAR(DGPRI)=""
 .Q
 ;
 ; found dependent in 408.13. if demo data different, change in 408.13
 ; and add in 408.41
 Q:$D(IVMFERR)
 I IVMFLG1 S DGIPI=+$P($P(IVMPRN,"^",3),";") D AUDITP^IVMUM9,AUDIT1^IVMUM9 Q
 ;
 ; dependent not found. add record to 408.13
 I 'IVMFLG1 D
 .S $P(IVMSTR,"^")=IVMNM,$P(IVMSTR,"^",2)=IVMSEX,$P(IVMSTR,"^",3)=IVMDOB,$P(IVMSTR,"^",9)=IVMSSN
 .D ADDDEP
 Q
 ;
ADDDEP ; add dependent to 408.13 file
 ; In - DFN=IEN of File #2
 ;      DGRP0ND=0 node of 408.13
 ;Out - DGIPI=408.13 IEN
 ;
 S DGRP0ND=IVMSTR
 K DINUM
 S (DIK,DIC)="^DGPR(408.13,",DIC(0)="L",DLAYGO=408.13,X=$P(DGRP0ND,"^") K DD,DO D FILE^DICN S (DGIPI,DA)=+Y K DLAYGO
 ;
 ; if can't create stub notify site & IVM Center
 I DGIPI'>0 D  Q
 .S (IVMTEXT(6),HLERR)="Can't create stub for file 408.13"
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 .S IVMFERR=""
 L +^DGPR(408.13,+DGIPI) S ^DGPR(408.13,+DGIPI,0)=DGRP0ND D IX1^DIK L -^DGPR(408.13,+DGIPI)
 S IVMFLG2=1 ; added dep to 408.13 must add to 408.12
 K DIK,DIC
 Q
 ;
 ;
GETIP ; if can't find 408.12 record notify site & IVM Center
 S IVMPRN=$G(^DGPR(408.12,+DGPRI,0))
 S IVMRELO=$P(IVMPRN,"^",2)
 I IVMPRN']"" D  Q
 .S (IVMTEXT(6),HLERR)="Can't find 408.12 record "_DGPRI
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 .S IVMFERR=""
 Q:IVMRELO=1
 ;
GETIPI ; ivmseg13 is 0 node of income person file
 ; get demo data in 408.13 & 408.12
 S IVMSEG13=$$DEM^DGMTU1(DGPRI)
 I IVMSEG13']"" D  Q
 .S (IVMTEXT(6),HLERR)="Can't find 408.13 record"
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 .S IVMFERR=""
 S IVMSEX13=$P(IVMSEG13,"^",2),IVMDOB13=$P(IVMSEG13,"^",3),IVMSSN13=$P(IVMSEG13,"^",9)
 S IVMNM13=$P(IVMSEG13,"^")
 Q
