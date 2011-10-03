%ZOSV1 ;SFISC/AC,LL/DFH,sfisc/fyb - ;07/07/95  16:11
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DEVOPN ;X=$J,Y=List of devices separated by a comma
 N A,I,JA,JOB,DEV,CDEV,ODEV,PDEV
 S X=$J D JSTAT
 I 'ZVER S Y=$$jstat^%mjob(X),Y=$S($P(Y,"|",6)>0:$P(Y,"|",6)_",",1:"")_$P(Y,"|",9)_$E(",",$P(Y,"|",9)]"") Q
 ;S PDEV=$V(0,JA+18,-3),PDEV=$S(PDEV:$V(0,PDEV+2,-2),1:"-")
 ;S CDEV=$V(0,JA+22,-3),CDEV=$S(CDEV:$V(0,CDEV+2,-2),1:"-")
 S PDEV=$P($zjob(X),"|",5)
 S CDEV=$P($zjob(X),"|",6)
 S ODEV="",JOB=$V(0,JA+10,-4)
 ;S A=$V(1,62,-3) I A,$V(0,A+4,-2) D JDEV ; includes parents cur device
 S A=$V(1,38,-3)
 F A=A:0 Q:'$V(0,A,-2)  D:$V(0,A+4,-2)=JOB JDEV S A=A+$V(0,A,-2)
 S Y=$S(CDEV:CDEV_",",1:"")_$E(ODEV,2,999)_$E(",",$E(ODEV,2,999)]"")
 Q
JSTAT ; Get DTM data - X=Job Number
 S X=$S($D(X)[0:$J,X'?1N.N:$J,1:X)
 S ZVER=($P($ZVER,"/",2)'<4) ; ZVER=1 if Version 4
 ;S JA=$V(1,(X-1*2)+100,-2)*16
 S JA=0
 Q
JDEV ;
 S DEV=$V(0,A+2,-2) I DEV,DEV'=PDEV S ODEV=ODEV_","_DEV
 Q
 ;
FREEDEV ;
 F P=$V($S($P($ZVER,"/",2)<4:4,1:1),38,-3):0 S L=$V(0,P,-2) Q:'L  Q:'$V(0,P+4,-2)&($V(0,P+6,-1)=6)  S P=P+L
 ;
 S IO=$S(L:$V(0,P+2,-2),1:"") Q
JOBLIST ; Active Jobs delimited by comma
 S Y=$$jobs^%mjob Q
 ;
SHUTDOWN ; Check shutdown flag
 S Y=$S($P($ZVER,"/",2)<4:$V(4,0,-1)#2,1:$V(1,0,-1)#2)
 Q
