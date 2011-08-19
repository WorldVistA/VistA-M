RAO7MFN ;HISC/GJC-Create MFN orderable item update msg ;6/11/97  08:47
 ;;5.0;Radiology/Nuclear Medicine;**1,6,10,18,45**;Mar 16, 1998
 ;Last midification by SS for P18 JUN 19, 2000
 ;Last modification: 12.16.03 patch 45 Contrast Media by CPT gjc
PROC(RAENALL,RAFILE,RASTAT,RAY) ; Entry point to update a single procedure.
 ; 'RAY'    <> is the same as 'Y' when passed back from DIC after
 ;             lookup on file 71 & file 71.3
 ; 'RAENALL'<> single procedure (0) or whole file update (1) flag
 ; 'RAFILE' <> file # of the file being edited (71 or 71.3)
 ; 'RASTAT' <> Procedure file (71) status: 0 inactive^1 active
 ;             Com. Proc. file (71.3) Seq. # status: 0 inactive^1 active
 ;             1st piece: status before edit, 2nd piece: status after
 ;                        edit.
 ; This entry point can be called from 2^RAMAIN2 or 13^RAMAIN2
 ; This routine assumes that RAVAR is defined as an array or global
 ;  root in which to place the output.
 ;
 Q:'$D(RAY)!('$D(RAFILE))!('$D(RASTAT))!('$D(RAENALL))
 S RAFNUM=71,RAFNAME=$P($G(^DIC(RAFNUM,0)),"^"),RAXIT=0
 S:'$D(RATSTMP) RATSTMP=$$NOW^XLFDT()
 S:'$D(RACNT) RACNT=0 S:'$D(RAINCR) RAINCR="S RACNT=RACNT+1"
 S:'$D(RASUB) RASUB="""RAO7"""
 D:'$D(RAHLFS)!('$D(RAECH)) EN1^RAO7UTL
 I 'RAENALL,('$D(RAVAR)) D
 . S RAVAR="^TMP("_RASUB_","_RATSTMP_","
 . S RAVARBLE="^TMP("_RASUB_","_RATSTMP_")"
 . Q
 I RAFILE=71 D
 . S RA71(0)=$G(^RAMIS(RAFILE,+RAY,0))
 . S RA71("I")=$G(^RAMIS(RAFILE,+RAY,"I"))
 . I $D(^RAMIS(71.3,"B",+RAY)) D
 .. S RA713(0)=$G(^RAMIS(71.3,+$O(^RAMIS(71.3,"B",+RAY,0)),0))
 .. Q
 . Q
 I RAFILE=71.3 D
 . S RA713(0)=$G(^RAMIS(RAFILE,+RAY,0))
 . ; if RA713(0)="" then the common procedure was deleted
 . S RASVIEN=$S(+RA713(0)>0:+RA713(0),1:+$P(RAY,"^",2))
 . S RA71(0)=$G(^RAMIS(71,RASVIEN,0))
 . S RA71("I")=$G(^RAMIS(71,RASVIEN,"I"))
 . K RASVIEN
 . Q
 Q:$$PROCNDE^RAO7UTL(.RA71)  ; Does the Proc. have Proc-Types & I-Types
 I RAFILE=71 D
 .I +$P(RAY,"^",3) D
 ..;new entry, add to master file whether active or inactive
 ..S RAMFE="MAD"
 ..Q
 .I '+$P(RAY,"^",3),(+$P(RASTAT,"^",2)) D
 ..;now active regardless of prior status, update master file
 ..S RAMFE="MUP"
 ..Q
 .I '+$P(RAY,"^",3),('+$P(RASTAT,"^",2)) D
 ..;now inactive regardless of prior status, deactivate master file
 ..S RAMFE="MDC"
 ..Q
 .Q
 ; If RAMFE is still not defined, must be an addition to common orders
 ; 'Update' to OE since procedure is already in their master file
 I RAFILE=71.3 S RAMFE="MUP"
 ;
 ; If parent with no descendents, send deactivate msg even if active
 I $P($G(RA71(0)),"^",6)="P",'$O(^RAMIS(71,$S(RAFILE=71.3:+$P(RAY,"^",2),1:+RAY),4,0)) S RAMFE="MDC"
 ;
 S RACPT(0)=$$NAMCODE^RACPTMSC(+$P(RA71(0),"^",9),DT)
 S:RAFILE=71 RAIEN71=+RAY S:RAFILE=71.3 RAIEN71=+$P(RAY,"^",2)
 S RAXT71=$P(RA71(0),"^")
 S RAIMGAB=$P($G(^RA(79.2,+$P(RA71(0),"^",12),0)),"^",3)
 S RAPHYAP=$S($P(RA71(0),"^",11)="":"","Yy"[$P(RA71(0),"^",11):"Y",1:"N")
 S RACOST=$P(RA71(0),"^",10),RAPRCTY=$P(RA71(0),"^",6)
 S RACMNOR=$S($P($G(RA713(0)),"^",4)]"":"Y",1:"N") ;can't be an active common w/o a seq #
 ;determine CM associations for active & inactive procedures
 S RACMCODE=$$CMEDIA^RAO7UTL(RAIEN71,$P(RA71(0),U,6)) ;ien, proc. type
 S RAINACT=$S(RA71("I")]"":$$HLDATE^HLFNC(RA71("I"),"DT"),1:"")
 I 'RAENALL D
 . X RAINCR
 . S @(RAVAR_RACNT_")")=$$MSH^RAO7UTL("MFN^M01") X RAINCR ;P18 event type
 . D MFI^RAO7UTL("UPD") ;P18
 . Q
 S @(RAVAR_RACNT_")")="MFE"_RAHLFS_RAMFE_RAHLFS_RAHLFS_RAINACT_RAHLFS
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_$P(RACPT(0),"^")
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAECH(1)
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_$P(RACPT(0),"^",2)
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAECH(1)_"CPT4"
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAECH(1)_RAIEN71
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAECH(1)_RAXT71
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAECH(1)_"99RAP"
 K RAINACT X RAINCR
 S @(RAVAR_RACNT_")")="ZRA"_RAHLFS_RAIMGAB_RAHLFS_RAPHYAP
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAHLFS_RACOST_RAHLFS
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_$G(RACMCODE)_RAHLFS
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RACMNOR_RAHLFS
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAPRCTY_RAHLFS
 ; Check the synonym (1), message (3) and the Education Description
 ; "EDU" multiples for data
 N I,J,K,RAPMSG S RAPMSG=0
 F RAMULT="^RAMIS(71,"_RAIEN71_",1,","^RAMIS(71,"_RAIEN71_",3,","^RAMIS(71,"_RAIEN71_",""EDU""," D
 . I RAMULT=("^RAMIS(71,"_RAIEN71_",""EDU"","),($$UP^XLFSTR($P(RA71(0),"^",17))'="Y") Q  ; display Ed Descr not set to yes, quit
 . Q:'+$O(@(RAMULT_"0)"))  ; no data for 1 synonym, 3 message, "EDU" desc multiple
 . S (I,J)=0,K=""
 . F  S J=$O(@(RAMULT_J_")")) Q:J'>0  D
 .. S K=$G(@(RAMULT_J_",0)"))
 .. I RAMULT=("^RAMIS(71,"_RAIEN71_",1,") D  Q
 ... X RAINCR S I=I+1
 ... S @(RAVAR_RACNT_")")="ZSY"_RAHLFS_I_RAHLFS_$P(K,"^")
 ... Q
 .. I RAMULT=("^RAMIS(71,"_RAIEN71_",3,") D
 ... X RAINCR S I=I+1,RAPMSG=1
 ... S @(RAVAR_RACNT_")")="NTE"_RAHLFS_I_RAHLFS_RAHLFS_$P($G(^RAMIS(71.4,+K,0)),"^")
 ... Q
 .. I RAMULT=("^RAMIS(71,"_RAIEN71_",""EDU"",") D
 ... I RAPMSG D
 .... X RAINCR S I=I+1
 .... S @(RAVAR_RACNT_")")="NTE"_RAHLFS_I_RAHLFS_RAHLFS_" "
 .... S RAPMSG=0
 .... Q
 ... X RAINCR S I=I+1
 ... S @(RAVAR_RACNT_")")="NTE"_RAHLFS_I_RAHLFS_RAHLFS_K
 ... Q
 .. Q
 . Q
 I 'RAENALL D
 . D MSG^XQOR("RA ORDERABLE ITEM UPDATE",RAVARBLE)
 . D PURGE^RAO7UTL
 . Q
 X:RAENALL RAINCR
 Q
ENALL ; Whole Rad/Nuc Med Procedure file update.  Called only when Rad/Nuc
 ; Med or OE/RR are being installed.
 Q:'$D(XPDNM)  ; quit if not KIDS, xists during pre/post inits
 ; & environment check routines.
 L +^RAMIS(71.3):300 D ^RACOMDEL L -^RAMIS(71.3)
 L +^RAMIS(71):300
 I '$T D  Q
 . N TXT S TXT(1)=" "
 . S TXT(2)="Another user is editing a record in the "
 . S TXT(2)=TXT(2)_$P($G(^DIC(71,0)),"^")
 . S TXT(3)="file.  Try again later!"
 . S XPDQUIT=1 D MES^XPDUTL(.TXT)
 . Q
 N RA,RACNT,RAECH,RAENALL,RAFILE,RAFNAME,RAFNUM,RAHLFS,RAINCR,RASTAT
 N RASUB,RATSTMP,RAVAR,RAXIT,RAY
 S (RA,RACNT)=0,RAENALL=1,RATSTMP=$$NOW^XLFDT(),RAINCR="S RACNT=RACNT+1"
 S RASUB="""RAO7""",RAVAR="^TMP("_RASUB_","_RATSTMP_","
 S RAVARBLE="^TMP("_RASUB_","_RATSTMP_")"
 D EN1^RAO7UTL ; sets up RAECH & RAHLFS
 S (RAFILE,RAFNUM)=71,RAFNAME=$P($G(^DIC(RAFNUM,0)),"^"),RASTAT="0^1"
 X RAINCR S @(RAVAR_RACNT_")")=$$MSH^RAO7UTL("MFN^M01") X RAINCR ;P18 event type
 D MFI^RAO7UTL("REP")
 F  S RA=$O(^RAMIS(71,RA)) Q:RA'>0  D  D PURGE1^RAO7UTL
 . S RA(0)=$G(^RAMIS(71,RA,0)),RA("I")=$G(^RAMIS(71,RA,"I"))
 . Q:$P(RA("I"),"^")]""&($P(RA("I"),"^")'>DT)  ; inactive date present
 . S RAY=RA_"^"_$P(RA(0),"^")_"^"_1 D PROC(RAENALL,RAFILE,RASTAT,RAY)
 . Q
 D EN^ORMFN(RAVARBLE) K @RAVARBLE,RAVARBLE
 L -^RAMIS(71) ; unlock whole file
PARM ;Send Div params for SUBMIT TO prompt and allowing BROAD procedures
 ;to OE3 so they can populate their OE/RR Parameter Instance file
 N DIK S DIK="^RA(79,",DIK(1)=".121^AC1" D ENALL^DIK
 N DIK S DIK="^RA(79,",DIK(1)=".17^AC" D ENALL^DIK
 Q
