RABWORD ;HOIFO/JH&MM - Radiology Billing Awareness ;12/20/04 12:55am
 ;;5.0;Radiology/Nuclear Medicine;**41,57,70**;Mar 16, 1998;Build 7
 ;
 ; Rtn invokes IA #226-C, #1300-A, #2083, #10082, #2343, #4419
 Q
 ;
ASK(RADFN,RASDDT) ; Ask ICD DX & SC/EI/MST/HNC questions at time of Order.
 ; Called from BAQUES^RAORD1
 Q:'$D(^XUSEC("PROVIDER",DUZ))  ;user provider key check
 Q:'$$CIDC^IBBAPI(RADFN)  ;patient insurance & CIDC switch check
 N DIC,I11,RACNT,RADUP,RAQUIT,RABCOPY,RABASEC K RAKILL S RABASEC=0
 ;if previous order's ICD9 etc. were copied, then put them in RABWDX to file
 I $D(^TMP("RACOPY",$J)) D
 .;remove copied CV value from piece 8 of RABWDX(1) and all RABWDX(RACNT)
 .I ^TMP("RACOPY",$J,"BA") S RABWDX(1)=^("BA"),$P(RABWDX(1),U,8)=""
 .S RABCOPY=0,RACNT=1
 .F  S RABCOPY=$O(^TMP("RACOPY",$J,"BA",RABCOPY)) Q:'RABCOPY  S RACNT=RACNT+1,RABWDX(RACNT)=^(RABCOPY),$P(RABWDX(RACNT),U,8)=""
PRIMDX I $D(^TMP("RACOPY",$J,"BA")) D
 .S RABCOPY(1)=^TMP("RACOPY",$J,"BA")
 .D BADISP^RABWORD1(.RABCOPY)
 S DIC="^ICD9(",DIC(0)="QEAMNZ"
 S DIC("A")="Ordering ICD-9 Diagnosis: "
 S DIC("B")="" I $D(RABWDX(1))&($P($G(RABWDX(1)),U)>0) S DIC("B")=$P(^ICD9(+RABWDX(1),0),U)
 I $D(RABCOPY) S DIC("B")=$P(RABCOPY(1),U) K RABCOPY
 S DIC("S")="I $P($$ICDDX^ICDCODE(Y,DT),U,10)" D ^DIC
 S:(+Y<0) Y=0
 S:Y="^" RAQUIT=1
 I (+Y>0) D
 .S RACNT=1,$P(RABWDX(RACNT),U,1)=+Y D BAQUES S Y=1
 ; check @ deletion of previous entry
 I X="@" K RABWDX(1)
 Q:'$D(RABWDX)!$G(RAQUIT)
 ;
