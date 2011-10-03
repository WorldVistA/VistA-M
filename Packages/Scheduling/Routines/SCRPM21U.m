SCRPM21U ;ALB/PDR - POSITION REASSIGNMENT UTILITIES ; AUG 1998
 ;;5.3;Scheduling;**148,157**;Aug 13, 1993
 ;
PREVDAY(DAY)    ; GET PREVIOUS DAY
 N X,X1,X2
 S X1=DAY,X2=-1
 D C^%DTC
 Q X
 ;
PCPCASN(FASIEN,SCTP)    ; IS THIS A PRIMARY CARE to PRIMARY CARE ASSIGNMENT?
 ; FASIEN = Pointer to source Position assignment SCPT(404.43)
 ; SCTP   = Destination position pointer to Position DEF file SCTM(404.57)
 N SPPC,DPPC,STPC,SCST
 ; Exclude the case where source = destination team
 ;
 S SCST=$P($G(^SCPT(404.43,FASIEN,0)),U,2) ; pointer to position DEF file
 S SCST=$P($G(^SCTM(404.57,SCST,0)),U,2) ; pointer to team DEF file
 I SCST="" Q 0  ; this is really an error condition
 I SCST=$P($G(^SCTM(404.57,SCTP,0)),U,2) Q 0  ; source and dest teams are the same
 ;
 ; Both source and destination positions are (or will be) primary care.
 ;
 ; test source position is a pc position, and the new position is too
 S SPPC=$P($G(^SCPT(404.43,FASIEN,0)),U,5)>0 ; source position is primary care
 S DPPC=@SCFIELDA@(.05)>0 ; destination position is primary care
 S STPC=$$GETPOSTM(FASIEN)
 S STPC=$P($G(^SCPT(404.42,STPC,0)),U,8)=1 ; source team is primary care
 ; if source pos and dest pos are PC OR source team and dest pos are PC then is a pc to pc assignment
 Q (SPPC&DPPC)!(STPC&DPPC)
 ;
UPDATPOS(POSAIEN,SCERR) ; UPDATE EXISTING POSITION ASSIGNMENT PARAMETERS, AND ENSURE NO FUTURE DISCHARGE
 N SC,SCFLD,ENTFLD
 S ENTFLD=",.06,.07,"
 S SC($J,404.43,(+POSAIEN)_",",.08)=DUZ ; last edited by
 S SC($J,404.43,(+POSAIEN)_",",.09)=SCNOW ; last edit date/time
 S SC($J,404.43,(+POSAIEN)_",",.03)=SCACT ; set new activity date for existing position assgn
 S SC($J,404.43,(+POSAIEN)_",",.04)="" ; ensure no future discharge
 IF $D(SCFIELDA) D
 . S SCFLD=0
 . F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 .. Q:ENTFLD[","_SCFLD_","  ; don't want ENTRY user and ENTRY date time for edit
 .. S SC($J,404.43,(+POSAIEN)_",",SCFLD)=@SCFIELDA@(SCFLD)
 D FILE^DIE("","SC($J)",SCERR) ; update position assignment paramaeters
 I $D(@SCERR) S POSAIEN=0_U_POSAIEN
 Q
 ;
TMEXIST(DFN,SCTM,SCSD,TMAIEN) ;
 ; returns 1 if current/future assignment exists else 0
 ; conserves IEN of the des tm asgn if it exists
 N SCRESULT,SCSDT,SCX,SCTMLIST,SCTMERR
 S (SCRESULT,TMAIEN)=0
 ;
 ;;set date variables for $$tmpt
 S SCSDT("BEGIN")=$G(SCSD,DT)
 S SCSDT("END")=$$FMADD^XLFDT(SCSDT("BEGIN"),36500)
 ;
 ;;look for current asgn first
 S SCX=$$TMPT(1)
 S TMAIEN=$O(SCTMLIST("SCTM",SCTM,0))
 I +TMAIEN S SCRESULT=1 G TMXISTQ
 ;
 ;;look for nearest future legit asgn/dschrg
 S SCX=$$TMPT(0)
 I '+$O(SCTMLIST("SCTM",SCTM,0)) G TMXISTQ
 ;
 F  S TMAIEN=$O(SCTMLIST("SCTM",SCTM,TMAIEN)) Q:'TMAIEN  D
 .S SCX=$O(SCTMLIST("SCTM",SCTM,TMAIEN,0))
 .S SCX=$P(SCTMLIST(SCX),U,4,5)
 .Q:$P(SCX,U,2)<+SCX
 .S SCTMLIST("SCTM","BYDATE",+SCX,TMAIEN)=""
 .Q
 ;
 S SCX=$O(SCTMLIST("SCTM","BYDATE",""))
 I +SCX D
 .S TMAIEN=$O(SCTMLIST("SCTM","BYDATE",SCX,""))
 .S SCRESULT=1
 .Q
 ;
TMXISTQ S TMAIEN=+TMAIEN
 Q +SCRESULT
 ;
TMPT(SCX) ;
 S SCSDT("INCL")=SCX
 K SCTMLIST
 K SCTMERR
 Q $$TMPT^SCAPMC(DFN,"SCSDT","","SCTMLIST","SCTMERR")
 ;
DELPOS(DISIEN,POSAIEN)  ; DELETE a position
 ; DISIEN = SOURCE POSITION TO DISCHARGE
 ; POSAIEN = CURRENT DESTINATION POSITION IEN - USED JUST AS AN ERROR INDICATOR HERE
 S DIK="^SCPT(404.43,"
 S DA=DISIEN
 ;
 IF DIK]"",$D(@(DIK_DA_",0)")) D ^DIK
 E  S POSAIEN=0_U_POSAIEN
 Q
 ;
