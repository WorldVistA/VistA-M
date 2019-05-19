YTSWHYMP ;SLC/PIJ - Score WHYMPI ; 01/08/2016@1200
 ;;5.01;MENTAL HEALTH;**123**;DEC 30, 1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .I (LEG="N")!(LEG="Y") Q
 .I (YSCDA=1155)!(YSCDA=1156) D TALLYRAW Q
 .D SCORE
 Q
 ;
TALLYRAW ;
 ; Part I. Interference
 I (DES="A2")!(DES="A3")!(DES="A4")!(DES="A8")!(DES="A9")!(DES="A13")!(DES="A14")!(DES="A17")!(DES="A19") D
 .S INTERFER=INTERFER+1
 ; Support
 I (DES="A5")!(DES="A10")!(DES="A15") D
 .S SUPPORT=SUPPORT+1
 ; Pain Severity
 I (DES="A1")!(DES="A7")!(DES="A12") D
 .S PAIN=PAIN+1
 ; Life-Control
 I (DES="A11")!(DES="A16") D
 .S LIFE=LIFE+1
 ; Affective Distress
 I (DES="A6")!(DES="A18")!(DES="A20") D
 .S AFFECT=AFFECT+1
 ; Part II.
 ;  Negative Response
 I (DES="B1")!(DES="B4")!(DES="B7")!(DES="B10") D
 .S NEG=NEG+1
 ; Solicitous Response
 I (DES="B2")!(DES="B5")!(DES="B8")!(DES="B11")!(DES="B13")!(DES="B14") D
 .S SOLICIT=SOLICIT+1
 ; Distracting Response
 I (DES="B3")!(DES="B6")!(DES="B9")!(DES="B12") D
 .S DISTRACT=DISTRACT+1
 .; Part III.
 .; Household Chores
 I (DES="C1")!(DES="C5")!(DES="C9")!(DES="C13")!(DES="C17") D
 .S HOUSE=HOUSE+1
 ; Outdoor Work
 I (DES="C2")!(DES="C6")!(DES="C10")!(DES="C14")!(DES="C18") D
 .S OUTDOOR=OUTDOOR+1
 ; Activities away from home
 I (DES="C3")!(DES="C7")!(DES="C11")!(DES="C15") D
 .S ACTIVITY=ACTIVITY+1
 ; Social Activities
 I (DES="C4")!(DES="C8")!(DES="C12")!(DES="C16") D
 .S SOCIAL=SOCIAL+1
 Q
 ;
SCORE ;
 ; Part I.
 ;Interference
 I (DES="A2")!(DES="A3")!(DES="A4")!(DES="A8")!(DES="A9")!(DES="A13")!(DES="A14")!(DES="A17")!(DES="A19") D
 .S TOTINT=TOTINT+$G(YSCDA,0)
 ; Support
 I (DES="A5")!(DES="A10")!(DES="A15") D
 .S TOTSUPP=TOTSUPP+$G(YSCDA,0)
 ; Pain Severity
 I (DES="A1")!(DES="A7")!(DES="A12") D
 .S TOTPAIN=TOTPAIN+$G(YSCDA,0)
 ; Life-Control
 I (DES="A11")!(DES="A16") D
 .S TOTLIFE=TOTLIFE+$G(YSCDA,0)
 ; Affective Distress
 I (DES="A6")!(DES="A18")!(DES="A20") D
 .I (DES="A6") S YSCDA=(6-$G(YSCDA,0))  ; This is the correction for Affective Disorder
 .S TOTAFF=TOTAFF+$G(YSCDA,0)    ; per Dr. Garcia.  The (6-YSCDA) is the reverse
 ; Part II.
 ;  Negative Response
 I (DES="B1")!(DES="B4")!(DES="B7")!(DES="B10") D
 .S TOTNEG=TOTNEG+$G(YSCDA,0)
 ; Solicitous Response
 I (DES="B2")!(DES="B5")!(DES="B8")!(DES="B11")!(DES="B13")!(DES="B14") D
 .S TOTSOL=TOTSOL+$G(YSCDA,0)
 ; Distracting Response
 I (DES="B3")!(DES="B6")!(DES="B9")!(DES="B12") D
 .S TOTDIS=TOTDIS+$G(YSCDA,0)
 ; Part III.
 ; Household Chores
 I (DES="C1")!(DES="C5")!(DES="C9")!(DES="C13")!(DES="C17") D
 .S TOTHOUSE=TOTHOUSE+$G(YSCDA,0)
 ; Outdoor Work
 I (DES="C2")!(DES="C6")!(DES="C10")!(DES="C14")!(DES="C18") D
 .S TOTOUTDR=TOTOUTDR+$G(YSCDA,0)
 ; Activities away from home
 I (DES="C3")!(DES="C7")!(DES="C11")!(DES="C15") D
 .S TOTACTIVE=TOTACTIVE+$G(YSCDA,0)
 ; Social Activities
 I (DES="C4")!(DES="C8")!(DES="C12")!(DES="C16") D
 .S TOTSOC=TOTSOC+$G(YSCDA,0)
 Q
 ;
