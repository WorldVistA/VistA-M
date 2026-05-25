DGPMV36 ;ALB/MIR - TREATING SPECIALTY TRANSFER, CONTINUED ; 8/6/04 10:17am
 ;;5.3;Registration;**1104,1117**;Aug 13, 1993;Build 32
 ; Reference to NEWEOC^PXCOMPACT, $$ASC^PXCOMPACT, $$GETEOCSEQ^PXCOMPACT, and $$GETSTDT^PXCOMPACT in ICR #7327
 ;
 I '$P(DGPMA,"^",9) S DGPMA="",DIK="^DGPM(",DA=DGPMDA D ^DIK K DIK W !,"Incomplete Treating Specialty Transfer...Deleted"
 Q
 ;
DICS ; -- check that it is a PROVIDER/SPECIALTY change
 S DGER=DGPMTYP'=20
 Q
 ;
ONLY ; -- determine if there is only one 'specialty xfr' type mvt
 N C,I S C=0
 F I=0:0 S I=$O(^DG(405.1,"AT",6,I)) Q:'I  I $D(^DG(405.1,I,0)),$P(^(0),"^",4) S C=C+1,DGPMSPI=I I C>1 K DGPMSPI Q
 Q
 ;
SPEC ; -- entry point to add/edit specialty mvt when adding/editing
 ;    a physical mvt
 ;
 ;       Input:     Y = ifn of mvt file ^ auto add specialty entry(1)
 ;      Output:     Y = ifn of spec mvt
 ;      
 ;    Variable: DGPMPHY = physical mvt IFN ; DGPMPHY0 = 0th node
 ;              DGPMSP  = specialty mvt IFN
 ;
 Q:'$D(^DGPM(+Y,0))
 N DGPMT,DGPMN S DGPMPHY=+Y,DGPMPHY0=^DGPM(+Y,0),DGPMT=6,DGPMN=0
 S DGPMSP=$S($D(^DGPM("APHY",DGPMPHY)):$O(^(DGPMPHY,0)),1:"")
 I 'DGPMSP S Y=+$P(Y,"^",2) D ASK:'Y G SPECQ:'Y D NEW
 D EDIT:DGPMSP
 ;Only call if doing a transfer
 I DGPMUC'="ADMISSION",$G(PTF)'="",$$ELIG^DGCOMPACTELIG(DFN,"DGPMV36")'="NOT ELIGIBLE" D COMPACT
SPECQ S Y=DGPMSP K DGPMPHY,DGPMPHY0,DGPMSP Q
 ;
ASK ; -- ask user if they want to make a special mvt also
 W ! S DIR(0)="YA",DIR("A")="Do you wish to associate a 'facility treating specialty' transfer? "
 S DIR("?",1)="If you would like to associate a facility specialty"
 S DIR("?",2)="transfer with this physical movement then answer 'Yes'."
 S DIR("?")="Otherwise, answer with a 'No'."
 D ^DIR K DIR
 Q
 ;
