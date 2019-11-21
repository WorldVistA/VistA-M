XUMVIDTA ;MVI/CKN - MVI New Person Data Analysis ;8/20/19  11:03
 ;;8.0;KERNEL;**705,711,710**;Jul 10, 1995;Build 2
 Q
EP(RETURN,SEL,ACTSEL) ;
 ;RPC - XUS MVI NEW PERSON DATA
 ;This RPC is called by MPI to get data analysis report from
 ;NEW PERSON file (#200) for active VistA sites
 ;Input:
 ;    SEL (Required) - 1 : All - Active New Person and  Non Active New Person
 ;                     2 : Active New Person
 ;                     3 : Non Active New Person
 ; ACTSEL (Optional for Non Active) - 1 : All
 ;                     1 : All
 ;                     2 : Active records having a SecID value
 ;                     3 : Active records having an Email value
 ;                     4 : Active records having a NT USERNAME value
 ;Output:
 ; RETURN - Total Count^Total Non Active^Total Active^Total SECID^Total Email
 ;          ^Total NT User^Total Visitors
 ;
 N XUDUZ,U,TOTVIS,TOTCNT,NONACT,ACT,TOTNACT,TOTACT,TOTSECID,TOTEMAIL,TOTNTUSR,ARR
 S (TOTCNT,TOTNACT,TOTACT,TOTSECID,TOTEMAIL,TOTNTUSR,TOTVIS)=0
 S U="^"
 S XUDUZ=.9 F  S XUDUZ=$O(^VA(200,XUDUZ)) Q:+XUDUZ=0  D
 .K ARR
 .S TOTCNT=TOTCNT+1
 .D GET(XUDUZ,.ARR)
 .I $G(ARR("VISITOR"))=1 S TOTVIS=TOTVIS+1 ; Visitor records ;**710 - STORY_952862 (dri) remove QUIT to stop filtering, allow person to also be counted as active
 .;Inactive New Person
 .I SEL=3 D  Q
 ..S NONACT=$$NONACT(.ARR)
 ..I NONACT S TOTNACT=TOTNACT+1
 .;Active New Person
 .I SEL=2 D  Q
 ..S ACT=$$ACT(.ARR) I 'ACT Q
 ..S TOTACT=TOTACT+1
 ..D GETACT(ACTSEL,.ARR)
 .;All Active and Inactive New Person
 .I SEL=1 D
 ..S NONACT=$$NONACT(.ARR) I NONACT S TOTNACT=TOTNACT+1 Q
 ..I '$$ACT(.ARR) Q
 ..S TOTACT=TOTACT+1
 ..D GETACT(ACTSEL,.ARR)
 ;
 ;RETURN - Total Count^Total Non Active^Total Active^Total SECID^Total Email
 ;         ^Total NT User^Total Visitors
 S RETURN=TOTCNT_U_TOTNACT_U_TOTACT_U_TOTSECID_U_TOTEMAIL_U_TOTNTUSR_U_TOTVIS
 Q
GET(XUDUZ,ARR) ;
 ;Get all necessary fields from New Person file (#200)
 N NPDATA
 S DR="201;205.1;205.5;501.1;7;9.2",DIC=200,DA=XUDUZ,DIQ="NPDATA",DIQ(0)="I" D EN^DIQ1
 S ARR("PRIMOPT")=$G(NPDATA(200,XUDUZ,201,"I"))
 S ARR("SECID")=$G(NPDATA(200,XUDUZ,205.1,"I"))
 S ARR("EMAIL")=$G(NPDATA(200,XUDUZ,205.5,"I"))
 S ARR("NTUSR")=$G(NPDATA(200,XUDUZ,501.1,"I"))
 S ARR("DISUSR")=$G(NPDATA(200,XUDUZ,7,"I"))
 S ARR("TERMDT")=$G(NPDATA(200,XUDUZ,9.2,"I"))
 I $O(^VA(200,XUDUZ,8910,0)) S ARR("VSTDATA")=1
 I $G(ARR("VSTDATA")),$G(ARR("PRIMOPT"))'="" S ARR("VISITOR")=1
 K DIC,DA,DR,DIQ
 Q
NONACT(ARR) ;
 ;Inactive Person - Disuser=Y and/or Termination date is not a future date
 I $G(ARR("DISUSR"))=1!(($G(ARR("TERMDT"))'="")&($G(ARR("TERMDT"))'>DT)) Q 1
 Q 0
ACT(ARR) ;
 ;Active Person - not Disuser=Y and/or no Termination date.
 ;**711 Story 977780 (ckn) - Add check for primary option assigned.
 I $G(ARR("DISUSR"))'=1,($G(ARR("TERMDT"))=""!($G(ARR("TERMDT"))>DT)),($G(ARR("PRIMOPT"))'="") Q 1
 Q 0
GETACT(ACTSEL,ARR) ;
 ;Aggregate total Active records has a SECID value
 I ACTSEL=2,$G(ARR("SECID"))'="" S TOTSECID=TOTSECID+1 Q
 ;Agreegate total Active records has an Email value
 I ACTSEL=3,$G(ARR("EMAIL"))'="" S TOTEMAIL=TOTEMAIL+1 Q
 ;Aggregate total Active records has a NT UserName value
 I ACTSEL=4,$G(ARR("NTUSR"))'="" S TOTNTUSR=TOTNTUSR+1 Q
 ;Aggregate all - SECID, AUPDN and NT UserName
 I ACTSEL=1 D
 .I $G(ARR("SECID"))'="" S TOTSECID=TOTSECID+1
 .I $G(ARR("EMAIL"))'="" S TOTEMAIL=TOTEMAIL+1
 .I $G(ARR("NTUSR"))'="" S TOTNTUSR=TOTNTUSR+1
 Q
