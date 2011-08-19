XDRMERG ;SF-IRMFO.SEA/JLI - TENATIVE UPDATE POINTER NODES ;04/26/2001  08:17
 ;;7.3;TOOLKIT;**23,34,38,44,45,49,54,73**;Apr 25, 1995
 ;;
 Q
 ;
 ; FILE is the file NUMBER of the file in which the pointed to fields
 ;        are being merged (e.g., 2 or 200)
 ; FROM is a root under which paired arrays of FROM and TO ien values
 ;        may be found.  If internal entry number 275 were being merged
 ;        merged into ien 75, and the array name to be used was XX,
 ;        the data would be stored as ARRYNAME(FROMIEN,TOIEN) OR
 ;        XX(275,75).  The call would be
 ;
 ;          D ENTRY^XDRMERG(2,"XX")
 ;
 ;    Any number of pairs may be in the From/To array, and the higher
 ;    this number, the more efficient the conversion will be.
 ;
EN(FILE,FROM) ;
 D RESTART(FILE,FROM)
 Q
 ;
 ; The restart entry point permits the user to specify locations for
 ; continuation of a previously interrupted merge process.  The
 ; first two arguments are as indicated above for the EN entry point.
 ; The next three arguments are optional, and should only be set for
 ;    a restart of a merge which was interrupted in progress.  Even
 ;    then these values could be omitted with minimal impact on the
 ;    first two phases of the merge operation.
 ;
 ; XDRTYPE is an indicator of the phase of the merge process
 ;
 ; SFILE indicates the pointer file number from which processing
 ;    should be continued.
 ;
 ; SENTRY indicates the internal entry number within SFILE from which
 ;    processing should be continued
 ;
RESTART(FILE,FROM,XDRTYPE,SFILE,SENTRY) ;
 ;
 N XBASIS,CURRTYPE,CURRFIL,XBASE,X,XDRXT,XDRH1,XDRH2,XDRH3,XTYPE
 N XDRFGLOB,VAFCA08,XDRDVALF,XDRFILE,DIQUIET,RGRSICN
 S VAFCA08=1,XDRDVALF=1,DIQUIET=1,RGRSICN=1
 ;
 S XDRFGLOB=$G(^DIC(FILE,0,"GL")) Q:XDRFGLOB=""
 ;
 I $G(XDRTYPE)<2 D CHKFROM^XDRMERG2(FROM,FILE) ; check for self-pointers, circular, etc.
 ;
 S XDRGID=$O(@FROM@("")) I XDRGID="" Q
 S XDRGID=FILE_U_XDRGID_U_$O(@FROM@(XDRGID,""))
 S ^XTMP("XDRSTAT",0)=$$FMADD^XLFDT(DT,30)_U_DT
 S ^XTMP("XDRSTAT",XDRGID,"START",$J)=$$NOW^XLFDT()
 ;
 I $G(XDRTYPE)<2 D
 . S XDRTYPE=1
 . D DOMAIN^XDRMERG2(FILE,FROM)
 . S XDRTYPE=2
 I $D(ZTSTOP) Q
 ;