COMPACT ; -- ask user if the treatment for the movement was for Acute Suicidal Crisis
 N %,CDATA,CMPMSG,DGVAL,ERROR,FIRSTMOVE,FLIP,MOVEDT,MOVESEQ,MVMTVAL,PTFPOINT,PXEOCNUM,PXEOCSEQ,PXIENS,SEQCHK,STARTDT,X,Y
 W !,"Was Treatment for Acute Suicidal Crisis" S %=$S($$ASC^PXCOMPACT(DFN)="Y":1,1:2) D YN^DICN I %=-1 W !,"Answer must be 'Yes' or 'No'" G COMPACT
 S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN),CDATA=""
 ; get EOC sequence number
 S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 I (%=2),$$ASC^PXCOMPACT(DFN)="Y" D  Q
 . ;before marking an episode as an error, determine if this movement is the last one in the multiple
 . I $$CHKMVMT^DGCOMPACT(DFN,PTF)=1,$D(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,PTFPOINT,1,"B",DGPMDA)) D
 . . I $$GETBENTYP^PXCOMPACT(DFN)="I" W !,"This action will end COMPACT Act benefit. Are you sure" S %=2 D YN^DICN I %'=1 G COMPACT
 . . ;set PTF 101 to a No
 . . D SETPTFFLG^DGCOMPACT(PTF,0)
 . . ;set 501 to No
 . . I DGPMY'="" D
 . . . S MOVESEQ=$O(^DGPT(PTF,"M","AM",DGPMY,"")) I MOVESEQ="" Q
 . . . D SETPTFMVMT^DGCOMPACT(PTF,"N",MOVESEQ)
 . . D REVERT^DGCOMPACT(DFN,PTF)
 . . ;I $$GETBENTYP^PXCOMPACT(DFN)="I" D REVERT^DGCOMPACT(DFN,PTF)
 . I $$CHKMVMT^DGCOMPACT(DFN,PTF)>1 D
 . . ;Remove movement from multiple in EOC file
 . . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 . . S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . . S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 . . S DA(3)=PXEOCNUM,DA(2)=PXEOCSEQ,DA(1)=PTFPOINT,DA=$$GETMVMT^DGCOMPACT(DFN,PTF,DGPMDA)
 . . S DIK="^PXCOMP(818,"_DA(3)_",10,"_DA(2)_",40,"_DA(1)_",1,"
 . . D ^DIK
 . . K DA,DIK
 . . I DGPMY'="" D
 . . . S MOVESEQ=$O(^DGPT(PTF,"M","AM",DGPMY,"")) I MOVESEQ="" Q
 . . . D SETPTFMVMT^DGCOMPACT(PTF,"N",MOVESEQ)
 . . ;reset start date (potentially) to earliest movement date
 . . S FIRSTMOVE=$O(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,PTFPOINT,1,"B","")) I FIRSTMOVE="" Q
 . . S MOVEDT=$P($P($G(^DGPM(FIRSTMOVE,0)),"^"),"."),STARTDT=$$GETSTDT^PXCOMPACT(DFN)
 . . I MOVEDT'=STARTDT D
 . . . ;check if there is a prior OP episode whose end date matches this episode's start date
 . . . S SEQCHK="B"
 . . . F  S SEQCHK=$O(^PXCOMP(818,PXEOCNUM,10,SEQCHK),-1) Q:SEQCHK=0  D
 . . . . I SEQCHK=PXEOCSEQ Q
 . . . . I $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",2)=STARTDT D
 . . . . . S $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",2)=MOVEDT,$P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",5)=MOVEDT
 . . . I $$GETBENTYP^PXCOMPACT(DFN)="O" D  Q
 . . . . ;update start date ONLY
 . . . . S PXIENS=PXEOCSEQ_","_PXEOCNUM_","
 . . . . I $G(MOVEDT)'="" S CDATA(818.01,PXIENS,.01)=MOVEDT
 . . . . D FILE^DIE("","CDATA")
 . . . D SETSTDT^PXCOMPACT(DFN,MOVEDT)
 ;if yes AND there's a current inpatient episode, add the movement to the episode and set the 501 to Yes
 I ($$ASC^PXCOMPACT(DFN)="Y"),($$GETBENTYP^PXCOMPACT(DFN)="I") D  Q
 . S (CMPMSG,CDATA(818.41))=""
 . ;Set the movement multiple
 . S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 . S PXIENS="?+1,"_PTFPOINT_","_PXEOCSEQ_","_PXEOCNUM_","
 . I $G(DGPMDA)'="" D
 . . S CDATA(818.41,PXIENS,.01)=DGPMDA
 . . D UPDATE^DIE("","CDATA","","CMPMSG")
 . ;set 501 to Yes
 . I DGPMY'="" D
 . . S MOVESEQ=$O(^DGPT(PTF,"M","AM",DGPMY,"")) I MOVESEQ="" Q
 . . D SETPTFMVMT^DGCOMPACT(PTF,"Y",MOVESEQ)
 . S ^UTILITY($J,"PXCOMPACT-TRANS")=""
 I %=1 D
 . W !,"THIS MOVEMENT WILL BEGIN THE COMPACT ACT BENEFIT. ARE YOU SURE" S %=2 D YN^DICN I %'=1 G COMPACT
 . S DGVAL=$S(%=1:1,1:0),MVMTVAL=$S(%=1:"Y",1:"N"),STARTDT="",ERROR="",FLIP=""
 . ;get start date of last valid episode
 . S STARTDT=$$GETSTDT^PXCOMPACT(DFN)
 . ;handle scenario where current episode is Outpatient
 . I $$ASC^PXCOMPACT(DFN)="Y",$P(^PXCOMP(818,PXEOCNUM,0),"^",3)="O",$$CHKMVMT^DGCOMPACT(DFN,PTF)="" D
 . . ;first check if date belongs to a different sequence (that possibly errored)
 . . S PXEOCSEQ=$O(^PXCOMP(818,PXEOCNUM,10,"B",$P(DGPMY,"."),""))
 . . I PXEOCSEQ'="",$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",6)="E" S ERROR=1
 . . ;same day processing, flip episode to Inpatient
 . . I $P(DGPMY,".")=STARTDT,'ERROR D
 . . . S $P(^PXCOMP(818,PXEOCNUM,0),"^",3)="I"
 . . . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",4)=$$FMADD^XLFDT($P(DGPMY,"."),29)
 . . . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",5)=""
 . . . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",7)="A"
 . . . D VISIT^PXCOMPACT(PTF,"I",PXEOCNUM,DFN)
 . . . S FLIP=1
 . . ;non-same day processing, end OP episode and create new IP episode using the date provided
 . . I $P(DGPMY,".")'=STARTDT,'ERROR D
 . . . D SETENDDT^PXCOMPACT(DFN,$P(DGPMY,"."),"PR")
 . . . D NEWEOC^PXCOMPACT(DFN,PTF,"I",$P(DGPMY,"."))
 . . . S FLIP=1
 . ;reopen episode of care if the transfer date is on the same date as an Entered in Error episode
 . I PXEOCNUM'="",$D(^PXCOMP(818,PXEOCNUM,10,"B",$P(DGPMY,"."))),'FLIP D
 . . D SETENDDT^PXCOMPACT(DFN,$P(DGPMY,"."),"PR")
 . . S PXEOCSEQ=$O(^PXCOMP(818,PXEOCNUM,10,"B",$P(DGPMY,"."),"")) I PXEOCSEQ="" Q
 . . D REOPNEOC^PXCOMPACT(PXEOCNUM,PXEOCSEQ,""),VISIT^PXCOMPACT(PTF,"I",PXEOCNUM,DFN)
 . ;Reopen episode of care if the PTF is already associated with an episode and not currently in a crisis
 . I PXEOCNUM'="",PXEOCSEQ'="",$D(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,"B",PTF)),$$ASC^PXCOMPACT(DFN)="N" D
 . . D REOPNEOC^PXCOMPACT(PXEOCNUM,PXEOCSEQ,STARTDT)
 . ;otherwise start a new episode
 . I $$ASC^PXCOMPACT(DFN)="N" D NEWEOC^PXCOMPACT(DFN,PTF,"I",$P(DGPMY,"."))
 . D SETPTFFLG^DGCOMPACT(PTF,DGVAL)
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 . S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . S (CMPMSG,CDATA(818.41))=""
 . ;Set the movement multiple
 . S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 . S PXIENS="?+1,"_PTFPOINT_","_PXEOCSEQ_","_PXEOCNUM_","
 . I $G(DGPMDA)'="" D
 . . S CDATA(818.41,PXIENS,.01)=DGPMDA
 . . D UPDATE^DIE("","CDATA","","CMPMSG")
 . S ^UTILITY($J,"PXCOMPACT-TRANS")=""
 . ;set 501 to Yes
 . I DGPMY'="" D
 . . S MOVESEQ=$O(^DGPT(PTF,"M","AM",DGPMY,"")) I MOVESEQ="" Q
 . . D SETPTFMVMT^DGCOMPACT(PTF,"Y",MOVESEQ)
 Q
 ;
