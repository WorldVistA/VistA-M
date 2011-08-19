LRBLAUD1 ;TOG/CYM   -AUDIT TRAIL UTILITY ;4/30/97   14:00
 ;;5.2;LAB SERVICE;**90,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 ; This routine is called by file 65 edit template LRBLIDTM
 ;
 ; When a transfusion of TRANSFUSE is edited, the routine
 ; gathers all information that is deleted along with the
 ; disposition, puts into an array for later addition to the
 ; audit trail
 ;
 ; Utility also allows for entries in the MODIFY TO/FROM field
 ; to go onto the audit trail
 ;
DISP ; When editing Unit Disposition, gets
 ; all associated data in files 65 and 63 that are also cleaned up
 ; and saves variables in the case the Disposition is Edited and the
 ; appropriate patient's transfusion record needs to be cleaned up.
 ; If so, these entries are then added to the audit trail.
 S LRDISP=$G(^LRD(65,DA,4)),LRDSP=$P(LRDISP,U),LRDISDT=$P(LRDISP,U,2),LRPERS=$P(LRDISP,U,3),LRDIPD=$P(LRDISP,U,4)
 S LRPTRANS=$G(^LRD(65,DA,6)),LRPTR=$P(LRPTRANS,U),LRPHYS=$P(LRPTRANS,U,2),LRTS=$P(LRPTRANS,U,3),LRREC=$P(LRPTRANS,U,4),LRREACT=$P(LRPTRANS,U,5)
 S LRPROVN=$P(LRPTRANS,U,6),LRTSNUM=$P(LRPTRANS,U,7),LRRXTYPE=$P(LRPTRANS,U,8) I LRPTR]"" D
 . S LRPTREC=$G(^LR(LRPTR,1.6,LRREC,0)),LRTRDT=$P(LRPTREC,U),LRCOMP=$P(LRPTREC,U,2),LRCOMPID=$P(LRPTREC,U,3),LRENTP=$P(LRPTREC,U,4),LRUNABO=$P(LRPTREC,U,5)
 . S LRUNRH=$P(LRPTREC,U,6),LRPOOL=$P(LRPTREC,U,7),LRRECRX=$P(LRPTREC,U,8),LROLD=$P(LRPTREC,U,9),LRVOL=$P(LRPTREC,U,10),LRTYPE=$P(LRPTREC,U,11)
 Q
 ;
DISP1 ; Actual code that adds data removed from the system when a 
 ; disposition is deleted when using the option LRBLSED.
 Q:$D(^LRD(65,DA,4))
 S O=$G(LRDISDT),Z="65,4.2" D AUDIT
 S O=$G(LRPERS),Z="65,4.3" I O]"" S X="Orig Entry Deleted" D EN^LRUD
 S O=$G(LRDIPD),Z="65,4.4" D AUDIT
 S O=$G(LRPTR),Z="65,6.1" D AUDIT
 S O=$G(LRPHYS),Z="65,6.2" D AUDIT
 S O=$G(LRTS),Z="65,6.3" D AUDIT
 S O=$G(LRREC),Z="65,6.4" D AUDIT
 S O=$G(LRREACT),Z="65,6.5" D AUDIT
 S O=$G(LRPROVN),Z="65,6.6" D AUDIT
 S O=$G(LRTSNUM),Z="65,6.7" D AUDIT
 S O=$G(LRRXTYPE),Z="65,6.8" D AUDIT
 Q:'$D(LRPTR)  Q:LRPTR']""
 S O=$G(LRTRDT),Z="63.017,.01" S DA(1)=LRPTR,DA=LRREC D AUDIT
 S O=$G(LRCOMP),Z="63.017,.02" D AUDIT
 S O=$G(LRCOMPID),Z="63.017,.03" D AUDIT
 S O=$G(LRENTP),Z="63.017,.04" D AUDIT
 S O=$G(LRUNABO),Z="63.017,.05" D AUDIT
 S O=$G(LRUNRH),Z="63.017,.06" D AUDIT
 S O=$G(LRPOOL),Z="63.017,.07" D AUDIT
 S O=$G(LRRECRX),Z="63.017,.08" D AUDIT
 S O=$G(LROLD),Z="63.017,.09" D AUDIT
 S O=$G(LRVOL),Z="63.017,.1" D AUDIT
 S O=$G(LRTYPE),Z="63.017,.11" D AUDIT
 Q
 ;
AUDIT I O]"" S X="Deleted" D EN^LRUD
 Q
 ;
K ; Kills variables created during editing of a disposition
 K LRIEN,NODE2,LRDISDT,LRDISP,LRDSP,LRDIST,LRPERS,LRPTRANS,LRDIPD,LRPTR,LRPHYS,LRTS,LRREC,LRREACT,LRPROVN,LRTSNUM,LRRXTYPE,LRPTREC,LRTRDT,LRCOMP,LRCOMPID,LRENTP,LRUNABO,LRUNRH,LRPOOL,LRRECRX,LROLD,LRVOL,LRTYPE,MOD,BEGMOD,AFTMOD,BEGM
 Q
 ;
