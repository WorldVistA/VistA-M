LRVRAP4 ;DALOI/STAFF - LAB AP INTERFACE ;12/07/11  12:25
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Extracts the results information in the ^LAH(LWL,1,ISQN... global and stores it in the Lab Data AP subfile.
 ;
DISPLAY ; Display AP results
 ;
 I LRSS'?1(1"SP",1"CY",1"EM") W !,"Abort- Not an AP accession" Q
 S %ZIS="MQ" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^LRVRAP4",ZTDESC="PRINT LEDI AP RESULTS",ZTSAVE("LR*")=""
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q")
 ;
 ;
DQ ;
 U IO
 N LRLINE,LRI,LRPAGE
 S LRPAGE=1,LREND=0,$P(LRLINE,"-",IOM)=""
 W @IOF
 I $D(LRDFN) D PT^LRX
 D HDG,DATA
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ACCEPT
 ;
EXIT ;
 Q
 ;
 ;
HDG ;
 ;
 W !,"Accession #: ",$G(LRACC)," UID: ",$G(LRUID)
 W !,"Name: ",$G(PNM)," SSN: ",$G(SSN)," DOB: ",$$FMTE^XLFDT($G(DOB),"1M")," Age: ",$G(AGE(2))
 W ?(IOM-10),"PAGE: ",LRPAGE
 W !,"Collection Date: ",$$FMTE^XLFDT($G(LRCDT))
 S LRPAGE=LRPAGE+1
 W !,LRLINE
 Q
 ;
 ;
DATA ;
 N FLDNM,LINE,LRI
 F LRI=99,.2,.3,.4,.5,1,1.1,1.2,1.3,1.4 I $D(^LAH(LRLL,1,LRISQN,LRSS,LRI))&('LREND) D
 . S FLDNM=$S(LRI=.2:"Brief Clinical History",LRI=.3:"Preoperative Diagnosis",LRI=.4:"Operative Findings",LRI=.5:"Postoperative Findings",LRI=99:"Report",1:0)
 . I FLDNM=0 S FLDNM=$S(LRI=1:"Gross Description",LRI=1.1:"Microscopic Description",LRI=1.2:"Supplementary Report",LRI=1.3:"Frozen Section",1:0)
 . I LRI=1.4 S FLDNM=$S(LRSS="EM":"EM",LRSS="SP":"Surgical Pathology",LRSS="CY":"Cytopathology",1:0)_"Diagnosis"
 . W !,LRLINE,!,FLDNM
 . K ^UTILITY($J)
 . S DIWR=IOM-5,DIWL=5,DIWF="W"
 . S:LRI=99 DIWR=IOM,DIWL=0
 . I LRI=1.2 D PRTSR Q
 . S LINE=0
 . F  S LINE=$O(^LAH(LRLL,1,LRISQN,LRSS,LRI,LINE)) Q:'LINE!LREND  D
 . . S X=^LAH(LRLL,1,LRISQN,LRSS,LRI,LINE,0) D ^DIWP
 . . D ^DIWW
 . . D PAUSE Q:LREND
 ;
 Q
 ;
 ;
PRTSR ; Print Supplemental Report
 N LINE,LRISQN2
 S LRISQN2=0
 F  S LRISQN2=$O(^LAH(LRLL,1,LRISQN,LRSS,LRI,LRISQN2)) Q:'LRISQN2!LREND  D
 .  S LINE=0
 . F  S LINE=$O(^LAH(LRLL,1,LRISQN,LRSS,LRI,LRISQN2,1,LINE)) Q:'LINE!LREND  D
 . . S X=^LAH(LRLL,1,LRISQN,LRSS,LRI,LRISQN2,1,LINE,0) D ^DIWP
 . . D ^DIWW
 . . D PAUSE Q:LREND
 Q
 ;
 ;
ACCEPT ; Ask if want to accept results
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Do you want to ACCEPT these results",DIR("B")="NO"
 S DIR("?")="Enter Y if you want to accept these results"
 S DIR("?",1)="Entering Y will store the results for this accession"
 D ^DIR
 I $D(DIRUT) Q
 I 'Y D PURG Q
 ;
STORE ;
 ; First, some setup stuff
 ;
 N FIELD,FILE,DIC,LRI
 ;
 S DIC(0)="LXZ"
 ; Begin actual processing of the data
 ;
 I LRSS="EM" S FILE=63.02
 I LRSS="CY" S FILE=63.09
 I LRSS="SP" S FILE=63.08
 ;
 ; Set DATE REPORT COMPLETED(.03), REPORT RELEASE DATE/TIME (.11) and RELEASED BY (.13) fields
 N FDA,FLDS,IEN,LRDATE,LRERR
 S LRI=LRIDT,LRDATE=$$NOW^XLFDT,IEN=LRIDT_","_LRDFN_","
 S FDA(1,FILE,IEN,.03)=LRDATE
 S FDA(1,FILE,IEN,.11)=LRDATE
 S FDA(1,FILE,IEN,.13)=DUZ(2)
 D FILE^DIE("","FDA(1)","LRERR")
 ;
 F LRI=99,.2,.3,.4,.5,1,1.1,1.2,1.3,1.4 I $D(^LAH(LRLL,1,LRISQN,LRSS,LRI)) D
 . S FIELD=$S(LRI=99:99,LRI=.2:.013,LRI=.3:.014,LRI=.4:.015,LRI=.5:.016,LRI=1:1,LRI=1.1:1.1,LRI=1.2:1.2,LRI=1.3:1.3,LRI=1.4:1.4,1:0)
 . I LRI=99 D COMMENT Q
 . I LRI=1.2 D SRPT Q  ; SUPPLEMENTARY REPORT
 . D WP^DIE(FILE,LRIDT_","_LRDFN_",",FIELD,"K","^LAH(LRLL,1,LRISQN,LRSS,LRI)","LRERR") ; WORD-PROCESSING FIELDS
 ;
 ; Store performing lab info
 I $D(^TMP("LRPL",$J)) D ROLLUPPL^LRRPLUA(LRDFN,LRSS,LRIDT)
 ;
 ; Ask for performing laboratory assignment
 W !! D EDIT^LRRPLU(LRDFN,LRSS,LRIDT)
 ;
 ; Store reporting lab
 D SETRL^LRVERA(LRDFN,LRSS,LRIDT,DUZ(2))
 ;
 ; Update clinical reminders
 D UPDATE^LRPXRM(LRDFN,LRSS,LRIDT)
 ;
 ; Queue results if LEDI and cleanup
 D LEDI^LRVR0,ZAP^LRVR0
 ;
 ;K ENTRY,I,SECTION,FDA,FILE,DIC,Y,BUG,IEN,M,F
 Q
 ;
 ;
COMMENT ;
 N CFILE,LRISQN2
 S LRISQN2=0
 I LRSS="SP" S CFILE=63.98
 I LRSS="CY" S CFILE=63.908
 I LRSS="EM" S CFILE=63.208
 F  S LRISQN2=$O(^LAH(LRLL,1,LRISQN,LRSS,LRI,LRISQN2)) Q:'LRISQN2  S LRLINE=^LAH(LRLL,1,LRISQN,LRSS,LRI,LRISQN2,0) D
 . K FDA,IEN,LRERR
 . S IEN="?+1,"_LRIDT_","_LRDFN_","
 . S FDA(2,CFILE,IEN,.01)=LRLINE
 . D UPDATE^DIE("","FDA(2)","IEN","LRERR")
 Q
 ;
 ;
SRPT ; SUPPLEMENTARY REPORT
 N SRFILE,LRISQN2
 S LRISQN2=0
 I LRSS="SP" S SRFILE=63.817,FIELD=1
 I LRSS="CY" S SRFILE=63.907,FIELD=1
 I LRSS="EM" S SRFILE=63.207,FIELD=1
 F  S LRISQN2=$O(^LAH(LRLL,1,LRISQN,LRSS,LRI,LRISQN2)) Q:'LRISQN2  D
 . K FDA,IEN,LRERR,LRERR2
 . S IEN="?+1,"_LRIDT_","_LRDFN_","
 . S FDA(1,SRFILE,IEN,.01)=$$NOW^XLFDT
 . S FDA(1,SRFILE,IEN,.02)=1
 . D UPDATE^DIE("","FDA(1)","IEN","LRERR2")
 . I $G(IEN(1)) D WP^DIE(SRFILE,IEN(1)_","_LRIDT_","_LRDFN_",",FIELD,"K","^LAH(LRLL,1,LRISQN,LRSS,LRI,LRISQN2,1)","LRERR")
 Q
 ;
 ;
PURG ; Ask if the entry should be purged from ^LAH(
 W !
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Do you want to purge this entry from ^LAH Global"
 S DIR("?")="Remove the entry from the list",DIR("B")="No"
 D ^DIR
 I $G(Y)=1 D ZAP^LRVR0 S LRNOP=1
 Q
 ;
 ;
PAUSE ; Check for end of page
 I $Y>(IOSL-6)&($E(IOST,1,2)="C-") D  Q:$G(LREND)
 . N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="E"
 . D ^DIR S:'Y LREND=1
 I $Y>(IOSL-6) S $Y=0 W @IOF D HDG Q
 Q
