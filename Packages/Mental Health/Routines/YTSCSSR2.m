YTSCSSR2 ;ISP/LMT - C-SSRS_V2 Report ;Aug 06, 2025@12:06:28
 ;;5.01;MENTAL HEALTH;**269**;Dec 30, 1994;Build 7
 ;
 ;
DLLSTR(YSDATA,YS,YSTRNG) ; compute scores or report text based on YSTRNG
 ; input
 ;   YSDATA(2)=adminId^patientDFN^instrumentName^dateGiven^isComplete
 ;   YSDATA(2+n)=questionId^sequence^choiceId
 ;   YS("AD")=adminId
 ;   YSTRNG=1 for score, 2 for report
 ; output if YSTRNG=1: ^TMP($J,"YSCOR",n)=scaleId=score
 ; output if YSTRNG=2: append special "answers" to YSDATA
 ;
 I YSTRNG=1 D BYKEY^YTSCORE(.YSDATA)  ; just use "regular" scoring
 ;
 I YSTRNG=2 D REPORT(.YSDATA,.YS)
 ;
 Q
 ;
REPORT(YSDATA,YS) ; Add Interpretation to report
 ;
 N YSHIGH,YSI,YSINTERP,YSLOW,YSMOD,YSN,YSNAME,YSNONE,YSSCORE,YSVALUE
 ;Line breaks and line spacing behaves differently between MH REPORT and PROGRESS NOTE
 ;Be careful making changes to risk level text.
 S YSNONE="   No C-SSRS items endorsed. No additional action is required |"
 S YSNONE=YSNONE_" based on current screening results."
 S YSLOW="   Items endorsed indicate LOW risk C-SSRS screening level: Mental health |"
 S YSLOW=YSLOW_" follow-up (may include but is not limited to, reviewing mental |"
 S YSLOW=YSLOW_" health needs with a provider) must be offered."
 S YSMOD="   Items endorsed indicate MODERATE risk C-SSRS screening level: |"
 S YSMOD=YSMOD_" Mental health follow-up (may include but is not limited to, |"
 S YSMOD=YSMOD_" reviewing mental health needs with a provider) must be offered."
 S YSHIGH="   Items endorsed indicate HIGH risk C-SSRS screening level. Address any |"
 S YSHIGH=YSHIGH_" immediate safety concerns. The Comprehensive Suicide Risk Evaluation must|"
 S YSHIGH=YSHIGH_" be completed and documented by an LIP or APP same day (except in settings|"
 S YSHIGH=YSHIGH_" that allow up to 24 hrs.)."
 ;
 ; Get Score
 S YSSCORE=""
 K ^TMP($J,"YSCOR")
 D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 S YSI=0 F  S YSI=$O(^TMP($J,"YSCOR",YSI)) Q:'YSI  D
 . S YSNAME=$P(^TMP($J,"YSCOR",YSI),"=")
 . S YSVALUE=$P(^TMP($J,"YSCOR",YSI),"=",2)
 . I YSNAME="Total" S YSSCORE=YSVALUE
 K ^TMP($J,"YSCOR")
 ;
 ; Calculate interpretation based off score
 S YSINTERP=""
 I YSSCORE=0 S YSINTERP=YSNONE            ;    0 = no items endorsed/no action required
 I YSSCORE>0,YSSCORE<3 S YSINTERP=YSLOW   ;  1-2 = low risk C-SSRS screening level
 I YSSCORE>2,YSSCORE<13 S YSINTERP=YSMOD  ; 3-12 = moderate risk C-SSRS screening
 I YSSCORE>12 S YSINTERP=YSHIGH           ;  13+ = high risk C-SSRS screening level
 ;
 S YSN=$O(YSDATA(""),-1) ; get last node
 S YSDATA(YSN+1)="7771^9999;1^"_YSINTERP
 ;
 Q
