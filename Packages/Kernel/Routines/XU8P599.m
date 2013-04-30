XU8P599 ;ISD/HGW - Patch XU*8*599 Post-init ;05/17/12  08:22
 ;;8.0;KERNEL;**599**;May 17, 2012;Build 8
 Q
POST  ;
 ;Load changes into ^%Z* routines
 I '$D(^XTV(8989.3,1,"PEER")) S ^XTV(8989.3,1,"PEER")="127.0.0.1"
 X ^%ZOSF("EON")
 W ! D RELOAD^ZTMGRSET W !
 X ^%ZOSF("EOFF")
 Q
