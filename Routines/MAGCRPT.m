MAGCRPT ;WOIFO/EdM ; Report on inconsistencies ; [ 11/01/2001 11:27 ]
 ;;3.0;IMAGING;;Mar 01, 2002
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
RPT(TYPE) ; This entry is called from the VistA Menu Option handler
 ; The value of TYPE is equal to either
 ;  "QA"  -- report for Quality Assurance  (option MAG_IC_RPT_QA)
 ;  "CO"  -- report for Central Office     (option MAG_IC_RPT_CO)
 ;
 N OK,POP,X,Y,STOP,TODAY,STATUS,NUMBER,ERRTYPE,I,II,VA,VADM
 S NUMBER=$O(^XTMP("MAGCHK",""))
 I +NUMBER,$P(^XTMP("MAGCHK",NUMBER,0),"^",1)'?.N1".".N S NUMBER=0
 ; Previous scans had the 1st piece as the scan status instead of the purge date for XTMP
 S OUT=0
 I +NUMBER D
 . S STATUS=$P($G(^XTMP("MAGCHK",NUMBER,0)),"^",4)
 . D NOW^%DTC S TODAY=%
 . S START=$P($G(^XTMP("MAGCHK",NUMBER,0)),"^",5)
 . S STOP=$P($G(^XTMP("MAGCHK",NUMBER,0)),"^",6)
 I +NUMBER I STATUS'="COMPLETE" D
 . S Y=$P(^XTMP("MAGCHK",NUMBER,0),"^",5) X ^DD("DD")
 . N DIR
 . S OK=1
 . W !!,"Scanning appears to be active.  It was started on: "_Y
 . S DIR(0)="Y",DIR("B")="Y"
 . S DIR("A")="Do you want to start it again?"
 . D ^DIR S:'Y OK=0
 . I 'OK W !,"Note:  Report will be partial and not the complete report."
 . I OK S NUMBER=0
 . I Y["^" S OUT=1
 . Q
 I +OUT Q
 ;check to see if scan is over 2 weeks old
 I +NUMBER I STATUS="COMPLETE" S X1=TODAY,X2=STOP D ^%DTC I X>14 D
 . S DAYS=+X
 . N DIR
 . S OK=1
 . S DIR(0)="Y",DIR("B")="Y"
 . S DIR("A",1)="The database scanner has not run in "_+X_" days"
 . S DIR("A")="Do you want to start a new scan? "
 . D ^DIR S:'Y OK=0
 . I 'OK W !,"Note:  You will get an old report."
 . I OK S NUMBER=0
 . I Y["^" S OUT=1
 . Q
 I +OUT Q
 S OK=0 F  D  Q:POP>0  Q:OK
 . D ^%ZIS Q:POP>0
 . I IOM<132 W !!,"Report is formatted for 132 columns",!,"Try again" Q
 . S OK=1
 . I $E(IOST,1,1)'="P" D  Q:'OK
 . . N DIR
 . . S DIR(0)="Y"
 . . S DIR("A")="This is not a printer.  Is this OK",DIR("B")="YES"
 . . D ^DIR S:'Y OK=0
 . . Q
 . I $D(IO("Q")) D  Q
 . . S ZTRTN="WORK^MAGICRPT"
 . . S ZTIO=ION_";132"
 . . S ZTDESC="Imaging Integrity Check Report"
 . . S ZTSAVE("TYPE")=TYPE
 . . D ^%ZTLOAD,HOME^%ZIS
 . . I '$D(ZTSK) S OK=0 W !!,$C(7),"Request canceled.",! Q
 . . W !!,"Request queued." S OK=-1
 . . Q
 . Q
 Q:OK<1  Q:POP>0
 W !!,"Report being produced on ",IOST,!!
 U IO D WORK D ^%ZISC,HOME^%ZIS
 Q
 ;
WORK N D0,ERR,H1,H2,I,LIN,N,PAG,PT,SQI,X
 K ^TMP("MAGMAIL",$J)
 S ^TMP("MAGMAIL",$J,1,0)="Image^DFN-1^Name-1^SS4-1^SS4-2^DFN-2^DFN-2^Package^D0/D1^Message"
 D:'NUMBER RPT^MAGGSQI(.SQI,1E11) S NUMBER=$O(^XTMP("MAGCHK",""))
 S H1=$P(^XTMP("MAGCHK",NUMBER,0),"^",5) S X=H1 D H^%DTC S H1=%H_","_%T
 S H2=$P(^XTMP("MAGCHK",NUMBER,0),"^",6) S X=H2 D H^%DTC S H2=%H_","_%T
 S PAG=0
 S PT(3.9)="^XMB(3.9,PD0|MailMan||2|^XMB(3.9,PD0,2005,"
 S PT(63)="^LR(PD0,GF,PD1|Aut (M)|AY|1|^LR(PD0,GF,PD1,2005,"
 S PT(63.02)="^LR(PD0,GF,PD1|El-Micr|EM|1|^LR(PD0,GF,PD1,2005,"
 S PT(63.08)="^LR(PD0,GF,PD1|SrgPath|SP|1|^LR(PD0,GF,PD1,2005,"
 S PT(63.09)="^LR(PD0,GF,PD1|Cytol|CY|1|^LR(PD0,GF,PD1,2005,"
 S PT(63.2)="^LR(PD0,GF,PD1|Aut (G)|AU|1|^LR(PD0,GF,PD1,2005,"
 S PT(74)="^RARPT(PD0|Rad||2|^RARPT(PD0,2005,"
 S PT(130)="^SRF(PD0|Surgery||1|^SRF(PD0,2005,"
 S PT(691)="^MCAR(691,PD0|Echo||2|^MCAR(691,PD0,2005,"
 S PT(691.1)="^MCAR(691.1,PD0|Cath||2|^MCAR(691.1,PD0,2005,"
 S PT(691.5)="^MCAR(691.5,PD0|ECG||2|^MCAR(691.5,PD0,2005,"
 S PT(694)="^MCAR(694,PD0|Hema||2|^MCAR(694,PD0,2005,"
 S PT(699)="^MCAR(699,PD0|Endo||2|^MCAR(699,PD0,2005,"
 S PT(699.5)="^MCAR(699.5,PD0|Med||2|^MCAR(699.5,PD0,2005,"
 ;S PT(8925)="^TIU(8925,PD0|TIU||2|^TIU(8925.91,""ADI"",PD0,"
 S PT(8925)="^TIU(8925,PD0|TIU||2|^TIU(8925.91,""ADI"",PD0,"
 S ERR="" F  S ERR=$O(^XTMP("MAGCHK",NUMBER,"B",ERR)) Q:ERR=""  D 
 . I TYPE="CO" S X=1 D  Q:X
 . . S:ERR="Patient pointer mismatch between Image Group and Image" X=0
 . . S:ERR="Image and associated report have different patient pointers" X=0
 . . S:ERR="Associated report does not point back to Image" X=0
 . . Q
 . S ERRTYPE(ERR)=0 I ERR="Images only point to Patient." K ERRTYPE(ERR) Q
 . D HDR(ERR)
 . S N=0
 . S D0="" F  S D0=$O(^XTMP("MAGCHK",NUMBER,"B",ERR,D0)) Q:D0=""  D
 . . N ASITE,DFN,IDFN,IPN,ISS4,PD0,PD1,PDFN,PF,PK,PPN,PSS4,X0,X2
 . . S N=N+1
 . . S ASITE=$P($G(^MAG(2005,D0,100)),"^",3)
 . . S X0=$G(^MAG(2005,D0,0))
 . . S X2=$G(^MAG(2005,D0,2))
 . . S IDFN=$P(X0,"^",7) S:'IDFN IDFN="-?-"
 . . S PF=$P(X2,"^",6),PD0=$P(X2,"^",7),PD1=$P(X2,"^",10)
 . . S X=$G(PT(+PF),"|Unknown")
 . . S PK=$P(X,"|",2)
 . . ;S DFN=IDFN D DEM^VADPT S IPN=VADM(1),ISS4=$E(IPN,1)_$G(VA("BID"))
 . . S XX=+$$PTLKP(IDFN,.IPN,.ISS4)
 . . S (PPN,PDFN,PSS4)=""
 . . D:ERR="Image and associated report have different patient pointers"
 . . . N GF,GP,GR,GR0,GT,P0,T
 . . . Q:PK="Unknown"
 . . . S GR=$P(PT(PF),"|",1),GR0=GR_",0)"
 . . . S GP=$P(PT(PF),"|",4)
 . . . S P0=$G(@GR0,"^not defined"),PDFN=$P(P0,"^",GP)
 . . . I PF\1=63 S PDFN=PD0
 . . . I 'PDFN,IPN=PDFN S PDFN=IDFN
 . . . Q:IDFN=PDFN
 . . . S XX=+$$PTLKP(PDFN,.PPN,.PSS4)
 . . . ;S DFN=PDFN D DEM^VADPT S PPN=VADM(1),PSS4=$E(PPN,1)_$G(VA("BID"))
 . . . Q
 . . D:ERR="Patient pointer mismatch between Image Group and Image"
 . . . N G0,P0
 . . . S P0=$P(X0,"^",10)
 . . . S X0=$G(^MAG(2005,D0,0))
 . . . S X2=$G(^MAG(2005,D0,2))
 . . . S PDFN=$P(X0,"^",7) D:IDFN=PDFN
 . . . . S G0=0 F  S G0=$O(^MAG(2005,P0,1,G0)) Q:'G0  D  Q:'G0
 . . . . . S X0=$G(^MAG(2005,+$P($G(^MAG(2005,P0,1,G0,0)),"^",1),0))
 . . . . . S PDFN=$P(X0,"^",7) S:PDFN'=IDFN G0=0
 . . . . . Q
 . . . . Q
 . . . Q:PDFN=IDFN
 . . . S XX=+$$PTLKP(PDFN,.PPN,.PSS4)
 . . . ;S DFN=PDFN D DEM^VADPT S PPN=VADM(1),PSS4=$E(PPN,1)_$G(VA("BID"))
 . . . Q
 . . S LIN=LIN+1 D:LIN>IOSL HDR(ERR)
 . . S X=PD0 S:PD1 X=X_"/"_PD1
 . . I TYPE="CO",PK'="Rad" Q
 . . Q:ERR="Images only point to Patient."
 . . S ERRTYPE(ERR)=$G(ERRTYPE(ERR))+1
 . . W !,$J(D0,7),"  ",$$L(IPN,31),"  ",$$L(PPN,31),"  "
 . . W $$L(ISS4,5),"  ",$$L(PSS4,5),"  "
 . . W $J(IDFN,8),"  ",$J(PDFN,8),"  ",$$L(PK,8),"  ",$J(X,5)," ",$J(ASITE,5)
 . . S I=$O(^TMP("MAGMAIL",$J," "),-1)+1
 . . S ^TMP("MAGMAIL",$J,I,0)=D0_"^"_IPN_"^"_PPN_"^"_ISS4_"^"_PSS4_"^"_IDFN_"^"_PDFN_"^"_PK_"^"_X_"^"_ERR_"^"_ASITE
 . . Q
 . Q
 ;
 D PN
 W !,"S u m m a r y"
 ;S X=$G(SQI(0)) W !!,+X," ",$P(X,"^",2),!!
 S X=$P($G(^XTMP("MAGCHK",NUMBER,0)),"^",8) W !!,X," entries scanned."
 S II=$O(^TMP("MAGMAIL",$J," "),-1)+1
 S ^TMP("MAGMAIL",$J,II,0)=+X_" entries scanned."
 S I="" F  S I=$O(ERRTYPE(I)) Q:I=""  D
 . W !,$J($G(ERRTYPE(I)),7)," occurrence" W:+$G(ERRTYPE(I))'=1 "s" W " of ",I
 . S II=$O(^TMP("MAGMAIL",$J," "),-1)+1
 . S ^TMP("MAGMAIL",$J,II,0)=$G(ERRTYPE(I))_" occurrence"_$S($G(ERRTYPE(I))'=1:"s",1:"")_" of "_I
 . Q
 I +H1 D
 . S X=$P(H2,",",1)-$P(H1,",",1)*86400+$P(H2,",",2)-$P(H1,",",2)
 . W !!,"Database scan took "
 . S HRS=X\3600 I +HRS S HRS=+HRS_$S(HRS>1:" hours ",1:" hour ") W HRS
 . S MIN=X\60#60 I +MIN S MIN=+MIN_$S(MIN>1:" minutes ",1:" minute ") W MIN
 . S SEC=X#60 I +SEC S SEC=+SEC_$S(SEC>1:" seconds ",1:" second ") W SEC
 . S II=$O(^TMP("MAGMAIL",$J," "),-1)+1
 . S ^TMP("MAGMAIL",$J,II,0)="Database scan took "_HRS_" "_MIN_" "_SEC
 . Q
 N XMY,XMTEXT,XMSUB
 S XMY("G.MAG SERVER")=""
 S XMTEXT="^TMP(""MAGMAIL"","_$J_","
 S XMSUB="Imaging Integrity Check ("_TYPE_")"
 ;
 I TYPE="CO" I $P(^XTMP("MAGCHK",NUMBER,0),"^",7)="" D
 . D ^XMD
 . S $P(^XTMP("MAGCHK",NUMBER,0),"^",7)="MAILED"
 . Q
 ;
 I TYPE="QA" I $P(^XTMP("MAGCHK",NUMBER,0),"^",9)="" D
 . D ^XMD
 . S $P(^XTMP("MAGCHK",NUMBER,0),"^",9)="MAILED"
 . Q
 K ^TMP("MAGMAIL",$J)
 Q
 ;
L(X,N) Q $E(X_$J("",N),1,N)
 ;
PTLKP(DFN,IPN,ISS4) ;
 S IPN="Unknown"
 S ISS4="Unk"
 I DFN="" Q "0^NO_DFN"
 D DEM^VADPT
 S:'VAERR IPN=VADM(1),ISS4=$E(IPN,1)_$G(VA("BID"))
 I 'VAERR Q "1^SUCCESS"
 Q "0^FAILED"
 ;
PN N X
 S PAG=PAG+1,X="Page "_PAG,LIN=6
 W:PAG'=1 @IOF
 W DT#100," "
 W $P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",DT\100#100)
 W " ",DT\10000+1700,?(IOM-$L(X)),X
 Q
 ;
HDR(ERR) ;
 D PN
 S HEADING=$S(TYPE="CO":"**** Report on Inconsistencies Caused by Global Moves ****",1:"**** Report of All Image-Related Inconsistencies Detected ****")
 W !?(IOM-$L(HEADING)\2),HEADING
 W !?(IOM-$L(ERR)\2),ERR,!
 W !,"Image    Patient Name                     Patient Name                     SSN4   SSN4    DFN      DFN                Package"
 W !,"Number   (First one found)                (Other one found)                (fst)  (oth)  (fst)     (oth)     Package  IEN      SITE"
 W !,"=======  ===============================  ===============================  =====  =====  ========  ========  =======  ======= ====="
 W !
 Q
 ;
QA ; Report for QA
 D RPT("QA")
 Q
 ;
CO ; Report for CO
 D RPT("CO")
 Q
 ;
TEST S IOSL=55,IOM=132,IO=$P,TYPE="QA" D WORK
 Q
 ;
DOCU ;
 ;^XTMP("MAGCHK",$J,0)=PURGE DATE^CREATE DATE^DESCRIPTION^STATUS^SCAN START^SCAN STOP^C0 MAILED^#SCANNED^QA MAILED
 Q
