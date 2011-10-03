IVMUM4 ;ALB/SEK - ADD NEW INDIVIDUAL ANNUAL INCOME FILE ENTRIES ; 6/12/09 12:55pm
 ;;2.0;INCOME VERIFICATION MATCH;**1,8,17,115,139**;21-OCT-94;Build 3
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; this routine will add entries to INDIVIDUAL ANNUAL INCOME file
 ; (408.21)
 ; 
 ; * A reference to this code in Vista was not discovered.  This may be dead code!
 ; *   IVM*2*115 updated EN1 so that Version 1 means test data returned on ZIC
 ; *   segments in a Z06 message will be processed for dependent children, if that
 ; *   information is ever added to Vista Z06 messages.  Additionally, the code remains
 ; *   in case analysis of Vista missed any reference to this routine.
 ;
 ; DFN    Patient file IEN
 ; DGPRI  Patient Relation IEN
 ; DGLY      Last Year
 ; DGINI     New Individual Annual Income IEN
 ; IVMSEG    ZIC record for veteran or spouse or dependent
 ; IVMMTIEN  Means Test IEN (#408.31)
 ; IVM0      408.21 0 node pieces 8-18
 ; IVM1             1 node pieces 1-3
 ; IVM2             2 node pieces 1-5
 ;
 N IVM0,IVM1,IVM2,IVMC
 S DGINI=$$ADDIN^DGMTU2(DFN,DGPRI,DGLY)
 ;
 ; if can't create stub notify site & IVM Center
 I DGINI'>0 D  Q
 . S (IVMTEXT(6),HLERR)="Can't create stub for file 408.21"
 . D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 . S IVMFERR=""
 ;
 ; if can't lock stub notify site & IVM Center
 L +^DGMT(408.21,DGINI):10 E  D  Q
 .S (IVMTEXT(6),HLERR)="Can't update stub for file 408.21"
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 .S IVMFERR=""
 ;
EN1 ; add 1 node for vet & child
 ; add 2 node for vet, spouse & (when VR 1) child
 F IVMC=3:1:12 S:$P(IVMSEG,"^",IVMC)=HLQ $P(IVMSEG,"^",IVMC)=""
 S IVM0=$P(IVMSEG,"^",3,12)
 I IVMSPCHV'="S" F IVMC=13:1:15 S:$P(IVMSEG,"^",IVMC)=HLQ $P(IVMSEG,"^",IVMC)=""
 I IVMSPCHV'="S" S IVM1=$P(IVMSEG,"^",13,15)
 ;IVM*2.0*115
 S $P(^DGMT(408.21,DGINI,0),"^",8,17)=IVM0,DA=DGINI S:IVMSPCHV'="S" ^(1)=IVM1
 N MTVERS
 S MTVERS=$S(+$G(IVMMTIEN):+$P($G(^DGMT(408.31,$G(IVMMTIEN),2)),"^",11),1:0)
 I +$G(MTVERS)=0 D
 . I IVMSPCHV'="C" F IVMC=16:1:20 S:$P(IVMSEG,"^",IVMC)=HLQ $P(IVMSEG,"^",IVMC)=""
 . I IVMSPCHV'="C" S IVM2=$P(IVMSEG,"^",16,20)
 . S:IVMSPCHV'="C" ^DGMT(408.21,DGINI,2)=IVM2
 E  D
 . F IVMC=16,18,19 S:$P(IVMSEG,"^",IVMC)=HLQ $P(IVMSEG,"^",IVMC)=""
 . S IVM2=$P(IVMSEG,"^",16)_"^^"_$P(IVMSEG,"^",18,19)
 . S ^DGMT(408.21,DGINI,2)=IVM2
 S DIK="^DGMT(408.21,"
 D IX1^DIK L -^DGMT(408.21,DGINI)
 K DA,DIK
 Q
