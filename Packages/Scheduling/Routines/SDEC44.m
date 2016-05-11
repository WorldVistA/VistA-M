SDEC44 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ; Get primary provider for a visit
 ;  VIEN = Visit IEN
 ;  Returns Provider IEN ^ Provider Name ^ V Provider IEN
PRIPRV(VIEN) ;EP
 N X,Y,RET
 Q:'VIEN $$ERR("Invalid visit IEN.")
 S X=0,RET=""
 F  S X=$O(^AUPNVPRV("AD",VIEN,X)) Q:'X  D  Q:RET>0
 .S Y=$G(^AUPNVPRV(X,0))
 .S:$P(Y,U,4)="P" RET=$P(Y,U)_U_$P($G(^VA(200,+Y,0)),U)_U_X
 Q RET
 ;
 ; Set primary provider
 ;  INP = Visit IEN [1] ^ Patient IEN [2] ^ Provider IEN [3] ^ Primary/Secondary (P/S) [4] ^
 ;        Force Conversion to Primary (Y/N) [5]
SETVPRV(RET,INP) ;
 N X,VIEN,VPRV,DFN,PRV,PRI,FORCE,PRIPRV,IENS,FDA,FNUM
 S RET="",FNUM=$$FNUM
 S VIEN=+INP
 S DFN=$P(INP,U,2)
 S RET=$$CHKVISIT^SDECUTL(VIEN,DFN)
 Q:RET
 S PRV=$P(INP,U,3)
 S PRI=$P(INP,U,4)
 S:'$L(PRI) PRI="S"
 S FORCE=$P(INP,U,5)
 S FORCE=FORCE!(FORCE="Y")
 S PRIPRV=$$PRIPRV(VIEN)
 I PRIPRV>0,PRI="P",+PRIPRV'=PRV D  Q:RET
 .I FORCE S FDA(FNUM,$P(PRIPRV,U,3)_",",.04)="S"
 .E  S RET=$$ERR("SDEC44",$P(PRIPRV,U,2))
 S (X,VPRV)=0
 F  S X=$O(^AUPNVPRV("AD",VIEN,X)) Q:'X  D  Q:VPRV
 .S:$P($G(^AUPNVPRV(X,0)),U)=PRV VPRV=X
 S IENS=$S(VPRV:VPRV_",",1:"+1,")
 S FDA=$NA(FDA(FNUM,IENS))
 S @FDA@(.01)=PRV
 S @FDA@(.02)=DFN
 S @FDA@(.03)=VIEN
 S @FDA@(.04)=PRI
 S RET=$$UPDATE^SDECUTL(.FDA)
 Q
 ; Return V File #
FNUM() Q 9000010.06
 ;
GETVPRV(BGOY,VPRV)  ;return data from the V PROVIDER file
 ;GETVPRV(BGOY,VPRV)  external parameter tag is in SDEC
 ;  .BGOY   = returned pointer to list of V PROVIDER data
 ;   VPRV    = V PROVIDER code - pointer to ^AUPNVPRV
 ; called by SDEC GETVPRV
 N BGOI,BGONOD,BGOVP
 S BGOI=0
 K ^TMP("SDEC",$J)
 S BGOY="^TMP(""SDEC""_$J_"")"""
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 ;check for valid V PROVIDER
 I '+VPRV D ERR("SDEC44: Invalid V Provider ID") Q
 I '$D(^AUPNVPRV(VPRV,0)) D ERR("SDEC44: Invalid V Provider ID") Q
 S BGONOD=^AUPNVPRV(VPRV,0)
 ;                        1                    2                  3                  4           5
 S ^TMP("SDEC",$J,0)="I00020V_PROVIDER_IEN^I00020PROVIDER_IEN^I00020PATIENT_NAME^T00030VISIT^T00030PROVIDER_STATUS"_$C(30)
 S BGOVP=VPRV_U   ; V_PROVIDER_IEN
 S BGOVP=BGOVP_$P(BGONOD,U,1)_U  ; PROVIDER_IEN
 S BGOVP=BGOVP_$P(BGONOD,U,2)_U  ; PATIENT_NAME
 S BGOVP=BGOVP_$P(BGONOD,U,3)_U  ; VISIT
 S BGOVP=BGOVP_$P(BGONOD,U,5)    ; PROVIDER_STATUS
 S BGOI=BGOI+1
 S ^TMP("SDEC",$J,BGOI)=BGOVP
 S BGOI=BGOI+1
 S ^TMP("SDEC",$J,BGOI)=$C(30)
 S BGOI=BGOI+1
 S ^TMP("SDEC",$J,BGOI)=$C(31)
 Q
 ;
ERROR ;
 D ERR("Error")
 Q
 ;
ERR(ERRNO) ;Error processing
 S BGOI=$G(BGOI)+1
 S ^TMP("SDEC",$J,BGOI)=ERRNO_$C(30)
 S BGOI=BGOI+1
 S ^TMP("SDEC",$J,BGOI)=$C(31)
 Q
