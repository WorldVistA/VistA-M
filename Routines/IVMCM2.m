IVMCM2 ;ALB/SEK,CKN,TDM - ADD NEW DCD DEPENDENT TO INCOME PERSON FILE ; 3/18/10 2:07pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,105,115,139,121**;21-OCT-94;Build 45
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; this routine will add entries to INCOME PERSON file (408.13) for
 ; new dependents (spouse/children).  if DCD demo data (name, dob, 
 ; ssn, sex) is different than VAMC data, 408.13 will be changed to
 ; contain the DCD data.  the MEANS TEST CHANGES file (408.41) will
 ; contain both values.
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
 N IVMSPFLG,IVMSPMNM
 N IVMZDP13,IVMSADL1,IVMSADL2,IVMSADL3,IVMSCITY,IVMSST,IVMSZIP,IVMSALU,IVMSTELE
 N IVMAL113,IVMAL213,IVMAL313,IVMCTY13,IVMST13,IVMZIP13,IVMTEL13,IVMALU13
 S (IVMFLG1,IVMFLG2,IVMFLG5)=0
 S IVMSPFLG=1 ; VOA
 S DGPRI=$P(IVMSEG,"^",7) ; ien of patient relation file
 ;
 S IVMNM=$$FMNAME^HLFNC($P(IVMSEG,"^",2)),IVMSEX=$P(IVMSEG,"^",3),IVMDOB=$$FMDATE^HLFNC($P(IVMSEG,"^",4)),IVMSSN=$P(IVMSEG,"^",5)
 S IVMPSSNR=$P(IVMSEG,"^",10) ;Pseudo SSN Reason IVM*2*105
 ;if there is a valid Pseudo SSN Reason, then append a "P" to the end
 ;of the SSN so that it cam be recognized on VistA as a pseudo - IVM*2*115
 S IVMSSN=$G(IVMSSN)_$S($G(IVMPSSNR)="N":"P",$G(IVMPSSNR)="R":"P",$G(IVMPSSNR)="S":"P",1:"")
 S IVMEFFDT=$$FMDATE^HLFNC($P(IVMSEG,"^",9)),IVMRELN=$P(IVMSEG,"^",6)
 S IVMSPMNM=$P(IVMSEG,"^",8) ;Spouse Maiden Name IVM*2*105
 ;If not valid value, set it to null
 I IVMPSSNR]"",IVMPSSNR'="R",IVMPSSNR'="S",IVMPSSNR'="N" S IVMPSSNR=""
 S IVMSSNVS=$P(IVMSEG,"^",12) ;SSN Verification Status IVM*2*115
 ;If not valid value, set it to null
 I IVMSSNVS]"",IVMSSNVS'=2,IVMSSNVS'=4 S IVMSSNVS=""  ;IVM*2*115
 ;
 I IVMSPCHV="S"&((IVMNM']"")!(IVMSEX']"")!(IVMDOB']"")) S IVMFLG5=1 Q
 ;
 ; VOA Spouse additional info
 S IVMZDP13=$P(IVMSEG,"^",13)
 S IVMSADL1=$P(IVMZDP13,$E(HLECH,1),1) ; Addr Line 1 - 13.1
 S IVMSADL2=$P(IVMZDP13,$E(HLECH,1),2) ; Addr Line 2 - 13.2
 S IVMSADL3=$P(IVMZDP13,$E(HLECH,1),8) ; Addr Line 3 - 13.8
 S IVMSCITY=$P(IVMZDP13,$E(HLECH,1),3) ; City - 13.3
 S IVMSST=$P(IVMZDP13,$E(HLECH,1),4) ; State - 13.4
 S IVMSZIP=$P(IVMZDP13,$E(HLECH,1),5) ; Zip - 13.5
 S IVMSALU=$P(IVMZDP13,$E(HLECH,1),12)
 S IVMSALU=$P(IVMSALU,$E(HLECH,2),1) ; Addr Last DT/TM Upt - 13.12.1
 S IVMSALU=$$FMDATE^HLFNC(IVMSALU) ; Convert DT/TM from HL7 to FM
 S IVMSTELE=$P(IVMSEG,"^",14)
 S IVMSTELE=$P(IVMSTELE,$E(HLECH,1),1) ; Telephone - 14.1
 ;
 I 'DGPRI G NOIEN
 ;
 ; if ien of patient relation file (dgpri) transmitted by IVM Center
 ; and found in 408.12, get ien of income person.  if DCD demo data
 ; is different, change in 408.13 & add to 408.41
 ; ivmprn is 0 node of 408.12
 ; dgipi is ien of 408.13
 S IVMPRN=$G(^DGPR(408.12,+DGPRI,0))
 I IVMPRN]"" D GETIPI Q:$D(IVMFERR)  S DGIPI=+$P($P(IVMPRN,"^",3),";"),IVMFLG1=1,IVMRELO=$P(IVMPRN,"^",2) D AUDITP^IVMCM9,AUDIT^IVMCM9 Q
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
 I IVMFLG1 S DGIPI=+$P($P(IVMPRN,"^",3),";") D AUDITP^IVMCM9,AUDIT1^IVMCM9 Q
 ;
 ; dependent not found. add record to 408.13
 I 'IVMFLG1 D
 .S $P(IVMSTR,"^")=IVMNM,$P(IVMSTR,"^",2)=IVMSEX,$P(IVMSTR,"^",3)=IVMDOB,$P(IVMSTR,"^",9)=IVMSSN,$P(IVMSTR,"^",10)=IVMPSSNR,$P(IVMSTR,"^",11)=IVMSSNVS
 .S $P(IVMSTR1,"^")=IVMSPMNM
 .S $P(IVMSTR1,"^",2)=IVMSADL1,$P(IVMSTR1,"^",3)=IVMSADL2,$P(IVMSTR1,"^",4)=IVMSADL3
 .S $P(IVMSTR1,"^",5)=IVMSCITY,$P(IVMSTR1,"^",6)=IVMSST,$P(IVMSTR1,"^",7)=IVMSZIP,$P(IVMSTR1,"^",8)=IVMSTELE
 .S $P(IVMSTR1,"^",9)=IVMSALU
 .D ADDDEP
 Q
 ;
