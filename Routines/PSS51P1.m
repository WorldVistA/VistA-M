PSS51P1 ;BIR/LDT - API FOR INFORMATION FROM FILE 51.1 ;5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85,91,108,118,94**;9/30/97;Build 26
 ;
ZERO(PSSIEN,PSSFT,PSSPP,PSSTSCH,LIST) ;
 ;PSSIEN - IEN of entry in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSFT - Free Text name in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSPP - PACKAGE PREFIX field (#4) in ADMINISTRATION SCHEDULE file (#51.1). Screens for Administration
 ;Schedules for the Package Prefix passed.
 ;PSSTSCH - TYPE OF SCHEDULE field (#5) of ADMINISTRATION SCHEDULE file (#51.1). Screens for
 ;          One-time "O" if PSSTSCH passed in.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), STANDARD ADMINISTRATION TIMES field (#1), FREQUENCY (IN MINUTES) field (#2),
 ;MAXIMUM DAYS FOR ORDERS field (#2.5), PACKAGE PREFIX field (#4), TYPE OF SCHEDULE field (#5),
 ;STANDARD SHIFTS field (#6), OUTPATIENT EXPANSION field (#8), and OTHER LANGUAGE EXPANSIONS field (#8.1)
 ;of ADMINISTRATION SCHEDULE file (#51.1).
 N DIERR,ZZERR,PSS51P1,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSTSCH)]"",PSSTSCH'="O" S PSSTSCH=""
 S SCR("S")="" I $G(PSSTSCH)]""!$G(PSSPP)]"" D SETSCR
 I +$G(PSSIEN)>0 N PSSIEN2 S PSSIEN2=$$FIND1^DIC(51.1,"","A","`"_PSSIEN,"B",SCR("S"),"") D
 .I +PSSIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(51.1,+PSSIEN2,".01;1;2;4;5;6;2.5;8;8.1","IE","PSS51P1") S PSS(1)=0
 .F  S PSS(1)=$O(PSS51P1(51.1,PSS(1))) Q:'PSS(1)  D SETZRO^PSS51P1B
 I +$G(PSSIEN)'>0,$G(PSSFT)]"" D
 .I PSSFT["??" D LOOP^PSS51P1B(1) Q
 .D FIND^DIC(51.1,,"@;.01;1","QP",PSSFT,,"B",SCR("S"),,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSSXX S PSSXX=0 F  S PSSXX=$O(^TMP("DILIST",$J,PSSXX)) Q:'PSSXX  D
 ..S PSSIEN=+^TMP("DILIST",$J,PSSXX,0) K PSS51P1 D GETS^DIQ(51.1,+PSSIEN,".01;1;2;4;5;6;2.5;8;8.1","IE","PSS51P1") S PSS(1)=0
 ..F  S PSS(1)=$O(PSS51P1(51.1,PSS(1))) Q:'PSS(1)  D SETZRO^PSS51P1B
 K ^TMP("DILIST",$J)
 Q
 ;
WARD(PSSIEN,PSSFT,PSSIEN2,LIST) ;
 ;PSSIEN - IEN of entry in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSFT - Free Text name in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSIEN2 - IEN of entry in WARD sub-file (#51.11)
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), WARD multiple (#51.11) WARD field (#.01), and WARD ADMINISTRATION TIMES field (#1)
 ;of ADMINISTRATION SCHEDULE file (#51.1).
 N DIERR,ZZERR,PSS51P1,PSS,CNT
 S CNT=0
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN2)]"",+$G(PSSIEN2)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D WARD^PSS51P1C
 Q
 ;
HOSP(PSSIEN,PSSFT,LIST) ;
 ;PSSIEN - IEN of entry in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSFT - Free Text name in ADMINISTRATION SCHEDULE file (#51.1).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), HOSPITAL LOCATION multiple (#51.17) HOSPITAL LOCATION field (#.01), ADMINISTRATION TIMES field (#1),
 ;and SHIFTS field (#2) of ADMINISTRATION SCHEDULE file (#51.1).
 N DIERR,ZZERR,PSS51P1,SCR,PSS,CNT
 I $G(LIST)']"" Q
 D HOSP^PSS51P1A
 Q
 ;
IEN(PSSFT,LIST) ;
 ;PSSFT - Free Text name in ADMINISTRATION SCHEDULE file (#51.1).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01) and STANDARD ADMINISTRATION TIMES field (#1) of ADMINISTRATION SCHEDULE file (#51.1).
 N DIERR,ZZERR,PSS51P1,SCR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFT)']"" S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D IEN^PSS51P1A
 Q
 ;
AP(PSSPP,PSSFT,PSSWDIEN,PSSTYP,LIST,PSSFREQ) ;
 ;PSSPP - PACKAGE PREFIX in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSFT - Free Text name in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSWDIEN - IEN of entry of WARD multiple in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSSTYP - TYPE OF SCHEDULE field (#5) in ADMINISTRATION SCHEDULE file (#51.1). 
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), STANDARD ADMINISTRATION TIMES field (#1), and PACKAGE PREFIX field (#4)
 ;of ADMINISTRATION SCHEDULE file (#51.1).
 ;If PSSWDIEN is passed in then the WARD multiple (#51.11) WARD field (#.01), and WARD ADMINISTRATION TIMES field (#1)
 ;of ADMINISTRATION SCHEDULE file (#51.1) is returned.
 N DIERR,ZZERR,PSS51P1,SCR,PSS,PSSIEN,PSSVAL,PSSTMP
 I $G(PSSFREQ)']"" S PSSFREQ=""
 I $G(LIST)']"" Q
 D AP^PSS51P1A
 Q
 ;
IX(PSSFT,PSSPP,LIST) ;
 ;PSSFT - Free Text name in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSPP - PACKAGE PREFIX in ADMINISTRATION SCHEDULE file (#51.1).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), STANDARD ADMINISTRATION TIMES field (#1), FREQUENCY (IN MINUTES) field (#2),
 ;MAXIMUM DAYS FOR ORDERS field (#2.5),PACKAGE PREFIX field (#4), TYPE OF SCHEDULE field (#5), STANDARD
 ;SHIFTS field (#6), OUTPATIENT EXPANSION field (#8), and OTHER LANGUAGE EXPANSION field (#8.1) of
 ;ADMINISTRATION SCHEDULE file (#51.1).
 N DIERR,ZZERR,PSS51P1,PSS
 I $G(LIST)']"" Q
 D IX^PSS51P1A
 Q
 ;
ADM(PSSADM) ; admin times
 N X S X=PSSADM
 I $S($L($P(X,"-"))>4:1,$L(X)>119:1,$L(X)<2:1,X'>0:1,1:X'?.ANP) K X Q "^"
 S X(1)=$P(X,"-") I X(1)'?2N,X(1)'?4N K X Q "^"
 S X(1)=$L(X(1)) F X(2)=2:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $S($L(X(3))'=X(1):1,X(3)>$S(X(1)=2:24,1:2400):1,1:X(3)'>$P(X,"-",X(2)-1)) K X Q
 I '$D(X) Q "^"
 K:$D(X) X(1),X(2),X(3) Q PSSADM
 ;
ALL(PSSIEN,PSSFT,LIST) ;
 ;PSSIEN - IEN of entry in ADMINISTRATION SCHEDULE file (#51.1).
 ;PSSFT - Free Text name in ADMINISTRATION SCHEDULE file (#51.1).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns NAME field (#.01), STANDARD ADMINISTRATION TIMES field (#1), FREQUENCY (IN MINUTES) field (#2),
 ;MAXIMUM DAYS FOR ORDERS field (#2.5), PACKAGE PREFIX field (#4), TYPE OF SCHEDULE field (#5),
 ;STANDARD SHIFTS field (#6), OUTPATIENT EXPANSION field (#8), OTHER LANGUAGE EXPANSIONS field (#8.1),
 ; HOSPITAL LOCATION multiple (#51.17) HOSPITAL LOCATION field (#.01), ADMINISTRATION TIMES field (#1),
 ;SHIFTS field (#2), WARD multiple (#51.11) WARD field (#.01), and WARD ADMINISTRATION TIMES field (#1)
 ;of ADMINISTRATION SCHEDULE file (#51.1).
 N DIERR,ZZERR,PSS
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSSIEN)'>0,($G(PSSFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSSIEN)]"",+$G(PSSIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 D ALL^PSS51P1C
 Q
 ;
SETSCR ;Set Screen for One-time schedule type
 ;Naked reference below refers to ^PS(51.1,+Y,0)
 I $G(PSSTSCH)]"" S SCR("S")="I $P(^(0),""^"",5)=""O"""
 ;Naked reference below refers to ^PS(51.1,+Y,0)
 I $G(PSSPP)]"" S SCR("S")=$S(SCR("S")]"":SCR("S")_" I $P(^(0),""^"",4)=PSSPP",1:"I $P(^(0),""^"",4)=PSSPP")
 Q
FREQ(PSSVAL,PSSFREQ) ; VALIDATES FREQUNCY FIELD
 S PSSTMP=0
 I PSSVAL>PSSFREQ S PSSTMP=1
 I PSSVAL<1 S PSSTMP=1
 I PSSFREQ="" S PSSTMP=0
 Q PSSTMP
PSSDQ ;DQ^DICQ call on 51.1
 N DIC,D,DZ S DIC="^PS(51.1,",D="B",DIC(0)="EQS",DZ="??" D DQ^DICQ Q
 ;
SCHED(PSSWIEN,PSSARRY) ;
 I $G(PSSWIEN)="" S PSSWIEN=0
 D SCHED^PSSSCHED(PSSWIEN,.PSSARRY) Q