DISPOS(DISIEN,POSAIEN)  ; DISCHARGE a position
 ; DISIEN = SOURCE POSITION TO DISCHARGE
 ; POSAIEN = CURRENT DESTINATION POSITION IEN - USED JUST AS AN ERROR INDICATOR HERE
 N DISDAT
 S DISDAT=SCACT  ; init discharge date
 I $P($G(^SCPT(404.43,DISIEN,0)),U,3)'>$$PREVDAY(SCACT) S DISDAT=$$PREVDAY(SCACT)
 S STEC=$$INPTTP^SCAPMC(DFN,DISIEN,DISDAT,SCERR)
 I 'STEC S POSAIEN=0_U_POSAIEN
 Q
 ;
CREATPOS(POSAIEN,TMAIEN)        ; CREATE A POSITION
 N SCIEN
 S POSAIEN="" ; initialize position IEN
 IF $D(SCFIELDA) D
 . S SCFLD=0
 . F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 .. S SC($J,404.43,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 S SC($J,404.43,"+1,",.01)=TMAIEN
 S SC($J,404.43,"+1,",.02)=SCTP
 S SC($J,404.43,"+1,",.03)=SCACT
 D UPDATE^DIE("","SC($J)","SCIEN",SCERR) ; create new position
 IF $D(@SCERR) K SCIEN
 ELSE  D
 . S POSAIEN=+$G(SCIEN(1))
 . S SCNEWTP=1
 . D AFTERTP^SCMCDD1(POSAIEN)
 Q
 ;
DELTEAM(TMAIEN) ; DELETE A TEAM ASSIGNMENT
 S DIK="^SCPT(404.42,"
 S DA=TMAIEN
 ;
 IF DIK]"",$D(@(DIK_DA_",0)")) D ^DIK
 E  S TMAIEN=0_U_TMAIEN
 Q
 ;
