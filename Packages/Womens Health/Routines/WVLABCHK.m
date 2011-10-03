WVLABCHK ;HIOFO/FT-IS LAB TEST A PAP SMEAR? ;10/25/04  10:23
 ;;1.0;WOMEN'S HEALTH;**16,23**;Sep 30, 1998;Build 5
 ;
 ; This routine uses the following IAs:
 ;   #525 - ^LR references      (controlled)
 ;  #4298 - ^LR references      (private)
 ; #10103 - ^XLFDT calls        (supported)
 ; #10063 - ^%ZTLOAD            (supported)
 ; #10141 - ^XPDUTL             (supported)
 ; #10035 - ^DPT                (supported)
 ;
 ; This routine supports the following IAs:
 ; CREATE - 4525
 ;
CREATE(DFN,LRDFN,LRI,LRA,LRSS) ;
 ; Add lab test to WH file (#790.08).
 ; Called by REPORT RELEASE DATE/TIME field in:
 ; a) File 63, Field 63.08,.11
 ; b) File 63, Field 63.09,.11
 ; Input: DFN    = PATIENT DFN
 ;        LRDFN  = FILE 63 IEN (+^DPT(DFN,"LR"))
 ;        LRI    = INVERSE DATE/TIME OF TEST
 ;        LRA    = ZERO NODE OF THE CY or SP ENTRY
 ;        LRSS   = File 63 subscript (e.g., CY or SP)
 ;
 Q:($G(DFN)']"")!($G(LRDFN)']"")!($G(LRI)']"")!($G(LRA)']"")!($G(LRSS)']"")
 Q:'$D(^WV(790.02,DUZ(2)))  ;no site parameter entry
 Q:'$P($G(^WV(790.02,+$G(DUZ(2)),0)),U,24)  ;lab link is NO or null
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="CREATEQ^WVLABCHK",ZTDESC="WV CHECK SNOMED CODE CHANGES"
 S ZTSAVE("DFN")="",ZTSAVE("LRDFN")="",ZTSAVE("LRI")="",ZTSAVE("LRA")=""
 S ZTSAVE("LRSS")="",ZTIO=""
 S ZTDTH=$$HADD^XLFDT($H,"","","",150) ;don't want the SNOMED trigger to 
 ; conflict with the report verification trigger
 D ^%ZTLOAD
 Q
CREATEQ ; Called from CREATE above
 I $D(ZTQUEUED) S ZTREQ="@"
 N WVDATE,WVDFN,WVDUZ2,WVIEN,WVLABAN,WVLOC,WVLRDFN,WVLRI,WVLRSS,WVNODE,WVPAP,WVPIEN,WVPROV,WVTOP,X,Y
 Q:$P($G(^DPT(DFN,0)),U,2)'="F"  ;not female
 S WVLABAN=$P(LRA,U,6) ;lab accession#
 Q:$D(^WV(790.1,"F",WVLABAN))  ;already tracked
 ; check WH site parameters
 Q:'$D(^WV(790.02,DUZ(2)))  ;no site parameter entry
 Q:'$P($G(^WV(790.02,+$G(DUZ(2)),0)),U,24)  ;lab link is NO or null
 Q:'$$VNVEC^WVLRLINK()  ;vet/non-vet/eligibility code check
 D CODES ;what SNOMED codes are we looking for?
 I WVTOP(0)=0 Q  ;no SNOMED codes identified
 S WVPIEN=$$PAPIEN^WVRPCPR()
 Q:'WVPIEN
 S WVIEN=$O(^WV(790.08,"B",WVLABAN,0))
 Q:'WVIEN
 S WVNODE=$G(^WV(790.08,WVIEN,0))
 Q:WVNODE=""
 S WVLRDFN=$P(WVNODE,U,36)
 Q:'WVLRDFN
 S WVLRI=$P(WVNODE,U,37)
 Q:'WVLRI
 S WVLRSS=$P(WVNODE,U,38)
 S WVDFN=$P(WVNODE,U,2)
 S WVPROV=$P(WVNODE,U,7)
 S WVLOC=$P(WVNODE,U,11)
 S WVDATE=$P(WVNODE,U,12)
 S WVLABAN=$P(WVNODE,U,1)
 S WVDUZ2=$P(WVNODE,U,10)
 I WVLRSS="CY" D  Q
 .S WVPAP=$$CY()
 .D:WVPAP ADD
 .Q
 I WVLRSS="SP" D  Q
 .S WVPAP=$$SP()
 .D:WVPAP ADD
 .Q
 Q
 ;
CODES ; WVTOP array identifies SNOMED codes (IENS) used for pap smears
 N WVPIEN,WVPIEN1,WVSNOMED
 S WVTOP(0)=0
 S WVPIEN=$$PAPIEN^WVRPCPR()
 I 'WVPIEN Q  ;pap smear procedure not identified
 S WVPIEN1=0
 F  S WVPIEN1=$O(^WV(790.2,WVPIEN,2,WVPIEN1)) Q:'WVPIEN1  D
 .S WVSNOMED=$P($G(^WV(790.2,WVPIEN,2,WVPIEN1,0)),U,1)
 .Q:'WVSNOMED
 .S WVTOP(0)=WVTOP(0)+1
 .S WVTOP(WVSNOMED)=""
 .Q
 Q
CY() ; Check SNOMED codes used by cytology entry
 N WVFLAG,WVLOOP,WVSNOMED
 S (WVFLAG,WVLOOP)=0
 ; check topography multiple
 F  S WVLOOP=$O(^LR(WVLRDFN,"CY",WVLRI,2,WVLOOP)) Q:'WVLOOP!(WVFLAG=1)  D
 .S WVSNOMED=+$P($G(^LR(WVLRDFN,"CY",WVLRI,2,WVLOOP,0)),U,1)
 .Q:'WVSNOMED
 .I $D(WVTOP(WVSNOMED)) S WVFLAG=1
 .Q
 Q WVFLAG
 ;
SP() ; Check SNOMED codes used by surgical pathology entry
 N WVFLAG,WVLOOP,WVSNOMED
 ; check topography multiple
 S (WVFLAG,WVLOOP)=0
 F  S WVLOOP=$O(^LR(WVLRDFN,"SP",WVLRI,2,WVLOOP)) Q:'WVLOOP!(WVFLAG=1)  D
 .S WVSNOMED=+$P($G(^LR(WVLRDFN,"SP",WVLRI,2,WVLOOP,0)),U,1)
 .Q:'WVSNOMED
 .I $D(WVTOP(WVSNOMED)) S WVFLAG=1
 .Q
 Q WVFLAG
 ;
ADD ; Add pap smear to FILE 790.1
 N WVDR,WVERR
 S WVERR=0
 I '$D(^WV(790,WVDFN,0)) D  ;add patient to File 790, if not there
 .D AUTOADD^WVPATE(WVDFN,WVDUZ2,.WVERR)
 .Q
 Q:WVERR<0  ;quit if new patient could not be added to File 790
 S WVDR=".02////"_WVDFN
 S WVDR=WVDR_";.04////"_WVPIEN ;File 790.2 pointer
 S:WVPROV]"" WVDR=WVDR_";.07////"_WVPROV ;provider
 S WVDR=WVDR_";.1////"_WVDUZ2 ;health care facility
 S:WVLOC]"" WVDR=WVDR_";.11////"_WVLOC ;patient location
 S WVDR=WVDR_";.12////"_WVDATE ;procedure date/time
 S WVDR=WVDR_";.14////"_"o" ;status
 S WVDR=WVDR_";.18////.5;.19////"_DT ;entering user and date
 S WVDR=WVDR_";.34////"_WVDUZ2 ;accessioning facility
 S WVDR=WVDR_";2.17////"_WVLABAN ;lab accession#
 S WVDR=WVDR_";2.18////"_WVLRDFN ;Lab Data file (#63) pointer
 S WVDR=WVDR_";2.19////"_WVLRI ;Lab Data file inverse d/t
 S WVDR=WVDR_";2.2////"_WVLRSS ;Lab Data file subscript (CY/SP)
 ; add procedure to File 790.1
 D NEW2^WVPROC(WVDFN,WVPIEN,WVDATE,WVDR,"","",.WVERR)
 Q:'Y
 I $$PATCH^XPDUTL("OR*3.0*210") D
 .D CPRS^WVSNOMED(70,WVDFN,"",WVPROV,"Pap Smear results available.",WVLRSS_U_WVLABAN_U_WVLRI)
 .D DELETE^WVLABADD(WVIEN)
 .Q 
 Q
