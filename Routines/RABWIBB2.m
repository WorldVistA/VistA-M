RABWIBB2 ;HOIFO/MDM - Radiology Billing Awareness ;12/20/04 12:55am
 ;;5.0;Radiology/Nuclear Medicine;**57,70**;Mar 16, 1998;Build 7
 ; $$GETACCT^IBBAPI uses DBIA #4664
 ; Calls referencing PFSS Account Referance (field 90 file #75.1)) uses DBIA #4741
 ;
 Q
GA(RAOIFN) ; Get Account Reference
 ;
 N RAMISDAT,RAPRO,RAITYP,RADAT,RADX,S1,S2,P1,IBBDFN,IBBPV1,IBBPV2
 N IBBDG1,IBBPR1,IBBZCL,RABADAT,RABAFLD,RAORD0
 ; Called from FB^RABWIBB
 ; Define remaining (Required) IBB Variables and Arrays
 ;
 ; Radiology Orders Data
 S RAORD0=$G(^RAO(75.1,RAOIFN,0))
 S IBBDFN=$P(RAORD0,U,1)                           ; PATIENT NAME Pointer to patient file #2
 S IBBPV1(2)=$P(RAORD0,U,4)                        ; PATIENT STATUS I(npatient) O(utpatient)
 S IBBPV1(3)=$P(RAORD0,U,20)
 S IBBPV1(3)=$P($G(^RA(79.1,IBBPV1(3),0)),U,1)     ; IMAGING LOCATION
 S IBBPV1(7)=$P(RAORD0,U,14)                       ; REQUESTING PHYSICIAN
 S IBBPV1(44)=$P(RAORD0,U,21),IBBPV2(8)=IBBPV1(44) ; DATE DESIRED
 S IBBDG1(1,6)="A"                                 ; DIAGNOSIS TYPE
 ;
 ; CPT Code
 S RAPRO=$P(RAORD0,U,2) ; Procedure Pointer
 S RAMISDAT=^RAMIS(71,+RAPRO,0) ; Procedure Data
 S IBBPR1(3)=$P(RAMISDAT,U,9) ; Isolate CPT Code
 ; If there is no CPT Code then get the procedure name instead.
 I IBBPR1(3)="" S IBBPR1(4)=$P(RAMISDAT,U,1) K IBBPR1(3)
 ;
 ; ABBREVIATION FOR TYPE OF IMAGING
 S RAITYP=$P(RAORD0,U,3) ; Image Type File Pointer
 S RADAT=^RA(79.2,+RAITYP,0) ; Image Type File Data
 S IBBPR1(6)=$P(RADAT,U,3) ; Image Type Abbreviation
 ;
 ; CLINICAL INDICATORS RELATED TO PRIMARY DX
 ; Initialize gathering process variables.
 S S1="",RADX(92)=3,RADX(93)=1,RADX(94)=2,RADX(95)=4,RADX(96)=5
 S RADX(97)=6,RADX(99)=7,RADX(100)=8
 S RABADAT=$G(^RAO(75.1,+RAOIFN,"BA"))
 S IBBDG1(1,3)=$P(RABADAT,U,1)                     ; PRIMARY DIAGNOSIS CODE
 S IBBZCL=""
 F P1=92:1:97,99,100 S RABAFLD=$P($P(^DD(75.1,P1,0),U,4),";",2) I $P(RABADAT,U,RABAFLD)]"" D
 . S S1=S1+1
 . ; IBBZCL(n,2)=clin. Indic. type, IBBZCL(n,3)={0,1,null}
 . S IBBZCL(S1,2)=RADX(P1)
 . S IBBZCL(S1,3)=$P(RABADAT,U,RABAFLD)
 . Q
 ;
 ; Get Account Reference
 S RACCOUNT=$$GETACCT^IBBAPI(IBBDFN,IBBARFN,IBBEVENT,IBBAPLR,.IBBPV1,.IBBPV2,.IBBPR1,.IBBDG1,.IBBZCL,"",+RAOIFN)
 Q
STOR751(RAOIFN) ; Store acct ref no. in file 75.1, field 90, for this order
 ;
 N RAFDA
 S RAFDA(75.1,+RAOIFN_",",90)=RACCOUNT
 D FILE^DIE("K","RAFDA")
 Q
