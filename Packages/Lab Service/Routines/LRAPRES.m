LRAPRES ;DALOI/STAFF - AP ESIG RELEASE REPORT ;11/20/09  12:40
 ;;5.2;LAB SERVICE;**259,295,317,315,350**;Sep 27, 1994;Build 230
 ;
 ;
 ; Reference to NEW^TIUPNAPI supported by IA #1911
 ; Reference to SETPARM^TIULE supported by IA #2863
 ; Reference to File #8925.1 supported by IA #5033
 ; Reference to TGET^TIUSRVR1 supported by IA #2944
 ; Reference to $$DDEFIEN^TIUFLF7 supported by IA #5352
 ; Reference to EXTRACT^TIULQ supported by IA #2693
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
MAIN ;
 N LRMSG,LRDEM,LREND,LRQUIT,LRNTIME,LRPRCLSS,LRVCDE,LRMTCH
 N LRPCEXP,LRESCPT,LRPCSTR,USRSEL
 S LRESCPT=0
 D TITLE
 I LRQUIT D END Q
 D CPTCHK
 F  D  Q:LRQUIT
 . S LRQUIT=0
 . D MENU
 . Q:LRQUIT
 . S USRSEL=$G(LRSEL)
 . D  ; Protect USRSEL var
 . . N USRSEL
 . . D SECTION
 . Q:LRQUIT
 . S LREND=0
 . I USRSEL="E" S LREND=0 D CLSSCHK^LRAPRES1(DUZ,.LREND)
 . Q:LREND
 . D ACCYR
 . Q:LRQUIT
 . D ACCPN
 D END
 Q
 ;
 ;