TOTSCR ; Interference
 S INTERSC="Too many skipped questions"
 I (INTERFER<3) D
 .S INTERSC=$J(TOTINT/(9-INTERFER),0,2)
 ; Support
 S SUPSC="Too many skipped questions"
 I (SUPPORT<2) D
 .S SUPSC=$J(TOTSUPP/(3-SUPPORT),0,2)
 ; Pain Severity
 S PAINSC="Too many skipped questions"
 I (PAIN<2) D
 .S PAINSC=$J(TOTPAIN/(3-PAIN),0,2)
 ; Life-Control
 S LIFESC="Too many skipped questions"
 I (LIFE<2) D
 .S LIFESC=$J(TOTLIFE/(2-LIFE),0,2)
 ; Affective Distress
 S AFFECTSC="Too many skipped questions"
 I (AFFECT<2) D
 .S AFFECTSC=$J(TOTAFF/(3-AFFECT),0,2)
 ; Part II.
 ; Negative Responses
 S NEGSC="Too many skipped questions"
 I (NEG<2) D
 .S NEGSC=$J(TOTNEG/(4-NEG),0,2)
 ; Solicitous Responses
 S SOLSC="Too many skipped questions"
 I (SOLICIT<2) D
 .S SOLSC=$J(TOTSOL/(6-SOLICIT),0,2)
 ; Distracting Responses
 S DISSC="Too many skipped questions"
 I (DISTRACT<2) D
 .S DISSC=$J(TOTDIS/(4-DISTRACT),0,2)
 ; Part III.
 ; Household Chores
 S HOUSC="Too many skipped questions"
 I (HOUSE<2) D
 .S HOUSC=$J(TOTHOUSE/(5-HOUSE),0,2)
 ; Outdoor Work
 S OUTSC="Too many skipped questions"
 I (OUTDOOR<2) D
 .S OUTSC=$J(TOTOUTDR/(5-OUTDOOR),0,2)
 ; Activities Away from Home
 S ACTSC="Too many skipped questions"
 I (ACTIVITY<2) D
 .S ACTSC=$J(TOTACTIVE/(4-ACTIVITY),0,2)
 ; Social Activities
 S SOCSC="Too many skipped questions"
 I (SOCIAL<2) D
 .S SOCSC=$J(TOTSOC/(4-SOCIAL),0,2)
 ; General Activity - total skipped questions
 S GENERAL=HOUSE+OUTDOOR+ACTIVITY+SOCIAL
 S GENSC="Too many skipped questions"
 I (GENERAL<5) D
 .S GENSC=$J((TOTHOUSE+TOTOUTDR+TOTACTIVE+TOTSOC)/(18-GENERAL),0,2)
 Q
 ;
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="WHYMPI Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 ;Part I 
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,507_",",3,"I")_"="_INTERSC
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,508_",",3,"I")_"="_SUPSC
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,553_",",3,"I")_"="_PAINSC
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,554_",",3,"I")_"="_LIFESC
 S ^TMP($J,"YSCOR",6)=$$GET1^DIQ(601.87,555_",",3,"I")_"="_AFFECTSC
 ;Part II
 S ^TMP($J,"YSCOR",7)=$$GET1^DIQ(601.87,556_",",3,"I")_"="_NEGSC
 S ^TMP($J,"YSCOR",8)=$$GET1^DIQ(601.87,557_",",3,"I")_"="_SOLSC
 S ^TMP($J,"YSCOR",9)=$$GET1^DIQ(601.87,558_",",3,"I")_"="_DISSC
 ;Part III.
 S ^TMP($J,"YSCOR",10)=$$GET1^DIQ(601.87,559_",",3,"I")_"="_HOUSC
 S ^TMP($J,"YSCOR",11)=$$GET1^DIQ(601.87,560_",",3,"I")_"="_OUTSC
 S ^TMP($J,"YSCOR",12)=$$GET1^DIQ(601.87,561_",",3,"I")_"="_ACTSC
 S ^TMP($J,"YSCOR",13)=$$GET1^DIQ(601.87,562_",",3,"I")_"="_SOCSC
 S ^TMP($J,"YSCOR",14)=$$GET1^DIQ(601.87,563_",",3,"I")_"="_GENSC
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,NODE,LEG,YSCDA,YSQN,YSINSNAM
 N ACTIVITY,AFFECT,DISTRACT,GENERAL,HOUSE,INTERFER,LIFE,NEG,OUTDOOR,PAIN
 N SOCIAL,SOLICIT,SUPPORT,TOTACTIVE,TOTAFF,TOTDIS,TOTHOUSE
 N TOTINT,TOTLIFE,TOTNEG,TOTOUTDR,TOTPAIN,TOTSOC,TOTSOL,TOTSUPP
 N INTERSC,SUPSC,PAINSC,LIFESC,AFFECTSC,NEGSC,SOLSC,DISSC,HOUSC,OUTSC,ACTSC,SOCSC,GENSC
 ;
 S (ACTIVITY,AFFECT,DISTRACT,HOUSE,INTERFER,LIFE,NEG,OUTDOOR,PAIN)=0
 S (SOCIAL,SOLICIT,SUPPORT,TOTACTIVE,TOTAFF,TOTDIS,TOTHOUSE)=0
 S (TOTINT,TOTLIFE,TOTNEG,TOTOUTDR,TOTPAIN,TOTSOC,TOTSOL,TOTSUPP)=0
 ;
 I YSTRNG=2 Q  ; no special text in the report
 ;
 D DATA1
 D TOTSCR
 D SCORESV
 Q
