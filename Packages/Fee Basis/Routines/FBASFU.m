FBASFU ;AISC/JLG - UTILITIES FOR ICD10 DIAGNOSIS CODE ASF (Advanced Search Functionality) ;3/26/2012
 ;;3.5;FEE BASIS;**139**;JAN 30, 1995;Build 127
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to API $$CODEC^ICDEX supported by ICR #5747
 ; Reference to API $$SD^ICDEX supported by ICR #5747
 ; Reference to API $$STATCHK^ICDEX supported by ICR #5747
 ;
 ;checks if field is a required field
 ;input parameters : File number, Field name
 ;returns 0 -if true -1 -if false
REQFLD(FBFILE,FBFLD) N FBFLDNO,FBFLAT S FBFLDNO=""
 S FBFLDNO=$$FLDNUM^DILFD(FBFILE,FBFLD) ; get field number
 S FBFLAT=$P($G(^DD(FBFILE,FBFLDNO,0)),U,2)  ;sample ^DD(162.5,30,0)="ICD1^RP80'^ICD9(^DX;1^Q"
 I FBFLAT["R" Q 0  ; return true if field is required
 Q -1
 ;
 ; returns default value
 ;    parameters- file number,ien,field name
 ;    returns value of field
GETVAL(FBFILE,FBIEN,FBFLD)  N FBFLDNO S FBFLDNO=""
 I (FBFLD[":") D
 . I $E(FBFLD,1,3)="ICD" S FBFLD=$TR(FBFLD,": ") ;remove colon from ICDn prompt
 . I FBFLD["ADMITTING DIAGNOSIS:" S FBFLD="ADMITTING DIAGNOSIS" ; remove colon from ADMITTING DIAGNOSIS prompt
 . Q
 Q:((FBFILE="161.01")&('$D(^FBAAA(1,1,FBIEN,"C")))) ""
 Q:FBFILE="161.01" $$CODEC^ICDEX(80,$P(^FBAAA(1,1,FBIEN,"C"),U,2)) ; Code from an IEN 
 S FBFLDNO=$$FLDNUM^DILFD(FBFILE,FBFLD)
 Q:FBFLDNO'>0 ""
 Q $$GET1^DIQ(FBFILE,FBIEN,FBFLDNO)
 ;
 ; returns diagnosis code to use as default
 ;    parameters- file number,patient ien,other indexed ien (example authorization ien)
 ;    returns value of field
GETDC(FBFILE,FBDFN,FBIEN) ;
 ; 161.01 is the sub-field authorization in fee basis patient file
 Q:(FBFILE="161.01")&('$D(^FBAAA(FBDFN,1,FBIEN,"C"))) ""
 Q:(FBFILE="161.01")&($P(^FBAAA(FBDFN,1,FBIEN,"C"),"^",2)<1) "" ; quit if not a valid diagnosic code
 Q:FBFILE="161.01" $$CODEC^ICDEX(80,$P(^FBAAA(FBDFN,1,FBIEN,"C"),"^",2)) ; Code from an IEN 
 Q ""
 ;
 ; returns diagnosis code from file 162.7 (FB Unauthorized Claims) to use as default
 ;    parameters- Fee Basis file number, UAC ien
 ;    returns value of field or spaces
GETDCUC(FBFILE,FBIEN) ;
 Q:(FBFILE="162.7")&('$D(^FB583(FBIEN,"DX"))) ""
 Q:(FBFILE="162.7")&($P(^FB583(FBIEN,"DX"),"^",2)<1) ""  ; quit if not a valid diagnosic code
 Q:FBFILE="162.7" $$CODEC^ICDEX(80,$P(^FB583(FBIEN,"DX"),"^",2))
 Q ""
 ;
 ; prints inactive to screen if ICD code is inactive and returns a value of -1 
STATCHK(ICDCODE,ICDDT) ; 
 N ICDRET,FBPOUT,MYARY
 S ICDRET=$$STATCHK^ICDEX(ICDCODE,ICDDT,30) ;  3rd param represents coding system ie. ICD-10-CM
 ; possible results (set 1)  1^IEN^Effective Date     Active Code       (returns 0)
 ;                  (set 2)  0^IEN^Effective Date     Inactive Code     (returns -1)
 ;                  (set 3)  0^IEN^Null               Future Activation (pending) (returns -2)
 ;                  (set 4)  0^-1^Error Message       Code not Found or Error (returns -3)
 I $P(ICDRET,U)=1 Q 0         ; reference set 1
 I $P(ICDRET,U,2)<0 Q -3      ; reference set 4
 I $L($P(ICDRET,U,3))<7 Q -2  ; reference set 3 
 ; falls into set 2 - inactive code - print icd code, short description and inactive message to the screen
 S FBIEN=$P(ICDRET,U,2),FBICD=$$CODEC^ICDEX(80,FBIEN)
 S FBDESC=$$SD^ICDEX(80,FBIEN,ICDDT,.MYARY,60)
 S FBINAC=FBIEN_";"_FBICD_"^"_FBDESC
 W ! S FBPOUT=$$PRTICD10(FBINAC)
 W !,*7," Code is inactive" W:$G(ICDDT)>0 " on "_$$FMTE^XLFDT(ICDDT) ; defaults to set 2
 K FBICD,FBDESC,FBINAC
 Q -1
 ;
 ; print ICD-10 code and description to the screen
PRTICD10(ICDREC) ; 
 N ICDRET,ICDDESC,ICDLEN,PRTLEN,POSREM,SPOS,EPOS,NUMLN,I,PRTLN
 I ($P(ICDREC,U,3)=0)&(FBDFLT'=$P($P(ICDREC,U,1),";",2)) W !,"One match found",!
 W !,"  ICD Diagnosis code:         "_$P($P(ICDREC,U,1),";",2)
 S ICDDESC=$P(ICDREC,U,2),ICDLEN=$L(ICDDESC) ; length of description
 S PRTLEN=30,POSREM=IOM-PRTLEN,SPOS=1,EPOS=POSREM
 S NUMLN=(ICDLEN\POSREM)+1
 F I=1:1:NUMLN D
 . S PRTLN(I)=$E(ICDDESC,SPOS,EPOS)
 . I I=1 W !,"  ICD Diagnosis description:  "_PRTLN(I)
 . I I>1 W !,?PRTLEN,PRTLN(I)
 . S SPOS=SPOS+POSREM
 . S EPOS=EPOS+POSREM
 . K PRTLN(I)
 N FBYN S FBYN=999
 I ($P(ICDREC,U,3)=0)&(FBDFLT'=$P($P(ICDREC,U,1),";",2)) D
 .F FBYN=0!FBYN=1!FBYN=2 S FBYN=$$QUESTION^FBASF(1,"OK?")
 Q:FBYN=2 -1 ;no entered 
 Q:FBYN=-3 -1 ;"^" entered
 S ICDRET=$P(ICDREC,U) ; ien
 Q ICDRET
 ;
