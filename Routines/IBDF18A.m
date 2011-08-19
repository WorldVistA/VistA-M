IBDF18A ;ALB/CJM/AAS - ENCOUNTER FORM - utilities for PCE ;12-AUG-94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**34,38,51**;APR 24, 1997
 ;                                       
GLL(CLINIC,INTRFACE,ARY,FILTER,PAR5,PAR6,ENCDATE) ; -- get lots of lists in one call
 ; -- input see GETLST but pass interface by reference expects
 ;    intrface(n) = name of select list in package interface file
 ;
 ; -- PAR5 => not currently used
 ; -- PAR6 => not currently used
 ;
 ; -- output see GETLST
 N X,COUNT
 S COUNT=0
 S X="" F  S X=$O(INTRFACE(X)) Q:X=""  D GETLST(CLINIC,INTRFACE(X),ARY,$G(FILTER),.COUNT,$G(PAR6),ENCDATE)
 Q
 ;
GETLST(CLINIC,INTRFACE,ARY,FILTER,COUNT,MODIFIER,ENCDATE) ; -- returns any specified selection list for a clinic
 ; -- input  CLINIC = pointer to hospital location file for clinic
 ;         INTRFACE = name of selection list in package interface file
 ;              ARY = name of array to return list in
 ;           FILTER = predefined filters (optional, default = 1)
 ;                                       1 = must be selection list
 ;                                       2 = only visit cpts on list
 ;          ENCDATE = encounter date
 ;         MODIFIER = if modifiers are to be passed, 1=yes send modifiers
 ;                                                   
 ; -- output  The format of the returned array is as follows
 ;         @ARY@(0) = count of array element (0 of nothing found)
 ;         @ARY@(1) = ^group header
 ;         @ARY@(2) = P1 := cpt or icd code / ien of other items
 ;                    P2 := user defined text
 ;                    p6 := user defined expanded text to send to PCE
 ;                    p7 := second code or item defined for line item
 ;                    p8 := third code or item defined for line item
 ;                    p9 := associated clinical lexicon term
 ;                       
 ;         @ARY@(2,"MODIFIER",0)=count of CPT Modifiers for entry
 ;         @ARY@(2,"MODIFIER",1)=2 character CPT Modifier value
 ;         @ARY@(2,"MODIFIER",2)=2 character CPT Modifier value
 ;         @ARY@(2,"MODIFIER",k+1)=2 character CPT Modifier value
 ;        
 ;         @ARY@(k) = ^next group header
 ;         @ARY@(k+1) = problem ien or cpt or icd code^user define text
 ;
 ; -- output modification for patch 34:
 ;         Narrative to Send to PCE (instead of printed text)
 ;         field (2.01) in file 357.3, added as piece 6 of @ary@(n)
 ;
 ;         if additional codes for an item (diagnosis) are added to
 ;         item, they are added as pieces 7 and/or 8 of @ary@(n).
 ;
 ;         if a type of visit code is requested and none found, will
 ;         automatically look first for blocks named type of visit and
 ;         second for filtered codes using regular cpt blocks.
 ;
 ;         if a diagnosis block it requested and none found will
 ;         automagically look for Clinic Common Problem List and
 ;         then convert it to look like a diagnosis list
 ;
 N I,J,X,Y,INUM,IBQUIT,FORM,SETUP,LIST,BLOCK,OLDARY,IBDTMP,ROW,COL,BLK
 N LIST1,PACKAGE
 K ^TMP("IBDUP",$J)
 S (IBQUIT,LIST)=0
 S PACKAGE=$E(INTRFACE,1,30)
 ;
 ;Setup array containing NAME of the Package Interface file
 ;This is the second paramenter passed by PCE, TIU, & CPRS
 S LIST1("DG SELECT CPT PROCEDURE CODES")=""
 S LIST1("DG SELECT ICD-9 DIAGNOSIS CODE")=""
 S LIST1("DG SELECT VISIT TYPE CPT PROCE")=""
 S LIST1("GMP INPUT CLINIC COMMON PROBLE")=""
 S LIST1("GMP PATIENT ACTIVE PROBLEMS")=""
 ;
 S COUNT=$G(COUNT,0)
 I $G(FILTER)<1 S FILTER=1 ;default value=1
 I FILTER>1 S OLDARY=ARY,ARY="IBDTMP"
 S @ARY@(0)=+$G(@ARY@(0))
 I $G(CLINIC)="" G GETLSTQ
 I $G(^SC(CLINIC,0))="" G GETLSTQ
 I $G(INTRFACE)="" G GETLSTQ
 S INUM=$O(^IBE(357.6,"B",$E(INTRFACE,1,30),0))
 ; 
 ; -- find forms defined for clinic
 ;    piece 2 = basic form
 ;    piece 3,4,6 = supplemental forms
 S SETUP=$G(^SD(409.95,+$O(^SD(409.95,"B",CLINIC,0)),0))
 G:SETUP="" GETLSTQ
 F I=2,3,4,6,8,9 S FORM=$P(SETUP,"^",I) D  Q:IBQUIT
 .;
 .; -- find blocks on forms
 .Q:'FORM
 . D GETBLKS Q:'$O(BLK(0))
 . S (ROW,COL)=""
 . F  S ROW=$O(BLK(ROW)) Q:ROW=""  S COL="" F  S COL=$O(BLK(ROW,COL)) Q:COL=""  S BLOCK=$G(BLK(+ROW,+COL)) D
 ..;
 ..; -- see if package interface defined for blocks
 ..S LIST=0
 ..F  S LIST=$O(^IBE(357.2,"C",BLOCK,LIST)) Q:'LIST  I $P($G(^IBE(357.2,LIST,0)),"^",11)=INUM D COPYLIST^IBDF18A1(LIST,ARY,.COUNT)
 ;I COUNT D URH^IBDF18A1
 S @ARY@(0)=COUNT
 I FILTER=2 D F2^IBDF18A1(OLDARY)
 ;
 I COUNT=0 D
 .I $E(INTRFACE,1,30)=$E("DG SELECT VISIT TYPE CPT PROCEDURES",1,30) D TOV
 ;
 ; -- always check for both diagnosis and clinic common problems when
 ;    looking for diagnosis, return in diagnosis format
 I $E(INTRFACE,1,30)=$E("DG SELECT ICD-9 DIAGNOSIS CODES",1,30) D CCP(COUNT)
 ;This routine checks list that have CPT & ICD codes for CSV.
 D CHKLST^IBDF18A2:$D(LIST1(PACKAGE))
 ;
 K ^TMP("IBDUP",$J)
 ;
