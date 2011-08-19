GMRCIAC1 ;SLC/JFR - FILE IFC ACTIVITIES cont'd ;04/29/09  12:09
 ;;3.0;CONSULT/REQUEST TRACKING;**22,66**;DEC 27, 1997;Build 30
 ;#2051($$FIND1^DIC), #2053(DIE)
 Q
COMP(GMRCAR) ;process partial result, clin complete and admin complete
 ;
 N GMRCDA,GMRCFDA,GMRCORC,GMRCLAT,GMRCACT,FDA
 N GMRCRES,GMRCERR,GMRCSTS,GMRCREAS
 M ^TMP("GMRCIN",$J)=@GMRCAR
 S GMRCORC=^TMP("GMRCIN",$J,"ORC")
 S GMRCREAS=$P($P(GMRCORC,"|",16),U)
 S GMRCDA=$$GETDA^GMRCIAC2(GMRCORC)
 S GMRCSTS=$P(^GMR(123,GMRCDA,0),U,12)
 I '$$LOCKREC^GMRCUTL1(GMRCDA) D  Q  ;couldn't lock record
 . D APPACK^GMRCIAC2(GMRCDA,"AR",901) ;send app. ACK
 . K ^TMP("GMRCIN",$J) Q
 ;
 S GMRCFDA(8)=$S($P(GMRCORC,"|",5)="CM":2,GMRCSTS=2:2,1:9) ;comp or pr
 S GMRCLAT=$S($P(GMRCORC,"|",5)="A":9,GMRCREAS="A":13,1:10)
 S GMRCFDA(9)=GMRCLAT ;complete/upd or incomplete rpt
 I $D(^TMP("GMRCIN",$J,"OBX",6,1)) D
 . S GMRCFDA(15)=$P(^TMP("GMRCIN",$J,"OBX",6,1),"|",5)
 ;     v-- check to see if a duplicate transmission
 I $$DUPACT^GMRCIAC2(GMRCDA,GMRCLAT,GMRCORC,$S(GMRCLAT=13:"",1:$G(^TMP("GMRCIN",$J,"OBX",4,1)))) Q
 M FDA(1,123,GMRCDA_",")=GMRCFDA
 D UPDATE^DIE("","FDA(1)",,"GMRCERR") ;file last action and status
 ; check GMRCERR and act if error
 K GMRCERR
 K GMRCFDA,FDA
 D FILEACT^GMRCIAC2(GMRCDA,GMRCLAT,,$NA(^TMP("GMRCIN",$J)))
 ;     ^--- file result and activities
 I $D(^TMP("GMRCIN",$J,"OBX",4,1)) D  ;file result if there
 . I GMRCLAT=13 Q  ; addendum carries the result that it's addending
 . I GMRCLAT=9 Q  ; don't file result on inc. report
 . I $P(^GMR(123,GMRCDA,12),U,5)="F" Q  ;no comp coming from placer
 . D FILRES^GMRCIAC2(GMRCDA,^TMP("GMRCIN",$J,"OBX",4,1))
 D  ;send notifications
 . I GMRCLAT=9 Q
 . I $P(^GMR(123,GMRCDA,12),U,5)="F" Q  ;filler only gets historical comp
 . N GMRCORTX S GMRCORTX=""
 . I $O(^GMR(123,GMRCDA,51," "),-1)>1 D
 .. S GMRCORTX="New remote result added to "
 . I GMRCLAT=13 S GMRCORTX="Addendum added to "
 . S GMRCORTX=GMRCORTX_"Remote Complete Consult: "_$$ORTX^GMRCAU(+GMRCDA)
 . D MSG^GMRCP($P(^GMR(123,GMRCDA,0),U,2),GMRCORTX,GMRCDA,23,,1)
 D  ;send appl ACK
 . D APPACK^GMRCIAC2(GMRCDA,"AA")
 ;
 K ^TMP("GMRCIN",$J)
 Q
 ;
