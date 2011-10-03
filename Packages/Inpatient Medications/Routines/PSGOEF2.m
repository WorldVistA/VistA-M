PSGOEF2 ;BIR/JMC - INPATIENT MEDS OVERLAPPING ADMIN TIMES ;23 Jun 09 / 2:48 PM
 ;;5.0; INPATIENT MEDICATIONS ;**222**;16 DEC 97;Build 5
 ;
 ; Reference to ORCD is supported by DBIA 5493.
 ;
 Q
 ;
OVERLAP ;  Check for overlapping admin times on complex orders with "AND" conjunction.
 K ORDIALOG,^TMP("PSJATOVR",$J)  ;Have to use array name ORDIALOG even though it's not PSJ namespaced. 
 S PSJOVRLP=0
 N PSJORDLG,X,CNT,TOTCONJ
 S PSJORDLG=$$PTR^ORCD("PSJ OR PAT OE") I PSJORDLG="" Q  ;locates dialog sequence for Inpatient Meds dialog in CPRS.
 D GETDLG^ORCD(PSJORDLG)  ;retrieves info about Inpatient Meds dialog setup in CPRS
 S X="" F  S X=$O(ORDIALOG(X)) Q:X=""  D
 . I $P($G(ORDIALOG(X)),"^",2)="CONJ" D GETDLG1^ORCD(PSJORDLG),GETORDER^ORCD(PSJCOM) M PSJOVR("CONJ")=ORDIALOG(X)
 . I $P($G(ORDIALOG(X)),"^",2)="ADMIN" D GETDLG1^ORCD(PSJORDLG),GETORDER^ORCD(PSJCOM) M PSJOVR("ADMIN")=ORDIALOG(X)
 . I $P($G(ORDIALOG(X)),"^",2)="SCHEDULE" D GETDLG1^ORCD(PSJORDLG),GETORDER^ORCD(PSJCOM) M PSJOVR("SCHEDULE")=ORDIALOG(X)
 K ORDIALOG
 ; Clean up array below by killing unnecessary nodes
 F X="CONJ","ADMIN","SCHEDULE"  K PSJOVR(X,0),PSJOVR(X,"A"),PSJOVR(X,"?"),PSJOVR(X,"??") I X="ADMIN" M PSJOVR(X_"O")=PSJOVR(X)
 ; Look for no AND conjunctions.  If no AND conjuncitons, quit.
 S X="",CNT=0,TOTCONJ=$O(PSJOVR("CONJ",""),-1)
 F  S X=$O(PSJOVR("CONJ",X)) Q:X=""  I PSJOVR("CONJ",X)="A" S CNT=CNT+1
 Q:CNT=0  ;if CNT=0, there are no AND conjunctions in the order.  No need to proceed further.
 D BUILD
 ; Format all admin times to 4 digit length for comparison.
 S X="" F  S X=$O(PSJOVR("ADMIN",X)) Q:X=""  D
 . S X1=$G(PSJOVR("ADMIN",X)),X2=$L(X1,"-")
 . F X3=1:1:X2 D
 . . I $L($P(X1,"-",X3))<4 S $P(X1,"-",X3)=$P(X1,"-",X3)_"00"
 . . S PSJOVR("ADMIN",X)=X1,PSJADOV(X,$P(X1,"-",X3))=""
 ; Order contains all AND conjunctions, no THEN conjunctions.
 I CNT=TOTCONJ D CHK,EXIT Q
 ; Piece order back together in a string of part number, conjunction
 ; Produces a string like 1A2T3 - part 1 AND part 2 THEN part 3
 S X="" F  S X=$O(PSJOVR("ADMIN",X)) Q:X=""  D
 . S PSJOVR("STRING")=$G(PSJOVR("STRING"))_X_$G(PSJOVR("CONJ",X))
 . S PSJTHEN=$L(PSJOVR("STRING"),"T")
 . S PSJTHEN1="" F PSJTHEN1=1:1:PSJTHEN D
 . . I $P(PSJOVR("STRING"),"T",PSJTHEN1)'["A" Q  ;No need to check for overlap if only one part to a THEN conjunction
 . . S PSJAND=$L($P(PSJOVR("STRING"),"T",PSJTHEN1),"A")
 . . S PSJAND1="" F PSJAND1=1:1:PSJAND D
 . . . S PSJAND(PSJTHEN1,PSJAND1)=$P($P(PSJOVR("STRING"),"T",PSJTHEN1),"A",PSJAND1)
 D CHK2,EXIT
 Q
CHK ;
 Q:'CNT
 K PSJADOVR
 S X=""
 F X=1:1:CNT D
 . S X2=""  F  S X2=$O(PSJADOV(X2)) Q:X2=""  D
 . . S X3=""  F  S X3=$O(PSJADOV(X2,X3)) Q:X3=""  D
 . . . I $D(PSJADOV(X2+X,X3)) S $P(^TMP("PSJATOVR",$J,X2),"^",4)=1,$P(^TMP("PSJATOVR",$J,X2+X),"^",4)=1,PSJOVRLP=1
 Q
 ;
CHK2 ;
 Q:'$G(PSJAND1)
 S (X,X1,X2,X3,X4,PSJZT)=""
 K PSJADOVR
 F X=1:1:PSJAND1 D
 . S X2="" F  S X2=$O(PSJAND(X2)) Q:X2=""  D
 . . S X3="" F  S X3=$O(PSJAND(X2,X3)) Q:X3=""  D
 . . . S X4=$G(PSJAND(X2,X3))
 . . . Q:X4=""
 . . . M PSJADOVR(X2,X3,X4)=PSJADOV(X4)
 F PSJZT=1:1:PSJAND1 D
 . S X="" F  S X=$O(PSJADOVR(X)) Q:X=""  D
 . . S X1="" F  S X1=$O(PSJADOVR(X,X1)) Q:X1=""  D
 . . . S X2="" F  S X2=$O(PSJADOVR(X,X1,X2)) Q:X2=""  D
 . . . . S X3="" F  S X3=$O(PSJADOVR(X,X1,X2,X3)) Q:X3=""  D
 . . . . . I $D(PSJADOVR(X,X1+PSJZT,X2+PSJZT,X3)) S $P(^TMP("PSJATOVR",$J,X2),"^",4)=1,$P(^TMP("PSJATOVR",$J,X2+PSJZT),"^",4)=1,PSJOVRLP=1
 Q
 ;
BUILD ;
 S X="" F  S X=$O(PSJOVR("SCHEDULE",X)) Q:X=""  S ^TMP("PSJATOVR",$J,X)=X_"^"_$G(PSJOVR("SCHEDULE",X))
 S X="" F  S X=$O(PSJOVR("ADMIN",X)) Q:X=""  S ^TMP("PSJATOVR",$J,X)=^TMP("PSJATOVR",$J,X)_"^"_$G(PSJOVR("ADMIN",X))_"^0"
 Q
 ;
EXIT ; Kill variables
 K PSJAND,PSJAND1,PSJTHEN,PSJTHEN1,PSJADOVR,PSJADOV,PSJADOV2
 K X,X1,X2,X3,X4,PSJZT,TOTCONJ,CNT,PSJORDLG
 Q