ACCPN ; Prompt for accession number or patient name
 N USRSEL1
 S USRSEL1=$G(USRSEL) ;from MAIN
 F  D  Q:LREND
 . S (LRQUIT,LREND)=0
 . D CPTCHK
 . D LOOKUP^LRAPUTL(.LRDATA,LRH(0),LRO(68),LRSS,LRAD,LRAA)
 . Q:'LRDATA
 . I LRDATA=-1 S LREND=1 Q
 . S LRDFN=LRDATA,LRI=LRDATA(1)
 . S LRIENS=LRI_","_LRDFN_","
 . I USRSEL1="E" D  Q:LRQUIT
 . . D RELCHK
 . . Q:LRQUIT
 . . D SETRL^LRVERA(LRDFN,LRSS,$S('LRAU:LRI,1:0),DUZ(2))
 . . D:'LRZ(2) BROWSE
 . . D ESIG
 . . Q:LRQUIT
 . . S LRNTIME=$$NOW^XLFDT
 . . I 'LRZ(2) D TIUPREP,STORE
 . . Q:LRQUIT
 . . D RELEASE
 . . Q:LRQUIT
 . . D:'LRZ(2) MAIN^LRAPRES1(LRDFN,LRSS,LRI,LRSF,LRP,LRAC)
 . . D OERR^LR7OB63D
 . I USRSEL1="C" D
 . . Q:$T(CPT^LRCAPES)=""
 . . S LRPRO=DUZ
 . . D PROVIDR^LRAPUTL
 . . Q:LRQUIT
 . . D CPT^LRCAPES(LRAA,LRAD,LRAN,LRPRO)
 . I USRSEL1="V" D
 . . D DEMARR
 . . D INIT^LRAPSNMD(LRDFN,LRSS,LRI,LRSF,LRAA,LRAN,LRAD,.LRDEM,1)
 Q
 ;
 ;
TITLE ; Title
 S LRQUIT=0
 D CK^LRAP
 I Y=-1 S LRQUIT=1 Q
 W @IOF
 S LRTEXT="Release/Electronically Sign Pathology Reports"
 S LRMSG(1)=$$CJ^XLFSTR(LRTEXT,IOM)
 S LRMSG(1,"F")="!!"
 S LRMSG(2)="",LRMSG(2,"F")="!"
 D EN^DDIOL(.LRMSG) K LRMSG
 Q
 ;
 ;
CPTCHK ; Determine if CPT is activated
 Q:$T(ES^LRCAPES)=""
 S LRESCPT=$$ES^LRCAPES()
 Q
 ;
 ;
DEMARR ;
 I LRAU D
 . S LRPRO=$$GET1^DIQ(63,LRDFN_",",13.5,"I")
 . S LRPRO(1)=$$GET1^DIQ(63,LRDFN_",",13.5)
 I 'LRAU D
 . S LRPRO=$$GET1^DIQ(LRSF,LRI_","_LRDFN_",",.07,"I")
 . S LRPRO(1)=$$GET1^DIQ(LRSF,LRI_","_LRDFN_",",.07)
 S LRDEM("SEX")=SEX,LRDEM("DOB")=DOB
 S LRDEM("AGE")=AGE
 S LRDEM("SEC")=LRAA(1),LRDEM("PNM")=PNM
 S LRDEM("SSN")=SSN,LRDEM("PRO")=LRPRO(1)
 I LRAU D
 . S LRDEM("DTH")=$P(VADM(6),"^",2)
 . S LRDEM("AUDT")=$$GET1^DIQ(63,LRDFN_",",11)
 . S LRDEM("AUTYP")=$$GET1^DIQ(63,LRDFN_",",13.7)
 Q
 ;
 ;
MENU ;
 N DIR,X,Y
 S DIR(0)="SO^"
 S:LRESCPT DIR(0)=DIR(0)_"C:CPT Coding;"
 S DIR(0)=DIR(0)_"E:Electronically Sign Reports;V:View SNOMED Codes"
 S DIR("A")="Selection"
 D ^DIR
 I $D(DIRUT) S LRQUIT=1 Q
 S LRSEL=Y
 Q
 ;
 ;
SECTION ; Choose Anatomic Pathology section (AU,SP,CY,EM)
 N LRMSG
 W !
 D ^LRAP
 I '$D(Y)!('$D(LRSS)) S LRQUIT=1 Q
 S:LRO(68)="EM" LRO(68)="ELECTRON MICROSCOPY"
 S LRAU=0            ; LRAU = 0 - Not Autopsy
 S:LRSS="AU" LRAU=1  ;      = 1 - Autopsy
 I LRCAPA D  Q:LRQUIT
 . S X=""
 . S:LRSS="CY" X="CYTOLOGY REPORTING"
 . S:LRSS="SP" X="SURGICAL PATH REPORTING"
 . D:X'="" X^LRUWK
 . S:'$D(X) LRQUIT=1
 ;
 S LRSOP="Z"
 S LRMSG(1)=LRO(68)_" ("_LRABV_")",LRMSG(1,"F")="!?20"
 S LRMSG(2)="",LRMSG(2,"F")="!"
 D EN^DDIOL(.LRMSG)
 Q
 ;
 ;
ACCYR ; Determine Accession Year
 D ACCYR^LRAPUTL(.LRAD1,LRH(0),LRAA,LRO(68))
 I LRAD1=-1 S LRQUIT=1 Q
 I LRAD1 S LRAD=$P(LRAD1,U),LRH(0)=$P(LRAD1,U,2)
 Q
 ;
 ;
RELCHK ; Perform series of checks
 N LRPAT,LRSRLST,LRSRREL
 S LRQUIT=0
 I 'LRAU D  Q:LRQUIT
 . S LRPAT=+$$GET1^DIQ(LRSF,LRIENS,.02,"I")
 . S LRZ=$$GET1^DIQ(LRSF,LRIENS,.03,"I")
 . S LRZ(1)=$$GET1^DIQ(LRSF,LRIENS,.13,"I")
 . S LRZ(1.1)=$$GET1^DIQ(LRSF,LRIENS,.13)
 . S LRZ(2)=$$GET1^DIQ(LRSF,LRIENS,.11,"I")
 . I 'LRZ,'LRZ(2) D
 . . W $C(7)
 . . S LRMSG="No date report completed.  Cannot release."
 . . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . . S LRQUIT=1
 ;
 I LRAU D  Q:LRQUIT
 . I $G(^LR(LRDFN,"AU"))="" D  Q
 . . S LRMSG="No information found for this accession in the "
 . . S LRMSG=LRMSG_"LAB DATA file (#63)."
 . . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . . S LRQUIT=1
 . S LRPAT=+$$GET1^DIQ(63,LRDFN_",",13.6,"I")
 . S LRZ=$$GET1^DIQ(63,LRDFN_",",13,"I")
 . S LRZ(1)=$$GET1^DIQ(63,LRDFN_",",14.8,"I")
 . S LRZ(1.1)=$$GET1^DIQ(63,LRDFN_",",14.8)
 . S LRZ(2)=$$GET1^DIQ(63,LRDFN_",",14.7,"I")
 . ; KLL-CHECK FOR PROVISIONAL DATE OR DATE REPORT COMPLETED
 . S LRZ(3)=$$GET1^DIQ(63,LRDFN_",",14.9,"I")
 . I 'LRZ,'LRZ(3) D
 . . W $C(7)
 . . S LRMSG="Provisional or date report completed required.  Cannot release."
 . . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . . S LRQUIT=1
 I 'LRPAT,'LRZ(2) D
 . W $C(7)
 . S LRMSG="Pathologist or Cytotechnologist entry missing. Cannot release."
 . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . S LRQUIT=1
 D:'LRZ(2) SUPCHK^LRAPR1
 Q:LRQUIT
 I LRZ(2) D  Q:LRQUIT
 . W $C(7)
 . S LRMSG="Report " S:LRZ(2)=1 LRMSG=LRMSG_"has already been "
 . S LRMSG=LRMSG_"released "
 . S Y=LRZ(2) D DD^%DT S:LRZ(2)>1 LRMSG=LRMSG_Y
 . S:LRZ(1)'="" LRMSG=LRMSG_" by "_LRZ(1.1)
 . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . S:'LRAU LRQUIT=1
 ; KLL-DON'T ALLOW UNRELEASE IF REPT COMPLETED DATE EXISTS FOR AU
 I LRZ(2),LRZ S LRQUIT=1
 S LRMSG="" D EN^DDIOL(LRMSG,"","!") K LRMSG
 ; Don't allow unrelease if supp report not released for AU
 I LRZ(2),'LRZ D
 . S LRSRLST=$P($G(^LR(LRDFN,84,0)),"^",4)
 . Q:'LRSRLST
 . S LRSRREL=$P($G(^LR(LRDFN,84,LRSRLST,0)),"^",2)
 . I 'LRSRREL D
 . . N LRMSG
 . . S LRMSG=$C(7)_"Supplementary report has not been released. Cannot use this option."
 . . D EN^DDIOL(LRMSG,"","!!")
 . . S LRQUIT=1
 Q:LRQUIT
 I LRZ(2),'LRZ D
 . S DIR(0)="YA",DIR("B")="NO"
 . S DIR("A")="Unrelease report? "
 . D ^DIR
 . I 'Y S LRQUIT=1
 Q
 ;
 ;
BROWSE ; Display the report in the browser
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ; Check if user's terminal supports browser functionality
 I '$$TEST^DDBRT D  Q
 . S DIR("A",1)="This terminal does not support the needed functionality to use the Browser!"
 . S DIR("A",2)="Unable to display report on terminal."
 . S DIR("A")="Press any key to continue."
 . S DIR(0)="EA" D ^DIR
 ;
 S DIR(0)="YA",DIR("B")="YES"
 S DIR("A")="View the report before signing? "
 D ^DIR
 I Y<1 Q
 ;
 K ^TMP("LRAPBR",$J)
 S LRMSG=$$CJ^XLFSTR("*** Report is being processed.  One moment please. ***",IOM)
 D EN^DDIOL(LRMSG,"","!!")
 D INIT^LRAPBR(LRAA,LRSS,LRI,LRDFN,LRO(68),LRAU,0)
 Q
 ;
 ;
ESIG ; Prompt for electronic signature
 S LRQUIT=0
 D SIG^XUSESIG
 I X1="" D  Q
 . W "  SIGNATURE NOT VERIFIED"
 . S LRQUIT=1
 Q
 ;
 ;
TIUPREP ;
 K ^TMP("TIUP",$J)
 S LRMSG="*** Report is being processed"
 ; Exclude patient files 67, 67.1, 67.2, 67.3, 62.3 from TIU storage
 ;
 I LRDPF'=62.3,LRDPF'[67 S LRMSG=LRMSG_" for storage in TIU"
 S LRMSG=LRMSG_".  One moment please. ***"
 S LRMSG=$$CJ^XLFSTR(LRMSG,IOM)
 D EN^DDIOL(LRMSG,"","!!")
 ;
 D INIT^LRAPBR(LRAA,LRSS,LRI,LRDFN,LRO(68),LRAU,1,LRNTIME)
 Q
 ;
 ;
RELEASE ; Release the report
 N LRMSG
 ;
 ; Store REPORT RELEASE DATE/TIME and RELEASED BY
 I 'LRAU D
 . S LRRC=$$GET1^DIQ(LRSF,LRIENS,.1,"I")
 . I LRCAPA D C^LRAPSWK
 . S DR=".11////^S X=LRNTIME;.13////^S X=DUZ"
 . S DIE="^LR(LRDFN,LRSS,",DA=LRI,DA(1)=LRDFN
 . S LRA=^LR(LRDFN,LRSS,LRI,0) ; Set LRA for xref call to LRWOMEN
 ;
 ; Store AUTOPSY RELEASE DATE/TIME and AUTOPSY RELEASED BY
 I LRAU D
 . S DR="14.7////^S X=$S(LRZ(2):""@"",1:LRNTIME);"
 . S DR=DR_"14.8////^S X=$S(LRZ(2):""@"",1:DUZ);"
 . S DIE="^LR(",DA=LRDFN
 ;
 D CK^LRU
 Q:$D(LR("CK"))
 D ^DIE
 ;
 ; Update accession with completion status
 D ACCCOMP
 ;
 ; Update clinical reminders
 D UPDATE^LRPXRM(LRDFN,$G(LRSS,"AU"),$G(LRI))
 ;
 D FRE^LRU
 S LRMSG="*** Report "
 I LRZ(2),LRAU S LRMSG=LRMSG_"un"
 S LRMSG=LRMSG_"released. ***"
 D EN^DDIOL($$CJ^XLFSTR(LRMSG,IOM),"","!!")
 ;
 ; Record workload
 I "CYSP"[LRSS,LRCAPA D WKLD
 ;
 ; Check if supported subscript, released and LEDI accession and send results back to submitting facility.
 I LRSS?1(1"SP",1"CY",1"EM"),$$GET1^DIQ(LRSF,LRIENS,.11,"I") D LEDI^LRVR0
 ;
 ;I LRCAPA,"SPCYEM"[LRSS,LRD(1)'="","MBA"[LRD(1) D C1^LRAPSWK
 Q
 ;
 ;
STORE ; Store report in TIU
 N LRTITLE,LRIENS,LRFILE,LRFDA,LRTIUPTR,LRMSG
 I LRDPF=62.3!(LRDPF[67) D REFRRL^LRAPUTL Q
 S:LRSS="SP" LRO68="SURGICAL PATHOLOGY"
 S:LRSS="CY" LRO68="CYTOPATHOLOGY"
 S:LRSS="EM" LRO68="ELECTRON MICROSCOPY"
 S:LRSS="AU" LRO68="AUTOPSY"
 D SETPARM^TIULE
 S LRTITLE=$$DDEFIEN^TIUFLF7("LR "_LRO68_" REPORT","TL")
 I 'LRTITLE D
 . W $C(7)
 . S LRMSG="No TIU title for this lab report.  Cannot release."
 . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . S LRQUIT=1
 Q:LRQUIT
 ; Set parameter to 1 for e-sig verification in TIU; if e-sig fails,
 ;      TIU will abort creation of doc in ^TIU(8925, and return
 ;      an error, tiufn=-1,-1.
 D NEW^TIUPNAPI(.LRTIUPTR,DFN,DUZ,LRNTIME,LRTITLE,,,,DUZ,,1)
 I LRTIUPTR="-1^-1" D  Q
 .S LRMSG(1)="     *** Signature in TIU failed. ***"
 .S LRMSG(2,"F")="!!!"
 .S LRMSG(2)="Possible causes:"
 .S LRMSG(3,"F")="!!"
 .S LRMSG(3)="1. Report contains 3 sequential characters matching those defined"
 .S LRMSG(4)="in the BLANK CHARACTER STRING field (#1.06), TIU PARAMETERS file (#8925.99)"
 .S LRMSG(5)="which are "_$P(TIUPRM1,U,6)_"."
 .S LRMSG(6,"F")="!!"
 .S LRMSG(6)="To correct this situation use a data entry option to remove"
 .S LRMSG(7)="these characters from this report."
 .S LRMSG(8,"F")="!!"
 .S LRMSG(8)="2.  There is some other TIU document setup problem."
 .S LRMSG(9,"F")="!!"
 .S LRMSG(9)="Report this situation to the Laboratory ADP Coordinator."
 .S LRMSG(10)="     *** Report storage in TIU failed. ***"
 .S LRMSG(10,"F")="!!!"
 .D EN^DDIOL(.LRMSG,"","!!")
 .S LRQUIT=1
 I +LRTIUPTR=-1 D  Q
 . S LRMSG="*** Report storage in TIU failed. ***"
 . S LRMSG=$$CJ^XLFSTR(LRMSG,IOM)
 . D EN^DDIOL(LRMSG,"","!!")
 . S LRQUIT=1
 S LRMSG="*** Report storage in TIU is complete. ***"
 S LRMSG=$$CJ^XLFSTR(LRMSG,IOM)
 D EN^DDIOL(LRMSG,"","!!")
 ;CKA-Calculate checksum of TIU report text
 D EXTRACT^TIULQ(+LRTIUPTR,"LRTIU",,,,1,,1)
 S $P(LRTIU(+LRTIUPTR,"TEXT",0),U,5)=$P(LRTIU(+LRTIUPTR,1201,"I"),".")
 S LRCHKSUM=$$CHKSUM^XUSESIG1("LRTIU("_+LRTIUPTR_",""TEXT"")")
 K LRTIU
 ;
 ; Store pointer & checksum information in the LAB DATA (#63) file
 S LRIENS="+1,"_$S('LRAU:LRI_",",1:"")_LRDFN_","
 S LRFILE=$S(LRSS="SP":63.19,LRSS="CY":63.47,LRSS="EM":63.49,1:"")
 S:LRFILE="" LRFILE=$S(LRSS="AU":63.101,1:"")
 S LRFDA(1,LRFILE,LRIENS,.01)=LRNTIME
 S LRFDA(1,LRFILE,LRIENS,1)=+LRTIUPTR
 S LRFDA(1,LRFILE,LRIENS,2)=LRCHKSUM
 D UPDATE^DIE("","LRFDA(1)")
 D RETRACT^LRAPRES1(LRDFN,LRSS,LRI,+LRTIUPTR)
 Q
 ;
 ;
WKLD ; Capture workload
 N ERR,FILE,FILE1,IENS,IENS1,LRIEN,LRFDA,LROUT,RNUM
 S LRK=$P(^LR(LRDFN,LRSS,LRI,0),"^",11) Q:'LRK
 Q:$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0))
 S RNUM=1,IENS="+"_RNUM_","_LRAN_","_LRAD_","_LRAA_","
 S FILE=68.04,LRIEN(1)=LRT
 S LRFDA(1,FILE,IENS,.01)=LRT
 S LRFDA(1,FILE,IENS,1)=50
 S LRFDA(1,FILE,IENS,3)=DUZ
 S LRFDA(1,FILE,IENS,4)=LRK
 S C=0,FILE1=68.14
 F  S C=$O(LRT(C)) Q:'C  D
 . S RNUM=RNUM+1,LRIEN(RNUM)=C
 . S IENS1="+"_RNUM_","_IENS
 . S LRFDA(1,FILE1,IENS1,.01)=C
 . S LRFDA(1,FILE1,IENS1,.02)=1
 . S LRFDA(1,FILE1,IENS1,.03)=0
 . S LRFDA(1,FILE1,IENS1,.04)=0
 . S LRFDA(1,FILE1,IENS1,1)=LRK
 . S LRFDA(1,FILE1,IENS1,2)=DUZ
 . S LRFDA(1,FILE1,IENS1,3)=DUZ(2)
 . S LRFDA(1,FILE1,IENS1,4)=LRAA
 . S LRFDA(1,FILE1,IENS1,5)=LRAA
 . S LRFDA(1,FILE1,IENS1,6)=LRAA
 D UPDATE^DIE("","LRFDA(1)","LRIEN","LROUT")
 Q
 ;
 ;
ACCCOMP ; Complete tests on accession
 ;
 N LRERR,LRFDA,LRFILE,LRIENS,LRK,LRORDT,LRSN,LRSRDT,LRT,LRX
 ;
 ;ZEXCEPT: LRAA,LRAD,LRAN,LRDFN,LRDUZ,LRI,LRSS
 ;
 ; Retrieve d/t released
 I LRSS="AU" S LRK=$P(^LR(LRDFN,LRSS),"^",15)
 E  S LRK=$P(^LR(LRDFN,LRSS,LRI,0),"^",11)
 I LRK="" Q
 ;
 ; Lab Arrival d/t
 I LRSS="AU" S LRSRDT=$P(^LR(LRDFN,LRSS),"^",1)
 E  S LRSRDT=$P(^LR(LRDFN,LRSS,LRI,0),"^",10)
 ;
 ; Don't update workload tests (urgency>49)
 S LRT=0,LRFILE=68.04
 F  S LRT=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT)) Q:LRT<.5  D
 . I $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0),"^",2)>49 Q
 . K LRIENS,LRFDA,LRERR(1)
 . S LRIENS=LRT_","_LRAN_","_LRAD_","_LRAA_","
 . S LRFDA(1,LRFILE,LRIENS,3)=$S($G(LRDUZ):LRDUZ,$G(DUZ):DUZ,1:"")
 . S LRFDA(1,LRFILE,LRIENS,4)=LRK
 . D UPDATE^DIE("","LRFDA(1)","","LRERR(1)")
 ;
 ; Update order with release date/time if available.
 ;  - check for lab arrival time and update if missing
 S LRX=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 S LRORDT=$P(LRX,"^",4),LRSN=$P(LRX,"^",5)
 I LRORDT>0,LRSN>0,$D(^LRO(69,LRORDT,1,LRSN,0)) D
 . K LRFILE,LRIENS
 . S LRIENS=LRSN_","_LRORDT_",",LRFILE=69.01
 . I $P($G(^LRO(69,LRORDT,1,LRSN,3)),"^")="",LRSRDT S LRFDA(2,LRFILE,LRIENS,20)=LRSRDT
 . S LRFDA(2,LRFILE,LRIENS,21)=LRK
 . D UPDATE^DIE("","LRFDA(2)","","LRERR(2)")
 ;
 Q
 ;
 ;
END ; Clean-up variables and quit
 K LRAD1,LRDATA,LRAU,LRRDTE,LRTEXT,LRSEL,LRFILE,LRIENS,LRIENS1
 K LRFDA,ERR,IENS,LROUT,LRIEN,LRTMP
 K ^TMP("LRAPBR",$J),^TMP("TIUP",$J)
 D:$T(CLEAN^LRCAPES)'="" CLEAN^LRCAPES
 D V^LRU
 Q
