DGPMDD1 ;ALB/MRL - FILE 405 'SET' X-REFERENCES; 08 NOV 88 ; 11/5/03 1:24pm
 ;;5.3;Registration;**156,555**;Aug 13, 1993
 D FLDS^DGPMDD2 G Q:DGPMDDER I DGPMDD(2)']"" G 14:DGPMDDF=14,Q
 I "^1^2^3^22^"[("^"_+DGPMDDF_"^"),DGPMDD(3) S ^DGPM("ATT"_+DGPMDD(2),+DGPMDD(1),DA)="",^DGPM("APTT"_+DGPMDD(2),+DGPMDD(3),+DGPMDD(1),DA)="",^DGPM("AMV"_+DGPMDD(2),+DGPMDD(1),+DGPMDD(3),DA)="",^DGPM("ATID"_+DGPMDD(2),+DGPMDD(3),DGPMDDID,DA)=""
 I DGPMDD(2)=4!(DGPMDD(2)=5) G Q
 I "^1^3^22^"[("^"_+DGPMDDF_"^"),DGPMDD(3),DGPMDD(2)'=6 S ^DGPM("APID",+DGPMDD(3),DGPMDDID,DA)="",^DGPM("APRD",+DGPMDD(3),+DGPMDD(1),DA)=""
 I "^1^3^9^22^"[("^"_+DGPMDDF_"^"),DGPMDD(9),DGPMDD(14),DGPMDD(3) S ^DGPM("ATS",+DGPMDD(3),+DGPMDD(14),DGPMDDID,+DGPMDD(9),DA)=""
 I "^1^3^22^23^"[("^"_+DGPMDDF_"^"),DGPMDD(23) S ^DGPM("ADMMS",+DGPMDD(3),DGPMDDID,DGPMDD(23),DA)=""
14 I "^1^3^14^22^"[("^"_+DGPMDDF_"^"),DGPMDD(14),DGPMDD(2)'=6 S ^DGPM("APMV",+DGPMDD(3),+DGPMDD(14),DGPMDDID,DA)="",^DGPM("APCA",+DGPMDD(3),+DGPMDD(14),+DGPMDD(1),DA)=""
Q K DGPMDD,DGPMDDF,DGPMDDN,DGPMDDER,DGPMDDID Q
 ;
DES ;ATT - ^DGPM("ATT"_Transaction#,Date,DA)=""
 ;ATID - ^DGPM("ATID"_Transaction type,DFN,Inverse Date,DA)=""
 ;APID - ^DGPM("APID",Patient,Inverse Date,DA)=""
 ;APTT - ^DGPM("APTT"_Transaction#,Patient,Date,DA)=""
 ;APCA - ^DGPM("APCA",Patient,Corresponding Admission,Date,DA)=""
 ;APMV - ^DGPM("APMV",Patient,Corresponding Admit,Inverse Date,DA)=""
 ;APRD - ^DGPM("APRD",Patient,Date,DA)=""
 ;AMV - ^DGPM("AMV"_TT,Date,Patient,DA)=""
 ;ATS - ^DGPM("ATS",DFN,Corresponding Admission,Inverse Date,Treating Specialty,DA)
 ;ADMMS - ^DGPM("ADMMS",DFN,Inverse Date,DMMS Episode number,DA)