DISTEAM(TMAIEN) ; DISCHARGE A TEAM ASSIGNMENT
 ; TMAIEN = SOURCE TEAM IEN
 N DISDAT,SCPREVDT,SCNODE
 S DISDAT=SCACT  ; init discharge date
 ; discharge for previous day if assignment date prior to today
 I $P($G(^SCPT(404.42,TMAIEN,0)),U,9)'>$$PREVDAY(SCACT) S DISDAT=$$PREVDAY(SCACT)
 N SCTEC
 S SCTEC=$$INPTTM^SCAPMC(DFN,TMAIEN,DISDAT,SCERR) ; Discharge from team Assignments
 I 'SCTEC S TMAIEN=0_U_TMAIEN
 Q
 ;
CREATETM(DFN,SCTMTO,SCACT,TMAIEN)       ; CREATE A TEAM ASSIGNMENT
 N SCTM,SCIEN
 S TMAIEN="+1,"
 ; set team assignment type (i.e PC (1) or non-PC (99))
 S:$D(@SCFIELDA@(.05)) SCTM($J,404.42,TMAIEN,.08)=$G(@SCMAINA@(.08),$S(@SCFIELDA@(.05):1,1:99))
 ; set team user entering
 S:$D(@SCFIELDA@(.06)) SCTM($J,404.42,TMAIEN,.11)=$G(@SCMAINA@(.11),@SCFIELDA@(.06))
 ; set team Date/time entered
 S:$D(@SCFIELDA@(.07)) SCTM($J,404.42,TMAIEN,.12)=$G(@SCMAINA@(.12),@SCFIELDA@(.07))
 ; set team last edited by
 ;S:$D(@SCFIELDA@(.08)) SCTM($J,404.42,TMAIEN,.13)=$G(@SCMAINA@(.13),@SCFIELDA@(.08))
 ; set team date/time last edited
 ;S:$D(@SCFIELDA@(.09)) SCTM($J,404.42,TMAIEN,.14)=$G(@SCMAINA@(.14),@SCFIELDA@(.09))
 S SCTM($J,404.42,TMAIEN,.01)=DFN
 S SCTM($J,404.42,TMAIEN,.02)=SCACT
 S SCTM($J,404.42,TMAIEN,.03)=SCTMTO
 D UPDATE^DIE("","SCTM($J)","SCIEN",SCERR) ; new entry
 IF $D(@SCERR) D
 . K SCIEN
 . S TMAIEN=""
 ELSE  D
 . S TMAIEN=$G(SCIEN(1))  ; new assignment record set up
 . S SCNEWTM=1
 . D AFTERTM^SCMCDD1(TMAIEN)
 Q
 ;
TMACTIV(TMAIEN,PCPOS)   ; CHANGE FUTURE ACTIVE DATE TO CURRENT DATE
 ; PCPOS - flag that indicates whether or not team should be activated as a PC Team
 ;  the team definition is assumed to support PC service at this point
 ; also remove future discharge date if present
 S SC($J,404.42,(+TMAIEN)_",",.14)=SCNOW ; date time last edited
 S SC($J,404.42,(+TMAIEN)_",",.13)=DUZ ; last edited by
 S SC($J,404.42,(+TMAIEN)_",",.02)=SCACT  ; assigned date
 S SC($J,404.42,(+TMAIEN)_",",.09)=""     ; discharge date
 I PCPOS S SC($J,404.42,(+TMAIEN)_",",.08)=1 ;
 D FILE^DIE("","SC($J)",SCERR) ; update TEAM assignment
 I $D(@SCERR) S TMAIEN=0_U_TMAIEN
 Q
 ;
