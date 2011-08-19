VAFHLPD1 ;ALB/RKS,PHH-HL7 PD1 SEGMENT; 26 July 01 ; 3/9/2004 2:09PM
 ;;5.3;Registration;**91,160,229,149,409,389,568**;Jun 06, 1996
 ;
 ;
EN(DFN,VAFSTR) ;Main enty point for building of PD1 Segment
 ;
 ;Input  : DFN - Pointer to entry in PATIENT fiel (#2)
 ;         VAFSTR - String of fields requested separated by commas
 ;         All variables defined by call to INIT^HLFNC2()
 ;Output : PD1 segment
 ;
 N FS,CS,SS,VAFPD1
 S FS=HL("FS"),CS=$E(HL("ECH")),SS=$E(HL("ECH"),4)
 I $G(DFN)="" Q "PD1"_FS
 I $G(^DPT(DFN,0))="" Q "PD1"_FS
 S:($G(VAFSTR)="") VAFSTR="3,4"
 S VAFSTR=","_VAFSTR_","
 S VAFPD1="PD1"_FS
 ;Patient CMOR  (as defined by CIRN)
 I VAFSTR[",3,",('$D(^PPP(1020.128,"AC",$P($$SITE^VASITE,"^",3)))) D
 . ;CIRN check
 . I $T(CHANGE^MPIF001)']"" S $P(VAFPD1,FS,4)=HL("Q")_CS_CS_HL("Q") Q
 . N DIC,DR,DA,DIQ,PTR4,SITENAME,SITENUM,PT,INST
 . S (SITENAME,SITENUM)=""
 . S DIC=2,DR="991.03",DA=DFN,DIQ="PT",DIQ(0)="IE"
 . D EN^DIQ1
 . S PTR4=$G(PT(2,DFN,991.03,"I"))
 . ;IF CMOR DEFINED
 . I PTR4]"" D
 . . S DIC=4,DR="99",DA=PTR4,DIQ="INST",DIQ(0)="IE"
 . . D EN^DIQ1
 . . S SITENAME=$G(PT(2,DFN,991.03,"E"))
 . . S SITENUM=$G(INST(4,PTR4,99,"E"))
 . . Q
 . S $P(VAFPD1,FS,4)=$$HLQ^VAFHUTL(SITENAME)_CS_CS_$$HLQ^VAFHUTL(SITENUM)
 . Q
 ;Primary Care Provider  (as defined by PCMM)
 I VAFSTR[",4," D
 . N PTR200,VAFHLTMP,PCPRV,X
 . ;Get provider (pointer to NEW PERSON file)
 . S PTR200=+$$PCPRACT^DGSDUTL(DFN)
 . I PTR200<1 S $P(VAFPD1,FS,5)=HL("Q") Q
 . ;Get External Provider ID
 . D PERSON^VAFHLRO3(PTR200,"VAFHLTMP",HL("Q"))
 . I ('$D(VAFHLTMP)) S $P(VAFPD1,FS,5)=HL("Q") Q
 . S PCPRV=VAFHLTMP(1,1,1)_SS_VAFHLTMP(1,1,2)
 . F X=2:1:7 S $P(PCPRV,CS,X)=HL("Q")
 . S $P(PCPRV,CS,8)=VAFHLTMP(1,8)
 . S $P(VAFPD1,FS,5)=PCPRV
 . Q
 ;Done
 Q VAFPD1
