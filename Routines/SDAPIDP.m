SDAPIDP ;ALB/MTC - Outpatient API/Dispositions ; 03 MAY 1996 11:30 am
 ;;5.3;Scheduling;**27,132**;08/13/93
 ;
EN(DFN,SDT,SDCL,SDUZ,SDMODE,SDVIEN) ; -- check api for appts
 N SDDA,SDOE
 S SDOE=0
 ;
 ; -- file check-out data ; get encount ien
 S SDOE=$$FILE(DFN,SDT,SDCL,SDUZ,SDMODE,$G(SDVIEN))
 ;
ENQ Q SDOE
 ;
 ;
FILE(DFN,SDT,SDCL,SDUZ,SDMODE,SDVIEN) ; -- file data
 N SDATA,SDHDL,SDOE,SDCOMPF,SDLOG
 S SDOE=""
 ;
 ; -- get encounter ien ; error if none returned
 S SDOE=$$GETDISP^SDVSIT2(DFN,SDT,$G(SDVIEN))
 I 'SDOE D ERRFILE^SDAPIER(110) G FILEQ
 ;
 ; -- log user and date/time data
 D LOGDATA^SDAPIAP(SDOE)
 ;
 ; -- process data
 D FILE^SDAPICO(SDOE,SDUZ)
 ;
 ; -- update check-out completion
 D EN^SDCOM(SDOE,SDMODE,1,.SDCOMPF)
 ;
FILEQ Q SDOE
 ;
