WVSNOMED ;HIOFO/FT-IS LAB TEST A PAP SMEAR? ;2/12/04  14:37
 ;;1.0;WOMEN'S HEALTH;**16,23**;Sep 30, 1998;Build 5
 ;
 ; This routine uses the following IAs:
 ;  #1362 - ^ORB3               (controlled)
 ;   #525 - ^LR references      (controlled)
 ;  #4298 - ^LR references      (private)
 ; #10035 - ^DPT( references    (supported)
 ; #10070 - ^XMD                (supported)
 ; #10141 - ^XPDUTL             (supported)
 ;
SNOMED() ; Check lab test for SNOMED codes that indicate if pap smear.
 ; LRDFN,LRI,LRSS must be defined.
 ; Returns: 0 - lab test is not a pap smear
 ;          1 - lab test is a pap smear
 ; 
 N WVPAP,WVPIEN,WVPIEN1,WVSNOMED,WVTOP
 ; WVTOP array identifies SNOMED codes (IENS) used for pap smears
 S WVTOP(0)=0
 S WVPIEN=$$PAPIEN^WVRPCPR()
 I 'WVPIEN Q 0  ;pap smear procedure entry not found
 S WVPIEN1=0
 F  S WVPIEN1=$O(^WV(790.2,WVPIEN,2,WVPIEN1)) Q:'WVPIEN1  D
 .S WVSNOMED=$P($G(^WV(790.2,WVPIEN,2,WVPIEN1,0)),U,1)
 .Q:'WVSNOMED
 .S WVTOP(0)=WVTOP(0)+1
 .S WVTOP(WVSNOMED)=""
 .Q
 I WVTOP(0)=0 Q 0  ;no SNOMED codes identified
 K WVTOP(0)
 S WVPAP=0
 I LRSS="CY" S WVPAP=$$CY()
 I LRSS="SP" S WVPAP=$$SP()
 Q WVPAP
 ;
CY() ; Check SNOMED codes used by cytology entry
 N WVFLAG,WVLOOP,WVLOOP1,WVSNOMED
 S (WVFLAG,WVLOOP)=0
 ; check topography multiple
 F  S WVLOOP=$O(^LR(LRDFN,"CY",LRI,2,WVLOOP)) Q:'WVLOOP!(WVFLAG=1)  D
 .S WVSNOMED=+$P($G(^LR(LRDFN,"CY",LRI,2,WVLOOP,0)),U,1)
 .Q:'WVSNOMED
 .I $D(WVTOP(WVSNOMED)) S WVFLAG=1
 .Q
 Q WVFLAG
 ;
SP() ; Check SNOMED codes used by surgical pathology entry
 N WVFLAG,WVLOOP,WVLOOP1,WVSNOMED
 ; check topography multiple
 S (WVFLAG,WVLOOP)=0
 F  S WVLOOP=$O(^LR(LRDFN,"SP",LRI,2,WVLOOP)) Q:'WVLOOP!(WVFLAG=1)  D
 .S WVSNOMED=+$P($G(^LR(LRDFN,"SP",LRI,2,WVLOOP,0)),U,1)
 .Q:'WVSNOMED
 .I $D(WVTOP(WVSNOMED)) S WVFLAG=1
 .Q
 Q WVFLAG
 ;
