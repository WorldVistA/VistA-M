WVLRLINK ;HIOFO/FT-LAB-WOMEN'S HEALTH LINK  ;9/29/04  14:34
 ;;1.0;WOMEN'S HEALTH;**6,10,16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #10035 - ^DPT references     (supported)
 ; #10063 - ^%ZTLOAD            (supported)
 ; #10070 - ^XMD                (supported)
 ; #10103 - ^XLFDT              (supported)
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
 S ZTRTN="CREATEQ^WVLRLINK",ZTDESC="WV CREATE FILE 790.08 ENTRY"
 S ZTSAVE("DFN")="",ZTSAVE("LRDFN")="",ZTSAVE("LRI")="",ZTSAVE("LRA")=""
 S ZTSAVE("LRSS")="",ZTIO=""
 S ZTDTH=$$HADD^XLFDT($H,"","","",120) ;time delay if MOVE entry point
 ; is called to delete a bogus entry first so check of lab accession
 ; x-ref doesn't fail.
 D ^%ZTLOAD
 Q
CREATEQ ; Called from CREATE above
 ; WVLOC   = WARD/CLINIC/LOCATION (FILE #44)
 ; WVDATE  = DATE OF THE PROCEDURE (FM date/time)
 ;   WVDR  = DR STRING
 ; WVPROV  = ORDERING PROVIDER (FILE #200)
 ; WVLABAN = LAB ACCESSION # (e.g., CY 99 1)
 N WVDATE,WVDR,WVLABAN,WVLABAN0,WVLOC,WVPROV
 Q:$P($G(^DPT(DFN,0)),U,2)'="F"  ;not female
 Q:'$$VNVEC()  ;vet/non-vet/eligibility code check
 S WVDATE=$P(LRA,U,1) ;date/time specimen taken
 S WVLABAN=$P(LRA,U,6) ;lab accession#
 S WVLOC=$P(LRA,U,8) ;patient location
 I WVLOC]"" S WVLOC=$$HL(WVLOC) ;convert location to File 44 pointer
 S WVPROV=$P(LRA,U,7) ;requesting provider
 ; Quit if this lab test has already been sent to FILE 790.1.
 Q:$D(^WV(790.1,"F",WVLABAN))
 I LRSS'="CY",LRSS'="SP" Q  ;not cytology or surgical pathology
 ; ===============================================================
 ; Check SNOMED codes and determine if lab test is a pap smear and
 ; can be automatically created in FILE 790.1.
 I $$SNOMED^WVSNOMED() D  Q
 .D ADD^WVSNOMED
 .Q
 ; ===============================================================
 S WVDR=".02////"_DFN
 S:WVPROV]"" WVDR=WVDR_";.07////"_WVPROV
 S WVDR=WVDR_";.1////"_$G(DUZ(2))
 S:WVLOC]"" WVDR=WVDR_";.11////"_WVLOC
 S WVDR=WVDR_";.12////"_WVDATE
 S WVDR=WVDR_";.18////.5;.19////"_DT_";.34////"_$G(DUZ(2))
 S WVDR=WVDR_";2.18////"_LRDFN_";2.19////"_LRI_";2.2////"_LRSS
 S X=WVLABAN,Y=0
 K DD,DO
 N DIC,DLAYGO
 S DIC("DR")=WVDR,DIC="^WV(790.08,",DIC(0)="ML",DLAYGO=790.08
 D FILE^DICN
 Q:Y<1  ;FILE 790.08 entry was not created
 D MAIL^WVLABWP(DFN,WVLABAN,WVPROV,LRSS) ;patient, lab accession #, provider/requestor, lab subscript (CY or SP)
 Q
