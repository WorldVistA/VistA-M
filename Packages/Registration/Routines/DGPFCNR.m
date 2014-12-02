DGPFCNR ;ALB/SCK - PRF CAT II TO CAT I REPORTING;27 JAN 2012
 ;;5.3;Registration;**849**;Aug 13, 1993;Build 28
 ;
 ; No direct entry
 Q
 ;
EN(DGRSLT,DGXTMP) ; Main entry point
 N DGLINE,DGSPACE,DGDBL
 ;
 D SETUP
 D BLDSUM(.DGRSLT,DGXTMP)
 D BLDPROC(DGXTMP)
 W !!?3,">> Results have been sent to the 'DGPF CLINICAL HR FLAG' mail group"
 ;
 Q
 ;
SETUP ; Setup formatting variables for reports
 ;
 I $G(DGXTMP)']"" S DGXTMP="^TMP(""DGPFL2N"",$J)"
 S $P(DGLINE,"-",78)=""
 S $P(DGSPACE," ",78)=""
 S $P(DGDBL,"=",78)=""
 Q
 ;
BLDPROC(DGXTMP) ; Build report of processed cat II to Cat I entries
 N DGMSG,DGFOUND,DGCNT,DGNAME,DFN,DGPFASG,DGPFASGH,DGTEXT,DGPRE,DGSUBJ
 ;
 K DGMSG
 S DGMSG(10)=$S($G(DGRUN)="R":"Pre-scan results ",1:"Processing results ")_"from Local to National flag processing job"
 S DGMSG(12)="Run date: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S DGMSG(14)="Started by: "_$$GET1^DIQ(200,DUZ,.01)
 S DGMSG(17)=""
 ;
 K DGFOUND
 S DGMSG(19)="List of patients that "_$S($G(DGRUN)="R":"will have a",1:"had a")_" Cat 1 flag created"
 S DGMSG(21)="Name"_$E(DGSPACE,1,32)_"Owning Site"
 S DGMSG(25)=DGLINE
 ;S DGMSG(27)=""
 ;
 S DGNAME="",DGCNT=30
 F  S DGNAME=$O(@DGXTMP@("COMPLETE",DGNAME)) Q:DGNAME']""  D
 . S DFN=$P($G(@DGXTMP@("COMPLETE",DGNAME)),U,1)
 . S DGPFASG=$P($G(@DGXTMP@("COMPLETE",DGNAME)),U,2)
 . S DGPFASGH=$P($G(@DGXTMP@("COMPLETE",DGNAME)),U,3)
 . S DGTEXT=DGNAME_" ("_$$LAST4(DFN)_")"
 . S DGTAB=36-$L(DGTEXT)
 . S DGMSG(DGCNT)=DGTEXT_$E(DGSPACE,1,DGTAB)_$$GET1^DIQ(26.13,DGPFASG,.04)
 . ;_"  "_DGPFASG_"^"_DGPFASGH
 . S DGCNT=DGCNT+1,DGFOUND=1
 ;
 I '$G(DGFOUND) D
 . S DGNAME="",DGCNT=30
 . F  S DGNAME=$O(@DGXTMP@("PREPROC",DGNAME)) Q:DGNAME']""  D
 .. N DGPFX
 .. S DFN=$P($G(@DGXTMP@("PREPROC",DGNAME)),U,1)
 .. S DGPFX=$P($G(@DGXTMP@("PREPROC",DGNAME)),U,2)
 .. S DGTEXT=DGNAME_" ("_$$LAST4(DFN)_")"
 .. S DGTAB=36-$L(DGTEXT)
 .. S DGMSG(DGCNT)=DGTEXT_$E(DGSPACE,1,DGTAB)_$$GET1^DIQ(26.13,DGPFX,.04)
 .. S DGCNT=DGCNT+1,DGFOUND=1,DGPRE=1
 ;
 I '$G(DGFOUND) D
 . S DGMSG(DGCNT)="No Cat II records to process were found",DGMSG(DGCNT+1)="",DGCNT=DGCNT+5
 ;
 S DGSUBJ=$S($G(DGRUN)="R":"Pre-report ",$G(DGRUN)="P":"Processed ",1:"")_"National Flag Create "
 D SENDMSG(.DGMSG,DGSUBJ)
 Q
 ;
BLDSUM(DGRSLT,DGXTMP) ; Build summary report of cat II to cat I processing
 N DGMSG,DGNAME,VA,DFN,DFN1,DGIEN,DGTAB,DGTEXT,DGSUBJ
 ;
