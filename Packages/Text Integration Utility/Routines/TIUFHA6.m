TIUFHA6 ; SLC/MAM - Templates A H J C D X Action TRY ;12/4/97
 ;;1.0;TEXT INTEGRATION UTILITIES;**5,12**;Jun 20, 1997
 ;
CHECKDEF ; Templates A, C, H, D, X, J Action Try
 N INFO,FILEDA,MSG,TIUFXNOD,SUCCESS,NODE0,CLASSFDA,ANCEST,TIUFI,PFILEDA
 N SUBS,DTOUT,DIRUT,DIROUT,DETAILS,DODOCMT
 S VALMBCK="",TIUFXNOD=$G(XQORNOD(0))
 I $P(TIUFXNOD,U,3)="TR" W "Try",! S $P(TIUFXNOD,U,4)="TR="_$P($P(TIUFXNOD,U,4),"==",2)
 I $P(TIUFXNOD,U,3)="TRY" W "Try",! S $P(TIUFXNOD,U,4)="TRY="_$P($P(TIUFXNOD,U,4),"==",2)
 I $G(TIUFSTMP)="T" W !!,"Action Try not available on items screen.",! H 2 Q
 I '$D(TIUFSTMP) D EN^VALM2(TIUFXNOD,"SO") G:'$O(VALMY(0)) CHECX S INFO=$G(^TMP("TIUF1IDX",$J,$O(VALMY(0)))),FILEDA=$P(INFO,U,2) I 'INFO W !!,"Missing List Manager Data; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="Q" G CHECX
 I $D(TIUFSTMP) S FILEDA=$P(TIUFINFO,U,2)
 S PFILEDA=+$O(^TIU(8925.1,"AD",FILEDA,0)),DETAILS=1
 N TIUFCK D CHECK^TIUFLF3(FILEDA,PFILEDA,DETAILS,.TIUFCK)
 G:$D(DTOUT) CHECX
 ;      If all OK, Try on Document if Title, and quit:
 I TIUFCK W !! D  D PAUSE^TIUFXHLX Q:$D(DIRUT)  D:$D(^TIU(8925.1,"AT","DOC",FILEDA)) DOCMT(FILEDA) Q
 . I $G(TIUFSTMP)="X"  W "Boilerplate Text looks OK; no bad/inactive Objects.",! Q
 . W $S($D(^TIU(8925.1,"AT","O",FILEDA)):"Object",1:"Entry")," looks OK; no problems found.",!
 ;      If not all OK, write out nonobject problems:
 K DIRUT
 ; If NOT in subtemplate X:
 I $G(TIUFSTMP)'="X" F SUBS="F","I","T","C","B","O","S","M","U","A","E","R","V","D","H","N","G","P","DESC" D  G:$D(DIRUT) CHECX
 . I $D(TIUFCK(SUBS)) S MSG=$S(SUBS="P":"Entry is an ",$D(^TIU(8925.1,"AT","O",FILEDA)):"Faulty Object: ",1:"Faulty Entry: ")_TIUFCK(SUBS) W !!!,MSG,! D PAUSE^TIUFXHLX
 ;      If not all OK, is Object, write out object problems and quit:
 I $D(^TIU(8925.1,"AT","O",FILEDA)) D  Q
 . F SUBS="J","JN","JA","JP" I $D(TIUFCK(SUBS)) S MSG="Faulty Object: "_TIUFCK(SUBS) W !!!,MSG,! D PAUSE^TIUFXHLX Q:$D(DIRUT)
 ;      If not all OK, has Btext problem, then write Btext problem:
 ; If NOT in subtemplate X or D:
 I '$D(TIUFSTMP),$D(TIUFCK("OBJ"))!$D(TIUFCK("OBJINACT")) D
 . W !!!,$S($D(TIUFCK("OBJ")):"Faulty Entry: Bad",1:"Inactive")," Object in Boilerplate Text.  For details, select",!,"Action BOILERPLATE TEXT, then Action TRY.",! D PAUSE^TIUFXHLX ;template A or H or C
 ; If in subtemplate X or D:
 I $D(TIUFCK("OBJ"))!$D(TIUFCK("OBJINACT")),$G(TIUFSTMP)'="","XD"[$G(TIUFSTMP) D
 . K DIRUT N TIUFCK D XCHECK^TIUFLX(FILEDA,0,1,.TIUFCK) Q:$D(DIRUT)  D DCHECK^TIUFLX(FILEDA,0,1,.TIUFCK) ; 0 for NOT Silent.  XCHECK writes out specific problems for each bad object in Btext.
 ;      If not all OK, no Btext problem, in subtemplate X, then write Btext OK:
 I $G(TIUFSTMP)="X",'$D(TIUFCK("OBJ")),'$D(TIUFCK("OBJINACT")) W !!!,"Boilerplate Text looks OK; no bad/inactive Objects",! D PAUSE^TIUFXHLX Q:$D(DIRUT)
 ;      If not all OK, non Btext problem, in subtemplate X, then write Entry itself is faulty:
 K TIUFCK("OBJINACT") S DODOCMT=$S($D(TIUFCK)'>9:1,1:0) K TIUFCK("OBJ")
 I $G(TIUFSTMP)="X",$D(TIUFCK)>9 W !!!,"Title/Component itself is faulty.  For details, exit out of BOILERPLATE TEXT",!,"and TRY entry.",! D PAUSE^TIUFXHLX Q:$D(DIRUT)
 ;      If is Title and inactive object in Btext is the only problem,
 ;        then try on document:
 I $D(^TIU(8925.1,"AT","DOC",FILEDA)) I DODOCMT D DOCMT(FILEDA)
CHECX I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
DOCMT(FILEDA) ; Try entry on a document
 I $D(DIRUT) Q
 D FULL^VALM1
 W !!,"Checking Title on a document.  You will not be permitted to sign the document,",!,"and the document will be deleted at the end of the check.",!
 W !,"Be sure to select a TEST PATIENT since the document will show up on Unsigned",!,"lists while you are editing it.",!
 S NODE0=^TIU(8925.1,FILEDA,0) D ANCESTOR^TIUFLF4(FILEDA,NODE0,.ANCEST,0)
 S TIUFI=$O(ANCEST(100),-1) S CLASSFDA=$G(ANCEST(TIUFI-1)) I 'CLASSFDA W !!,"Ancestry ERROR; See IRM" D PAUSE^TIUFXHLX
 I CLASSFDA N FPRI,INDEX,TIUASK,VALUE D MAIN^TIUEDIT(CLASSFDA,.SUCCESS,"",FILEDA,1,1) H 1 Q:$D(DTOUT)
 S VALMSG=$$VMSG^TIUFL D RE^VALM4,RESET^TIUFXHLX
 Q
 ;
