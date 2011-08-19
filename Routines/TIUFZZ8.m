TIUFZZ8 ; SLC/MAM - Post Patch TIU*1*27 Cleanup. Scratch.  Updates fld .04 for documents in TIU DOCUMENT FILE ;8/27/97  14:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**27**;Jun 20, 1997
 ;
ZZUPDATE ; Update Parent Document Type for all documents, one title at a time.  Scratch tool, needed by sites that have moved documents before having patch 27.
 S %ZIS="Q" D ^%ZIS I POP G UPDAX
 I '$D(IO("Q")) G ZZUP1
 S ZTRTN="ZZUP1^TIUFZZ8",ZTDESC="TIU Document File - Update Parent Document Type"
 D ^%ZTLOAD G UPDAX
 ;
ZZUP1 N TITLEDA,FILEDA,NUPDATE,TIUFMOVE
 S TIUFMOVE="",(TITLEDA,NUPDATE)=0 W !!
 K ^XTMP("TIUFZZ8"),^XTMP("TIUFZZ8P")
 S ^XTMP("TIUFZZ8",0)=+$$FMADD^XLFDT(DT,30)_U_DT
 S ^XTMP("TIUFZZ8P",0)=+$$FMADD^XLFDT(DT,30)_U_DT
 F  S TITLEDA=$O(^TIU(8925.1,"AT","DOC",TITLEDA)) Q:'TITLEDA  K ^XTMP("TIUFMOVE"_TITLEDA) D:$D(^TIU(8925,"B",TITLEDA)) MTRPOINT(TITLEDA,.NUPDATE)
 U IO
 W !!!,"    *** RESULTS: TIU Document File - Update Parent Document Type ***",!
 I NUPDATE D  G UPDAX
 . I $O(^XTMP("TIUFZZ8P",0)) D
 . . W !!,"The following titles have documents but are orphan Titles.  Please make sure you",!,"own each title.  Then add them to the hierarchy using option Edit Document"
 . . W !,"Definitions, action Items for the desired parent, action Add/Create.  Then",!,"update each title, using action Update Documents (under action Copy/Move)."
 . . W !,"If needed, this list can be found in ^XTMP(""TIUFZZ8P"",TITLEDA).",!
 . . W !,"IEN  Title:"
 . . S TITLEDA=0 F  S TITLEDA=$O(^XTMP("TIUFZZ8P",TITLEDA)) Q:'TITLEDA  W !,TITLEDA,"   ",$P(^TIU(8925.1,TITLEDA,0),U)
 . I $O(^XTMP("TIUFZZ8",0)) D
 . . W !!,"The following titles have documents that were not able to be updated.  Please",!,"update them, using regular Document Definition action Update Documents"
 . . W !,"(under action Copy/Move) for each listed title.  If needed, this list can be",!,"found in ^XTMP(""TIUFZZ8"",TITLEDA).",!
 . . W !,"IEN  Title:"
 . . S TITLEDA=0 F  S TITLEDA=$O(^XTMP("TIUFZZ8",TITLEDA)) Q:'TITLEDA  W !,TITLEDA,"   ",$P(^TIU(8925.1,TITLEDA,0),U)
 W !!,"All documents updated for all Titles.",!
 K ^XTMP("TIUFZZ8"),^XTMP("TIUFZZ8P")
UPDAX D ^%ZISC,HOME^%ZIS
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
MTRPOINT(TITLEDA,NUPDATE) ; Repoints PARENT DOCUMENT TYPE to parent of TITLEDA for documents using title TITLEDA.
 N DIE,DR,DA,FILEDA,XDCDA,NOLOCK,TIUFI
 Q:TITLEDA=81  ;ADDENDUM
 I $E(IOST,1,2)="C-" W !!,"Processing documents that use Title ",TITLEDA," ..."
 S (FILEDA,NOLOCK,TIUFI)=0,XDCDA=+$O(^TIU(8925.1,"AD",TITLEDA,0))
 I 'XDCDA D  Q
 . I $O(^TIU(8925,"B",TITLEDA,FILEDA)) S ^XTMP("TIUFZZ8P",TITLEDA)="",NUPDATE=1
 F  S FILEDA=$O(^TIU(8925,"B",TITLEDA,FILEDA)) Q:'FILEDA  D
 . S TIUFI=TIUFI+1
 . I $E(IOST,1,2)="C-",(TIUFI#1000)=1 W "."
 . D MTRPT1(TITLEDA,FILEDA,XDCDA,.NOLOCK)
 I NOLOCK D  Q
 . S NUPDATE=1,^XTMP("TIUFZZ8",TITLEDA)=""
 . S ^XTMP("TIUFMOVE"_TITLEDA,0)=+$$FMADD^XLFDT(DT,30)_U_DT
 . S ^XTMP("TIUFMOVE"_TITLEDA,"ONCETHRU")=""
 Q
 ;
MTRPT1(TITLEDA,DA,XDCDA,NOLOCK) ; Repoint 1 docmt for Move TL.
 ; Requires TITLEDA,DA,XDCDA.
 I '$G(^TIU(8925,DA,0)) W !!,"Document ",DA,", from B Cross Reference, doesn't exist in file 8925.",! Q
 I XDCDA=$P(^TIU(8925,DA,0),U,4) Q  ;  Parent Docmt Type already ok.
 L +^TIU(8925,DA,0):1 I '$T S NOLOCK=1 S ^XTMP("TIUFMOVE"_TITLEDA,DA)="" Q
 S DR=".04////"_XDCDA,DIE=8925 D ^DIE
 L -^TIU(8925,DA,0)
 Q
 ;
