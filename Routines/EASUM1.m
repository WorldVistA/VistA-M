EASUM1 ;ALB/SEK,GN - IVM MEANS/COPAY TEST UPLOAD DRIVER ; 7/6/04 1:23pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**23,30,35,42,86**;21-OCT-94;Build 4
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;EAS*1*42 add RX Copay to Z06 Upload/Delete
 ;
EN ; this routine will call routines to upload means tests sent by the IVM
 ; Center in HL7 segments.  the required sequence of these segments were
 ; validated in the calling routine IVMPREC7.  this routine will call
 ; IVMUCHK to ensure that the data is consistent with DHCP means test
 ; file and software requirements.
 ;
 ; entries will be added/modified in the following means test and
 ; patient files:
 ;
 ;       PATIENT RELATION (#408.12)
 ;       INCOME PERSON (#408.13)
 ;       INDIVIDUAL ANNUAL INCOME (#408.21)
 ;       INCOME RELATION (#408.22)
 ;       ANNUAL MEANS TEST (#408.31)
 ;       MEANS TEST CHANGES (#408.41)
 ;       PATIENT (#2)
 ;
 ; current year is date of means test.
 ; income year is calendar year before date of means test.
 ; meant test status is based on income year data.
 ;
 ; IVMDAP is pointer to the PID HL7 segment in file #772
 ; IVMDAZ is pointer to the ZMT segment
 ;
 S:'$D(DUZ) DUZ=.5 ; if no DUZ set to postmaster
 ;
 ; get copay exemption status (IVMCEB) and means test status (IVMMTB)
 ; before upload
 S IVMCEB=$P($$RXST^IBARXEU(DFN),"^",2)
 S IVMMTB=$P($$LST^DGMTU(DFN),"^",3)
 ;
 ; subscript of array IVMAR is ien of 408.12 transmitted by IVM Center
 ; or created by upload.
 ;K IVMAR
 ;S IVMX=$$EN^IVMUCHK() I IVMX]"" S HLERR=IVMX K IVMX Q  ; error found in MT data
 ;
ADD ; add new annual means test file (408.31) stub
 ; input   DGMTDT (.01) dt of test
 ;         DFN (.02) Patient IEN
 ;         DGMTYPT (.19) type of test (1-means test, 2-Rx Copay test)
 ; output  DGMTI annual means test IEN
 S DGMTDT=IVMMTDT
 D ADD^DGMTA
 I $G(IVMMTIEN)="" S IVMMTIEN=$G(DGMTI) ;Set IEN if only MT on file is Z06 MT
 ;
 ;Create new Z06 IVM Means Test
 ; Make STUB MT primary, add comment that it was created by Edb
 S DGCOM="Z06 MT via Edb"
 D PARSEZMT^EASPREC7(ZMTSEG)              ;Parse ZMT Segment for MT Data
 I $$EXPIRED^EASPTRN1(DFN,$G(IVM2)) S DGENUPLD="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS"    ;If MT expired then do not update Enrollment record
 S DA=DGMTI,DIE="^DGMT(408.31,"
 S DR=".03////^S X=IVM3;.12////^S X=IVM8;.07////^S X=IVM10;.09////^S X=IVM25;.11////^S X=IVM7;.18////^S X=IVM12;.23////^S X=IVM18;.25////^S X=IVM20;2////1;2.02////^S X=IVMDATE;2.03////^S X=IVM26;50///^S X=DGCOM"
 ;
 ; Linking logic for MT & CT, conditionally set link field 2.06 
 ;   Link the CT to MT (if MT found), or MT to CT (if CT found)
 ;   don't link tests older than Oct. 1999 or not same Year
 N LNKDAT,LNKMT,LNKDTE,LNKCAT,CURIEN
 S CURIEN=DGMTI,LNKMT=""
 S LNKDAT=$$LST^DGMTU(DFN,DGMTDT,$S(DGMTYPT=1:2,1:1)),DGMTI=CURIEN
 S:LNKDAT LNKMT=+LNKDAT,LNKDTE=$P(LNKDAT,"^",2),LNKCAT=$P(LNKDAT,"^",4)
 ; set LNKMT off if either of two scenarios below
 I LNKMT D
 . I $E(LNKDTE,1,3)'=$E(DGMTDT,1,3) S LNKMT="@" Q
 . I DGMTDT<2991001 S LNKMT="" Q
 S:LNKMT'="" DR=DR_";2.06////^S X=LNKMT"
 ;
 D ^DIE K DA,DIE,DR                            ;update new 408.31 test
 ;
 ; Update other 408.31 related Test, Link field, if link scenario true
 I LNKMT S DA=LNKMT,DIE="^DGMT(408.31,",DR="2.06////^S X=CURIEN" D ^DIE K DA,DIE,DR
 ;
 ;Variables needed for Bulletins
 ;
 S DGCAT=$P($G(^DG(408.32,IVM3,0)),"^",1)
 I '$D(IVM5) S IVM5=""
 ;
 D GETREL^DGMTU11(DFN,"V",DGLY,IVMMTIEN)
 I EASZ06 S (IVMMT31,DGMTP)=$G(^DGMT(408.31,IVMMTIEN,0)) ;dgmtp is event driver variable
 D COMPLETE
 Q
 ;
 ; add dependent(s) to income person file (408.13)
 ;
 ; add spouse if not in 408.13
 S IVMSPCHV="S" ; spouse/child/vet indicator
 S IVMDA1=IVMDAP+3 D GET ; spouse ZDP segment
 D INPIEN^IVMUM2
 Q:$D(IVMFERR)
 ;
 I IVMFLG5 G ADDCHILD ; entry not added - goto add children
 ;
 ; add entry to patient relation file (408.12)
 D EN^IVMUM3
 Q:$D(IVMFERR)
 ;
ADDS21 ; add spouse entry to individual annual income file (408.21)
 S IVMDA1=IVMDAP+4 D GET ; spouse ZIC segment
 D EN^IVMUM4
 Q:$D(IVMFERR)
 ;
 ; add spouse entry to income relation file (408.22)
 S IVMDA1=IVMDAP+5 D GET ; spouse ZIR segment
 D EN^IVMUM5
 Q:$D(IVMFERR)
 ;
ADDCHILD ; add children if not in 408.13
 S IVMSPCHV="C" ; spouse/child/vet indicator
 I 'IVMFLGC G ADDV21 ; no dependent children 
 S IVMCTR2=5
 F IVMCTR3=1:1:IVMFLGC D  Q:$D(IVMFERR)
 .S IVMCTR2=IVMCTR2+1
 .S IVMDA1=IVMDAP+IVMCTR2 D GET ; child ZDP segment
 .D INPIEN^IVMUM2
 .Q:$D(IVMFERR)
 .;
 .; add child entry to patient relation file (408.12)
 .D EN^IVMUM3
 .Q:$D(IVMFERR)
 .;
ADDC21 .; add child entry to individual annual income file (408.21)
 .S IVMCTR2=IVMCTR2+1
 .S IVMDA1=IVMDAP+IVMCTR2 D GET ; child ZIC segment
 .D EN^IVMUM4
 .Q:$D(IVMFERR)
 .;
 .; add entry to income relation file (408.22)
 .S IVMCTR2=IVMCTR2+1
 .S IVMDA1=IVMDAP+IVMCTR2 D GET ; child ZIR segment
 .D EN^IVMUM5
 .Q:$D(IVMFERR)
 .Q
 Q:$D(IVMFERR)
 ;
ADDV21 ; add vet entry to individual annual income file (408.21)
 ; get vet patient relation ien
 S DGPRI=+$G(DGREL("V"))
 S IVMDA1=IVMDAP+1 D GET ; vet ZIC segment
 S IVMSPCHV="V" ; spouse/child/vet indicator
 D EN^IVMUM4
 Q:$D(IVMFERR)
 S DGVINI=DGINI ; vet individual annual income ien
 ;
 ; add vet entry to income relation file (408.22)
 S IVMDA1=IVMDAP+2 D GET ; vet ZIR segment
 D EN^IVMUM5
 Q:$D(IVMFERR)
 S DGVIRI=DGIRI ; vet income relation ien
 ;
COMPLETE ; complete means test
 ;
 ;D EN^IVMUM6
 ;Call Means Test Event Driver to complete processing
 ;
 S DGMTACT="UPL"
 D AFTER^DGMTEVT
 S DGMTINF=1                                    ;Non-Interactive Flag
 D EN^DGMTEVT
 D MTBULL^EASUM7,MAIL^IVMUFNC()               ;Build Mail Message
 ;
 ; cleanup                                  ;EAS*1*42   remove Dgmtypt
 K DGINI,DGIRI,DGLY,DGMTDT,DGPRI,DGREL,DGVINI,DGVIRI,DGENUPLD
 K DGCAT,IVMAR,IVMCEB,IVMCTR2,IVMCTR3,IVMDA1,IVMDAP,IVMFERR
 K IVMFLG2,IVMFLG5,IVMFLGC,IVMMTB,IVMPRN
 K IVMRELN,IVMRELO,IVMSEG,IVMSPCHV,IVMX
 Q
 ; 
GET ; get HL7 segment from ^HL
 S IVMSEG=$P($G(^TMP($J,IVMRTN,IVMDA1,0)),"^",2,999)
 Q
