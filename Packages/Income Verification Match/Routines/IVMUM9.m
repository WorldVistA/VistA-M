IVMUM9 ;ALB/SEK - ADD DEPENDENT CHANGES TO 408.13 & 408.41 ; 12 JAN 95
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;**1**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
AUDIT ; change dependent demo data in 408.13 and add changes to 408.41.
 ; if IVM transmitted IEN of 408.12 and IEN found at VAMC, any of the
 ; 4 demo fields could be different.  if ien of 408.12 is not
 ; transmitted and dependent is found in 408.13, name & ssn could be
 ; different because sex, dob, & relationship (408.12) must be the same.
 I IVMDOB'=IVMDOB13 D
 .S DGMTACT="DOB",DGMTSOLD=IVMDOB13,DGMTSNEW=IVMDOB D SET^DGMTAUD
 .S IVMDR=".03////^S X=IVMDOB"
 .Q
 I IVMSEX'=IVMSEX13 D
 .S DGMTACT="SEX",DGMTSOLD=IVMSEX13,DGMTSNEW=IVMSEX D SET^DGMTAUD
 .S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_".02////^S X=IVMSEX"
 .Q
AUDIT1 I IVMNM'=IVMNM13 D
 .S DGMTACT="NAM",DGMTSOLD=IVMNM13,DGMTSNEW=IVMNM D SET^DGMTAUD
 .S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_".01////^S X=IVMNM"
 .Q
 I IVMSSN'=IVMSSN13 D
 .S DGMTACT="SSN",DGMTSOLD=IVMSSN13,DGMTSNEW=IVMSSN D SET^DGMTAUD
 .S IVMSSN=$S(IVMSSN="":"@",1:IVMSSN)
 .S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_".09////^S X=IVMSSN"
 .Q
 ;
 ; change 408.13
 I $D(IVMDR) S DR=IVMDR,DA=DGIPI,DIE="^DGPR(408.13," D ^DIE K DA,DIE,DR,IVMDR Q
 K DGDEPI,DGMTA,DGMTACT,DGMTSNEW,DGMTSOLD
 Q
 ;
AUDITP ; set common variables for audit
 S DGMTYPT=1,DGDEPI=DGIPI,DGMTA=DGMTP
 K IVMDR
 ;
 ; dgrel("s") contains 408.12 IEN of active spouse of VAMC test
 ; dgrel("c",xxx) contains 408.12 IEN of active children of VAMC test
 ; if VAMC dependent not a IVM dependent the dependent must be inactivated
 ; dependents remaining in dgrel after all IVM dependents are uploaded, will be inactivated
 ; if IVM & VAMC dependent, kill dgrel to prevent inactivation of dependent
 ; dgpri is IVM (or IVM & VAMC) dependent's 408.12 IEN
 I IVMSPCHV="S" D  Q
 .I +$G(DGREL("S"))=DGPRI K DGREL("S")
 S IVMFLG4=1,IVMCC=0 F  S IVMCC=$O(DGREL("C",IVMCC)) Q:'IVMCC  D  Q:'IVMFLG4
 .I +$G(DGREL("C",IVMCC))=DGPRI S IVMFLG4=0 K DGREL("C",IVMCC)
 K IVMCC
 Q
