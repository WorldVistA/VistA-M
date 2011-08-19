IVMUM3 ;ALB/SEK,GTS - ADD NEW DEPENDENT TO PATIENT RELATIONS FILE ; 12 MAY 94
 ;;2.0;INCOME VERIFICATION MATCH;**1,17,101**;21-OCT-94;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; this routine will add entries for new dependents to PATIENT
 ; RELATION file-408.12 (including 408.1275) or will add new entries
 ; to effective date multiple (408.1275) for all IVM spouses and
 ; dependents.  if only adding to 408.1275 and IVM relationship is
 ; different then VAMC relationship, change in 408.12 and add to
 ; MEANS TEST CHANGES file (408.41).
 ;
 ; input  dfn        ien of file #2
 ;        dgipi      408.13 ien
 ;        dgmti      408.31 ien
 ;        dgpri      408.12 ien
 ;        ivmeffdt   effective (dependent) date of spouse/dependent
 ;        ivmreln    IVM relationship
 ;        ivmrelo    VAMC relationship
 ;        ivmseg     ZDP segment of spouse/dependent
 ;
 ;
 I IVMFLG2 G NEWPR
 ;
 ; add new entry to 408.1275
 ;
 K DINUM
 S DA(1)=DGPRI
 S (DIK,DIC)="^DGPR(408.12,DA(1),""E"",",DIC(0)="L",DLAYGO=408.1275,X=IVMEFFDT K DD,DO D FILE^DICN S DA=+Y K DLAYGO
 ;
 ; if can't create stub notify site & IVM Center
 I DA'>0 D  Q
 .S (IVMTEXT(6),HLERR)="Can't create stub for file 408.1275"
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 .S IVMFERR=""
 ;
 ;Set value of FILED BY IVM field : GTS - IVM*2*101
 ;DGFIVM is YES when source of Means Test is DCD or IVM
 N DGFIVM ;IVM*2*101
 S DGFIVM=$$SRCOFMT^IVMCM3(DGMTI) ;IVM*2*101
 ;
 L +^DGPR(408.12,+DGPRI) S $P(^DGPR(408.12,DA(1),"E",DA,0),"^",2,4)=1_"^"_DGFIVM_"^"_DGMTI D IX1^DIK L -^DGPR(408.12,+DGPRI)
 K IVMEFFDT,DA,DIC,DIK
 ;
 ; replace relationship in 408.12 with IVM relationship if different
 ; and add both values to 408.41
 ;
 Q:IVMRELN=IVMRELO
 S DA=DGPRI,DIE="^DGPR(408.12,",DR=".02////^S X=IVMRELN" D ^DIE K DA,DIE,DR
 S DGMTYPT=1,DGMTACT="REL",DGMTSOLD=IVMRELO,DGMTSNEW=IVMRELN,DGDEPI=DGIPI,DGMTA=DGMTP
 D SET^DGMTAUD
 K DGDEPI,DGMTA,DGMTACT,DGMTSNEW,DGMTSOLD
 Q
 ;
NEWPR ;Add entry to file #408.12
 ;In -  dgrp0nd  0 node of 408.12
 ;      ivmeffdt effective date of dependent
 ;      ivmreln  IVM relationship
 ;Out - dgpri ien of new 408.12 entry
 ;
 N DGFIVM ;IVM*2*101
 S DGRP0ND=DFN_"^"_IVMRELN_"^"_+DGIPI_";DGPR(408.13,"
 ;
 K DINUM
 S (DIK,DIC)="^DGPR(408.12,",DIC(0)="L",DLAYGO=408.12,X=+DGRP0ND K DD,DO D FILE^DICN S (DGPRI,DA)=+Y K DLAYGO
 ;
 ; if can't create stub notify site & IVM Center
 I DGPRI'>0 D  Q
 .S (IVMTEXT(6),HLERR)="Can't create stub for file 408.12"
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 .S IVMFERR=""
 ;
 ;Set value of FILED BY IVM field : GTS - IVM*2*101
 ;DGFIVM is YES when source of Means Test is DCD or IVM
 S DGFIVM=$$SRCOFMT^IVMCM3(DGMTI)
 ;
 ;Create Patient Relation record : GTS - IVM*2*101 (DGFIVM replaces default of 1)
 L +^DGPR(408.12,+DGPRI) S ^DGPR(408.12,+DGPRI,0)=DGRP0ND,^DGPR(408.12,+DGPRI,"E",0)="^408.1275D^1^1",^(1,0)=IVMEFFDT_"^"_1_"^"_DGFIVM_"^"_DGMTI D IX1^DIK L -^DGPR(408.12,+DGPRI)
 K IVMEFFDT,DA,DIC,DIK
 ;
 ; to prevent the logic in IVMUM2 from matching a dependent sent from
 ; the IVM Center (with no 408.12 ien) with this dependent, an entry
 ; is made in array IVMAR.  subscripts of this array is ien of 408.12
 ; transmitted by the IVM Center or created or found by upload.
 S IVMAR(DGPRI)=""
 Q