FWD(GMRCAR)     ;file forward action from a remote site
 ;Input:
 ; GMRCAR = array name containing message
 ;      e.g.  ^TMP("GMRCIF",$J)
 ;
 N GMRCFDA,GMRCDA,GMRCFWSR,GMRCFROM,GMRCORC,GMRCTIFC,GMRCLAC,GMRCROL
 M ^TMP("GMRCIN",$J)=@GMRCAR
 I '$D(^TMP("GMRCIN",$J,"OBR")) Q
 S GMRCORC=^TMP("GMRCIN",$J,"ORC")
 S GMRCTIFC=$S($P($P(GMRCORC,"|",16),U)="F":0,1:1)
 S GMRCDA=$$GETDA^GMRCIAC2(GMRCORC)
 I '$$LOCKREC^GMRCUTL1(GMRCDA) D  Q  ;couldn't lock record
 . D APPACK^GMRCIAC2(GMRCDA,"AR",901) ;send app. ACK
        . K ^TMP("GMRCIN",$J) Q
 S GMRCROL=$P(^GMR(123,GMRCDA,12),U,5)
 I 'GMRCTIFC D
 . S GMRCFDA(9)=17,GMRCLAC=17
 . I GMRCROL="F" D  Q
 .. S GMRCFROM=$P($P(^TMP("GMRCIN",$J,"OBR"),"|",4),U,2)
 . S GMRCFDA(.131)=$P($P(^TMP("GMRCIN",$J,"OBR"),"|",4),U,2)
 . S GMRCFROM=$P($G(^GMR(123,GMRCDA,13)),U)
 I GMRCTIFC D
 . S GMRCFROM=$P($P(^TMP("GMRCIN",$J,"OBR"),"|",4),U,2)
 . S GMRCFDA(9)=25,GMRCLAC=25
 ;
 S GMRCFDA(8)=5
 D  ;get urgency to file
 . N URG
 . S URG=$$URG^GMRCHL7A($P($P(^TMP("GMRCIN",$J,"ORC"),"|",7),U,6))
 . S GMRCFDA(5)=$$FIND1^DIC(101,"","X","GMRCURGENCY - "_URG)
 ;   v-- chk to see if activity is a dup transmission
 I $$DUPACT^GMRCIAC2(GMRCDA,GMRCLAC,GMRCORC) Q
 ;
 M FDA(1,123,GMRCDA_",")=GMRCFDA
 D UPDATE^DIE("","FDA(1)",,"GMRCERR")
 K GMRCFDA
 ;
 ; file activity tracking
 D FILEACT^GMRCIAC2(GMRCDA,GMRCLAC,GMRCFROM,$NA(^TMP("GMRCIN",$J)))
 ;
 ; send alerts
 I GMRCROL="F" D
 . I GMRCLAC'=25 Q  ; filler alerts only on FWD 2 IFC
 . N GMRCTX
 . S GMRCTX="New remote Consult: "_$$ORTX^GMRCAU(GMRCDA)
 . D MSG^GMRCP($P(^GMR(123,GMRCDA,0),U,2),GMRCTX,GMRCDA,27,,1)
 . Q
 I GMRCROL="P" D
 . N GMRCTX
 . S GMRCTX="Updated Remote Consult: "_$$ORTX^GMRCAU(GMRCDA)
 . D MSG^GMRCP($P(^GMR(123,GMRCDA,0),U,2),GMRCTX,GMRCDA,63,,1)
 . Q
 ;
 ; print if FWD to IFC
 I GMRCROL="F" D
 . I GMRCLAC'=25 Q
 . D PRNT^GMRCUTL1("",GMRCDA)
 ;
 D  ;send app. ACK and unlock record
 . D APPACK^GMRCIAC2(GMRCDA,"AA")
 K ^TMP("GMRCIN",$J)
 Q
 ;
