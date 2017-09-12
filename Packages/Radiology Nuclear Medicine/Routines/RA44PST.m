RA44PST ;HOIFO/SWM-Post install ;1/20/04  11:52
 ;;5.0;Radiology/Nuclear Medicine;**44**;Mar 16, 1998
 ; This is the post-install routine for patch RA*5.0*44
 ;
 ; This routine may be deleted after the patch is installed.
 ;
 ; supported IA 1472 allows adding record to file 19.2
 ;
 I '$D(XPDNM)#2 D EN^DDIOL("This entry point must be called from the KIDS installation -- Nothing Done.",,"!!,$C(7)") Q
 N RABY,RADT,RAIEN19,RAWHEN,RAFLAG,RAERR,RAR,RATXT
 N D1,M1,Y1,M2,Y2
 S RATXT(1)=""
 S RAIEN19=$O(^DIC(19,"B","RA PERFORMIN TASKLM",0))
 I 'RAIEN19 D  Q
 . S RATXT(2)="** Option RA PERFORMIN TASKLM isn't installed into file 19, so nothing done. **"
 . D MES^XPDUTL(.RATXT)
 . Q
 ;
 D OPTSTAT^XUTMOPT("RA PERFORMIN TASKLM",.RAR)
 I $P($G(RAR(1)),U) D  Q
 . S RATXT(2)="** Option RA PERFORMIN TASKLM is already scheduled, so nothing done. **"
 . D MES^XPDUTL(.RATXT)
 . Q
 ;
 ; add option to file 19.2 for automatic rescheduling
 I '$O(^DIC(19.2,"B",RAIEN19,0)) D
 . S RAFLAG="L"
 . S RATXT(2)="** Installing RA PERFORMIN TASKLM into file 19.2. **"
 . D MES^XPDUTL(.RATXT)
 . D SET15
 . D RESCH^XUTMOPT("RA PERFORMIN TASKLM",RAWHEN,,RABY,RAFLAG,.RAERR)
 . Q
 ;
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO=""
 S ZTRTN="SCHED^RA44PST"
 S ZTDESC="RA*5.0*44 Schedule RA PERFORMIN TASKLM on 15th"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,2,0) ;add 2 minutes to 'now'
 D ^%ZTLOAD S RATXT(1)=" "
 S RATXT(2)="RA*5.0*44 Scheduling RA PERFORMIN TASKLM in background."
 S:$G(ZTSK)>0 RATXT(3)="Task: "_ZTSK_"."
 S RATXT(4)=" "
 D MES^XPDUTL(.RATXT)
 Q
SCHED ; schedule RA PERFORMIN TASKLM to run on 15th
 N RABY,RADT,RAIEN19,RAWHEN,RAFLAG,RAERR,RAR
 N D1,M1,Y1,M2,Y2
 S ZTREQ="@"
 D OPTSTAT^XUTMOPT("RA PERFORMIN TASKLM",.RAR)
 I $P($G(RAR(1)),U) Q  ; option already tasked
 I '$D(RAR(1)) Q  ; option not in file 19.2
 D SET15
 D RESCH^XUTMOPT("RA PERFORMIN TASKLM",RAWHEN,,RABY,,.RAERR)
 Q
SET15 ; set some variables for scheduling task
 S Y1=$E(DT,1,3),M1=$E(DT,4,5),D1=$E(DT,6,7)
 S Y2=$S(M1="12":Y1+1,1:Y1),M2=$S(M1="12":"01",1:M1+1)
 S:$L(M2)=1 M2="0"_M2
 D:D1=15 TODAY D:D1<15 THISM D:D1>15 NEXTM
 S RAWHEN=$$FMADD^XLFDT(RADT,,,5) ; add 5 mins to scheduled date
 S RABY="1M(15)" ; every month on the 15th day
 Q
TODAY ; today is the 15th
 S RADT=$$NOW^XLFDT
 Q
THISM ; this month on the 15th
 S RADT=Y1_M1_"15."_$P(($$NOW^XLFDT),".",2)
 Q
NEXTM ; next month on the 15th
 S RADT=Y2_M2_"15."_$P(($$NOW^XLFDT),".",2)
 Q
