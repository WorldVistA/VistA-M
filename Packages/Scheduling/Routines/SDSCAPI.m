SDSCAPI ;ALB/JDS/JAM/RBS - Automated Service Connection Designation Review ; 4/16/07 10:39am
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ; Routine should be called at specified tags only.
 Q
SC(SDFN,SDXS,SDENC,SDVST) ; Determine if SC based on DXS codes
 ;  Input:
 ;    SDFN = Patient ien, file #2 [Required, if SDENC or SDVST undefined]
 ;    SDXS = Diagnosis code array [Optional, if SDENC defined]
 ;   SDENC = Encounter ien, file #409.68 [Optional]
 ;   SDVST = Visit ien, field #9000010 [Optional]
 ;
 ;  Output:
 ;    $$SDFILEOK = (4 piece data string ^ delimited)
 ;                 (SC flag^SC description^VBA/ICD9 match^ASCD Review)
 ;        SC flag:  1-SC, 0-NSC, ""-could not be determined
 ; SC description:  SC or NSC
 ; VBA/ICD9 match:  1-yes, 0-no
 ;           ASCD:  1-send to review, 0-don't send to review
 ;
 N SDOE0,SDFILEOK,SDOEDAT,SDKILL
 S SDENC=+$G(SDENC),SDFILEOK=""
 I 'SDENC S SDENC=+$O(^SCE("AVSIT",+$G(SDVST),0))
 I SDENC S SDOE0=$$GETOE^SDOE(SDENC)
 S SDOEDAT=$S(SDENC:+SDOE0,+$G(SDVST):+$G(^AUPNVSIT(SDVST,0)),1:DT)
 ; Get patient. If no patient, quit.
 I '$G(SDFN) S SDFN=$S(SDENC:$P(SDOE0,U,2),+$G(SDVST):$P($G(^AUPNVSIT(SDVST,0)),U,5),1:"")
 I '$G(SDFN) Q SDFILEOK
 ; diagnosis codes present
 I $O(SDXS(0)) D OPT3 Q SDFILEOK
 I 'SDENC Q SDFILEOK
 D OPT2 I $D(SDKILL) K SDXS
 Q SDFILEOK
 ;
OPT2 ; enter with no DXS defined; get ICD9 for visit/encounter
 N SCDXS
 K SDXS
 I '+$G(SDENC) Q
 D GETDX^SDOE(SDENC,"SCDXS")
 S SDXS=0 F  S SDXS=$O(SCDXS(SDXS)) Q:'SDXS  S SDXS(+SCDXS(SDXS))=""
 I $O(SDXS(0))="" Q
 S SDKILL=1
OPT3 ; enter with DXS defined
 N I,SDRD,SDRDIEN,SD31,ICDMCH,SDMCH,FL,SDARR
 ; Patient has no rated disabilities
 D RDIS^DGRPDB(SDFN,.SDARR)
 I '$D(SDARR) S SDFILEOK="1^SC^0^1" Q
 ; Patient has rated disabilities
 S (SDRD,FL)=0
 F  S SDRD=$O(SDARR(SDRD)) Q:'SDRD  D
 .S SDRDIEN=$P(SDARR(SDRD),U) Q:SDRDIEN=""
 .; Get code from eligibility file.
 .S I=0,SD31=$G(^DIC(31,SDRDIEN,0)) Q:SD31=""
 .; Get partial or true match on ICD9 code
 .F  S I=$O(SDXS(I)) Q:'I  D
 ..S SDMCH=$$MATCH(SDRDIEN,I,SDOEDAT,SDENC),ICDMCH(SDMCH)=""
 ; locate entry in the following priority order -
 F I="1^SC^1^0","1^SC^1^1","0^NSC^0^1","1^SC^0^1" I $D(ICDMCH(I)) S SDFILEOK=I Q
 Q
 ;
STORE ; Save the information for this encounter.
 N SDSC,SDIEN,SDERR
 S SDIEN(1)=SDENC
 S SDSC(409.48,"+1,",.01)=SDENC
 S SDSC(409.48,"+1,",.04)=DT
 S SDSC(409.48,"+1,",.07)=+SDOE0
 S SDSC(409.48,"+1,",.08)=SDPRV
 S SDSC(409.48,"+1,",.09)=$P(SDFILEOK,U,3)
 S SDSC(409.48,"+1,",.11)=$P(SDOE0,U,2)
 S SDSC(409.48,"+1,",.12)=$P(SDOE0,U,11)
 S SDSC(409.48,"+1,",.05)="N"
 S SDSC(409.48,"+1,",.13)=SDOSC
 D UPDATE^DIE("","SDSC","SDIEN","SDERR")
 I $D(SDERR) S ERR=1
 Q