SECDX F I11=1:1:7 Q:($G(RAQUIT)&'$O(RABWDX(I11)))  W ! D
 .I $D(^TMP("RACOPY",$J,"BA"))&(RABASEC'="") D
 ..S RABASEC=$O(^TMP("RACOPY",$J,"BA",RABASEC))
 ..Q:RABASEC=""
 ..S RABCOPY(2)=^TMP("RACOPY",$J,"BA",RABASEC)
 ..D BADISP^RABWORD1(.RABCOPY)
 .S DIC="^ICD9(",DIC(0)="QEAMNZ"
 .S DIC("A")="Secondary Ordering ICD-9 Diagnosis: "
 .S DIC("B")="" I $D(RABWDX(I11+1)) S DIC("B")=$P(^ICD9(+RABWDX(I11+1),0),U)
 .I $D(RABCOPY(2)) S DIC("B")=$P(RABCOPY(2),U) K RABCOPY
 .S DIC("S")="I $P($$ICDDX^ICDCODE(Y,DT),U,10)" D ^DIC
 .; delete node RABWDX() if its secondary ICD9 was @-deleted
 .I X="@" K RABWDX(I11+1)
 .I +Y<1 S RAQUIT=1 Q  ; No More Secondary ICD Dx to Enter.
 .S RADUP=0 D DUPDX
 .I RADUP W !?5,"* Cannot Enter Duplicate ICD-9 Diagnosis *" S I11=I11-1 Q
 .S RACNT=RACNT+1,$P(RABWDX(RACNT),U,1)=+Y D BAQUES
 K ^TMP("RACOPY",$J)
 Q  ; Quit back to RAORD1 routine.
 ;
BAQUES ; Ask the SC/EI/MST/HNC questions associated to each ICD Dx.
 N RASEQ,RASEQ1,RASEQ2,RAI0,RASDCLY,RAQUES,RADEFLT,RAEXHELP
 S RASDCLY=""
 D CL^SDCO21(RADFN,RASDDT,"",.RASDCLY)
 ; non-null value in RASDCLY() means that indicator should be asked
 ; Current Question Sequence is:  SC, CV, AO, IR, EC, SHAD, MST, HNC
 S RASEQ="3,7,1,2,4,8,5,6" ; Same Question Sequence as in $$SEQ^SDCO21
 F RAI0=1:1:$L(RASEQ,",") Q:$G(RAQUIT)  S RASEQ1=+$P(RASEQ,",",RAI0) I $D(RASDCLY(RASEQ1)) D
 .S RAQUES="Was treatment related to "_$P($G(^SD(409.41,RASEQ1,0)),U,6)
 .I RASEQ1=3 S RAQUES="Was treatment for a SC Condition"
 .S RAEXHELP=$S(RASEQ1=3:"D DIS^DGRPDB",1:"")
 .S RASEQ2=$S(RASEQ1=3:2,RASEQ1=1:3,RASEQ1=2:4,1:RASEQ1+1)
 .; if no user entry for CV, default to Yes; else keep user entry for CV
 .S RADEFLT=$S($P(RABWDX(RACNT),U,RASEQ2)=1:"Yes",$P(RABWDX(RACNT),U,RASEQ2)=0:"NO",RASEQ2=8:"Yes",1:"")
 .I RADEFLT=""&($D(^TMP("RACOPY",$J))) D
 ..;find matching DX from Prim and Sec "RACOPY" nodes
 ..I $P(^TMP("RACOPY",$J,"BA"),U,1)=$P(RABWDX(RACNT),U,1) S RADEFLT=$S($P(^TMP("RACOPY",$J,"BA"),U,RASEQ2)=1:"Yes",$P(^TMP("RACOPY",$J,"BA"),U,RASEQ2)=0:"No",1:"")
 ..I $D(^TMP("RACOPY",$J,"BA",$P(RABWDX(RACNT),U,1))) S RADEFLT=$S($P(^TMP("RACOPY",$J,"BA",$P(RABWDX(RACNT),U,1)),U,RASEQ2)=1:"Yes",$P(^TMP("RACOPY",$J,"BA",$P(RABWDX(RACNT),U,1)),U,RASEQ2)=0:"No",1:"")
 .S $P(RABWDX(RACNT),U,RASEQ2)=$S($P(RABWDX(RACNT),U,1)>0:$$ASKYN(RAQUES,RADEFLT,RAEXHELP),1:0)
 Q
 ;
ASKYN(RAQUES,RADEFLT,RAEXHELP) ; Ask Yes/No Questions
 N DIR,DIRUT,DUOUT,DTOUT
 I $G(RAEXHELP)'="" S DIR("??")="^"_RAEXHELP
 S DIR("A")="  "_RAQUES,DIR(0)="YO"
 S DIR("B")=RADEFLT D ^DIR
 S:Y="^" RAQUIT=1
 I $D(DIRUT)!($D(DTOUT))!($D(DUOUT)) S Y="" ; user typed  @ , ^ , or timed out
 Q Y
 ;
DUPDX ; Check If A Duplicate ICD Dx Has Been Entered.
 N I
 F I=1:1 Q:'$D(RABWDX(I))  I (I11+1)'=I,+Y=+RABWDX(I) S RADUP=1 Q
 Q
 ;
PROV() ; Validate for Provider Key, Active, and non-Terminated statuses.
 ; Original DIC("S") for Requesting Provider.
 ; Y = ien file #200
 S RACRE=0 ; 1 =  person is Active and Credentialed; 0 =  otherwise
 ; Check PROVIDER KEY
 I $$ACTIVE^XUSER(Y),$D(^XUSEC("PROVIDER",Y)) S RACRE=1
 Q RACRE
 ;
FILEDX(RADFN,RAO) ; Store SC/EI Fields in Order file #75.1
 ; Called from RAORD1 routine.
 I '$D(RABWDX) G PFSS
 N RA1,RA11,RA2,RAFDA,RAIEN,RAMSG
 S RAFDA(75.1,RAO_",",91)=+RABWDX(1) ; Primary Ordering ICD Dx pointer.
 F RA1=2:1:9 D
 .S RA11=$S(RA1<8:RA1,1:RA1+1) ;Skip a field # for CV
 .S RAFDA(75.1,RAO_",",(90+RA11))=$P(RABWDX(1),U,RA1)
 D FILE^DIE("K","RAFDA","RAMSG") K RAFDA,RAMSG
 S RA1=1
 F  S RA1=$O(RABWDX(RA1)) Q:RA1=""  D
 .S RAFDA(75.13,"?+2,"_RAO_",",.01)=+RABWDX(RA1)
 .F RA2=2:1:9 D
 ..S RAFDA(75.13,"?+2,"_RAO_",",RA2)=$P(RABWDX(RA1),U,RA2)
 .D UPDATE^DIE("","RAFDA","RAIEN","RAMSG") K RAFDA,RAIEN,RAMSG
 .Q
PFSS ; RAO is the IEN of file #75.1
 ; we need to make this call before testing for RABWDX because the GETACCT 
 ; must be done regardless of presence of the RABWDX array
 I '$D(RACPRS) D FB^RABWIBB(RAO)  ; Requirement 1
 Q
