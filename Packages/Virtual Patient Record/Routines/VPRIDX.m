VPRIDX ;SLC/MKB/BLJ -- Create AVPR index ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,28**;Sep 01, 2011;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; -- create index
 D GMRV
 ;
 Q
 ;
GMRV ; -- create AVPR index on GMRV Measurement file #120.5
 N VPRX,VPRY
 S VPRX("FILE")=120.5
 S VPRX("NAME")="AVPR"
 S VPRX("TYPE")="MU"
 S VPRX("USE")="A"
 S VPRX("EXECUTION")="R"
 S VPRX("ACTIVITY")=""
 S VPRX("SHORT DESCR")="Trigger updates to VPR"
 S VPRX("DESCR",1)="This is an action index that updates the Virtual Patient Record (VPR)"
 S VPRX("DESCR",2)="when any of the fields in this index are changed. No actual cross-"
 S VPRX("DESCR",3)="reference nodes are set or killed."
 S VPRX("SET")="D GMRV^VPREVNT(X(1),DA,$G(X(3)))"
 S VPRX("KILL")="Q"
 S VPRX("WHOLE KILL")="Q"
 S VPRX("VAL",1)=.02              ;Patient
 S VPRX("VAL",2)=1.2              ;Rate
 S VPRX("VAL",3)=2                ;Entered in Error
 D CREIXN^DDMOD(.VPRX,"kW",.VPRY) ;VPRY=ien^name of index
 Q
 ;;
PCMM ; -- create ADP index on POSITION ASSIGNMENT HISTORY file #404.52
 Q:$D(^SCTM(404.52,"ADP"))  ;exists [ICR #7174]
 N VPRX,VPRY,I
 S VPRX("FILE")=404.52
 S VPRX("NAME")="ADP"
 S VPRX("TYPE")="R"
 S VPRX("USE")="S"
 S VPRX("EXECUTION")="R"
 S VPRX("SHORT DESCR")="Sort Assignments by Date & Position"
 S VPRX("DESCR",1)="This regular index sorts assignment changes by Effective Date and Position."
 ;
 S VPRX("SET")="S ^SCTM(404.52,""ADP"",X(1),X(2),DA)="""""
 S VPRX("KILL")="K ^SCTM(404.52,""ADP"",X(1),X(2),DA)"
 S VPRX("WHOLE KILL")="K ^SCTM(404.52,""ADP"")"
 S VPRX("VAL",1)=.02              ;Effective Date
 S VPRX("VAL",2)=.01              ;Team Position
 F I=1,2 S VPRX("VAL",I,"SUBSCRIPT")=I,VPRX("VAL",I,"COLLATION")="F"
 D CREIXN^DDMOD(.VPRX,"kW",.VPRY) ;VPRY=ien^name of index
 ;
 ; queue job to create index in background overnight
 I $G(VPRY) D
 . N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 . S ZTRTN="SCTM^VPRIDX",ZTDESC="Create SCTM ADP index",ZTIO=""
 . S ZTDTH=DT_".2355"
 . D ^%ZTLOAD
 . I $G(ZTSK) D BMES^XPDUTL("Task #"_ZTSK_" created to build index nodes.") Q
 . D BMES^XPDUTL("UNABLE TO QUEUE JOB TO CREATE ADP INDEX NODES!")
 . D MES^XPDUTL("Use the VA FileMan Utility option to create the ADP index.")
 Q
 ;
SCTM ; -- create index nodes
 N DIK S DIK="^SCTM(404.52,"
 S DIK(1)=".01^ADP"
 D ENALL^DIK
 Q
