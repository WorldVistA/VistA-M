SDEC08A ;ALB/PWC - VISTA SCHEDULING RPCS ;May 7, 2020@11:20
 ;;5.3;Scheduling;**745**;Aug 13, 1993;Build 40
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ; called from ^SDEC08 - routine was too big and had to split *745
 ;
AVUPDT(SDECSCD,SDECSTART,SDECLEN) ;Update Clinic availability
 ;See SDCNP0
 N HSI,I,S,SB,SD,SDDIF,SI,SL,SS,ST,STARTDAY,STR,X,Y
 S (SD,S)=SDECSTART
 S I=SDECSCD
 Q:'$D(^SC(I,"ST",SD\1,1))
 S SL=^SC(I,"SL"),X=$P(SL,U,3),STARTDAY=$S($L(X):X,1:8),SB=STARTDAY-1/100,X=$P(SL,U,6),HSI=$S(X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4),STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2)
 S SL=SDECLEN
 S S=^SC(I,"ST",SD\1,1),Y=SD#1-SB*100,ST=Y#1*SI\.6+(Y\1*SI),SS=SL*HSI/60
 I Y'<1 F I=ST+ST:SDDIF S Y=$E(STR,$F(STR,$E(S,I+1))) Q:Y=""  S S=$E(S,1,I)_Y_$E(S,I+2,999),SS=SS-1 Q:SS'>0
 S ^SC(SDECSCD,"ST",SD\1,1)=S
 Q
 ;
APCAN(SDECZ,SDECLOC,SDECDFN,SDECSD,SDECAPTID,SDECLEN) ;
 ;Cancel appointment for patient SDECDFN in clinic SDECSC1 at time SDECSD
 N SDECPNOD,SDECC,DA,DIE,DPTST,DR,%H
 ;save data into SDEC APPOINTMENT in case of un-cancel (status & appt length)
 S SDECPNOD=^DPT(SDECPATID,"S",SDECSD,0)
 S DPTST=$P(SDECPNOD,U,2)
 S DIE=409.84
 S DA=SDECAPTID
 S DR=".17///"_DPTST_";"_".18///"_SDECLEN
 D ^DIE
 S SDECC("PAT")=SDECDFN
 S SDECC("CLN")=SDECLOC
 S SDECC("TYP")=SDECTYP
 S SDECC("ADT")=SDECSD
 S %H=$H D YMD^%DTC
 S SDECC("CDT")=SDECDATE   ;X+%
 S SDECC("NOT")=SDECNOT
 S:+SDECCR SDECC("CR")=SDECCR
 S SDECC("USR")=SDUSER
 S SDECZ=$$CANCEL^SDEC08(.SDECC)   ;PWC - changed to call routine SDEC08, code was previously in that routine before split *745
 Q