TOP ;
 S DGMSG(10)=$S($G(DGRUN)="R":"Pre-scan summary ",1:"Processing summary ")_"from Local to National flag processing job"
 S DGMSG(12)="Run date: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S DGMSG(14)="Started by: "_$$GET1^DIQ(200,DUZ,.01)
 S DGMSG(16)=DGLINE
 S DGMSG(16.5)=""
 S DGMSG(18)="Summary of PRF Processing:"
 S DGMSG(22)="  Total active Cat II flag assignments: "_+$G(DGRSLT("TOTAL"))
 S DGMSG(24)="  Cat I flags created:                  "_+$G(DGRSLT("NEW"))
 S DGMSG(26)="  Potential errors Found:               "_+$G(DGRSLT("ERR"))
 S DGMSG(28)="  Cat II flags requiring manual action: "_+$G(DGRSLT("MANUAL"))
 S DGMSG(30)="  Found active Cat I and Cat II flags:  "_+$G(DGRSLT("DONE"))
 S DGMSG(32)=" "
 S DGMSG(34)=DGDBL
 S DGMSG(38)=" "
 S DGMSG(40)="Processing Results: "
 S DGMSG(41)=" "
PRT1 ;
 S DGNAME="",DGCNT=100
 S DGMSG(DGCNT)="Invalid DFN's or Patient File errors"
 S DGMSG(DGCNT+1)=DGLINE
 S DGMSG(DGCNT+2)=""
 S DGCNT=DGCNT+5
 ;
 S DFN=0
 F  S DFN=$O(@DGXTMP@("DFN ERROR",DFN)) Q:'DFN  D
 . S DGMSG(DGCNT)=@DGXTMP@("DFN ERROR",DFN)
 . S DGCNT=DGCNT+1,DGFOUND=1
 I '$G(DGFOUND) S DGMSG(DGCNT)="No DFN errors were found",DGMSG(DGCNT+1)="",DGCNT=DGCNT+5
 ;
PRT2 ;
 S DGMSG(DGCNT+3)="Patients with Local ICN (National ICN Required)"
 S DGMSG(DGCNT+4)="Name"_$E(DGSPACE,1,32)_"Local ICN"
 S DGMSG(DGCNT+5)=DGLINE
 S DGMSG(DGCNT+6)=""
 ;
 S DGNAME="",DGCNT=DGCNT+6
 F  S DGNAME=$O(@DGXTMP@("MPI ERROR",DGNAME)) Q:DGNAME']""  D
 . S DFN1=$P($G(@DGXTMP@("MPI ERROR",DGNAME)),U,2)
 . S DGNAME=DGNAME_" ("_$$LAST4(DFN1)_")"
 . S DGTAB=36-$L(DGNAME)
 . S DGMSG(DGCNT)=DGNAME_$E(DGSPACE,1,DGTAB)_$$GETICN^MPIF001(DFN1)
 . S DGCNT=DGCNT+1
PRT3 ;
 K DGFOUND
 S DGMSG(DGCNT+1)=""
 S DGMSG(DGCNT+3)="National Flag assigned and Local still active"
 S DGMSG(DGCNT+4)="Name"_$E(DGSPACE,1,30)_"CMOR"_$E(DGSPACE,1,20)_"Owning Site"
 S DGMSG(DGCNT+5)=DGLINE
 S DGMSG(DGCNT+6)=""
 ;
 S DGNAME="",DGCNT=DGCNT+6
 F  S DGNAME=$O(@DGXTMP@("FLGASGN",DGNAME)) Q:DGNAME']""  D
 . S DFN1=$P($G(@DGXTMP@("FLGASGN",DGNAME)),U,2)
 . S DGCMOR=$$HL7CMOR^MPIF001(DFN1,"^")
 . S DGTEXT=DGNAME_" ("_$$LAST4(DFN1)_")"
 . S DGTAB=34-$L(DGTEXT)
 . S DGMSG(DGCNT)=DGTEXT_$E(DGSPACE,1,DGTAB)_$P(DGCMOR,U,2)
 . S DGTAB=58-$L(DGMSG(DGCNT))
 . S DGIEN=$P(@DGXTMP@("FLGASGN",DGNAME),U,3)
 . S DGMSG(DGCNT)=DGMSG(DGCNT)_$E(DGSPACE,1,DGTAB)_$$GET1^DIQ(26.13,DGIEN,.04)
 . ;S DGMSG(DGCNT+1)="   >"_$P(@DGXTMP@("FLGASGN",DGNAME),U)
 . S DGCNT=DGCNT+2,DGFOUND=1
 I '$G(DGFOUND) S DGMSG(DGCNT)="No Multiple PRF assignments were found",DGMSG(DGCNT+1)="",DGCNT=DGCNT+5
