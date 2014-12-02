DGPFCNV ;ALB/SCK - PRF CAT II TO CAT I PROCESSING - MAIN;27 JAN 2012
 ;;5.3;Registration;**849**;Aug 13, 1993;Build 28
 ;
 Q  ; No direct entry
 ;
 ; Variables in use
 ;   DGRUN         Processing Run type, R-Report Only, P-Full Processing
 ;   DGPARM        Local Cat II PRF name stored in DGPF SUICIDE FLAG parameter field
 ;   DGPRF         Patient Record flag value
 ;   DGXTMP        TMP global for information storage on processing run
 ;
EN ;
 N DGRUN,DGERR,DGPARM,DGPRV,DGNFLAG
 ;
 ;
 S DGNFLAG="HIGH RISK FOR SUICIDE"
 I '$$NATFLG(DGNFLAG) D  Q  ; Check for national flag
 . D ERRMSG("National PRF flag for Suicide Prevention not found")
 I '$$LOCFLG(.DGPARM) D  Q  ; check for local flag
 . D ERRMSG("Local PRF for Suicide Prevention not found in Parameter File")
 S DGRUN=$$RUNTYP() ; Determine run type, report or process
 Q:"Q"[DGRUN
 D PROCESS(DGRUN,DGPARM,.DGERR)
 Q
 ;
PROCESS(DGRUN,DGPARM,DGERR) ;
 N DGXTMP,DGPRF,DGRSLT
 ;
 S DGXTMP="^TMP(""DGPFL2N"",$J)"
 K @DGXTMP
 S DGPRF=$$GETVAR(DGPARM,"L")
 I +DGPRF<1 D  Q
 . S DGERR="Local Patient Record Flag '"_DGPARM_"' was "_$P(DGPRF,";",2)
 D WAIT^DICD
 D SEARCH(DGPRF,DGRUN,DGXTMP,.DGRSLT)
 D EN^DGPFCNR(.DGRSLT,DGXTMP)
 Q
 ;
SEARCH(DGPRF,DGRUN,DGXTMP,DGRSLT) ; Begin search for Cat II flags to convert
 N DGIEN,DFN,DGPAT,DGX,DGPRFN,DGCNVT,DGINACT,DGPIEN1
 ;
 F DGX="TOTAL","NEW","ERR","MANUAL","DONE" S DGRSLT(DGX)=0
 ;
 S DFN=0
 F  S DFN=$O(^DGPF(26.13,"AFLAG",DGPRF,DFN)) Q:'DFN  D
 . S DGI=$O(^DGPF(26.13,"AFLAG",DGPRF,DFN,0))
 . Q:'$$GET1^DIQ(26.13,DGI,.03,"I")
 . S DGRSLT("TOTAL")=DGRSLT("TOTAL")+1
 . I '$$GETPAT^DGPFUT2(DFN,.DGPAT) D  Q
 .. S DGRSLT("ERR")=DGRSLT("ERR")+1
 .. S @DGXTMP@("DFN ERROR",DFN)="Unable to retrieve patient information for "_DFN
 . ;
 . I '$$MPIOK^DGPFUT(DFN) D  Q
 .. S DGRSLT("ERR")=DGRSLT("ERR")+1
 .. S @DGXTMP@("MPI ERROR",DGPAT("NAME"))="This patient has a local ICN assigned^"_DFN
 . ;
 . S DGPFIEN=$O(^DGPF(26.13,"AFLAG",DGPRF,DFN,0))
 . S DGPRFN=$$GETFLAG^DGPFAPIU(DGNFLAG,"N")
 . S DGPIEN1=$O(^DGPF(26.13,"AFLAG",DGPRFN,DFN,0))
 . I DGPIEN1>0 D  Q
 .. I $$GETASGN^DGPFAA(DGPFIEN,.DGPFA)
 .. I +DGPFA("STATUS") D
 ... S DGRSLT("DONE")=DGRSLT("DONE")+1
 ... S @DGXTMP@("FLGASGN",DGPAT("NAME"))="Patient had active National and Local PRF's assigned^"_DFN_"^"_DGPFIEN
 ... I "P"[DGRUN S DGINACT=$$INACT(DGPFIEN) I '$G(DGINACT) D
 .... S DGRSLT("ERR")=DGRSLT("ERR")+1
 .... S @DGXTMP@("ERROR",DGPAT("NAME"))=$P(DGINACT,U,2)
 . ; 
 . K DGERR
 . S DGOWNER=0
 . ;I '$$OWNER(DFN,$G(DGPFIEN),.DGOWNER,.DGERR) D  Q
 . ;. S DGRSLT("MANUAL")=DGRSLT("MANUAL")+1
 . ;. S @DGXTMP@("MANUAL",DGPAT("NAME"))=DGERR_"^"_DFN
 . ;
 . I "P"[DGRUN D
 .. S DGCNVT=$$CONVERT(DGPFIEN,DGOWNER,DGPRFN)
 .. I +DGCNVT D
 ... S DGRSLT("NEW")=DGRSLT("NEW")+1
 ... S @DGXTMP@("COMPLETE",DGPAT("NAME"))=DFN_"^"_$P(DGCNVT,U,2,3)_"^"_$P(DGCNVT,U,2)
 .. E  D
 ... S DGRSLT("ERR")=DGRSLT("ERR")+1
 ... S @DGXTMP@("ERROR",DGPAT("NAME"))=$P(DGCNVT,U,2)_"^"_DFN_"^"_DGPFIEN
 . E  D
 .. S DGRSLT("NEW")=DGRSLT("NEW")+1
 .. S @DGXTMP@("PREPROC",DGPAT("NAME"))=DFN_"^"_DGPFIEN
 Q
 ;
CONVERT(DGPFIEN,DGOWNER,DGPRFN) ;
 N DGRSLT,DGASGN,DGNEW,DGNEWH,DGASGNH,DGPFHIEN,DGRESULT,DGHLRSLT,DGUPDT,DGRDDT
 ;
 I '$$GETASGN^DGPFAA(DGPFIEN,.DGASGN) D  G CNVTQ
 . S DGRSLT="0^Unable to to Retrieve PRF Assignment"
 S DGNEW("DFN")=DGASGN("DFN")
 S DGNEW("FLAG")=DGPRFN_"^"_DGNFLAG
 S DGNEW("STATUS")="1^ACTIVE"
 S DGNEW("OWNER")=DGASGN("OWNER") ;DGOWNER
 S DGNEW("ORIGSITE")=$P($$SITE^VASITE,U,1,2)
 ;S DGNEW("REVIEWDT")=$$FMADD^XLFDT($P(DGASGN("REVIEWDT"),U),90)
 D BLDWP(.DGASGN,.DGNEW,"ASGNTXT","NARR")
 ;
 S DGPFHIEN=$$GETLAST^DGPFAAH(DGPFIEN)
 I $$GETHIST^DGPFAAH(DGPFHIEN,.DGASGNH) D
 . S DGNEWH("ACTION")="1^NEW ASSIGNMENT"
 . S DGNEWH("APPRVBY")=DGASGNH("APPRVBY")
 . S DGNEWH("ASSIGN")=DGASGNH("ASSIGN")
 . S DGNEWH("ASSIGNDT")=$$NOW^XLFDT_"^"_$$FMTE^XLFDT($$NOW^XLFDT)
 . S DGNEWH("ENTERBY")=DUZ_"^"_$$GET1^DIQ(200,DUZ,.01)
 . S DGNEWH("TIULINK")="^"
 . D BLDWP("",.DGNEWH,"HSTNEW","COMMENT")
 ;
 ; Set Review Date
 I $$FMDIFF^XLFDT(+$G(DGASGN("REVIEWDT")),+$G(DGASGNH("ASSIGNDT")),1)>90 D
 . S DGNEW("REVIEWDT")=$$FMADD^XLFDT($P(DGASGNH("ASSIGNDT"),".",1),90)
 . S DGNEW("REVIEWDT")=DGNEW("REVIEWDT")_"^"_$$FMTE^XLFDT(+DGNEW("REVIEWDT"))
 . S DGX=$O(DGNEW("NARR",99999),-1),DGX=DGX+1
 . S DGNEW("NARR",DGX,0)="Original Review Date from Local PRF: "_$P($G(DGASGN("REVIEWDT")),U,2)
 E  D
 . S DGNEW("REVIEWDT")=DGASGN("REVIEWDT")
 ;
 S DGRESULT=$$STOALL^DGPFAA(.DGNEW,.DGNEWH,.DGERR)
 I +$G(DGRESULT) D
 . S DGRSLT=1_"^"_DGRESULT
 . S:$$PROD^XUPROD() DGHLRSLT=$$SNDORU^DGPFHLS(+$G(DGRESULT))
 . S DGUPDT=$$INACT(DGPFIEN)
 . I '+$G(DGUPDT) D  Q
 .. D SNDERR^DGPFCNR(DGUPDT,DGPFIEN,.DGASGN)
 E  D
 . S DGRSLT="0^An error occurred when trying to file assignment/history"
CNVTQ ;
 Q $G(DGRSLT)
 ;
INACT(DGPFIEN) ;  Inactivate cat II flag
 N DGPFA,DGPFAH,DGRSLT,DGRESULT
 ;
 I '$$LOCK^DGPFAA3(DGPFIEN) D  G INACTQ
 . S DGRSLT="0^Unable to lock local PRF assignment for edit^"
 I '$$GETASGN^DGPFAA(DGPFIEN,.DGPFA) D  G INACTQ
 . S DGRSLT="0^Unable to retrieve local PRF assignment for edit^"
 ;
 S DGPFA("STATUS")=0
 S DGPFA("REVIEWDT")=""
 S DGPFAH("ACTION")=3
 S DGPFAH("ASSIGNDT")=$$NOW^XLFDT()
 S DGPFAH("ENTERBY")=DUZ
 S DGPFAH("APPRVBY")=DUZ
 D BLDWP("",.DGPFAH,"HSTOLD","COMMENT")
 ;
 S DGRESULT=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,.DGERR)
 I '+$G(DGRESULT) S DGRSLT="0^Error: "_$S($G(DGERR)]"":DGERR,1:"Unable to file updated assignment")
 E  S DGRSLT=1
INACTQ ;
 Q DGRSLT
 ;
OWNER(DFN,DGPFIEN,DGOWNER,DGERR) ; Determine owning site using previous owning site, current site and CMOR
 N DGRSLT,DGIEN,DGX,DGCMOR,DGSITE,DGTFL
 ;
 S DGOWNER=$$GET1^DIQ(26.13,DGPFIEN,.04,"I")
 D BLDTFL^DGPFUT2(DFN,.DGTFL)
 S DGCMOR=+$$HL7CMOR^MPIF001(DFN,"^")
 ;
 I DGCMOR>0 D  ; CMOR Found
 . I $D(DGTFL)<10 S DGOWNER=DGCMOR,DGRSLT=1 Q  ; No TF List found
 . I $D(DGTFL(+DGCMOR)) S DGOWNER=+DGCMOR,DGRSLT=1 Q  ; CMOR found on TF List
 . S DGERR="CMOR is not one of the known TF's",DGRSLT=0
 . ;
 E  D  ; No CMOR found
 . I $D(DGTFL)<10 S DGRSLT=1 Q  ; No TF List found
 . S DGSITE=+$$SITE^VASITE
 . I $D(DGTFL(DGSITE)) S DGOWNER=DGSITE,DGRSLT=1 Q  ; Current site found on TF List
 . S DGERR="No CMOR found, site does not match known TF",DGRSLT=0
 Q DGRSLT
 ;
NATFLG(DGNFLAG) ; Check for New national flag
 N DGRSLT
 ;
 S DGRSLT=0
 I $D(^DGPF(26.15,"B",DGNFLAG)) S DGRSLT=1
 Q DGRSLT
 ;
LOCFLG(DGPARM) ;  Retrieve current cat II flag from parameters
 N DGRSLT
 ; 
 S DGPARM=$$GET^XPAR("ALL","DGPF SUICIDE FLAG")
 S DGRSLT=0
 I DGPARM]"" S DGRSLT=1
 Q DGRSLT
 ;
RUNTYP() ;
 N DGRSLT,DIR,X,Y,DIRUT,DGDISPLAY,DGX
 ;
 S DGDISPLAY(1)="This option can be run in a report only mode which will provide a report "
 S DGDISPLAY(2)="of what actions the local-to-national processing will perform.  Enter 'R' "
 S DGDISPLAY(3)="to run the Report Only mode, or 'P' to begin the local-to-national PRF "
 S DGDISPLAY(4)="processing."
 W !
 F DGX=1:1:4 W !,DGDISPLAY(DGX)
 ;
 S DIR(0)="SO^R:Report Only;P:Process Local-to-National"
 S DIR("A")="Select which mode to run"
 S DIR("B")="R"
 M DIR("?")=DGDISPLAY
 S DIR("?")="Please select either 'R' to run the pre-report or 'P' to commence processing"
 S DIR("?",5)=""
 D ^DIR K DIR S:$D(DIRUT) Y="Q"
 S DGRSLT=Y
 Q DGRSLT
 ;
ERRMSG(DGERR) ;
 W !!,?3,DGERR,!!
 Q
 ;
GETVAR(DGPARMDF,DGCAT) ;
 Q $$GETFLAG^DGPFAPIU(DGPARMDF,DGCAT)
 ;
BLDWP(DGASGN,DGNEW,DGPFTAG,DGSUB) ;  Build word processing fields for assignment and assignment history entries
 N DGI,DGI1,DGTEXT2,DGLAST,DGUSER
 ;
 F DGI=1:1 Q:$P($T(@DGPFTAG+DGI),";;",2)="QUIT"!(DGI>10)  D
 . S DGNEW(DGSUB,DGI,0)=$P($T(@DGPFTAG+DGI),";;",2)
 ;
 S DGI=0 ; Insert new comment into top of WP field
 F  S DGI=$O(DGNEW(DGSUB,DGI)) Q:'DGI  D
 . S DGLAST=DGI
 . I DGNEW(DGSUB,DGI,0)["<DT>" K DGTEXT2 D
 .. S DGTEXT2=$P(DGNEW(DGSUB,DGI,0),"<DT>")_$$FMTE^XLFDT($$NOW^XLFDT)_$P(DGNEW(DGSUB,DGI,0),"<DT>",2)
 .. S DGNEW(DGSUB,DGI,0)=DGTEXT2
 . I DGNEW(DGSUB,DGI,0)["<USER>" K DGTEXT2 D
 .. S DGUSER=$S($G(DUZ)>0:$$GET1^DIQ(200,DUZ,.01),1:"POSTMASTER")
 .. S DGTEXT2=$P(DGNEW(DGSUB,DGI,0),"<USER>")_DGUSER_$P(DGNEW(DGSUB,DGI,0),"<USER>",2)
 .. S DGNEW(DGSUB,DGI,0)=DGTEXT2
 . I DGNEW(DGSUB,DGI,0)["<FLAG>" K DGTEXT2 D
 .. S DGTEXT2=$P(DGNEW(DGSUB,DGI,0),"<FLAG>")_$G(DGPARM)_$P(DGNEW(DGSUB,DGI,0),"<FLAG>",2)
 .. S DGNEW(DGSUB,DGI,0)=DGTEXT2
 ;
 ;  Add old narrative text after new inserted comment.
 Q:$D(DGASGN)<10
 S DGI1=0,DGLAST=+$G(DGLAST)+1
 F  S DGI1=$O(DGASGN(DGSUB,DGI1)) Q:'DGI1  D
 . S DGNEW(DGSUB,DGLAST,0)=DGASGN(DGSUB,DGI1,0)
 . S DGLAST=DGLAST+1
 Q
 ;
ASGNTXT ; Narrative text for PRF assignment created by auto-conversion
 ;;This national PRF entry was auto-created on <DT>, by the
 ;;'Convert Local HRMH PRF to National' option, run by <USER>.
 ;;The fields are based on the local PRF <FLAG> which was 
 ;;inactivated by the auto conversion.
 ;;QUIT
 Q
 ;
HSTOLD ; Inactivated cat2 assignment history status text
 ;;This local PRF entry was inactivated by the 'Convert Local HRMH 
 ;;PRF to National' option run on <DT> by <USER>.  A new
 ;;national HIGH RISK FOR SUICIDE PRF was created using the 
 ;;information in this local PRF entry
 ;;QUIT
 Q
 ;
ALTHTXT ; Inactivated cat2 assignment history text for cat1 conversion at another 
 ;;Since a national HIGH RISK FOR SUICIDE PRF entry has been activated 
 ;;by another site in VistA, this local PRF entry was inactivated by  
 ;;the 'Convert Local HRMH PRF to National' option, run on <DT> 
 ;;by <USER>.
 ;;QUIT
 Q
 ;
HSTNEW ;
 ;;New assignment for national PRF entry auto-created on <DT>,
 ;;by the 'Convert Local HRMH PRF to National' option.
 ;;QUIT
 Q
