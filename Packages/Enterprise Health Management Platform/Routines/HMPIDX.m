HMPIDX ;SLC/MKB,ASMR/RRB,SRG - Create HMP triggers;Feb 01, 2016 14:22:27
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;DE2818 documentation:
 ;  CREIXN^DDMOD - ICR 2916
 ;  EN^XPAR - ICR 2263
 ;
EN ; -- create index triggers
 ; Other indexes are created in HMP 2.0 PREREQUISITE BUNDLE patches
 ; Problems -- GMPL*2*36 provides protocol event
 ; CLiO     -- MD*2*38 provides protocol event
 ; TIU      -- TIU*2*106 provides index event
 D GMRV     ;Vitals            
 ;
 D EN^XPAR("PKG.VIRTUAL PATIENT RECORD","HMP TASK WAIT TIME",1,99)
 ;S ^XTMP("HMP",0)="3991231^3110101^HMP Patient Data Monitor"
 Q
 ;
GMRV ; -- create AHMP index on GMRV Measurement file #120.5
 ; DE3640: quit if index already exists, as deletion of old index by DIKCR will take a long time
 Q:$O(^DD("IX","BB",120.5,"AHMP",0))
 N HMPX,HMPY
 S HMPX("FILE")=120.5,HMPX("NAME")="AHMP"
 S HMPX("TYPE")="MU",HMPX("USE")="A"
 S HMPX("EXECUTION")="R",HMPX("ACTIVITY")=""
 S HMPX("SHORT DESCR")="Event for HMP"
 S HMPX("DESCR",1)="This index invokes a HMP event point when vitals are modified."
 S HMPX("DESCR",2)="No actual cross-reference nodes are set or killed."
 S HMPX("SET")="Q:$D(DIU(0))!($G(XDRDVALF)=1)  D GMRV^HMPEVNT(X,DA,$G(X(3)))"
 S HMPX("KILL")="Q",HMPX("WHOLE KILL")="Q"
 S HMPX("VAL",1)=.02            ;Patient
 S HMPX("VAL",2)=1.2            ;Rate
 S HMPX("VAL",3)=2              ;Entered in Error
 D CREIXN^DDMOD(.HMPX,"",.HMPY) ;HMPY=ien^name of index
 Q
 ;