NEW ; -- add a specialty mvt
 S X=DGPMPHY0,Y=+X_U_DGPMT_U_$P(X,U,3),$P(Y,U,14)=$P(X,U,14),$P(Y,U,24)=DGPMPHY
 S X=+X,DGPM0ND=Y D NEW^DGPMV3
 S DGPMSP=$S(+Y>0:+Y,1:"") S DGPMN=(+Y>0)
 I DGPMSP,$P(DGPMPHY0,"^",2)=1,$P(DGPMPHY0,"^",10)]"" S DR="99///"_$P(DGPMPHY0,"^",10),DA=DGPMSP,DIE="^DGPM(" D ^DIE
 K DIE,DIC,DA,DR,DGPM0ND
 Q
EDIT ; -- edit specialty mvt
 N DGPMX,DGPMP
 I DGPMN S (DGPMP,^UTILITY("DGPM",$J,6,DGPMSP,"P"))="",DIE("NO^")=""
 I 'DGPMN S (DGPMP,^UTILITY("DGPM",$J,6,DGPMSP,"P"))=^DGPM(DGPMSP,0)
 S Y=DGPMSP D PRIOR
 S DGPMN=(+DGPMP=+DGPMPHY0) ;set to 1 no dt/time change to bypass x-refs
 S DGPMX=+DGPMPHY0,DA=DGPMSP,DIE="^DGPM(",DR="[DGPM SPECIALTY TRANSFER]"
 K DQ,DG D ^DIE
 S ^UTILITY("DGPM",$J,6,DGPMSP,"A")=$S($D(^DGPM(DGPMSP,0)):^(0),1:"")
 S Y=DGPMSP D AFTER
 Q
 ;
PRIOR ; -- set special 'prior' nodes for event driver
 I DGPMN S (^UTILITY("DGPM",$J,6,Y,"DXP"),^("PTFP"))=""
 I 'DGPMN S X=$P($S($D(^DGPM(Y,"DX",0)):^(0),1:""),"^",3,4),X=X_$S($D(^(1,0)):$E(^(0),1,245-$L(X)),1:""),^UTILITY("DGPM",$J,6,Y,"DXP")=X,^UTILITY("DGPM",$J,6,Y,"PTFP")=$S($D(^DGPM(Y,"PTF")):^("PTF"),1:"")
 Q
 ;
AFTER ; -- set special 'after' nodes for event driver
 S X=$P($S($D(^DGPM(Y,"DX",0)):^(0),1:""),"^",3,4),X=X_$S($D(^(1,0)):$E(^(0),1,245-$L(X)),1:""),^UTILITY("DGPM",$J,6,Y,"DXA")=X,^UTILITY("DGPM",$J,6,Y,"PTFA")=$S($D(^DGPM(Y,"PTF")):^("PTF"),1:"")
 Q