EXIT ;EP
 K I,N,X
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
DELETE(DFN,LRDFN,LRI,LRA,LRSS) ;
 ; Modify WH to reflect change in lab report status (no longer released).
 ; Called by REPORT RELEASE DATE/TIME field xref in:
 ; a) File 63, Field 63.08,.11
 ; b) File 63, Field 63.09,.11
 Q:'$D(DFN)!('$D(LRDFN))!('$D(LRI))!('$D(LRA))!('$D(LRSS))
 Q:'$D(^WV(790.02,DUZ(2)))  ;no site parameter entry
 Q:'$P($G(^WV(790.02,+$G(DUZ(2)),0)),U,24)  ;lab link is NO or null
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="DELETEQ^WVLRLINK",ZTDESC="WV Change in Lab Rpt Status"
 S ZTSAVE("DFN")="",ZTSAVE("LRDFN")="",ZTSAVE("LRI")="",ZTSAVE("LRA")=""
 S ZTSAVE("LRSS")=""
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
DELETEQ ; Called from DELETE above.
 N WVIEN,WVDATE,WVCMGR,WVLABAN,WVLOOP,WVMSG,WVNODE,WVPN ;,WVPROV
 N XMDUZ,XMSUB,XMTEXT,XMY ;send mail message to case manager
 S WVLABAN=$P(LRA,U,6) ;lab accession#
 Q:WVLABAN=""
 S WVIEN=$O(^WV(790.08,"B",WVLABAN,0))
 I WVIEN D DELETE^WVLABADD(WVIEN) Q  ;delete, not yet addressed
 Q:'$D(^WV(790.1,"F",WVLABAN))  ;never entered in WH procedure file
 ; Next look up lab test in WH procedure file and send warning message
 ; to WH case manager.
 S WVIEN=$O(^WV(790.1,"F",WVLABAN,0))
 Q:'$D(^WV(790.1,WVIEN,0))
 D RADMOD^WVPROC(WVIEN) ;update procedure status to "open"
 S WVCMGR=+$$GET1^DIQ(790,DFN,.1,"I") ;get case manager
 S:WVCMGR XMY(WVCMGR)=""
 ; if no case manager, then get default case manager(s)
 I 'WVCMGR S WVLOOP=0 F  S WVLOOP=$O(^WV(790.02,WVLOOP)) Q:'WVLOOP  D
 .S WVCMGR=$$GET1^DIQ(790.02,WVLOOP,.02,"I")
 .S:WVCMGR XMY(WVCMGR)=""
 .Q
 Q:$O(XMY(0))'>0  ;no case manager(s)
 ;S:WVPROV XMY(WVPROV)=""
 S WVNODE=$G(^WV(790.1,+WVIEN,0))
 S WVPN=$E($P(WVNODE,U,1),1,2),WVPN=$$PN(WVPN)
 S XMDUZ=.5 ;message sender
 S XMSUB="Lab Report for WH patient is UNVERIFIED"
 S WVMSG(1)="        Patient: "_$P($G(^DPT(DFN,0)),U,1)_" (SSN: "_$$SSN^WVUTL1(DFN)_")"
 S WVMSG(2)=" WH Accession #: "_$P(WVNODE,U,1)_"  Procedure Type: "_$S(WVPN]"":WVPN,1:"Unknown")
 S WVMSG(3)="Lab Accession #: "_WVLABAN
 S WVMSG(4)=" "
 S WVMSG(5)="NOTE: This lab test has been UNVERIFIED in the LAB package."
 S WVMSG(6)=" "
 S WVMSG(7)="The status of the associated WH procedure has been changed to 'open',"
 S WVMSG(8)="You may wish to contact Lab Service to find out the reason for the change."
 S WVMSG(9)="Please use the 'Edit a Procedure' option in the WOMEN'S HEALTH package"
 S WVMSG(10)="to modify/close this procedure."
 S XMTEXT="WVMSG("
 D ^XMD
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
HL(WVLOC) ; Get Hospital Location file (#44) pointer
 N WVARRAY,WVERR
 D FIND^DIC(44,"","","X",WVLOC,"","C","","","WVARRAY","WVERR")
 I +$G(WVARRAY("DILIST",0))=1 Q +WVARRAY("DILIST",2,1)
 Q ""
PN(X) ; Get procedure name
 I X="" Q ""
 S X=$O(^WV(790.2,"D",X,0)) ;look at abbreviation x-ref
 I 'X Q ""
 S X=$P($G(^WV(790.2,+X,0)),U,1)
 Q X
 ;
MOVE(DFN,LRDFN,LRI,LRA,LRSS) ; Called from Lab package when a lab accession is
 ; moved from one patient to another because the test was originally
 ; associated to the wrong patient.
 Q:'$D(DFN)!('$D(LRDFN))!('$D(LRI))!('$D(LRA))!('$D(LRSS))
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="MOVEQ^WVLRLINK",ZTDESC="WV Lab Accession moved to another patient"
 S ZTSAVE("DFN")="",ZTSAVE("LRDFN")="",ZTSAVE("LRI")="",ZTSAVE("LRA")=""
 S ZTSAVE("LRSS")="",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
MOVEQ ; Called from MOVE above
 N DA,DIE,DR
 N WVACCN,WVCMGR,WVDFN,WVIEN,WVLABAN,WVLOOP,WVNIEN,WVNODE,WVPIEN,WVPN,WVRD
 S WVLABAN=$P(LRA,U,6) ;lab accession#
 Q:WVLABAN=""
 S WVIEN=$O(^WV(790.08,"B",WVLABAN,0)) ;check WV LAB TESTS first
 I WVIEN D  Q  ;fix/delete File 790.8 entry, not a file (790.1) entry
 .D DELETE^WVLABADD(WVIEN)
 .Q
 ;
 S WVPIEN=$O(^WV(790.1,"F",WVLABAN,0)) ;check WH Procedure file
 Q:'WVPIEN  ;lab test was not converted into a WH procedure
 S WVNODE=$G(^WV(790.1,WVPIEN,0))
 S WVACCN=$P(WVNODE,U,1) ;WH accession#
 S WVDFN=+$P(WVNODE,U,2) ;DFN for existing patient
 Q:WVACCN=""
 S WVRD=$$RDC("Error/disregard")
 ; delete links to lab test entry so wrong lab report doesn't display
 S DIE="^WV(790.1,",DA=WVPIEN,DR=".05////"_WVRD_";2.17///@;2.18///@;2.19///@;2.2///@"
 ; include amended comment?
 D ^DIE
 S WVNIEN=$O(^WV(790.4,"C",WVACCN,0)) ;notification for that procedure?
 ; Send a mail message to case manager about patient change
 D MOVE^WVLABWP(WVDFN,WVNODE,WVNIEN)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
RDC(WVRD) ; Return ien of Result/Diagnosis code
 ; input text of result/diagnois
 I WVRD="" Q ""
 Q +$O(^WV(790.31,"B",WVRD,0))
 ;
VNVEC() ; Veteran/Non-Veteran/Eligibility Code check
 ; DFN must be defined
 ; Returns 1 - veteran
 ;             include all non-vets flag set to YES
 ;             non-vet patient's eligibility code is on list to track 
 N WVALL,WVLOOP,X,Y
 I $E($$VET^WVUTL1A(DFN))="Y" Q 1  ;veteran
 S WVALL=$P($G(^WV(790.02,DUZ(2),0)),U,26) ;include all non-vets
 I WVALL=1!(WVALL="") Q 1  ;1=YES
 S WVLOOP=+$$ELIG^WVUTL9(DFN) ;internal^external elig code
 I 'WVLOOP Q 0  ;no eligibility code
 I $D(^WV(790.02,DUZ(2),6,WVLOOP)) Q 1  ;code is on list to be tracked
 Q 0
 ;
