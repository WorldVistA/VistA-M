IBDFN12 ;ALB/CJM - ENCOUNTER FORM - SELECTORS;MAY 10, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**12,38,40,51**;APR 24, 1997
 ;
LOOKUP(FILE,SCREEN,X,NODE) ;
 ; -- lookup X in file using SCREEN
 ; -- kills X if lookup not successful, else sets X to the ien and returns NODE as the 0 node
 ; -- pass X and NODE by reference
 ;
 I +$G(FILE)<1 K X Q
 N Y
 S (NODE,Y)=""
 K DIC S DIC=FILE,DIC("S")=SCREEN
 S DIC(0)="EMQZ"
 I $D(^DIC(FILE)) D ^DIC K DIC
 I +Y>0 D
 .S X=Y,NODE=Y(0)
 E  K X
 Q
 ;
SLCTCPT(X) ;for CPT codes
 ;pass X by reference
 ;example of use: D SLCTCPT^IBDFN12(.X)
 ;
 N NODE,SCRN
 ;;D LOOKUP(81,"I '$P(^(0),U,4)",.X,.NODE)
 ;
 ;List only active code. (CSV)
 S SCRN="I $P($$CPT^ICPTCOD(Y),U,7)=1" ;Check status for CPT (CSV)
 D LOOKUP(81,SCRN,.X,.NODE)
 I $D(X) S IBLABEL=$P(NODE,"^",2),(IBID,X)=$P(NODE,"^",1)
 Q
 ;
SLCTDX(X) ;for ICD9 diagnosis codes
 ;pass X by reference
 ;example of use: D SLCTICD^IBDFN12(.X)
 ;
 N NODE,SCRN
 ;;D LOOKUP(80,"I '$P(^(0),U,9)",.X,.NODE)
 ;
 ;List only active code. (CSV)
 S SCRN="I $P($$ICDDX^ICDCODE(Y),U,10)=1" ;Check status for ICD (CSV)
 D LOOKUP(80,SCRN,.X,.NODE)
 I $D(X) S IBLABEL=$P(NODE,"^",3),(IBID,X)=$P(NODE,"^",1)
 Q
 ;
SLCTVST(X) ;for VISIT TYPE codes
 ;pass X by reference
 ;example of use: D SLCTVST^IBDFN12(.X)
 ;
 N NODE,SCREEN
 ;;D LOOKUP(357.69,"I '$P(^(0),U,4)",.X,.NODE)
 ;
 ;List only active code. (CSV)
 S SCRN="I $P($$CPT^ICPTCOD(Y),U,7)=1" ;Check status for CPT (CSV)
 D LOOKUP(357.69,SCRN,.X,.NODE)
 ;
 ;; --change to api cpt ; dhh
 I $G(X) S NODE=$$CPT^ICPTCOD(+NODE),NODE=$G(NODE),(IBID,X)=$P(NODE,"^",2),IBLABEL=$P(NODE,"^",3)
 Q
 ;
SLCTED(X) ;for Education Topics
 ;pass X by reference
 ;example of use: D SLCTED^IBDFN12(.X)
 ;
 N NODE
 D LOOKUP(9999999.09,"",.X,.NODE)
 I $D(X) S IBLABEL=$P(NODE,"^"),IBID=+X,X=IBLABEL
 Q
 ;
SLCTIMM(X) ;for Immunizations
 ;pass X by reference
 ;example of use: D SLCTIMM^IBDFN12(.X)
 ;
 N NODE
 D LOOKUP(9999999.14,"",.X,.NODE)
 I $D(X) S IBLABEL=$P(NODE,"^",2),IBID=+X,X=IBLABEL
 Q
 ;
SLCTEX(X) ;for Exams
 ;pass X by reference
 ;example of use: D SLCTEX^IBDFN12(.X)
 ;
 N NODE
 D LOOKUP(9999999.15,"",.X,.NODE)
 I $D(X) S IBLABEL=$P(NODE,"^"),IBID=+X,X=IBLABEL
 Q
 ;
SLCTSKN(X) ;for Skin Tests
 ;pass X by reference
 ;example of use: D SLCTSKN^IBDFN12(.X)
 ;
 N NODE
 D LOOKUP(9999999.28,"",.X,.NODE)
 I $D(X) S IBLABEL=$P(NODE,"^"),IBID=+X,X=IBLABEL
 Q
 ;
SLCTHF(X) ;for Health Factors
 ;pass X by reference
 ;example of use: D SLCTHF^IBDFN12(.X)
 ;
 N NODE
 D LOOKUP(9999999.64,"I $P(^(0),U,10)=""F"",'$P(^(0),U,11)",.X,.NODE)
 I $D(X) S IBLABEL=$P(NODE,"^"),IBID=+X,X=IBLABEL
 Q
SLCTTR(X) ;for Treatments
 ;pass X by reference
 ;example of use: D SLCTTR^IBDFN12(.X)
 ;
 N NODE
 D LOOKUP(9999999.17,"",.X,.NODE)
 I $D(X) S IBLABEL=$P(NODE,"^"),IBID=+X,X=IBLABEL
 Q
 ;
SLCTYN(X) ;for selecting YES or NO
 ;
 I "Yy"[$E(X) S X="YES",IBID=1 Q
 I "Nn"[$E(X) S X="NO",IBID=0 Q
 W "Enter YES or NO."
 K X
 Q
 ;
SLCTCLS(PI,X) ;for visit classification
 ;pass X by reference
 ;*NOTE: if interactive sets IBQUAL to the qualifier, IBLABEL to the recommended label, for use in the input template
 ;example of use: D INPUTCLS^IBDFN12(PI,.X)
 ;
 N NODE
 D LOOKUP(357.98,"I $$DQGOOD^IBDFU9(PI,Y)",.X,.NODE)
 I $D(X) S IBID="",IBLABEL=$P(NODE,"^",3),IBQUAL=+X,X=$P(NODE,"^")
 Q
