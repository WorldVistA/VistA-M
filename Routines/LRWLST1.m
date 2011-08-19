LRWLST1 ;DALOI/CJS/RWF/FHS - ACCESSION SETUP ; July 19, 2006
 ;;5.2;LAB SERVICE;**48,65,121,153,261,286,331,379**;Sep 27, 1994;Build 2
 ;
 ; Reference to ^DIC(42 supported by IA #10039
 ; Reference to ^SC( supported by IA #10040
 ;
 S LRWLC=0
 F  S LRWLC=$O(LRTSTS(LRWLC)) Q:LRWLC<1  S LRAD=DT D SPLIT
 ;
 ; If LEDI and comments came with order then copy to order in #69
 I $G(LRORDRR)="R",$G(LR696),$D(^LRO(69.6,LR696,99)) D
 . N LRDIE
 . D WP^DIE(69.01,LRSN_","_LRODT_",",16,"A","^LRO(69.6,LR696,99)","LRDIE(16)")
 ;
 K DIC,DLAYGO,DR,DA,DIE,LRIXX
 Q:$G(LRORDR)="P"
 K LRNM,LRTSTS
 K ^TMP("LR",$J,"TMP")
 Q
 ;
SPLIT ;
 N LRAA,LRX
 ; Setup regular accessions (LRUNQ=0)
 S LRUNQ=0,LREND=0
 I $D(LRTSTS(LRWLC,0)) D
 . D GTWLN
 . I LREND Q
 . S LRAA=0
 . F  S LRAA=$O(LRTSTS(LRWLC,0,LRAA)) Q:LRAA<1  D
 . . S LRSS=LRTSTS(LRWLC,0,LRAA)
 . . D STWLN,ST2,^LRWLST11,EN^LA7ADL(LRUID)
 . D SICA^LRWLST11
 ;
 ; Setup accessions requiring 'unique' accession numbers (LRUNQ=1)
 S LRUNQ=1,LRAA=0
 F  S LRAA=$O(LRTSTS(LRWLC,1,LRAA)) Q:LRAA<1  D
 . S LRSS=LRTSTS(LRWLC,1,LRAA)
 . F  D GTWLN Q:LREND  D   Q:$O(LRTSTS(LRWLC,1,LRAA,0))<1
 . . D STWLN,ST2,^LRWLST11,EN^LA7ADL(LRUID),SICA^LRWLST11
 Q
 ;
 ;
STWLN ; Set accession number
 ;
 D GETLOCK(LRAA,LRAD)
 D CHECK68(LRAA,LRAD)
 ;
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 ;
 ; Handle 'in common' area that was not setup in GTWLN call.
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN)) D SETAN(LRAA,LRAD,LRAN)
 ;
 S LREND=0,LRLBLBP=1-$P(LRSS,U,2),LRSS=$P(LRSS,U)
 S LRACC=$P(^LRO(68,LRAA,0),U,11)_" "_$S(LRAD["0000":$E(LRAD,2,3),1:$E(LRAD,4,7))_" "_LRAN
 ;
 S LRPRAC=""
 I $D(^LRO(69,LRODT,1,LRSN,0)) S LRPRAC=$P(^(0),U,6) S:$D(LRNT) ^(3)=LRNT
 ;
 ; Location type
 S LRCAPLOC=$P($G(^SC(+LROLLOC,0)),U,3)
 I LRCAPLOC="" S LRCAPLOC="Z"
 ;
 ; File information in file #68 for this accession
 N FDA,LR6802,LRDIE
 S LR6802=LRAN_","_LRAD_","_LRAA_","
 S FDA(1,68.02,LR6802,.01)=LRDFN
 S FDA(1,68.02,LR6802,1)=LRDPF
 S FDA(1,68.02,LR6802,2)=LRAD
 S FDA(1,68.02,LR6802,3)=LRODT
 S FDA(1,68.02,LR6802,4)=LRSN
 S FDA(1,68.02,LR6802,6)=LRLLOC
 S X=$G(^LRO(69,LRODT,1,LRSN,.1)) I X'="" S FDA(1,68.02,LR6802,14)=X
 ;
 ; No ordering provider/location on controls
 I LRDPF'=62.3 D
 . S FDA(1,68.02,LR6802,6.5)=LRPRAC
 . S FDA(1,68.02,LR6802,94)=LROLLOC
 ;
 ; Only store treating specialty on file #2 patients
 ; If no treating specialty then use specialty from file #44 location
 I LRDPF=2 D
 . S LRTREA=$P($G(^DPT(DFN,.103)),U)
 . I 'LRTREA S LRTREA=$P($G(^SC(+LROLLOC,0)),U,20)
 . I LRTREA S FDA(1,68.02,LR6802,6.6)=LRTREA
 ;
 S FDA(1,68.02,LR6802,6.7)=DUZ
 S FDA(1,68.02,LR6802,15)=LRACC
 S FDA(1,68.02,LR6802,26)=DUZ(2)
 S FDA(1,68.02,LR6802,92)=LRCAPLOC
 ;
 D FILE^DIE("","FDA(1)","LRDIE(1)")
 I $D(LRDIE(1)) D MAILALRT
 ;
 ; If specimen defined then set nodes, force to ien=1 since many lab
 ; routines expect the specimen to be record number 1.
 I $G(LRSPEC) D
 . N FDAIEN
 . S FDAIEN(1)=1
 . S FDA(2,68.05,"+1,"_LR6802,.01)=LRSPEC
 . S FDA(2,68.05,"+1,"_LR6802,1)=$P(LRSAMP,";",1)
 . ;
 . ; Modification to prevent lock failures - loop 10 times to give system a chance to get lock
 . N LRLOCKOK,LRLOOPCT
 . S LRLOCKOK=0
 . F LRLOOPCT=1:1:10 Q:LRLOCKOK  D  I 'LRLOCKOK H 5
 . . K LRDIE(2)
 . . D UPDATE^DIE("","FDA(2)","FDAIEN","LRDIE(2)")
 . . S:$D(LRDIE(2))=0 LRLOCKOK=1
 . K LRLOCKOK,LRLOOPCT
 . ;
 . ;D UPDATE^DIE("","FDA(2)","FDAIEN","LRDIE(2)")
 . I $D(LRDIE(2)) D MAILALRT
 ;
 ; If no specimen defined then use specimen values from file #69.
 I $G(LRSPEC)="",$D(^LRO(69,LRODT,1,LRSN,4,0)) D
 . N FDA,FDAIEN,LRI,LRX
 . S LRI=0
 . F  S LRI=$O(^LRO(69,LRODT,1,LRSN,4,LRI)) Q:'LRI  D
 . . S FDAIEN(1)=LRI,LRX=$G(^LRO(69,LRODT,1,LRSN,4,LRI,0))
 . . S FDA(LRI,68.05,"+1,"_LR6802,.01)=$P(LRX,"^")
 . . D UPDATE^DIE("","FDA(LRI)","FDAIEN","LRDIE(LRI)")
 . . I $D(LRDIE(LRI)) D MAILALRT
 ;
 ; Create UID.
 S LRUID=$$LRUID^LRX(LRAA,LRAD,LRAN)
 ;
 I '$D(LRPHSET),('$G(LRQUIET)) W !!,"ACCESSION:  ",LRACC,"  <",LRUID,">"
 ;
 D UPD696
 ;
 L -^LRO(68,LRAA,1,LRAD,1,0)
 Q
 ;
 ;
