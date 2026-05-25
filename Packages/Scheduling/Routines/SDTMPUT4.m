SDTMPUT4 ;BAH/DRF - ADVANCED CLINIC SEARCH REPORT;Apr 21, 2025
 ;;5.3;Scheduling;**911**;Aug 13, 1993;Build 15
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to ^ECX(728.44 in #7340
 Q
 ;
BEGIN ;Ask for search criteria
 W #,"ADVANCED CLINIC SEARCH",!!
 K ^TMP("SDTMPUT4",$J)
 D ACT I Y="^" D END Q
 D CLINIC I Y="^" D END Q
 D DEFPROV I X="^" D END Q
 D PROVIDER I X="^" D END Q
 D STOPCODEX I X="^" D END Q
 D CHAR4 I X="^" D END Q
 D DIV I X="^" D END Q
 ;
IO ;Ask IO device
 W !!,"FOR PROPER FORMATTING, THIS REPORT SHOULD BE PRINTED TO A 132 COLUMN DEVICE OR TERMINAL"
 S %ZIS="PM" D ^%ZIS I POP D END Q
 ;
LOOP ;Loop through selected clinics
 S CNT=0,FND=0,PGNO=0,INACT=0
 S CLNAM="" F  S CLNAM=$O(^TMP("SDTMPUT4",$J,"C",CLNAM)) Q:CLNAM=""  D
 . S CL=0 F  S CL=$O(^TMP("SDTMPUT4",$J,"C",CLNAM,CL)) Q:'CL  D
 .. S IN=$G(^SC(CL,"I"))
 .. I $P(IN,U,1)>0,+$P(IN,U,2)=0,^TMP("SDTMPUT4",$J,"ACT")="A" Q  ;Eliminate inactive clinics
 .. I +$P(IN,U,1)=0!(+$P(IN,U,1)>0&(+$P(IN,U,2)>0)),^TMP("SDTMPUT4",$J,"ACT")="I" Q  ;Eliminate active clinics
 .. S NODE0=$G(^SC(CL,0)),CLSTC=$P(NODE0,U,7),CLCRSC=$P(NODE0,U,18),DIV=$P(NODE0,U,15),DP=$P(NODE0,U,13),CLCHAR4=$$CHAR4^SDESUTIL($P(NODE0,U,1))
 .. S INST="" I $G(DIV) S INST=$P($G(^DG(40.8,DIV,0)),U,7)
 .. S SDDIS=0 I $P($G(^SC(CL,"PA")),U,3)="Y" S SDDIS=1
 .. S DPR="" I +DP S DPR=$P(^VA(200,DP,0),U,1)
 .. I $D(^TMP("SDTMPUT4",$J,"DIV")),DIV'=$G(^TMP("SDTMPUT4",$J,"DIV")) Q  ;Eliminate non-matching divisions
 .. I $D(^TMP("SDTMPUT4",$J,"DP")) I $$DPRVMTCH(DP)=0 Q  ;Eliminate non-matching default provider
 .. I $D(^TMP("SDTMPUT4",$J,"P")) I '$$PROVMATCH(CL) Q  ;Eliminate non-matching provider
 .. I $D(^TMP("SDTMPUT4",$J,"SCP")) I $$SCPCHK()=0 Q  ;Eliminate non-matching stop code pair
 .. I $D(^TMP("SDTMPUT4",$J,"SC")) I $$SCCHK()=0 Q  ;Eliminate non-matching stop code
 .. I $D(^TMP("SDTMPUT4",$J,"CHAR4")) I CLCHAR4="" Q  ;Eliminate non-matching CHAR4
 .. I $D(^TMP("SDTMPUT4",$J,"CHAR4")) I '$D(^TMP("SDTMPUT4",$J,"CHAR4",CLCHAR4)) Q  ;Eliminate non-matching CHAR4
 .. D PRVARR
 .. D LINE
 I 'FND D HEADER W !!,"NO CLINICS MEETING THE CRITERIA WERE FOUND",!
 I CNT W !!,CNT," CLINIC" W:CNT>1 "S" W " TOTAL  (",INACT," INACTIVE, ",CNT-INACT," ACTIVE)",!
 W !,"** END **"
 G END
 ;
HEADER ;Print header
 N I,CRIT,DP,P,SC0,SCP,SCT,SCPAIR
 W #
 S PGNO=PGNO+1
 W ?1,"ADVANCED CLINIC SEARCH",?71,"DATE: ",$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?122,"PAGE: ",PGNO,!
 W ?1,"FLAGS: *=INACTIVE CLINIC, +=DISPLAY APPT TO PATIENTS, S=INACTIVE STOP CODE, C=INACTIVE CREDIT STOP CODE",!
 W ?1,$S($G(^TMP("SDTMPUT4",$J,"ACT"))="B":"BOTH ACTIVE AND *INACTIVE CLINICS",$G(^TMP("SDTMPUT4",$J,"ACT"))="I":"*INACTIVE CLINICS",1:"ACTIVE CLINICS")
 W " "
 S I="" F  S I=$O(^TMP("SDTMPUT4",$J,"CRI",I)) W:'I ! Q:'I  D
 . S CRIT=^TMP("SDTMPUT4",$J,"CRI",I)
 . I CRIT="ALL" W ?1,"ALL CLINICS" Q
 . I I>1 W " and "
 . I CRIT["[" W "CLINICS CONTAINING """_$P(CRIT,"[",2)_""""
 . I CRIT'["[" W "CLINICS BEGINNING WITH """_CRIT_""""
 I $D(^TMP("SDTMPUT4",$J,"DP")) D  W " DEFAULT PROVIDER: ",DP,!
 . S DP=""
 . S I=0 F  S I=$O(^TMP("SDTMPUT4",$J,"DP",I)) Q:'I  S DP=DP_$S(DP="":$P(^VA(200,I,0),U),1:", "_$P(^VA(200,I,0),U))
 I $D(^TMP("SDTMPUT4",$J,"P")) D  W " PROVIDER: ",P,!
 . S P=""
 . S I=0 F  S I=$O(^TMP("SDTMPUT4",$J,"P",I)) Q:'I  S P=P_$S(P="":$P(^VA(200,I,0),U),1:", "_$P(^VA(200,I,0),U))
 I $D(^TMP("SDTMPUT4",$J,"SC")) D  W " STOP CODE: ",SC,!
 . S SC=""
 . S I=0 F  S I=$O(^TMP("SDTMPUT4",$J,"SC",I)) Q:'I  D
 .. S SCT=^TMP("SDTMPUT4",$J,"SC",I),SC0=$G(^DIC(40.7,I,0)),SC=SC_$S(SC="":"",1:", ")_$P(SC0,U,2)_"-"_$P(SC0,U,1)_"("_SCT_")"_$S($P(SC0,U,3):" (Inactive)",1:"")
 I $D(^TMP("SDTMPUT4",$J,"SCP")) D  W " STOP CODE PAIR: ",SCPAIR,!
 . S SCP=0,SCP=$O(^TMP("SDTMPUT4",$J,"SCP",SCP))
 . S SC=$E(SCP,1,3),SC0=$G(^DIC(40.7,SC,0)),SCPAIR=$P(SC0,U,2)_"-"_$P(SC0,U,1)_$S($P(SC0,U,3):" (Inactive)",1:"")
 . S SC=$E(SCP,4,7),SC0=$G(^DIC(40.7,SC,0)),SCPAIR=SCPAIR_$S(SC="":"",1:", ")_$P(SC0,U,2)_"-"_$P(SC0,U,1)_$S($P(SC0,U,3):" (Inactive)",1:"")
 I $D(^TMP("SDTMPUT4",$J,"CHAR4")) D  W " CHAR4: ",CHAR4,!
 . S CHAR4=""
 . S I="" F  S I=$O(^TMP("SDTMPUT4",$J,"CHAR4",I)) Q:I=""  S CHAR4=CHAR4_$S(CHAR4="":"",1:", ")_I_"-"_$P(^ECX(728.441,$O(^ECX(728.441,"B",I,0)),0),U,2)
 S SDIV=$G(^TMP("SDTMPUT4",$J,"DIV"))
 W ?1,"DIVISION: ",$S(SDIV="":"ALL",1:$P($G(^DG(40.8,SDIV,0)),U,1)),!
 W ?1,"Clinic Name",?36,"IEN",?41,"CHAR4",?47,"SC#/CS#",?55,"Station",?63,"Provider (!Default Flag)",?89,"Default Provider",?116,"Updated",?127,"Flags",!
 W ?1,"--------------------------------",?34,"------",?41,"-----",?47,"-------",?55,"-------",?63,"-------------------------",?89,"--------------------------",?116,"----------",?127,"-----",!
 Q
 ;
LINE ;Write a single clinic record
 N SDFLG,CLSTD,CLCRSD,CLSTI,CLCRSI
 S FND=FND+1,CNT=CNT+1,SDFLG="    ",CLSTD="",CLCRSD="",CLSTI="",CLCRSI=""
 I FND#60=1 D HEADER
 I $P(IN,U,1)>0,+$P(IN,U,2)=0 S $E(SDFLG,1)="*",INACT=INACT+1
 I SDDIS S $E(SDFLG,2)="+"
 I CLSTC]"" S CLSTD=$P($G(^DIC(40.7,CLSTC,0)),U,2),CLSTI=$P($G(^DIC(40.7,CLSTC,0)),U,3)
 I CLSTI S $E(SDFLG,3)="S"
 I CLSTD="" S CLSTD="   "
 I CLCRSC]"" S CLCRSD=$P($G(^DIC(40.7,CLCRSC,0)),U,2),CLCRSI=$P($G(^DIC(40.7,CLCRSC,0)),U,3)
 I CLCRSD="" S CLCRSD="   "
 I CLCRSI S $E(SDFLG,4)="C"
 N X,XL,CLIN S X="     "_CL,XL=$L(X),CLIN=$E(X,XL-5,XL)
 W ?1,CLNAM,?34,CLIN,?41,CLCHAR4,?47,CLSTD,"/",CLCRSD,?55,$$GET1^DIQ(4,INST_",",99,"E"),?63,$E($G(PRV(1)),1,25),?89,$E(DPR,1,25),?116,$P($$AUDIT^SDTMPUT0(+CL),"@",1),?127,SDFLG,!
 I PRV>1 F K=2:1:PRV W ?63,PRV(K),! S FND=FND+1 D:FND#60=1 HEADER
 Q
 ;
END ;Clean up and Quit
 K ^TMP("SDTMPUT4",$J)
 K %ZIS,C,CHAR4,CL,CLCHAR4,CLCRSC,CLNAM,CLSTC,CNT,CRIT,CRITCNT,DIC,DIR,DIV,DP,DPR,FND,I,IN,INACT,INST,K,NODE0,PGNO,POP,PRNO,PRQTY,PRV,SC,SDDIS,SDIV,X,Y
 Q
 ;
ACT ;View active, inactive or both clinics
 K DIR,X,Y
 S DIR(0)="SA^A:ACTIVE;I:INACTIVE;B:BOTH^",DIR("B")="B"
 S DIR("A")="List which clinics - (A)ctive, (I)nactive or (B)oth ? "
 D ^DIR
 S ^TMP("SDTMPUT4",$J,"ACT")=Y
 Q
 ;
DIV ;Ask DIVISION
 K DIC,X,Y
 S DIC="^DG(40.8,",DIC(0)="AEMQZ" ;,DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))"
 S DIC("A")="Select DIVISION: ALL// " D ^DIC K DIC("S"),DIC("A") Q:"^"[X  I +Y'>0 G:+Y<0 DIV
 I X="^" Q
 S ^TMP("SDTMPUT4",$J,"DIV")=$P(Y,U,1)
 Q
 ;
CLINIC ;Ask CLINIC
 K C,CRIT,CRITCNT,D,DIR,FND,X,Y
 S DIR(0)="FO",DIR("A")="Select CLINIC NAME or ALL",CRITCNT="",CRITCNT=+$O(^TMP("SDTMPUT4",$J,"CRI",CRITCNT),-1)
 S DIR("?")=" "
 S DIR("?",1)="Enter a partial clinic name to find all clinics beginning with"
 S DIR("?",2)="that phrase. Use the left bracket ([) to find any clinics that"
 S DIR("?",3)="contains that phrase anywhere in their name. Enter ALL to include"
 S DIR("?",4)="all clinics. If you do not enter anything, ALL will be assumed."
 S DIR("?",5)="You may enter more than one clinic name on separate lines."
 D ^DIR
 I X="",$D(^TMP("SDTMPUT4",$J,"C")) Q
 I X="",'$D(^TMP("SDTMPUT4",$J,"C")) S X="ALL" W "ALL"
 I X="^" Q
 S CRIT=X ;Save criteria for report header
 I X="ALL" D  Q
 . K ^TMP("SDTMPUT4",$J,"C") ;All overwrites previous selections
 . S FND="" F I=1:1 S FND=$O(^SC("B",FND)) Q:FND=""  S C=0 F  S C=$O(^SC("B",FND,C)) Q:'C  S ^TMP("SDTMPUT4",$J,"C",FND,C)=""
 . S ^TMP("SDTMPUT4",$J,"CRI",1)="ALL"
 S D=X
 S FND=$O(^SC("B",D)),CNT=0
 I X'["[",$E(FND,1,$L(D))'=D W "  NOT FOUND",! G CLINIC
 I X["[" D 
 . S FND="" F I=1:1 S FND=$O(^SC("B",FND)) Q:FND=""  I FND[$P(X,"[",2) S C=0 F  S C=$O(^SC("B",FND,C)) Q:'C  S ^TMP("SDTMPUT4",$J,"C",FND,C)="",CNT=CNT+1
 . W " ",CNT," CLINICS FOUND"
 . S CRITCNT=CRITCNT+1,^TMP("SDTMPUT4",$J,"CRI",CRITCNT)=CRIT
 I X]"",X'["[" D
 . F I=1:1 S FND=$O(^SC("B",FND)) Q:$E(FND,1,$L(D))'=D  S C=0 F  S C=$O(^SC("B",FND,C)) Q:'C  S ^TMP("SDTMPUT4",$J,"C",FND,C)="",CNT=CNT+1
 . W " ",CNT," CLINICS FOUND"
 . S CRITCNT=CRITCNT+1,^TMP("SDTMPUT4",$J,"CRI",CRITCNT)=CRIT
 G CLINIC
 Q
 ;
CHAR4 ;Ask CHAR4
 K DIC,X,Y
 S DIC="^ECX(728.441,",DIC(0)="AEMQZ"
 S DIC("A")="Select CHAR4: " D ^DIC K DIC("S"),DIC("A") Q:"^"[X  I +Y'>0 G CHAR4
 I X="^" Q
 W " ",$P(Y(0),U,2),!
 S ^TMP("SDTMPUT4",$J,"CHAR4",$P(Y,U,2))=""
 G CHAR4
 Q
 ;
DEFPROV ;Ask DEFAULT PROVIDER
 K DIC,X,Y
 S DIC="^VA(200,",DIC(0)="AEMQZ"
 S DIC("A")="Select DEFAULT PROVIDER: " D ^DIC K DIC("S"),DIC("A") Q:"^"[X  I +Y'>0 G:+Y<0 DEFPROV
 I X="" Q
 I X="^" Q
 I '$D(^SC("AVADPR",$P(Y,U,1))) W " This person is not the default provider for any existing clinic",! G DEFPROV
 S ^TMP("SDTMPUT4",$J,"DP",$P(Y,U,1))=""
 G DEFPROV
 Q
 ;
PROVIDER ;Ask PROVIDER From provider multiple
 K DIC,X,Y
 S DIC="^VA(200,",DIC(0)="AEMQZ"
 S DIC("A")="Select PROVIDER: " D ^DIC K DIC("S"),DIC("A") Q:"^"[X  G:+Y<0 PROVIDER
 I X="" Q
 I X="^" Q
 S ^TMP("SDTMPUT4",$J,"P",$P(Y,U,1))=""
 G PROVIDER
 Q
 ;
PROVMATCH(CLINIC) ;Does clinic match search provider(s)?
 N MATCH,PCNT,PRDUZ,PRNO,PRQTY
 S PRQTY=+$P($G(^SC(CLINIC,"PR",0)),U,4) I PRQTY=0 Q 0
 S PCNT=0,MATCH=0
 F PRNO=1:1:PRQTY D
 . S PCNT=$O(^SC(CLINIC,"PR",PCNT))
 . S PRDUZ=$P(^SC(CLINIC,"PR",PCNT,0),U,1)
 . I $D(^TMP("SDTMPUT4",$J,"P",PRDUZ)) S MATCH=1 Q
 Q MATCH
 ;
PRVARR ;Create provider array
 K PRV
 N PCNT,PRDEF,PRDUZ,PRNAM,PRQTY
 S PRQTY=$P($G(^SC(CL,"PR",0)),U,4) I PRQTY=0 S PRV=0 Q
 S PCNT=0
 F PRNO=1:1:PRQTY D
 . S PCNT=$O(^SC(CL,"PR",PCNT))
 . S PRDUZ=$P(^SC(CL,"PR",PCNT,0),U,1),PRDEF=+$P(^SC(CL,"PR",PCNT,0),U,2),PRNAM=$P($G(^VA(200,PRDUZ,0)),U,1)
 . S PRV(PRNO)=PRNAM_$S(PRDEF:"!",1:"")
 S PRV=PRQTY
 Q
 ;
DPRVMTCH(DP) ;Does clinic match default provider(s)
 N MATCH,SDDP
 S MATCH=0
 I DP="" Q MATCH
 S SDDP="" F  S SDDP=$O(^TMP("SDTMPUT4",$J,"DP",SDDP)) Q:SDDP=""  I SDDP=DP S MATCH=1 Q
 Q MATCH
 ;
SCTYPE ;Where do you want to search for STOP CODE?
 S DIR(0)="FO",DIR("A")="Select (S)TOP CODE, (C)REDIT STOP CODE or (B)OTH"
 S DIR("?")=" "
 S DIR("?",1)="Enter S to check for Stop Code in the primary position."
 S DIR("?",2)="Enter C to check for a Stop Code in Credit Stop Code field"
 S DIR("?",3)="Enter B to check for a Stop Code in both fields."
 D ^DIR
 I X="" G SCTYPE
 I X="s" S X="S"
 I X="c" S X="C"
 I X="b" S X="B"
 I X'="S",X'="C",X'="B" W " Invalid choice" G SCTYPE
 Q
 ;
SCCHK() ;Individual STOP CODE check
 N MATCH
 S MATCH=0
 I 'CLSTC,'CLCRSC Q MATCH
 I CLSTC,$D(^TMP("SDTMPUT4",$J,"SC",CLSTC)),"BS"[$G(^TMP("SDTMPUT4",$J,"SC",CLSTC)) S MATCH=1
 I CLCRSC,$D(^TMP("SDTMPUT4",$J,"SC",CLCRSC)),"BC"[$G(^TMP("SDTMPUT4",$J,"SC",CLCRSC)) S MATCH=1
 Q MATCH
 ;
SCPCHK() ;Pair STOP CODE check
 N SCP,CLSTP,CLCRSP,MATCH
 S MATCH=0
 I 'CLSTC Q MATCH
 I 'CLCRSC Q MATCH
 S SCP="",SCP=$O(^TMP("SDTMPUT4",$J,"SCP",SCP))
 S CLSTP=$E(SCP,1,3),CLCRSP=$E(SCP,4,6)
 I CLSTP=CLSTC,CLCRSP=CLCRSC S MATCH=1
 Q MATCH
 ;
STOPCODEX ;Ask STOP CODE
 N ERROR,SCP
 S DIR(0)="FO"
 S DIR("A")=$S($D(^TMP("SDTMPUT4",$J,"SC")):"Select STOP CODE",1:"Select STOP CODE or PAIR")
 S DIR("?")=" "
 S DIR("?",1)="Enter a stop code or stop code pair. Stop code pairs must be "
 S DIR("?",2)="entered one per report with no other stop codes or pairs entered."
 S DIR("?",3)="Stop code pairs are entered as a 6 digit number with no slash or other"
 S DIR("?",4)="separator. Individual stop codes can be entered in multiples one at a"
 S DIR("?",5)="time on separate lines. You can search for individual stop codes as the"
 S DIR("?",6)="primary stop code, credit stop code or both."
 D ^DIR
 I X="",$D(^TMP("SDTMPUT4",$J,"SC")) Q
 I X="" Q
 I X="^" Q
 I X'?2.6N W " INVALID STOP CODE" G STOPCODEX
 I X?2.3N D
 . S ERROR=0,ERROR=$$SCLU(X,0) I 'ERROR S ^TMP("SDTMPUT4",$J,"SC",SC)=X
 I X?6N D
 . I $D(^TMP("SDTMPUT4",$J,"SC")) W ?34,"STOP CODE PAIRS MUST BE ENTERED ALONE",! Q
 . S ERROR=0
 . S ERROR=ERROR+$$SCLU($E(X,1,3),1)
 . I 'ERROR S $E(SCP,1,3)=SC
 . S ERROR=ERROR+$$SCLU($E(X,4,6),1)
 . I 'ERROR S $E(SCP,4,6)=SC
 . I ERROR W ?34,"INVALID PAIR",! Q
 . S ^TMP("SDTMPUT4",$J,"SCP",SCP)=""
 I $D(^TMP("SDTMPUT4",$J,"SCP")) Q
 G STOPCODEX
 Q
SCLU(CODE,PAIR)  ;Return SCERR=1 error, SCERR=0 no error
 N SC0
 S CODE=+CODE
 I '$D(^DIC(40.7,"C",CODE)) W ?34,"NOT FOUND",! Q 1
 I $D(^DIC(40.7,"C",CODE)) S SC="",SC=$O(^DIC(40.7,"C",CODE,SC))
 S SC0=^DIC(40.7,SC,0)
 W ?34,$P(SC0,U,2)," - ",$P(SC0,U,1)
 I $P(SC0,U,3) W " (INACTIVE)"
 I 'PAIR D SCTYPE
 W !
 Q 0
