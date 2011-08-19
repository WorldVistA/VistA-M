DGWPT1 ; SLC/KCM - Patient Lookup Functions (cont) ;3/1/01
 ;;5.3;Registration;**447**;Aug 13, 1993
 ;
SAVDFLT ; continued from DGWPT, save new default patient list
 N DAY,HOLDX S OK=1
 I $P(X,U)="P" D
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT LIST SOURCE",1,"P")
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT PROVIDER",1,"`"_$P(X,U,2))
 I $P(X,U)="T" D
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT LIST SOURCE",1,"T")
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT TEAM",1,"`"_$P(X,U,2))
 I $P(X,U)="S" D
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT LIST SOURCE",1,"S")
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT SPECIALTY",1,"`"_$P(X,U,2))
 I $P(X,U)="C" D
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT LIST SOURCE",1,"C")
 . F DAY="MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY","SUNDAY" D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT CLINIC "_DAY,1,"`"_$P(X,U,2))
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT CLINIC START DATE",1,$P($P(X,U,3),";"))
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT CLINIC STOP DATE",1,$P($P(X,U,3),";",2))
 ; SLC/PKS - 6/25/2001
 ; Added section to save clinic defaults for current day only:
 I $P(X,U)="CT" D
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT LIST SOURCE",1,"C")
 . S HOLDX=X
 . D NOW^%DTC D DW^%DTC S DAY=X S X=HOLDX
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT CLINIC "_DAY,1,"`"_$P(X,U,2))
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT CLINIC START DATE",1,$P($P(X,U,3),";"))
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT CLINIC STOP DATE",1,$P($P(X,U,3),";",2))
 I $P(X,U)="W" D
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT LIST SOURCE",1,"W")
 . D EN^XPAR(DUZ_";VA(200,","DGLP DEFAULT WARD",1,"`"_$P(X,U,2))
 I $P(X,U)="A" D DEL^XPAR(DUZ_";VA(200,","ORLP DEFAULT LIST SOURCE",1)
 Q
PRCARE(VAL,PATIENT)        ; return Primary Care info
 ; VAL=Primary Care Team^Primary Care Provider^Attending
 N PCT,PCP,ATT
 S PCT=$P($$OUTPTTM^SDUTL3(PATIENT,DT),U,2)
 S PCP=$P($$OUTPTPR^SDUTL3(PATIENT,DT),U,2)
 S ATT=$G(^DPT(PATIENT,.1041)) I ATT S ATT=$P($G(^VA(200,ATT,0)),U)
 S VAL=PCT_U_PCP_U_ATT
 Q
PCDETAIL(LST,PATIENT)   ; return Primary Care Detail information
 N ILST,X S ILST=0
 S X=$$OUTPTTM^SDUTL3(PATIENT,DT)
 I +X>0 D
 . S ILST=ILST+1,LST(ILST)="    Primary Care Team:  "_$P(X,U,2)
 . S ILST=ILST+1,LST(ILST)="                Phone:  "_$P($G(^SCTM(404.51,+X,0)),U,2)
 E  S ILST=ILST+1,LST(ILST)="No Primary Care Team Assigned."
 S ILST=ILST+1,LST(ILST)=" "
 S X=$$OUTPTPR^SDUTL3(PATIENT,DT)
 I +X>0 D
 . S ILST=ILST+1,LST(ILST)="Primary Care Provider:  "_$P(X,U,2)
 . S ILST=ILST+1,LST(ILST)="         Analog Pager:  "_$P($G(^VA(200,+X,.13)),U,7)
 . S ILST=ILST+1,LST(ILST)="        Digital Pager:  "_$P($G(^VA(200,+X,.13)),U,8)
 . S ILST=ILST+1,LST(ILST)="         Office Phone:  "_$P($G(^VA(200,+X,.13)),U,2)
 E  S ILST=ILST+1,LST(ILST)="No Primary Care Provider Assigned."
 S ILST=ILST+1,LST(ILST)=" "
 S X=$$OUTPTAP^SDUTL3(PATIENT,DT)
 I +X>0 D
 . S ILST=ILST+1,LST(ILST)="   Associate Provider:  "_$P(X,U,2)
 . S ILST=ILST+1,LST(ILST)="         Analog Pager:  "_$P($G(^VA(200,+X,.13)),U,7)
 . S ILST=ILST+1,LST(ILST)="        Digital Pager:  "_$P($G(^VA(200,+X,.13)),U,8)
 . S ILST=ILST+1,LST(ILST)="         Office Phone:  "_$P($G(^VA(200,+X,.13)),U,2)
 E  S ILST=ILST+1,LST(ILST)="No Associate Provider Assigned."
 S ILST=ILST+1,LST(ILST)=" "
 S X=$G(^DPT(PATIENT,.1041))
 I +X D
 . S ILST=ILST+1,LST(ILST)="  Attending Physician:  "_$P($G(^VA(200,+X,0)),U)
 . S ILST=ILST+1,LST(ILST)="         Analog Pager:  "_$P($G(^VA(200,+X,.13)),U,7)
 . S ILST=ILST+1,LST(ILST)="        Digital Pager:  "_$P($G(^VA(200,+X,.13)),U,8)
 . S ILST=ILST+1,LST(ILST)="         Office Phone:  "_$P($G(^VA(200,+X,.13)),U,2)
 Q