DISP4 ; Actual code used to evaluate when the DISPOSITION field (4.1)
 ; is edited and the software edits/deletes associated
 ; fields.  Each field is evaluated and if there is a change
 ; the changes are captured on the audit trail.
 S LRM=$G(^LRD(65,DA,4))
 S O=$G(LRDISDT),X=$P(LRM,U,2),Z="65,4.2" D CHECK
 S O=$G(LRPERS),X=DUZ,Z="65,4.3" D CHECK
 S O=$G(LRDIPD),X=$P(LRM,U,4),Z="65,4.4" D CHECK
 S LRM=$G(^LRD(65,DA,6))
 S O=$G(LRPTR),X=$P(LRM,U),Z="65,6.1" D CHECK
 S O=$G(LRPHYS),X=$P(LRM,U,2),Z="65,6.2" D CHECK
 S O=$G(LRTS),X=$P(LRM,U,3),Z="65,6.3" D CHECK
 S O=$G(LRREC),X=$P(LRM,U,4),Z="65,6.4" D CHECK
 S O=$G(LRREACT),X=$P(LRM,U,5),Z="65,6.5" D CHECK
 S O=$G(LRPROVN),X=$P(LRM,U,6),Z="65,6.6" D CHECK
 S O=$G(LRTSNUM),X=$P(LRM,U,7),Z="65,6.7" D CHECK
 S O=$G(LRRXTYPE),X=$P(LRM,U,8),Z="65,6.8" D CHECK
 I LRPTR]"" D DISP5
 Q
 ;
DISP5 ; If Disposition is edited to TRANSFUSE, routine LRBLJED creates
 ; a patient transfusion record in file 63.  Following code adds
 ; those changes to the audit trail.
 S LRM=$G(^LR(LRPTR,1.6,LRREC,0))
 S O=$G(LRTRDT),X=$P(LRM,U),Z="63.017,.01" S DA(1)=LRPTR,DA=LRREC D CHECK
 S O=$G(LRCOMP),X=$P(LRM,U,2),Z="63.017,.02" D CHECK
 S O=$G(LRCOMPID),X=$P(LRM,U,3),Z="63.017,.03" D CHECK
 S O=$G(LRENTP),X=$P(LRM,U,4),Z="63.017,.04" D CHECK
 S O=$G(LRUNABO),X=$P(LRM,U,5),Z="63.017,.05" D CHECK
 S O=$G(LRUNRH),X=$P(LRM,U,6),Z="63.017,.06" D CHECK
 S O=$G(LRPOOL),X=$P(LRM,U,7),Z="63.017,.07" D CHECK
 S O=$G(LRRECRX),X=$P(LRM,U,8),Z="63.017,.08" D CHECK
 S O=$G(LROLD),X=$P(LRM,U,9),Z="63.017,.09" D CHECK
 S O=$G(LRVOL),X=$P(LRM,U,10),Z="63.017,.1" D CHECK
 S O=$G(LRTYPE),X=$P(LRM,U,11),Z="63.017,.11" D CHECK
 Q
 ;
MOD ; At the beginning of an edit session, collects all data
 ; in the MODIFIED TO/FROM field multiple, puts into a
 ; BEGM() array and counts total for later comparison.
 S (MOD,BEGMOD)=0
 F  S MOD=$O(^LRD(65,LRIEN,9,MOD)) Q:MOD'>0  S BEGMOD=BEGMOD+1,BEGM(LRIEN,9,MOD)=^LRD(65,LRIEN,9,MOD,0)
 Q
 ;
MOD2 ; If a disposition of MODIFY is deleted, collects all data in the
 ; MODIFY TO/FROM field multiple (from the BEGM() array), and adds
 ; to the audit trail before the software deletes the entries.
 Q:'$D(BEGM)
 S DA(1)=DA,MOD=0 F  S MOD=$O(^LRD(65,LRIEN,9,MOD)) Q:MOD'>0  D
 . S LRM=^LRD(65,LRIEN,9,MOD,0)
 . S O=$P(LRM,U),Z="65.091,.01" D AUDIT
 . S O=$P(LRM,U,2),Z="65.091,.02" D AUDIT
 . S O=$P(LRM,U,3),Z="65.091,.03" D AUDIT
 Q
 ;
MOD3 ; Counts MODIFY TO/FROM entries after unit is modified.
 ; If total entries after modification < total entries before
 ; modification puts deleted entry onto the audit trail
 S (MOD,AFTMOD)=0
 F  S MOD=$O(^LRD(65,LRIEN,9,MOD)) Q:MOD'>0  S AFTMOD=AFTMOD+1,AFTM(LRIEN,9,MOD)=^LRD(65,LRIEN,9,MOD,0)
 I AFTMOD<BEGMOD D
 . S AUD=0
 . F  S AUD=$O(BEGM(LRIEN,9,AUD)) Q:AUD'>0  D
 .. I '$D(^LRD(65,LRIEN,9,AUD)) D
 ... S LRM=BEGM(LRIEN,9,AUD)
 ... S O=$P(LRM,U),Z="65.091,.01" D AUDIT
 ... S O=$P(LRM,U,2),Z="65.091,.02" D AUDIT
 ... S O=$P(LRM,U,3),Z="65.091,.03" D AUDIT
 I AFTMOD>BEGMOD D
 . S AUD=0
 . F  S AUD=$O(AFTM(LRIEN,9,AUD)) Q:AUD'>0  D
 .. I '$D(BEGM(LRIEN,9,AUD)) D
 ... S LRM=^LRD(65,LRIEN,9,AUD,0)
 ... S X=$P(LRM,U),Z="65.091,.01",O="" D EN^LRUD
 ... S X=$P(LRM,U,2),Z="65.091,.02",O="" D EN^LRUD
 Q
CHECK I O'=X D EN^LRUD
 Q
