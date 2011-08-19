BPSCMT01 ;BHAM ISC/SS - ECME ADD/VIEW COMMENTS ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;USER SCREEN
 Q
 ;
ADD ;entry point for Add option in Add/View screen
 ;full screen mode
 D FULL^VALM1
 D ADDCMT
 S VALMBCK="R"
 Q
 ;make element for the patient
 ;BPLINE - line number in LM ARRAY (by ref)
 ;BPTMP - VALMAR (TMP global for LM)
 ;BPDFN - patient's DFN
 ;BPSINSUR - ;patient's insurance ien^name^phone
 ;BPLMIND - passed by ref - current patient(/insurance) index ( to make 1, 2,etc)
 ;BPDRIND - passed by ref - current claim level index ( to make .1, .2, .10,... .20,... )
 ;BPPREV - to store previous data to update patient summary line
MKPATELM(BPLINE,BPTMP,BPDFN,BPSINSUR,BPLMIND,BPDRIND,BPPREV) ;*/
 N BPSSTR,BPLNS,BPSTAT
 ;PATIENT SUMMARY level
 ;-------- first process previous patient & insurance group
 ;determine patient summary statuses for the previous "patient" group
 ;update the record for previous patient summary after we went thru all his claims
 I BPLMIND>0,+BPPREV=BPLMIND D UPDPREV(BPTMP,BPLMIND,BPPREV)
 ;process new "patient & insurance" group ------------------
 S BPDRIND=0
 S BPLMIND=(BPLMIND\1)+1
 ;save the all necessary data for the patient & insurance to use as previous for STAT4PAT later on
 S BPPREV=BPLMIND_U_BPLINE_U_BPDFN_U_$$PATINF^BPSSCR02(BPDFN,BPSINSUR)_U_(+BPSINSUR)
 S BPSSTR=$$LJ^BPSSCR02(BPLMIND,4)_$P(BPPREV,U,4)
 D SAVEARR^BPSSCR02(BPTMP,BPLMIND,BPDRIND,BPDFN,0,BPLINE,BPSSTR,+BPSINSUR)
 S BPLINE=BPLINE+1
 Q
 ;
 ;/**
 ;update patient summary info in LM array
UPDPREV(BPTMP,BPLMIND,BPPREV) ;
 N BPSSTR
 ;update the record for previous patient summary after we went thru all his claims
 S BPSSTR=$$LJ^BPSSCR02(BPLMIND,4)_$P(BPPREV,U,4)_" "_$$STAT4PAT^BPSSCR02(BPLMIND)
 D SAVEARR^BPSSCR02(BPTMP,BPLMIND,0,+$P(BPPREV,U,3),0,+$P(BPPREV,U,2),BPSSTR,+$P(BPPREV,U,5))
 Q
 ;/**
 ;make array element for a claim
 ;BPLINE - line number in LM ARRAY (by ref)
 ;BPTMP - VALMAR (TMP global for LM)
 ;BP59 - ptr to 9002313.59
 ;BPDFN - patient's DFN
 ;BPSINSUR - ;patient's insurance ien
 ;BPLMIND - passed by ref - current patient(/insurance) index ( to make 1, 2,etc)
 ;BPDRIND - passed by ref - current claim level index ( to make .1, .2, .10,... .20,... )
 ;BPPREV - to store previous data to update patient summary line
MKCLMELM(BPLINE,BPTMP,BP59,BPDFN,BPSINSUR,BPLMIND,BPDRIND,BPPREV) ;*/
 N BPSSTR,BPLNS,BPSTAT
 ;CLAIMS level
 I +$O(@BPTMP@("LMIND",BPLMIND,BPDRIND,BPDFN,0))'=BP59 D
 . S BPDRIND=BPDRIND+1
 . S BPSSTR="  "_$$LJ^BPSSCR02(+$P(BPLMIND,".")_"."_BPDRIND,5)_" "_$$CLAIMINF^BPSSCR02(BP59)
 . D SAVEARR^BPSSCR02(BPTMP,BPLMIND,BPDRIND,BPDFN,BP59,BPLINE,BPSSTR,BPSINSUR)
 . S BPLINE=BPLINE+1
 . N BPARR,X
 . ;use ADDINF^BPSSCR03 to get comments
 . S BPLNS=$$ADDINF^BPSSCR03(BP59,.BPARR,74,"C")
 . F X=1:1:BPLNS D
 . . I $G(BPARR(X))="" Q
 . . D SAVEARR^BPSSCR02(BPTMP,BPLMIND,BPDRIND,BPDFN,BP59,BPLINE,"      "_BPARR(X),BPSINSUR)
 . . S BPLINE=BPLINE+1
 Q
 ;/**
 ;input:
 ; BPDFLT1 - default selection (optional)
 ;add comment
 ;the user can select
 ; a patient - comment will be added to all claims
 ; a claim - comment will be added only to this claim
ADDCMT ;*/
 N BPRET,BPSEL,BP59ARR,BPRCMNT,BP59,BPNOW,BPLCK,BPREC,BPDFLT1
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 ;select an item
 W !,"Enter the line number for which you wish to Add comments."
 S BPDFLT1=$G(^TMP("BPSCMT",$J,"VALM","SELLN"))
 S BPDFLT1=$P(BPDFLT1,U,6)_"."_$P(BPDFLT1,U,7)
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","PC","Please select Patient Line to add a comment to all RXs or a SINGLE RXs",$G(BPDFLT1))
 I BPSEL<1 S VALMBCK="R" Q
 ;if single claim
 I $P(BPSEL,U,7)>0 S BP59ARR(+$P(BPSEL,U,4))=""
 E  D MKPATARR^BPSCMT(VALMAR,+$P(BPSEL,U,6),.BP59ARR)
 S BPRCMNT=$$COMMENT^BPSSCRCL("Enter Comment",60)
 I (BPRCMNT="^")!($L(BPRCMNT)=0)!(BPRCMNT?1" "." ") Q
 S BP59=0
 F  S BP59=$O(BP59ARR(BP59)) Q:+BP59=0  D
 . N BPDA,BPERR,%
 . D NOW^%DTC
 . S BPNOW=%
 . L +^BPST(9002313.59111,+BP59):10
 . S BPLCK=$T
 . I 'BPLCK Q  ;quit
 . D INSITEM(9002313.59111,+BP59,BPNOW)
 . S BPREC=$O(^BPST(BP59,11,"B",BPNOW,0))
 . I BPREC>0 D
 . . S BPDA(9002313.59111,BPREC_","_BP59_",",.02)=+$G(DUZ)
 . . S BPDA(9002313.59111,BPREC_","_BP59_",",.03)=$G(BPRCMNT)
 . . D FILE^DIE("","BPDA","BPERR")
 . I BPLCK L -^BPST(9002313.59111,+BP59)
 D REDRWCMT^BPSCMT ;update the content of the screen and display it
 S ^TMP("BPSSCR",$J,"VALM","UPDATE")=1
 Q
 ;
 ;/**
 ;BPSFILE - subfile# (9002313.59111) for comment
 ;BPIEN - ien for file in which the new subfile entry will be inserted
 ;BPVAL01 - .01 value for the new entry
INSITEM(BPSFILE,BPIEN,BPVAL01) ;*/
 N BPSSI,BPIENS,BPFDA,BPER
 S BPIENS="+1,"_BPIEN_","
 S BPFDA(BPSFILE,BPIENS,.01)=BPVAL01
 D UPDATE^DIE("","BPFDA","BPSSI","BPER")
 I $D(BPER) D BMES^XPDUTL(BPER("DIERR",1,"TEXT",1))
 Q
 ;
 ;Function to return username data from NEW PERSON file VA(200)
 ; Parameter
 ;  BPSDUZ - IEN of NEW PERSON file
 ;  
 ; Returns
 ;  Username in format of Lastname, Firstname MI
USERNAM(BPSDUZ) ; Return username from NEW PERSON file
 N BPSNMI,BPSNMO
 I '$G(BPSDUZ) Q ""
 S BPSNMI=$$VA200NM^BPSJUTL(+BPSDUZ,"")
 I $G(BPSNMI)="" Q ""
 Q:$P(BPSNMI,U)="" ""
 S BPSNMO=$P(BPSNMI,U)
 Q:$P(BPSNMI,U,2)="" BPSNMO
 S BPSNMO=BPSNMO_", "_$P(BPSNMI,U,2)
 Q:$P(BPSNMI,U,3)="" BPSNMO
 S BPSNMO=BPSNMO_" "_$E($P(BPSNMI,U,3),1)
 Q BPSNMO