PRT4 ;
 K DGFOUND
 S DGMSG(DGCNT+1)=""
 S DGMSG(DGCNT+3)="Patients flagged for manual processing"
 S DGMSG(DGCNT+4)="Name"_$E(DGSPACE,1,32)_"CMOR"_$E(DGSPACE,1,12)_"Description"
 S DGMSG(DGCNT+5)=DGLINE
 S DGMSG(DGCNT+6)=""
 ;
 S DGNAME="",DGCNT=DGCNT+6
 F  S DGNAME=$O(@DGXTMP@("MANUAL",DGNAME)) Q:DGNAME']""  D
 . S DFN1=$P($G(@DGXTMP@("MANUAL",DGNAME)),U,2)
 . S DGTEXT=DGNAME_" ("_$$LAST4(DFN1)_")"
 . S DGTAB=36-$L(DGTEXT)
 . S DGMSG(DGCNT)=DGTEXT_$E(DGSPACE,1,DGTAB)_$E($P($$HL7CMOR^MPIF001(DFN1,"^"),U,2),1,16)
 . S DGMSG(DGCNT)=DGMSG(DGCNT)_"  "_$P(@DGXTMP@("MANUAL",DGNAME),U,1)
 . S DGCNT=DGCNT+1,DGFOUND=1
 I '$G(DGFOUND) S DGMSG(DGCNT)="No records needing manual intervention found",DGMSG(DGCNT+1)="",DGCNT=DGCNT+5
PRT5 ;
 K DGFOUND
 S DGMSG(DGCNT+1)=""
 S DGMSG(DGCNT+3)="Other Errors which may have prevented conversion"
 S DGMSG(DGCNT+4)="Name"_$E(DGSPACE,1,32)_"Description"
 S DGMSG(DGCNT+5)=DGLINE
 S DGMSG(DGCNT+6)=""
 ;
 S DGNAME="",DGCNT=DGCNT+6
 F  S DGNAME=$O(@DGXTMP@("ERROR",DGNAME)) Q:DGNAME']""  D
 . S DFN1=$P($G(@DGXTMP@("ERROR",DGNAME)),U,2)
 . S DGTEXT=DGNAME_" ("_$$LAST4(DFN1)_")"
 . S DGTAB=36-$L(DGTEXT)
 . S DGMSG(DGCNT)=DGTEXT_$E(DGSPACE,1,DGTAB)_$P(@DGXTMP@("ERROR",DGNAME),U,1)
 . S DGCNT=DGCNT+1,DGFOUND=1
 I '$G(DGFOUND) S DGMSG(DGCNT)="No other errors found",DGMSG(DGCNT+1)="",DGCNT=DGCNT+5
FIN ;
 S DGSUBJ=$S($G(DGRUN)="R":"Pre-report ",$G(DGRUN)="P":"Processed ",1:"")_"National Flag Create "
 D SENDMSG(.DGMSG,DGSUBJ)
 Q
 ;
LAST4(DFN) ; Get the SSN last four
 N VA
 ;
 D PID^VADPT6
 Q VA("BID")
 ;
SENDMSG(DGBODY,DGSUBJ) ;  Send report to mail group
 N XMTO,XMSUBJ,XMBODY,XMDUZ,XMINSTR
 ;
 S XMSUBJ=$S($G(DGSUBJ)]"":DGSUBJ,1:"National Flag Create ")
 S XMTO("G.DGPF CLINICAL HR FLAG REVIEW")=""
 S XMSUBJ=XMSUBJ_$$FMTE^XLFDT($$NOW^XLFDT(),"2M")
 S XMBODY="DGBODY"
 S XMDUZ=DUZ
 S XMINSTR("FLAGS")="P"
 S XMINSTR("FROM")="HRMH PRF GENERATE JOB"
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR)
 Q
 ;
SNDERR(DGERR,DGPFIEN,DGASGN) ;  Send error message notification
 N XMTO,XMSUBJ,XMBODY,XMDUZ,DGMSG
 ;
 S DGMSG(10)="The following error/issue occurred during"
 S DGMSG(12)="the Local to National PRF processing:"
 S DGMSG(14)=""
 S DGMSG(16)="   "_$P(DGERR,U,2)
 S DGMSG(18)=""
 S DGMSG(20)="  Patient: "_$P(DGASGN("DFN"),U,2)
 S DGMSG(22)="  PRF Assignment Entry: "_DGPFIEN
 ;
 S XMTO("G.DGPF CLINICAL HR FLAG REVIEW")=""
 S XMSUBJ="PRF L2N Processing Issue"_$$FMTE^XLFDT($$NOW^XLFDT(),"2M")
 S XMBODY="DGMSG"
 S XMDUZ=DUZ
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 Q