GETLSTQ Q
 ;
GETBLKS ; -- get the blocks for a form in row,column order
 K BLK
 N ROW,COL
 S BLK=0
 F  S BLK=$O(^IBE(357.1,"C",FORM,BLK)) Q:'BLK  D
 . S ROW=$P($G(^IBE(357.1,+BLK,0)),"^",4),COL=$P(^(0),"^",5)
 . Q:ROW=""!(COL="")
 . S BLK(ROW,COL)=BLK
 Q
 ;
CCP(COUNT) ; -- no diagnosis, look for common problems and convert
 N I,X,OLDCNT
 S OLDCNT=COUNT
 ;
 ; -- get the clinic common problem list
 D GETLST(CLINIC,"GMP SELECT CLINIC COMMON PROBLEMS",ARY,"",COUNT)
 ;
 ; -- now convert it to primary icd code save lexicon pointer in piece 6
 S I=OLDCNT
 F  S I=$O(VAR(I)) Q:I=""  D
 .S X=+VAR(I)
 . S:X $P(VAR(I),"^",9)=X,$P(VAR(I),"^",1)=$$ICDONE^LEXU(X)
 . I $P(VAR(I),"^",7) S $P(VAR(I),"^",7)=$$ICDONE^LEXU($P(VAR(I),"^",7))
 . I $P(VAR(I),"^",8) S $P(VAR(I),"^",8)=$$ICDONE^LEXU($P(VAR(I),"^",8))
 Q
 ;
TOV ; -- if trying to find Type of Visit codes but list on form
 ;    uses another interface try this
 ;
 N INUM
 S INUM=0
 F  S INUM=$O(^IBE(357.6,"B","DG SELECT CPT PROCEDURE CODES",INUM)) Q:'INUM  S INUM(INUM)=""
 D TOV1
 I COUNT=0 D TOV2
 Q
 ;