ADDDEP ; add dependent to 408.13 file
 ; In - DFN=IEN of File #2
 ;      DGRP0ND=0 node of 408.13
 ;      DGRP1ND=1 node of 408.13
 ;Out - DGIPI=408.13 IEN
 ;
 N X,Y
 S DGRP0ND=IVMSTR
 S DGRP1ND=IVMSTR1
 K DINUM
 N CNT,I S CNT=0
 F I=2,3,9 D
 .S CNT=CNT+1,$P(DIC("DR"),";",CNT)=".0"_I_"////"_$P(DGRP0ND,U,I)
 F I=10,11 D
 .S CNT=CNT+1,$P(DIC("DR"),";",CNT)="."_I_"////"_$P(DGRP0ND,U,I)
 F I=1:1:8 S DIC("DR")=DIC("DR")_";1."_I_"////"_$P(DGRP1ND,U,I)
 S (DIK,DIC)="^DGPR(408.13,",DIC(0)="L",DLAYGO=408.13,X=$P(DGRP0ND,"^") K DD,DO D FILE^DICN S (DGIPI,DA)=+Y K DLAYGO
 ;
 ; if can't create stub notify site & IVM Center
 I DGIPI'>0 D  Q
 .S (IVMTEXT(6))="Can't create stub for file 408.13"
 .D PROB^IVMCMC(IVMTEXT(6))
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 .S IVMFERR=""
 S IVMFLG2=1 ; added dep to 408.13 must add to 408.12
 K DIK,DIC
 Q
 ;
 ;
GETIP ; if can't find 408.12 record notify site & IVM Center
 S IVMPRN=$G(^DGPR(408.12,+DGPRI,0))
 S IVMRELO=$P(IVMPRN,"^",2)
 I IVMPRN']"" D  Q
 .S (IVMTEXT(6))="Can't find 408.12 record "_DGPRI
 .D PROB^IVMCMC(IVMTEXT(6))
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 .S IVMFERR=""
 Q:IVMRELO=1
 ;
GETIPI ; ivmseg13 is 0 node of income person file
 ; get demo data in 408.13 & 408.12
 S IVMSEG13=$$DEM^DGMTU1(DGPRI)
 S IVMSG131=$$DEM1^DGMTU1(DGPRI) ;Get node 1
 I IVMSEG13']"" D  Q
 .S (IVMTEXT(6))="Can't find 408.13 record"
 .D PROB^IVMCMC(IVMTEXT(6))
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 .S IVMFERR=""
 S IVMSEX13=$P(IVMSEG13,"^",2),IVMDOB13=$P(IVMSEG13,"^",3),IVMSSN13=$P(IVMSEG13,"^",9),IVMPSR13=$P(IVMSEG13,"^",10),IVMSVS13=$P(IVMSEG13,"^",11)
 S IVMSMN13=$P($G(IVMSG131),"^")
 S IVMNM13=$P(IVMSEG13,"^")
 S IVMAL113=$P($G(IVMSG131),"^",2),IVMAL213=$P($G(IVMSG131),"^",3),IVMAL313=$P($G(IVMSG131),"^",4)
 S IVMCTY13=$P($G(IVMSG131),"^",5),IVMST13=$P($G(IVMSG131),"^",6),IVMZIP13=$P($G(IVMSG131),"^",7)
 S IVMTEL13=$P($G(IVMSG131),"^",8),IVMALU13=$P($G(IVMSG131),"^",9)
 Q