UPD696 ; Update file #69.6 if LEDI referral patient and no existing entry
 K LR696IEN
 I $G(LRORDRR)="R" D
 . S LR696IEN=0
 . I $G(LRRSITE("SMID"))'="",$G(LRSD("RUID"))'="" S LR696IEN=+$O(^LRO(69.6,"AD",LRRSITE("SMID"),LRSD("RUID"),0))
 . I LR696IEN Q
 . I '$G(LRRSTAT(0)) S LRRSTAT(0)=$$FIND1^DIC(64.061,"","OMX","Specimen in process","","I $P(^LAB(64.061,Y,0),U,7)=""U""")
 . D PSET^LRPEND(SSN(2),+LRRSITE("RSITE"),LRSD("RUID"),+LRSD("RPSITE"),LRSPEC,LRSAMP,LRRSTAT(0),LRODT,$P(LRCDT,U),LRRSITE("SDT"),LRNT,.LROT)
 Q
 ;
 ;
ST2 ; Find next available node in LR global
 ;
 N FDA,FDAIEN,LRDIE,LRX,LRXIDT
 ;
 ; Autopsy ("AU") is not a mulitple - do not attempt to set in ^LR global
 I LRSS="AU" S LRIDT=0 Q
 ;
 S LRIDT=0
 F  D  Q:LRIDT
 . S LRXIDT=9999999-LRCDT
 . L +^LR(LRDFN,LRSS,LRXIDT,0):5
 . I '$T S LRCDT=$$FMADD^XLFDT(LRCDT,0,0,0,1) Q
 . I '$D(^LR(LRDFN,LRSS,LRXIDT,0)) S LRIDT=LRXIDT Q
 . L -^LR(LRDFN,LRSS,LRXIDT,0)
 . S LRCDT=$$FMADD^XLFDT(LRCDT,0,0,0,1)
 ;
 ; Create entry in appropriate subscript in LAB DATA file (#63).
 S LRX=$S(LRSS="CH":63.04,LRSS="MI":63.05,LRSS="BB":63.01,LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,1:0)
 S FDAIEN(1)=LRIDT
 S FDA(63,LRX,"+1,"_LRDFN_",",.01)=LRCDT
 S FDA(63,LRX,"+1,"_LRDFN_",",.06)=LRACC
 I LRSS'="CH" S FDA(63,LRX,"+1,"_LRDFN_",",.1)=LRNT
 I LRSS="CH" S FDA(63,LRX,"+1,"_LRDFN_",",.12)=3
 I LRSS="MI" S FDA(63,LRX,"+1,"_LRDFN_",",38)=3
 I LRX D UPDATE^DIE("","FDA(63)","FDAIEN","LRDIE(63)")
 I $D(LRDIE(63)) D MAILALRT
 ;
 ; Uncomment following code when new field .9 in"MI" subscript is released
 ;I LRSS="MI" D
 ;. N LRN,ERR,IENS
 ;. S IENS=LRIDT_","_LRDFN_",",LRN=0
 ;. F  S LRN=$O(^LRO(69,LRODT,1,LRSN,2,LRN)) Q:LRN<1  D
 ;. . I '$D(^LRO(69,LRODT,1,LRSN,2,LRN,1,0)) Q
 ;. . D WP^DIE(63.05,IENS,.9,"A","^LRO(69,"_LRODT_",1,"_LRSN_",2,"_LRN_",1)","ERR")
 ;
 L -^LR(LRDFN,LRSS,LRIDT,0)
 ;
 Q
 ;
 ;
GTWLN ;
 N X
 ;
 ; Execute accession transform for this area.
 S LRAN=0
 S X=$G(^LRO(68,LRWLC,.1)) X:X'="" X
 ;
 D GETLOCK(LRWLC,LRAD)
 D CHECK68(LRWLC,LRAD)
 ;
 S:'LRAN LRAN=1+$P($G(^LRO(68,LRWLC,1,LRAD,1,0)),U,3)
 ;
 I "CYEMSP"'[LRSS F  Q:'$D(^LRO(68,LRWLC,1,LRAD,1,LRAN))  S LRAN=LRAN+1
 ;
 ; check for AP Accessions
 I "CYEMSP"[LRSS F  Q:'$D(^LRO(68,LRWLC,1,LRAD,1,LRAN))&'$D(^LR("A"_LRSS_"A",$E(LRAD,1,3),LRAN))  S LRAN=LRAN+1
 ;
 I '$D(LRPHSET),$D(LRNCWL)!$P(^LAB(69.9,1,0),U,8) D ASK Q:LREND
 ;
 D SETAN(LRWLC,LRAD,LRAN)
 ;
 L -^LRO(68,LRWLC,1,LRAD,1,0)
 Q
 ;
 ;
ASK ;
 ; Don't ask if tasked or a "silent" call
 I $D(ZTQUEUED)!($G(LRQUIET)) Q
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LROK,LRANX,X,Y
 S LROK=0
 F  D  Q:LREND!(LROK)
 . K DIR
 . S DIR(0)="NO^1:"_$S($P(LRLABKY,U,2):999999,1:LRAN)_":0"
 . S DIR("A")="Force to",DIR("B")=LRAN
 . D ^DIR
 . I $D(DIRUT) S LREND=1 Q
 . S LRANX=Y
 . I LRANX<+$P($G(^LRO(68,LRWLC,1,LRAD,1,0)),U,3) D
 . . W !,"This accession number may be already assigned either in this "
 . . W !,"area or a common accession area."
 . I $D(^LRO(68,LRWLC,1,LRAD,1,LRANX,0)) D  Q:'LROK
 . . N LRDFNX S LRDFNX=LRDFN
 . . N DFN,LRDFN,LRDPF,PNM,SSN
 . . S LRDFN=+^LRO(68,LRWLC,1,LRAD,1,LRANX,0),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^LR(LRDFN,0),U,3)
 . . D PT^LRX
 . . W !,"THIS NUMBER BELONGS TO ",!,PNM,"     SSN: ",SSN
 . . D INF^LRX
 . . I LRDFN=LRDFNX S LROK=1
 . K DIR
 . S DIR(0)="YO",DIR("A")="Are you sure",DIR("B")="NO"
 . D ^DIR
 . I $D(DIRUT) S LREND=1 Q
 . I Y=1 S LRAN=LRANX,LROK=1
 ;
 ; Unlock if aborting.
 I LREND L -^LRO(68,LRWLC,1,LRAD,1,0)
 ;
 Q
 ;
 ;
CHECK68(LRAA,LRAD) ; Check for/set header node of ^LRO(68) 68.01 subfile.
 ;
 ; Call with LRAA = ien of entry in file #68
 ;           LRAD = accession date in fileman format
 ;
 ; Set accession date in file #68 for this acession.
 ; Check for existence of accession number multiple but not accession date multiple,
 ; FileMan DBS call fails when accession number multiple exists but accession date multiple does not.
 ; If this condition found then set missing node directly and quit.
 ;
 I '$D(^LRO(68,LRAA,1,LRAD,0)) D
 . N FDA,FDAIEN,LRDIE,X
 . S X=$Q(^LRO(68,LRAA,1,LRAD,0))
 . I X'="",$QS(X,4)=LRAD S $P(^LRO(68,LRAA,1,LRAD,0),"^")=LRAD Q
 . S (FDAIEN(1),FDA(1,68.01,"+1,"_LRAA_",",.01))=LRAD
 . D UPDATE^DIE("","FDA(1)","FDAIEN","LRDIE(1)")
 . I $D(LRDIE(1)) D MAILALRT
 ;
 Q
 ;
 ;
GETLOCK(LRAA,LRAD) ; Obtain lock on zeroth node of this accession date
 ; Call with LRAA = ien of entry in file #68
 ;           LRAD = accession date in fileman format
 ;
 F  L +^LRO(68,LRAA,1,LRAD,1,0):10 Q:$T  D
 . I $D(ZTQUEUED)!($G(LRQUIET)) Q
 . W !!?5,"Accession area ",$P(^LRO(68,LRAA,0),"^")," is locked by another user.",!,$C(7)
 Q
 ;
 ;
SETAN(LRAA,LRAD,LRAN) ; Create stub entry in file #68 for this acession.
 ;
 ; Call with LRAA = ien of entry in file #68
 ;           LRAD = accession date in fileman format
 ;           LRAN = accession number
 ;
 N FDA,FDAIEN,LR6802,LRDIE
 ;
 S LR6802=LRAD_","_LRAA_","
 S FDAIEN(1)=LRAN
 S FDA(2,68.02,"+1,"_LR6802,.01)=LRDFN
 ;
 ; Modification to prevent lock failures - loop 10 times to give system a chance to get lock
 N LRLOCKOK,LRLOOPCT
 S LRLOCKOK=0
 F LRLOOPCT=1:1:10 Q:LRLOCKOK  D  I 'LRLOCKOK H 5
 . K LRDIE(2)
 . D UPDATE^DIE("","FDA(2)","FDAIEN","LRDIE(2)")
 . S:$D(LRDIE(2))=0 LRLOCKOK=1
 K LRLOCKOK,LRLOOPCT
 ;
 ;D UPDATE^DIE("","FDA(2)","FDAIEN","LRDIE(2)")
 I $D(LRDIE(2)) D MAILALRT
 Q
 ;
 ;
MAILALRT ; Send mail message alert when FileMan DBS errors returned
 ;
 N J,LR68,LRCNT,LRMTXT,X,XMINSTR,XMSUB,XMTO
 ;
 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN)) M LR68=^LRO(68,LRAA,1,LRAD,1,LRAN)
 ;
 S LRMTXT(1)="The following debugging information is provided to assist"
 S LRMTXT(2)="support staff in resolving error during accessioning."
 S LRMTXT(3)=" "
 S LRCNT=3
 ;
 F J="FDA","FDAIEN","LR68","LRAA","LRAD","LRAN","LRDFN","LRDIE","LRSS","LRTSTS","LRUNQ","LRWLC","XQY","XQY0" D
 . S X=$G(@J)
 . I X'="" S LRCNT=LRCNT+1,LRMTXT(LRCNT)=J_"="_X
 . F  S J=$Q(@J) Q:J=""  S LRCNT=LRCNT+1,LRMTXT(LRCNT)=J_"="_@J
 ;
 S XMSUB="FileMan DBS call failed during accessioning in routine LRWLST1"
 S XMTO("G.LMI")=""
 S XMINSTR("FROM")=.5
 S XMINSTR("ADDR FLAGS")="R"
 D SENDMSG^XMXAPI(DUZ,XMSUB,"LRMTXT",.XMTO,.XMINSTR)
 Q