SF(GMRCAR) ;add significant findings
 ; Input:
 ; GMRCAR = array name containing message
 ;      e.g.  ^TMP("GMRCIF",$J)
 ;
 N FDA,GMRCERR,GMRCOSF,GMRCISF
 M ^TMP("GMRCIS",$J)=@GMRCAR
 I '$D(^TMP("GMRCIS",$J,"OBX",6,1)) Q  ;no SF flag sent  ;-(
 S GMRCDA=$$GETDA^GMRCIAC2(^TMP("GMRCIS",$J,"ORC"))
 I '$$LOCKREC^GMRCUTL1(GMRCDA) D  Q  ;couldn't lock record
 . D APPACK^GMRCIAC2(GMRCDA,"AR",901) ;send app. ACK
 . K ^TMP("GMRCIN",$J) Q
 ;
 S GMRCOSF=$P(^GMR(123,GMRCDA,0),U,19)
 S GMRCISF=$P(^TMP("GMRCIS",$J,"OBX",6,1),"|",5)
 S FDA(1,123,GMRCDA_",",15)=GMRCISF
 S FDA(1,123,GMRCDA_",",9)=4
 ;   v-- quit if a duplicate activity
 I $$DUPACT^GMRCIAC2(GMRCDA,4,^TMP("GMRCIS",$J,"ORC")) Q
 ;
 D UPDATE^DIE("","FDA(1)",,"GMRCERR") ;file last action and SF
 D FILEACT^GMRCIAC2(GMRCDA,4,,$NA(^TMP("GMRCIS",$J))) ;activity track
 D  ;send notifications
 . I $P(^GMR(123,GMRCDA,12),U,5)="F" Q  ;filler only gets hist. SF
 . N GMRCORTX
 . S GMRCORTX=$S(GMRCISF="N":"No ",GMRCISF="Y":"",1:"Unknown ")
 . S GMRCORTX=GMRCORTX_"Sig Findings for "_$$ORTX^GMRCAU(+GMRCDA)
 . D MSG^GMRCP($P(^GMR(123,GMRCDA,0),U,2),GMRCORTX,GMRCDA,23,,1)
 D  ;send appl ACK and unlock record
 . D APPACK^GMRCIAC2(GMRCDA,"AA")
 K ^TMP("GMRCIS",$J)
 Q
 ;