TOV1 ; -- first get all lists for blocks named Type of Visit or E&M
 N NM,HD
 F I=2,3,4,6,8,9 S FORM=$P(SETUP,"^",I) D:+FORM  Q:IBQUIT
 . ;
 . ; -- find blocks on forms
 . D GETBLKS Q:'$O(BLK(0))
 . S (ROW,COL)=""
 . F  S ROW=$O(BLK(ROW)) Q:ROW=""  S COL="" F  S COL=$O(BLK(ROW,COL)) Q:COL=""  S BLOCK=$G(BLK(+ROW,+COL)) D
 .. ;
 .. S NM=$P($G(^IBE(357.1,BLOCK,0)),"^",1)
 .. S NM=$TR(NM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .. S HD=$P($G(^IBE(357.1,BLOCK,0)),"^",11)
 .. S HD=$TR(HD,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .. I NM["TYPE OF VISIT"!(NM["VISIT TYPE")!(HD["TYPE OF VISIT")!(HD["VISIT TYPE")!(NM["E&M")!(NM["E & M")!(HD["E&M")!(HD["E & M") D
 ... S LIST=0
 ... F  S LIST=$O(^IBE(357.2,"C",BLOCK,LIST)) Q:'LIST  D
 .... I $D(INUM($P($G(^IBE(357.2,LIST,0)),"^",11))) D COPYLIST^IBDF18A1(LIST,ARY,.COUNT) K BLK(ROW,COL)
 Q
 ;
TOV2 ; -- get the type of visit codes from cpt lists using filter
 S OLDARY=ARY,ARY="IBDTMP"
 S @ARY@(0)=+$G(@ARY@(0))
 ;
 F I=2,3,4,6,8,9 S FORM=$P(SETUP,"^",I) D:+FORM  Q:IBQUIT
 . ;
 . ; -- find blocks on forms
 . S (ROW,COL)=""
 . F  S ROW=$O(BLK(ROW)) Q:ROW=""  S COL="" F  S COL=$O(BLK(ROW,COL)) Q:COL=""  S BLOCK=$G(BLK(+ROW,+COL)) D
 .. ;
 .. ; -- see if package interface defined for blocks
 .. S LIST=0
 .. F  S LIST=$O(^IBE(357.2,"C",BLOCK,LIST)) Q:'LIST  I $D(INUM($P($G(^IBE(357.2,LIST,0)),"^",11))) D COPYLIST^IBDF18A1(LIST,ARY,.COUNT)
 D F2^IBDF18A1(OLDARY)
 Q
 ;
 ; -- here are some sample tests for different lists
TEST1 K VAR D GETLST(573,"DG SELECT ICD-9 DIAGNOSIS CODES","VAR",1,"","",DT)
 X "ZW VAR"
 Q
 ;
TEST2 K VAR D GETLST(301,"DG SELECT ICD-9 DIAGNOSIS CODES","VAR",1,"","",DT)
 X "ZW VAR"
 Q
 ;
TEST4 K VAR D GETLST(300,"DG SELECT VISIT TYPE CPT PROCEDURES","VAR",1,"",1,DT)
 X "ZW VAR"
 Q
 ;
TEST5 K VAR D GETLST(300,"PX SELECT IMMUNIZATIONS","VAR",1,DT)
 X "ZW VAR"
 Q
 ;
TEST5A K VAR D GETLST(300,"PX SELECT SKIN TESTS","VAR",1,DT)
 X "ZW VAR"
 Q
 ;
TEST6 K VAR D GETLST(573,"DG SELECT CPT PROCEDURE CODES","VAR",1,"",1,DT)
 X "ZW VAR"
 Q
 ;
TEST7 K VAR D GETLST(573,"DG SELECT VISIT TYPE CPT PROCEDURES","VAR",1,"",1,DT)
 X "ZW VAR"
 Q
 ;
TEST8 ; -- use this to test CPRS ability to retrieve type of visit
 ;    set clinic := name or internal entry number of clinic or change
 ;    value for specific clinic
 K VAR
 I $G(CLINIC)="" S CLINIC=300
 I CLINIC'=+CLINIC W !,"Using Clinic: ",CLINIC S CLINIC=$O(^SC("B",CLINIC,0)) W !,"IEN: ",CLINIC,! H 5
 X "D VISIT^ORWPCE(.VAR,CLINIC) ZW VAR"
 Q
 ;
TEST9 K VAR D GETLST(301,"GMP SELECT CLINIC COMMON PROBLEMS","VAR",1)
 X "ZW VAR"
 Q
