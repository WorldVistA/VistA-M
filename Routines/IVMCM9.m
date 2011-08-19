IVMCM9 ;ALB/SEK,CKN,TDM - ADD DCD DEPENDENT CHANGES TO 408.13 & 408.41 ; 6/17/09 2:30pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,105,115,121**;21-OCT-94;Build 45
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
 .;If not a pseudo quit if not verified
 .Q:(IVMSSNVS'=4)&(IVMSSN'["P")
 .S DGMTACT="SSN",DGMTSOLD=IVMSSN13,DGMTSNEW=IVMSSN D SET^DGMTAUD
 .S IVMSSN=$S(IVMSSN="":"@",1:IVMSSN)
 .S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_".09////^S X=IVMSSN"
 .Q
 I IVMPSSNR'=IVMPSR13 D
 .S IVMPSSNR=$S(IVMPSSNR="":"@",1:IVMPSSNR)
 .S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_".1////^S X=IVMPSSNR"
 .Q
 I IVMSSNVS'=IVMSVS13 D
 .I IVMSSNVS="" Q  ;quit if no verify status
 .I IVMSSNVS=2,IVMSSN'=IVMSSN13 Q  ;Quit if verify status=Invalid and NO SSN match
 .S IVMSSNVS=$S(IVMSSNVS="":"@",1:IVMSSNVS)
 .S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_".11////^S X=IVMSSNVS"
 .Q
 I IVMSPMNM'=IVMSMN13 D
 .S IVMSPMNM=$S(IVMSPMNM="":"@",1:IVMSPMNM)
 .S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.1////^S X=IVMSPMNM"
 .Q
 ;
 I IVMSALU'=""&(IVMSADL1'=""&(IVMSALU>IVMALU13)) D
 . I IVMSADL1'=IVMAL113 D
 . . S IVMSADL1=$S(IVMSADL1="":"@",1:IVMSADL1)
 . . S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.2////^S X=IVMSADL1"
 . I IVMSADL2'=IVMAL213 D
 . . S IVMSADL2=$S(IVMSADL2="":"@",1:IVMSADL2)
 . . S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.3////^S X=IVMSADL2"
 . I IVMSADL3'=IVMAL313 D
 . . S IVMSADL3=$S(IVMSADL3="":"@",1:IVMSADL3)
 . . S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.4////^S X=IVMSADL3"
 . I IVMSCITY'=IVMCTY13 D
 . . S IVMSCITY=$S(IVMSCITY="":"@",1:IVMSCITY)
 . . S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.5////^S X=IVMSCITY"
 . I IVMSST'=IVMST13 D
 . . S IVMSST=$S(IVMSST="":"@",1:IVMSST)
 . . S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.6////^S X=IVMSST"
 . I IVMSZIP'=IVMZIP13 D
 . . S IVMSZIP=$S(IVMSZIP="":"@",1:IVMSZIP)
 . . S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.7////^S X=IVMSZIP"
 . I IVMSTELE'=IVMTEL13 D
 . . S IVMSTELE=$S(IVMSTELE="":"@",1:IVMSTELE)
 . . S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.8////^S X=IVMSTELE"
 . I IVMSALU'=IVMALU13 D
 . . S IVMDR=$S($D(IVMDR):IVMDR_";",1:"") S IVMDR=IVMDR_"1.9////^S X=IVMSALU"
 ;
 ; change 408.13
 I $D(IVMDR) S DR=IVMDR,DA=DGIPI,DIE="^DGPR(408.13," D ^DIE K DA,DIE,DR,IVMDR Q
 K DGDEPI,DGMTA,DGMTACT,DGMTSNEW,DGMTSOLD
 Q
 ;
AUDITP ; set common variables for audit
 S DGMTYPT=$S(IVMTYPE=3:"",1:IVMTYPE),DGDEPI=DGIPI
 I IVMMTIEN S DGMTA=$G(^DGMT(408.31,IVMMTIEN,0))
 S $P(DGMTA,"^",2)=DFN
 K IVMDR
 ;
 ; dgrel("s") contains 408.12 IEN of active spouse of VAMC test
 ; dgrel("c",xxx) contains 408.12 IEN of active children of VAMC test
 ; if VAMC dependent not a DCD dependent the dependent must be inactivated
 ; dependents remaining in dgrel after all DCD dependents are uploaded, will be inactivated
 ; if DCD & VAMC dependent, kill dgrel to prevent inactivation of dependent
 ; dgpri is DCD (or DCD & VAMC) dependent's 408.12 IEN
 I IVMSPCHV="S" D  Q
 .I +$G(DGREL("S"))=DGPRI K DGREL("S")
 S IVMFLG4=1,IVMCC=0 F  S IVMCC=$O(DGREL("C",IVMCC)) Q:'IVMCC  D  Q:'IVMFLG4
 .I +$G(DGREL("C",IVMCC))=DGPRI S IVMFLG4=0 K DGREL("C",IVMCC)
 K IVMCC
 Q
 ;
TRIGGER(IVMDA) ; Trigger logic for Spouse Address fields to update the Spouse
 ; Addr Last Update Date/Time' field.  The variable IVMSPFLG is set at
 ; the beginning of IVMCM2 to specify a Z10 spouse address update.
 ; A Z10 transmission should not allow the trigger to run.
 ; If IVMSPFLG does NOT exist then a manual update will be assumed. A
 ; manual update is the only change allowed by the trigger.
 ;
 ; INPUT
 ;   IVMDA: The IEN of the field that was changed to cause the trigger
 Q:$D(IVMSPFLG)
 N DGIEN,DATA
 S DATA(1.9)=$$NOW^XLFDT(),DGIEN=IVMDA
 I $$UPD^DGENDBS(408.13,.DGIEN,.DATA)
 Q