XALLPOS(FASIEN,POSAIEN) ; DISCHARGE ALL POSITIONS FROM THE "from" TEAM
 ; FASIEN = source position assignment IEN
 ; POSAIEN = destination position assignment IEN, used just for error reporting here
 ; this only occurs when the "from" pos and "to" pos are both Primary care,
 ; or the "from" team is PC and the "to" pos is PC.
 ; Rational is that a patient can't have more than one PC team
 ;
 ; use FASIEN to get team assignment, then find all positions for this team assignment,
 ; and discharge them
 N POSASGN,TMASGN,DISDAT,SCX,SCFLAG
 S DISDAT=SCACT  ; init discharge date
 ; discharge for previous day if assignment date prior to today
 S SCX=$$PREVDAY(SCACT)
 I $P($G(^SCPT(404.43,FASIEN,0)),U,3)'>SCX S DISDAT=SCX
 S SCFLAG=0
 S TMASGN=+$P($G(^SCPT(404.43,FASIEN,0)),U,1)
 I TMASGN D 
 .S POSASGN=0
 .F  S POSASGN=$O(^SCPT(404.43,"B",TMASGN,POSASGN)) Q:POSASGN=""  D
 ..S SCX=+$P($G(^SCPT(404.43,POSASGN,0)),U,4)       ;already discharged?
 ..I SCX,SCX<SCACT Q                                ;leave past alone!
 ..K @SCERR
 ..S STEC=$$INPTTP^SCAPMC(DFN,POSASGN,DISDAT,SCERR) ;discharge position
 ..I $D(@SCERR) S SCFLAG=1
 ..Q
 .Q
 I ('TMASGN)!(SCFLAG) S POSAIEN=0_U_POSAIEN
 Q
 ;
GETPOSTM(POSAIEN)       ; RETURN THE TEAM ASSIGNMENT FOR A POSITION
 Q $P($G(^SCPT(404.43,POSAIEN,0)),U,1)
 ;
FUPOSASN(POSAIEN,SCACT) ; IS THIS A FUTURE POSITION ASSIGNMENT?
 Q $P($G(^SCPT(404.43,POSAIEN,0)),U,3)>SCACT
 ;
FUTMASN(TMAIEN,SCACT)   ; IS THIS A FUTURE TEAM ASSIGNMENT?
 Q $P($G(^SCPT(404.42,TMAIEN,0)),U,2)>SCACT
 ;
FUTTMDIS(TMAIEN,SCACT)  ; IS THERE A FUTURE TEAM DISCHARGE?
 Q $P($G(^SCPT(404.42,TMAIEN,0)),U,9)>SCACT
 ;
DPOSPROB(SCPTTPA,SCACT) ; handle disposition of existing destination POSITION
 I $$FUPOSASN(.SCPTTPA,SCACT) D  Q:'SCPTTPA  ; BAIL OUT
 . D DELPOS(SCPTTPA,.SCPTTPA) ; DELETE future non-PC position assignment
 . I 'SCPTTPA D ERROR^SCRPMPSP("Unable to DELETE non-PC position assignment for existing dest team",SCPTTPA,20) Q   ; BAIL OUT
 ELSE  D
 . D DISPOS(SCPTTPA,.SCPTTPA)  ; else if current non-pc assignment discharge it
 . I 'SCPTTPA D ERROR^SCRPMPSP("Unable to discharge non-PC position assignment with existing dest team",SCPTTPA,25) Q   ; BAIL OUT
 Q 'SCPTTPA
 ;
DTMPROB(SCPTTMA,SCACT)  ; HANDLE DISPOSITION OF EXISTING DESTINATION TEAM
 I $$FUTMASN(.SCPTTMA,SCACT) D  Q:'SCPTTMA  ; BAIL OUT
 . D DELTEAM(.SCPTTMA) ; DELETE future dest NON-PC team assign
 . I 'SCPTTMA D ERROR^SCRPMPSP("Unable to DELETE non-PC team assignment for existing dest team",SCPTTMA,30)
 ELSE  D 
 . D DISTEAM(.SCPTTMA)  ; discharge current non-pc team assignment
 . I 'SCPTTMA D ERROR^SCRPMPSP("Unable to discharge non-PC team assignment for existing dest team",SCPTTMA,35) Q   ; BAIL OUT
 Q 'SCPTTMA
