YSKFASIP ;16IT/PTC - SUBSTANCE ABUSE ;8/3/01  14:07
 ;;5.01;MENTAL HEALTH;**73**;Dec 30, 1994
 ;CALLED FROM YSKFASIR
 ;
CALC ;
 I NEW=0 S NEWPTP="    ."
 E  S NEWPTP=$S(CKCTT'=0:((NEW/CKCTT)*100),1:"    .")
 I ASI=0 S ASIP="    ."
 E  S ASIP=$S(NEW'=0:((ASI/NEW)*100),1:"    .")
 I G12=0 S G12P="    ." ;ASF 6/15/01
 E  S G12P=$S(NEW'=0:((G12/NEW)*100),1:"    .") ;ASF 6/15/01
 I NOASI=0 S NOASIP="    ."
 E  S NOASIP=$S(NEW'=0:((NOASI/NEW)*100),1:"    .")
 I MAYBE=0 S MAYBEP="    ."
 E  S MAYBEP=$S(NEW'=0:((MAYBE/NEW)*100),1:"    .")
RPT ;
 S YSKFLCNT=0
 S YSKFLCNT=YSKFLCNT+1,^TMP($J,YSKFLCNT)=""
 S ^TMP($J,YSKFLCNT)="                            ASI MONITOR ",YSKFLCNT=YSKFLCNT+1
 ;S ^TMP($J,YSKFLCNT)="                            "_^DD("SITE",1)_" "_^DD("SITE"),YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="                            "_+$P($$SITE^VASITE,U)_" "_$$SITE^YSGAF3,YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="                            FROM "_$E(YSKFBDT,4,5)_"/"_$E(YSKFBDT,6,7)_"/"_$E(YSKFBDT,2,3)_"-"_$E(YSKFEDT,4,5)_"/"_$E(YSKFEDT,6,7)_"/"_$E(YSKFEDT,2,3),YSKFLCNT=YSKFLCNT+1
 ;S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="The denominator is composed of patients admitted to Substance Abuse bedsections",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="27,29,72,73,74,84,86 or seen in a substance abuse clinic (513,514,523,547,560)",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="and meet the inpt/outpt criteria.",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   Inpatients are those admitted for >24 hrs.",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   Outpatients are those with at least 3 substance abuse visits within 90 days.",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   New patients are these inpt. and outpts  who have not been  ",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   seen in a mental health substance abuse setting in the past 90 days.",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   Measure : Patients admitted to Substance Abuse Program during date range ",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="             with an ASI",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   For inpt,the ASI date range is 30 days prior to admit date to 14th day ",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="             of admit date",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   For outpt,the ASI date range is 30 days prior to the 1st visit",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="              to 14 days after 3rd visit",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   BACKGROUND INFORMATION :",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="                                            NUMBER   PERCENT",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="     Patients with Inpt/Outpt Criteria : "_$J(CKCTT,6),YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="         New Patients                  : "_$J(NEW,6)_"    "_$J(NEWPTP,6,1),YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   ASI MEASURE :",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="           New patients with ASI       : "_$J(ASI,6)_"    "_$J(ASIP,6,1),YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="           New patients with G12 ASI   : "_$J(G12,6)_"    "_$J(G12P,6,1),YSKFLCNT=YSKFLCNT+1 ;ASF 6/15/01
 S ^TMP($J,YSKFLCNT)="           New Patients without ASI    : "_$J(NOASI,6)_"    "_$J(NOASIP,6,1),YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="           No ASI/14th day not reached : "_$J(MAYBE,6)_"    "_$J(MAYBEP,6,1),YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="   FOLLOWUP MEASURE :",YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="           Followups Done              : "_$J(FOLLDONE,6)_"    "_$J(FOLLDONP,6,1),YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="           Followups G12'd             : "_$J(FOLLG12,6)_"    "_$J(FOLLG12P,6,1),YSKFLCNT=YSKFLCNT+1 ;ASF 8/3/01
 S ^TMP($J,YSKFLCNT)="           Followups Missed            : "_$J(NOFOLLCT,6)_"    "_$J(NOFOLLP,6,1),YSKFLCNT=YSKFLCNT+1
 S ^TMP($J,YSKFLCNT)="           Followups Pending           : "_$J(FOLLSHR,6)_"    "_$J(FOLLSHRP,6,1),YSKFLCNT=YSKFLCNT+1
 Q
