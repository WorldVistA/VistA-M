IBDFN14 ;ALB/CMR - ENCOUNTER FORM - OUTPUTS;JAN 4, 1996
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**12,38,51**;APR 24, 1997
 ;
CPT(X) ; -- return external value, descr and active flag for CPT code
 ; -- X passed equal to ien for cpt code
 ;
 ;    input: ien of file #81
 ;    output: IBID = cpt code (.01 field of file #81)
 ;            IBLABEL = description fo cpt code
 ;            IBINACT = null if active
 ;                      1 if inactive
 ;
 Q:'X
 N IBDFNODE
 S (IBID,IBLABEL,IBINACT)=""
 S IBDFNODE=$$CPT^ICPTCOD(X)
 Q:+IBDFNODE=-1
 S IBID=$P(IBDFNODE,"^",2)
 S IBLABEL=$P(IBDFNODE,"^",3)
 S IBINACT=$S($P(IBDFNODE,"^",7)=1:"",1:1)
 Q
DX(X) ; -- return external value, descr and active flag for ICD9 diagnosis
 ; -- pass X equal to ien for icd9 code
 ;
 Q:'X
 N ICDNODE
 S (IBID,IBLABEL,IBINACT)=""
 ;;I $G(^ICD9(X,0))]"" S IBID=$P(^(0),"^"),IBLABEL=$P(^(0),"^",3),IBINACT=$P(^(0),"^",9)
 S ICDNODE=$$ICDDX^ICDCODE(X)
 Q:+ICDNODE=-1
 S IBID=$P(ICDNODE,U,2)     ;ICD code
 S IBLABEL=$P(ICDNODE,U,4)  ;ICD description
 S STATUS=$P(ICDNODE,U,10)  ;ICD status, 0-Not Active, 1-Acitve
 ;
 ;Set inactive flag to 1, if the ICD code is not active (STATUS=0)
 I STATUS=0 S IBINACT=1
 Q
VST(X) ; -- return external value, descr and active flag for VISIT TYPE 
 ; -- pass X equal to ien for visit type
 ;
 Q:'X
 S (IBID,IBLABEL,IBINACT)=""
 ;; --change to api cpt ; dhh
 I $G(^IBE(357.69,X,0))]"",+$$CPT^ICPTCOD(X)'=-1 D
 .S IBID=$P(^IBE(357.69,X,0),"^"),IBLABEL=$P(^(0),"^",3)
 .S HDR=$P(^IBE(357.69,X,0),"^",2) I $L(HDR_IBLABEL)<75 S IBLABEL=HDR_" "_IBLABEL
 .K HDR
 .;; --change to api cpt ; dhh
 .S IBINACT=$S($P(^IBE(357.69,X,0),"^",4):1,$P($$CPT^ICPTCOD(X),"^",7)=0:1,1:"")
 Q
ED(X) ; -- return descr and active flag for education topics
 ; -- pass X equal to ien for education topic
 ;
 Q:'X
 S (IBID,IBLABEL,IBINACT)=""
 I $G(^AUTTEDT(X,0))]"" S IBID="ED TOPIC",IBLABEL=$P(^(0),"^"),IBINACT=$P(^(0),"^",3)
 Q
EXAM(X) ; -- return descr and active flag for exam
 ; -- pass X equal to ien for exam
 ;
 Q:'X
 S (IBID,IBLABEL,IBINACT)=""
 I $G(^AUTTEXAM(X,0))]"" S IBID="EXAM",IBLABEL=$P(^(0),"^"),IBINACT=$P(^(0),"^",4)
 Q
HF(X) ; -- return descr and active flag for health factor
 ; -- pass X equal to ien for health factor
 ;
 Q:'X
 S (IBID,IBLABEL,IBINACT)=""
 I $G(^AUTTHF(X,0))]"" S IBID="FACTOR",IBLABEL=$P(^(0),"^"),IBINACT=$P(^(0),"^",11)
 Q
 ;
IMMUN(X) ; -- return descr and active flag for immunization
 ; -- pass X equal to ien for immunization
 ;
 Q:'X
 S (IBID,IBLABEL,IBINACT)=""
 I $G(^AUTTIMM(X,0))]"" S IBID="IMMUN",IBLABEL=$P(^(0),"^"),IBINACT=$P(^(0),"^",7)
 Q
 ;
TREAT(X) ; -- return descr and active flag for treatment
 ; -- pass X equal to ien for TREATMENTS
 ;
 Q:'X
 S (IBID,IBLABEL,IBINACT)=""
 I $G(^AUTTTRT(X,0))]"" S IBID="TREATMENT",IBLABEL=$P(^(0),"^"),IBINACT=$P(^(0),"^",4)
 Q
 ;
ST(X) ; -- return descr and active flag for immunization
 ; -- pass X equal to ien for immunization
 ;
 Q:'X
 S (IBID,IBLABEL,IBINACT)=""
 I $G(^AUTTSK(X,0))]"" S IBID="SKIN TEST",IBLABEL=$P(^(0),"^"),IBINACT=$P(^(0),"^",3)
 Q
YN(X) ; -- return descr
 ; -- pass X equal to 1 or 0
 ;
 Q:X']""
 S IBID="VALUE"
 S (IBLABEL,IBINACT)=""
 I X S IBLABEL="YES" Q
 S IBLABEL="NO" Q
 Q
