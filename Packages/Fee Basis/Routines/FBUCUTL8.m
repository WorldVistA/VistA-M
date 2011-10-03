FBUCUTL8 ;ALBISC/TET - UTILITY (continued) ;10/10/2001
 ;;3.5;FEE BASIS;**38**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EXPIRE(FBDA,FBDT,FBUCA,FBORDER) ;determine expiration date based upon status order
 ;INPUT:  FBDA     - internal entry number of unauthorized claim, 162.7
 ;        FBDT   - date used to which expiration days are added,
 ;      value is either  date letter sent, or if no letter, today's date
 ;      or date statement of the case issued, depending on status.
 ;        FBUCA - current (or after) zero node of claim
 ;        FBORDER - status order number
 ;OUTPUT: expiration date, based on days associated with status.
 ;        no expiration date if dispostion is approved or canceled/withdrawn
 N FBEXP I $S('FBDA:1,'$D(FBDT):1,'FBDT:1,'$D(FBUCA):1,'$D(FBORDER):1,'FBORDER:1,1:0) S FBEXP=0 G EXPIREQ
 N FBEXP,FBORIG,FBSTATUS,DAYS S FBEXP=+$P(FBUCA,U,26),FBORIG=+$P(FBUCA,U,22)
 S FBSTATUS=$$STATUS^FBUCUTL(FBORDER),DAYS=$$DAYS^FBUCUTL(FBSTATUS,$P(FBUCA,U,28))
 I $P(FBUCA,U,11)=3 S FBEXP=$S($P(FBUCA,U,26):"@",1:0) G EXPIREQ
 I 'DAYS,+FBEXP S FBEXP="@"
 I DAYS,FBEXP'="@" S:FBORDER'=55 FBEXP=$$CDTC^FBUCUTL(FBDT,DAYS) I FBORDER=55 S DAYS=DAYS-$$DTC^FBUCUTL(FBDT,FBORIG) S FBEXP=$$CDTC^FBUCUTL(FBDT,$S(DAYS'>60:60,1:DAYS))
 ;if order=55, get number of days between date statement of case issued
 ;     or date letter sent and date of original disposition;
 ;     expiration date is either remainder of year or 60 days,
 ;     whichever is greater.
 ; if incomplete Mill Bill claim then check for an extension
 I FBEXP'="@",$P(FBUCA,U,28),FBORDER=10 D
 . N FBED
 . ; obtain most recent extension date (if any)
 . S FBED=$P($$EXT(FBDA,FBORDER),U,2)
 . ; use extension date if later then the computed expiration date
 . I FBED]"",FBED>FBEXP S FBEXP=FBED
EXPIREQ Q $G(FBEXP)
DISAPR ;check disapproval reason and file if all same, or ask if diff from pr.
 I FBUCDISR=0 W !?3,"No: ",FBDA,?15,"Treatment From: ",$$DATX^FBAAUTL($P(FBUCA,U,5)) W:$P(FBUCA,U,6) ?40,"Treatment To: ",$$DATX^FBAAUTL($P(FBUCA,U,6)) S DIE="^FB583(",DA=FBDA,DR=15 D ^DIE K DIE,DA,DR Q
 F I=2:1 S J=$P(FBUCDISR,U,I) Q:'J  D DISAP^FBUCUTL(FBDA,J)
 Q
EXT(FBDA,FBORDER) ; Obtain most recent extension for status
 ; input FBDA = ien of claim in file 162.7
 ;       FBORDER = status order number
 ; returns string = ien of extension^extension date OR
 ;                  null if no extension
 N FBDA1,FBXD,FBRET,FBSTATUS,FBY
 S FBRET="" ; initalize return value
 ;
 I '$G(FBDA)!'$G(FBORDER) Q FBRET
 ;
 ; get ien of status that extension should apply to
 S FBSTATUS=$$STATUS^FBUCUTL(FBORDER)
 ;
 ; loop thru entered extensions in reverse chronological order
 S FBXD=" "
 F  S FBXD=$O(^FB583(FBDA,3,"B",FBXD),-1) Q:'FBXD  D  Q:FBRET
 . S FBDA1=" "
 . F  S FBDA1=$O(^FB583(FBDA,3,"B",FBXD,FBDA1),-1) Q:'FBDA1  D  Q:FBRET
 . . S FBY=$G(^FB583(FBDA,3,FBDA1,0))
 . . Q:$P(FBY,U,3)'=FBSTATUS  ; ignore extensions for a different status
 . . Q:$P(FBY,U,4)=""  ; extension date was not entered
 . . S FBRET=FBDA1_U_$P(FBY,U,4)
 ;
 Q FBRET