ST(SDENC,SDXS) ;Reviews the diagnosis codes for an encounter and then
 ;determines whether or not to file, or delete the record from the
 ;ASCD file, SDSC SERVICE CONNECTED CHANGES (#409.48).
 ;
 ;   Input:   SDENC   = Encounter ien, file (#409.68) [Required]
 ;            SDXS    = Diagnosis code array [Optional]
 ;
 ;   Output:  $$ST value
 ;              0 = not filed for additional review
 ;              1 = filed for additional review
 ;              2 = deleted from (#409.48) file
 ;
 N SDLIST,SDOE0,SDEL,SDOEDAT,SDPRV,SDFN,SDFILEOK,ERR,SCVAL,SDCLIN,SDSTP
 N SDPAT,SDCST,SDKILL,SDV0,SDOSC,SDOEDT
 I '$G(SDENC) Q 0
 S SDOE0=$$GETOE^SDOE(SDENC) I SDOE0="" Q 0
 ;quit if child encounter
 I $P(SDOE0,U,6) Q 0
 S SDV0=$P(SDOE0,U,5),SDOSC=$$GET1^DIQ(9000010,SDV0_",",80001,"I")
 S SDPRV=$$PRIMVPRV^PXUTL1(SDV0),SDEL=$P(SDOE0,U,13),SCVAL=0
 S (SDOEDAT,SDOEDT)=+SDOE0,(SDFILEOK,ERR)=0,SDCLIN=$P(SDOE0,U,4)
 S SDCST=$P(SDOE0,U,3),(SDFN,SDPAT)=$P(SDOE0,U,2)
 ;no patient
 I 'SDPAT Q 0
 ;no clinic
 I 'SDCLIN Q 0
 ;no stop code
 I 'SDCST Q 0
 ;no visit SC value
 I SDOSC="" Q 0
 ;not checked-out
 I $P(SDOE0,U,12)'=2 Q 0
 ;check for non-count
 I $$NCTCL^SDSCUTL(SDCLIN) Q 0
 ;no eligibility
 I SDEL="" Q 0
 ;If eligibility is not service connected, quit.
 D ELIG I '$D(SDLIST(SDEL)) Q 0
 ;if non-billable for first and third party, quit
 I $$NBFP^SDSCUTL(SDENC),$$NBTP^SDSCUTL(SDENC) Q 0
 D
 .I $O(SDXS(0)) D OPT3 Q
 .D OPT2 I $D(SDKILL) K SDXS
 I SDFILEOK="" Q 0
 ;File encounter in ASCD if it does not exist
 I $P(SDFILEOK,U,4),'$D(^SDSC(409.48,SDENC,0)) D STORE Q 'ERR
 I '$P(SDFILEOK,U,4) D  Q SCVAL
 .;Set for review if Visit SC is different from ASCD
 .I SDOSC'=$P(SDFILEOK,U) Q:$D(^SDSC(409.48,SDENC,0))  D STORE S SCVAL='ERR Q
 .;Remove encounter from ASCD if no review needed
 .N DA,DIK
 .I $D(^SDSC(409.48,SDENC,0)) S DA=SDENC,DIK="^SDSC(409.48," D ^DIK S SCVAL=2
 Q 0
ELIG ;Compile list of service connected eligibility codes
 N I,J
 F I=1,3 S J=0 F  S J=$O(^DIC(8,"D",I,J)) Q:'J  S SDLIST(J)=""
 Q
MATCH(SDIEN31,SDXIEN,SDATE,SDENC) ;ICD9 matching code
 ; - api should be changed to lexicon in next version
 ;   Input:
 ;     SDIEN31 = File #31 [Required]
 ;     SDXIEN  = Diagnosis code ien, file #80 [Required]
 ;     SDATE   = Encounter date, [Optional] [Required for lexicon]
 ;     SDENC   = Encounter ien, file #409.68 [Required]
 ;
 ;  Output:
 ;    $$SDFILEOK = (4 piece data string ^ delimited)
 ;                 (SC flag^SC description^VBA/ICD9 match^ASCD Review)
 ;        SC flag:  1-SC, 0-NSC, ""-could not be determined
 ; SC description:  SC or NSC
 ; VBA/ICD9 match:  1-yes, 0-no
 ;           ASCD:  1-send to review, 0-don't send to review
 ;
 N SDMCH,SDXIEN1,SDXLVL,SDPDX
 I '$D(^DIC(31,SDIEN31,"ICD")) Q "1^SC^0^1"
 I '$D(^DIC(31,SDIEN31,"ICD","B",SDXIEN)) Q "0^NSC^0^1"
 S SDXIEN1=$O(^DIC(31,SDIEN31,"ICD","B",SDXIEN,0))
 S SDXLVL=$G(^DIC(31,SDIEN31,"ICD",+SDXIEN1,0)),SDMCH=+$P(SDXLVL,U,2)
 I ('SDXIEN1)!(SDXLVL="") Q "0^NSC^0^1"
 D GETPDX^SDOERPC(.SDPDX,SDENC)
 Q $S(SDMCH&(SDPDX=SDXIEN):"1^SC^1^0",1:"1^SC^1^1")
