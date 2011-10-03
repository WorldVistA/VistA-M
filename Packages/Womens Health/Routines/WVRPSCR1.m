WVRPSCR1 ;HCIOFO/FT,JR-Display Compliance Rates (cont.) ;6/17/99  11:47
 ;;1.0;WOMEN'S HEALTH;**3,7**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  THIS REPORT WILL DISPLAY COMPLIANCE RATES FOR PAPS & MAMS.
 ;;  ENTRY POINTS CALLED BY WVRPSCR.
DATA ;EP
 ;---> SORT AND STORE ARRAY IN ^TMP("WV",$J
 K WVTMP,^TMP("WV",$J),^TMP("WVP",$J),WVPR
 ;---> WVBEGDT1=ONE SECOND BEFORE BEGIN DATE.
 ;---> WVENDDT1=THE LAST SECOND OF END DATE.
 F WVCNT=20,30,40,50,60,70,200 S WVAGRG(WVCNT)=""
 S WVBEGDT1=WVBEGDT-.0001,WVENDDT1=WVENDDT+.9999
 ;
 S WVDATE=WVBEGDT1,WVTOT=$$ACTIVE^WVRPSCR2(WVBEGDT,WVENDDT1,WVAGRG)
 F  S WVDATE=$O(^WV(790.1,"D",WVDATE)) Q:'WVDATE!(WVDATE>WVENDDT1)  D
 .S WVIEN=0
 .F  S WVIEN=$O(^WV(790.1,"D",WVDATE,WVIEN)) Q:'WVIEN  D
 ..S Y=^WV(790.1,WVIEN,0)
 ..S WVDFN=$P(Y,U,2),WVPCDN=$P(Y,U,4),WVRES=$P(Y,U,5)
 ..;
 ..;---> QUIT IF THIS PROCEDURE HAS A RESULT OF "ERROR/DISREGARD".
 ..Q:WVRES=8
 ..;
 ..;---> QUIT IF NEITHER A PAP (IEN=1) NOR A SCREENING MAM (IEN=28).
 ..Q:((WVPCDN'=1)&(WVPCDN'=28))
 ..;
 ..;---> QUIT IS PATIENT IS NOT WITHIN AGE RANGE.
 ..S WVAGE=+$$AGE^WVUTL9(WVDFN)
 ..I WVAGRG'=1 Q:((WVAGE<$P(WVAGRG,"-"))!(WVAGE>$P(WVAGRG,"-",2)))
 ..;
 ..;---> GET VALUE OF RESULT: 0=NORMAL, 1=ABNORMAL, 2=NO RESULT
 ..S WVNORM=$$NORMAL^WVUTL4(WVRES) S:WVNORM=2 WVNORM=0
 ..;
 ..S ^TMP("WV",$J,WVDFN,WVNORM,WVPCDN,WVIEN)=""
 ..I WVPCDN=1 D
 ...S WVJPAPR=$P($G(^WV(790,WVDFN,0)),U,16)
 ...I WVJPAPR'>0 S WVJPAPR="NOT SPECIFIED"
 ...E  S WVJPAPR=$P($G(^WV(790.03,WVJPAPR,0)),U)
 ...S ^TMP("WVP",$J,WVJPAPR,WVDFN,WVNORM,WVPCDN,WVIEN)=""
 ..I WVPCDN=28 D
 ...S WVJ=$O(WVAGRG(WVAGE))
 ...S WVJAGER=$S(WVJ=20:"<20",WVJ=30:"20-29",WVJ=40:"30-39",WVJ=50:"40-49",WVJ=60:"50-59",WVJ=70:"60-69",WVJ=200:">70",1:"AGE UNKNOWN")
 ...S ^TMP("WVP",$J,WVJAGER,WVDFN,WVNORM,WVPCDN,WVIEN)=""
 ;
 ;---> NOW COLLATE DATA FROM ^TMP ARRAY INTO LOCAL WVTMP REPORT ARRAY.
 ;---> FIRST, SEED LOCAL ARRAY WITH ZEROS.
 F M=1,28 D
 .N I F I=1:1:5 S WVTMP("RES",M,I)=0
 ;
 ;---> COLLATE DATA.
 S N=0
 F  S N=$O(^TMP("WV",$J,N)) Q:'N  D
 .F M=1,28 D
 ..Q:$D(^TMP("WV",$J,N,1,M))
 ..S P=0,Q=0
 ..F  S P=$O(^TMP("WV",$J,N,0,M,P)) Q:'P  S Q=Q+1
 ..Q:'Q
 ..I '$D(WVTMP("RES",M,Q)) S WVTMP("RES",M,Q)=1 Q
 ..S WVTMP("RES",M,Q)=WVTMP("RES",M,Q)+1
 ;
 ;---> STORE ALL NODES >5 IN THE 5+ NODE.
 F M=1,28 D
 .S Q=5
 .F  S Q=$O(WVTMP("RES",M,Q)) Q:'Q  D
 ..S WVTMP("RES",M,5)=WVTMP("RES",M,5)+WVTMP("RES",M,Q)
 ..K WVTMP("RES",M,Q)
 ;
 ;---> FIGURE PERCENTAGES OF WOMEN AND STORE IN ARRAY.
 F M=1,28 D
 .F Q=1:1:5 S $P(WVTMP("RES",M,Q),U,2)=$J((+WVTMP("RES",M,Q)/WVTOT),0,2)
 ;
 ;---> BUILD DISPLAY ARRAY.
 N WVNODE K ^TMP("WV",$J)
 ;
 ;---> PAPS SUBHEADER LINE.
 S WVNODE=$$S(40)_"SCREENING PAPS"
 D WRITE(1,WVNODE)
 S WVNODE=$$S(39)_"----------------"
 D WRITE(2,WVNODE)
 S WVNODE=" # of PAPs:                                        1     2     3     4     5+"
 D WRITE(4,WVNODE)
 S WVNODE=" -----------                                     ----- ----- ----- ----- -----"
 D WRITE(5,WVNODE)
 ;
 ;---> PAPS NUMBER OF WOMEN DATA LINE.
 S WVNODE=" # of Women:                                    "
 F Q=1:1:5 S WVNODE=WVNODE_$J($P(WVTMP("RES",1,Q),U),6)
 D WRITE(6,WVNODE)
 S WVNODE=" % of Women:                                    "
 F Q=1:1:5 S WVNODE=WVNODE_$J(($P(WVTMP("RES",1,Q),U,2)*100),5)_"%"
 D WRITE(7,WVNODE)
 ;
 ;---> LINE FEEDS BETWEEN PAPS AND MAMS.
 S WVNODE="" D WRITE(8,WVNODE) S WVNODE="" D WRITE(9,WVNODE)
 ;
 ;---> MAMS SUBHEADER LINE.
 S WVNODE=$$S(40)_"SCREENING MAMS"
 D WRITE(10,WVNODE)
 S WVNODE=$$S(39)_"----------------"
 D WRITE(11,WVNODE)
 S WVNODE=" # of MAMs:                                        1     2     3     4     5+"
 D WRITE(13,WVNODE)
 S WVNODE=" -----------                                     ----- ----- ----- ----- -----"
 D WRITE(14,WVNODE)
 ;
 ;---> PAPS NUMBER OF WOMEN DATA LINE.
 S WVNODE=" # of Women:                                    "
 F Q=1:1:5 S WVNODE=WVNODE_$J($P(WVTMP("RES",28,Q),U),6)
 D WRITE(15,WVNODE)
 S WVNODE=" % of Women:                                    "
 F Q=1:1:5 S WVNODE=WVNODE_$J(($P(WVTMP("RES",28,Q),U,2)*100),5)_"%"
 D WRITE(16,WVNODE)
 Q
 ;
WRITE(I,Y) ;EP
 S ^TMP("WV",$J,I,0)=Y
 Q
 ;
S(S) ;EP
 ;---> SPACES.
 Q $$S^WVUTL7($G(S))
 ;
 ;
AGERNG(WVAGRG,WVPOP) ;EP
 ;---> ASK AGE RANGE.
 ;---> RETURN AGE RANGE IN WVAGRG.
 N DIR,DIRUT,Y S WVPOP=0
 W !!?3,"Do you wish to limit this report to an age range?"
 S DIR(0)="Y",DIR("B")="NO" D HELP1
 S DIR("A")="   Enter Yes or No"
 D ^DIR K DIR W !
 S:$D(DIRUT) WVPOP=1
 ;---> IF NOT DISPLAYING BY AGE RANGE, SET WVAGRG (AGE RANGE)=1, QUIT.
 I 'Y S WVAGRG=1 Q
BYAGE1 ;
 W !?5,"Enter the age range you wish to select in the form of: 40-75"
 W !?5,"Use a dash ""-"" to separate the limits of the range."
 W !?5,"To select only one age, simply enter that age, with no dash."
 W !?5,"(NOTE: Patient ages will reflect the age they are today.)",!
 K DIR
 S DIR(0)="FOA",DIR("A")="     Enter age range: "
 S:$D(^WV(790.72,DUZ,0)) DIR("B")=$P(^(0),U,3)
 D ^DIR K DIR
 I $D(DIRUT) S WVPOP=1 Q
 D CHECK(.Y)
 I Y="" D  G BYAGE1
 .W !!?5,"* INVALID AGE RANGE.  Please begin again."
 ;---> WVAGRG=SELECTED AGE RANGE(S).
 S WVAGRG=Y
 D DIC^WVFMAN(790.72,"L",.Y,"","","","`"_DUZ)
 Q:Y<0
 D DIE^WVFMAN(790.72,".03////"_WVAGRG,+Y,.WVPOP,1)
 Q
 ;
HELP1 ;EP
 ;;Answer "YES" to display screening rates for a specific age range.
 ;;If you choose to display for an age range, you will be given the
 ;;opportunity to select the age range.  For example, you might choose
 ;;to display from ages 50-75.
 ;;Answer "NO" to display screening rates for all ages.
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
 ;
PRINTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
 ;
HELPTX ;EP
 ;---> CREATES DIR ARRAY FOR DIR.  REQUIRED VARIABLES: WVTAB,WVLINL.
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
 ;
CHECK(X) ;EP
 ;---> CHECK SYNTAX OF AGE RANGE STRING.
 ;---> IF X=ONE AGE ONLY, SET IT IN THE FORM X-X AND QUIT.
 I X?1N.N S X=X_"-"_X Q
 ;
 N FAIL,I,Y1,Y2
 S FAIL=0
 ;---> CHECK EACH RANGE.
 S Y1=$P(X,"-"),Y2=$P(X,"-",2)
 ;---> EACH END OF EACH RANGE SHOULD BE A NUMBER.
 I (Y1'?1N.N)!(Y2'?1N.N) S X="" Q
 ;---> THE LOWER NUMBER SHOULD BE FIRST.
 I Y2<Y1 S FAIL=1
 I FAIL S X="" Q
 Q