LOOP ;
 I $G(SFILE)="" S SFILE=0
 I $G(SENTRY)="" S SENTRY=0
 S CURRTYPE=XDRTYPE
 ;
 D SETUP(XDRTYPE) ; identify files and fields to be processed
 ;
 F CURRFIL=SFILE-.0000001:0 Q:$D(ZTSTOP)  S CURRFIL=$O(^TMP($J,"XFIL",CURRFIL)) Q:CURRFIL'>0  D
 . I CURRFIL=1 Q
 . I CURRFIL=15!(CURRFIL=15.4) Q
 . I FILE=63,CURRFIL=2 Q
 . ;
 . I $D(XDRTHRED)>1,'$D(XDRTHRED(CURRFIL)) Q
 . ;
 . ;
 . S XBASIS=^TMP($J,"XFIL",CURRFIL)
 . I '$D(^TMP($J,"XGLOB",XBASIS)) D  I X'[XBASIS Q
 . . S X=$O(^TMP($J,"XGLOB",XBASIS))
 . S XDRXT=$$NOW^XLFDT()
 . I $D(XDRFDA) D  I 1
 . . S ^VA(15.2,XDRFDA,3,XDRFDA1,1)=XDRXT_U_CURRTYPE_U_CURRFIL_U
 . E  D
 . . S ^XTMP("XDRSTAT",XDRGID,"TIME",$J)=XDRXT_U_CURRTYPE_U_CURRFIL_U
 . S XDRH1=XDRXT
 . S ^XTMP("XDRSTAT",XDRGID,"FIL",XDRTYPE,CURRFIL)=XDRH1
 . S XTYPE=$$TYPE^XDRMERG1(XBASIS),XBAS=XBASIS D  Q:$D(ZTSTOP)
 . . I XDRTYPE=2 D  Q
LOOP2 . . . I XTYPE="DINUM" D DINUM^XDRMERG2(XBAS,XBAS,"")
 . . . I XTYPE'="" D XREFS^XDRMERG2(XBAS,XBAS,"")  ; LET DINUM IN TO CHECK FOR ANY OTHER XREFS UNDER XBAS
 . . . S XBAS=$O(^TMP($J,"XGLOB",XBAS)) I XBAS[XBASIS S XTYPE=$$TYPE^XDRMERG1(XBAS) G LOOP2
 . . . Q
 . . D CHASE^XDRMERG1(XBASIS,XBASIS,"")
 . S XDRH2=$$NOW^XLFDT()
 . S XDRH3=$$FMDIFF^XLFDT(XDRH2,XDRH1,2)
 . S ^XTMP("XDRSTAT",XDRGID,"FIL",XDRTYPE,CURRFIL)=XDRH1_U_XDRH2_U_XDRH3
 ;
 ;   hook to stop special xref clean-up after phase II
 I $D(XDRFDA),$P(^VA(15.2,XDRFDA,0),U)="FIX XREF PROCESS" Q
 I '$D(ZTSTOP),XDRTYPE=2  D  G LOOP ; NOW DO THE ONES WE HAVE TO HUNT
 . S XDRTYPE=3
 . S (SFILE,SENTRY)=0
 . K XDRTHRD
 . N I,MAXTHRED,THREADS S MAXTHRED=$P($G(^VA(15.1,FILE,1)),U),THREADS=$P($G(^(1)),U,2) S:'$D(XDRFDA) MAXTHRED=1 Q:MAXTHRED'>1  D SETUP(XDRTYPE)
 . F I=1:1:MAXTHRED S XDRTHRD=$P(THREADS,";",I) Q:XDRTHRD'>0  D
 . . S XDRTHRD(I,XDRTHRD)="" K ^TMP($J,"XFIL",XDRTHRD)
 . S XDRTHRD=0 F  S I=$S(I'<MAXTHRED:1,1:I+1) S XDRTHRD=$O(^TMP($J,"XFIL",XDRTHRD)) Q:XDRTHRD'>0  S XDRTHRD(I,XDRTHRD)="" K ^TMP($J,"XFIL",XDRTHRD)
 . F XDRTHRD=2:1:MAXTHRED,1 D
 . . K XDRTHRED M XDRTHRED=XDRTHRD(XDRTHRD) S XDRTHRED=XDRTHRD
 . . I XDRTHRD=1 D  Q
 . . . F XDRTHRED=0:0 S XDRTHRED=$O(XDRTHRED(XDRTHRED)) Q:XDRTHRED'>0  S ^VA(15.2,XDRFDA,3,XDRFDA1,2,XDRTHRED,0)=XDRTHRED
 . . S ZTRTN="DQTHREAD^XDRMERG0",ZTIO="",ZTDTH=$$NOW^XLFDT()
 . . S ZTDESC="MERGE THREAD FOR "_XDRTHRD,ZTSAVE("XDRFDA")=""
 . . S ZTSAVE("XDRTHRED")="",ZTSAVE("XDRTHRED(")="",ZTSAVE("XDRFILE")=FILE
 . . D ^%ZTLOAD
 . S XDRTHRED=""
 ;
 I $D(ZTSTOP) S ^XTMP("XDRSTAT",XDRGID,"HALT",$J)=$$NOW^XLFDT()
 E  I '$D(XDRFDA) D
 . D CLOSEIT
 . S ^XTMP("XDRSTAT",XDRGID,"DONE",$J)=$$NOW^XLFDT()
 Q
CLOSEIT ;
 I $D(XDRXFLG) Q  ; DON'T CLOSE IF JUST CHECKING
 S:'$D(FILE) FILE=XDRFILE
 S:'$D(FROM) FROM=$NA(^TMP("XDRFROM",$J)) ;FROM="XDRZZZ"
 D SETUP(2)
 S I="" F  S I=$O(^TMP($J,"XGLOB",I)) Q:I=""  D
 . I I'["DA,",$P($G(^TMP($J,"XGLOB",I,0,1)),U,3)="DINUM" D
 . . F XDRFR=0:0 S XDRFR=$O(@FROM@(XDRFR)) Q:XDRFR'>0  D
 . . . K @(I_XDRFR_")")
 I FILE'=2 D
 . S I=^DIC(FILE,0,"GL")
 . F XDRFR=0:0 S XDRFR=$O(@FROM@(XDRFR)) Q:XDRFR'>0  D
 . . K @(I_XDRFR_")")
 Q
 ;
SETUP(XDRTYPE) ; XDRTYPE=3 DOES NON-.01 FIELDS (AND .01 WITH NO DINUM OR X-REF)
 N PFILE,PUFILE,PXFILE,PGLOB,PUFLD,PFLD,PNODE,PUNODE,NODE,PIECE,XREF,XGLOB,N,I,XREFFLAG,CHECK,STANDARD
 ;
 K ^TMP($J,"XGLO"),^TMP($J,"XGLOB"),^TMP($J,"XFIL")
 N XDRDINUM S XDRDINUM(FILE)=""
 N FILE
 S FILE=""
 F  S FILE=$O(XDRDINUM(FILE)) Q:FILE=""  D
 . F PFILE=0:0 S PFILE=$O(^DD(FILE,0,"PT",PFILE)) Q:PFILE'>0  D
 . . ;   skip Imaging files
 . . Q:PFILE=2006.55
 . . Q:PFILE=2006.552
 . . S PUFILE=PFILE,N=0
 . . F  Q:$D(^DIC(PUFILE,0,"GL"))  D  Q:PXFILE=""
 . . . S PXFILE=$G(^DD(PUFILE,0,"UP")) I PXFILE="" Q
 . . . S PUFLD=$O(^DD(PXFILE,"SB",PUFILE,0)) I PUFLD'>0 S PXFILE="" Q
 . . . S PUNODE=$P($P(^DD(PXFILE,PUFLD,0),U,4),";")
 . . . I PUNODE'=+PUNODE S PUNODE=""""_PUNODE_""""
 . . . S N=N+1
 . . . S PNODE(N)=PUNODE
 . . . S PUFILE=PXFILE
 . . I '$D(^DIC(PUFILE,0,"GL")) Q
 . . K PGLOB
 . . S PGLOB(0)=^DIC(PUFILE,0,"GL")
 . . S ^TMP($J,"XFIL",PUFILE)=PGLOB(0)
 . . S XGLOB=PGLOB(0)
 . . F I=1:1 Q:N=0  D
 . . . S PGLOB(I)=PGLOB(I-1)_"DA,"_PNODE(N)_","
 . . . S N=N-1
 . . . S ^TMP($J,"XGLO",PGLOB(I))=""
 . . . S XGLOB=PGLOB(I)
 . . F PFLD=0:0 S PFLD=$O(^DD(FILE,0,"PT",PFILE,PFLD)) Q:PFLD'>0  D
 . . . I '$D(^DD(PFILE,PFLD,0)) Q
 . . . I $P(^DD(PFILE,PFLD,0),U,2)'["V",$P(^(0),U,3)'=$E(^DIC(FILE,0,"GL"),2,200),PFILE'=53.51 Q  ; MAKE SURE POINTER IS 'REALLY' POINTING TO FILE (E.G., FIELD 400 IN FILE 60)
 . . . S NODE=$P($G(^DD(PFILE,PFLD,0)),U,4)
 . . . I NODE="" Q
 . . . S PIECE=$P(NODE,";",2)
 . . . S NODE=$P(NODE,";")
 . . . I NODE'=+NODE S NODE=""""_NODE_""""
 . . . S XREF=""
 . . . I PFLD=.01,$D(^DIC(PFILE,0)) D  ; MODIFIED 03/24/99 - JLI USE DINUM ONLY AT TOP OF FILE
 . . . . I ^DD(PFILE,PFLD,0)["DINUM" D
 . . . . . S XREF="DINUM"
 . . . . . S XDRDINUM(PFILE)=""
 . . . ;
 . . . ; the following section of code was modified to identify any pointer value reachable with
 . . . ; a cross-reference whether top level or in a subfile.  The x-reference is checked for
 . . . ; the expected value for at least ten entries before being considered valid
 . . . ; 03/24/99 - JLI
 . . . ;
 . . . I XREF="" D
 . . . . N J,K,L,X1,NMAX,GLOBPCS,YGLOB,KN,KI,NCNT
 . . . . S NMAX=$L(XGLOB,"DA,") F J=1:1:NMAX S GLOBPCS(J)=$P(XGLOB,"DA,",J)
 . . . . F J=0:0 Q:XREF'=""  S J=$O(^DD(PFILE,PFLD,1,J)) Q:J'>0  D
 . . . . . S X1=$P($G(^DD(PFILE,PFLD,1,J,0)),U,2)
 . . . . . Q:X1=""
 . . . . . I X1'=+X1 S X1=""""_X1_""""
 . . . . . S K="" F KN=1:1 S K=$O(@(GLOBPCS(1)_X1_","_$S(K'=+K:""""_K_"""",1:K)_")")) Q:K=""!(XREF'="")  D  S:KN>10&(XREF="") XREF=X1_U_J I KN>10 Q  ; global value used as naked global on next line
 . . . . . . S YGLOB=GLOBPCS(1),L=K,NCNT=0 F KI=1:1:NMAX S L=$O(^(L,"")) Q:L'>0!(L'=+L)  S NCNT=NCNT+1,YGLOB=YGLOB_L_","_$S(NCNT<NMAX:GLOBPCS(KI+1),1:"") ; naked global used on above line and within loop (descending subscripts)
 . . . . . . I NCNT'=NMAX S XREF=-1 Q
 . . . . . . I $E($P($G(@(YGLOB_NODE_")")),U,PIECE),1,30)'=K S XREF=-1 ; MODIFIED 3/19/99 JLI
 . . . . . I XREF=-1 S XREF=""
 . . . I XREF'="",(XREF'="DINUM") D  ;modified 3/6/2003 JDS XT*7.3*73
 . . . . S CHECK=^DD(PFILE,PFLD,1,$P(XREF,U,2),1)
 . . . . S STANDARD="S "_PGLOB(0)_$P(XREF,U)_",$E(X,1,30),DA"
 . . . . I CHECK'[STANDARD S XREF=""
 . . . I XREF'=""&(XDRTYPE'=3) S ^TMP($J,"XGLOB",XGLOB,NODE,PIECE)=PFILE_U_PFLD_U_XREF
 . . . I (XREF=""&(XDRTYPE=3)) S ^TMP($J,"XGLOB",XGLOB,NODE,PIECE)=$S(XDRTYPE'=3:PFILE_U_PFLD_U_XREF,$O(^DD(PFILE,PFLD,1,0))>0:PFILE_U_PFLD,1:"")
 . . . ; END OF CHANGES 03/24/99 - JLI
 Q
