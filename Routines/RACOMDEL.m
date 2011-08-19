RACOMDEL ;HIRMFO/GJC-Utility, remove duplicates in ^RAMIS(71.3 ;7/10/97  09:17
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
 ; This routine is called from the RAO7MFN routine after initial
 ; population of CPRS (OE/RR v3) Orderable Items file.
 ; Deletes all but one instance of a procedure in the Rad/Nuc Med
 ; Common Procedure file.
 K RA1,RA2,RA3,RACNT,RAIEN,RAPROC,^TMP($J,"RA CMMN PROC") S RAPROC=0
 F  S RAPROC=$O(^RAMIS(71.3,"B",RAPROC)) Q:RAPROC'>0  D
 . S (RACNT,RAIEN)=0
 . F  S RAIEN=+$O(^RAMIS(71.3,"B",RAPROC,RAIEN)) Q:RAIEN'>0  D
 .. S RACNT=RACNT+1 D:RACNT>1 SAVE
 .. Q
 . Q
 I '$D(^TMP($J,"RA CMMN PROC")) D XIT Q
 S RA1=0
 F  S RA1=$O(^TMP($J,"RA CMMN PROC",RA1)) Q:RA1'>0  D  ;file 71 ien
 . S RA2="",RACNT=0
 . F  S RA2=$O(^TMP($J,"RA CMMN PROC",RA1,RA2)) Q:RA2']""  D  ;active?
 .. S RA3=0
 .. F  S RA3=$O(^TMP($J,"RA CMMN PROC",RA1,RA2,RA3)) Q:RA3'>0  D  ;71.3
 ... S RACNT=RACNT+1 D:RACNT>1 PURGE(RA3)
 ... Q
 .. Q
 . Q
 D RESEQ ; re-sequence common procedures
XIT ; Kill variables and quit
 K RA1,RA2,RA3,RACNT,RAIEN,RAPROC,^TMP($J,"RA CMMN PROC")
 Q
PURGE(DA) ; Delete duplicate common procedures saving the first
 ; occurrence of our common in question.  Data is stored so that active
 ; common procedures will sort first.
 ; Input: DA-ien of entry in 71.3 to be deleted!
 K %,DIC,DIK,X,Y S DIK="^RAMIS(71.3," D ^DIK K %,DIC,DIK,X,Y
 Q
SAVE ; Save off all common procedure data when more than one occurrence.
 K RA713,RACTIV
 I RACNT=2 D
 . N RAIEN S RAIEN=+$O(^RAMIS(71.3,"B",RAPROC,0)) Q:'RAIEN
 . S RA713=$G(^RAMIS(71.3,RAIEN,0)) Q:RA713']""
 . S RACTIV=$S($P(RA713,"^",5)]"":1,1:0)
 . D SET
 . Q
 S RA713=$G(^RAMIS(71.3,RAIEN,0)) Q:RA713']""
 S RACTIV=$S($P(RA713,"^",5)]"":1,1:0) D SET
 K RA713,RACTIV
 Q
SET ; Set the ^TMP($J,"RA CMMN PROC") global.
 ; RAPROC=pntr to file 71, RAIEN=ien in file 71.3
 ; RACTIV=Active flag: 1 for inactive, 0 for active
 S ^TMP($J,"RA CMMN PROC",RAPROC,RACTIV,RAIEN)=""
 Q
RESEQ ;Resequence the common procedure list for all imaging types
 N D,DA,D0,DI,DIC,DIE,DQ,DR,RACNT,RAI,RAIMGTYI,RAJ,X,Y
 S DIE="^RAMIS(71.3,",RAIMGTYI=0
 F  S RAIMGTYI=$O(^RAMIS(71.3,"AA",RAIMGTYI)) Q:RAIMGTYI'>0  D
 . S (RAI,RACNT)=0
 . F  S RAI=$O(^RAMIS(71.3,"AA",RAIMGTYI,RAI)) Q:RAI'>0  D
 .. S RAJ=0
 .. F  S RAJ=$O(^RAMIS(71.3,"AA",RAIMGTYI,RAI,RAJ)) Q:RAJ'>0  I $D(^RAMIS(71.3,RAJ,0)) D
 ... S DA=RAJ,RACNT=RACNT+1
 ... S DR="3////^S X=RACNT" D ^DIE
 ... Q
 .. Q
 . Q
 Q