RESUB(GMRCAR) ;resubmit a cancelled, remote consult
 ; Input:
 ;   GMRCAR - array name containing message
 ;      e.g.  ^TMP("GMRCIF",$J)
 ;
 K ^TMP("GMRCIN",$J)
 M ^TMP("GMRCIN",$J)=@GMRCAR
 N GMRCDA,GMRCFDA,FDA
 S GMRCDA=$$GETDA^GMRCIAC2(^TMP("GMRCIN",$J,"ORC"))
 I '$$LOCKREC^GMRCUTL1(GMRCDA) D  Q  ;couldn't lock record
 . D APPACK^GMRCIAC2(GMRCDA,"AR",901) ; send app. ACK
 . K ^TMP("GMRCIN",$J) Q
 ;
 S GMRCFDA(8)=5,GMRCFDA(9)=11 ;status and last action
 ;
 I $D(^TMP("GMRCIN",$J,"OBR")) D  ; has INPATIENT or OUTPATIENT changed?
 . N GMRCION
 . S GMRCION=$P(^TMP("GMRCIN",$J,"OBR"),"|",18)
 . I GMRCION'=$P(^GMR(123,GMRCDA,0),U,18) S GMRCFDA(14)=GMRCION
 . Q
 D  ; check for change in urgency
 . N GMRCURG
 . S GMRCURG=$P($P(^TMP("GMRCIN",$J,"ORC"),"|",7),U,6)
 . I '$L(GMRCURG) Q
 . S GMRCURG=$$URG^GMRCHL7A(GMRCURG)
 . S GMRCURG=$$FIND1^DIC(101,"","X","GMRCURGENCY - "_GMRCURG)
 . I GMRCURG'>1 Q
 . I GMRCURG=$P(^GMR(123,GMRCDA,0),U,9) Q  ;no change
 . S GMRCFDA(5)=GMRCURG
 . Q
 D  ;check for change earliest date WAT/66
 . N GMRCERDT
 . S GMRCERDT=$P($P(^TMP("GMRCIN",$J,"ORC"),"|",7),U,4)
 . I '$L(GMRCERDT) Q
 . S GMRCERDT=$$FMDATE^GMRCHL7(GMRCERDT)
 . I GMRCERDT=$P(^GMR(123,GMRCDA,0),U,24) Q  ;no change
 . S GMRCFDA(17)=GMRCERDT
 . Q
 I $D(^TMP("GMRCIN",$J,"OBX",2)) D  ; change in Prov. DX?
 . N PROVDX
 . S PROVDX=$P($P(^TMP("GMRCIN",$J,"OBX",2,1),"|",5),U,2)
 . I '$L(PROVDX) Q
 . I PROVDX=$G(^GMR(123,GMRCDA,30)) Q  ; no change
 . S GMRCFDA(30)=PROVDX
 . S GMRCFDA(30.1)=$P($P(^TMP("GMRCIN",$J,"OBX",2,1),"|",5),U)
 . Q
 ;   v-- QUIT if a duplicate transmission
 I $$DUPACT^GMRCIAC2(GMRCDA,11,^TMP("GMRCIN",$J,"ORC")) Q
 ;
 M FDA(1,123,GMRCDA_",")=GMRCFDA
 D UPDATE^DIE("","FDA(1)",,"GMRCERR") ;file edits
 K GMRCFDA,FDA
 ;
 I $D(^TMP("GMRCIN",$J,"OBX",1)) D  ; reason for request change?
 . D TRIMWP^GMRCIUTL($NA(^TMP("GMRCIN",$J,"OBX",1)),5)
 . N DIFF S DIFF=0
 . D  I 'DIFF Q
 .. I $O(^TMP("GMRCIN",$J,"OBX",1," "),-1)'=$O(^GMR(123,GMRCDA,20," "),-1) S DIFF=1 Q  ;  diff # of lines in new and existing
 .. N LN S LN=0 F  S LN=$O(^GMR(123,GMRCDA,20,LN)) Q:'LN!(DIFF)  D
 ... I $G(^GMR(123,GMRCDA,20,LN,0))=$G(^TMP("GMRCIN",$J,"OBX",1,LN)) Q
 ... S DIFF=1 ;if the lines aren't the same, set DIFF and Q
 . D WP^DIE(123,GMRCDA_",",20,"K",$NA(^TMP("GMRCIN",$J,"OBX",1)))
 . Q
 D  ;file activity tracking
 . D FILEACT^GMRCIAC2(GMRCDA,11,,$NA(^TMP("GMRCIN",$J)))
 N GMRCNTIF
 D  ;determine if part of a FWD to IFC
 . I $P(^GMR(123,GMRCDA,40,1,0),U,2)'=24 S GMRCNTIF=1 Q
 . N ACT S ACT=1
 . S GMRCNTIF=0
 . F  S ACT=$O(^GMR(123,GMRCDA,40,ACT)) Q:'ACT!($G(GMRCNTIF))  D
 .. I ($P(^GMR(123,GMRCDA,40,ACT,0),U,2)=25),$O(^GMR(123,GMRCDA,40,ACT)) S GMRCNTIF=1 ;wat/66 Remedy 278355
 ;
 D  ;print SF-513 & send notifications
 . I '$G(GMRCNTIF) Q  ;part of a FWD to IFC
 . D PRNT^GMRCUTL1("",GMRCDA)
 . N GMRCORTX
 . S GMRCORTX="New remotely re-submitted consult "
 . S GMRCORTX=GMRCORTX_$$ORTX^GMRCAU(+GMRCDA)
 . D MSG^GMRCP($P(^GMR(123,GMRCDA,0),U,2),GMRCORTX,GMRCDA,27,,1)
 ;
 D  ;send appl ACK and unlock record
 . D APPACK^GMRCIAC2(GMRCDA,"AA")
 ;
 K ^TMP("GMRCIN",$J)
 Q
 ;