ADD ; Add pap smear to FILE 790.1
 N WV7901,WVDR,WVPIEN,WVERR
 S WVERR=0
 I '$D(^WV(790,DFN,0)) D  ;add patient to File 790, if not there
 .D AUTOADD^WVPATE(DFN,DUZ(2),.WVERR)
 .Q
 Q:WVERR<0  ;quit if new patient could not be added to File 790
 S WVPIEN=$$PAPIEN^WVRPCPR()
 S WVDR=".02////"_DFN
 S WVDR=WVDR_";.04////"_WVPIEN ;File 790.2 pointer
 S:WVPROV]"" WVDR=WVDR_";.07////"_WVPROV ;provider
 S WVDR=WVDR_";.1////"_$G(DUZ(2)) ;health care facility
 S:WVLOC]"" WVDR=WVDR_";.11////"_WVLOC ;patient location
 S WVDR=WVDR_";.12////"_WVDATE ;procedure date/time
 S WVDR=WVDR_";.14////"_"o" ;status
 S WVDR=WVDR_";.18////.5;.19////"_DT ;entering user and date
 S WVDR=WVDR_";.34////"_$G(DUZ(2)) ;accessioning facility
 S WVDR=WVDR_";2.17////"_WVLABAN ;lab accession#
 S WVDR=WVDR_";2.18////"_LRDFN ;Lab Data file (#63) pointer
 S WVDR=WVDR_";2.19////"_LRI ;Lab Data file inverse d/t
 S WVDR=WVDR_";2.2////"_LRSS ;Lab Data file subscript (CY/SP)
 ; add procedure to File 790.1
 D NEW2^WVPROC(DFN,WVPIEN,WVDATE,WVDR,"","",.WVERR)
 Q:'Y
 S WV7901=+Y
 I $$PATCH^XPDUTL("OR*3.0*210") D  Q
 .D CPRS^WVSNOMED(70,DFN,"",WVPROV,"Pap Smear results available.",LRSS_U_WVLABAN_U_LRI)
 .Q
 D MAIL(DFN,WVLABAN,WVPROV,LRSS,WV7901)
 Q
MAIL(DFN,WVLABAN,WVPROV,LRSS,WV7901) ; Send mail message to case manager
 ; when pap smear added to FILE 790.1
 ; Called from above
 ;      DFN -> Patient ien
 ;  WVLABAN -> Lab Accession# (e.g., CY 99 1)
 ;   WVPROV -> File 200   IEN (provider/requestor)
 ;     LRSS -> File 63 subscript (e.g., CY or SP)
 ;   WV7901 -> FILE 790.1 IEN
 Q:'$G(DFN)!($G(WVLABAN)="")!($G(LRSS)="")
 N WVCMGR,WVLOOP,WVMSG,XMDUZ,XMSUB,XMTEXT,XMY
 S WVCMGR=+$$GET1^DIQ(790,DFN,.1,"I") ;get case manager
 S:WVCMGR XMY(WVCMGR)=""
 ; if no case manager, then get default case manager(s)
 I 'WVCMGR S WVLOOP=0 F  S WVLOOP=$O(^WV(790.02,WVLOOP)) Q:'WVLOOP  D
 .S WVCMGR=$$GET1^DIQ(790.02,WVLOOP,.02,"I")
 .S:WVCMGR XMY(WVCMGR)=""
 .Q
 Q:$O(XMY(0))'>0  ;no case manager(s)
 S XMDUZ=.5 ;message sender
 S XMSUB="Pap Smear report verified for a WH patient"
 S WVMSG(1)="A "_$S(LRSS="CY":"Cytology ",LRSS="SP":"Surgical Pathology ",1:"")_"lab test was verified for:"
 S WVMSG(2)=" "
 S WVMSG(3)="                Patient: "_$P($G(^DPT(DFN,0)),U,1)_" (SSN: "_$$SSN^WVUTL1(DFN)_")"
 S WVMSG(4)="         WH Accession #: "_$P($G(^WV(790.1,+WV7901,0)),U,1)
 S WVMSG(5)="        LAB Accession #: "_WVLABAN
 S WVMSG(6)="Test Requestor/Provider: "_$S(+WVPROV:$$GET1^DIQ(200,+WVPROV,.01,"E"),1:"UNKNOWN")
 S WVMSG(7)=" "
 S WVMSG(8)="Please use CPRS to resolve the Clinical Reminder for this procedure and"
 S WVMSG(9)="complete the result."
 S XMTEXT="WVMSG("
 D ^XMD
 Q
 ;
CPRS(WVORN,WVDFN,WVORDER,WVPROV,WVMSG,WVIEN) ; Generate a CPRS alert
 ;   WVORN - FILE 100.9 IEN
 ;   WVDFN - FILE 2 IEN
 ; WVORDER - FILE 100 IEN (not currently used)
 ;  WVPROV - FILE 200 IEN
 ;   WVMSG - Free text message
 ;   WVIEN - IEN for a lab or radiology report (not currently used)
 ;
 Q:'$$PATCH^XPDUTL("OR*3.0*210")  ;no pap & mam alerts 
 Q:'WVDFN
 Q:'WVORN
 I WVPROV]"" S WVARRAY(WVPROV)="" ;provider's IEN
 S WVCMGR=$P($G(^WV(790,WVDFN,0)),U,10)
 I WVCMGR]"" S WVARRAY(WVCMGR)="" ;women's health case manager's IEN
 D EN^ORB3(WVORN,WVDFN,WVORDER,.WVARRAY,WVMSG,WVIEN)
 K WVARRAY,WVCMGR
 Q
