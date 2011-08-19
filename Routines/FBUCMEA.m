FBUCMEA ;WOIFO/SAB-UNAUTHORIZED CLAIM MAIN MENU ENTRY ACTION ;12/17/2001
 ;;3.5;FEE BASIS;**38**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N DFN,DIR,FBDA,FBDT,FBEXP,FBFR,FBO,FBOUT,FBPG,FBTO,FBVET,FBX,FBY
 ;
 ; gather data
 N VADM,X,Y
 K ^TMP("FBEX",$J)
 S FBTO=$$FMADD^XLFDT(DT,6)
 F FBO=10,55 D
 . S FBDT=-(FBTO+.1)
 . F  S FBDT=$O(^FB583("AES",FBO,FBDT)) Q:FBDT']""  D
 . . S FBDA=0 F  S FBDA=$O(^FB583("AES",FBO,FBDT,FBDA)) Q:'FBDA  D
 . . . S FBY=$G(^FB583(FBDA,0))
 . . . S FBEXP=$P(FBY,U,26)
 . . . S FBVET=$$VET^FBUCUTL($P(FBY,U,4))
 . . . S ^TMP("FBEX",$J,FBEXP,FBVET_";"_$P(FBY,U,4),FBDA)=""
 ;
 ; display resutls
 I $D(^TMP("FBEX",$J)) D
 . S FBPG=0,FBOUT=0 D HD
 . S FBEXP="" F  S FBEXP=$O(^TMP("FBEX",$J,FBEXP)) Q:FBEXP=""  D  Q:FBOUT
 . . S FBX="" F  S FBX=$O(^TMP("FBEX",$J,FBEXP,FBX)) Q:FBX=""  D  Q:FBOUT
 . . . S FBDA=0
 . . . F  S FBDA=$O(^TMP("FBEX",$J,FBEXP,FBX,FBDA)) Q:'FBDA  D  Q:FBOUT
 . . . . S FBY=$G(^FB583(FBDA,0))
 . . . . S DFN=$P(FBY,U,4)
 . . . . D DEM^VADPT
 . . . . I $Y+6>IOSL D HD Q:FBOUT
 . . . . W !,$E($P(FBX,";"),1,20),?22,$P(VADM(2),U,2)
 . . . . W ?36,$E($$VEN^FBUCUTL($P(FBY,U,3)),1,20)
 . . . . W ?59,$$FMTE^XLFDT(FBEXP,"2F")
 . . . . W ?69,$E($$GET1^DIQ(162.7,FBDA_",",24),1,10)
 . . . . D KVAR^VADPT
 . I 'FBOUT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S FBOUT=1 Q
 ;
 ; clean up
 K ^TMP("FBEX",$J)
 Q
 ;
HD ; header
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBOUT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF S $X=0
 S FBPG=FBPG+1
 W !,?10,"Unauthorized Claims Expiring on or before "_$$FMTE^XLFDT(FBTO)
 W !,"Veteran",?22,"SSN",?36,"Vendor",?59,"Expires",?69,"Status"
 W !,"--------------------",?22,"-----------"
 W ?36,"--------------------"
 W ?59,"--------",?69,"----------"
 Q
 ;FBUCMEA
